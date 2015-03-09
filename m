Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6925470.3dTJuekQN3@uw000953>
References: <1425401999-21203-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1425401999-21203-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<6925470.3dTJuekQN3@uw000953>
Date: Mon, 9 Mar 2015 17:19:17 +0100
Message-ID: <CAMv5GbeLJNEMkLLbVy_kx9rzZXJB6Cnn0GF6yowO7tQmitzXxA@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] profiles/network: Move bnep connection setup
 logic to bnep
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,


On 9 March 2015 at 16:14, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Grzegorz,
>
> On Tuesday 03 of March 2015 17:59:48 Grzegorz Kolodziejczyk wrote:
>> BNEP connection set up logic which was added before bnep_server_add,
>> can be private method of bnep. Moved logic was almost doubled in two
>> cases: NAP role in PAN, server listening. Now set up and connect
>> scenario check of bnep connection is only handled in bnep part for
>> listen connections.
>> ---
>>  android/pan.c             |  27 ++--------
>>  profiles/network/bnep.c   | 127 ++++++++++++++++++++++++++++------------------
>>  profiles/network/bnep.h   |   6 +--
>>  profiles/network/server.c |  48 ++++++++++--------
>>  4 files changed, 112 insertions(+), 96 deletions(-)
>>
>> diff --git a/android/pan.c b/android/pan.c
>> index 61b81a4..c4ec349 100644
>> --- a/android/pan.c
>> +++ b/android/pan.c
>> @@ -463,8 +463,7 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
>>  {
>>       struct pan_device *dev = user_data;
>>       uint8_t packet[BNEP_MTU];
>> -     struct bnep_setup_conn_req *req = (void *) packet;
>> -     uint16_t src_role, dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
>> +     uint16_t rsp = BNEP_CONN_NOT_ALLOWED;
>>       int sk, n, err;
>>
>>       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
>> @@ -481,24 +480,8 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
>>               goto failed;
>>       }
>>
>> -     /* Highest known control command id BNEP_FILTER_MULT_ADDR_RSP 0x06 */
>> -     if (req->type == BNEP_CONTROL &&
>> -                                     req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
>> -             error("cmd not understood");
>> -             bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_CMD_NOT_UNDERSTOOD,
>> -                                                             req->ctrl);
>> -             goto failed;
>> -     }
>> -
>> -     if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ) {
>> -             error("cmd is not BNEP_SETUP_CONN_REQ %02X %02X", req->type,
>> -                                                             req->ctrl);
>> -             goto failed;
>> -     }
>> -
>> -     rsp = bnep_setup_decode(req, &dst_role, &src_role);
>> -     if (rsp != BNEP_SUCCESS) {
>> -             error("bnep_setup_decode failed");
>> +     if (n < 3) {
>> +             error("pan: to few setup connection request data received");
>>               goto failed;
>>       }
>>
>> @@ -509,8 +492,8 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
>>               goto failed;
>>       }
>>
>> -     if (bnep_server_add(sk, dst_role, BNEP_BRIDGE, dev->iface,
>> -                                                     &dev->dst) < 0) {
>> +     if (bnep_server_add(sk, BNEP_BRIDGE, dev->iface, &dev->dst, packet, n)
>> +                                                                     < 0) {
>>               error("pann: server_connadd failed");
>>               rsp = BNEP_CONN_NOT_ALLOWED;
>>               goto failed;
>> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
>> index 7d78575..160ad1f 100644
>> --- a/profiles/network/bnep.c
>> +++ b/profiles/network/bnep.c
>> @@ -549,63 +549,25 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
>>       return err;
>>  }
>>
>> -int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
>> -                                             const bdaddr_t *addr)
>> -{
>> -     int err;
>> -
>> -     if (!bridge || !iface || !addr)
>> -             return -EINVAL;
>> -
>> -     err = bnep_connadd(sk, dst, iface);
>> -     if (err < 0)
>> -             return err;
>> -
>> -     err = bnep_add_to_bridge(iface, bridge);
>> -     if (err < 0) {
>> -             bnep_conndel(addr);
>> -             return err;
>> -     }
>> -
>> -     return bnep_if_up(iface);
>> -}
>> -
>> -void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
>> -{
>> -     if (!bridge || !iface || !addr)
>> -             return;
>> -
>> -     bnep_del_from_bridge(iface, bridge);
>> -     bnep_if_down(iface);
>> -     bnep_conndel(addr);
>> -}
>> -
>> -ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp)
>> -{
>> -     struct bnep_control_rsp rsp;
>> -
>> -     rsp.type = type;
>> -     rsp.ctrl = ctrl;
>> -     rsp.resp = htons(resp);
>> -
>> -     return send(sk, &rsp, sizeof(rsp), 0);
>> -}
>> -
>> -uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
>> -                                                             uint16_t *src)
>> +static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
>> +                                                             uint16_t *dst)
>>  {
>>       const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
>>                                       0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
>> +     uint16_t src;
>>       uint8_t *dest, *source;
>>       uint32_t val;
>>
>> +     if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
>> +             return BNEP_CONN_NOT_ALLOWED;
>> +
>>       dest = req->service;
>>       source = req->service + req->uuid_size;
>>
>>       switch (req->uuid_size) {
>>       case 2: /* UUID16 */
>>               *dst = get_be16(dest);
>> -             *src = get_be16(source);
>> +             src = get_be16(source);
>>               break;
>>       case 16: /* UUID128 */
>>               /* Check that the bytes in the UUID, except the service ID
>> @@ -629,7 +591,7 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
>>               if (val > 0xffff)
>>                       return BNEP_CONN_INVALID_SRC;
>>
>> -             *src = val;
>> +             src = val;
>>               break;
>>       default:
>>               return BNEP_CONN_INVALID_SVC;
>> @@ -639,12 +601,13 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
>>       switch (*dst) {
>>       case BNEP_SVC_NAP:
>>       case BNEP_SVC_GN:
>> -             if (*src == BNEP_SVC_PANU)
>> +             if (src == BNEP_SVC_PANU)
>>                       return BNEP_SUCCESS;
>> +
>>               return BNEP_CONN_INVALID_SRC;
>>       case BNEP_SVC_PANU:
>> -             if (*src == BNEP_SVC_PANU || *src == BNEP_SVC_GN ||
>> -                                                     *src == BNEP_SVC_NAP)
>> +             if (src == BNEP_SVC_PANU || src == BNEP_SVC_GN ||
>> +                                                     src == BNEP_SVC_NAP)
>>                       return BNEP_SUCCESS;
>>
>>               return BNEP_CONN_INVALID_SRC;
>> @@ -652,3 +615,69 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
>>
>>       return BNEP_CONN_INVALID_DST;
>>  }
>> +
>> +int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>> +                                             uint8_t *setup_data, int len)
>> +{
>> +     int err;
>> +     uint16_t dst = NULL;
>> +     struct bnep_setup_conn_req *req = (void *) setup_data;
>> +
>> +     /* Highest known Control command ID
>> +      * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
>> +     if (req->type == BNEP_CONTROL &&
>> +                             req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
>> +             uint8_t pkt[3];
>> +
>> +             pkt[0] = BNEP_CONTROL;
>> +             pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
>> +             pkt[2] = req->ctrl;
>> +
>> +             send(sk, pkt, sizeof(pkt), 0);
>> +
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* Processing BNEP_SETUP_CONNECTION_REQUEST_MSG */
>> +     err = bnep_setup_decode(sk, req, &dst);
>> +     if (err < 0) {
>> +             error("error while decoding setup connection request: %d", err);
>
> Lets be consistent and prefix info/error appropriately.
>
OK, will update it in v3.
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (!bridge || !iface || !addr || !dst)
>> +             return -EINVAL;
>> +
>> +     err = bnep_connadd(sk, dst, iface);
>> +     if (err < 0)
>> +             return err;
>> +
>> +     err = bnep_add_to_bridge(iface, bridge);
>> +     if (err < 0) {
>> +             bnep_conndel(addr);
>> +             return err;
>> +     }
>> +
>> +     return bnep_if_up(iface);
>> +}
>> +
>> +void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
>> +{
>> +     if (!bridge || !iface || !addr)
>> +             return;
>> +
>> +     bnep_del_from_bridge(iface, bridge);
>> +     bnep_if_down(iface);
>> +     bnep_conndel(addr);
>> +}
>> +
>> +ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp)
>> +{
>> +     struct bnep_control_rsp rsp;
>> +
>> +     rsp.type = type;
>> +     rsp.ctrl = ctrl;
>> +     rsp.resp = htons(resp);
>> +
>> +     return send(sk, &rsp, sizeof(rsp), 0);
>> +}
>> diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
>> index 5aedf38..aa81dcb 100644
>> --- a/profiles/network/bnep.h
>> +++ b/profiles/network/bnep.h
>> @@ -41,10 +41,8 @@ void bnep_set_disconnect(struct bnep *session, bnep_disconnect_cb disconn_cb,
>>                                                               void *data);
>>  void bnep_disconnect(struct bnep *session);
>>
>> -int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
>> -                                                     const bdaddr_t *addr);
>> +int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>> +                                             uint8_t *setup_data, int len);
>>  void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
>>
>>  ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
>> -uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
>> -                                                             uint16_t *src);
>> diff --git a/profiles/network/server.c b/profiles/network/server.c
>> index 04f188a..30bb190 100644
>> --- a/profiles/network/server.c
>> +++ b/profiles/network/server.c
>> @@ -47,6 +47,7 @@
>>  #include "src/log.h"
>>  #include "src/error.h"
>>  #include "src/sdpd.h"
>> +#include "src/shared/util.h"
>>
>>  #include "bnep.h"
>>  #include "server.h"
>> @@ -281,11 +282,14 @@ static void setup_destroy(void *user_data)
>>  static gboolean bnep_setup(GIOChannel *chan,
>>                       GIOCondition cond, gpointer user_data)
>>  {
>> +     const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
>> +                                     0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
>>       struct network_adapter *na = user_data;
>>       struct network_server *ns;
>>       uint8_t packet[BNEP_MTU];
>>       struct bnep_setup_conn_req *req = (void *) packet;
>> -     uint16_t src_role, dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
>> +     uint16_t dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
>> +     uint32_t val;
>>       int n, sk;
>>
>>       if (cond & G_IO_NVAL)
>> @@ -305,29 +309,31 @@ static gboolean bnep_setup(GIOChannel *chan,
>>               return FALSE;
>>       }
>>
>> -     /* Highest known Control command ID
>> -      * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
>> -     if (req->type == BNEP_CONTROL &&
>> -                             req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
>> -             uint8_t pkt[3];
>> -
>> -             pkt[0] = BNEP_CONTROL;
>> -             pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
>> -             pkt[2] = req->ctrl;
>> -
>> -             send(sk, pkt, sizeof(pkt), 0);
>> -
>> +     if (n < 3) {
>> +             error("to few setup connection request data received");
>>               return FALSE;
>>       }
>>
>> -     if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
>> -             return FALSE;
>> +     switch (req->uuid_size) {
>> +     case 2:
>> +             dst_role = get_be16(req->service);
>> +             break;
>> +     case 16:
>> +             if (memcmp(&req->service[4], bt_base, sizeof(bt_base)) != 0)
>> +                     return FALSE;
>>
>> -     rsp = bnep_setup_decode(req, &dst_role, &src_role);
>> -     if (rsp != BNEP_SUCCESS)
>> -             goto reply;
>> +             /* Intentional no-brake */
>>
>> -     rsp = BNEP_CONN_NOT_ALLOWED;
>> +     case 4:
>> +             val = get_be32(req->service);
>> +             if (val > 0xffff)
>> +                     return FALSE;
>> +
>> +             dst_role = val;
>> +             break;
>> +     default:
>> +             return FALSE;
>> +     }
>>
>>       ns = find_server(na->servers, dst_role);
>>       if (!ns) {
>> @@ -348,8 +354,8 @@ static gboolean bnep_setup(GIOChannel *chan,
>>       strncpy(na->setup->dev, BNEP_INTERFACE, 16);
>>       na->setup->dev[15] = '\0';
>>
>> -     if (bnep_server_add(sk, dst_role, ns->bridge, na->setup->dev,
>> -                                                     &na->setup->dst) < 0)
>> +     if (bnep_server_add(sk, ns->bridge, na->setup->dev,
>> +                                             &na->setup->dst, packet, n) < 0)
>>               goto reply;
>>
>>       na->setup = NULL;
>>
>
> --
> Best regards,
> Szymon Janc

BR,
Grzegorz Kołodziejczyk

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1568775.YUNollJELb@uw000953>
References: <1425401999-21203-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1425401999-21203-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1568775.YUNollJELb@uw000953>
Date: Mon, 9 Mar 2015 17:18:17 +0100
Message-ID: <CAMv5Gbdbp63f0a-B5Fi0fEg3pwRzR1p_fKxgU+b5XVukxb7gVg@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] profiles/network: Handle ctrl rsp after conn
 setup by bnep
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
> On Tuesday 03 of March 2015 17:59:49 Grzegorz Kolodziejczyk wrote:
>> This patch moves setup control response to bnep and makes it private.
>> ---
>>  android/pan.c             | 14 +++--------
>>  profiles/network/bnep.c   | 61 +++++++++++++++++++++++++++++------------------
>>  profiles/network/bnep.h   |  2 --
>>  profiles/network/server.c | 36 +++++++++-------------------
>>  4 files changed, 52 insertions(+), 61 deletions(-)
>>
>> diff --git a/android/pan.c b/android/pan.c
>> index c4ec349..72d8a73 100644
>> --- a/android/pan.c
>> +++ b/android/pan.c
>> @@ -463,7 +463,6 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
>>  {
>>       struct pan_device *dev = user_data;
>>       uint8_t packet[BNEP_MTU];
>> -     uint16_t rsp = BNEP_CONN_NOT_ALLOWED;
>>       int sk, n, err;
>>
>>       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
>> @@ -486,22 +485,16 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
>>       }
>>
>>       err = nap_create_bridge();
>> -     if (err < 0) {
>> +     if (err < 0)
>>               error("pan: Failed to create bridge: %s (%d)", strerror(-err),
>>                                                                       -err);
>> -             goto failed;
>> -     }
>>
>> -     if (bnep_server_add(sk, BNEP_BRIDGE, dev->iface, &dev->dst, packet, n)
>> -                                                                     < 0) {
>> +     if (bnep_server_add(sk, (err < 0) ? NULL : BNEP_BRIDGE, dev->iface,
>> +                                             &dev->dst, packet, n) < 0) {
>>               error("pann: server_connadd failed");
>> -             rsp = BNEP_CONN_NOT_ALLOWED;
>>               goto failed;
>>       }
>>
>> -     rsp = BNEP_SUCCESS;
>> -     bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
>> -
>>       dev->watch = g_io_add_watch(chan, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
>>                                                       nap_watchdog_cb, dev);
>>       g_io_channel_unref(dev->io);
>> @@ -513,7 +506,6 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
>>       return FALSE;
>>
>>  failed:
>> -     bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
>>       pan_device_remove(dev);
>>
>>       return FALSE;
>> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
>> index 160ad1f..e8f9698 100644
>> --- a/profiles/network/bnep.c
>> +++ b/profiles/network/bnep.c
>> @@ -549,6 +549,18 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
>>       return err;
>>  }
>>
>> +static ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl,
>> +                                                             uint16_t resp)
>> +{
>> +     struct bnep_control_rsp rsp;
>> +
>> +     rsp.type = type;
>> +     rsp.ctrl = ctrl;
>> +     rsp.resp = htons(resp);
>> +
>> +     return send(sk, &rsp, sizeof(rsp), 0);
>> +}
>> +
>>  static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
>>                                                               uint16_t *dst)
>>  {
>> @@ -603,7 +615,6 @@ static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
>>       case BNEP_SVC_GN:
>>               if (src == BNEP_SVC_PANU)
>>                       return BNEP_SUCCESS;
>> -
>>               return BNEP_CONN_INVALID_SRC;
>>       case BNEP_SVC_PANU:
>>               if (src == BNEP_SVC_PANU || src == BNEP_SVC_GN ||
>> @@ -620,7 +631,7 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>>                                               uint8_t *setup_data, int len)
>>  {
>>       int err;
>> -     uint16_t dst = NULL;
>> +     uint16_t rsp, dst = NULL;
>>       struct bnep_setup_conn_req *req = (void *) setup_data;
>>
>>       /* Highest known Control command ID
>> @@ -639,26 +650,41 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>>       }
>>
>>       /* Processing BNEP_SETUP_CONNECTION_REQUEST_MSG */
>> -     err = bnep_setup_decode(sk, req, &dst);
>> -     if (err < 0) {
>> -             error("error while decoding setup connection request: %d", err);
>> -             return -EINVAL;
>> +     rsp = bnep_setup_decode(sk, req, &dst);
>> +     if (rsp != BNEP_SUCCESS || !dst) {
>> +             err = -rsp;
>> +             error("bnep: error while decoding setup connection request: %d",
>> +                                                                     rsp);
>> +             goto reply;
>>       }
>>
>> -     if (!bridge || !iface || !addr || !dst)
>> -             return -EINVAL;
>> +     if (!dst) {
>> +             error("bnep: cannot decode proper destination service UUID");
>> +             rsp = BNEP_CONN_INVALID_DST;
>> +             goto reply;
>> +     }
>>
>>       err = bnep_connadd(sk, dst, iface);
>> -     if (err < 0)
>> -             return err;
>> +     if (err < 0) {
>> +             rsp = BNEP_CONN_NOT_ALLOWED;
>> +             goto reply;
>> +     }
>>
>>       err = bnep_add_to_bridge(iface, bridge);
>>       if (err < 0) {
>>               bnep_conndel(addr);
>> -             return err;
>> +             rsp = BNEP_CONN_NOT_ALLOWED;
>> +             goto reply;
>>       }
>>
>> -     return bnep_if_up(iface);
>> +     err = bnep_if_up(iface);
>> +     if (err < 0)
>> +             rsp = BNEP_CONN_NOT_ALLOWED;
>> +
>> +reply:
>> +     bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
>> +
>> +     return err;
>>  }
>>
>>  void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
>> @@ -670,14 +696,3 @@ void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
>>       bnep_if_down(iface);
>>       bnep_conndel(addr);
>>  }
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
>> diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
>> index aa81dcb..4fe79ed 100644
>> --- a/profiles/network/bnep.h
>> +++ b/profiles/network/bnep.h
>> @@ -44,5 +44,3 @@ void bnep_disconnect(struct bnep *session);
>>  int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>>                                               uint8_t *setup_data, int len);
>>  void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
>> -
>> -ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
>> diff --git a/profiles/network/server.c b/profiles/network/server.c
>> index 30bb190..5d2fbcc 100644
>> --- a/profiles/network/server.c
>> +++ b/profiles/network/server.c
>> @@ -288,9 +288,10 @@ static gboolean bnep_setup(GIOChannel *chan,
>>       struct network_server *ns;
>>       uint8_t packet[BNEP_MTU];
>>       struct bnep_setup_conn_req *req = (void *) packet;
>> -     uint16_t dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
>> +     uint16_t dst_role = 0;
>>       uint32_t val;
>>       int n, sk;
>> +     char *bridge = NULL;
>>
>>       if (cond & G_IO_NVAL)
>>               return FALSE;
>> @@ -320,51 +321,36 @@ static gboolean bnep_setup(GIOChannel *chan,
>>               break;
>>       case 16:
>>               if (memcmp(&req->service[4], bt_base, sizeof(bt_base)) != 0)
>> -                     return FALSE;
>> +                     break;
>>
>>               /* Intentional no-brake */
>>
>>       case 4:
>>               val = get_be32(req->service);
>>               if (val > 0xffff)
>> -                     return FALSE;
>> +                     break;
>>
>>               dst_role = val;
>>               break;
>>       default:
>> -             return FALSE;
>> +             break;
>>       }
>>
>>       ns = find_server(na->servers, dst_role);
>> -     if (!ns) {
>> -             error("Server unavailable: (0x%x)", dst_role);
>> -             goto reply;
>> -     }
>> -
>> -     if (!ns->record_id) {
>> -             error("Service record not available");
>> -             goto reply;
>> -     }
>> +     if (!ns || !ns->record_id || !ns->bridge)
>> +             error("Server error, bridge not initialized: (0x%x)", dst_role);
>
> Lets be consistent and prefix info/error appropriately.
This file don't have any consistent prefixes, so that's why I've
decided to not do it here also.

>>
>> -     if (!ns->bridge) {
>> -             error("Bridge interface not configured");
>> -             goto reply;
>> -     }
>> +     bridge = ns->bridge;
>
> This would dereference possibly null ns.
>
Right, I'll fix it in v3.

>>
>>       strncpy(na->setup->dev, BNEP_INTERFACE, 16);
>>       na->setup->dev[15] = '\0';
>>
>> -     if (bnep_server_add(sk, ns->bridge, na->setup->dev,
>> -                                             &na->setup->dst, packet, n) < 0)
>> -             goto reply;
>> +     if (bnep_server_add(sk, bridge, na->setup->dev, &na->setup->dst,
>> +                                                     packet, n) < 0)
>> +             error("BNEP server cannot be added");
>>
>>       na->setup = NULL;
>>
>> -     rsp = BNEP_SUCCESS;
>> -
>> -reply:
>> -     bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
>> -
>>       return FALSE;
>>  }
>>
>>
>
> --
> Best regards,
> Szymon Janc

BR,
Grzegorz Kołodziejczyk

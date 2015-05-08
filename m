Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4544955.5Mj2SbYDcF@leonov>
References: <1428930887-25519-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1428930887-25519-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<4544955.5Mj2SbYDcF@leonov>
Date: Fri, 8 May 2015 15:33:25 +0200
Message-ID: <CAMv5Gbd=WJzgxVg7hV7qegd+oZiohz9X--FucwTqJ85zX+rnKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] profiles/network: Add support for handling
 extension hdr in ctrl msg
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 8 May 2015 at 15:27, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Grzegorz,
>
> On Monday 13 of April 2015 15:14:46 Grzegorz Kolodziejczyk wrote:
>> Support for extension headers is mandatory functionality. This patch
>> add support to it and leave responsibility for processing extension
>> header and sending setup success response to kernel.
>>
>> This patch is necessary to pass PTS bnep test TC_CTRL_BV_19_C.
>> ---
>>  android/pan.c             |  2 +-
>>  profiles/network/bnep.c   | 83
>> +++++++++++++++++++++++++++++++++++++++++++---- profiles/network/server.c |
>>  2 +-
>>  tools/bneptest.c          |  2 +-
>>  4 files changed, 80 insertions(+), 9 deletions(-)
>>
>> diff --git a/android/pan.c b/android/pan.c
>> index 6c9815b..b98fccd 100644
>> --- a/android/pan.c
>> +++ b/android/pan.c
>> @@ -472,7 +472,7 @@ static gboolean nap_setup_cb(GIOChannel *chan,
>> GIOCondition cond, sk = g_io_channel_unix_get_fd(chan);
>>
>>       /* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
>> -     n = read(sk, packet, sizeof(packet));
>> +     n = recv(sk, packet, sizeof(packet), MSG_PEEK);
>
> Add a comment here why PEEK is needed.
>
Ok, this is good idea.
>>       if (n  < 0) {
>>               error("read(): %s(%d)", strerror(errno), errno);
>>               goto failed;
>> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
>> index e325b72..a878d14 100644
>> --- a/profiles/network/bnep.c
>> +++ b/profiles/network/bnep.c
>> @@ -124,6 +124,7 @@ static int bnep_connadd(int sk, uint16_t role, char
>> *dev)
>>
>>       req.sock = sk;
>>       req.role = role;
>> +     req.flags = (1 << BNEP_SETUP_RESPONSE);
>>       if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
>>               int err = -errno;
>>               error("bnep: Failed to add device %s: %s(%d)",
>> @@ -135,6 +136,18 @@ static int bnep_connadd(int sk, uint16_t role, char
>> *dev) return 0;
>>  }
>>
>> +static uint32_t bnep_getsuppfeat(void)
>> +{
>> +     uint32_t feat;
>> +
>> +     if (ioctl(ctl, BNEPGETSUPPFEAT, &feat) < 0)
>> +             feat = 0;
>> +
>> +     DBG("supported features: 0x%x", feat);
>> +
>> +     return feat;
>> +}
>> +
>>  static int bnep_if_up(const char *devname)
>>  {
>>       struct ifreq ifr;
>> @@ -530,7 +543,9 @@ static uint16_t bnep_setup_decode(int sk, struct
>> bnep_setup_conn_req *req, uint8_t *dest, *source;
>>       uint32_t val;
>>
>> -     if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
>> +     if (((req->type != BNEP_CONTROL) &&
>> +             (req->type != (BNEP_CONTROL | BNEP_EXT_HEADER)))  ||
>> +                                     req->ctrl != BNEP_SETUP_CONN_REQ)
>>               return BNEP_CONN_NOT_ALLOWED;
>>
>>       dest = req->service;
>> @@ -587,10 +602,52 @@ static uint16_t bnep_setup_decode(int sk, struct
>> bnep_setup_conn_req *req, return BNEP_CONN_INVALID_DST;
>>  }
>>
>> +static int bnep_server_add_legacy(int sk, uint16_t dst, char *bridge,
>> +                                     char *iface, const bdaddr_t *addr,
>> +                                     uint8_t *setup_data, int len)
>> +{
>> +     int err, n;
>> +     uint16_t rsp;
>> +
>> +     n = read(sk, setup_data, len);
>> +     if (n != len) {
>> +             err = -1;
>> +             rsp = BNEP_CONN_NOT_ALLOWED;
>> +             goto reply;
>> +     }
>> +
>> +     err = bnep_connadd(sk, dst, iface);
>> +     if (err < 0) {
>> +             rsp = BNEP_CONN_NOT_ALLOWED;
>> +             goto reply;
>> +     }
>> +
>> +     err = bnep_add_to_bridge(iface, bridge);
>> +     if (err < 0) {
>> +             bnep_conndel(addr);
>> +             rsp = BNEP_CONN_NOT_ALLOWED;
>> +             goto reply;
>> +     }
>> +
>> +     err = bnep_if_up(iface);
>> +     if (err < 0)
>> +             rsp = BNEP_CONN_NOT_ALLOWED;
>> +
>> +reply:
>> +     if (bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp) < 0) {
>> +             err = -errno;
>> +             error("bnep: send ctrl rsp error: %s (%d)", strerror(-err),
>> +                                                                     -err);
>> +     }
>> +
>> +     return err;
>> +}
>> +
>>  int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t
>> *addr, uint8_t *setup_data, int len)
>>  {
>>       int err;
>> +     uint32_t feat;
>>       uint16_t rsp, dst;
>>       struct bnep_setup_conn_req *req = (void *) setup_data;
>>
>> @@ -617,6 +674,17 @@ int bnep_server_add(int sk, char *bridge, char *iface,
>> const bdaddr_t *addr, goto reply;
>>       }
>>
>> +     feat = bnep_getsuppfeat();
>> +
>> +     /*
>> +      * Take out setup data if kernel doesn't support handling it, especially
>> +      * setup request. If kernel would have set session flags, they should
>> +      * be checked and handled respectively.
>> +      */
>> +     if (!feat || !(feat & (1 << BNEP_SETUP_RESPONSE)))
>> +             return bnep_server_add_legacy(sk, dst, bridge, iface, addr,
>> +                                                     setup_data, len);
>> +
>>       err = bnep_connadd(sk, dst, iface);
>>       if (err < 0) {
>>               rsp = BNEP_CONN_NOT_ALLOWED;
>> @@ -626,19 +694,22 @@ int bnep_server_add(int sk, char *bridge, char *iface,
>> const bdaddr_t *addr, err = bnep_add_to_bridge(iface, bridge);
>>       if (err < 0) {
>>               bnep_conndel(addr);
>> -             rsp = BNEP_CONN_NOT_ALLOWED;
>> -             goto reply;
>> +             return err;
>>       }
>>
>>       err = bnep_if_up(iface);
>>       if (err < 0)
>> -             rsp = BNEP_CONN_NOT_ALLOWED;
>> +             return err;
>
> Cleanupis  missing.
>
>
Yes, I'll add it in next set.
>> +
>> +     /* Kernel will handle success setup response */
>> +     if (feat & (1 << BNEP_SETUP_RESPONSE))
>> +             return err;
>
> This path is executed only with BNEP_SETUP_RESPONSE set so check is not
> needed.
>
> I'd also add specific fail paths that would handle cleanup bridge setup, del
> conn etc if something failed. (same should be done for legacy path)
>
Right.
>>
>>  reply:
>>       if (bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp) < 0) {
>>               err = -errno;
>> -             error("bnep: send ctrl rsp error: %s (%d)", strerror(errno),
>> -                                                                     errno);
>> +             error("bnep: send ctrl rsp error: %s (%d)", strerror(-err),
>> +                                                                     -err);
>>       }
>>
>>       return err;
>> diff --git a/profiles/network/server.c b/profiles/network/server.c
>> index 32aafc3..ec37c97 100644
>> --- a/profiles/network/server.c
>> +++ b/profiles/network/server.c
>> @@ -328,7 +328,7 @@ static gboolean bnep_setup(GIOChannel *chan,
>>       sk = g_io_channel_unix_get_fd(chan);
>>
>>       /* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
>> -     n = read(sk, packet, sizeof(packet));
>> +     n = recv(sk, packet, sizeof(packet), MSG_PEEK);
>
> Add a comment here why PEEK is needed.
>
ok.
>>       if (n < 0) {
>>               error("read(): %s(%d)", strerror(errno), errno);
>>               return FALSE;
>> diff --git a/tools/bneptest.c b/tools/bneptest.c
>> index 98ee9b1..a7d5815 100644
>> --- a/tools/bneptest.c
>> +++ b/tools/bneptest.c
>> @@ -327,7 +327,7 @@ static gboolean setup_bnep_cb(GIOChannel *chan,
>> GIOCondition cond, sk = g_io_channel_unix_get_fd(chan);
>>
>>       /* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
>> -     n = read(sk, packet, sizeof(packet));
>> +     n = recv(sk, packet, sizeof(packet), MSG_PEEK);
>>       if (n < 0) {
>>               error("read(): %s(%d)", strerror(errno), errno);
>>               return FALSE;
>
> --
> BR
> Szymon Janc

BR,
Grzegorz Kolodziejczyk

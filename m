Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikqYE7iL0w7DW9xaeUrRVg7yVeO1w@mail.gmail.com>
References: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
 <1308445186-27135-4-git-send-email-adamek.kuba@gmail.com> <BANLkTikqYE7iL0w7DW9xaeUrRVg7yVeO1w@mail.gmail.com>
From: Jakub Adamek <adamek.kuba@gmail.com>
Date: Mon, 20 Jun 2011 19:15:26 +0200
Message-ID: <BANLkTin8TREM7XD_ayDt9qf_qOgZ+27MQw@mail.gmail.com>
Subject: Re: [PATCH obexd 03/10] Store received headers in gw_obex_xfer object
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
2011/6/20 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Jakub,
>
> On Sun, Jun 19, 2011 at 3:59 AM, Jakub Adamek <adamek.kuba@gmail.com> wrote:
>> ---
>>  gwobex/obex-priv.c |   22 ++++++++++++++++++++++
>>  1 files changed, 22 insertions(+), 0 deletions(-)
>>
>> diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
>> index aba7dd7..b9216e5 100644
>> --- a/gwobex/obex-priv.c
>> +++ b/gwobex/obex-priv.c
>> @@ -39,6 +39,7 @@
>>  #include <sys/socket.h>
>>
>>  #include <openobex/obex.h>
>> +#include <openobex/obex_const.h>
>>
>>  #ifdef HAVE_CONFIG_H
>>  # include "config.h"
>> @@ -335,6 +336,7 @@ static void get_non_body_headers(obex_t *handle, obex_object_t *object,
>>     obex_headerdata_t hv;
>>     uint8_t hi;
>>     unsigned int hlen;
>> +    struct a_header *ah;
>>
>>     xfer->target_size = GW_OBEX_UNKNOWN_LENGTH;
>>     xfer->modtime = -1;
>> @@ -358,6 +360,26 @@ static void get_non_body_headers(obex_t *handle, obex_object_t *object,
>>                     xfer->apparam_size = 0;
>>                 break;
>>             default:
>> +                ah = g_new0(struct a_header, 1);
>> +                ah->hi = hi;
>> +                ah->hv_size = hlen;
>> +                switch (hi & OBEX_HDR_TYPE_MASK) {
>> +                    case OBEX_HDR_TYPE_UINT8:
>> +                    case OBEX_HDR_TYPE_UINT32:
>> +                        ah->hv = hv;
>> +                        break;
>> +                    case OBEX_HDR_TYPE_BYTES:
>> +                    case OBEX_HDR_TYPE_UNICODE:
>> +                        ah->hv.bs = g_try_malloc(hlen);
>> +                        if (ah->hv.bs) {
>> +                            memcpy((void *) ah->hv.bs, hv.bs, hlen);
>> +                            ah->hv_size = hlen;
>> +                        } else {
>> +                            ah->hv_size = hlen;
>> +                        }
>
> No need to add braces for single line statements.
Will fix. In any case this is badly done, since I think I should test
if g_try_malloc returned NULL because of hlen=0 or because of failure.

>
>> +                        break;
>> +                }
>> +                xfer->aheaders = g_slist_append(xfer->aheaders, ah);
>
> I would suggest having this code separated in another function e.g.
> get_aheader, it is easier to identify what the code is doing and
> switch inside a switch is not very nice to read/understand IMO.
Ok.
>
> --
> Luiz Augusto von Dentz
>

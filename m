Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL75FwxCZeNjXOX=p1Ev7NwEL7rMJP8XNY2edU3aMAF4g@mail.gmail.com>
References: <1326451712-21784-1-git-send-email-lkslawek@gmail.com>
	<1326451712-21784-3-git-send-email-lkslawek@gmail.com>
	<CABBYNZL75FwxCZeNjXOX=p1Ev7NwEL7rMJP8XNY2edU3aMAF4g@mail.gmail.com>
Date: Fri, 13 Jan 2012 13:40:59 +0100
Message-ID: <CA+i+Aw33=yu0arA3apL_omxVKywA-1GsN_=PvbfqP6XL+GjE7g@mail.gmail.com>
Subject: Re: [PATCH obexd 3/4] map_ap.c: Add implementation for map_ap_decode()
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 13, 2012 at 1:09 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Slawomir,
>
> On Fri, Jan 13, 2012 at 12:48 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>> +               switch (ap_defs[tago].type) {
>> +               case APT_UINT8:
>> +                       if (hdr->len != 1) {
>> +                               DBG("Value of tag %s (%d) is %d bytes long "
>> +                                               "instead of expected 1 byte - "
>> +                                               "skipped!", ap_defs[tago].name,
>> +                                               hdr->tag, hdr->len);
>> +                               break;
>> +                       }
>> +
>> +                       map_ap_set_u8(ap, hdr->tag, hdr->val[0]);
>> +
>> +                       break;
>> +               case APT_UINT16:
>> +                       if (hdr->len != 2) {
>> +                               DBG("Value of tag %s (%d) is %d bytes long "
>> +                                               "instead of expected 2 bytes - "
>> +                                               "skipped!", ap_defs[tago].name,
>> +                                               hdr->tag, hdr->len);
>> +                               break;
>> +                       }
>> +
>> +                       memcpy(&val16, hdr->val, sizeof(val16));
>> +                       map_ap_set_u16(ap, hdr->tag, GUINT16_FROM_BE(val16));
>> +
>> +                       break;
>> +               case APT_UINT32:
>> +                       if (hdr->len != 4) {
>> +                               DBG("Value of tag %s (%d) is %d bytes long "
>> +                                               "instead of expected 4 bytes - "
>> +                                               "skipped!", ap_defs[tago].name,
>> +                                               hdr->tag, hdr->len);
>> +                               break;
>> +                       }
>> +
>> +                       memcpy(&val32, hdr->val, sizeof(val32));
>> +                       map_ap_set_u32(ap, hdr->tag, GUINT32_FROM_BE(val32));
>> +
>> +                       break;
>> +               case APT_STR:
>> +                       valstr = g_malloc0(hdr->len + 1);
>> +                       memcpy(valstr, hdr->val, hdr->len);
>> +                       map_ap_set_string(ap, hdr->tag, valstr);
>> +                       g_free(valstr);
>> +
>> +                       break;
>> +               }
>
> Perhaps this parts can be integrated directly in their respective
> map_ap_set_* functions or if you are planing to reuse them not only
> for decoding then you can use dedicated decoder function e.g.
> map_ap_decode_u8.

Looking at the map_ap.h one can use find out that map_ap_set_*
functions are going to be used for other purposes (those are even
documented there). Additional decoding function could be added if you
think that this will really increase readability.

>
> --
> Luiz Augusto von Dentz



-- 
Slawomir Bochenski

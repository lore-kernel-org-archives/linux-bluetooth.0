Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357672384.1806.34.camel@aeonflux>
References: <1357670608-19081-1-git-send-email-anderson.lizardo@openbossa.org>
	<1357670608-19081-2-git-send-email-anderson.lizardo@openbossa.org>
	<1357672384.1806.34.camel@aeonflux>
Date: Tue, 8 Jan 2013 16:27:11 -0400
Message-ID: <CAJdJm_PV7qMJWQLJBOmA0tqqDzor6immypKGgGTtLVy9SR5A8A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] lib: Fix SDP_TEXT_STR16/SDP_URL_STR16 parsing
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jan 8, 2013 at 3:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> diff --git a/lib/sdp.c b/lib/sdp.c
>> index ca474cd..b87f392 100644
>> --- a/lib/sdp.c
>> +++ b/lib/sdp.c
>> @@ -1176,7 +1176,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
>>               }
>>               n = bt_get_be16(p);
>>               p += sizeof(uint16_t);
>> -             *len += sizeof(uint16_t) + n;
>> +             *len += sizeof(uint16_t);
>
> I do not get this fix. Isn't this str8 and url8 part wrong?

On the same function, next to the return, there is:

*len += n;

This is why STR8/URL8 actually are okay. For STR16 the "n" part is
added twice due to the snippet I change in this patch.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150220105525.GA25329@t440s.lan>
References: <1424428710-8907-1-git-send-email-luiz.dentz@gmail.com>
	<1424428710-8907-3-git-send-email-luiz.dentz@gmail.com>
	<20150220105525.GA25329@t440s.lan>
Date: Fri, 20 Feb 2015 13:47:49 +0200
Message-ID: <CABBYNZLJ6Z3mM7OqxnENLF9dsbtoWnicUnxF511B6Z6UGAr3qQ@mail.gmail.com>
Subject: Re: [RFC BlueZ 3/3] tools/btgatt-client: Add signed write support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Feb 20, 2015 at 12:55 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, Feb 20, 2015, Luiz Augusto von Dentz wrote:
>> +static bool convert_csrk_key(char *optarg, uint8_t csrk[16])
>> +{
>> +     int i;
>> +     char value[2];
>> +
>> +     if (strlen(optarg) != 32) {
>> +             printf("csrk length is invalid\n");
>> +             return false;
>> +     }
>> +
>> +     for (i = 0; i < 16; i++) {
>> +             strncpy(value, optarg + (i * 2), 2);
>> +             csrk[i] = strtol(value, NULL, 16);
>
> It doesn't look like you've got enough space in 'value' for this. You'd
> need 2 + 1 to have it nul-terminater. However, I think you can
> completely get away with the need of this temporary variable by using
> sscanf(), i.e. something like:
>
>         sscanf(optarg + (i * 2), "%2hhx", &csrk[i]);

Yep, this sounds much much better.


-- 
Luiz Augusto von Dentz

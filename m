Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150126202728.GA31780@t440s.P-661HNU-F1>
References: <1422287118-25319-1-git-send-email-luiz.dentz@gmail.com>
	<1422287118-25319-2-git-send-email-luiz.dentz@gmail.com>
	<20150126202728.GA31780@t440s.P-661HNU-F1>
Date: Mon, 26 Jan 2015 23:42:30 +0200
Message-ID: <CABBYNZ+keWMS0QjZy9V+-LBVWVvdDxjEHL5CCRK=93BYmtcaiA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] unit/gatt: Add TP/GAR/CL/BV-04-C/64K test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Jan 26, 2015 at 10:27 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Mon, Jan 26, 2015, Luiz Augusto von Dentz wrote:
>> +#define DATA_10B  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
>> +
>> +#define DATA_100B DATA_10B, DATA_10B, DATA_10B, DATA_10B, DATA_10B, \
>> +                     DATA_10B, DATA_10B, DATA_10B, DATA_10B, DATA_10B
>> +
>> +#define DATA_511B DATA_100B, DATA_100B, DATA_100B, DATA_100B, DATA_100B, \
>> +                     DATA_10B, 0xff
>> +
>> +#define DATA_512B DATA_511B, 0xff
>> +
>> +#define DATA_4KB DATA_512B, DATA_512B, DATA_512B, DATA_512B, DATA_512B, \
>> +             DATA_512B, DATA_512B, DATA_512B
>> +
>> +#define DATA_16KB DATA_4KB, DATA_4KB, DATA_4KB, DATA_4KB
>> +
>> +#define DATA_64KB DATA_16KB, DATA_16KB, DATA_16KB, DATA_16KB
>> +
>> +/* 64KB + 383B */
>> +static const uint8_t long_data_2[] = { DATA_64KB, DATA_100B, DATA_100B,
>> +                                     DATA_100B, DATA_10B, DATA_10B, DATA_10B,
>> +                                     DATA_10B, DATA_10B, DATA_10B, DATA_10B,
>> +                                     DATA_10B, 0xff, 0xff, 0xff };
>
> Instead of all these complex defines wouldn't it be easier to just:
>
> static const uint8_t long_data_2[0xffff + 383];
>
> The only difference is that you'd have zeros instead of 0xff bytes as
> content.

Indeed it is much simpler, the content is not really important in the
end, in the other hand it looks like the length limit for a value is
512 bytes not 64 K so I there is a couple more changes needed.


-- 
Luiz Augusto von Dentz

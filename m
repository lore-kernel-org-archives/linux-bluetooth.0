Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <755599B7-D32C-424C-B2B8-E0E8539C31EE@holtmann.org>
References: <1390952835-23251-1-git-send-email-szymon.janc@tieto.com>
	<46CB790A-A0DF-47A4-ACD1-DD7C0F0A9D2D@holtmann.org>
	<CAJdJm_MEjCN4ooe4OSym4CLN1JLS4FrnO-n5_ZVQzrVuuZ3Sfw@mail.gmail.com>
	<755599B7-D32C-424C-B2B8-E0E8539C31EE@holtmann.org>
Date: Wed, 29 Jan 2014 12:12:08 -0400
Message-ID: <CAJdJm_Pxex7RpLh_NjtBA_5P69cfE83bUdbD31euAWaU5kCsCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/bluetooth: Add threashold to RSSI change
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jan 28, 2014 at 9:02 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> And why not:
>>
>> int delta = abs(old - new);
>>
>> (unless there is no abs() in bionic)
>
> I remember that abs() needs -lm or something stupid.

>From my tests, it does not require any extra libraries other than
libc6 (at least in recent versions). It seems that at least for x86 it
is even optimized to a few machine instructions (as I could not find
the library call when using objdump on code that does
"abs(atoi(argv[1]))").

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil

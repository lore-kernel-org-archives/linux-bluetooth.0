Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <46CB790A-A0DF-47A4-ACD1-DD7C0F0A9D2D@holtmann.org>
References: <1390952835-23251-1-git-send-email-szymon.janc@tieto.com>
	<46CB790A-A0DF-47A4-ACD1-DD7C0F0A9D2D@holtmann.org>
Date: Tue, 28 Jan 2014 20:17:54 -0400
Message-ID: <CAJdJm_MEjCN4ooe4OSym4CLN1JLS4FrnO-n5_ZVQzrVuuZ3Sfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/bluetooth: Add threashold to RSSI change
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 28, 2014 at 8:09 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> +{
>> +     int delta;
>> +
>> +     if (old > new)
>> +             delta = old - new;
>> +     else
>> +             delta = new - old;
>> +
>> +     /* only 8 dBm or more */
>> +     return delta >= 8;
>
>         int delta = old > new ? old - new : new - old;

And why not:

int delta = abs(old - new);

(unless there is no abs() in bionic)

BTW, I believe this is called "hysteresis" (at least a very simple
kind). But threshold looks just fine :)

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil

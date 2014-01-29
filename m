Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/2] android/bluetooth: Add threashold to RSSI change
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_MEjCN4ooe4OSym4CLN1JLS4FrnO-n5_ZVQzrVuuZ3Sfw@mail.gmail.com>
Date: Tue, 28 Jan 2014 17:02:50 -0800
Cc: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <755599B7-D32C-424C-B2B8-E0E8539C31EE@holtmann.org>
References: <1390952835-23251-1-git-send-email-szymon.janc@tieto.com> <46CB790A-A0DF-47A4-ACD1-DD7C0F0A9D2D@holtmann.org> <CAJdJm_MEjCN4ooe4OSym4CLN1JLS4FrnO-n5_ZVQzrVuuZ3Sfw@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>>> +{
>>> +     int delta;
>>> +
>>> +     if (old > new)
>>> +             delta = old - new;
>>> +     else
>>> +             delta = new - old;
>>> +
>>> +     /* only 8 dBm or more */
>>> +     return delta >= 8;
>> 
>>        int delta = old > new ? old - new : new - old;
> 
> And why not:
> 
> int delta = abs(old - new);
> 
> (unless there is no abs() in bionic)

I remember that abs() needs -lm or something stupid.

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: Advertising API, possible to set LE only?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150716131004.GA28916@t440s.P-661HNU-F1>
Date: Thu, 16 Jul 2015 22:39:25 +0200
Cc: dogan yazar <doganyazar@gmail.com>, linux-bluetooth@vger.kernel.org
Message-Id: <C1E229B1-274F-4B5B-81EA-A546488B07DD@holtmann.org>
References: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com> <20150716105937.GA18341@t440s.lan> <CANzaTi5gK457ZJP5V_ty6ufSzm2LmX6wsfVracqR0MwDZS6jyg@mail.gmail.com> <20150716131004.GA28916@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> Thanks a lot for the answer. That is exactly what I need.  However
>> putting in the main.conf did not really make any reference and trying
>> the btmgmt returns "Rejected"
>> [mgmt]# bredr off
>> Set BR/EDR for hci0 failed with status 0x0b (Rejected)
>> 
>> Any idea why? Is it controller related?
> 
> First of all, please don't top-post on this list. I think you need to
> power off the adapter before you can disable BR/EDR, i.e. "btmgmt power
> off".

actually you need to power off the controller, enable LE and only then you can turn off BR/EDR. Of course you require a dual-mode BR/EDR + LE controller in the first place to do this.

Regards

Marcel


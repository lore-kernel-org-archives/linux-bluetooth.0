Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Adding Broadcom Support for BCM 20702AO of Fuijitsu Lifebook E751 with .driver_info = BTUSB_BCM_PATCHRAM },
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <547D817A.7010708@gmx.de>
Date: Tue, 2 Dec 2014 09:14:58 +0000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3A403AB8-AE17-45E8-BABE-D41F8087AE18@holtmann.org>
References: <547C2F76.80000@gmx.de> <CA52376B-12C5-4A2E-9922-616A722D1D54@holtmann.org> <547C4D47.6010606@gmx.de> <1FB03768-38C7-4FDA-980A-C63BA5EE2DC2@holtmann.org> <547D817A.7010708@gmx.de>
To: harv@gmx.de
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harvey,

>>> I extracted the firmware file from the windows driver and
>>> converted it via hex2hcd. Is this an acceptable way to go?
>> 
>> we merged an earlier patch adding instructions on how to get the
>> firmware. Have a look at that for reference.
> 
> I could not find the mentioned patch but this is not really
> astonishing as I am not an experienced developer but only an ambitious
> user.
> 
> But: I am willing to do the work if you provide me some more
> information. At least it is never too late to learn something new ;)
> 
> Can you point me in the right direction?

check the commit a86c02ea38c53b695209b1181f9e2e18d73eb4e8 in bluetooth-next tree.

Regards

Marcel


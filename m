Return-Path: <cyrus@holtmann.org>
Message-ID: <442C56D12F0C4CE0B6625FF181846FED@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Shivendra Agrawal" <ag.shivendra@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
References: <201010191147.34241.sander@outrightsolutions.nl><AANLkTikgKM1MNpwP2JL1GdERZ60dE6dkFNC=rdyQDhOV@mail.gmail.com> <AANLkTim9ypGcMEJ4+HqSZT_uxH4x9chHUW3mU0uDbfrR@mail.gmail.com>
In-Reply-To: <AANLkTim9ypGcMEJ4+HqSZT_uxH4x9chHUW3mU0uDbfrR@mail.gmail.com>
Subject: Re: AVRCP 1.4 : Future on Target Role
Date: Wed, 20 Oct 2010 17:24:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shivendra,

> Hi All,
>
> David,
> If you are going to resume AVRCP 1.3 implementation, can we sync
> together as I have done some study on this part as well.
> So far I don't have any device and guess PTS can be taken as start point.

(PTS??)

Regarding an AVRCP device, I have not found any on the market.  I designed 
and built a remote control based on a CSR BC4 chip, with LCD display and 
keypad controller (and battery charger, USB, etc., etc.).  Firmware is 
programmed using the CSR BlueCore SDK.  The latest version (version 4.1.2) 
of the SDK includes functions that provide support for AVRCP 1.3, but 
probably not for 1.4 AFAIK.

For my purposes, I am not implementing A2DP and headset capability in this 
remote.

David
>
> Regards,
> Shivendra
>
 


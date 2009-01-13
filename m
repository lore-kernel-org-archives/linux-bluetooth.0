Return-Path: <cyrus@holtmann.org>
Message-Id: <59B9EB12-3290-4428-A7BF-04E115C9B55D@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <e6fea9c20901130025w21145356yacf4a4d051033e76@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: BlueZ 4.26 : headset profile
Date: Tue, 13 Jan 2009 10:03:25 +0100
References: <e6fea9c20901130025w21145356yacf4a4d051033e76@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Jan 13, 2009, at 9:25, Thierry Pierret wrote:
> I wish my computer to play the role of a headset, with the aim to play
> music from my bluetooth-capable player onto the computer soundcard.

That's not implemented right now so it won't work. There's an  
experimental patch available (with the misleading subject "Gateway  
profile") on this list which hasn't been accepted upstream yet (since  
there are just too many issues with it).

> First I had to enable the "Gateway" option in the "audio.conf" file in
> order to get the Headset service exposed. By the same way, you must
> enable the "Headset" option in order to be an audio gateway). It
> sounds already weird to me.

Yeah, I know it's a little bit counterintuitive. The reason is mainly  
historical. What the option is referring to is which D-Bus interfaces  
should be enabled for remote devices objects. I.e. "Headset" enables  
support for the org.bluez.Headset interface on remote device objects  
(i.e. allows remote devices that support the Headset/Handsfree role to  
be used).

Johan

Return-Path: <cyrus@holtmann.org>
Message-Id: <4B40718A-55AA-40D1-AD54-469C0917070F@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <60689.209.216.239.242.1230838689.squirrel@webmail.ipns.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: incoming connection conflicting with alsa?
Date: Thu, 1 Jan 2009 23:25:36 +0200
References: <60689.209.216.239.242.1230838689.squirrel@webmail.ipns.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

On Jan 1, 2009, at 21:38, Dave Schile wrote:
> I think I'm having  a conflict between alsa and my headset device  
> making
> its own connection.  If there is no connection, programs that are  
> set to
> use the alsa bluetooth  device connect fine.  If I have press the  
> button
> on the headset before alsa can connect to it, te device makes its  
> own ACL
> connection and alsa becomes unable to get the device.
>
> If alsa makes the connection first then  press the button on the  
> headset
> the incoming connection takes the place of the alsa connection and  
> alsa
> loses the device.
>
> How can I solve this?  I've tried a number of hciconfig settings,  
> but the
> button press always creates a connection, breaking the alsa one.

It shouldn't matter if the headset is already connected or if  
bluetoothd needs to create the connection on-demand (when needed by an  
alsa application). In both cases the alsa application should be able  
to pick up the bluetooth audio stream just fine. Could you post the  
output of hcidump -XV when the headset creates a connection to you and  
also when you try to use it with alsa after this (which fails)? Any  
debug output from bluetoothd when this happens could also help.

One potential cause that comes to my mind is that this headset might  
have a buggy HSP implementation (I assume you've got HFP disabled  
based on your other email about the AnswerRequested signal which is  
only available for HSP connections). Maybe the headset tries to  
connect HFP, fails (since you don't have it enabled) but stops there  
even though the correct behavior would be to continue trying to  
connect HSP instead. Which headset model is this btw?

Johan

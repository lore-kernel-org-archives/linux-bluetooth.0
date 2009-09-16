Return-Path: <cyrus@holtmann.org>
Message-ID: <4AB13FFA.8080704@charter.net>
Date: Wed, 16 Sep 2009 15:43:54 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Odd eSCO behavior with BCM2045-based receiver
References: <4AB128CC.6090807@charter.net>
In-Reply-To: <4AB128CC.6090807@charter.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Peter Hurley wrote:
> While attempting to setup a Motorola S9 headset with a BCM2045-based 
> USB dongle (Dell-branded Logitech device), I've observed some strange 
> eSCO behavior.  I'm running 64-bit 2.6.31 kernel with bluez 4.52.
>
> Behavior # 1:  when attempting a SCO connection, frequently the 
> connection is rejected with Reserved Slot Violation status return from 
> the Synchronous Connect Complete event.  The SCO connection 
> occasionally succeeds as an eSCO connection in CVSD mode. I've been 
> experimenting with this for a while. (After some more observation, it 
> may be that the successful path is preceded by a mode change to sniff 
> mode) Any ideas?
>
> Behavior # 2:  The bt receiver's LM crashes when the eSCO connection 
> is disconnected (here's the hcidump):
>
>
> After this, *all connections with every device* are terminated (note 
> that in the above sequence handle 11 was disconnected as well) and 
> cannot be restarted without unplugging the dongle ('hcitool reset' 
> operates but is ineffective) and restarting the daemon.  Again, I'd 
> welcome any suggestions for further experimentation.  I do not have a 
> sniffer.
>
> Thanks,
> Peter Hurley
Answered my own question by discovering the sco kernel module parameter, 
'disable_esco'.  However, it doesn't make sense to me that one device 
incompatibility disables an entire transport type.  Wouldn't it be 
better if the user-space daemon controlled (or at least had the ability 
to override) which transport was attempted?  At least, control would be 
finer-grained (e.g., only HSP profiles could optionally connect to 
SCO-only).  The sco driver has no idea that the connection attempt is 
being driven for a headset.

Regards,
Peter

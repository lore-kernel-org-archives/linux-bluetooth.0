Return-Path: <thomae@ei.tum.de>
Message-ID: <401E22EF.4050009@ei.tum.de>
Date: Mon, 02 Feb 2004 11:14:07 +0100
From: Matthias Thomae <thomae@ei.tum.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   ant-phone-devel@nongnu.org
Subject: Re: [Bluez-users] Telephony with BT headset?
References: <4018CCA1.9060605@ei.tum.de> <1075500623.3594.6.camel@pegasus>
In-Reply-To: <1075500623.3594.6.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:
>>>I have a BT headset lying around which came with my mobile
>>>phone. However, I don't use it with my mobile, so the idea
>>>crossed my mind that it could be possible to use the
>>>headset with my linux server to make phone calls using
>>>the ISDN system.
>>>
>>>I'm quite sure that this _is_ possible, as I can receive
>>>and send an audio stream via ISDN4Linux, and the same
>>>applies (more or less) to the headset via BlueZ.
>>
>>There is a telephone application http://www.antcom.de/ant-phone/ which I
>>have tried with a cable headset.
> 
> has anyone tried this application with the capidrv? For example with a
> AVM B1. I own one, but mine is build into the wrong machine for such
> tests and I need it there. I run some tests with a BlueFRITZ! AP-ISDN
> and call management stuff seems to work, but I don't hear anything on my
> soundcard.

In my setup, I used capidrv and a BlueZ cmtp connection to a BlueFritz! 
AP-X (and a cable-headset), and it worked although I got large 
latencies. Also see my post(s) at the ant-phone mailing list:
http://mail.gnu.org/archive/html/ant-phone-devel/2003-11/msg00002.html

> Is there anyone who will spend some time in adding native CAPI support
> to this application?

I guess Roland has to be asked this :) I cross-post this to his mailing 
list as well.

Regards.
Matthias

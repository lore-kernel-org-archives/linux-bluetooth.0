Return-Path: <cyrus@holtmann.org>
Message-ID: <512996D9.8040705@kamens.us>
Date: Sat, 23 Feb 2013 23:28:09 -0500
From: Jonathan Kamens <jik@kamens.us>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: HFP/HSP Telephony profile doesn't work with Bluetooth USB dongle
References: <51100E6E.8070804@kamens.us>
In-Reply-To: <51100E6E.8070804@kamens.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I sent the below message almost three weeks ago and there have not been 
any responses that I've seen.

Was this the wrong place for me to report this problem? If so, where 
should I report it?

You can get a USB Bluetooth dongle for $2.88 on Amazon, so I don't 
really think cost is an issue, but if it is, then if there is a 
contributor to the code base who is willing to commit to working on 
this, I'm happy to mail him/her a dongle.

   Jonathan Kamens

On 02/04/2013 02:39 PM, Jonathan Kamens wrote:
> Greetings,
>
> Using Fedora 18 x86_64, I've tested two different USB Bluetooth 
> dongles (cheap generic Cambridge Silicon and more expensive BlueRigger 
> BTD-400) and two different headsets (Motorola SF600, BrainyTrade 
> BH-M20), in all combinations, the A2DP High-Fidelity profile for audio 
> output works, but the HFP/HSP Telephony profile does not.
>
> I contacted BlueRigger about this and they tested for themselves on 
> different hardware and got the same result. BlueRigger says the 
> HFP/HSP Telephony profile works fine with Ubuntu, which they say 
> doesn't use Bluez.
>
> I don't know if this problem is new in Fedora 18, because I didn't get 
> the dongles until after I upgraded from Fedora 17.
>
> I've reported this in Red Hat bugzilla 
> <https://bugzilla.redhat.com/show_bug.cgi?id=905283> and emailed the 
> Fedora test list 
> <http://lists.fedoraproject.org/pipermail/test/2013-February/113598.html> 
> about it; there has been no response to either.
>
> Any suggestions or insights into how to resolve this issue would be 
> appreciated.
>
> Regards,
>
> Jonathan Kamens
>
>
>
>


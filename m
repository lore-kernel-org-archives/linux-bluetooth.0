Return-Path: <cyrus@holtmann.org>
Message-ID: <48D8F101.9040802@pook.es>
Date: Tue, 23 Sep 2008 15:37:05 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: martin f krafft <madduck@madduck.net>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [Bluez-devel] "unable to install hw params" to bluetooth (SCO)
 headset
References: <20080822073628.GA5989@piper.oerlikon.madduck.net> <1219394015.7591.441.camel@violet.holtmann.net> <20080826163544.GA5068@lapse.rw.madduck.net> <8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org> <20080905162654.GA17843@lapse.rw.madduck.net> <1220634042.6714.89.camel@californication> <20080923130000.GA848@piper.oerlikon.madduck.net>
In-Reply-To: <20080923130000.GA848@piper.oerlikon.madduck.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 23/09/08 15:00, martin f krafft wrote:
> I can reproduce the exact same error with a BT250 hooked up via
> a different bluetooth adapter to an amd64 machine this time (the
> last one was i386), running 2.6.26.

I as said on http://bugzilla.kernel.org/show_bug.cgi?id=11514 aplay and 
my JX10 headset work with bluez-4.4 and linux 2.6.26. I only get the 
"unable to install hw params" error on 2.6.27-rc5.

> Stuart Pook told me about bluez-utils 4.4 [0] - I am still using 3.36
> [1], but the wiki page says that I need 3.16 or newer. Would
> I have better luck with 4.4? Where does this stuff come in anyway?

I would suggest using bluez-4.x and checking that your headset works 
with a 2.6.26 kernel. Note don't use SCO headsets and linux 2.6.26 for 
too long as using SCO and the old hci_usb driver will cause your machine 
to hard crash sooner or later. The new btusb driver gained SCO support 
in 2.6.27-rc4.

> I am running hcid in the background, but I know too little about
> ALSA or Bluetooth to be able to see how the two interlink. The wiki
> mentions a btaudiod, which 3.36 seems not to have. Is that needed?

I don't remember btaudiob. Bluetoothd has replaced hcid. If you run 
"bluetoothd -d -n" you will see that aplay (via the bluetooth alsa 
libraries) contacts bluetoothd and that it is bluetoothd that connects 
to the headset (at least that is how I understand things).

Be careful when you install bluez-4.x that you replace the alsa 
bluetooth libraries that aplay uses. I can tell you more about this if 
required.

I have added hcidump -XV dumps of the communication between my machine 
and my JX10 headset using 2.6.27-rc5 to the bug report mentioned above. 
Tomorrow I'll add hcidump -XV using 2.6.26 so that we can see the 
differences.

Stuart

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean-Jacques BRUCKER <jean-jacques.brucker@sagem.com>
In-Reply-To: <OF94D063E5.A6EB9011-ONC12571ED.0029C0F3-C12571ED.002ABA9E@sagem.com>
References: <OF94D063E5.A6EB9011-ONC12571ED.0029C0F3-C12571ED.002ABA9E@sagem.com>
Date: Mon, 18 Sep 2006 10:04:32 +0200
Message-Id: <1158566672.5645.11.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel]
	=?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_R=E9f=2E_=3A_Re?=
	=?iso-8859-1?q?=3A_bluez_=3A_new__bluetooth_keyboard=09supported_b?=
	=?iso-8859-1?q?y_hidd=2E?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jean-Jacques,

>  About the left space : it work but I have assigned it to Alt key. At
> the end we need a special kmap file to be able to use all features of
> this keybord, ( mine is an azerty keyboard), in this keymap file (or
> using xmodmap with X) we could reassign left space button to space
> event and Alt gr button to Alt and Alt gr event !
> 
>  I have assigned this button to Alt because I missed him (to switch
> between console for exemple), And to not loose a special keypress on
> the keyboard. (it already have a few keys... only 63 !).

the actual keyboard layout maybe needs a re-thinking. I leave this to
actual users of it.

>  At the end my patch suggested an architecture to manage different
> peripherals. The code in is actual state will become a big mess if the
> number of differents peripheral to manage increase.

No it wasn't an architecture. It still was a hack. The decoding routine
for the keyboard was still named epox_decode(). A clean architecture
would have used a callback table or something similar. You can't design
an architecture if you don't have enough facts about the devices you are
trying to cover. Everything that is based on the Serial Port Profile and
which uses a proprietary protocol on top of RFCOMM is a problem and all
of them are basically unique.

I prefer the less intrusive approach and this was to use the class of
device and/or service name for detecting the (at the moment) two
different devices. I would pick the OUI part of the BD_ADDR only if I
have no other choice and trusting the remote name is also not a good
idea, because some input devices allow to change it.

And besides the Laserkey keyboard, I don't expect any other kind of
Bluetooth input device. The HID is a standard and if you buy a CSR chip,
you basically get the HID support for free. They did all the work for
running HID on the chip.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

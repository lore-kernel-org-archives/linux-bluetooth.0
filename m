Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] New to the headset club :)
From: Marcel Holtmann <marcel@holtmann.org>
To: Nils Faerber <nils@kernelconcepts.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1065537273.29878.613.camel@idoru.kc.de>
References: <1065537273.29878.613.camel@idoru.kc.de>
Content-Type: text/plain
Message-Id: <1065538541.5470.73.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 07 Oct 2003 16:55:35 +0200

Hi Nils,

> I made a mistake and bought a Bluetooth headset ;)

no comment. We talk again after you got a Bluespoon Digital ;)

> New toy... and now I am desperately trying to get a sound from it.
> After some struggeling hstest connects but the headset does not play a
> single beep.
> When hstest connects I get the following:
> 
> Voice setting: 0x0040
> RFCOMM channel connected
> SCO audio channel connected (handle 43, mtu 64)
> AT+VGS=4
> 
> and the headset beeps a single time.
> After that nothing obvious happens anymore.
> What does the AT command mean? It seems to come from the headset, right?
> Would hstest need to respond at least with OK?

If you use 2.4.22-mh1 for example you have a hci_usb driver which allows
you to drive one SCO channel with 16 bit PCM (voice setting 0x0060). My
hstest code operates with 8 bit, so you must change this. When I have a
little bit more time I should modify the hstest program to call sox and
mpg123 as needed. I already have done this, but I don't remember where I
stored the code :(

> Oh, BTW: This headset is a C-Tech BT101, seems a quite common low-price
> one...

Please send the output from "hcitool info <bdaddr>".

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Di Pietro Nicolas <potens@swing.be>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1082745203.718.0.camel@darthvader.linuxkot.kap>
Mime-Version: 1.0
Subject: [Bluez-users] Can't get di Nuovo works in BT :'( help please.  (a bit long,
 sorry)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 23 Apr 2004 20:33:23 +0200

Hi !
Here is the story:
A long time ago (three days) in a land far far away (Belgium)
I've bougth a di Nuovo keyboard and...
... since, I'm trying to get it work :-(
At the moment, the keyboard works and the media pad also (without the
screen but
for now, I don't care), the multimedia key doesn't work (some a of them
but not
much) and the mouse doen't work at all. 

I've read dozens mail, forums howto's and I really
don't know what to do now.

My kernel is a 2.6.5 with gentoo patch and patch-2.6.5-mh3.gz .
It seems that he is patched against multibyte (hid-core)

first, I've tried what was explained <a
href='http://www.bueche.ch/comp/mx900/mx900.html'>here</a>
but it doesn't work :
> /opt/bluetooth/sbin/bthid --daemon
># move your MX900, watch /var/log/daemon.log
>(Connected: Logitech Bluetooth Mouse (abcd:abcd)) 
No, nothing like this. So :
> if your have used your MX900 mouse with another dongle (eg the
Bluetooth
docking >delivered with the MX900), even with another OS (eg Windows
XP), you
have to >convince your HID device (the MX900) to talk to your usual
dongle
again. To do >this, first start the bthid daemon as above (if not yet
done) :
>/opt/bluetooth/sbin/bthid --daemon
># then, with the -c option, poke the mouse using its Bluetooth Address
:
>/opt/bluetooth/sbin/bthid -c 00:07:61:13:E8:21 (this address is mine,
look up
>yours under the mouse)
># then, press the connect button under the mouse
># move your MX900, watch /var/log/daemon.log
>(Connected: Logitech Bluetooth Mouse (abcd:abcd)) 
Nothing better append

<----->
after, I've tried this :
http://www.bueche.ch/comp/mx900/feedback/ghisoli_alexandre_mx900_with_hub.txt

without success :

>Check usb buses to see your USB HUB :
>  lsusb
>Bus 004 Device 001: ID 0000:0000
>Bus 003 Device 003: ID 046d:c704 Logitech, Inc.
>Bus 003 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
>Bus 003 Device 001: ID 0000:0000
>Bus 002 Device 001: ID 0000:0000
>Bus 001 Device 001: ID 0000:0000

Okay, I have the same.

>Then switch it :

>/usr/local/bluetooth/sbin/hid2hci
>Switching device 046d:c704 to HCI mode was successful

No, never seen that, I get :
Switching device 046d:c704 to HCI mode failed (No such file or
directory)

once, I get something different (but don't remember)
I think it was successfull but then my BT receiver (the mouse charger)
freezed
(no more keyboad, keypad, mouse and pushing the button did nothing)

I've seen in this mailing list archive a lot of treads about this mouse
or
keyboard, success and failure hid2hci problem, and no clues for me.
I've tried the libs2 and utils2 (CVS) with and without the
--enable-compat flag.

I'm really sad and turning mad.
Two times the mouse worked (but without BT) but I have to connect
another usb
mouse on the machine and it doesn't work each time.

Help me please.
Tanks in advance an sorry for this awful english.
Nicolas



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

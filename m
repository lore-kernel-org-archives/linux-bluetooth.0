Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Nils Faerber <nils@kernelconcepts.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1065537273.29878.613.camel@idoru.kc.de>
Mime-Version: 1.0
Subject: [Bluez-users] New to the headset club :)
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
Date: Tue, 07 Oct 2003 16:34:33 +0200

Hi!
I made a mistake and bought a Bluetooth headset ;)
New toy... and now I am desperately trying to get a sound from it.
After some struggeling hstest connects but the headset does not play a
single beep.
When hstest connects I get the following:

Voice setting: 0x0040
RFCOMM channel connected
SCO audio channel connected (handle 43, mtu 64)
AT+VGS=4

and the headset beeps a single time.
After that nothing obvious happens anymore.
What does the AT command mean? It seems to come from the headset, right?
Would hstest need to respond at least with OK?

Oh, brave new world ;)

Any hints are welcome!
Oh, BTW: This headset is a C-Tech BT101, seems a quite common low-price
one...

CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

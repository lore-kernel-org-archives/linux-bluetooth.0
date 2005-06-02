Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d3fa87005060214356a41e003@mail.gmail.com>
From: Bruce Lin <bruceylin@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Same 3Com Bluetooth PCMCIA problems
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 2 Jun 2005 16:35:58 -0500

Hi everybody,
Just acquired a 3Com 3CRWB6094 pc card, v1.0, trying to get it working
with Gentoo and a 2.6.11.7 kernel on an IBM Thinkpad T42.  After much
Googling and forum reading, I can get to the same point as jmoose
(previous message on 5/19/2005) did:

1. hci_uart, serial_cs, and all other kernel modules are appropriately load=
ed
2. cardmgr sees the card as it's being plugged in; serial port
/dev/ttyS1 gets created
3. cardctl ident/config shows seemingly correct information
4. "bluefw pccard 0x3f8" loads my 3com firmware to make the little
light turn on.

The problem comes when trying to hciattach the com port.  Anything
other than "hciattach ttyS1 any" times out (using other device types).
 The hci0 device that *is* registered using the "any" type doesn't
report the correct BD address (all zeroes).  Trying to "hciconfig hci0
up" times out as well with the same "Can't init device hci0:
Connection timed out (110)" error.

>From the previous thread, I suppose I know the answer already (too old
of a version, it won't work?), but I wanted to ask the List for any
troubleshooting suggestions before getting another bluetooth card.  If
I have to get another one, the 2.0 version of this card seems to work
better?

You guys seem helpful and responsive on this list; thanks in advance!

--=20
Bruce Lin


http://unclerib.net:8081/bruce.pubkey.asc


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

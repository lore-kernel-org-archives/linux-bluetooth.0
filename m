Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Colin Pinkney <bluez-devel@cpinkney.org.uk>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200402232033.50271.bluez-devel@cpinkney.org.uk>
Subject: [Bluez-devel] Sharp Zaurus ipks
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 23 Feb 2004 20:33:50 +0000

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I though I might mention the Zaurus ipks in the binary packages download ar=
ea=20
are a bit out of date (Nice website now though). I think the kernel modules=
=20
in those ipks are for the 2.4.6 kernel while all the latest Zaurus devices=
=20
and ROMs use kernel 2.4.18. I have updated the ipks, included the bt950=20
driver, stopped the bluecard based cards from locking up the Zaurus, added=
=20
several cards to /etc/pcmcia/bluetooth.conf and made a way of editing a=20
simple file (/etc/bluetooth/uart) to specify the hciattach parameters. I've=
=20
written a howto for the Zaurus, which also gives the ipk links:

http://www.zaurususergroup.com/modules.php?op=3Dmodload&name=3DphpWiki&file=
=3Dindex&pagename=3DBluetooth

The Zaurus community is also maintaining a Bluetooth CF card compatibility=
=20
list that I setup, specifically for the Zaurus:

http://www.zaurususergroup.com/modules.php?op=3Dmodload&name=3DphpWiki&file=
=3Dindex&pagename=3DBluetoothCardSupport

You might notice an ipk for CSR based CF cards in the howto above, like the=
=20
Socket Bluetooth Rev G. This is a hack to get the Zaurus to do the serial=20
initialisation properly and then run the hciattach command. I've tried addi=
ng=20
the ident details to bluetooth.conf and then put the setserial commands=20
in /etc/pcmcia/bluetooth but that did work for some reason (I only have the=
=20
Rev F card, which doesn't help).=20

I don't know if you like attachments on this list, so here's my=20
latest /etc/pcmcia/bluetooth

>>>>>>>>>
#!/bin/sh
#
# bluetooth
#
# Initialize a PCMCIA Bluetooth device
# Written by Colin Pinkney
#
# $1 - start/stop
# $2 - HCI device (e.g. hci0)
#

IDENT=3D"/sbin/cardctl ident"
UART_CONF=3D"/etc/bluetooth/uart"

ID=3D`$IDENT | grep info: | sed 's/^ *product info: *//'`
TYPE=3D`$IDENT | grep function: | sed 's/^ *function: *//' | cut -f1 -d" "`

case "$1" in
start,resume)
   case "$TYPE" in
	# Serial device
	2)
	   [ -f /usr/sbin/hciattach -a -f $UART_CONF ] || exit 0
           ID=3D`/sbin/cardctl ident | grep info: | sed 's/^ *product info:=
 *//'=20
| sed 's/"/\\"/g'`
           UART_SET=3D`grep "$ID" $UART_CONF | cut -f2 -d":"`
           if [ "$UART_SET" !=3D "" ]; then
              DEVICE=3D`echo $UART_SET | cut -f1 -d" "`
              IRQ=3D`setserial $DEVICE | sed -e 's/.*IRQ: //'`
              setserial $DEVICE irq 0 ; setserial $DEVICE irq $IRQ
              /usr/sbin/hciattach $UART_SET
           fi
        ;;
        *)
           # Do nothing for other types
        ;;
   esac
;;
stop,suspend)
   hciconfig $2 down
   sleep 1
  =20
   case "$TYPE" in
   2)
      killall hciattach > /dev/null 2>&1
   ;;
   *)
      # Do nothing specific for non-serial
   ;;
   esac
;;
esac

exit 0
<<<<<<<<<

The file /etc/bluetooth/uart looks like this (Bit rubbish I know, but it=20
works):

>>>>>>>>>
"Socket", "CF+ Personal Network Card Rev 2.5":/dev/ttyS3 bcsp 230400
"Bluetooth BT0100M":/dev/ttyS3 bcsp
<<<<<<<<<

=2D --=20
Colin Pinkney
http://www.cpinkney.org.uk
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAOmOuioDqRlN9/eURAoPlAJ4uWW0pbdXlT7cThoZzY3gyglj8sACggrUr
O48un1FyBIgqnGHG0iltKmM=3D
=3DcWPt
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm use count
Message-ID: <001601c495f8$fb6b0760$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <001501c495f5$f36b05e0$1a01010a@baked>
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
Date: Wed, 8 Sep 2004 16:10:07 -0700

One more thing possibly of interest:

cat /proc/bluetooth/l2cap:
00:00:00:00:00:00 00:00:00:00:00:00 4 3 0x0000 0x0000 1024 0 0x0

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> Daryl Van Vorst
> Sent: September 8, 2004 3:48 PM
> To: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Rfcomm use count
>=20
>=20
> Marcel,
>=20
> I've been able to get the rfcomm use count to stick above 0 using a
> single-threaded app which only does RFCOMM socket calls. After killing
> hciattach and all bluetooth related programs, I have this:
>=20
> lsmod:
> Module                  Size  Used by    Not tainted
> rfcomm                 23268   2  (autoclean)
> hci_uart                5656   0  (autoclean)
> l2cap                  17028   1  (autoclean) [rfcomm]
> bluez                  32392   0  (autoclean) [rfcomm hci_uart l2cap]
>=20
> cat /proc/bluetooth/rfcomm:
> sk  3A:A4:58:16:05:00 26:02:5F:16:05:00 9 4
> sk  3A:A4:58:16:05:00 26:02:5F:16:05:00 9 10
>=20
> This shows, I think, two sockets in the BT_CLOSED state which=20
> aren't getting
> cleaned up. Kernel is 2.4.21-mh10 running on an ARM (with ARM=20
> patches, which
> as far as I can tell don't touch any bluetooth code).
>=20
> The test program loops, doing the following, in pseudo code:
>=20
> While(1) {
> 	1. Connect to remote device via rfcomm
> 	2. send a few 100 bytes of data
> 	3. Attempt to receive, but the remote side closes the=20
> connection.
> 	4. creates a socket, binds, listens, and accepts an=20
> incomming rfcomm
> connection
> 	5. closes the listening socket (continues to use the=20
> socket return
> by accept)
> 	6. sends a few 100 bytes and receives ~100kB.
> 	7. closes the socket
> }
>=20
> Unfortunately the problem is not easily reproduced. It can=20
> take all day for
> it to happen, with the test program being re-run many times=20
> (and stopped
> with ctrl-c).
>=20
> There are two modules connected via serial. On the device two=20
> copies of this
> program are run, each one specifying a local bluetooth device=20
> in the bind
> calls for connect and listen/accept. i.e. each program works=20
> with its own
> local device and does not do anything with the other device.
>=20
> Any thoughts?
>=20
> -Daryl.
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=3Dick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

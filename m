Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000001c402dd$07bf1dd0$9349edc7@thores>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-users] AUX1 and devices
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
Date: Fri, 5 Mar 2004 10:09:41 -0800

Does anyone know of any Bluetooth devices that have a HCI command for
sending user data in AUX1 packets?

I know this is disallowed in the Bluetooth specification, but I have
seen some
devices that have vendor commands that send AUX1 packets. The problems
with these
is that they don't allow any user data, but instead just allow an
argument that
specifies the number of transmissions (along with connhandle). 
The device then sends its own magic bit-pattern so the other end can
compute BER.

The reason for my interest is that I want to measure the latency of AUX
packets
using my own software implemented error control and adaptive
compensation scheme.
There are several research papers that prove AUX1 packets to be superior
to the
other 6 in terms of latency with a good sw error control scheme, for a
good range
of BER.

Thanks,

Thor


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000301c3fe31$fdf2b460$46a57e40@thores>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-users] AUX1 packets
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
Date: Sat, 28 Feb 2004 11:35:16 -0800

Is there any way of having an ACL connection use AUX1 packets?

The packet type is not defined in the Bluetooth specification for
the HCI_create_connection command.

I am using Belkin USB devices (CSR).

Can this be done by setting one of the reserved packet types,
or using a vendor specific command, or is it simply not possible?

The reason I want to do this is to measure the effect of having
CRC, FEC and ARQ on the software side, also using proactive
retransmits.

Thanks,

Thor E. Skaug


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

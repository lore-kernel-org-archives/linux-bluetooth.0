Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Manolis Stamatogiannakis <mstamat@csd.uoc.gr>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.GSO.4.53.0310091345550.20391@thetis.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] flow control question
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
Date: Thu, 9 Oct 2003 13:54:11 +0300 (EEST)

Hi,
As I remember from a previous thread if you use BlueZ to exchange data
between two apps and receiving device receives too slow, eventually data
will be lost due to kernel buffers for receiving device being filled up.

Does the mechanisms (eg some HCI call?) exist to allow you propagate the
knowledge that buffers are full (so data will be lost) to the Bluetooth
chip and make it use the FLOW field on baseband packets to notify sender
to stop sending?

Thanks,
Manolis


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

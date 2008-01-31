Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Jan 2008 12:28:08 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200801312028.m0VKS8ST011488@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] unique bus name
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

	'Could you try running it manually as root with
"/usr/lib/bluetooth/ bluetoothd-service-audio -s" as see what messages
you get?'

/etc/bluetooth# /usr/local/lib/bluetooth/bluetoothd-service-audio -s
audio[5746]: Bluetooth Audio daemon
audio[5746]: Config options: DisableHFP=true, SCORouting=PCM, SourceCount=2
audio[5746]: Unix socket created: 5
audio[5746]: Adding service record failed: Connection refused
audio[5746]: Unable to register HS AG service record
audio[5746]: Unregistered manager path
audio[5746]: Audio init failed!

	This causes nothing to show up in hcidump, so it isn't even
getting to the Bluetooth transceiver.

	Everything I try, when it gets through to the target headset,
times out.  'Pin Code Request' returns 'Error: LMP Response Timeout'
	Is this more likely the headset or the transceiver?

russell bell

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 13 May 2008 09:55:21 -0700
Message-ID: <F60A3CE9E807BE49B5F56BD80B894D20016883A4@sc-exch03.marvell.com>
From: "Angus Ainslie" <aainslie@marvell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] A2dpsink with bluez 3.31
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I've got an application that was running with a2dp under bluez 3.24 .
With bluez 3.31 there seems to be some children added to the a2dp sink.
The fakesink child transitions nicely from NULL to READY to PAUSED. The
a2d2psink transtions from NULL to READY but never makes it to PAUSED.

Is there a description of how the new children and a2dpsink should
interact?
Does it need a different initialization scheme from the 3.24 sink ?

Thanks
Angus

Senior Firmware Developer
Automotive Systems Group
Marvell Semiconductor

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

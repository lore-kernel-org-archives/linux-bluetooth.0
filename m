Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 13 Mar 2008 21:32:28 +0100
Message-Id: <1205440348.12951.9.camel@californication>
Mime-Version: 1.0
Subject: [Bluez-devel] Moving towards a new API for BlueZ 4.0
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

Hi Folks,

so we are near to the end-of-lifetime for the BlueZ 3.x series. We will
have only a few release left and the plan is to end it with the magic
number 3.33 in a few weeks.

Everybody is currently working hard at implemented the new features and
API changes for the 4.x series. We will deprecated a big chunk of the
D-Bus API and basically do major simplifications. For a preview you can
check the new doc/ directory in the bluez-utils CVS repository. It
contains documentation for the new manager, adapter, device and agent
interfaces. The real new stuff is the device interface which will
represent paired and known remote device. Also the agent interface
changes a lot to implement what we have learned during the last two
years of D-Bus usage within BlueZ.

Most of the new API is already implemented and will be part of the 3.29
release within the next few days. All new features are marked as
experimental until we reach 4.0 and you have to start hcid with the -x
option to enable them.

Please review the interface APIs and do some early testing.

More to come soon :)

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

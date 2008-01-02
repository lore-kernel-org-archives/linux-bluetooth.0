Return-Path: <cyrus@holtmann.org>
Message-ID: <992535570801012318m4cb67e35ke0c95e60ad85b496@mail.gmail.com>
Date: Wed, 2 Jan 2008 07:18:13 +0000
From: "Alex Tanner" <lxtanner@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Bug: "SCO packet for unknown connection handle X"
	errors unnecessarily flood syslog/dmesg when certain BT
	adapters are used
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

IMO, I think checking for the above named error is in itself an error
if done outside a debug context. Perhaps the Connection Handle "error"
could be checked for just ONCE (upon insertion of "offending"
hardware) rather than 100's of times a second? The effect on hardware
seems to be so minimal that there is no justification for checking the
situation that many times. Much more information on this issue can be
found at <http://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.15/+bug/39414>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Feb 2008 19:15:03 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200802110315.m1B3F19F020278@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] passkey-agent and auth-agent
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


	'I was of the impression that passkey-agent and auth-agent
were unsupported/sample programs. Am I correct?  As far as I can tell,
they are undocumented, neither in the tarball, nor in the wiki (aside
from a few brief mentions) I don't have a full build system up right
now, but judging from the various Makefile.in files in the tarball, it
appears they are not built by default.  Debian does not distribute
them-- does any distribution?'
	Slackware doesn't.  I built from source which built these two
but install didn't put them into the target bin directory; I did by
hand.

russell bell

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <cyrus@holtmann.org>
Message-ID: <20080120235254.32204.qmail@station192.com>
From: "=?iso-8859-1?Q?russell?=" <russell@rickstewart.com>
To: bluez-users@lists.sourceforge.net
Date: Sun, 20 Jan 2008 23:52:54 +0000
MIME-Version: 1.0
Subject: [Bluez-users] All connections disconnect immediately
Reply-To: =?iso-8859-1?Q?russell?= <russell@rickstewart.com>,
	BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I just bought a bluetooth adaptor and bluetooth headset.  I can connect to the headset and
to some of my neighbors' computers, but only for a second.  When I run:

    hcitool cc $HeadsetID

then try to run anything else that requires a connection I find that I am already disconnected.
I tell this because I run hcidump in another virtual terminal.  I stay connected for about a second,
then hcid requests disconnection.

If I put another command on the same line, for instance:

     hcitool cc $HeadsetID ; hcitool lq $HeadsetID

the 'lq' gets completed before the disconnection so I get a link quality report (240-255).

The same happens when I connect to a neighbor's computer (unbeknownst to them).

What's going on here?


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

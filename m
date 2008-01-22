Return-Path: <cyrus@holtmann.org>
Message-ID: <20080122042247.25733.qmail@station192.com>
From: "=?iso-8859-1?Q?russell?=" <russell@rickstewart.com>
To: bluez-users@lists.sourceforge.net
Date: Tue, 22 Jan 2008 04:22:46 +0000
MIME-Version: 1.0
Subject: [Bluez-users] 'cannot open libasound_module_pcm_bluetooth.so': a
	solution
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

	When I try to play a file on my headset via bluetooth I get
that message.  I don't have libasound_module_pcm_bluetooth.so.  I run
Slackware 10.2 with kernel 2.6.23.1 and had all the bluez-* packages
(3.22) installed.  I uninstalled all the bluez-* packages, downloaded
the latest source from bluez.org, built it, and still had the same
result.  I found some likely source for
libasound_module_pcm_bluetooth.so in bluez-utils-3.24, ran:

	configure --enable-alsa --enable-usb --enable-avctrl --enable-audio

(I don't know that I needed all of those, perhaps just the
'--enable-alsa') rebuilt, and still had the same problem.  I figured
out my sound apps were looking only in /usr/lib/alsa while the build
had put the libraries in /usr/local/lib/alsa.  I linked the contents
of /usr/local/lib/alsa to /usr/lib/alsa and they were happy (perhaps
rebuilding the apps, or other libraries they use, would have solved
the problem too) - at least they didn't complain about not finding the
library, only about not finding a target: I still haven't figured out
how to make a permanent connection to my headset.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jan 2008 11:56:33 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200801241956.m0OJuWIV003375@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] 'cannot open libasound_module_pcm_bluetooth.so': a
	solution
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

	When I try to play a file on my headset via bluetooth I get
that message.  I don't have libasound_module_pcm_bluetooth.so.  I run
Slackware 10.2 with kernel 2.6.23.1; I had all the bluez-* packages
(3.22: Slackware's most recent version) installed.  I uninstalled all
the bluez-* packages, downloaded the latest source from www.bluez.org,
built it, had the same result.  I found some likely source for
libasound_module_pcm_bluetooth.so in bluez-utils-3.24, ran:

	configure --enable-alsa --enable-usb --enable-avctrl --enable-audio

(I don't know that I needed all of those, perhaps just the
'--enable-alsa') rebuilt, and still had the same problem.  I figured
out my sound apps were looking only in /usr/lib/alsa while the build
had put the libraries in /usr/local/lib/alsa.  I linked the contents
of /usr/local/lib/alsa to /usr/lib/alsa and my apps were happy
(perhaps rebuilding the apps, or other libraries they use, would have
solved the problem too) - at least they didn't complain about not
finding the library, only about not finding a target: I still haven't
figured out how to make a permanent connection to my headset.

russell bell


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <cyrus@holtmann.org>
Message-ID: <47986354.2080205@naustech.com>
Date: Thu, 24 Jan 2008 11:07:16 +0100
From: "Ing. Gabriele Oberhammer" <gabriele@naustech.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4795D6EB.2080209@naustech.com>
	<1201018471.24085.4.camel@littletux>
In-Reply-To: <1201018471.24085.4.camel@littletux>
Subject: Re: [Bluez-users] Headset half working using Bluez's ALSA plugin
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Hi, I've successful compiled and installed 'utils' and 'libs' from today 
cvs but now its worse then before, now playback doesn't work too :-(
Now In the preferences menu in gnome-applet there are no services 
listed, but my headset pairs correctly.
Here's what I've done, please tell ma what's wrong:

1. checked out latest 'utils' and 'libs' directoryes from cvs
2. installed all needed development headers
3. Compiled:
	$ cd utils/
	$ sudo ./bootstrap
	$ sudo ./configure --enable-all --prefix=/usr/local/
	$ sudo make

	$ cd ../libs/
	$ sudo ./bootstrap
	$ sudo ./configure --prefix=/usr/local/
	$ sudo make

4. uninstalled bluez-utils:
	$ sudo apt-get remove bluez-utils

5. uninstalled libbluetooth2 (forcing needed to solve dependencies):
	$ sudo dpkg --force-all -r libbluetoot2

6. Installed libs and utils:
	$ cd libs; sudo make install
	$ cd utils; sudo make install

7. Edited '/etc/init.d/bluetooth' and modified all paths to pont to 
correct locations under /usr/local/{bin,sbin}

8. rebooted (I know it's not needed but I did it)

9. Now headset pairs, 'hcitool dev' correctly shows it but
	$ mplayer -ao alsa:device=bluetooth test.mp3
	
	gives:

	....
	[AO_ALSA] alsa-lib: pcm.c:2105:(snd_pcm_open_conf) Cannot open shared 
library /usr/lib/alsa-lib/libasound_module_pcm_bluetooth.so
	[AO_ALSA] Playback open error: No such file or directory
	....


10. sadness  ;(


Can someone help me or give me some link to documentation about correct 
procedures for cvs building?


Tnx  :-)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

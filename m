Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Jan 2008 06:04:01 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47986354.2080205@naustech.com>
Message-ID: <alpine.LNX.1.00.0801270455220.19860@nge2.ngu.pk>
References: <4795D6EB.2080209@naustech.com>
	<1201018471.24085.4.camel@littletux>
	<47986354.2080205@naustech.com>
MIME-Version: 1.0
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


On Thu, 24 Jan 2008, Ing. Gabriele Oberhammer wrote:



-> Hi, I've successful compiled and installed 'utils' and 'libs' from today cvs
-> but now its worse then before, now playback doesn't work too :-(

I'd stick with stable, cvs stuff is usually not intended for production use. 
Sometimes you need it for a new feature or fix, but I don't think that's the 
case here.

-> Now In the preferences menu in gnome-applet there are no services listed, but
-> my headset pairs correctly.
-> Here's what I've done, please tell ma what's wrong:
-> 
-> 1. checked out latest 'utils' and 'libs' directoryes from cvs
-> 2. installed all needed development headers
-> 3. Compiled:
-> 	$ cd utils/
-> 	$ sudo ./bootstrap
-> 	$ sudo ./configure --enable-all --prefix=/usr/local/
-> 	$ sudo make
-> 
-> 	$ cd ../libs/
-> 	$ sudo ./bootstrap
-> 	$ sudo ./configure --prefix=/usr/local/
-> 	$ sudo make

You should probably install into /usr instead of use /usr/local when you are 
replacing your main system things, else you end up with two conflicting 
versions of the same thing, or apps will look in /usr and quit, ignoring 
/usr/local. You can do tricks with symlinks, or hope the apps check the local 
level, but that gets messy.


-> 8. rebooted (I know it's not needed but I did it)

MS Windows? ;)


-> 	....
-> 	[AO_ALSA] alsa-lib: pcm.c:2105:(snd_pcm_open_conf) Cannot open shared
-> library /usr/lib/alsa-lib/libasound_module_pcm_bluetooth.so
-> 	[AO_ALSA] Playback open error: No such file or directory
-> 	....

It looks in /usr not /usr/local here...

That file is built in bluez-utils, provided you have a complete and working 
Alsa install. Beware, lots of distros give you abbreviated/incomplete 
installs. You think you have the whole shbang, but likely don't, you need 
*-dev or *-devel or some other such thing. There may be plugin packages, or 
they may split one alsa source tarball into a dozen binary packages, all of 
which you might need to track down and install to actually get the full, 
working, buildable install.

I'd start with Alsa since it seems suspect. You should have stuff like:

tree /lib/modules/2.6.23.13/kernel/sound/ 
/lib/modules/2.6.23.13/kernel/sound/
|-- ac97_bus.ko.gz
|-- core
|   |-- oss
|   |   |-- snd-mixer-oss.ko.gz
|   |   `-- snd-pcm-oss.ko.gz
|   |-- seq
|   |   |-- oss
|   |   |   `-- snd-seq-oss.ko.gz
|   |   |-- snd-seq-device.ko.gz
|   |   |-- snd-seq-dummy.ko.gz
|   |   |-- snd-seq-midi-event.ko.gz
|   |   |-- snd-seq-midi.ko.gz
|   |   |-- snd-seq-virmidi.ko.gz
|   |   `-- snd-seq.ko.gz
|   |-- snd-page-alloc.ko.gz
|   |-- snd-pcm.ko.gz
|   |-- snd-rawmidi.ko.gz
|   |-- snd-rtctimer.ko.gz
|   |-- snd-timer.ko.gz
|   `-- snd.ko.gz
|-- drivers
|   |-- snd-dummy.ko.gz
|   `-- snd-virmidi.ko.gz
|-- pci
|   |-- ac97
|   |   `-- snd-ac97-codec.ko.gz
|   `-- snd-intel8x0.ko.gz
`-- soundcore.ko.gz

(unless compiled in-kernel, which is unlikely since sound isn't a boot 
requirement. Your card driver will likely be different, and the oss emulation 
stuff may not be there)

ls /usr/include/alsa

alisp.h             conv.h     instr.h         pcm_extplug.h  seq.h 
version.h
asoundef.h          error.h    mixer.h         pcm_ioplug.h   seq_event.h
asoundlib.h         global.h   mixer_abst.h    pcm_old.h      seq_midi_event.h
conf.h              hwdep.h    output.h        pcm_plugin.h   seqmid.h
control.h           iatomic.h  pcm.h           pcm_rate.h     sound/
control_external.h  input.h    pcm_external.h  rawmidi.h      timer.h

ls -l /usr/lib/libasound.*

-rw-r--r-- 1 root root 1.3M Dec 29 17:05 /usr/lib/libasound.a
-rwxr-xr-x 1 root root  819 Dec 29 17:05 /usr/lib/libasound.la*
lrwxrwxrwx 1 root root   18 Dec 29 17:05 /usr/lib/libasound.so -> libasound.so.2.0.0*
lrwxrwxrwx 1 root root   18 Dec 29 17:05 /usr/lib/libasound.so.2 -> libasound.so.2.0.0*
-rwxr-xr-x 1 root root 961K Dec 29 17:05 /usr/lib/libasound.so.2.0.0*


These I built from

linux-2.6.23.13, kernel.org

alsa-lib-1.0.15.tar.bz2
alsa-plugins-1.0.15.tar.bz2
alsa-tools-1.0.15.tar.bz2  (might not need this, I didn't)
alsa-utils-1.0.15.tar.bz2, alsa site (forgot the URL)


bluez-firmware-1.2.tar.gz
bluez-libs-3.24.tar.gz
bluez-utils-3.24.tar.gz, bluez.org


bluez-utils built with:

configure '--prefix=/usr' '--enable-static' '--enable-shared' '--enable-pie' 
'--enable-expat' '--enable-usb' '--enable-alsa' '--enable-obex' 
'--enable-glib' '--enable-audio' '--enable-input' '--enable-serial' 
'--enable-network' '--enable-sync' '--enable-echo' '--enable-hcid' 
'--enable-sdpd' '--enable-hidd' '--enable-pand' '--enable-test' 
'--enable-cups' '--enable-manpages' '--enable-configfiles' '--enable-bccmd' 
'--enable-avctrl' '--enable-hid2hci' '--enable-dfutool' '--enable-dfubabel' 
'--with-gnu-ld'

Should build:

find bluez-utils-3.24/audio -name \*.so

bluez-utils-3.24/audio/.libs/libasound_module_pcm_bluetooth.so
bluez-utils-3.24/audio/.libs/libasound_module_ctl_bluetooth.so

When the 'checking for ...' messages are going, it should list ALSA as yes or 
ok. If not, open config.log and look for the tests it used to determine if 
Alsa was OK or not, and see why it failed. The tests are usually looking for a 
file or program, or trying to compile/link/run a program.

Doing just ./configure usually isn't enough. Start with ./configure --help and 
look at all the options, and pick and choose what you want/need, then build 
with that.



bluez-utils plus alsa-plugins should give a full set like:

ls -1 /usr/lib/bluetooth

bluetoothd-service-audio*
bluetoothd-service-echo*
bluetoothd-service-input*
bluetoothd-service-network*
bluetoothd-service-serial*
bluetoothd-service-transfer


ls -1 /usr/lib/alsa-lib/*.so

/usr/lib/alsa-lib/libasound_module_ctl_bluetooth.so*
/usr/lib/alsa-lib/libasound_module_ctl_dsp_ctl.so*
/usr/lib/alsa-lib/libasound_module_ctl_oss.so*
/usr/lib/alsa-lib/libasound_module_pcm_alsa_dsp.so*
/usr/lib/alsa-lib/libasound_module_pcm_bluetooth.so*
/usr/lib/alsa-lib/libasound_module_pcm_oss.so*
/usr/lib/alsa-lib/libasound_module_pcm_upmix.so*
/usr/lib/alsa-lib/libasound_module_pcm_vdownmix.so*
/usr/lib/alsa-lib/libasound_module_rate_speexrate.so*
/usr/lib/alsa-lib/libasound_module_rate_speexrate_best.so@
/usr/lib/alsa-lib/libasound_module_rate_speexrate_medium.so@

...depending on how you configured alsa in the kernel, the stuff you have 
installed, and how you built the alsa user-space libs/utils.


Bluetooth is a plugin, libasound_module_pcm_bluetooth, so you'll need 
something like

pcm.bluetooth {
         type bluetooth
         device 00:1A:45:01:F9:42
}

in an alsa configuration file. Then you make sure the bluez-utils config 
files are set, plug in the hardware if you have this type of bluetooth 
device, start dbus, and the bluetooth servers. passkey-agent should be running 
with the PIN of your device. I find the device to the computer pairs easier 
than the other way, but that might just be my setup. After that you should be 
able to use the bluetooth pcm to play your sound file, but I haven't got this 
last part working perfectly yet.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

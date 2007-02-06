Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45C83D70.9030900@killesreiter.de>
Date: Tue, 06 Feb 2007 09:33:52 +0100
From: Gerhard Killesreiter <gerhard@killesreiter.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45C7C6DF.20106@killesreiter.de> <45C7FFD2.9080300@xmission.com>
In-Reply-To: <45C7FFD2.9080300@xmission.com>
Subject: Re: [Bluez-users] headset /SCO / plugz
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Brad Midgley wrote:
> Gerhard
> 
>> 6) now what? a2dpd doesn't show up in my output choices in xmms, 
>> "headset" shows up as a choice for the mixer device, but not the general 
>> output device.
> 
> I have to type
>  a2dpd
>   or
>  headset
> freehand in the device choice in xmms. It's true it doesn't find it
> automatically and we've tried to document that.
>

Ok, tried that, but it still doesn't work.

Set to a2dpd and ran a2dpd:

  a2dpd
A2DPD[392.542]: make_daemon_process: a2dpd [Feb  4 2007 12:12:52] 
starting ...
A2DPD[392.543]: init_uinput: (errno=2:No such file or directory)Cannot 
open /dev/input/uinput
A2DPD[392.543]: a2dpd_signal_init:
A2DPD[392.545]: a2dpd_signal_init: (errno=2:No such file or 
directory)Getting on DBUS
A2DPD[392.548]: a2dpd_signal_init: OK
A2DPD[392.548]: add_avrtg:
A2DPD[392.549]: add_a2source:
A2DPD[392.549]: a2dpd_signal_set_socket: Signal socket set to 9
A2DPD[392.551]: a2dpd_thread_handler: Registering object path: 
/com/access/a2dpd
A2DPD[392.641]: a2dpd_thread_handler: Acquiring service: com.access.a2dpd
A2DPD[392.643]: a2dpd_thread_handler: Running ...
A2DPD[392.644]: a2dpd_signal_state: Disconnected

If I run aplay I get:

aplay -B 1000000 -D a2dpd 
/usr/lib/openoffice/share/gallery/sounds/wallewal.wav
ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM a2dpd
aplay: main:550: audio open error: Datei oder Verzeichnis nicht gefunden


> What does your .asoundrc have in it?

It is a copy of the one you ship with the mac address of my headset.

How do I find out if my headset has been successfully paired to my 
bleutooth dongle?

Cheers,
	Gerhard

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

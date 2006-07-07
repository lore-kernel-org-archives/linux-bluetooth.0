Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44AE84D4.9080903@palmsource.com>
Date: Fri, 07 Jul 2006 17:59:16 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Alsa plugin for A2DP daemon
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,

    I've been working with Brad's a2dp plugin for some time now. I =

hacked it with the idea of having an ipc alsa plugin and an audio daemon =

and guess what : today, I have something working pretty well. It fully =

separate the application and the headset (tcp used for ipc). Thus, you =

can let the application play audio while having the heaset switched off. =

Switch on the headset and you will start hearing sound. It also permit =

having lots of applications using the headset at a time and yes, sound =

is mixed. You can crash and restart the daemon without interrupting the =

app. Reverse is possible too.
    Drawbacks : some ticks in the sound, Tcp may give additionnal burden =

but for now it seems far from being cpu intensive (if you consider Xeon =

as being a representative cpu ;).

    Brad, to do this, I only modified file Makefile.am and added new =

source code files in the 'alsa-plugins' folder. It will setup next to =

the original alsa-plugin. Is is called pcm_a2dpd.c. The archive also =

contain a modified version of pcm_a2dp.c that receives connections on =

the control socket.

    You can get a full archive there http://fdalleau.free.fr/btsco.tar.gz
     I would love to have someone try it on an ARM platform. Next step =

is volume control!

    Hope you like it! Documentation follow

    Fr=E9d=E9ric




To build
-----------
    bootstrap && ./configure --enable-alsaplugin && make && sudo make =

install
    You may have to create a symbolic link as I had : sudo ln -s =

/usr/local/lib/alsa-lib  /usr/lib/alsa-lib


To run
----------
    Your headset must be paired.
    create .asoundrc if you do not have one that contain the following =

(don't forget backup previous one)
pcm.!default {
        type a2dpd
        bdaddr "00:11:22:33:44:55"
}

pcm.a2dpd {
        type a2dpd
        bdaddr "00:11:22:33:44:55"
}
    This bluetooth address is needed but not used. Put something that =

looks like a bluetooth address.

    restart alsa with : /etc/init.d/alsa-utils restart

    start your favorite media player configure it to play with alsa, and =

press play!

    Oops, we forgot to start the daemon... No problem. Go in the =

alsa-plugins subfolder of the archive and type : a2dpd AA:BB:CC:DD:EE:FF.
    where AA:BB:CC:DD:EE:FF is the bluetooth address of your device. =

Now, switch on your headset. Ctrl-C will quit the daemon.

    Try to keep with 16bits/stereo sounds!

    Remove the .asoundrc to restore your sound!



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

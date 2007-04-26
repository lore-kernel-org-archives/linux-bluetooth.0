Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a72d33330704261041x375653d6ia0af61b82085bca5@mail.gmail.com>
Date: Thu, 26 Apr 2007 19:41:55 +0200
From: "Ma Begaj" <derliebegott@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headsetd, skype and bluetooth headsets.
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

Did you or someone else solve this problem?

I have the same problem. I applied the latest kernel patch (v4.2) with
the latest vanilla kernel 2.6.21.

I have Jabra 250v, sound is ok with aplay and arecord, hearing in
skype is ok,  but my recorded voice (echo123) is "garbled beyond
recognition".

Thanks

M.


Alan Conway wrote:

---- quote ---
Trying to use a plantronics 510s with skype.



Update on my attempts, I've established the setup that almost works. By
almost works I mean:
- aplay, arecord -D headset work, quality is fine for telephone use.
- aoss skype almost works: I can hear the test call clearly, I can
record a message but when it is played back my voice is garbled beyond
recognition.

My next step is to fiddle with pcm settings - I've seen .asoundrc
scripts for skype and dmix that do conversions between 8 and 16 bit
formats and other stuff I know nothing about (but am afraid I'm gonna
learn). Here are the details of how I got this far:

== DETAILS: based on btsco/docs/build.html from CVS, slightly modified.

install libsbc:

Note: When asking for a password simply press Enter.

cvs -d:pserver:anonymous <at> sbc.cvs.sourceforge.net:/cvsroot/sbc login
cvs -d:pserver:anonymous <at> sbc.cvs.sourceforge.net:/cvsroot/sbc co sbc
cd sbc
./bootstrap
./configure --prefix=/usr
make
sudo make install

install bstco:

cvs
-d:pserver:anonymous <at>
bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa
login
cvs
-d:pserver:anonymous <at>
bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa
co btsco
cd btsco
./bootstrap
# Note I added CFLAGS in ./configure. Without them the plugin emits
# a torrent of debug messages that slow it down and ruin the sound quality.
# -NDEBUG is essential, -03 is just for good luck.
./configure --prefix=/usr --enable-alsaplugin CFLAGS="-NDEBUG -03"
make
sudo make install

** Using from skype
My .asoundrc is copied from btsco/alsa-plugins/asound.conf with the
headset address replaced by my own and the following addition for aoss:

# Use headset via aoss emulation for skype.

pcm.dsp0 {
   type plug
   slave.pcm "hw_headset"
}

Full .asoundrc attached. Run skype as "aoss skype" (you need alsa-oss
package installed.)

== NOTES

The instructions at http://bluetooth-alsa.sourceforge.net/build.html did
*not* work for me. The plugz version of the plugin requires a different
.asoundrc (based on plugz/asound.conf) but aplay -D headset gave me:

[aconway <at> scooter plugz]$ aplay -D headset /usr/share/sounds/startup3.wav
Playing WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Stereo
aplay: set_params:909: Channels count non available

Cheers,
Alan.

pcm.headset {
	type plug;
	slave.pcm "hw_headset";
}

pcm.hw_headset {
	 <at> args [BDADDR TIMEOUT MAX_PERIODS]
	
	# The Bluetooth device address for target headset, used for Audio
Gateway (PC) initiated connections
        # Please note that this value is ignored when the connection
is Headset initiated
	 <at> args.BDADDR {
		type string
		default "00:03:89:95:9C:83" # Put your HS address here
	}

	# This value represents how long we will try to reach the headset,
until we give up.
	# Value is in milliseconds
	 <at> args.TIMEOUT {
		type integer
		default 6000
	}

	# This is the size of the buffer used to queue Voice packets. Value
must be between
	# 2 and 334 (~ 1 second). Default value is 2 buffers, which works
well most of the
        # time, and has the advantage of giving us an ultra low delay
	 <at> args.MAX_PERIODS {		
		type integer
		default 334
	}

	type        sco
	bdaddr      $BDADDR
	timeout     $TIMEOUT
	max_periods $MAX_PERIODS
}

ctl.headset {
	type sco
}

pcm.a2dpd {
        type a2dpd
}

# Use headset via aoss emulation for skype.

pcm.dsp0 {
   type plug
   slave.pcm "hw_headset"
}

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

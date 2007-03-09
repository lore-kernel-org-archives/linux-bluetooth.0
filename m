Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F0CE06.3030405@redhat.com>
Date: Thu, 08 Mar 2007 22:01:26 -0500
From: Alan Conway <aconway@redhat.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45EFC3C7.2060802@redhat.com>
In-Reply-To: <45EFC3C7.2060802@redhat.com>
Content-Type: multipart/mixed; boundary="------------040602080803030704090500"
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
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040602080803030704090500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

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

cvs -d:pserver:anonymous@sbc.cvs.sourceforge.net:/cvsroot/sbc login
cvs -d:pserver:anonymous@sbc.cvs.sourceforge.net:/cvsroot/sbc co sbc
cd sbc
./bootstrap
./configure --prefix=/usr
make
sudo make install

install bstco:

cvs 
-d:pserver:anonymous@bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa 
login
cvs 
-d:pserver:anonymous@bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa 
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

[aconway@scooter plugz]$ aplay -D headset /usr/share/sounds/startup3.wav
Playing WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit Little 
Endian, Rate 44100 Hz, Stereo
aplay: set_params:909: Channels count non available

Cheers,
Alan.

--------------040602080803030704090500
Content-Type: text/plain;
 name=".asoundrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".asoundrc"

pcm.headset {
	type plug;
	slave.pcm "hw_headset";
}

pcm.hw_headset {
	@args [BDADDR TIMEOUT MAX_PERIODS]
	
	# The Bluetooth device address for target headset, used for Audio Gateway (PC) initiated connections
        # Please note that this value is ignored when the connection is Headset initiated
	@args.BDADDR {
		type string
		default "00:03:89:95:9C:83" # Put your HS address here
	}

	# This value represents how long we will try to reach the headset, until we give up.
	# Value is in milliseconds
	@args.TIMEOUT {
		type integer
		default 6000
	}

	# This is the size of the buffer used to queue Voice packets. Value must be between 
	# 2 and 334 (~ 1 second). Default value is 2 buffers, which works well most of the
        # time, and has the advantage of giving us an ultra low delay
	@args.MAX_PERIODS {		
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

--------------040602080803030704090500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------040602080803030704090500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------040602080803030704090500--

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45EFC3C7.2060802@redhat.com>
Date: Thu, 08 Mar 2007 03:05:27 -0500
From: Alan Conway <aconway@redhat.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------030103080705040308070400"
Subject: [Bluez-users] Headsetd, skype and bluetooth headsets.
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
--------------030103080705040308070400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Trying to get a plantronics 510s headset working with skype (among other 
things) and I'm tantalizingly close. Hopefully someone can help close 
the gap.

I go the headset working for input and output with headsetd and headset 
plug-in: aplay and arecord -D headset working A-OK - my .asoundrc 
attached. Then I tried aoss skype - it *almost* worked. I could hear OK 
thru the headset but my voice was weirdly distorted and unrecognizable. 
I decided to recompile off the CVS head and now nothing works I get
  ALSA lib pcm_sco.c:532:(_snd_pcm_sco_open) Unknown field max_periods

Probably I have some mish-mash of versions installed, it's too late at 
night.

So what I'd like to know to speed my quest tomorrow:
 * In CVS there are multiple headsetd and alsa-plugins under plugz, 
btsco and alsa-plugin-sco. Which is the right one?
 * Maybe the distortion indicates some transformation of sound formats 
is needed - any hints as to what it might be?
 * Is there a better way than aoss for skype? It only shows alsa 
hardware devices in it's menus, I haven't found a way to make it use a PCM.
 * Any other  tips on what might be going wrong, or better ways to 
approach this?

I'll be happy to post my solution to the list if that's useful.

Thanks,
Alan.

--------------030103080705040308070400
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

--------------030103080705040308070400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030103080705040308070400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------030103080705040308070400--

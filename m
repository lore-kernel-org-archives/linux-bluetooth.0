Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c02b565a0707181118sdc0a73x1b1f559b355373b@mail.gmail.com>
Date: Wed, 18 Jul 2007 20:18:33 +0200
From: "Crni Gorac" <cgorac@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Plantronics Explorer 350 and bluetooth-alsa
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

Am trying to utilize my Plantronics Explorer 350 headset with Skype on
my Slackware 12.0 installation.  I first provided that hcid and sdpd
are started upon system boot (is any other daemon needed?), and the
compiled current CVS versions of sbc and plugz acoording to
instructions from http://bluetooth-alsa.sourceforge.net/build.html.
Then I created /etc/asound.conf with following contents (given MAC is
of my headset, obtained from hcitool scan output):

###
pcm.headset {
        @args [BDADDR TIMEOUT]

        # The Bluetooth device address for target headset, used for
Audio Gateway (PC) initiated connections
        # Please note that this value is ignored when the connection
is Headset initiated
        @args.BDADDR {
                type string
                default "00:03:89:F5:FB:F6"
        }

        # This value represents how long we will try to reach the
headset, until we give up.
        # Value is in milliseconds
        @args.TIMEOUT {
                type integer
                default 6000
        }

        type        sco
        bdaddr      $BDADDR
        timeout     $TIMEOUT
}

ctl.headset {
        type sco
}
###

Furhter, I started headsetd manually, and am not trying to have
something played on headset trough:
  mplayer -ao alsa:device=headset /opt/Skype/sounds/CallRingingIn.wav

However, I'm receiving following error reported:
alsa-lib: pcm_sco.c:277:(sco_headset_hw_params) Unable to set number
of SCO buffers : please upgrade your Kernel !
alsa-init: unable to set hw-parameters: Invalid argument
Could not open/initialize audio device -> no sound.

Is this because I haven't applied the sco-flowcontrol kernel patch
from plugz/patches directory?  But I'm running latest 2.6.22.1 kernel,
and an error is reported on one of kernel source files when the patch
applied against this kernel (and - what's the status of this patch
anyway, is it going to be included in stock kernel soon or not?)...
Further - do I need CONFIG_BT_SCO option enabled in kernel or not?

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

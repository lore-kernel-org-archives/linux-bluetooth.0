Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex Holland <ah160@york.ac.uk>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1071931390.2102.34.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] Problem with stability - Belkin F8T001 with bluez+bluefw in Gentoo
 Linux
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 20 Dec 2003 14:43:10 +0000

Hi,

I've been battling to set up my Belkin USB dongle in Gentoo so I can
sync my Sony Ericsson t610 with Evolution using multisync.

However, I'm having problems with the stability of the dongle. My init
scripts load the firmware using hotplug/bluefw, then load the required
kernel modules, then bring hci0 up using hciconfig, then start hcid and
sdpd.

In this state I can see my phone on a hcitool scan, connect to it using
rfcomm, pair with it, etc. I've had little joy with multisync, but
that's a matter for another mailing list.

After some fiddling with hcitool, sdptool and multisync, any sdp related
function ceases to work. Running "sdptool browse" returns "Failed to
connect to SDP server on 00:0A:D9:3F:21:27: Connection timed out", and
l2ping loses 100% of packets.

I've tried to recover from this state by using "hciconfig down" then
"hciconfig up" or even "hciconfig reset". However, if I bring hciconfig
down (either with down or reset), I subsequently can't bring it up,
getting the following message: "Can't init device hci0. Connection timed
out(110)".

I've tried bringing hci0 down, killing all BT related processes,
unloading all relevant modules and then starting over, but it still
times out. Nothing but a reboot seems to fix it.

Any suggestions? All other USB devices on my system (keyboard, mouse,
Zip drive) work fine, so I don't think the USB subsystem is suspect. The
same dongle worked wonderfully in Windows 2000, so I'm not sure what the
problem is.

I can post copious configuration details if required.

Alex Holland



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

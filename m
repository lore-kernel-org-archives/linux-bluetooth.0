Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: David Elze <wegwerf@datenschrott.de>
To: bluez-users@lists.sourceforge.net
Date: Sun, 04 Nov 2007 17:14:25 +0100
Message-Id: <1194192865.2823.20.camel@aero64.datenschrott.de>
Mime-Version: 1.0
Subject: [Bluez-users] headset via bluetooth-headset not fully working
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

Hey, 

I'm running Debian unstable and want to do some VoIP stuff with my
HBH-PV700 (Sony Ericsson) headset over a standard bluetooth dongle
(usb).

Pretty everything works as it should: 
1. I can pair the headset correctly (hcitool, gnome bluetooth 
   manager and friends) [1]
2. I can start the headsetd via 'headsetd -n' to get its output
3. When I run 
   'aplay -Dplug:headset /usr/share/sounds/alsa/Front_Center.wav'
   the headsets does a beep, I can hear some silent noise (nothing
   like the expected sound, only background noise that is slightly
   louder than the headset normally is if there is no aplay involved)
   but not the expected sound and headsetd says [2] whereas my 
   .asoundrc looks like [3]

So everything seems to be fine: the connection does work, if I send some
sound to the headset-alsa-device it recognizes that, beeps and starts to
'sound' different then before but I just hear no sound. I increased all
audio levels via alsamixer, I put the usb-stick into another usb-port
(because I read something about problems with certain usb-hubs and
sco-like stuff) and did some strace'ing and aplay -verbose but there
were absolutely no error messages.

Maybe you guys have an idea or at least some rtfm-hint because I don't
know what to do anymore. The headset itself is working correctly, I
tested it twice with my normal cellphone.

Thanks for any hint :-)

Greetings, David

[1] 
BD Address:  xx:yy... (removed for obvious reasons)
Device Name: HBH-PV700
LMP Version: 1.1 (0x1) LMP Subversion: 0x9240
Manufacturer: Philips Semiconductors (37)
Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00
<encryption> <slot offset> <timing accuracy> <role switch> 
<sniff mode> <SCO link> <HV3 packets> <CVSD> 

[2] 
headsetd[3109]: Configuration phase ended: target bdaddr is xx:yy:...,
timeout is 6000 ms
headsetd[3109]: Changing state: Idle-->Paging
headsetd[3109]: Changing state: Paging-->Connecting
headsetd[3109]: Changing state: Connecting-->Ready
headsetd[3109]: Changing state: Ready-->Opening
headsetd[3109]: SCO channel opened handle=0x002b mtu=64
headsetd[3109]: Changing state: Opening-->Streaming
headsetd[3109]: Appli closed socket
headsetd[3109]: Changing state: Streaming-->Zombie
headsetd[3109]: Nobody uses SCO channel anymore, closing it.
headsetd[3109]: Changing state: Zombie-->Connected

[3]
pcm.headset {
        @args [BDADDR TIMEOUT]
        @args.BDADDR {
                type string
                default "xx:yy:..."
        }
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



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

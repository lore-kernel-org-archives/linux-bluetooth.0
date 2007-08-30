Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: David Geiger <lists@david-geiger.de>
To: bluez-users@lists.sourceforge.net
Date: Thu, 30 Aug 2007 15:32:20 +0200
MIME-Version: 1.0
Message-Id: <200708301532.21872.lists@david-geiger.de>
Subject: [Bluez-users] plugz: no sound playing in headset
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

Hi,

I got the current CVS version of plugz installed and headsetd running. 
However, when I try to play sound to the ALSA "headset" device, I get the 
connection beep in the headset but no sound (won't start playing) and the 
output below. Similar for A2DP.
Additionally, "headset" doesn't show up in the XMMS ALSA device dropdown list, 
I have to enter it manually.

I use SUSE 10.2 and a (paired) Plantronics PLT 510. Got it working long time 
ago with the old btsco daemon...

Can anyone help or tell me where to find additional information? Thanks!

--- In XMMS ---
Aug 30 14:54:37 blizzmo headsetd[18594]: Bluetooth headset daemon version 0.5
Aug 30 14:55:15 blizzmo headsetd[18594]: Configuration phase ended: target 
bdaddr is 00:03:89:A9:2C:C1, timeout is 6000 ms
Aug 30 14:55:15 blizzmo headsetd[18594]: Changing state: Idle-->Paging
Aug 30 14:55:15 blizzmo hcid[17457]: link_key_request (sba=00:0A:94:02:C3:0F, 
dba=00:03:89:A9:2C:C1)
Aug 30 14:55:15 blizzmo headsetd[18594]: Changing state: Paging-->Connecting
Aug 30 14:55:16 blizzmo headsetd[18594]: Changing state: Connecting-->Ready
Aug 30 14:55:16 blizzmo headsetd[18594]: Changing state: Ready-->Opening
Aug 30 14:55:16 blizzmo headsetd[18594]: SCO channel opened handle=0x002d 
mtu=64
Aug 30 14:55:16 blizzmo headsetd[18594]: Changing state: Opening-->Streaming
Aug 30 14:56:50 blizzmo headsetd[18594]: exiting cleanly

--- Similar for amarok ---
Aug 30 15:00:47 blizzmo headsetd[18772]: Bluetooth headset daemon version 0.5
Aug 30 15:00:49 blizzmo headsetd[18772]: Configuration phase ended: target 
bdaddr is 00:03:89:A9:2C:C1, timeout is 6000 ms
Aug 30 15:00:49 blizzmo headsetd[18772]: Changing state: Idle-->Paging
Aug 30 15:00:50 blizzmo hcid[17457]: link_key_request (sba=00:0A:94:02:C3:0F, 
dba=00:03:89:A9:2C:C1)
Aug 30 15:00:50 blizzmo headsetd[18772]: Changing state: Paging-->Connecting
Aug 30 15:00:50 blizzmo headsetd[18772]: Changing state: Connecting-->Ready
Aug 30 15:00:50 blizzmo headsetd[18772]: Changing state: Ready-->Opening
Aug 30 15:00:50 blizzmo headsetd[18772]: SCO channel opened handle=0x002d 
mtu=64
Aug 30 15:00:50 blizzmo headsetd[18772]: Changing state: Opening-->Streaming
Aug 30 15:00:50 blizzmo headsetd[18772]: Appli closed socket
Aug 30 15:00:50 blizzmo headsetd[18772]: Changing state: Streaming-->Zombie
Aug 30 15:00:57 blizzmo headsetd[18772]: Nobody uses SCO channel anymore, 
closing it.
Aug 30 15:00:57 blizzmo headsetd[18772]: Changing state: Zombie-->Connected
Aug 30 15:00:57 blizzmo kernel: hci_scodata_packet: hci0 SCO packet for 
unknown connection handle 45
Aug 30 15:01:04 blizzmo headsetd[18772]: exiting cleanly

--- My .asoundrc ---
pcm.headset {
	@args [BDADDR TIMEOUT]
	
	# The Bluetooth device address for target headset, used for Audio Gateway 
(PC) initiated connections
        # Please note that this value is ignored when the connection is 
Headset initiated
	@args.BDADDR {
		type string
		default "00:03:89:A9:2C:C1"
	}

	# This value represents how long we will try to reach the headset, until we 
give up.
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

# Simplest a2dpd possible
pcm.a2dpdsimple {
	type a2dpd
}

# More complex a2dpd, not yet recommended but worth a try!
# This entry allows the plugin to appear in mixer applications
# This way, the sound level can be controlled by software outside the player
# This worked very well last time! 2007-jun

pcm.a2dpd {
	type plug
	slave.pcm "a2dpdsoftvol"
}

pcm.a2dpdsoftvol {
	type softvol
	slave {
		pcm "a2dpdplug"
	}

	control {
		name "Bluetooth Headset"
		card 0
		count 1
	}
}

pcm.a2dpdplug {
	type a2dpd
}


--- hcitool info ---
Requesting information ...
        BD Address:  00:03:89:A9:2C:C1
        Device Name: PLT  510
        LMP Version: 1.2 (0x2) LMP Subversion: 0x958
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbc 0xe8 0x01 0x00 0x18 0x18 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <sniff mode> <SCO link> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <AFH cap. slave> <AFH class. slave> <AFH cap. master>
                <AFH class. master>
-- 
David Geiger
lists@david-geiger.de

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

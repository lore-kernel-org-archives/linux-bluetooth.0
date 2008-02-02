Return-Path: <cyrus@holtmann.org>
Message-ID: <47A438C6.90700@gmx.de>
Date: Sat, 02 Feb 2008 10:32:54 +0100
From: Daniel Stumpner <bigstumpi@gmx.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47A274DB.9020808@gmx.de>
In-Reply-To: <47A274DB.9020808@gmx.de>
Subject: Re: [Bluez-users] BT Headset connected but no sound
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

Daniel Stumpner wrote:
> Hi,
> 
> can connect to my BT Headset but if I try to play a sound, it does only
> beep at the start and at the end of the connection but there is no sound.
> 
> mplayer -ao alsa:device=bluetooth test.wav
> - beep -
> (pressing 'q')
> - beep -
> 
> I am running Gentoo with linux 2.6.23 (x86)
> bluez-libs-3.24
> blues-utils-3.24
> 
> 
> ========================================================================
>                        Some Debug Information:
> ========================================================================
> 
> # lsusb
> Bus 002 Device 002: ID 046d:c012 Logitech, Inc. Optical Mouse
> Bus 002 Device 001: ID 0000:0000
> Bus 004 Device 001: ID 0000:0000
> Bus 003 Device 002: ID 03f0:011d Hewlett-Packard     /* Critical line */
> Bus 003 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
> 
> ------------------------------------------------------------------------
> 
> # cat /proc/bus/usb/devices | grep -e^[TPD] | grep -e Cls=e0 -B1 -A1
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=03f0 ProdID=011d Rev= 0.17
> 
> ------------------------------------------------------------------------
> 
> # hciconfig -a
> hci0:	Type: USB
> 	BD Address: 00:10:C6:F8:11:7C ACL MTU: 377:10 SCO MTU: 16:0
> 	UP RUNNING PSCAN ISCAN
> 	RX bytes:87191 acl:27 sco:1676 events:53 errors:0
> 	TX bytes:809 acl:21 sco:0 commands:30 errors:0
> 	Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> 	Link policy: RSWITCH HOLD SNIFF PARK
> 	Link mode: SLAVE ACCEPT
> 	Name: 'BlueZ (0)'
> 	Class: 0x080100
> 	Service Classes: Capturing
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.2 (0x2) HCI Rev: 0x11 LMP Ver: 1.2 (0x2) LMP Subver: 0x6963
> 	Manufacturer: Broadcom Corporation (15)
> 
> ------------------------------------------------------------------------
> 
> # hcitool info 00:0D:44:30:4B:11      /* My Logitech headset */
> Requesting information ...
> 	BD Address:  00:0D:44:30:4B:11
> 	LMP Version: 1.2 (0x2) LMP Subversion: 0x611
> 	Manufacturer: Cambridge Silicon Radio (10)
> 	Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
> 		<encryption> <slot offset> <timing accuracy> <role switch>
> 		<hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
> 		<HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
> 		<paging scheme> <power control> <transparent SCO>
> 		<AFH cap. slave> <AFH cap. master>
> 
> ------------------------------------------------------------------------
> 
> # rfcomm
> rfcomm0: 00:0D:44:30:4B:11 channel 1 clean
> 
> ------------------------------------------------------------------------
> 
> # l2ping 00:0D:44:30:4B:11
> Ping: 00:0D:44:30:4B:11 from 00:10:C6:F8:11:7C (data size 44) ...
> 44 bytes from 00:0D:44:30:4B:11 id 0 time 34.40ms
> 44 bytes from 00:0D:44:30:4B:11 id 1 time 52.72ms
> 2 sent, 2 received, 0% loss
> 
> ------------------------------------------------------------------------
> 
> # cat /etc/asound.conf
> pcm.bluetooth {
>         type bluetooth
> 	device 00:0D:44:30:4B:11
> }
> 
> ------------------------------------------------------------------------
> 
> # cat /proc/asound/cards
>  0 [ICH6           ]: ICH4 - Intel ICH6
>                       Intel ICH6 with AD1981B at irq 21
>  1 [Modem          ]: ICH-MODEM - Intel ICH6 Modem
>                       Intel ICH6 Modem at irq 19
> 
> ------------------------------------------------------------------------
> 
> # tail -f /var/log/messages    /* before executing the above mplayer
> command */
> Feb  1 00:36:25 snake audio[8329]: Accepted new client connection on
> unix socket (fd=9)
> Feb  1 00:36:25 snake audio[8329]: Audio API: received
> BT_GETCAPABILITIES_REQ
> Feb  1 00:36:25 snake audio[8329]: Audio API: sending BT_GETCAPABILITIES_RSP
> Feb  1 00:36:25 snake audio[8329]: Audio API: received
> BT_SETCONFIGURATION_REQ
> Feb  1 00:36:25 snake audio[8329]: State changed
> /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED ->
> HEADSET_STATE_CONNECT_IN_PROGRESS
> Feb  1 00:36:29 snake hcid[8156]: link_key_request
> (sba=00:10:C6:F8:11:7C, dba=00:0D:44:30:4B:11)
> Feb  1 00:36:29 snake audio[8329]: /org/bluez/audio/device0: Connecting
> to 00:0D:44:30:4B:11 channel 1
> Feb  1 00:36:30 snake audio[8329]: State changed
> /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS ->
> HEADSET_STATE_CONNECTED
> Feb  1 00:36:30 snake audio[8329]: /org/bluez/audio/device0: Connected
> to 00:0D:44:30:4B:11
> Feb  1 00:36:30 snake audio[8329]: State changed
> /org/bluez/audio/device0: HEADSET_STATE_CONNECTED ->
> HEADSET_STATE_PLAY_IN_PROGRESS
> Feb  1 00:36:30 snake audio[8329]: SCO socket opened for headset
> /org/bluez/audio/device0
> Feb  1 00:36:30 snake audio[8329]: SCO fd=11
> Feb  1 00:36:30 snake audio[8329]: Audio API: sending
> BT_SETCONFIGURATION_RSP
> Feb  1 00:36:30 snake audio[8329]: State changed
> /org/bluez/audio/device0: HEADSET_STATE_PLAY_IN_PROGRESS ->
> HEADSET_STATE_PLAYING
> Feb  1 00:36:30 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:30 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:30 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:30 snake hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 0
> Feb  1 00:36:30 snake hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 0
> Feb  1 00:36:30 snake hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 0
> Feb  1 00:36:30 snake hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 0
> Feb  1 00:36:30 snake hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 0
> Feb  1 00:36:30 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:30 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:30 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:30 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:30 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:30 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Audio API: received BT_STREAMSTART_REQ
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMSTART_RSP
> Feb  1 00:36:31 snake audio[8329]: Audio API: sending BT_STREAMFD_IND
> Feb  1 00:36:31 snake audio[8329]: Unix client disconnected (fd=9)
> Feb  1 00:36:31 snake audio[8329]: State changed
> /org/bluez/audio/device0: HEADSET_STATE_PLAYING ->
> HEADSET_STATE_DISCONNECTED
> Feb  1 00:36:31 snake hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 1
> 
> 
> ========================================================================
>                           End of debug info
> ========================================================================
> 
> 
> 
> I have no Idea where to start searching the problem...
> Somewhere I read that Broadcom Chips aren't fully supported. May I need
> firmware perhaps? Would l2ping work in this case? (In my case it DOES
> work!?)
> Quote:
> "If you have a Broadcom Chipset or Hewlett-Packard Integrated Chipset
> (such as mine on HP nx8220) then you really want to pass
> 'force_scofix=1' as argument to kernel: it was the only way to make work
> hci_usb properly with my chip. NOTE: bcm203x won't recognize HP
> Integrated as a valid chip (03f0:011d instead of 0a5c:2033 - you can
> check this with lsusb), then don't even try to make it work."
> 
> May I have an error in my alsa-config? There is no card displayed...
> 
> 
> Thanks for your time!
> Best regards, Daniel
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

Hi again,

I got new info:

this is a part of the hcid-log in my messages when I switch on my
headset. Seems that I have no Key-Agent...

#passkey-agent --help   /* tells me that I have Version 3.24 */

Do I have to set it up manually?
So I did the following:

#passkey-agent --default 0000 /* test key */

I see:
hcid[14592]: Default passkey agent (:1.41,
/org/bluez/passkey_agent_14605) registered

But the errors don't change...
What do I have to do to get my key-agent working?


Best regards, Daniel




LOG (when switching on headset):
==========================================================================
hcid[10257]: link_key_request (sba=00:10:C6:F8:11:7C, dba=00:0D:44:30:4B:11)
hcid[10257]: /org/bluez: org.bluez.Database.RequestAuthorization()
hcid[10257]: handle_authorize_request
hcid[10257]: no default agent
audio[10261]: Requesting authorization for device 00:0D:44:30:4B:11,
UUID 0000111F-0000-1000-8000-00805F9B34FB
audio[10261]: State changed /org/bluez/audio/device0:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
audio[10261]: Access denied: Authorization agent does not exist
audio[10261]: State changed /org/bluez/audio/device0:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
hcid[10257]: link_key_notify (sba=00:10:C6:F8:11:7C, dba=00:0D:44:30:4B:11)
==========================================================================

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

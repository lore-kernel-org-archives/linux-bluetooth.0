Return-Path: <cyrus@holtmann.org>
Message-ID: <480C654C.2040904@powercraft.nl>
Date: Mon, 21 Apr 2008 11:58:36 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48092EF6.3090603@powercraft.nl>	<48093316.3070906@powercraft.nl>	<alpine.LNX.1.00.0804190011000.27696@nge2.ngu.pk>	<480A5877.4080201@powercraft.nl>	<alpine.LNX.1.00.0804201637170.29306@nge2.ngu.pk>
	<480C5D72.6090001@powercraft.nl>
In-Reply-To: <480C5D72.6090001@powercraft.nl>
Subject: Re: [Bluez-users] Samsung WEP210 Bluetooth Headset
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

Jelle de Jong wrote:
> jayjwa wrote:
>> On Sat, 19 Apr 2008, Jelle de Jong wrote:
>>
>> -> So, I tried to get it working for a other 4 hours, but I can't get it to
>> -> work. Please help me, how can I get the device fully working, what am I
>> -> doing wrong here?
>> -> -> Please take a look at the logs i attached in the mail, i hope this 
>> gives
>> -> enough information for a advanced bluez users to tell me what is wrong.
>>
>> Several things stand out.
>>
>> 1.)
>>
>> First is your kernel version. Seems to be a 2.5.24.x. If you are using 
>> an SCO-only headset, the 2.6.24.x kernels will not work with it. You 
>> must either patch the kernel, or upgrade to an ESCO-able headset. This 
>> is the issue with mine. I use the patch that was on this list to patch 
>> my 2.6.24.4. The device's features should mention eSCO.
>>
>>
>> -> snapshot of my syslog >>
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Bluetooth HCI daemon
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: HCI dev 0 registered
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Starting SDP server
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Unix socket created: 12
>> -> Apr 19 21:55:55 debian-eeepc hidd[2333]: Bluetooth HID daemon
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Registered manager
>> -> path:/org/bluez/audio
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Registering service
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Unable to execute
>> -> /usr/lib/bluetooth/bluetoothd-service-audio
>>
>> 2). The file, and format of those files above is not used anymore. Now, 
>> the audio service is a plugin: /usr/lib/bluetooth/plugins/libaudio.so
>> There are no more  *.service files in /etc/bluetooth like audio.service.
>>
>>
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: HCI dev 0 up
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Device hci0 has been added
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Starting security manager 0
>> -> Apr 19 21:55:55 debian-eeepc hcid[2330]: Device hci0 has been activated
>> -> Apr 19 21:56:53 debian-eeepc hcid[2330]: link_key_request
>> -> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
>> -> Apr 19 21:56:55 debian-eeepc hcid[2330]: pin_code_request
>> -> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
>> -> Apr 19 21:56:55 debian-eeepc hcid[2330]: link_key_notify
>> -> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
>> -> Apr 19 21:56:57 debian-eeepc hcid[2330]: link_key_request
>> -> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
>> -> Apr 19 21:56:58 debian-eeepc hcid[2330]: Access denied: Not authorized
>>
>> 3.) The pin setup you used I think is old, too. The users on this list 
>> seem to use some graphical utility, but myself I've always just used 
>> auth-agent and passkey-agent from the bluez-utils src tarball.
>>
>> passkey-agent --default (pin number) (remote device address) &
>> auth-agent &
>>
>> -> Apr 19 21:56:59 debian-eeepc hcid[2330]: link_key_notify
>> -> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
>> -> Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: received
>> -> BT_GETCAPABILITIES_REQ
>> -> Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: sending
>> -> BT_GETCAPABILITIES_RSP
>> -> Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: received
>> -> BT_SETCONFIGURATION_REQ
>> -> Apr 19 21:57:18 debian-eeepc hcid[2330]: config sco - device =
>> -> 20:07:09:15:A9:5A access_mode = 2
>> -> Apr 19 21:57:20 debian-eeepc hcid[2330]: link_key_request
>> -> (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
>> -> Apr 19 21:57:22 debian-eeepc kernel: Bluetooth: SCO (Voice Link) ver 0.5
>> -> Apr 19 21:57:22 debian-eeepc kernel: Bluetooth: SCO socket layer 
>> initialized
>> -> Apr 19 21:57:24 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
>> -> for unknown connection handle 43
>> -> Apr 19 21:57:55 debian-eeepc last message repeated 10158 times
>> -> Apr 19 21:58:02 debian-eeepc last message repeated 2576 times
>> -> Apr 19 21:58:02 debian-eeepc hcid[2330]: connect(): Connection timed out
>>
>>
>> Here...
>>
>> -> Apr 19 21:58:02 debian-eeepc hcid[2330]: config failed
>> -> Apr 19 21:58:02 debian-eeepc hcid[2330]: Audio API: sending
>> -> BT_SETCONFIGURATION_RSP
>> -> Apr 19 21:58:02 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
>> -> for unknown connection handle 43
>> -> Apr 19 21:58:33 debian-eeepc last message repeated 10090 times
>> -> Apr 19 21:59:23 debian-eeepc last message repeated 16726 times
>>
>> ...and here, look like the message I used to get about the SCO/eSCO 
>> problem with 2.6.24 kernels. I'm not 100% sure that's what this is, but 
>> it looks similar.
>>
>> I'll attach setup info and the previously posted esco patch, if you find 
>> you do need it. Other than these things mentioned here, I'm not sure 
>> what the problem could be.
>>
> 
> Thank you so much for the quality information:
> 
> I setup my system again and followed your steps i only used my own 
> simple -agent because the passkey-agent is not available in debian sid.
> 
> The device nicely connects goes to voice mode and than crashes because 
> it's a SCO only device.
> 
> sudo hcitool info 20:07:09:15:A9:5A
> Requesting information ...
>      BD Address:  20:07:09:15:A9:5A
>      Device Name: Samsung WEP210
>      LMP Version: 2.0 (0x3) LMP Subversion: 0xbf9
>      Manufacturer: Cambridge Silicon Radio (10)
>      Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
>          <encryption> <slot offset> <timing accuracy> <role switch>
>          <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
>          <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
>          <paging scheme> <power control> <transparent SCO>
>          <AFH cap. slave> <AFH cap. master>
> 
> If i understand correctly i have to recompile my kernel to get the 
> device working. This is not a sustainable solution for me, so i want to 
> go with a better solution.
> 
> Where can I find a list of eSCO capable headsets so that i get "out of 
> the box support"
> 
> Will the SCO only capable device be supported again? They worked in the 
> past but the community has decided to remove the support? How and why 
> did this happen?
> 

Just to be sure:

http://en.wikipedia.org/wiki/Bluetooth

So if a headset follows the Bluetooth 1.0 and 1.0B and 1.01 specs is 
uses SCO Links and is not native supported.

If the headset follows Bluetooth 1.2 and above it should have eSCO link 
capabilities.

The description of the seller of my Samsung WEP210 described my headset 
as Bluetooth specification: Ver 2.0. However I can't find specification 
on the Samsung website about the headset. I can only assume that the 
description of the seller is wrong.

Kind regards,

Jelle





-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

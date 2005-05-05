Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <427A6875.8060804@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] dongle manufacturers
References: <4277B273.3010706@gmx.ch> <1115152035.8496.15.camel@pegasus>	 <427898EC.7040200@gmx.ch> <1115200453.8496.80.camel@pegasus>
In-Reply-To: <1115200453.8496.80.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 05 May 2005 20:39:49 +0200

Hello Marcel

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>>>I just bought two SiliconWave bt1.2 USB Dongles (Anycom and arp datacon).
>>>>
>>>>What's the supportstate of SiliconWave?
>>>
>>>if it is the ROM version then all of them return the wrong inquiry with
>>>RSSI event. I have a kernel workaround for that ready, but it is not
>>>public at the moment.
>>
>>how do I know if it's the rom version?
> 
> 
> what does "hciconfig hci0 version features" tells you.

hci1:   Type: USB
         BD Address: 00:0B:0D:05:8A:19 ACL MTU: 120:20 SCO MTU: 64:0
         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
         Manufacturer: Silicon Wave (11)


         Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                 <enhanced iscan> <interlaced iscan> <interlaced pscan>
                 <AFH cap. slave> <AFH class. slave> <AFH cap. master>
                 <AFH class. master>


>>they are pretty new, maybee that's already fixed.
> 
> 
> Actually I doubt it. However you set the inquiry mode to 1 and check by
> yourself the size of the returned inquiry result events.

sorry to ask again, you didn't answer:
interested in the hciconfig -a and proc/usb of these two new dongles?


regards
Marco


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

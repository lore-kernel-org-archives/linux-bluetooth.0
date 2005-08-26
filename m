Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050826053506.11947.qmail@web30304.mail.mud.yahoo.com>
From: Brian Muramatsu <fhobia@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] No SCO Mapping? No Link Key Reply?
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
Date: Thu, 25 Aug 2005 22:35:06 -0700 (PDT)

Hello all,

I have a Motorola HS805 headset that I would like to
use with a Thinkpad T43 with built-in Broadcom
Bluetooth Module.
(http://www.thinkwiki.org/wiki/IBM_Integrated_Bluetooth_IV_with_56K_Modem_%28BMDC-3%29)

I've installed btsco and the snd_bt_sco module without
problems according to the Bluetooth-Alsa website;
however, I have run into several problems when trying
to enable the headset: 

1. My revision output does not contain any SCO
Mapping. Instructions for btsco say that if I don't
have this then I need a new dongle! The headset works
fine in the redmond os on the same computer though, is
this a problem with usb 2.0 (referred to by the btsco
instructions), bluez, or is this integrated bluetooth
card really a dud for this situation?

Here is my revision output so  far:
# hciconfig hci0 features revision version         
hci0:   Type: USB
        BD Address: 00:0E:9B:D9:88:E8 ACL MTU: 377:10
SCO MTU: 16:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00
0x00
                <3-slot packets> <5-slot packets>
<encryption> <slot offset> 
                <timing accuracy> <role switch> <hold
mode> <sniff mode> 
                <RSSI> <channel quality> <SCO link>
<HV2 packets> 
                <HV3 packets> <u-law log> <A-law log>
<CVSD> <power control> 
                <transparent SCO> <enhanced iscan>
<interlaced iscan> 
                <interlaced pscan> <AFH cap. slave>
<AFH cap. master> 
        Firmware 9.105 / 99
        HCI Ver: 1.2 (0x2) HCI Rev: 0x9 LMP Ver: 1.2
(0x2) LMP Subver: 0x6963
        Manufacturer: Broadcom Corporation (15)

(Note no "SCO MAPPING"... :( Is there basically no way
to enable the mapping?)

2. I can query my headset to get its bdaddr using
hcitool only during pairing mode, and I see the
following in the hcidump output:

> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0B:2E:33:9E:4B
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 6 bdaddr 00:0B:2E:33:9E:4B type
ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Read Local Version I

So it seems to be timing out without a link key reply,
but I'm not sure why this is happening...I have the
typical pin script echoing the pin, but alas, I'm not
sure if this is related. Do you have any ideas?

Thank you,
-Brian

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

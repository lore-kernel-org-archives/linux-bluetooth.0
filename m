Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <439845E1.3010206@rambler.ru>
From: Pavel Fedin <sonic_amiga@rambler.ru>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ISSC IVT USB dongle
References: <43982224.6020208@rambler.ru> <1134044091.3752.87.camel@blade>	 <43982BAC.2030508@rambler.ru> <1134047622.3752.89.camel@blade>	 <43983410.5010701@rambler.ru> <1134049860.3752.96.camel@blade>
In-Reply-To: <1134049860.3752.96.camel@blade>
Content-Type: text/plain; charset=KOI8-R; format=flowed
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
Date: Thu, 08 Dec 2005 17:40:33 +0300

Marcel Holtmann wrote:

> please post the output of "hciconfig -a" and "lsusb".

  Ok, here it is:

  --- cut ---
[root@fedin media]# lsusb
Bus 004 Device 002: ID 1131:1001 Integrated System Solution Corp.
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000
  --- cut ---
[root@fedin media]# hciconfig -a
hci0:   Type: USB
         BD Address: 00:11:67:0C:6F:B8 ACL MTU: 678:8 SCO MTU: 48:10
         UP RUNNING PSCAN ISCAN
         RX bytes:4106 acl:83 sco:0 events:205 errors:0
         TX bytes:2457 acl:101 sco:0 commands:50 errors:0
         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'fedin.vostok.ru-0'
         Class: 0x120104
         Service Classes: Networking
         Device Class: Computer, Desktop workstation
         HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x1f4
         Manufacturer: Integrated System Solution Corp. (57)
  --- cut ---

> Make sure that hcid is running. Normally this is done by an init script.

  Thank you very much, i really disabled BlueTooth in rc.d a long time ago (since i didn't expect to 
ever start using it here). This output was produced after i enabled and started the service.

  Kind regards.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource
	temporarily unavailable
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051219120021.91668.qmail@web36101.mail.mud.yahoo.com>
References: <20051219120021.91668.qmail@web36101.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1134993904.31688.6.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 19 Dec 2005 13:05:04 +0100

Hi Swathi,

> My headset is in the pairing mode. Now i am getting a
> different set of message for the hcitool info. I tried
> executing this command many times. But still get the
> same message(below one). I no more get the previous
> msg which contained BD address and the Device name.
> 
> Output obtained are as below
> 
> hcitool info 00:08:C6:3E:54:2C
> ========================================================
> Requesting information ...
> Can't create connection: Connection timed out
> ========================================================
> 
> hcidump -X -V
> ========================================================
> HCI sniffer - Bluetooth packet analyzer ver 1.28
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
> clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:08:C6:3E:54:2C
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x22 handle 41 bdaddr 00:08:C6:3E:54:2C
> type ACL encrypt 0x00
>     Error: LMP Response Timeout
> =======================================================

make sure that hcid is running. Check the syslog for output about the
PIN helper if it still fails.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

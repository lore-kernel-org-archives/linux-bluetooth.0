Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource
	temporarily unavailable
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051219094442.64827.qmail@web36106.mail.mud.yahoo.com>
References: <20051219094442.64827.qmail@web36106.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1134986417.24233.4.camel@localhost>
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
Date: Mon, 19 Dec 2005 11:00:17 +0100

Hi Swathi,

> As per your request i have attached the "hcidump -X -V" output when i
> execute the command "btsco 00:08:C6:3E:54:2C 2"
> 
> output of hcidump -X -V
> =====================================================
> HCI sniffer - Bluetooth packet analyzer ver 1.18
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
> Read Voice Setting (0x03|0x0025) ncmd 1
> status 0x00 voice setting 0x0060
> < HCI Command: Create Connection (0x01|0x0005) plen 13
> bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
> Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: PIN Code Request (0x16) plen 6
> bdaddr 00:08:C6:3E:54:2C
> > HCI Event: Connect Complete (0x03) plen 11
> status 0x22 handle 41 bdaddr 00:08:C6:3E:54:2C type ACL encrypt 0x00
> E rror: LMP Error Transaction Collision
> =====================================================
> 
> I hope i will be able to get a solution for this.

what does "hciconfig -a" and "hcitool info ..." say? What version of
bluez-utils and bluez-hcidump do you use?

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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource
	temporarily unavailable
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051220100816.22612.qmail@web36115.mail.mud.yahoo.com>
References: <20051220100816.22612.qmail@web36115.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1135080141.5236.45.camel@localhost>
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
Date: Tue, 20 Dec 2005 13:02:21 +0100

Hi Swathi,

> Few of the information requested by you as well as
> some of the things which  i thought might be helpful
> for debugging.
> 
> ==============================================================
> hcid daemon is running on my system. 
> 
> [root@localhost /]# /etc/init.d/bluetooth status
> hcid (pid 2794) is running...
> sdpd (pid 2798) is running...
> ==============================================================
> [root@localhost /]# btsco 00:08:C6:3E:54:2C -v -r
> btsco v0.4c
> Device is 1:0
> Error: Failed to connect to SDP server: Function not
> implemented
> Assuming channel 2
> Voice setting: 0x0060
> Can't connect RFCOMM channel: Resource temporarily
> unavailable
> 
> What does it mean when it says "Function not
> implemented" ?
> ==============================================================
> 
> [root@localhost /]# hcidump -X -V
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
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
>     Read Voice Setting (0x03|0x0025) ncmd 1
>     status 0x00 voice setting 0x0060
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
> clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:08:C6:3E:54:2C
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x22 handle 42 bdaddr 00:08:C6:3E:54:2C
> type ACL encrypt 0x00
>     Error: LMP Response Timeout
> ==============================================================

according to the dump, it is not running. Did you start hcid as root,
because it needs root rights to deal with the authentication.

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

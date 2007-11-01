Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: smohan@vsnl.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4729B5FE.9020600@vsnl.com>
References: <4729B5FE.9020600@vsnl.com>
Date: Thu, 01 Nov 2007 13:14:36 +0100
Message-Id: <1193919276.6641.40.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Auth failure
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

Hi Mohan,

> When I try to create a connection with my headset, it fails due to auth.
> Key is 0000.
> 
> Sniffer Output:
> ---------------
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>       bdaddr 00:0B:2E:39:31:3F ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>       Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>   > HCI Event: Command Status (0x0f) plen 4
>       Create Connection (0x01|0x0005) status 0x00 ncmd 1
>   > HCI Event: Link Key Request (0x17) plen 6
>       bdaddr 00:0B:2E:39:31:3F
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>       bdaddr 00:0B:2E:39:31:3F key 6A49558AB5A9CD2C856AD475DC632E9C
>   > HCI Event: Command Complete (0x0e) plen 10
>       Link Key Request Reply (0x01|0x000b) ncmd 1
>       status 0x00 bdaddr 00:0B:2E:39:31:3F
>   > HCI Event: Connect Complete (0x03) plen 11
>       status 0x05 handle 12 bdaddr 00:0B:2E:39:31:3F type ACL encrypt 0x00
>       Error: Authentication Failure
> 
> See some key value being sent here. How do I decipher the key value? How
> do I set the key value? Passkey agent is registered but I do not know
> which/where the agent is. Gutsy std.

the passkey agent has nothing to do with it at this point. It seems you
already paired it before. So use the Bluetooth properties to delete that
bonding or better switch your headset into pairing mode.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

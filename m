Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multiple connections between USB dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <94e407f00603150040p3baf9d54o54a9a93cd58b874a@mail.gmail.com>
References: <94e407f00603090536g6e039055tad50e96bf5be8ea9@mail.gmail.com>
	 <1141917840.4605.36.camel@aeonflux.holtmann.net>
	 <94e407f00603150040p3baf9d54o54a9a93cd58b874a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1142599823.4392.16.camel@localhost>
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
Date: Fri, 17 Mar 2006 13:50:23 +0100

Hi Arpit,

> This is what the hcidump returns
> 
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:10:60:B3:2D:04 ptype 0xcc18 rswitch 0x01 clkoffset
> 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x0c ncmd 1
>     Error: Command Disallowed

and what does "hciconfig hci0 revision" tells you about the firmware
version. Maybe they only support two ACL links at a time.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

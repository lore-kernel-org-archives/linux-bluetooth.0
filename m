Return-Path: <rfoster@mountainvisions.com.au>
Subject: Re: [Bluez-users] bluez-utils 2.7 and bthid
From: Robert Foster <rfoster@mountainvisions.com.au>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084177906.9269.129.camel@pegasus>
References: <1084160685.3287.2.camel@rover.mountainvisions.com.au>
	 <1084177906.9269.129.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084181491.3559.2.camel@rover.mountainvisions.com.au>
Mime-Version: 1.0
Date: Mon, 10 May 2004 19:31:32 +1000
List-ID: <bluez-users.lists.sourceforge.net>

Update: I received the PIN prompt...

This time, before I tried to connect, I pushed the Connect Channel
button on the bottom of the mouse:

hcidump:

< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: PIN Code Request(0x16) plen 6
< HCI Command: PIN Code Request Negative Reply(0x01|0x000e) plen 6
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11

system log:
May 10 19:27:08 rover hcid[2098]: link_key_request
(sba=00:20:E0:85:06:49, dba=00:50:F2:E5:B5:57)
May 10 19:27:08 rover hcid[2098]: pin_code_request
(sba=00:20:E0:85:06:49, dba=00:50:F2:E5:B5:57)
May 10 19:27:13 rover bthid[3374]: Connection failed: Invalid exchange
(52)

Rob.

On Mon, 2004-05-10 at 18:31, Marcel Holtmann wrote:
> Hi Robert,
> 
> > bthid does not seem to play nicely with the recently released
> > bluez-utils 2.7.  Every time I tried to connect to my MS mouse, it would
> > ask for a pin code.  I had to uninstall bluez-{utils|libs} 2.7 and
> > revert back to the 2.6 release before this problem would go away again.
> 
> I haven't seen such problem. Do you enabled auth or encrypt in your
> hcid.conf? Look with hcidump at the connection setup and show it to us.
> 
> Regards
> 
> Marcel
> 
> 

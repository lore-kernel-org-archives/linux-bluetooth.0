Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BCSP problem
From: Erwin Authried <eauth@softsys.co.at>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <BAY104-F40DFDF64BCF0100D83487BC18A0@phx.gbl>
References: <BAY104-F40DFDF64BCF0100D83487BC18A0@phx.gbl>
Content-Type: text/plain
Message-Id: <1105654294.3361.25.camel@kabel>
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
Date: Thu, 13 Jan 2005 23:11:35 +0100

On Thu, 2005-01-13 at 18:01, blookk - wrote:
> Hello:
> 
> I am working with CompactFlash Bluetooth BT0100M, and when I make some data 
> tranference or operations  as hciattach or other operations  I obtain these 
> warnings:
> 
> 
> bcsp_recv: Short BCSP packet
> bcsp_recv: Error in BCSP hdr checksum
> bcsp_recv: Error in BCSP hdr checksum
> bcsp_timed_event: Timeout, retransmitting 1 pkts
> bcsp_recv: Short BCSP packet
> bcsp_recv: Error in BCSP hdr checksum
> bcsp_recv: Error in BCSP hdr checksum
> bcsp_recv: Out-of-order packet arrived, got 0 expected 5
> bcsp_timed_event: Timeout, retransmitting 1 pkts
> bcsp_unslip_one_byte: Invalid byte a8 after esc byte
> bcsp_recv: Out-of-order packet arrived, got 3 expected 2
> bcsp_recv: Out-of-order packet arrived, got 4 expected 2
> bcsp_recv: Out-of-order packet arrived, got 5 expected 2
> bcsp_timed_event: Timeout, retransmitting 1 pkts
> 
> 
> Is there any form to modify the timeout?
> How can manage this?
> 
> Thanks and regards.
> 
That looks like you get overrun errors in the serial driver. You can
check /proc/tty/driver/ if there are overrun errors. I don't know your
particular card, but generally PCMCIA/CF cards do no have a real uart
and can send data far beyond the specified baudrate. I had to modify the
serial driver as well as hci_bcsp.c to get rid of the errors for an
embedded system (ARM7,40MHz).

Regards,
Erwin




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F40DFDF64BCF0100D83487BC18A0@phx.gbl>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Bluez-users] BCSP problem
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
Date: Thu, 13 Jan 2005 17:01:13 +0000


Hello:

I am working with CompactFlash Bluetooth BT0100M, and when I make some data 
tranference or operations  as hciattach or other operations  I obtain these 
warnings:


bcsp_recv: Short BCSP packet
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_timed_event: Timeout, retransmitting 1 pkts
bcsp_recv: Short BCSP packet
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Out-of-order packet arrived, got 0 expected 5
bcsp_timed_event: Timeout, retransmitting 1 pkts
bcsp_unslip_one_byte: Invalid byte a8 after esc byte
bcsp_recv: Out-of-order packet arrived, got 3 expected 2
bcsp_recv: Out-of-order packet arrived, got 4 expected 2
bcsp_recv: Out-of-order packet arrived, got 5 expected 2
bcsp_timed_event: Timeout, retransmitting 1 pkts


Is there any form to modify the timeout?
How can manage this?

Thanks and regards.




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

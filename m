Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F11D4725B89F5B0701A79B8C18B0@phx.gbl>
In-Reply-To: <1105654294.3361.25.camel@kabel>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BCSP problem
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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
Date: Fri, 14 Jan 2005 09:03:15 +0000

Hello Erwin:

What changes have you done in hci_bcsp.c?
Could be the error in wait_states in serial driver?

I change the timeout to 1 HZ but the problem continue.

Regards.

&gt;From: Erwin Authried &lt;eauth@softsys.co.at&gt;
&gt;Reply-To: bluez-users@lists.sourceforge.net
&gt;To: bluez-users@lists.sourceforge.net
&gt;Subject: Re: [Bluez-users] BCSP problem
&gt;Date: Thu, 13 Jan 2005 23:11:35 +0100
&gt;
&gt;On Thu, 2005-01-13 at 18:01, blookk - wrote:
&gt; &gt; Hello:
&gt; &gt;
&gt; &gt; I am working with CompactFlash Bluetooth BT0100M, and when I make 
some data
&gt; &gt; tranference or operations  as hciattach or other operations  I 
obtain these
&gt; &gt; warnings:
&gt; &gt;
&gt; &gt;
&gt; &gt; bcsp_recv: Short BCSP packet
&gt; &gt; bcsp_recv: Error in BCSP hdr checksum
&gt; &gt; bcsp_recv: Error in BCSP hdr checksum
&gt; &gt; bcsp_timed_event: Timeout, retransmitting 1 pkts
&gt; &gt; bcsp_recv: Short BCSP packet
&gt; &gt; bcsp_recv: Error in BCSP hdr checksum
&gt; &gt; bcsp_recv: Error in BCSP hdr checksum
&gt; &gt; bcsp_recv: Out-of-order packet arrived, got 0 expected 5
&gt; &gt; bcsp_timed_event: Timeout, retransmitting 1 pkts
&gt; &gt; bcsp_unslip_one_byte: Invalid byte a8 after esc byte
&gt; &gt; bcsp_recv: Out-of-order packet arrived, got 3 expected 2
&gt; &gt; bcsp_recv: Out-of-order packet arrived, got 4 expected 2
&gt; &gt; bcsp_recv: Out-of-order packet arrived, got 5 expected 2
&gt; &gt; bcsp_timed_event: Timeout, retransmitting 1 pkts
&gt; &gt;
&gt; &gt;
&gt; &gt; Is there any form to modify the timeout?
&gt; &gt; How can manage this?
&gt; &gt;
&gt; &gt; Thanks and regards.
&gt; &gt;
&gt;That looks like you get overrun errors in the serial driver. You can
&gt;check /proc/tty/driver/ if there are overrun errors. I don't know your
&gt;particular card, but generally PCMCIA/CF cards do no have a real uart
&gt;and can send data far beyond the specified baudrate. I had to modify the
&gt;serial driver as well as hci_bcsp.c to get rid of the errors for an
&gt;embedded system (ARM7,40MHz).
&gt;
&gt;Regards,
&gt;Erwin
&gt;
&gt;
&gt;
&gt;
&gt;-------------------------------------------------------
&gt;The SF.Net email is sponsored by: Beat the post-holiday blues
&gt;Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
&gt;It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
&gt;_______________________________________________
&gt;Bluez-users mailing list
&gt;Bluez-users@lists.sourceforge.net
&gt;https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

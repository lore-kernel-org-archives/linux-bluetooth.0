Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F195C4A108FE44E68C67ADEC18A0@phx.gbl>
In-Reply-To: <1105640823.7961.238.camel@pegasus>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BCSP problem
Mime-Version: 1.0
Content-Type: text/html; charset=iso-8859-1; format=flowed
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
Date: Thu, 13 Jan 2005 21:02:34 +0000

<html><div style='background-color:'><DIV class=RTE>
<P>Hello Marcel:</P></DIV>
<P>I do not have problems with the tools, but when I make a ftp connection over Bluetooth and send a file, I obtain all this BCSP warnings and the transmision is very slowly, the transmision only reachs 5 Kbytes/s. <BR>(I make this connection with pand tool, and the interface bnep)</P>
<P>Other cuestion, Why the device expected 2 packets, for example, and got more than 2 packets?. This occur in the warning like this:&nbsp;&nbsp;bcsp_recv: Out-of-order packet arrived, got 5 expected 2 </P>
<P>Thanks for your help.</P>
<P>Regards.</P>
<DIV></DIV>&gt;From: Marcel Holtmann &lt;marcel@holtmann.org&gt;
<DIV></DIV>&gt;Reply-To: bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;To: BlueZ Mailing List &lt;bluez-users@lists.sourceforge.net&gt;
<DIV></DIV>&gt;Subject: Re: [Bluez-users] BCSP problem
<DIV></DIV>&gt;Date: Thu, 13 Jan 2005 19:27:03 +0100
<DIV></DIV>&gt;
<DIV></DIV>&gt;Hi,
<DIV></DIV>&gt;
<DIV></DIV>&gt; &gt; I am working with CompactFlash Bluetooth BT0100M, and when I make some data
<DIV></DIV>&gt; &gt; tranference or operations&nbsp;&nbsp;as hciattach or other operations&nbsp;&nbsp;I obtain these
<DIV></DIV>&gt; &gt; warnings:
<DIV></DIV>&gt; &gt;
<DIV></DIV>&gt; &gt;
<DIV></DIV>&gt; &gt; bcsp_recv: Short BCSP packet
<DIV></DIV>&gt; &gt; bcsp_recv: Error in BCSP hdr checksum
<DIV></DIV>&gt; &gt; bcsp_recv: Error in BCSP hdr checksum
<DIV></DIV>&gt; &gt; bcsp_timed_event: Timeout, retransmitting 1 pkts
<DIV></DIV>&gt; &gt; bcsp_recv: Short BCSP packet
<DIV></DIV>&gt; &gt; bcsp_recv: Error in BCSP hdr checksum
<DIV></DIV>&gt; &gt; bcsp_recv: Error in BCSP hdr checksum
<DIV></DIV>&gt; &gt; bcsp_recv: Out-of-order packet arrived, got 0 expected 5
<DIV></DIV>&gt; &gt; bcsp_timed_event: Timeout, retransmitting 1 pkts
<DIV></DIV>&gt; &gt; bcsp_unslip_one_byte: Invalid byte a8 after esc byte
<DIV></DIV>&gt; &gt; bcsp_recv: Out-of-order packet arrived, got 3 expected 2
<DIV></DIV>&gt; &gt; bcsp_recv: Out-of-order packet arrived, got 4 expected 2
<DIV></DIV>&gt; &gt; bcsp_recv: Out-of-order packet arrived, got 5 expected 2
<DIV></DIV>&gt; &gt; bcsp_timed_event: Timeout, retransmitting 1 pkts
<DIV></DIV>&gt; &gt;
<DIV></DIV>&gt; &gt;
<DIV></DIV>&gt; &gt; Is there any form to modify the timeout?
<DIV></DIV>&gt; &gt; How can manage this?
<DIV></DIV>&gt;
<DIV></DIV>&gt;do you have any functional problems with this card? In general you can
<DIV></DIV>&gt;ignore these messages, because BCSP is able to correct mostly every
<DIV></DIV>&gt;error. I am a little bit worried about the esc byte and hdr error,
<DIV></DIV>&gt;because we haven't seen this so far.
<DIV></DIV>&gt;
<DIV></DIV>&gt;Regards
<DIV></DIV>&gt;
<DIV></DIV>&gt;Marcel
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;-------------------------------------------------------
<DIV></DIV>&gt;The SF.Net email is sponsored by: Beat the post-holiday blues
<DIV></DIV>&gt;Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
<DIV></DIV>&gt;It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
<DIV></DIV>&gt;_______________________________________________
<DIV></DIV>&gt;Bluez-users mailing list
<DIV></DIV>&gt;Bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;https://lists.sourceforge.net/lists/listinfo/bluez-users
<DIV></DIV></div></html>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

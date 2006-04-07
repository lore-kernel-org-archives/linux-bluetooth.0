Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <44367EEE.708@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sniff & pand
References: <Pine.LNX.4.64.0603181246420.738@data.home> <Pine.LNX.4.64.0604020439250.738@data.home> <20060406200923.M10379@cos.ufrj.br>
In-Reply-To: <20060406200923.M10379@cos.ufrj.br>
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 07 Apr 2006 16:02:06 +0100

Alexandre Coser Monteiro wrote:
> < HCI Command: ogf 0x02, ocf 0x0003, plen 9
>  06 10 00 00 10 FF F7 00 07
> > HCI Event: 0x0f plen 4
> 12 01 03 08               

The Command Status event shows error code 0x12 = Invalid HCI Command
Parameters.

This means that the controller didn't like one of the parameters to the
sniff mode command.

The sniff mode command you gave had the parameters:

   Connection handle:  0x1006
   Sniff Max Interval: 0x0000
   Sniff Min Interval: 0xff10
   Sniff Attempts:     0x00f7
   Sniff Timeout:      0x??07

Notes:

  The connection handle is invalid. The valid range is 0x0000..0x0eff

  The maximum interval is invalid. The valid range is 0x0002..0xfffe

  The minimum interval is invalid. The valid range is 0x0002..max
  interval.

  The sniff attempts is highly unusual (but not actually invalid).

  The sniff timeout field is truncated, it should be two bytes.

So, it's not surprising that the controller is rejecting it.

Where is the sniff mode command being generated? How is it getting
through the BlueZ APIs to generate such an invalid event? Are the
normal APIs being bypassed and is a raw command being sent.

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

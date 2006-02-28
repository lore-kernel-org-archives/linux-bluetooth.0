Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sniff traffic between PDA and Phone
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060227175719.GX9328@zanu.org.uk>
References: <20060227175719.GX9328@zanu.org.uk>
Content-Type: text/plain
Message-Id: <1141112251.29374.4.camel@localhost>
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
Date: Tue, 28 Feb 2006 08:37:31 +0100

Hi Nick,

> I'm trying to capture bluetooth traffic between my PDA and mobile
> phone for diagnostic purposes:
> 
> I have a Palm TX PDA and Samsung Z500 phone. If I try to use GRPS over
> bluetooth (actually 3G, but it works the same) ppp connects and I am
> given an IP address and DNS servers. If I try to send any traffic, the
> packets are not sent. I can't ping the DNS servers for example.
> 
> If I change the phone for a different brand then it works fine, and if
> I change the PDA for a different model it works fine. Just those two
> together don't work. I've borrowed a different Z500 just in case mine
> was faulty, but the same problem. The other one had a slightly newer
> ROM too so this isn't something they have fixed.
> 
> I'm trying to find out if it is my phone or PDA that is a
> problem. Right now, Samsung blames Palm, and Palm blames Samsung. My
> carrier (Orange) blames them both, and would charge me a lot of money
> to change phone :-(
> 
> I hoped that I could use hcidump to see if the Palm TX actually sends
> packets, and if so, to compare them with what the Palm T3 sends. Can
> I tell hcidump and my Bluetooth dongle to capture ALL traffic, not
> just traffic going to/from the dongle?

for this you need a sniffer like the dongle and software from Frontline.
The hcidump can sniff only local traffic. It is not an air sniffer.

However it might be true that both are at fault, but from the first
guess I would blame Samsung not implemented the SDP records right. It
might be wrong, but they don't really have a good record of getting
these things right. Check the mailing list archive. On the other hand
some of the earlier Palm devices were also really bad and unreliable.
However I have no idea if this was Palm faults or a fault of the
Broadcom chip they used.

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

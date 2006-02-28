Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Nicholas Piper <nick@nickpiper.co.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Sniff traffic between PDA and Phone
Message-ID: <20060228084152.GB9328@zanu.org.uk>
References: <20060227175719.GX9328@zanu.org.uk> <1141112251.29374.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1141112251.29374.4.camel@localhost>
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
Date: Tue, 28 Feb 2006 08:41:53 +0000

Marcel,

Thank you for your comments.

On Tue, 28 Feb 2006, Marcel Holtmann wrote:

> > I have a Palm TX PDA and Samsung Z500 phone. If I try to use GRPS over
> > bluetooth (actually 3G, but it works the same) ppp connects and I am
> > given an IP address and DNS servers. If I try to send any traffic, the
> > packets are not sent. I can't ping the DNS servers for example.

> for this you need a sniffer like the dongle and software from Frontline.
> The hcidump can sniff only local traffic. It is not an air sniffer.

They appear to cost over 10 000 dollars? A bit too much to help fix my
phone trouble :-( I looked at http://www.fte.com/bpa07.asp

> However it might be true that both are at fault, but from the first
> guess I would blame Samsung not implemented the SDP records right. It
> might be wrong, but they don't really have a good record of getting
> these things right. Check the mailing list archive. On the other hand
> some of the earlier Palm devices were also really bad and unreliable.
> However I have no idea if this was Palm faults or a fault of the
> Broadcom chip they used.

I AM able to pair the devices, exchange items via obex, and even use
it as a LAN access point at get an IP address. Just after the network
is 'up' according to both devices, I can't ping or resolve anything
from the PDA. Does this still indicate SDP records being wrong?

 Nick

-- 
Nick Piper, Developer, LogicaCMG           http://www.nickpiper.co.uk/
GPG Encrypted mail welcome!                             1024D/3ED8B27F
Choose life. Be Vegan :-) Please reduce needless cruelty + suffering !


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

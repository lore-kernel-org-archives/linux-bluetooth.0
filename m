Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] IPv6 Bluez and Router Advertissement
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=E9r=F4me?= LECOMTE <lecomte@celar.fr>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <410E51C9.1020401@celar.fr>
References: <410E51C9.1020401@celar.fr>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1091478399.12594.131.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 02 Aug 2004 21:26:39 +0100

On Mon, 2004-08-02 at 16:38 +0200, Jérôme LECOMTE wrote:
> With a sniffer, router sollicication are going well from the slave to 
> the router but router advertisement (with ipv6 prefix) can't go through 
> Bluetooth links (sniffer on slaves shows that) and I don't understand why.
> Experience about this would be welcome

Is radvd definitely trying to send advertisements on the interface in
question? Are these part of a bridge on which radvd is configured to
broadcast, or is radvd configured to use each bnep device separately?

IPv6 autoconfig over BNEP is working fine for me. When used with Linux
bridging, I have to send a SIGHUP to radvd after adding the first BNEP
device to the bridge; otherwise radvd thinks the MAC address is all
zeroes and it doesn't work.

If that's not it, give more precise details of your setup, and tcpdump
from both ends. If radvd isn't sending the packets you want, look there
to find out why. If it _is_ and you're not seeing them at the other end,
I'll be surprised.

-- 
dwmw2




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092305447.24961.1169.camel@baroque.rococosoft.com>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092305447.24961.1169.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1092306354.28711.88.camel@pegasus>
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
Date: Thu, 12 Aug 2004 12:25:54 +0200

Hi Steve,

> > I am not an expert when it comes to specific compiler stuff and I can't
> > make the best decision with my limited information. What I realized is
> > that we need our own unaligned access implementation, because we can't
> > rely on the asm/unaligned.h. So I started to put our own in bluetooth.h
> > for general access. If this was wrong, please correct me.
> 
> I don't think this is wrong, in the absence of a system-supplied one.
> This is the basic problem if you ask me: <asm/unaligned.h> _should_ be a
> user-space header file (provided by glibc or something) because
> unaligned access _is_ something that people who write network programs
> need.

I must agree, but it seems that nobody provides a generic include for
unaligned access. So we don't have a choise at the moment :(

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

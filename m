Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092397956.10618.102.camel@hades.cambridge.redhat.com>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092306935.15466.74.camel@hades.cambridge.redhat.com>
	 <1092308407.28711.99.camel@pegasus>
	 <1092310391.15466.178.camel@hades.cambridge.redhat.com>
	 <1092311388.28711.117.camel@pegasus>
	 <1092312127.15466.211.camel@hades.cambridge.redhat.com>
	 <1092317787.28711.150.camel@pegasus>
	 <1092384465.4186.37.camel@imladris.demon.co.uk>
	 <1092387952.28711.217.camel@pegasus>
	 <1092397956.10618.102.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1092400824.28711.226.camel@pegasus>
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
Date: Fri, 13 Aug 2004 14:40:24 +0200

Hi David,

> I was overriding CFLAGS when I invoked make, because otherwise other
> stuff (like -m32) gets omitted. Can we do this in acinclude.m4?
> 
> -	CFLAGS="-Wall -O2"
> +	if (test "${CFLAGS}" = ""); then
> +		CFLAGS="-Wall -O2"
> +	fi
> +

I was thinking of something like that, but actually never included it
until now. Fix is in CVS for libs, utils and hcidump.

> OK. I think I'm not supposed to ship a cvs snapshot -- I have to wait
> for 2.10. But I've isolated just the patch in question and added it into
> the bluez-utils-2.9-2 RPM, with the above change to inherit CFLAGS if
> they're already set.

I will use memmove for unaligned access and release libs and utils
tomorrow or the day after tomorrow. I like to test your unaligned code a
little bit more before making a release with it.

> > I did it this way, but there were reports of Sparc platforms where the
> > resulting binary should be run-tested.
> 
> Hmmm. Can I revise my original answer.... don't. If the user asks for
> it, do it. Else don't.
> 
> Random behavioural changes based on the characteristics of the system we
> _happen_ to build on today are probably a bad thing. Just build as
> configured and don't try to auto-adapt to _anything_ :)

Don't worry. You still have to use --enable-pie to activate it even if
configure finds out that the compile supports it.

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

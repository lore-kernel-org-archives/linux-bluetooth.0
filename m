Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085044520.28151.1256.camel@hades.cambridge.redhat.com>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
	 <1084382445.25099.77.camel@pegasus>
	 <1084382743.4426.351.camel@hades.cambridge.redhat.com>
	 <1084382951.25099.89.camel@pegasus>
	 <1084383201.4426.374.camel@hades.cambridge.redhat.com>
	 <1084383929.25099.94.camel@pegasus>
	 <1085044520.28151.1256.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1085044833.4327.132.camel@pegasus>
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
Date: Thu, 20 May 2004 11:20:34 +0200

Hi David,

> OK, I've moved pand, dund and hidd into separate init scripts for
> Fedora. 
> 
> Updated bluez-* RPMS for FC2/ppc are in my yum repository at
> ftp://ftp.uk.linux.org/pub/people/dwmw2/fc2-mac/ (for i386 you'll want
> to rebuild them from the SRPMS which are also there). I'll probably push
> those as updates for FC2 too.

many thanks for that.

Besides these, have you checked the Bluetooth CUPS backend, which is
also included in bluez-utils-2.7?

> In fact, I suspect that the right answer for pand is to tie it into the
> initscripts and system-config-network, so you add an interface of type
> 'PAN slave' or 'PAN master' and the network scripts handle starting and
> stopping the daemon like they do ipppd, rather than doing it from a SysV
> init script. I haven't used dund so I'm less sure about that but it
> might also be the right approach there.

I am not a Fedora Core user, so I can't answer this question, but in
general it is up to you to decide.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

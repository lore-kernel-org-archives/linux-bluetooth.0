Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Code questions
From: zze-COLBUS Emmanuel RD-MAPS-GRE <emmanuel.colbus@rd.francetelecom.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1109027849.7626.38.camel@pegasus>
References: <1108566885.11909.29.camel@g-necml5-146.rd.francetelecom.fr>
	 <1109027849.7626.38.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1109175241.4458.40.camel@g-necml5-146.rd.francetelecom.fr>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 23 Feb 2005 17:14:01 +0100

Hello,

>[...] 

Thank you for the previous answers, now the stack has become clearer to
me :) .

> 
> > - I've noticed the same for other events (that they were not treated).
> > Are they also just masked away, and, if yes, were in the code do this
> > masking happens?
> 
> Explain what you mean.

I was especially thinking about the hardware_error event : I haven't
found any place were he was handled. Is it masked away, ignored, or
treated, and, if yes, where in the code?

Regards,

Emmanuel

-- 
Please don't care about this useless mail signature:

M. Emmanuel Colbus de l'ENSIMAG intervenant à FTRD/MAPS/AMS du 01/02/05 
au 30/06/05 sous la responsabilité de M. Tahar Jarboui dans le cadre 
d'un stage de fin d'études.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

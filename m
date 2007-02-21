Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45DC675F.8010508@access-company.com>
References: <45DB19E9.5080709@access-company.com>
	<1172059615.7403.7.camel@violet> <45DC675F.8010508@access-company.com>
Date: Wed, 21 Feb 2007 16:51:15 +0100
Message-Id: <1172073075.7403.37.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] pan profile sdp record
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

> >> There are several issues to the problem :
> >> - patching pand is easy but some more options are needed to customize 
> >> fields (unless good defaults exists)
> >>     
> >
> > we need good default values and some extra parameters to change them. I
> > am all for this way.
> >   
> 
> What about this patch then?

looks good, but ...

Why do we need add_lang_attr(). This is actually not mandatory as far as I remember.

Do we have to make name and description configurable. Do you need it?

The security_desc should be automatically determined from the actually -E, -A or -S parameters.

The network access type and rate make sense to me. However I prefer if we simply hand them over via parameters instead of creating another struct.

> I still have a modified rfcomm man page, so I put it together...

Please separate patches.

> Also, Olivier from access once submitted a dev-down patch. As the patch 
> has not been adopted I was wondering if something could be mde better or 
> if it was just missed ?

I was actually sure that I didn't miss any patches, but that can
happens. Simply re-send it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

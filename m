Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45DC766D.1000903@access-company.com>
References: <45DB19E9.5080709@access-company.com>
	<1172059615.7403.7.camel@violet> <45DC675F.8010508@access-company.com>
	<1172073075.7403.37.camel@violet> <45DC766D.1000903@access-company.com>
Date: Wed, 21 Feb 2007 17:57:36 +0100
Message-Id: <1172077056.7403.40.camel@violet>
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

> >> What about this patch then?
> >>     
> >
> > looks good, but ...
> >
> > Why do we need add_lang_attr(). This is actually not mandatory as far as I remember.
> >
> > Do we have to make name and description configurable. Do you need it?
> >
> > The security_desc should be automatically determined from the actually -E, -A or -S parameters.
> >
> > The network access type and rate make sense to me. However I prefer if we simply hand them over via parameters instead of creating another struct.
> >
> >   
> lang, name, description are all mandatory attributes. I'm not sure if 
> their actually must have a language in the list.
> I have no specific requirement according to their values yet.
> Using a struct allows to make name and desc configurable without adding 
> new parameters and forwarding from function to function.
> 
> So two choices remains :
> - keeping only the sdp.c part is enough to conform the spec.
> - Doing everything and making all values configurable is quick (but the 
> option letters will be strange ;) ).

for an initial patch, I think we only change sdp.c with appropriate
default values to make it specification conform. The configurable has to
wait and maybe we only do that in the new network service. In general
the daemon should autodetect these values from the interface or the
bridge (not that I know how at the moment).

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

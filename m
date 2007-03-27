Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 27 Mar 2007 15:01:48 +0100
References: <200701150326.46855.bluez-devel@huitl.de>
	<200703271139.42015.Tim.Chick@csr.com>
	<46091D10.7070809@access-company.com>
In-Reply-To: <46091D10.7070809@access-company.com>
MIME-Version: 1.0
Message-Id: <200703271501.49792.chick@computergeek.freeserve.co.uk>
Subject: Re: [Bluez-devel] a2dpd and mplayer - any chance to get it working?
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

On Tuesday 27 March 2007 14:33, Frederic Dalleau wrote:
> > It looks like this stuff is in flux at the moment?
>
> Well, some people reported it works, some said it don't, but to me,
> it works.
>
> > I am using CVS from last night, and I see basically 100% CPU usage
> > from a2dpd, with mpg321 and mplayer whilst it is streaming.
> >
> > This is running on a 400MHz ARM based system, so there should be
> > plenty of CPU available.
>
I also tried a2dpd2, and this "only" took 50% of the CPU.

> Try a2dpd -g to get traces, to see possible errors.
> Is the sound ok ? 


Yes.

> Does it do 100% when there is no stream?
No.

> Could you try it on pc?
>
Yes, but I don't see how that helps :-)

Cheers,
Tim


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

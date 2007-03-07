Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 7 Mar 2007 00:42:13 +0000
References: <9da483cb0703061450i78cbaf95ibc797d27486f5beb@mail.gmail.com>
	<200703062308.06182.chick@computergeek.freeserve.co.uk>
	<CE5216C10C83944D9FD37B65CD33F3970CF481@mplex01.mpl.access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF481@mplex01.mpl.access-company.com>
MIME-Version: 1.0
Message-Id: <200703070042.14210.chick@computergeek.freeserve.co.uk>
Cc: Frederic Dalleau <Frederic.Dalleau@access-company.com>
Subject: Re: [Bluez-devel] Success with current cvs and amarok
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

On Wednesday 07 March 2007 00:24, Frederic Dalleau wrote:
> > > I just wanted to report a near 100% success with amarok and the
> > > current cvs bluez, to the point where its working to switch songs and
> >
> > If you are using a CSR based headset it will bend the pitch if the input
> > queue is getting too full or empty. So the headset doesn't like the data
> > timing.
>
> Hi, I believe (I hope) Mike is talking about a2dp which is digital and so
> the pitch can not be modified. But it is possibly a bug in the timing. Are
> there some traces that could be related to the moment where you feel the
> pitch change?

I was talking about a2dp as well - the headset will shift the pitch to correct 
buffer problems, using the built in dsp!

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

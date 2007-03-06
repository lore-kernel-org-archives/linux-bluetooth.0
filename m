Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 6 Mar 2007 23:08:05 +0000
References: <9da483cb0703061450i78cbaf95ibc797d27486f5beb@mail.gmail.com>
In-Reply-To: <9da483cb0703061450i78cbaf95ibc797d27486f5beb@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200703062308.06182.chick@computergeek.freeserve.co.uk>
Cc: Mike Hodson <mystica@gmail.com>
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

On Tuesday 06 March 2007 22:50, Mike Hodson wrote:
> I just wanted to report a near 100% success with amarok and the
> current cvs bluez, to the point where its working to switch songs and
> everything. :)
>
> The one thing I think I may not have noticed before, mostly due to the
> music i was testing with: techno/dance music. I think there is a very
> slight timing / pitch change every now and then.  However ,as i
> mentioned I do listen to dance music a lot and i honestly thought it
> was part of the dj mixing. :)
>
If you are using a CSR based headset it will bend the pitch if the input queue 
is getting too full or empty. So the headset doesn't like the data timing.

Thanks,
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

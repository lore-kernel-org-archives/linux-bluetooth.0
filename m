Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 19 Feb 2007 23:28:16 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070219212816.GA13138@jh-mbp>
References: <45D4FB7F.6090301@unternet.org>
	<1171591223.7583.33.camel@aeonflux.holtmann.net>
	<45DA01EC.4050007@unternet.org> <1171917193.26567.51.camel@violet>
	<45DA144F.1090506@unternet.org>
MIME-Version: 1.0
In-Reply-To: <45DA144F.1090506@unternet.org>
Subject: Re: [Bluez-devel] sdpd in polling loop on disconnect
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

Hi Frank,

On Mon, Feb 19, 2007, Frank de Lange wrote:
> Marcel Holtmann wrote:
> >> Attached: patch for sdpd (adds G_IO_HUP|G_IO_ERR to watched conditions 
> >> on g_io_channels)
> > 
> > thanks for the patch, but that should be already fixed in the CVS. Johan
> > found this during the UPF testing last week.
> 
> Even better. Did he also check the other watchers for similar problems? 
> As said there are several of them which only look for G_IO_IN events.

I tried to check all places that used g_io_add_watch so hopefully there 
shouldn't be any issues left. Feel free to check the CVS though as it's 
not impossible that I've missed some place.

Johan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

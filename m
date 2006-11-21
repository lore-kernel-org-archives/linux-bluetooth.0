Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <490dd6310611210554j161ce00fkc38437d4c81beaf8@mail.gmail.com>
Date: Tue, 21 Nov 2006 13:54:13 +0000
From: "Andy Spencer" <andy753421@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1163672851.5169.20.camel@localhost>
MIME-Version: 1.0
References: <490dd6310611152339s2d7a0cfs1db1518317637cf6@mail.gmail.com>
	<1163672851.5169.20.camel@localhost>
Subject: Re: [Bluez-devel] WiiMote driver
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

Just some follow-up. I got a wiimote today and did a little bit of
looking around at it, It does seems to support HID, however I'm not
entirely sure how to use it yet. I put up a wiki at
http://spenceal-3.student.rose-hulman.edu/wiimote/ with some
additional information I got off of it.

On 11/16/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andy,
>
> > I've been thinking about purchasing a WiiMote when they become
> > available in order to start working on a linux mouse driver for it.
> > Since it communicates using bluetooth this seems to be the most
> > appropriate place to do development. Anyway, I've never done much with
> > bluetooth or drivers before so I'm going at this as a bit of a
> > learning project. If anyone else is interested let me know.  I'll be
> > reading though source code, but if anyone has any suggestions about
> > where to start or what documentation to check out let me know that as
> > well.
>
> it depends a little bit on which profile(s) they actually support. My
> guess would be it is HID or AVRCP.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

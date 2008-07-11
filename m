Return-Path: <cyrus@holtmann.org>
From: "Heston James - Cold Beans" <heston.james@coldbeans.co.uk>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
References: <486BD582.9050004@aircable.net>	<1215757212.9744.13.camel@californication>	<00de01c8e32e$213a9fb0$63afdf10$@james@coldbeans.co.uk>
	<1215765115.9744.24.camel@californication>
In-Reply-To: <1215765115.9744.24.camel@californication>
Date: Fri, 11 Jul 2008 09:34:35 +0100
Message-ID: <00e201c8e330$f9f3d0e0$eddb72a0$@james@coldbeans.co.uk>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] CreateBonding while periodic scanning
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

> with the normal inquiry it is this way. You have to cancel that before
> you can do anything else. Nothing you can do about it. The periodic
> inquiry is special since it is meant to cancel itself on connection
> attempts and then automatically resume.

Ok, that's fair enough, at least I know what the score is now. Periodic
sounds like my best solution then.

> I applied that patch and it will be in bluez-utils-3.36 release.

Excellent stuff.

Cheers Marcel,

Heston


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
From: Marcel Holtmann <marcel@holtmann.org>
To: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200309171334.24526.bluez-devel@schaettgen.de>
References: <20030915221624.GA17085@bougret.hpl.hp.com>
	<200309161740.31300.bluez-devel@schaettgen.de>
	<1063755937.29942.12.camel@pegasus>
	<200309171334.24526.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1063990341.29941.129.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 19 Sep 2003 18:52:15 +0200

Hi Fred,

> > > I'm not sure if this question goes in the same direction, but what
> > > happened to the idea of a general purpose rfcomm-inetd, which also sets
> > > up sdp records for its clients? Maybe I'm not really up-to-date, and I
> > > didn't find too much about it in the archives.. is there one already?
> >
> > this makes no sense, because the SDP records are application (or call it
> > profile) specific. And the SDP infos should be coded in the application
> > itself and not in any master daemon.
> 
> I already have something like that working, but its a KDE daemon that runs 
> under the user account of the current user. An application can specify a sdp 
> record as an xml file, leaving the rfcomm channel attribute variable. The 
> server looks for a free rfcomm port and sets up the sdp record for each 
> application/registration file with the proper rfcomm channel. Of course this 
> won't be flexible enough for some applications, but it makes life easier if 
> you want a small daemon with a custom profile. Otherwise people are much more 
> tempted to hardcode rfcomm channels for small applications.
> I don't see why this shouldn't make any sense, but as long as there is no 
> demand it's not worth the effort of course.

you don't got my point, because you are talking about two different
thinks. An inetd like daemon must know of the SDP records when it is
listening on the RFCOMM channels, because it must advertise them first
before another device can detect this service and make use of it. What
you are running is a wrapper for SDP record registration and RFCOMM
listen/accept commands.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

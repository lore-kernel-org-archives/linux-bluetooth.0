Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
From: Marcel Holtmann <marcel@holtmann.org>
To: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200309161740.31300.bluez-devel@schaettgen.de>
References: <20030915221624.GA17085@bougret.hpl.hp.com>
	<1063712005.22723.27.camel@pegasus>
	<1063717418.3674.276.camel@hades.cambridge.redhat.com>
	<200309161740.31300.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1063755937.29942.12.camel@pegasus>
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
Date: 17 Sep 2003 01:45:31 +0200

Hi Fred,

> I'm not sure if this question goes in the same direction, but what happened to 
> the idea of a general purpose rfcomm-inetd, which also sets up sdp records 
> for its clients? Maybe I'm not really up-to-date, and I didn't find too much 
> about it in the archives.. is there one already?

this makes no sense, because the SDP records are application (or call it
profile) specific. And the SDP infos should be coded in the application
itself and not in any master daemon.

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

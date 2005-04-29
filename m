Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] mpg123 to the rescue of a2snk.c
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050428123014.50396.qmail@web8307.mail.in.yahoo.com>
References: <20050428123014.50396.qmail@web8307.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1114768235.8836.48.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Apr 2005 11:50:35 +0200

Hi Mayank,

> Can we make use of mpg123 in a similar way as we used
> it in the a2play application earlier on ??
> 
> I mean, if we decode the sbc packets and put them
> somewhere, for instance stdout, and then make mpg123
> play those decoded samples, will it be more audible ?

how should this work? The mpg123 reads MP3 files and not PCM streams.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050428121002.81723.qmail@web8309.mail.in.yahoo.com>
References: <20050428121002.81723.qmail@web8309.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1114768274.8836.50.camel@pegasus>
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
Date: Fri, 29 Apr 2005 11:51:14 +0200

Hi Mayank,

> > Maybe we should change the SBC encoding routines so
> > that it times how
> > long it needed to encode the resulting SBC frame.
> > Together with the
> > known time of the PCM data the SBC frame is encoded
> > for, we can
> > calculate the actual time for the usleep() in
> > a2play.
> 
> I think this is the best idea. But again some timing
> mismatch is bound to take place because of different
> CPU speeds. For instance the CPU on which we calculate
> the time taken for the encoding, may be different on
> which we are running our a2play application...

the best idea would be to use RTC as timing source.

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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050429142532.2760.qmail@web8302.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] mpg123 to the rescue of a2snk.c
To: bluez-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Fri, 29 Apr 2005 15:25:32 +0100 (BST)


We can use some other player instead of mpg123.


--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mayank,
> 
> > Can we make use of mpg123 in a similar way as we
> used
> > it in the a2play application earlier on ??
> > 
> > I mean, if we decode the sbc packets and put them
> > somewhere, for instance stdout, and then make
> mpg123
> > play those decoded samples, will it be more
> audible ?
> 
> how should this work? The mpg123 reads MP3 files and
> not PCM streams.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> SF.Net email is sponsored by: Tell us your software
> development plans!
> Take this survey and enter to win a one-year sub to
> SourceForge.net
> Plus IDC's 2005 look-ahead and a copy of this survey
> Click here to start! 
> http://www.idcswdc.com/cgi-bin/survey?id=105hix
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

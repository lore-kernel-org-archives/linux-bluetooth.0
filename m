Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexandros Karypidis <karypid@inf.uth.gr>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] JSR-82 Implementation
References: <1092427728.5708.1.camel@localhost.localdomain> <1092650525.19596.1222.camel@baroque.rococosoft.com> <1092657726.3452.77.camel@localhost.localdomain>
In-Reply-To: <1092657726.3452.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Message-Id: <200408161547.34493.karypid@inf.uth.gr>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 16 Aug 2004 15:47:30 +0300

You might also have a look at:

https://sourceforge.net/projects/avetanabt/

OBEX stuff is missing (we're working on wrapping around libopenobex) and 
will come around some time this fall.

Also, keep in mind that is J2SE/BlueZ based. So if you're using some 
sort of J2ME implementation for Linux, it won't work, complaining about 
missing classes...

On Monday 16 August 2004 15:02, Erik Tews wrote:

> Am Mo, den 16.08.2004 schrieb Stephen Crane um 12:02:
> > > Is there currently any implementation of the jsr-82 standard for
> > > linux, so that I can use bluetooth from my java-application? Or
> > > for any other (free) desktop-operating system? I have seen one
> > > for serial bluetooth dongels on linux (but I got only usb ones)
> > > and for Windows XP. Are there any other ones.
> >
> > You didn't mention whether it had to be free software or not
> > (however maybe your email address makes this unnecessary :-)
> >
> > Anyway Rococo has one which is free (as in beer) for students and
> > hobbyists. Have a look here:
> > http://www.rococosoft.com/products/impronto.html
>
> Well, free as in freedom would be better, but free beer is ok too.
>
> I think the sdk is what I was looking for, because I would like to
> know if my java-application is able to talk to a real world device.
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank
> Media 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only
> $33 Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 
In theory, there is no difference between theory and practice. In 
practice, there is. -- Yogi Berra.

Alexandros Karypidis
UTH, Computer & Communications Eng. dept.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

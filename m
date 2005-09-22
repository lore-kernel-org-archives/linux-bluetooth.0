Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <74d0deb30509220424ef67b06@mail.gmail.com>
From: pHilipp Zabel <philipp.zabel@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid: memory alignment problems on arm
In-Reply-To: <1127382235.5344.6.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <74d0deb3050921035545e2a33d@mail.gmail.com>
	 <1127336002.23006.0.camel@blade>
	 <74d0deb305092202185bd2308b@mail.gmail.com>
	 <1127381721.5344.4.camel@blade> <1127382235.5344.6.camel@blade>
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
Date: Thu, 22 Sep 2005 13:24:31 +0200

Hi Marcel,

> > is the attached patch also working for you? I think it is better to use
> > the D-Bus specific types.

It does work exactly the same as mine.
I still don't see pin request messages on the system message bus,
but  the alignment issues are gone.

thanks
--
Philipp


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

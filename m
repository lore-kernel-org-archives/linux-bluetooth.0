Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4210B13D.9080209@symlabs.com>
From: Antonio Navarro <antonio.navarro@symlabs.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Re: btsco
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
Date: Mon, 14 Feb 2005 15:10:05 +0100

  Hi Dave,

  I had an error similar to yours. It was due to the fact that version 1.7 of automake was not
looking into /usr/share/aclocal, but instead it was using /usr/local/share/aclocal. I was having
the same error as you, and got around it by symlinking 
/usr/local/share/aclocal -> /usr/share/aclocal

HTH

Antonio Navarro

>Hi Dave,
> 
> > I think the docs a pretty good, it just would help a bit if they made
> > reference to where the dependent packages could be downloaded from.
> 
> maybe we should adjust the names according to the distribtuion, because
> all of them tend to name development packages different.
> 
> > Wih my problem specifically, alsa-devel-1.0-6.8 is installed, so I"m not
> > sure what the problem is.
> 
> The alsa-devel package contains /usr/share/aclocal/alsa.m4 and so
> everything should work.
> 
> Regards
> 
> Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth filesystem integration
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1265464416.20050928201649@andric.com>
References: <1127865130.15926.18.camel@panic>
	 <1127899309.14281.7.camel@bluez.bueche.ch>
	 <1127899931.5321.16.camel@localhost.localdomain>
	 <1265464416.20050928201649@andric.com>
Content-Type: text/plain
Message-Id: <1128012314.30743.25.camel@localhost.localdomain>
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
Date: Thu, 29 Sep 2005 18:45:14 +0200

Hi Dimitry,

> > do you have any thoughts how the directory structure of this filesystem
> > should look like. Let's discuss how we design it.
> 
> Maybe it's nice to look at how the KDE bluetooth project has
> implemented this.  They already overlay some sort of 'virtual'
> filesystem on top of Konqueror, which is similar to:
> 
> bluetooth root
>    device1
>      service1
>      service2
>      ...
>    device2
>    device3
>    ...
> 
> etc.  See for instance:

the important thing is to thing about multiple local adapters. We have
to deal with it no matter what.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

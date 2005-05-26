Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05052614222118e70c@mail.gmail.com>
References: <1115901694.18499.32.camel@pegasus>
	 <Pine.LNX.4.33.0505121821020.3523-100000@redbean.intranet.gw-instruments.de>
	 <e1effdeb0505201404d05e818@mail.gmail.com>
	 <1116844053.30044.59.camel@pegasus>
	 <e1effdeb050523080216e96744@mail.gmail.com>
	 <1116925644.30044.140.camel@pegasus>
	 <e1effdeb050525152067a5cbd3@mail.gmail.com>
	 <1117098491.12036.23.camel@pegasus>
	 <e1effdeb05052614222118e70c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1117143615.12036.74.camel@pegasus>
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
Date: Thu, 26 May 2005 23:40:15 +0200

Hi Claudio,

> 1. Glib
> I will fix it. I found another approach using dbus main loop function.

perfect.

> 2. libbridge
> It should be removed. It is not being used at the momment.  I will fix
> the Makefile.am
> But in the the future, I would suggest provide automatic bridge creation.
> Using libbridge it's possible create bridge and add bnep interfaces.

I am not against it, but I think we need to make it optional. Does it
make sense to put that into pand or leave it in the client?

> 3. Coding style
> sorry, I try do my best. I am not familiar with linux kernel coding style.

Maybe you wanna read the paper from Greg KH on the BlueZ page. We will
sort that out later.

> 4. PThread 
> I will remove Posix Thread code.

We don't really need threads.

> I will send another patch until next monday.

Keep up the good work.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050530154229f338a2@mail.gmail.com>
References: <1115901694.18499.32.camel@pegasus>
	 <Pine.LNX.4.33.0505121821020.3523-100000@redbean.intranet.gw-instruments.de>
	 <e1effdeb0505201404d05e818@mail.gmail.com>
	 <1116844053.30044.59.camel@pegasus>
	 <e1effdeb050523080216e96744@mail.gmail.com>
	 <1116925644.30044.140.camel@pegasus>
	 <e1effdeb050525152067a5cbd3@mail.gmail.com>
	 <1117098491.12036.23.camel@pegasus>
	 <e1effdeb05052614222118e70c@mail.gmail.com>
	 <1117143615.12036.74.camel@pegasus>
	 <e1effdeb050530154229f338a2@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1117494345.7072.235.camel@pegasus>
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
Date: Tue, 31 May 2005 01:05:45 +0200

Hi Claudio,

> I am sending a new patch to be evaluated.
> Regarding glib dependency we need discuss this
> subject again. If you see the hcid code, there is a
> file (glib-ectomy.c) that implements the event
> processing, this code is a partial copy of glib.
> 
> What do you prefer? Repeat the glib-ectomy.c code
> or use glib?

the glib-ectomy is only still there, because I was too lazy to replace
it with a clean main loop using poll() implementation.

> For Maemo, glib is not problem. It is included in
> the SDK.

This is not a valid argument. Creating a massive dependency chain is
always bad. Using Glib inside bluez-utils is no option.

> Regarding pthread I put two versions to be evaluated:
> 1. using pthread
>    In my opinion because it save memory.
>    http://www.indt.org.br/maemo/bluez/bluez-dbus-thread.diff
>    
> 2. using fork
>    In my opinion this is not a feasible approach
>    because when listening is active two process 
>    will be running(a listening and another processing
>    D-Bus messages).
>    http://www.indt.org.br/maemo/bluez/bluez-dbus-fork.diff

Even without looking at the patches, I don't like any of it. I like to
see a nice main loop and then using poll(). We don't need threads or
forking out processes.

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

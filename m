Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BT-Sco
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A75ABD.2050605@suche.org>
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>
	 <20041123033429.132bf84b.henryk@ploetzli.ch>
	 <41A2B331.4010001@xmission.com>
	 <20041123070621.50569968.henryk@ploetzli.ch>
	 <41A3471C.4000602@xmission.com>
	 <20041123203836.046fb4f4.henryk@ploetzli.ch>
	 <41A3ACE2.4030501@xmission.com>  <41A74FE0.6020006@suche.org>
	 <1101481147.6514.10.camel@pegasus>  <41A75ABD.2050605@suche.org>
Content-Type: text/plain
Message-Id: <1101489555.6514.22.camel@pegasus>
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
Date: Fri, 26 Nov 2004 18:19:15 +0100

Hi Thomas,

> For the current version the size is to large but i thought of extending 
> the source to allow multiple Headsets.
> Than it does not grow much since it already use an record and no static 
> variables.

actually your record is global. And here again are again some comments
about coding. Defines and constants are in upper case, but not variable
names. So SND is the wrong name. This is C and not C++ or Jave and so
sSound is also a wrong. Use only lower case names and separate them with
a underscore.

> >Don't use {{{ and include some newlines. Actually follow the kernel
> >coding style.
> >  
> >
> The {{{ i use for folding marks they can be replaced with { same as with 
> }}} and }.

Really bad coding style.

> >Why do you rewrite the function from libbluetooth and libasound. Simply
> >use them, because these are shared library and they are loaded anyway.
> >  
> >
> 1. What function of libbluetooth ? The only bluetooth function in wich 
> would be useable is geting
> the local mac and the remove channel and string2adress conversion. wich 
> is in no relation to the
> size the binary would grow.

The first thing is that these function are for easy handling of address
conversion and so use them. What you do is totally ugly. And what about
the size? How do you link the library? It is a dynamic library.

>  With the same ground you could ask why i 
> rewrite the asound part.
> Here the ground is even more interesting.
> 1. I save many file open / close
> 2. It run faster
> 3. If the sound device support async io or even only signaling if there 
> are new mixer data it can be done without
> poll.

I don't know enough about the ALSA part, but actually your way is not
portable enough. The ALSA people may change interals, but they will keep
the API and so this is the way to go. If you think the ALSA library is
doing something wrong, then get in touch with them and clean it up.

> The ground i rewrite the original was so that i can use these code more 
> easy to add it so other programms like kphone
> and use the button with switch sco on/off for accepting phone calls.

You can write whatever code you want and use it, but from a maintainer
perspective I will never add such code. And I don't see any problems
with linking some extra libraries.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

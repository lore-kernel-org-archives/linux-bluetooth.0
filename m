Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300708170715g47102e93u36fa55c21bd6ddd7@mail.gmail.com>
Date: Fri, 17 Aug 2007 08:15:33 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187359379.6698.388.camel@violet>
MIME-Version: 1.0
References: <46C088D7.9000108@silicom.fr> <46C57BA5.5000400@free.fr>
	<1187348439.6698.369.camel@violet> <46C58673.70201@free.fr>
	<5C8C496C-7E67-4DCD-A579-20E1256FA5E0@nokia.com>
	<1187354654.9447.6.camel@ubuntu.mpl.access-company.com>
	<E3D0E085-FDE6-4BA0-97D4-3720ABB5880C@nokia.com>
	<7635988F-7113-477C-B33E-30E10DF56140@nokia.com>
	<1187358839.6257.28.camel@ubuntu.mpl.access-company.com>
	<1187359379.6698.388.camel@violet>
Subject: Re: [Bluez-devel] New A2DP support : HOWTO ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

> > Oh I see, then there is no need to write a pulseaudio specific plugin.
>
> we might have to do this for latency purposes. We don't wanna copy our
> audio data around. While it would work on the desktop, on an embedded
> device it would be overkill.

it is a little scary to think that the pulse daemon which takes up to
8% of my laptop's cycles when *idle* might be embedded. Fortunately
they did just change their threading model in a devel branch.
Hopefully the change completely removes the need for them to be
polling from a single mainloop.

I do still like the idea of a native pulse plugin. I think they will
get it right.

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

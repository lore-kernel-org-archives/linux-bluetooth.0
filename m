Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071410118.5988.8.camel@bluez.bueche.ch>
References: <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus> <20031204085314.GA1780@smartdata.ch>
	 <1071001915.13464.33.camel@bluez.bueche.ch>
	 <20031209224217.GE26896@smartdata.ch>
	 <1071043970.8979.5.camel@bluez.bueche.ch>
	 <20031210083002.GG26896@smartdata.ch>
	 <1071330995.4307.27.camel@bluez.bueche.ch>
	 <1071333541.27252.177.camel@pegasus>
	 <1071341513.4307.36.camel@bluez.bueche.ch>
	 <1071342247.1548.6.camel@pegasus> <1071410118.5988.8.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1071411737.4356.56.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 14 Dec 2003 15:22:17 +0100

Hi Charles,

> Now, my mouse isn't jumpy at all anymore. The only glitch left is that I
> have to press its "connect" button just after starting bthid if I want a
> link. Is there a way to get this automated ?

this shouldn't be needed, because the mouse reconnects if you start
moving it. The only thing you need is a HID server process on your host.

> I don't like to criticize about missing docs, because I have the same
> problem at my main contract as Solaris admin (too many things to do to
> write proper docs). However, bluez suffer a bit from that problem. They
> are loads of small HOWTOs, but I miss a sort of white paper to explain
> bluetooth in general. Any pointer is welcome.

If you understand german you are in the lucky position that I have
written some articles for german magazines and most of them are also
available online.

The missing of a general white paper is a good point. I have thought so
many times about writing the one and only introduction into Linux and
Bluetooth, but always the same things stopped me from doing this. The
first is that no company pays me for working on BlueZ and so we come to
the second, that my time is very limited.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

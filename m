Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43680DBC.1000409@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] addition to btsco
References: <1130887860.4889.7.camel@panic>
In-Reply-To: <1130887860.4889.7.camel@panic>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Tue, 01 Nov 2005 17:52:12 -0700

Collin

> I hacked together an addition to btsco which is totally unrelated to
> audio.
> 
> It basically converts the volume keys into X key events, so you can use
> your bluetooth headset to control presentations (slides). Is that
> something that would go into btsco? I would guess not, but if you guys
> think otherwise I'm happy to send in a patch. Otherwise I will just make
> an separate app. for just this.

That is an interesting idea. Yet another remote control protocol? We've
got at least sco, ericsson+AT, HID, AVRCP. :)

Yes, make it a separate app and we'll put support for the other
protocols in it too. We can also provide another delivery mechanism like
dbus eventually.

Brad


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

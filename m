Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP and SDP interface specification?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40718881.4050709@uni-paderborn.de>
References: <407174BC.8020503@uni-paderborn.de>
	 <1081179607.2843.9.camel@pegasus>  <40718881.4050709@uni-paderborn.de>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1081348775.8755.9.camel@pegasus>
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
Date: Wed, 07 Apr 2004 16:39:35 +0200

Hi Stefen,

> in your "btk2003_slides.pdf" (very nice) you say on page 13 "C/C++ API
> f=FCr Kommandos und Events". Where is it? I can send commands easily vi=
a
> the bluez-libs' "hci_send_cmd", but how do I get the result/event? Ok,
> I could use "hci_send_req", but that function blocks until timeout.
> Isn't there a simple way to use "hci_send_cmd" and register some kind
> of callback for the result/event? Isn't bluetooth devices
> interrupt-driven? If not, isn't there some kind of global polling and
> event dispatching instance? I thought it was the hcid.

you can poll on the HCI socket and of course you can also use the HCI
filter to look only for specific events.

> By "Glib" you mean "glib-ectomy.c" of hcid? In it's main loop it does
> "rc =3D poll(ufds, nfds, -1);". Does it wait/block forever for an event
> or what does "-1" mean? Btw, what's hcid for (except for initializing
> the device and giving it a name)?=20

I meant Glib (www.gtk.org) and the hcid is for device initialization and
it contains the security manager. And btw try "man poll" ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

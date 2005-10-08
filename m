Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Jumpy cursor with Wacom Graphire Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051008132533.GA954@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net>
Content-Type: text/plain
Message-Id: <1128778167.5212.8.camel@blade>
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
Date: Sat, 08 Oct 2005 15:29:27 +0200

Hi Robert,

> hcidump is telling me that my tablet sends packets only after six pixels
> of mouse movement or together with button events. - I suppose that some
> parameters exchanged during connection handshake are the cause.
> 
> -Who is making the connectinon? (hidp kernel module?)
> -Who can/could influence it's outcome? (hidd userspace daemon? Plays
>  hcid an important role?)
> -Has the latency thing something to do with it?
> -Which spec should I first dig into - Bluetooth or HID?

try again with patch-2.6.13-mh1 to add report mode protocol support.

> I played already around with role switching (forced, voluntary from the
> tablet, none). - Has no influence.

Forget about that. Use the default settings.

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

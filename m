Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN and kernel 2.4.26
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastian Ballmann <Crazydj@chaostal.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1088271695.29447.5.camel@espy.crazydj.de>
References: <1088271695.29447.5.camel@espy.crazydj.de>
Content-Type: text/plain
Message-Id: <1088364052.3774.67.camel@pegasus>
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
Date: Sun, 27 Jun 2004 21:20:52 +0200

Hi Bastian,

> I've got a little problem using PAN with a kernel 2.4.26.
> If I start pand I'll get the error:
> pand[698]: Bluetooth PAN daemon
> pand[698]: Failed to get L2CAP options. Invalid argument(22)
> I tried the same using kernel 2.6.7. and it works, but I have
> to use kernel 2.4, because of a wlan driver, which is not supported
> for kernel 2.6.
> I tried to l2ping the bluetooth adapter, that works and I can also 
> open a l2cap socket on that host, so l2cap works.
> I've installed the newest bluez packages and also patched the kernel
> using patch-2.4.26-mh1.gz. No effect.

this should actually not fail. Do you had any 2.4 version working? What
bluez-utils version is installed?

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

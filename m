Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Service level security for RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Fred Schaettgen <bluez-devel@schaettgen.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200410291234.49907.bluez-devel@schaettgen.de>
References: <1099024935.10164.11.camel@pegasus>
	 <1099042277.31284.438.camel@baroque.rococosoft.com>
	 <200410291234.49907.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1099051827.10164.28.camel@pegasus>
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
Date: Fri, 29 Oct 2004 14:10:27 +0200

Hi Fred,

> > > And btw, who is really interested in this feature or needs it?
> 
> Over here! I'm interested.

ok, so lets count. The KDE Bluetooth framework will be the first user :)

> I would like to integrate service level security into the meta server of 
> kdebluetooth. At the moment you can allow/disallow connections (or show a 
> confirmation popup) based on the service/rfcomm channel and on the peer 
> device address, but we can't ask for an authenticated link. Being able to use 
> service level security would allow us to force authenticated links when using 
> any service other than obex push, which should work without having to pair 
> devices first.
> IIRC I asked you to allow every user to send authentication requests a few 
> months ago, so that even programs running without root privileges can trigger 
> authentication. But then I didn't post it on the list as you told me, to let 
> other people comment on the security implications. The corresonding patch 
> changed only a single bit somewhere, but of course this solution is not very 
> conveniant. But if you want authentication to appear as a property of a 
> single rfcomm connection that's fine too, as long as a regular users are 
> allowed to use this feature. Would that be safe?

You should always remember that the authentication is per device and not
per service. You can trigger it on a per service basis, but it is still
common for the complete device.

Regards

Marcel




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

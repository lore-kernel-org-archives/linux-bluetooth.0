Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Radu Maurer <a400@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040211173519.GA6412@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de>
	 <1076451979.2777.21.camel@pegasus> <20040211151146.GA19818@mail.gmx.de>
	 <1076515215.2696.36.camel@pegasus>  <20040211173519.GA6412@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1076522006.2696.64.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 11 Feb 2004 18:53:26 +0100

Hi Radu,

> right now to compile hcidump from cvs but configure fails:
> 
> checking "for bluetooth/bluetooth.h"... (/usr/include) yes
> checking "for libbluetooth"... "no"
> configure: error: Bluetooth library not found.
>                 Please compile and install bluez-libs package.
> 
> although I do have libbluetooth.so installed in /usr/lib (package
> libbluetooth2_0.1-1_i386.deb)

you can't mix the libraries, because version 2 breaks some stuff. That's
why I prefer to use the Debian packages and install libs2 and utils2 by
hand under /opt/bluetooth.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCIemu
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <I9YCME$DFE1F4BA6EFCB5068110B7257B436297@uol.com.br>
References: <I9YCME$DFE1F4BA6EFCB5068110B7257B436297@uol.com.br>
Content-Type: text/plain
Message-Id: <1105111958.4299.102.camel@pegasus>
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
Date: Fri, 07 Jan 2005 16:32:38 +0100

Hi,

> I am trying to compile the HCIemu but
> i am having the following error messages:
> 
> hciemu.c:956: error: invalid use of
> undefined type `struct vhci_device'
> hciemu.c:958: error: invalid use of
> undefined type `struct vhci_device'
> hciemu.c:959: error: invalid use of
> undefined type `struct vhci_device'
> hciemu.c:960: error: invalid use of
> undefined type `struct vhci_device'
> hciemu.c:963: warning: implicit
> declaration of function `g_main_new'
> hciemu.c:963: error: `FALSE'
> undeclared (first use in this function)
> hciemu.c:963: warning: assignment
> makes pointer from integer without a cast
> hciemu.c:973: error: invalid use of
> undefined type `struct vhci_device'
> hciemu.c:976: error: `G_IO_IN'
> undeclared (first use in this function)
> hciemu.c:981: warning: implicit
> declaration of function `g_main_run'
> 
> should i enter anything else in the
> make command line?

install the Glib development package.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

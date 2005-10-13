Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Set D-BUS signal paths according to
	local device
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051013180202.GA24902@localhost.localdomain>
References: <20051013172036.GA24585@localhost.localdomain>
	 <e1effdeb0510131036v1ff73b7an369333a71bf0cca8@mail.gmail.com>
	 <20051013180202.GA24902@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129243900.5057.14.camel@localhost.localdomain>
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
Date: Fri, 14 Oct 2005 00:51:40 +0200

Hi Johan,

> > I didn't analized all the patch content, but I guess it's possible change
> > the signature of the functions passing the dev id instead of receive the BT
> > address and convert it.
> > 
> > What do you think?
> 
> Yes, that would also be one possibility. However, it requires some
> changes to security.c (where those functions are being called from).
> Also, if we decide to start using the device address (instead of the id)
> in the object paths, there's no point in changing the function
> parameters. Maybe Marcel has an opinion about this?

I applied your patch to get it started. However for the final solution
we should send around a string inside the hcid API that will maybe
"hci0" or also an alias. For example you can rename Ethernet interfaces
and at some point I like to rename Bluetooth HCI interfaces, too.
Internally it will still use an id number, but that is only inside the
kernel.

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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Broadcom chipset and reverse engineering
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20051014T130900-929@post.gmane.org>
References: <434E9DCE.6090402@gmx.de>
	 <1129244001.5057.17.camel@localhost.localdomain>
	 <loom.20051014T130900-929@post.gmane.org>
Content-Type: text/plain
Message-Id: <1129291016.5057.47.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 14 Oct 2005 13:56:56 +0200

Hi Benjamin,

> > since they use H:2 as transport, you should start decoding the USBsnoop
> > dumps by yourself. And yes it is legal in Germany for interop purpose.
> > 
> 
> Sorry, but I am new to Bluetooth development. I just searched some information
> about that 'H:2' transport and found out that this 'H:2' is the USB transport
> layer which is used for the physical transport of the HCI packets.
> 
> Is there any program which could decode the HCI data automatically from the USB
> data or do I have to decode every package by hand (I think there are about 6000
> packets [and yes, only my headset was connected; no other Bluetooth devices])? 
> 
> Or perhaps there is an easier way: Is there any free tool that runs under
> Windows XP (I have to use Windows because the headset only works there), which
> can dump/log/sniff the HCI packets between the USB host controller and the USB
> Bluetooth adapter?

I always did it by hand.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

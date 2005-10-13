Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcom chipset and reverse engineering
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <434E9DCE.6090402@gmx.de>
References: <434E9DCE.6090402@gmx.de>
Content-Type: text/plain
Message-Id: <1129244001.5057.17.camel@localhost.localdomain>
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
Date: Fri, 14 Oct 2005 00:53:21 +0200

Hi Benjamin,

> I am using a Broadcom chipset based USB Bluetooth dongle (Belkin F8T008)
> and I have a Logitech Mobile Pro Headset. Of course I am not able to use
> that headset with BlueZ because the Broadcom chipset is not supported.
> But it works without problems under Windows XP. I have read that the
> BlueZ developers are not able to make it work with the Broadcom chipset
> because they did not get any information about that chipset.
> So here are my questions:
> - Is it of any help if I try to log some of the USB traffic (I have
> found this program for example:
> http://sourceforge.net/projects/usbsnoop/) under my Windows XP system
> when connecting the headset and sending audio to it?
> - Is it allowed to sniff the traffic between the OS and the USB adapter
> (Is reverse engineering allowed)?

since they use H:2 as transport, you should start decoding the USBsnoop
dumps by yourself. And yes it is legal in Germany for interop purpose.

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

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] NEC usb bluetooth support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mitch <Mitch@0Bits.COM>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FE0E092.9060002@0Bits.COM>
References: <3FE0E092.9060002@0Bits.COM>
Content-Type: text/plain
Message-Id: <1071739959.3873.17.camel@pegasus>
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
Date: Thu, 18 Dec 2003 10:32:39 +0100

Hi Mitch,

> you explained the errors well in your previous email. The error (-5) is
> a EIO which is generated from the secondary config of the bluetooth device
> which is the voice SCO config which doesn't have 3 bNumEndPoints and
> fails the test in the hci_usb_probe()
> 
>         if (intf->altsetting[0].desc.bNumEndpoints < 3)
>                  return -EIO;
> 
> The error happens in both 2.4.23 and 2.6.0-test11, but doesn't stop the
> device working perfectly.

now I got it. We are the origin of this error and I think simply return
zero is the better approch, because it is not an error on interface 1
and 2 (if you have support for DFU). I put it on my TODO list for 2.6.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

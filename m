Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem "coldplugging"
From: Marcel Holtmann <marcel@holtmann.org>
To: Oguzhan Eris <eris3@ekls.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073252537.4255.6.camel@localhost>
References: <1073239248.2928.18.camel@localhost>
	 <1073243976.25261.160.camel@pegasus>  <1073252537.4255.6.camel@localhost>
Content-Type: text/plain
Message-Id: <1073253546.25261.165.camel@pegasus>
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
Date: Sun, 04 Jan 2004 22:59:06 +0100

Hi,

> all bluetooth core drivers are in-kernel. hci_usb is a module and so is 
> bcm203x (which I guess can never be in kernel as it needs way too many
> userland stuff)

personally I prefer to have all Bluetooth stuff as modules.

> I have tried lots and lots of different ways of going about it all.  I'm
> guessing hci_usb needs to be loaded before bcm203x, please correct me if
> I'm wrong.  But regardless,  SOMETIMES it works perfectly,  most of the
> time it just doesn't work.  By doesn't work, i mean I can see the hci0
> device but bringing it up sometimes results in ...
> Can't init device hci0. Connection timed out(110)
> and in the logs I see 
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb dd071214 err -90

Compile the hci_usb driver without the SCO audio support. Maybe the
Broadcom devices don't really like the ISOC transfers.

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

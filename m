Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device Busy during "hcitool info" or
	"sdptoolsearch"
From: Marcel Holtmann <marcel@holtmann.org>
To: ag@new-media-artists.de
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <FJENILNPNAGPJMMDOKDCEEKKDJAA.ag@new-media-artists.de>
References: <FJENILNPNAGPJMMDOKDCEEKKDJAA.ag@new-media-artists.de>
Content-Type: text/plain
Message-Id: <1071739500.3873.11.camel@pegasus>
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
Date: Thu, 18 Dec 2003 10:25:01 +0100

Hi Andreas,

> >In your case, the correct response to having your inquiry rejected is
> >to back off for a few seconds and try again - either that, or find some
> >way of sharing access to the device.
> 
> Sounds good to me, im actualy handling it like this. The only problem is if
> a device is in range that does not respond to the connection attemt will
> make the device unusable for inquiry until the connection attemt times out.

If the device runs an inquiry the kernel sets the HCI_INQUIRY flag. You
can check this with hciconfig.

> Who decides when to timeout? I guess the host, so where can i configure
> these timeouts?

we have timers on the host stack, but the important one is the page
timeout of the link manager. You should start reading the HCI spec. to
see what you can set on chip level. And "man hciconfig" is also very
helpful ;)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

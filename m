Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1101930555.6182.15.camel@localhost>
References: <1101930555.6182.15.camel@localhost>
Content-Type: text/plain
Message-Id: <1101933187.15615.54.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH] - for BT HID fixes + beginning of ctrl handling
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
Date: Wed, 01 Dec 2004 21:33:07 +0100

Hi Matthew,

don't do any cross postings and there is no need to address these mails
to me directly. I read the mailing lists ;)

> Please find 2 patches attached.  My original against 2.6.9-mh4, and one
> for 2.6.10-rc2-bk.  These are the patches I can easily produce. Is this
> OK with you? Please let me know what else you need and I will see what
> can be done.

from a first review, this looks good so far, but please don't change any
debug stuff. Leave it as it is. I am not going to apply any debug config
options.

It is "Bluetooth" and not "Blue Tooth" or "BlueTooth" and you should
follow more the coding style:

	"hidp_process_hid_control (" ==> "hidp_process_hid_control("
	"if ( hdr" == > "if (hdr"
	"HIDP_TRANS_DATA|HIDP_D..." ==> "HIDP_TRANS_DATA | HIDP_D..."

I think you see what I mean and don't introduce extra whitespaces:

-                 atomic_inc(&session->terminate);<== correct
+                 atomic_inc(&session->terminate);        <== wrong


There is no need to use "retval" and "result". Use one of them and I
actually prefer using "err".

And you must explain the extra need of the "schedule" parameter to me.

> I have not one yet between straight 2.6.10-rc2-bk+base-bthid+-mh4 and my
> trunk as the source tree manipulations are getting quite convoluted.
> Making this patching easier is something I would really like to sort out
> for both our work flows.

Fix the stuff I mentioned above and don't forget the Signed-off-by line
and I will start testing it on my machines.

> My question is, how do you manage the patch creation of -mh4 patches
> etc? Looks like this just a simple diff of your trunk net/bluetooth and
> drivers/bluetooth against current mainstream kernel.

The -mh patches are created by a bunch of scripts. Actually every patch
is part of a collection and these scripts will apply them in the correct
order and then rediff against vanilla. If all my work is merged mainline
then this a diff of mainline versus trunk. But sometimes there are also
testing patches in there, like the HIDP report mode support and the
RFCOMM service level security stuff.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

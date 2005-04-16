Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1113668583.16433.76.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Using ASCII based files for link key storage
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
Date: Sat, 16 Apr 2005 18:23:03 +0200

Hi Folks,

currently the link keys are stored in a binary format and they are
stored under the "/etc/bluetooth/" directory. Both things are not very
handy and we should start doing something to change this.

So first the new place for runtime things like link keys, names etc. I
decided to use "/var/cache/bluetooth/<bdaddr>/" as the base directory
and then use the file "linkkeys" for the actual link keys. And we will
use "names" for the device name cache. The "bdaddr" is the address of
the local adapter.

And second, The format of the link key file will be very simple:

	<bdaddr> <hex-linkkey> <type>

All the framework around these stuff is already committed to the BlueZ
utils CVS and we need only to fill in the functions for writing and
reading the link keys from the files. Both can be found as some kind of
prototypes in hcid/storage.c and I would be very happy if someone fills
these function with actual code, because I am quite busy with some other
stuff.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

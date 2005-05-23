Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] link_key pairing problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200505211500.37962.ruben@hotheads.de>
References: <200505211500.37962.ruben@hotheads.de>
Content-Type: text/plain
Message-Id: <1116842913.30044.36.camel@pegasus>
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
Date: Mon, 23 May 2005 12:08:33 +0200

Hi Ruben,

> I hoped to get rid of the pairing problem with my headset but it still exists.
> I had to manually delete the link_key file in /etc/bluetooth. I found a ugly 
> and simple hack: Symlinked /dev/null to /etc/bluetooth/link_key so that 
> everything that gets written to link_key is automatically deleted. This way 
> repairing works but it's not a clean way. I think there is a problem with the 
> pairing mechanism in bluez.  Or could that be a problem of my headset/dongle?
> 
> Actually I'm using bluez-utils /bluez-libs version 2.15. I allready tried 2.16 
> but that doesn't solve  the problem.

use bluez-utils-2.17 and use a clean start. Don't modify hcid.conf and
remove the link_key file (new place and file format since 2.16). Run
"hcidump -X -V" to show what happens.

Maybe your headset is broken.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

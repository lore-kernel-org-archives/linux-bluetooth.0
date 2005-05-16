Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Dealing with the bluez-utils dependencies
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05051610046ddb3671@mail.gmail.com>
References: <1115722824.8949.242.camel@pegasus>
	 <e1effdeb05051006043be12b4a@mail.gmail.com>
	 <1115901638.18499.30.camel@pegasus>
	 <e1effdeb0505120553473405cc@mail.gmail.com>
	 <1115903015.18499.34.camel@pegasus>
	 <e1effdeb05051610046ddb3671@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1116264847.10063.20.camel@pegasus>
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
Date: Mon, 16 May 2005 19:34:07 +0200

Hi Claudio,

> After lost a lot of time trying change the code to support
> DBUS version 0.33 I was informed that the code for get byte 
> arrays is broken.

check the bluez-utils CVS. I added a D-Bus patch from the Fedore Core
packages to workaround some API changes.

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

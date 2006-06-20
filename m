Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <564d96fb0606191321n68e4d17dp997e3dfe9578f195@mail.gmail.com>
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<564d96fb0606081007p3fb8ea42v5926c80eb1cc9657@mail.gmail.com>
	<1149884042.3985.6.camel@aeonflux.holtmann.net>
	<1150099297.2589.15.camel@aeonflux.holtmann.net>
	<564d96fb0606120452m4e4ced33x66ca63fd675ad3@mail.gmail.com>
	<1150715237.4277.17.camel@localhost>
	<564d96fb0606190513r4c59cd28v9bd23a9a45e55e8b@mail.gmail.com>
	<564d96fb0606190517w50ef4027p258030f7593ebd6a@mail.gmail.com>
	<564d96fb0606191038m42f48295w784bf0062ae184a3@mail.gmail.com>
	<1150740459.4277.25.camel@localhost>
	<564d96fb0606191321n68e4d17dp997e3dfe9578f195@mail.gmail.com>
Date: Tue, 20 Jun 2006 09:17:08 +0200
Message-Id: <1150787828.18381.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bug in sdp_gen_pd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Rafael,

> > please also check hidd, because the HID report descriptor is placed in a
> > string and we need to know the exact string length.
> 
> I tested with a Nokia bluetooth keyboard. I am not sure what the "HID
> report descriptor" is.

if you run a "sdptool search --bdaddr <bdaddr> --raw hid" you will see
an attribute with a byte stream. That is the HID report descriptor.
However you need to test this with the latest -mh kernel and you need to
make sure that /var/lib/bluetooth/<bdaddr>/hidd is empty.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

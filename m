Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111115003748.21b23ec1532619ff3363a845@studenti.unina.it>
References: <20111115003748.21b23ec1532619ff3363a845@studenti.unina.it>
Date: Tue, 15 Nov 2011 11:59:12 +0200
Message-ID: <CABBYNZLnhfPxN78D0vFJ_3b+ni7y+44k9zrb4pAJCELU1-ec7Q@mail.gmail.com>
Subject: Re: Regression with Bluetooth HID devices.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Tue, Nov 15, 2011 at 1:37 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> Hi,
>
> with master (a267bc2) I am getting this in dmesg for Sixaxis
> controllers:
>
> input: PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:02.0/...
> generic-bluetooth 0005:0000:0000.0018: input,hidraw1: BLUETOOTH HID v0.00 ...
> ^^^^^^^^^^^^^^^^^      ^^^^ ^^^^
>
> generic driver is used because vendor_id and product_id are 0000!
> while I would expect this:
>
> input: PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:02.0/...
> sony 0005:054C:0268.0017: input,hidraw1: BLUETOOTH HID v0.00 ...
> ^^^^      ^^^^ ^^^^
>
> Having vendor_id and product_id set to 0000 was making the device not
> working, the story is briefly like that:
>  - the hid-sony kernel driver makes the controller operational;
>  - devices are bound to hid drivers using vendor_id and product_id;
>  - with those set to 0000, hid-sony ends up not being used at all.

That is probably a bug in the code, does the device properties got the
right values?


-- 
Luiz Augusto von Dentz

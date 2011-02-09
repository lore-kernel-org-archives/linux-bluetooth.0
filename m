Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinRHYs+W+os7xn1O9cehqFnzOzhnedsqXWiNAcN@mail.gmail.com>
References: <AANLkTi=652bHGqL841fp1ufO1_7C3iTq+tZ4eBcGtEiO@mail.gmail.com>
	<4D4BED6C.3040506@nokia.com>
	<AANLkTinVkr3ivG0-Jt-sCJe0VLpPFTUAgDaTTiM5U51A@mail.gmail.com>
	<AANLkTimhUD74h=QDKQu=EGfPXYHafuTMnwQ-RbGeaUFp@mail.gmail.com>
	<AANLkTinRHYs+W+os7xn1O9cehqFnzOzhnedsqXWiNAcN@mail.gmail.com>
Date: Wed, 9 Feb 2011 14:56:19 -0300
Message-ID: <AANLkTimh+8zf2t2u==S4ZG1uiirzZZZt+u2pPk8nivXF@mail.gmail.com>
Subject: Re: Not able to test GATT on ubuntu
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vijayalakshmi N <vijayalakshmi.nk@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mika Linnanoja <mika.linnanoja@nokia.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Feb 9, 2011 at 8:47 AM, Vijayalakshmi N
<vijayalakshmi.nk@gmail.com> wrote:
> Now I have an updated setup where the bluetooth kernel code with BLE
> patches are taken from
> http://git.infradead.org/users/vcgomes/linux-2.6.git/tree/refs/heads/devel
> and hcidump 2.0

May I suggest you test first with two BR/EDR dongles to make sure the
GATT part is ok?

1) Make sure "AttributeServer = true" is added to
/etc/bluetooth/main.conf and start bluetoothd on the server
2) Make sure bluetoothd is started on the client as well (at least for
me this is required), if server/client are on different machines
3) On client, run:

gatttool -i <adapter> -b <server_bdaddr>  --primary

The rest of the parameters already have sane defaults. If that still
does not work, send us the server and client hcidump logs

HTH,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <57397128.8080208@redpinesignals.com>
References: <57397128.8080208@redpinesignals.com>
Date: Mon, 16 May 2016 10:45:18 +0300
Message-ID: <CABBYNZLb99QkEggXOiOye+VPp+UXK8i9bSZ0m=Vv2Mc_davLCw@mail.gmail.com>
Subject: Re: Request for BLE server applications and documents - BLUEZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mallikarjuna V <mallikarjuna.v@redpinesignals.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, May 16, 2016 at 10:05 AM, Mallikarjuna V
<mallikarjuna.v@redpinesignals.com> wrote:
>
> Hi Marcel,
>
> I need to develop the BLE based profile on GATT layer by using BULEZ
> software. I am unable to find the any reference documents to add new BLE
> services on GATT layer.
>
> Can you please provide any documents or links to develop the GATT server
> profiles on BLUEZ stack.

You can find the GATT related API documentation here:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/gatt-api.txt

There is also a python sample available under test/example-gatt-server:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server



-- 
Luiz Augusto von Dentz

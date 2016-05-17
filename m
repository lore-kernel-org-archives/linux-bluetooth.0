Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <573ACC64.60502@redpinesignals.com>
References: <57397128.8080208@redpinesignals.com>
	<CABBYNZLb99QkEggXOiOye+VPp+UXK8i9bSZ0m=Vv2Mc_davLCw@mail.gmail.com>
	<573ACC64.60502@redpinesignals.com>
Date: Tue, 17 May 2016 11:14:28 +0300
Message-ID: <CABBYNZJK20KwkcxFzhds8c+E1YsDFcOFhn3veTWzvumhbJLQyQ@mail.gmail.com>
Subject: Re: Request for BLE server applications and documents - BLUEZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mallikarjuna V <mallikarjuna.v@redpinesignals.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 17, 2016 at 10:46 AM, Mallikarjuna V
<mallikarjuna.v@redpinesignals.com> wrote:
>
> Luiz,
>
>
> We tried below python script, we got an error "GattManager1 interface not found"
>
> Can you please provide flow of sequence and dependences.

Please don't top post in the list, comment inline:
http://www.bluez.org/development/lists/. It is also not recommended to
use html in the emails sent to the list.

Regarding the actual problem it is probably because experimental
interfaces are not enabled by default, you can do enable that by
passing -E to bluetoothd.


>
> On 05/16/2016 01:15 PM, Luiz Augusto von Dentz wrote:
>
> Hi,
>
> On Mon, May 16, 2016 at 10:05 AM, Mallikarjuna V
> <mallikarjuna.v@redpinesignals.com> wrote:
>
> Hi Marcel,
>
> I need to develop the BLE based profile on GATT layer by using BULEZ
> software. I am unable to find the any reference documents to add new BLE
> services on GATT layer.
>
> Can you please provide any documents or links to develop the GATT server
> profiles on BLUEZ stack.
>
> You can find the GATT related API documentation here:
>
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/gatt-api.txt
>
> There is also a python sample available under test/example-gatt-server:
>
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server
>
>
>
>
>
>
>
>



-- 
Luiz Augusto von Dentz

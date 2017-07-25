Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMybWM1H9rxVW+np0r0y1cagPudcX15Xht5ZkSkmLn0gwFkCuw@mail.gmail.com>
References: <CAMybWM1H9rxVW+np0r0y1cagPudcX15Xht5ZkSkmLn0gwFkCuw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Jul 2017 15:41:54 +0300
Message-ID: <CABBYNZ+ZMm8_+cydkoZD0t-9nntyNJSVMjGBbmM3C+CvAkZpaQ@mail.gmail.com>
Subject: Re: Understanding GATT database
To: Natalya Rozhnova <rozhnova.natalya@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natalya,

On Mon, Jul 24, 2017 at 6:03 PM, Natalya Rozhnova
<rozhnova.natalya@gmail.com> wrote:
> Hello,
>
> I am trying to understand the difference between the gatt_db stored in
> the device structure and the one stored in bt_gatt_client structure. I
> see that the database stored in the device is recovered from the
> cache. I would like to understand what it is used for if anyway the
> new one is created during the discover_services phase? Another
> question that would very probably help me to understand this better:
> if I copy the device->db to client->db, would it still work or we
> really need to pass by a communication with a BLE device and compose
> the database from scratch?
>
> Could anybody explain me this please?

The gatt_db is passed over to bt_gatt_client_new, that way the client
can inspect if the attributes were already in place and skip deep
discovery:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/shared/gatt-client.c#n1831

As you can see above the client->db is a reference to device->db, so
there is just one instance of the db per device.

-- 
Luiz Augusto von Dentz

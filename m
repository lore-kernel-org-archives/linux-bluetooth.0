Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Help with LE Create Connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGuV3hM+GPfDQf5C6-Ug8R+QPe-xo361TgVTem2HjWjnZ0To2Q@mail.gmail.com>
Date: Mon, 23 Apr 2018 19:02:25 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8B5DE5B9-93AD-4385-932C-880F08BE8F4E@holtmann.org>
References: <CAGuV3hPxvhDbsO1TZLcQwtQuAWrm5TqQrH=zG3UrFsvjfZOeFA@mail.gmail.com>
 <CAGuV3hM+GPfDQf5C6-Ug8R+QPe-xo361TgVTem2HjWjnZ0To2Q@mail.gmail.com>
To: Fulko Hew <fulko.hew@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fulko,

> I'm doing my first Bluetooth app, and I have a specific question and a
> general question:
> 
> 1/ Where can I find documentation on the BlueZ API?
>   I've searched and haven't found anything yet.
> 
> 2/ I've captured a trace of an existing conversation off of my Android phone,
>   and I'm trying to re-create it via my own app using BlueZ.
>   I've gotten to the point of trying to do an LE Create Connection
> via hci_le_create_conn()
>   and my first stumbling block is the value of the 'peer address type'.
>   From my investigation, I need to use the 'public' address type
> which according to
>   the spec, and Wireshark is a value of 0x00, but bluetooth.h defines
> 'public' as 0x01
>   (as per the following extract).  Can anyone explain it to me?
> 
>   #define BDADDR_BREDR           0x00
>   #define BDADDR_LE_PUBLIC       0x01
>   #define BDADDR_LE_RANDOM       0x02

why not use the bluetoothd D-Bus GATT APIs for your application. It will create all needed connections. Manually doing HCI is the wrong approach since that is owned by the kernel.

Regards

Marcel


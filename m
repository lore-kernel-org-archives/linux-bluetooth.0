Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59CD26BE.8040803@digi.com>
References: <59CD26BE.8040803@digi.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 Sep 2017 21:21:26 +0300
Message-ID: <CABBYNZLFyyNQmkAk5JZGWDii_hcx0n68yr-sjeXVUAEHVcOqcw@mail.gmail.com>
Subject: Re: how to advertise a GATT service only for LE or BR/EDR?
To: "Hermida, Isaac" <Isaac.Hermida@digi.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Isaac,

On Thu, Sep 28, 2017 at 7:43 PM, Hermida, Isaac <Isaac.Hermida@digi.com> wrote:
> Hi group,
>
> As part of the bluetooth SIG certification there are two test cases
> /TP/GAR/CL/BI-34-C and /TP/GAR/CL/BI-35-C (you can see they defined in
> unit/test-gatt.c).
> Currently I am able to run the "test/example-gatt-server" and see my
> custom services and characteristics, but I need to define an specific
> service/characteristic to be only accessible trough LE or BR/EDR
> transport parameter. I was digging into the code but I was unable to
> find how to set it for the GATT server.
>
> In other words, what I want to do is launch the gatt-server and then,
> when inspecting the services/characteristic with gatttool, the returned
> list should be different if I run gatttool with "-p 31" or not (notice
> how the gatttool prompt is set to LE or BR).
>
> # gatttool -I -b 00:40:9D:98:99:BD -p 0
> [00:40:9D:98:99:BD][LE]> connect
> Attempting to connect to 00:40:9D:98:99:BD
> Connection successful
> [00:40:9D:98:99:BD][LE]> primary
> attr handle: 0x0001, end grp handle: 0x0005 uuid:
> 00001800-0000-1000-8000-00805f9b34fb
> attr handle: 0x0006, end grp handle: 0x0009 uuid:
> 00001801-0000-1000-8000-00805f9b34fb
> attr handle: 0x000a, end grp handle: 0x000d uuid:
> 0000180f-0000-1000-8000-00805f9b34fb
> attr handle: 0x000e, end grp handle: 0x001d uuid:
> 12345678-1234-5678-1234-56789abcdef0
> attr handle: 0x001e, end grp handle: 0x0025 uuid:
> 0000180d-0000-1000-8000-00805f9b34fb
>
>
> # /tmp/gatttool -I -b 00:40:9D:98:99:BD -p 31
> [00:40:9D:98:99:BD][BR]> connect
> Attempting to connect to 00:40:9D:98:99:BD
> Connection successful
> [00:40:9D:98:99:BD][BR]> primary
> attr handle: 0x0001, end grp handle: 0x0005 uuid:
> 00001800-0000-1000-8000-00805f9b34fb
> attr handle: 0x0006, end grp handle: 0x0009 uuid:
> 00001801-0000-1000-8000-00805f9b34fb
> attr handle: 0x000a, end grp handle: 0x0019 uuid:
> 12345678-1234-5678-1234-56789abcdef0
> attr handle: 0x001a, end grp handle: 0x001d uuid:
> 0000180f-0000-1000-8000-00805f9b34fb
> attr handle: 0x001e, end grp handle: 0x0025 uuid:
> 0000180d-0000-1000-8000-00805f9b34fb
>
>
>
> I am using bluez 5.41. Is possible to advertise a service only for LE or
> BR? I guess it should because is part of the SIG certification and is
> part of the unit/test-gatt.

This might be because the spec was no clear about the database being
bearer specific, which in my opinion this is a oversight since then we
can't represent attributes of dual mode devices with a unified object,
and I really wonder if this has to be forced up into the API, if it
does then we would have to encode bearer information into the object
path (argh!) for client and for server would probably need a property
telling which bearer this would be available and encode this into to
the database which may leave gaps in the handles or just duplicate
everything, for server Id probably just hide the services based on the
bearer, but we still need to store the CCC configuration in a bearer
specific manner.

-- 
Luiz Augusto von Dentz

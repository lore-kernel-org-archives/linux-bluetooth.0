Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35B17FE5076C7040809188FBE7913F983F844057B9@SC1EXMB-MBCL.global.atheros.com>
References: <AANLkTin8pUACCu4YYuhLpFB7DxCfsYhN3cOpYYaVcTQ6@mail.gmail.com>
	<35B17FE5076C7040809188FBE7913F983F844057B9@SC1EXMB-MBCL.global.atheros.com>
Date: Mon, 25 Oct 2010 14:55:52 -0300
Message-ID: <AANLkTinS-NhD3FhqcnpNRRdHKxn4mm+2zTmysrSeSjW8@mail.gmail.com>
Subject: Re: [RFC] LE connections and advertising management
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Mike Tsai <Mike.Tsai@atheros.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 25, 2010 at 2:11 PM, Mike Tsai <Mike.Tsai@atheros.com> wrote:
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Claudio Takahasi
> Sent: Monday, October 25, 2010 5:53 AM
> To: BlueZ development
> Subject: [RFC] LE connections and advertising management
>
> Hi all,
>
> Interleave BR/EDR/LE discovery is implemented, the next step in the
> user space is how to manage advertising and LE connections.
>
> Some aspects:
> 1. Only one LE connection is allowed(per peer), meaning only one
> GAttrib instance will be allowed otherwise it will not be possible to
> serialize commands/events
> 2. The remote/Peripheral can support more than one GATT primary service
> 3. We are planning to use "direct" connections only, meaning that we
> will not use whitelist and the application interested must inform the
> remote address/object to connect to.
> 4. Kernel manages the connection establishment, currently there isn't
> a  way to change the connection parameters. BMI or ioctls will be
> required to change the default parameters and also to trigger SMP
> negotiation.
>
>
> Some ideas:
> 1. implement a characteristic driver: basically to provide an
> abstraction to GATT clients. ex: Proximity, Health, ...
> 2. We don't need to implement Proximity and other GATT clients as a
> plugin at the moment, it can be enabled automatically by
> --enable-attrib
> 3. GATT clients could register a watcher/filter for advertising events
> 4. GATT clients doesn't need to know ATT, in theory it can handle
> characteristics only
> 5. GATT clients needs to control/request LE connections based on the
> advertisement received
>
> An initial draft implementing part of this idea is here:
> git://git.infradead.org/users/cktakahasi/bluez.git devel
>
> Comments?
>
> Regards,
> Claudio
>>>MT comments,
>
> 1. Only one LE connection is allowed(per peer), meaning only one
> GAttrib instance will be allowed otherwise it will not be possible to
> serialize commands/events
>
>>> You mean the master (or client) can only connect to 1 slave (or server) or a slave can only connect to 1 master?
[Claudio Takahasi]
The master can be connected to more than one slave. But here, I wanna
emphasize that only one instance of GAtttrib shall be created to
represent the physical channel between two LE capable devices. GAttrib
is the abstraction that we created in BlueZ to represent the GATT/ATT
connection, it is necessary to address multiple applications/profiles
and queue commands/events.

>
> 4. GATT clients doesn't need to know ATT, in theory it can handle
> characteristics only
>
>>> You mean both characteristic value and characteristic descriptors of characteristic?
[Claudio Takahasi]
Both. For the GATT client role, an interface can be created exporting
profile specific details.
Sometimes GATT clients will also need to access some low level information.

Regards,
Claudio
>
> Regards,
>
> Mike
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

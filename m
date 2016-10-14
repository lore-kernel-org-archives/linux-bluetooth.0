Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Getting the address type of a  BLE device
Date: Fri, 14 Oct 2016 12:54:51 +0000
Message-ID: <5EFE62F1AC977B4F94A5BA55F4D506333BF4DC07@DEDC01MBX02.corp.lairdtech.com>
References: <5EFE62F1AC977B4F94A5BA55F4D506333BF4D43A@DEDC01MBX02.corp.lairdtech.com>
 <20161008060409.GA4638@x1c.P-661HNU-F1>
 <5EFE62F1AC977B4F94A5BA55F4D506333BF4D518@DEDC01MBX02.corp.lairdtech.com>
 <20161009145208.GA9550@x1c.P-661HNU-F1>
In-Reply-To: <20161009145208.GA9550@x1c.P-661HNU-F1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The LE & BR/EDR D-Bus interface proposal from Szymon (that I mentioned in my earlier email) would likely be the cleanest way to do this.

Do you have a link to this proposal?

> What API does Qt use to connect? The first connection to LE devices is usually either through the Pair() or Connect() D-Bus method. Neither one requires knowledge of the address type. After the initial connection re-connections are typically done through passive background scanning by the kernel, and in this case the application also doesn't need knowledge of the address type.

Qt is using the DBus API but it seems they don't store the device handles/IDs and instead when connecting to a device just require the Bluetooth address (which is why this would be failing as it's not using the kernels cached entries and is specifically setting if it's connecting to a random address or public address before passing it to BlueZ)

> If you're not bonded there's no way to protect against other devices spoofing the address of the real device,

True, I was just referring to at the moment being unable to extract the address type.

> That's only true for BR/EDR Security Mode 4, and even that has some exceptions like SDP.

I'm not sure I follow you? BLE does not require any bonding unless mandated by the service/characteristics. It's possible to have many BLE devices and have them all interacting without any of them ever bonding with another device, yes this means there is no encryption or security but in some instances it is not required.

> I suppose you're referring to the Address property on the Device1 interface? It'd be help understand what exactly your concern is if you could be more specific in this regard. I'll assume you're talking about the Address property. This property was originally created for BR/EDR devices and probably isn't that useful for LE where you need to know the random vs public information. The new LE-specific D-Bus interface talked about earlier would provide this missing info.

I think the confusion comes from how we envisage the address type. When I think of the address type I think of it as part of the BLE address itself and prepend it to the address so with 00:11:22:33:44:55:66 the 00 is indicating that it is a public address and with 01:11:22:33:44:55:66 the 01 is indicating that it is a random address.

Thanks,
Jamie

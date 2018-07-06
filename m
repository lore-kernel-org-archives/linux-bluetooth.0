Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: Determine ATT MTU size over DBUS
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2X21xsgg8bEyTVVoBik7GT2JM5chtujJdSSpMBd-J7xIRMuRPqnF8Or25Al9oNj5R08x57BAEhkOUdT1-8FEmtoGVKXOB7X1DTlLztKep-8=@krauser.org>
Date: Fri, 6 Jul 2018 12:25:06 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5401E5CE-7C2B-44D6-BF62-C98AC634F490@holtmann.org>
References: <Vd5Hg1KzgalysaxK8wZu5wyXhzrIeNpwpHrqD6JzDGdK6926uwNchApKq9lnhrOPr7Y6Xb0Cgzzu-vWt8lvB-JRRxXhAmSPzjikGfg5kkSc=@krauser.org>
 <CABBYNZLHGQdpgZUGxaxhtWBG309WB9MVOXQxdRBWeMW+XuARBg@mail.gmail.com>
 <-JmTPP9qq2ljmysdKs_4nDqzQMZH4NMScqdEFmY7eo4Eu5GDniGqk-lMiLXCo7O1RZgB4BI_UsKZS0KdET69HZksuaRIKE_0mrQJS885K-M=@krauser.org>
 <2X21xsgg8bEyTVVoBik7GT2JM5chtujJdSSpMBd-J7xIRMuRPqnF8Or25Al9oNj5R08x57BAEhkOUdT1-8FEmtoGVKXOB7X1DTlLztKep-8=@krauser.org>
To: David Krauser <david@krauser.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> And here's a patch that lets the user know the MTU size over DBus:
> 
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 2a8da75b0..a0db65383 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -68,6 +68,7 @@ Methods		array{byte} ReadValue(dict options)
> 			operation was successful.
> 
> 			Possible options: "offset": uint16 offset
> +					  "MTU": Exchanged MTU (Server only)
> 					  "device": Object Device (Server only)
> 
> 			Possible Errors: org.bluez.Error.Failed
> @@ -83,6 +84,7 @@ Methods		array{byte} ReadValue(dict options)
> 			characteristic.
> 
> 			Possible options: "offset": Start offset
> +					  "MTU": Exchanged MTU (Server only)

I prefer "mtu" as option name here. We kept them all lowercase. Other option is to use "max-transfer-unit".

Regards

Marcel


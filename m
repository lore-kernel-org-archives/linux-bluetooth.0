Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5F431791-D0DC-4BC2-8233-5EB4B464EC0A@high-mobility.com>
References: <5F431791-D0DC-4BC2-8233-5EB4B464EC0A@high-mobility.com>
Date: Wed, 3 Feb 2016 17:38:35 +0200
Message-ID: <CABBYNZJcFSx4c6P+QHQZyLnb29K6+jwODK+Lg=_XvOtH3_dqKQ@mail.gmail.com>
Subject: Re: Write response for GATT WriteValue() method
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@high-mobility.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tõnis,

On Wed, Feb 3, 2016 at 1:07 PM, Tõnis Tiganik
<ttiganik@high-mobility.com> wrote:
> Hello,
> we are currently implementing communication between two BLE devices. We are sending chunks of data so we need to know when the other device is ready for the next chunks.
>
> We have impemented the writing of the data with DBUS API. It looks like this:
>
> message_var = g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE, data, length, sizeof(char));
> g_dbus_proxy_call_sync(write_characteristic, "WriteValue”, g_variant_new_tuple(&message_var, 1), G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);
>
> The write succeeds, the other device receives the data. However, it is not clear for us how to detect that the other device actually read the data(Write response).

What do you mean by read the data? The data needs to be written if you
use WriteValue, and the write response should only be sent once that
is complete otherwise you will be out of sync.

> So the first question is: How do we detect the GattCharacteristic1.WriteValue() response?

Unless you are writing to an attribute with  Write Without Response
property the reply is already the confirmation that the value has been
written. We even use Prepare + Execute write if reliable write is
supported.

>
> This is the blocking issue for us currently but I have some other questions about the problems that I image could arise in the future:
>
> How do we send a notification about a successful read on a characteristic value? (the writing of the chunks goes both ways)

Is this a peripheral, for notifications you need a CCC characteristic,
there is an example of that under test/example-gatt-server. If this is
just a read command than the remote will receive the read response you
don't need another notification.

> Do we get a notification of some sort when a Device goes out of range?

Yes you will get a signal PropertiesChanged for the Connected property.

> Thanks,
> Tõnis
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

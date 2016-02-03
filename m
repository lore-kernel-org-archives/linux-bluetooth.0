Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?utf-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@high-mobility.com>
Content-Type: text/plain; charset=utf-8
Subject: Write response for GATT WriteValue() method
Message-Id: <5F431791-D0DC-4BC2-8233-5EB4B464EC0A@high-mobility.com>
Date: Wed, 3 Feb 2016 13:07:08 +0200
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, 
we are currently implementing communication between two BLE devices. We are sending chunks of data so we need to know when the other device is ready for the next chunks.

We have impemented the writing of the data with DBUS API. It looks like this:

message_var = g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE, data, length, sizeof(char));
g_dbus_proxy_call_sync(write_characteristic, "WriteValue”, g_variant_new_tuple(&message_var, 1), G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);

The write succeeds, the other device receives the data. However, it is not clear for us how to detect that the other device actually read the data(Write response).

So the first question is: How do we detect the GattCharacteristic1.WriteValue() response?


This is the blocking issue for us currently but I have some other questions about the problems that I image could arise in the future:

How do we send a notification about a successful read on a characteristic value? (the writing of the chunks goes both ways)
Do we get a notification of some sort when a Device goes out of range?

Thanks,
Tõnis



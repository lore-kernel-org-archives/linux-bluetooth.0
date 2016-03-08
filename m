Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?utf-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@high-mobility.com>
Content-Type: text/plain; charset=utf-8
Subject: ConnectProfile for faster service discovery.
Message-Id: <9D4EB9A8-6F3A-47EE-842C-1049DEC1A5B2@high-mobility.com>
Date: Tue, 8 Mar 2016 13:15:04 +0200
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, we have implemented our application using BlueZ and DBUS.

All is working rather well but the service/characteristics discovery is slow after Connecting to the device. Our guess is that this is because all of the services are discovered automatically in the connection process and for instance iPhone has a lot of services extra that we are not interested in. For other platforms(iOS, BlueSDK), optional service discovery is supported and it seems to work faster.

After looking into some threads and the device-api.txt it seems ConnectProfile() should be the method to use. However, when connecting to our UUID with the following:

GVariant *UUIDString = g_variant_new("s", "713d0100-503e-4c75-ba94-3148f18d941e");
reply = g_dbus_proxy_call_sync(device_proxy, "ConnectProfile", g_variant_new_tuple(&UUIDString, 1),
                                           G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);

the call repeatedly fails with:

GDBus.Error:org.bluez.Error.Failed: Host is down

We know the UUID exists because it is in the Device property UUIDs if we use the normal Connect method that discovers all the services automatically.

Is it possible to connect and only discover the services that our application is interested in? 
Could it be faster than the normal Connect() method?


Im also wondering if there is a signal or some other mechanism to detect when a disconnected but advertising peripheral leaves the central's proximity?


Thanks, 
Tõnis



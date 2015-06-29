Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: how to use "example-gatt-server" test gatt?
Date: Mon, 29 Jun 2015 09:00:31 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E11A34AE9@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

1. I use the latest version of Bluez and run as "bluetoothd  -Edn" to test gatt.

2. I try to use example-gatt-server to test it.

However, it failed. Please check the following log.

Run "Bluetooth -Edn"
"
bluetoothd[17456]: src/gatt-database.c:manager_register_service() Registering service - path: /org/bluez/example/service0
bluetoothd[17456]: src/gatt-database.c:manager_register_service() Registering service - path: /org/bluez/example/service1
bluetoothd[17456]: src/gatt-database.c:manager_register_service() Registering service - path: /org/bluez/example/service2
bluetoothd[17456]: src/gatt-database.c:client_disconnect_cb() Client disconnected
bluetoothd[17456]: src/gatt-database.c:client_disconnect_cb() Client disconnected
bluetoothd[17456]: src/gatt-database.c:client_disconnect_cb() Client disconnected
"

Then Run "./example-gatt-server"
"
./example-gatt-server 
Battery Level drained: 98
Battery Level drained: 96
Battery Level drained: 94
Battery Level drained: 92
Failed to register service: org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken. 
"

After checked the source code, I find that "RegisterService" not return the dbus message and only after invoking client_ready_cb, the dbus message is returned.

I missed some steps to test it? Please help. Thanks.

Best Regards
Zheng Wu

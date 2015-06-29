Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E11A34AE9@SHSMSX104.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E11A34AE9@SHSMSX104.ccr.corp.intel.com>
Date: Mon, 29 Jun 2015 14:32:33 +0300
Message-ID: <CABBYNZLxnf4ToXGnkfQzjcn75ZE_t0qXR2Dkd3vAZWDmnaTt1g@mail.gmail.com>
Subject: Re: how to use "example-gatt-server" test gatt?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 29, 2015 at 12:00 PM, Zheng, Wu <wu.zheng@intel.com> wrote:
> Hi all,
>
> 1. I use the latest version of Bluez and run as "bluetoothd  -Edn" to test gatt.
>
> 2. I try to use example-gatt-server to test it.
>
> However, it failed. Please check the following log.
>
> Run "Bluetooth -Edn"
> "
> bluetoothd[17456]: src/gatt-database.c:manager_register_service() Registering service - path: /org/bluez/example/service0
> bluetoothd[17456]: src/gatt-database.c:manager_register_service() Registering service - path: /org/bluez/example/service1
> bluetoothd[17456]: src/gatt-database.c:manager_register_service() Registering service - path: /org/bluez/example/service2
> bluetoothd[17456]: src/gatt-database.c:client_disconnect_cb() Client disconnected
> bluetoothd[17456]: src/gatt-database.c:client_disconnect_cb() Client disconnected
> bluetoothd[17456]: src/gatt-database.c:client_disconnect_cb() Client disconnected
> "
>
> Then Run "./example-gatt-server"
> "
> ./example-gatt-server
> Battery Level drained: 98
> Battery Level drained: 96
> Battery Level drained: 94
> Battery Level drained: 92
> Failed to register service: org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.
> "
>
> After checked the source code, I find that "RegisterService" not return the dbus message and only after invoking client_ready_cb, the dbus message is returned.
>
> I missed some steps to test it? Please help. Thanks.

Check if you had update the D-Bus policy file, we will try to access
the clients services via ObjectManager etc, so you need the policy to
enable that.


-- 
Luiz Augusto von Dentz

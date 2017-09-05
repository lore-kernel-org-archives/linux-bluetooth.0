Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Query Regaring usage of RegisterApplication Method using Gio Api
Date: Tue, 5 Sep 2017 12:18:48 +0000
Message-ID: <7B53A3173656CB4190908401FE75F4F85CC14929@exgmbxfz01.sasken.com>
References: <7B53A3173656CB4190908401FE75F4F85CC0D1CE@exgmbxfz01.sasken.com>,<CABBYNZJncfY1tPqVTXbGG0eUtj9C56hh8YbiBLH3T_pyM=zziw@mail.gmail.com>,<7B53A3173656CB4190908401FE75F4F85CC14908@exgmbxfz01.sasken.com>
In-Reply-To: <7B53A3173656CB4190908401FE75F4F85CC14908@exgmbxfz01.sasken.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for the reply,

I could not continue using GIO apis for RegisterApplication, But we proceeded using Gdbus apis exposed by Bluez,
We see that the RegisterApplication is succeeded, but we are unable to auto connect.

Attached logs "bluetoothd_logs.txt",

bluetoothd[1520]: ../bluez-5.43/src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00_1C_05_FF_CA_D9 err 0
bluetoothd[1520]: ../bluez-5.43/src/gatt-database.c:manager_register_app() Registering application: :1.14:/
bluetoothd[1520]: ../bluez-5.43/src/gatt-database.c:proxy_added_cb() Object received: /org/bluez/app, iface: org.bluez.GattProfile1
bluetoothd[1520]: ../bluez-5.43/src/gatt-database.c:profile_add() Added ":1.14/org/bluez/app/00001800-0000-1000-8000-00805f9b34fb"
bluetoothd[1520]: ../bluez-5.43/src/gatt-database.c:profile_device_probe() :1.14/org/bluez/app/00001800-0000-1000-8000-00805f9b34fb probed
bluetoothd[1520]: ../bluez-5.43/src/service.c:change_state() 0x5577a0dd0cc0: device 00:1C:05:FF:CA:D9 profile :1.14/org/bluez/app/00001800-0000-1000-8000-00805f9b34fb state changed: unavailable -> disconnected (0)
bluetoothd[1520]: ../bluez-5.43/src/gatt-database.c:client_ready_cb() GATT application registered: :1.14:/

Any information will be of great help. Awaiting for the reply.

Regards,
Anitha
________________________________________
From: Luiz Augusto von Dentz [luiz.dentz@gmail.com]
Sent: Thursday, August 10, 2017 6:45 PM
To: Anitha Chandrasekar
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Query Regaring usage of RegisterApplication Method using Gio Api

Hi Anitha,

On Tue, Aug 8, 2017 at 3:01 PM, Anitha Chandrasekar
<anitha.chandrasekar@sasken.com> wrote:
> Hi ,
>
> We need to call RegisterApplication function from our application for auto-connect of devices. We are registering the GattProfile1 object and calling RegisterApplication method using Gio Api.
>
> But we are getting a "No object Found " error every time. Could you please let us know if there is any example code for the same or if you could suggest the API usage from d-feet tool.
> d-feet ->
> I dont see GattProfile1 being listed in d-feet and there is only RegisterApplication api, can I know what input params to be given and usage of it.Thanks in advance.

You need to implement GattProfile1 in the side of the application and
that should contain ObjectManager object since that is how bluetoothd
is able to list the available objects, you should be able to see the
available interfaces your application have all interfaces in d-feet.

> Regards,
> Anitha
>
> ________________________________
>
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Technologies Limited ( formerly known as "Sasken Communication Technologies Limited" ) unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/mail-disclaimer/
>
> ________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Luiz Augusto von Dentz

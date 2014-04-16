Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B177411279AD6@SHSMSX104.ccr.corp.intel.com>
References: <3D02B219753AD44CBDDDE484323B177411279AD6@SHSMSX104.ccr.corp.intel.com>
Date: Wed, 16 Apr 2014 09:20:37 -0300
Message-ID: <CAKT1EBdJmd=faGGx2EJf_j79ehrWqWNP34kBAj4p4TewZ4JJCA@mail.gmail.com>
Subject: Re: For Gatt feature question.
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie Gu,

On Wed, Apr 16, 2014 at 5:17 AM, Gu, Chao Jie <chao.jie.gu@intel.com> wrote:
> Hi, Claudio:
>
>          Sorry for taking your time to ask you question about GATT again.
> Recently we have implemented the part of Gatt feature in the Bluetooth-frwk
> in Tizen according to the Gatt-API doc in the bluez 5.18. We hope we can do
> some test for Gatt Client operation to contribute Gatt Client DBus API
> related development. However, now we have encountered the some issues about
> how to test GATT operation.
>
> Firstly, we have to familiar with the test steps about it. Now we setup two
> environment for testing. One acts as Gatt Server, the other acts as Gatt
> Client.
>
> For Gatt Server, I've checked out the latest tag (5.18) from git and have
> built it and gatt-example.c is compiled into a static plugin that is loaded
> at runtime. Through the bluetoothd running, I've confirmed that the plugin
> is compiled and is loaded at runtime. When I use gattool to do some test,
> connection is failed.
>
> Gatt server Bluetooth status:
>
> hci0:   Type: BR/EDR  Bus: USB
>
>         BD Address: 00:15:83:65:01:90  ACL MTU: 310:10  SCO MTU: 64:8
>
>         UP RUNNING PSCAN ISCAN
>
>         RX bytes:4394 acl:29 sco:0 events:197 errors:0
>
>         TX bytes:11856 acl:35 sco:0 commands:139 errors:0
>
>
>
> Gatt client Bluetooth status:
>
> hci0:  Type: BR/EDR  Bus: USB
>
> BD Address: 00:1A:7D:DA:71:0C  ACL MTU: 310:10  SCO MTU: 64:8
>
> UP RUNNING PSCAN
>
> RX bytes:104760 acl:34 sco:0 events:619 errors:0
>
> TX bytes:5704 acl:31 sco:0 commands:160 errors:0
>
>
>
> My operation step is:
>
> 1.       Scan and Pair the gatt client with gatt server , it pair
> successfully.
>
> 2.       In the server side, furthermore to register external gatt service
> by gatt-service.
>
> 3.       In the client side, use command line : gatttool -i hci0 -b
> 00:15:83:65:01:90 --primary
>
> To do primary service discovery.
>
> Command line feedback: Connection refused (111)
>
>
>
>    The client bluetoothd fail log :
>
> bluetoothd[29734]: src/adapter.c:connect_failed_callback() hci0
> 00:15:83:65:01:90 status 2
>
> bluetoothd[29734]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
> 00:15:83:65:01:90 type 1 status 0x2
>
> bluetoothd[29734]: src/adapter.c:resume_discovery()
>
>
>
> gatt_connect function has failed in the gatt tool, any option need to set in
> the command line ?

Please share the btmon log (of both sides).

Check if this problem also happens in BlueZ master.

>
> Which steps is right method to use gattool to test the gatt operation or
> lack other configuration for bluez in the sever side?

I recommend to use the interactive mode "-I" and specify the remote
address type.

>
>
>
> Secondly, there are a lot of patchset about Gatt Client DBus API
> implementation. Should we add all the patches into the latest tag (5.18) to
> test Gatt Client DBus API?

Do you mean re-base your patches to send upstream?
First make sure that your implementation is aligned with the
requirements that are being discussed in the ML: bt_att_* and shared
attribute database.

Regards,
Claudio

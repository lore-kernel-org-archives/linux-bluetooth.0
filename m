Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <13BCED30230BDE4A95185615BD0E58144C982E5A@GDC00215.swatchgroup.net>
References: <13BCED30230BDE4A95185615BD0E58144C982E5A@GDC00215.swatchgroup.net>
Date: Tue, 22 Mar 2016 14:32:03 +0200
Message-ID: <CABBYNZ+vmMKzZGAwUFHqRDAfB+kWmsvdi7koJhGsT4Xr=LiC3g@mail.gmail.com>
Subject: Re: Regression? Missing D-Bus GATT characteristics with version 5.38
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Hoover, David" <DHoover@asulab.ch>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, Mar 22, 2016 at 12:33 PM, Hoover, David <DHoover@asulab.ch> wrote:
> Hi,
>
> With the Feb 29 commit (8e493e8416e5525042b8b4a34eb2b7084725438b) I am able
> to see BLE device services and query their characteristics, but with version
> 5.38, this no longer works for me.
>
> This breaks test/example-gatt-client. Any idea? I can perform additional
> tests if necessary.
>
> For both checkouts I compiled with:
>
> ./configure --prefix=/share/bluez --enable-maintainer-mode
> --enable-backtrace --enable-test --enable-debug --disable-optimization
> --enable-experimental --sysconfdir=/share/bluez/etc --disable-udev
> --disable-systemd
>
> Thanks,
>
> David
>
>
> Example (8e493e8416e5525042b8b4a34eb2b7084725438b):
>
> dhoover@debian82:~/git/bluez/bluez/test$ qdbus --system org.bluez
> /
> /org
> /org/bluez
> /org/bluez/hci0
> /org/bluez/hci0/dev_12_34_50_12_34_52
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0001
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0002
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0004
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0006
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0008
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a/desc000c
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0011
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0012
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0014
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0016
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0018
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001b
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001c
>
> dhoover@debian82:~/git/bluez/bluez/test$ qdbus --system org.bluez
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009
> org.freedesktop.DBus.Properties.GetAll org.bluez.GattService1
> Characteristics: qdbus: I don't know how to display an argument of type
> 'ao', run with --literal.
> Device:
> Primary: true
> UUID: 0000180d-0000-1000-8000-00805f9b34fb
>
> dhoover@debian82:~/git/bluez/bluez/test$ qdbus --literal --system org.bluez
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009
> org.freedesktop.DBus.Properties.GetAll org.bluez.GattService1
> [Argument: a{sv} {"UUID" = [Variant(QString):
> "0000180d-0000-1000-8000-00805f9b34fb"], "Device" = [Variant: [ObjectPath:
> /org/bluez/hci0/dev_12_34_50_12_34_52]], "Primary" = [Variant(bool): true],
> "Characteristics" = [Variant: [Argument: ao {[ObjectPath:
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a], [ObjectPath:
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d], [ObjectPath:
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f]}]]}]
>
> dhoover@debian82:~/git/bluez/bluez/test$ ./example-gatt-client
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009
> Heart Rate Service ready
> Body sensor location value: Chest
> HR Measurement notifications enabled
> New HR Measurement
>                 HR: 108
>                 Sensor Contact status: no contact detected
>                 Energy Expended: 20
>
> Example (ver 5.38):
>
> dhoover@debian82:~/git/bluez/bluez/test$ qdbus --system org.bluez
> /
> /org
> /org/bluez
> /org/bluez/hci0
> /org/bluez/hci0/dev_12_34_50_12_34_52
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0001
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0002
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0004
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0006
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0008
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a/desc000c
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0011
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0012
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0014
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0016
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0018
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001b
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001c
> /org/bluez/hci0/dev_D0_33_11_3A_D4_71
> /org/bluez/hci0/dev_EE_34_56_78_9A_BC
>
> dhoover@debian82:~/git/bluez/bluez/test$ qdbus --system org.bluez
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009
> org.freedesktop.DBus.Properties.GetAll org.bluez.GattService1
> Device:
> Primary: true
> UUID: 0000180d-0000-1000-8000-00805f9b34fb
>
> dhoover@debian82:~/git/bluez/bluez/test$ ./example-gatt-client
> /org/bluez/hci0/dev_12_34_50_12_34_52/service0009
> Traceback (most recent call last):
>   File "./example-gatt-client", line 221, in <module>
>     main()
>   File "./example-gatt-client", line 207, in main
>     if not process_hr_service(service_path):
>   File "./example-gatt-client", line 167, in process_hr_service
>     chrc_paths = service_props['Characteristics']
> KeyError: 'Characteristics'

GattService1 no longer has the property Characteristic, this is
actually on purpose since the objects shall be enumerated with use of
ObjectManager, I will fix example-gatt-client in the meantime you can
use bluetoothctl.

-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Mirza Krak <mirza.krak@gmail.com>
Date: Thu, 22 Feb 2018 10:22:38 +0100
Message-ID: <CALw8SCXA0O=WEPptmNWA2A9b4Gedm17oAYWoU1toYskom=ox6Q@mail.gmail.com>
Subject: Issues with connecting to a BNEP/PAN network
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

My device is running:

- Linux kernel 4.14.18
- BlueZ 5.46

I am trying to setup the simple case where my "smart phone" should act
as an NAP with "tethering" enabled.

Then I simply want to connect to above network from my device.

The pair/connect phase worked just fine.

[OnePlus 3T]# info
Device 94:65:2D:26:01:7E
        Name: OnePlus 3T
        Alias: OnePlus 3T
        Class: 0x5a020c
        Icon: phone
        Paired: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        LegacyPairing: no
        UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34=
fb)
        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34=
fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34=
fb)
        UUID: Advanced Audio Distribu.. (0000110d-0000-1000-8000-00805f9b34=
fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34=
fb)
        UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34=
fb)
        UUID: PANU                      (00001115-0000-1000-8000-00805f9b34=
fb)
        UUID: NAP                       (00001116-0000-1000-8000-00805f9b34=
fb)
        UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34=
fb)
        UUID: SIM Access                (0000112d-0000-1000-8000-00805f9b34=
fb)
        UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34=
fb)
        UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34=
fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34=
fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34=
fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34=
fb)
        Modalias: bluetooth:v001Dp1200d1436

But when I try to connect with the following command:

    dbus-send --system --type=3Dmethod_call \
       --dest=3Dorg.bluez /org/bluez/hci0/dev_94_65_2D_26_01_7E
org.bluez.Network1.Connect string:'panu'

I get an error that is not clear to me what to do about it.

    bluetoothd[257]: bnep: Could not bring up bnep0: Cannot assign
requested address(99)

I have also tried to connect using NetworkManager (which in the end
sends the same dbus command as I have attempted above I believe) but
with the same result.

Any input would be greatly appreciated.

Full log from NetworkManager attempt pasted below:

Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.5197] device (94:65:2D:26:01:7E): Activation: starting
connection 'OnePlus 3T Network' (9e9aca7e-9a4c-43f9-a7f5-ed7b16b1941c)
Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.5206] audit: op=3D"connection-activate"
uuid=3D"9e9aca7e-9a4c-43f9-a7f5-ed7b16b1941c" name=3D"OnePlus 3T Network"
pid=3D339 uid=3D0 result=3D"success"
Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.5214] device (94:65:2D:26:01:7E): state change:
disconnected -> prepare (reason 'none') [30 40 0]
Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.5222] device (94:65:2D:26:01:7E): state change: prepare ->
config (reason 'none') [40 50 0]
Feb 22 08:43:33 hostname bluetoothd[257]: bnep: Could not bring up
bnep0: Cannot assign requested address(99)
Feb 22 08:43:33 hostname systemd-networkd[182]: bnep0: Could not find
udev device: No such device
Feb 22 08:43:33 hostname bluetoothd[257]: connect failed Input/output error
Feb 22 08:43:33 hostname systemd-networkd[182]: bnep0: Failed
Feb 22 08:43:33 hostname systemd-networkd[182]: Could not add new
link: No such device
Feb 22 08:43:33 hostname systemd-timesyncd[179]: Network configuration
changed, trying to establish connection.
Feb 22 08:43:33 hostname NetworkManager[194]: <warn>
[1519289013.9484] device (94:65:2D:26:01:7E): Error connecting with
bluez: GDBus.Error:org.bluez.Error.Failed: Input/output error
Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.9484] device (94:65:2D:26:01:7E): state change: config ->
failed (reason 'bluetooth-failed') [50 120 44]
Feb 22 08:43:33 hostname NetworkManager[194]: <warn>
[1519289013.9493] device (94:65:2D:26:01:7E): Activation: failed for
connection 'OnePlus 3T Network'
Feb 22 08:43:33 hostname systemd-udevd[345]: link_config:
autonegotiation is unset or enabled, the speed and duplex are not
writable.
Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.9542] device (94:65:2D:26:01:7E): state change: failed ->
disconnected (reason 'none') [120 30 0]
Feb 22 08:43:33 hostname systemd-udevd[345]: link_config: could not
get ethtool features for bnep0
Feb 22 08:43:33 hostname systemd-udevd[345]: Could not set offload
features of bnep0: No such device
Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.9620] devices added (path:
/sys/devices/platform/ff180000.serial/tty/ttyS0/hci0/hci0:11/net/bnep0,
iface: bnep0)
Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.9621] device added (path:
/sys/devices/platform/ff180000.serial/tty/ttyS0/hci0/hci0:11/net/bnep0,
iface: bnep0): no ifupdown configuration found.
Feb 22 08:43:33 hostname NetworkManager[194]: <info>
[1519289013.9661] devices removed (path:
/sys/devices/platform/ff180000.serial/tty/ttyS0/hci0/hci0:11/net/bnep0,
iface: bnep0)


--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

Mirza Krak

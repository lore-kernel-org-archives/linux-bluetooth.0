Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALUN+EdnyqB_X0sqV78gL_wd1OGaeNudH8DN7UNwNa5hAjdC-w@mail.gmail.com>
References: <CALUN+EfYdOffOSejMQh3vnLGX1PZmBqMXL8UhvL-UHK_2kZqFA@mail.gmail.com>
	<4717325.0Njt2iLfvL@athlon>
	<CALUN+EcJ4p4kkFDZDyi01iSAwDMv4M1Q=axAPiCb+YOAQ64CNQ@mail.gmail.com>
	<3935781.3YG3puahzJ@athlon>
	<CALUN+EdnyqB_X0sqV78gL_wd1OGaeNudH8DN7UNwNa5hAjdC-w@mail.gmail.com>
Date: Wed, 18 Feb 2015 11:41:01 -0700
Message-ID: <CALUN+Ee3MdSQVKWAo7vaMPG6j0+=mthyMe_EKibh_7+d2r1wpQ@mail.gmail.com>
Subject: Re: android-bluez with usb adapter
From: Keith Conger <keith.conger@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ok, things are looking somewhat better.

It doesn't seem to work in the UI.  But haltest looks good I think.

Here is a logcat from boot to me enable Bluetooth and looking for devices:

########## Start Logcat ##########

adb logcat|grep -i blue

- waiting for device -

W/PackageParser(  595): No actions in intent filter at
/system/app/Bluetooth.apk Binary XML file line #211

W/PackageManager(  595): Unknown permission
com.google.android.gallery3d.permission.GALLERY_PROVIDER in package
com.android.bluetooth

W/PackageManager(  595): Unknown permission
android.permission.MMS_SEND_OUTBOX_MSG in package
com.android.bluetooth

I/SystemServer(  595): No Bluetooh Service (emulator)

W/PackageManager(  595): Unknown permission
com.google.android.gallery3d.permission.GALLERY_PROVIDER in package
com.android.bluetooth

W/PackageManager(  595): Unknown permission
android.permission.MMS_SEND_OUTBOX_MSG in package
com.android.bluetooth

E/BluetoothAdapter(  727): Bluetooth binder is null

E/BluetoothAdapter(  727): Bluetooth binder is null

E/BluetoothAdapter(  654): Bluetooth binder is null

E/BluetoothAdapter(  654): Bluetooth binder is null

E/BluetoothAdapter(  727): Bluetooth binder is null

E/BluetoothAdapter(  654): Bluetooth binder is null

E/BluetoothAdapter(  654): Bluetooth binder is null

E/BluetoothAdapter(  654): Bluetooth binder is null

E/BluetoothAdapter(  717): Bluetooth binder is null

E/BluetoothAdapter(  717): Bluetooth binder is null

E/BluetoothAdapter(  595): Bluetooth binder is null

E/BluetoothAdapter(  595): Bluetooth binder is null

E/BluetoothAdapter(  717): Bluetooth binder is null

D/SubSettings(  717): Launching fragment
com.android.settings.bluetooth.BluetoothSettings

E/BluetoothAdapter(  717): Bluetooth binder is null

E/DeviceListPreferenceFragment(  717): Bluetooth is not supported on this device

########## END Logcat ##########





With haltest, it appears to work fine:


########## Start haltest session ##########
root@beagleboneblack:/ # haltest

hw_get_module_by_class returned -2

hw_get_module_by_class returned -2

thread_evt_cb: evt=ASSOCIATE_JVM

if_bluetooth->init: BT_STATUS_SUCCESS

get_profile_interface(handsfree) : 0xb6e2a134

get_profile_interface(a2dp) : 0xb6e2a0ec

get_profile_interface(avrcp) : 0xb6e2a100

get_profile_interface(health) : 0xb6e2a3d0

get_profile_interface(hidhost) : 0xb6e2a0a0

get_profile_interface(pan) : 0xb6e2a0d0

get_profile_interface(gatt) : 0xb6e2a1ac

get_profile_interface(socket) : 0xb6e2a094

if_av->init: BT_STATUS_SUCCESS

if_rc->init: BT_STATUS_SUCCESS

adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1

prop: type=BT_PROPERTY_UUIDS len=80 val={0000110e, 0000110c, 0000110a,
0000113b, 00001200}

if_gatt->init: BT_STATUS_FAIL

adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1

prop: type=BT_PROPERTY_UUIDS len=80 val={0000110e, 0000110c, 0000110a,
0000113b, 00001200}

adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1

prop: type=BT_PROPERTY_UUIDS len=80 val={0000110e, 0000110c, 0000110a,
0000113b, 00001200}

if_hf->init: BT_STATUS_SUCCESS

adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1

prop: type=BT_PROPERTY_UUIDS len=96 val={00001112, 0000110e, 0000110c,
0000110a, 0000113b, 00001200}

if_hh->init: BT_STATUS_SUCCESS

if_pan->init: BT_STATUS_SUCCESS

adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1

prop: type=BT_PROPERTY_UUIDS len=128 val={00001115, 00001116,
00001112, 0000110e, 0000110c, 0000110a, 0000113b, 00001200}

adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1

prop: type=BT_PROPERTY_UUIDS len=128 val={00001115, 00001116,
00001112, 0000110e, 0000110c, 0000110a, 0000113b, 00001200}

if_hl->init: BT_STATUS_SUCCESS

> bluetooth init

if_bluetooth->init: BT_STATUS_DONE

> bluetooth enable

adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=9

prop: type=BT_PROPERTY_BDADDR len=6 val=00:18:e7:36:36:e9

prop: type=BT_PROPERTY_BDNAME len=16 val=BeagleBone Black

prop: type=BT_PROPERTY_CLASS_OF_DEVICE len=4 val=000000

prop: type=BT_PROPERTY_TYPE_OF_DEVICE len=4 val=BT_DEVICE_DEVTYPE_BREDR

prop: type=BT_PROPERTY_ADAPTER_SCAN_MODE len=4 val=BT_SCAN_MODE_NONE

prop: type=BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT len=4 val=120

prop: type=BT_PROPERTY_ADAPTER_BONDED_DEVICES len=0 val={}

prop: type=BT_PROPERTY_UUIDS len=128 val={00001115, 00001116,
00001112, 0000110e, 0000110c, 0000110a, 0000113b, 00001200}

prop: type=(unknown) len=8 val=0xb6e1da5d

if_bluetooth->enable: BT_STATUS_SUCCESS

adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1

prop: type=BT_PROPERTY_CLASS_OF_DEVICE len=4 val=0a020c

adapter_state_changed_cb: state=BT_STATE_ON

> bluetooth start_discovery

if_bluetooth->start_discovery: BT_STATUS_SUCCESS

discovery_state_changed_cb: state=BT_DISCOVERY_STARTED

device_found_cb: num_properties=5

prop: type=BT_PROPERTY_BDADDR len=6 val=ec:88:92:c3:1e:48

prop: type=BT_PROPERTY_TYPE_OF_DEVICE len=4 val=BT_DEVICE_DEVTYPE_BREDR

prop: type=BT_PROPERTY_CLASS_OF_DEVICE len=4 val=5a020c

prop: type=BT_PROPERTY_REMOTE_RSSI len=4 val=216

prop: type=BT_PROPERTY_BDNAME len=17 val=EC:88:92:C3:1E:48

remote_device_properties_cb: status=BT_STATUS_SUCCESS
bd_addr=ec:88:92:c3:1e:48 num_properties=1

prop: type=BT_PROPERTY_BDNAME len=7 val=Nexus 6

discovery_state_changed_cb: state=BT_DISCOVERY_STOPPED

########## End haltest session ##########

On Wed, Feb 18, 2015 at 9:01 AM, Keith Conger <keith.conger@gmail.com> wrote:
> Sorry, about forgetting to reply-all.
>
> I'll give your suggestions a try and report back.
>
> Thanks for the help,
> Keith
>
> On Wed, Feb 18, 2015 at 12:34 AM, Szymon Janc <szymon.janc@gmail.com> wrote:
>> Hi Keith,
>>
>> (lets keep mailing list in CC)
>>
>> On Tuesday 17 February 2015 15:00:02 Keith Conger wrote:
>>> Thanks for getting back to me.  I did skip the hciattach part and I
>>> have verified /system/lib/bluetooth.default.so exists. When enabling
>>> via the UI I just see the following in the log:
>>
>> bluetooth.default.so should be in /system/lib/hw/
>>
>> This lib is loaded via hw_get_module().
>> (I'm not sure why this wasn't installed there - it should if you used our
>> Android.mk)
>>
>>>
>>> E/BluetoothAdapter( 1109): Bluetooth binder is null
>>> E/DeviceListPreferenceFragment( 1109): Bluetooth is not supported on this
>>> device
>>>
>>> I have attached a zip of my init scripts I'm using, I'm I missing anything?
>>
>> I'd make it a bit simpler:
>> - load modules directly from init.rc on boot
>> - remove this init.genericam33x.bt.rc file.
>>   this magic is not needed with btusb, also bluetoothd will power up device on
>>   start and power down on shutdown.
>> - remove init.bt.sh (not needed if you load module on init)
>> - import init.bluetooth.rc directly from you init.fooboard.rc file
>>
>>> Thanks again for your help!
>>> Keith
>>>
>>> On Tue, Feb 17, 2015 at 2:47 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
>>> > Hi Keith,
>>> >
>>> > On Tuesday 17 February 2015 14:16:37 Keith Conger wrote:
>>> >> I'm trying to swap out bluedroid with android-bluez to add bluetooth
>>> >> usb adapter support into KitKat for my Beaglebone Black(ARM). Should
>>> >> this be possible?
>>> >
>>> > Yeap, this is possible.
>>> >
>>> >> I followed this guide,
>>> >> http://forum.xda-developers.com/showthread.php?t=2640723 skipping the
>>> >> CSR parts.
>>> >>
>>> >> Here is a logcat with debugging enabled.  I've googled the errors and
>>> >> have had no luck.  Does anyone have any ideas?
>>> >>
>>> >> I/bluetoothd( 1072): Bluetooth daemon 5.28
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/main.c:set_capabilities() Caps: eff:
>>> >> 0x3400, perm: 0x3400, inh: 0x0
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:bt_bluetooth_start()
>>> >> index -1
>>> >>
>>> >> I/bluetoothd( 1072): Starting SDP server
>>> >>
>>> >> D/bluetoothd( 1072): external/bluetooth/bluez/android/main.c:main()
>>> >> Entering main loop
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0xffff] command 0x0001
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 01 00 ff ff 00 00
>>> >>
>>> >>           ..??..
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 ff ff 06 00 01 00 00 01 07 00
>>> >>
>>> >>           ..??........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0xffff] command 0x0001 complete: 0x00
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:read_version_complete()
>>> >>
>>> >> I/bluetoothd( 1072): Bluetooth management interface 1.7 initialized
>>> >>
>>> >> I/bluetoothd( 1072): Kernel connection control will be used
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0xffff] command 0x0003
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 03 00 ff ff 00 00
>>> >>
>>> >>           ..??..
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 ff ff 07 00 03 00 00 01 00 00 00
>>> >>
>>> >>           ..??.........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0xffff] command 0x0003 complete: 0x00
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:read_index_list_complete()
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:read_index_list_complete()
>>> >> Number of controllers: 1
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0004
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 04 00 00 00 00 00
>>> >>
>>> >>           ......
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 1b 01 04 00 00 e9 36 36 e7
>>> >> 18 00 03  .........?66?...
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   0f 00 bf 10 00 00 90 00 00 00 00 00 00
>>> >> 42 43 4d  ..?..........BCM
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   32 30 34 35 42 33 00 00 00 00 00 00 00
>>> >> 00 00 00  2045B3..........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00
>>> >>
>>> >>           .
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0004 complete: 0x00
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:read_info_complete()
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/src/sdpd-service.c:register_device_id()
>>> >> Adding device id record for 0002:1d6b:0247:051c
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/src/sdpd-service.c:add_record_to_server()
>>> >> Adding record with handle 0x10001
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/src/sdpd-service.c:add_record_to_server()
>>> >> Record pattern UUID 00001002-0000-1000-8000-00805f9
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/src/sdpd-service.c:add_record_to_server()
>>> >> Record pattern UUID 0000113a-0000-1000-8000-00805f9
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/src/sdpd-service.c:add_record_to_server()
>>> >> Record pattern UUID 0000113b-0000-1000-8000-00805f9
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:load_ltks() ltks 0
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:load_irks() irks 0
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:load_link_keys() keys 0
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x000e
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 0e 00 00 00 02 00 02 0c
>>> >>
>>> >>           ........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 06 00 0e 00 00 00 00 00
>>> >>
>>> >>           ............
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x000e complete: 0x00
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0011
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 11 00 00 00 10 00 00 00 00 00 00 00 00
>>> >> 00 00 00  ................
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 00 00 00
>>> >>
>>> >>           ......
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 06 00 11 00 00 00 00 00
>>> >>
>>> >>           ............
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0011 complete: 0x00
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0034
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 34 00 00 00 07 00 00 00 00 00 00 00 00
>>> >>
>>> >>           4............
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 0a 00 34 00 00 00 00 00 00
>>> >> 00 00 00  ......4.........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0034 complete: 0x00
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0018
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 18 00 00 00 01 00 01
>>> >>
>>> >>           .......
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 03 00 18 00 00
>>> >>
>>> >>           .........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0018 complete: 0x00
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0028
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 28 00 00 00 08 00 02 00 6b 1d 47 02 1c
>>> >> 05        (.......k.G...
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 03 00 28 00 00
>>> >>
>>> >>           ......(..
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0028 complete: 0x00
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0010
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 10 00 00 00 11 00 fb 34 9b 5f 80 00 00
>>> >> 80 00 10  ......?4._......
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 00 12 00 00 00
>>> >>
>>> >>           .......
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 06 00 10 00 00 00 00 00
>>> >>
>>> >>           ............
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0010 complete: 0x00
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0010
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 10 00 00 00 11 00 fb 34 9b 5f 80 00 00
>>> >> 80 00 10  ......?4._......
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if:   00 00 3b 11 00 00 00
>>> >>
>>> >>           ..;....
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 06 00 10 00 00 00 00 00
>>> >>
>>> >>           ............
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0010 complete: 0x00
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0013
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 13 00 00 00 02 00 00 00
>>> >>
>>> >>           ........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 02 00 00 00 03 00 13 00 0c
>>> >>
>>> >>           .........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x13 status: 0x0c
>>> >>
>>> >> I/bluetoothd( 1072): Failed to load LTKs: Not Supported (0x0c)
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0030
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 30 00 00 00 02 00 00 00
>>> >>
>>> >>           0.......
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 02 00 00 00 03 00 30 00 0c
>>> >>
>>> >>           ......0..
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x30 status: 0x0c
>>> >>
>>> >> I/bluetoothd( 1072): Failed to load IRKs: Not Supported (0x0c)
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0012
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 12 00 00 00 03 00 00 00 00
>>> >>
>>> >>           .........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 03 00 12 00 00
>>> >>
>>> >>           .........
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0012 complete: 0x00
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/bluetooth.c:load_link_keys_complete()
>>> >> status 0
>>> >>
>>> >> I/bluetoothd( 1072): Adapter initialized
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/ipc.c:cmd_connect_cb()
>>> >>
>>> >> E/bluetoothd( 1072): IPC: command socket connect failed
>>> >>
>>> >> I/bluetoothd( 1072): Switching controller off
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0005
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: < 05 00 00 00 01 00 00
>>> >>
>>> >>           .......
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: > 01 00 00 00 07 00 05 00 00 90 00 00 00
>>> >>
>>> >>           .............
>>> >>
>>> >> I/bluetoothd( 1072): mgmt_if: [0x0000] command 0x0005 complete: 0x00
>>> >>
>>> >> D/bluetoothd( 1072):
>>> >> external/bluetooth/bluez/android/main.c:cleanup_services()
>>> >>
>>> >> I/bluetoothd( 1072): Stopping SDP server
>>> >>
>>> >> I/bluetoothd( 1072): Exit
>>> >
>>> > This log looks OK. Adapter was found and initialized. Only problem is that
>>> > there was no IPC socket listening for it to connect.
>>> >
>>> > On Android bluetoothd is not suppose to be started 'by hand'. It needs to
>>> > be started as service defined in init.rc (check android/README and
>>> > android/init.bluetooth.rc). This service is started via
>>> > bluetooth.default.so provided by BlueZ (this is implementation ofn
>>> > Android Bluetooth HAL interface). When bluetoothd starts and initializes
>>> > adapter it tries to connect IPC to this library. If lib is not loaded
>>> > (and there is no socket to connect to) bluetoothd shuts down.
>>> >
>>> > This library is loaded by Android Framework and when you enable BT from UI
>>> > lib will be initialized and daemon will be started. Other option for
>>> > testing is our test tool called haltest. This is command line tool that
>>> > will load bt lib and allow you to play with bt stack (this tool doesn't
>>> > use Android Framework).>
>>> > So what you should check:
>>> >  - you have init.bluetooth.rc in /
>>> >  - this file is included from your board init.foo.rc file
>>> >  - daemon and bluetooth.default.so are installed on system (this should be
>>> >
>>> >    handled just fine by Android.mk provided by BlueZ)
>>> >
>>> >  - you don't need hciattach service - this is not needed with btusb
>>> >
>>> > --
>>> > Szymon K. Janc
>>> > szymon.janc@gmail.com
>>
>> --
>> Szymon K. Janc
>> szymon.janc@gmail.com
>
>
>
> --
> Keith Conger
> keith DOT conger AT gmail DOT com
> http://thecongers.org



-- 
Keith Conger
keith DOT conger AT gmail DOT com
http://thecongers.org

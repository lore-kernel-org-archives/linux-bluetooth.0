Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Keith Conger <keith.conger@gmail.com>
Cc: Szymon Janc <szymon.janc@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: android-bluez with usb adapter
Date: Wed, 18 Feb 2015 20:52:06 +0100
Message-ID: <11216650.UM2e8dqFFR@leonov>
In-Reply-To: <CALUN+Ee3MdSQVKWAo7vaMPG6j0+=mthyMe_EKibh_7+d2r1wpQ@mail.gmail.com>
References: <CALUN+EfYdOffOSejMQh3vnLGX1PZmBqMXL8UhvL-UHK_2kZqFA@mail.gmail.com> <CALUN+EdnyqB_X0sqV78gL_wd1OGaeNudH8DN7UNwNa5hAjdC-w@mail.gmail.com> <CALUN+Ee3MdSQVKWAo7vaMPG6j0+=mthyMe_EKibh_7+d2r1wpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

On Wednesday 18 of February 2015 11:41:01 Keith Conger wrote:
> Ok, things are looking somewhat better.
> 
> It doesn't seem to work in the UI.  But haltest looks good I think.
> 
> Here is a logcat from boot to me enable Bluetooth and looking for devices:
> 
> ########## Start Logcat ##########
> 
> adb logcat|grep -i blue
> 
> - waiting for device -
> 
> W/PackageParser(  595): No actions in intent filter at
> /system/app/Bluetooth.apk Binary XML file line #211
> 
> W/PackageManager(  595): Unknown permission
> com.google.android.gallery3d.permission.GALLERY_PROVIDER in package
> com.android.bluetooth
> 
> W/PackageManager(  595): Unknown permission
> android.permission.MMS_SEND_OUTBOX_MSG in package
> com.android.bluetooth
> 
> I/SystemServer(  595): No Bluetooh Service (emulator)
> 
> W/PackageManager(  595): Unknown permission
> com.google.android.gallery3d.permission.GALLERY_PROVIDER in package
> com.android.bluetooth
> 
> W/PackageManager(  595): Unknown permission
> android.permission.MMS_SEND_OUTBOX_MSG in package
> com.android.bluetooth
> 
> E/BluetoothAdapter(  727): Bluetooth binder is null
> 
> E/BluetoothAdapter(  727): Bluetooth binder is null
> 
> E/BluetoothAdapter(  654): Bluetooth binder is null
> 
> E/BluetoothAdapter(  654): Bluetooth binder is null
> 
> E/BluetoothAdapter(  727): Bluetooth binder is null
> 
> E/BluetoothAdapter(  654): Bluetooth binder is null
> 
> E/BluetoothAdapter(  654): Bluetooth binder is null
> 
> E/BluetoothAdapter(  654): Bluetooth binder is null
> 
> E/BluetoothAdapter(  717): Bluetooth binder is null
> 
> E/BluetoothAdapter(  717): Bluetooth binder is null
> 
> E/BluetoothAdapter(  595): Bluetooth binder is null
> 
> E/BluetoothAdapter(  595): Bluetooth binder is null
> 
> E/BluetoothAdapter(  717): Bluetooth binder is null
> 
> D/SubSettings(  717): Launching fragment
> com.android.settings.bluetooth.BluetoothSettings
> 
> E/BluetoothAdapter(  717): Bluetooth binder is null
> 
> E/DeviceListPreferenceFragment(  717): Bluetooth is not supported on this
> device
> 
> ########## END Logcat ##########
> 
> 
> 
> 
> 
> With haltest, it appears to work fine:
> 
> 
> ########## Start haltest session ##########
> root@beagleboneblack:/ # haltest
> 
> hw_get_module_by_class returned -2
> 
> hw_get_module_by_class returned -2
> 
> thread_evt_cb: evt=ASSOCIATE_JVM
> 
> if_bluetooth->init: BT_STATUS_SUCCESS
> 
> get_profile_interface(handsfree) : 0xb6e2a134
> 
> get_profile_interface(a2dp) : 0xb6e2a0ec
> 
> get_profile_interface(avrcp) : 0xb6e2a100
> 
> get_profile_interface(health) : 0xb6e2a3d0
> 
> get_profile_interface(hidhost) : 0xb6e2a0a0
> 
> get_profile_interface(pan) : 0xb6e2a0d0
> 
> get_profile_interface(gatt) : 0xb6e2a1ac
> 
> get_profile_interface(socket) : 0xb6e2a094
> 
> if_av->init: BT_STATUS_SUCCESS
> 
> if_rc->init: BT_STATUS_SUCCESS
> 
> adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1
> 
> prop: type=BT_PROPERTY_UUIDS len=80 val={0000110e, 0000110c, 0000110a,
> 0000113b, 00001200}
> 
> if_gatt->init: BT_STATUS_FAIL
> 
> adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1
> 
> prop: type=BT_PROPERTY_UUIDS len=80 val={0000110e, 0000110c, 0000110a,
> 0000113b, 00001200}
> 
> adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1
> 
> prop: type=BT_PROPERTY_UUIDS len=80 val={0000110e, 0000110c, 0000110a,
> 0000113b, 00001200}
> 
> if_hf->init: BT_STATUS_SUCCESS
> 
> adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1
> 
> prop: type=BT_PROPERTY_UUIDS len=96 val={00001112, 0000110e, 0000110c,
> 0000110a, 0000113b, 00001200}
> 
> if_hh->init: BT_STATUS_SUCCESS
> 
> if_pan->init: BT_STATUS_SUCCESS
> 
> adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1
> 
> prop: type=BT_PROPERTY_UUIDS len=128 val={00001115, 00001116,
> 00001112, 0000110e, 0000110c, 0000110a, 0000113b, 00001200}
> 
> adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1
> 
> prop: type=BT_PROPERTY_UUIDS len=128 val={00001115, 00001116,
> 00001112, 0000110e, 0000110c, 0000110a, 0000113b, 00001200}
> 
> if_hl->init: BT_STATUS_SUCCESS
> 
> > bluetooth init
> 
> if_bluetooth->init: BT_STATUS_DONE
> 
> > bluetooth enable
> 
> adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=9
> 
> prop: type=BT_PROPERTY_BDADDR len=6 val=00:18:e7:36:36:e9
> 
> prop: type=BT_PROPERTY_BDNAME len=16 val=BeagleBone Black
> 
> prop: type=BT_PROPERTY_CLASS_OF_DEVICE len=4 val=000000
> 
> prop: type=BT_PROPERTY_TYPE_OF_DEVICE len=4 val=BT_DEVICE_DEVTYPE_BREDR
> 
> prop: type=BT_PROPERTY_ADAPTER_SCAN_MODE len=4 val=BT_SCAN_MODE_NONE
> 
> prop: type=BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT len=4 val=120
> 
> prop: type=BT_PROPERTY_ADAPTER_BONDED_DEVICES len=0 val={}
> 
> prop: type=BT_PROPERTY_UUIDS len=128 val={00001115, 00001116,
> 00001112, 0000110e, 0000110c, 0000110a, 0000113b, 00001200}
> 
> prop: type=(unknown) len=8 val=0xb6e1da5d
> 
> if_bluetooth->enable: BT_STATUS_SUCCESS
> 
> adapter_properties_cb: status=BT_STATUS_SUCCESS num_properties=1
> 
> prop: type=BT_PROPERTY_CLASS_OF_DEVICE len=4 val=0a020c
> 
> adapter_state_changed_cb: state=BT_STATE_ON
> 
> > bluetooth start_discovery
> 
> if_bluetooth->start_discovery: BT_STATUS_SUCCESS
> 
> discovery_state_changed_cb: state=BT_DISCOVERY_STARTED
> 
> device_found_cb: num_properties=5
> 
> prop: type=BT_PROPERTY_BDADDR len=6 val=ec:88:92:c3:1e:48
> 
> prop: type=BT_PROPERTY_TYPE_OF_DEVICE len=4 val=BT_DEVICE_DEVTYPE_BREDR
> 
> prop: type=BT_PROPERTY_CLASS_OF_DEVICE len=4 val=5a020c
> 
> prop: type=BT_PROPERTY_REMOTE_RSSI len=4 val=216
> 
> prop: type=BT_PROPERTY_BDNAME len=17 val=EC:88:92:C3:1E:48
> 
> remote_device_properties_cb: status=BT_STATUS_SUCCESS
> bd_addr=ec:88:92:c3:1e:48 num_properties=1
> 
> prop: type=BT_PROPERTY_BDNAME len=7 val=Nexus 6
> 
> discovery_state_changed_cb: state=BT_DISCOVERY_STOPPED
> 
> ########## End haltest session ##########

This looks OK. You just need to reboot your board and UI should also be 
working.

This is due to Android doing test BT start while booting and if that failed it 
won't try to load BT HAL again.

Also note that you cannot run BT from UI and haltest at the same.

-- 
BR
Szymon Janc

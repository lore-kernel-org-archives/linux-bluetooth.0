Return-Path: <cyrus@holtmann.org>
Message-ID: <88de30607cc30c5d6e25e43bd6965da0.squirrel@iwavesystems.com>
In-Reply-To: <2de8f187df4e6d13765677ed44c1ddbc.squirrel@iwavesystems.com>
References: <2de8f187df4e6d13765677ed44c1ddbc.squirrel@iwavesystems.com>
Date: Tue, 8 Sep 2015 09:04:18 -0400
Subject: Re: USB  BT gives problem If device plugged during boot to
 platform.
From: krishnaks@iwavesystems.com
To: krishnaks@iwavesystems.com
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>>> Hi,
>>>
>>>> I am porting bluez 5.33 to android kitkat 4.4.3.I am using USB based
>>>> Bluetooth device. I referred instruction in
>>>> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/README and
>>>> able to build.
>>>> After botting Android image with USB dongle connected and type
>>>> "hciconfig
>>>> hci0 up" on console, It is throwing following error.
>>>> Can't init device hci0: Unknown error 132 (132)
>>>>
>>>> If I Type hciconfig -a . It gives following.
>>>> hci0:   Type: BR/EDR  Bus: USB
>>>>        BD Address: 5C:F3:70:6C:5E:FB  ACL MTU: 1021:8  SCO MTU: 64:1
>>>>        DOWN
>>>>        RX bytes:547 acl:0 sco:0 events:27 errors:0
>>>>        TX bytes:384 acl:0 sco:0 commands:27 errors:0
>>>>        Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
>>>>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>>>        Link policy: RSWITCH SNIFF
>>>>        Link mode: SLAVE ACCEPT
>>>>
>>>>
>>>>
>>>> But If I unplug and plug USB dongle, and then try same command
>>>> (hciconfig
>>>> hci0 up), It works. Even "hcitool scan" command also working after
>>>> that.
>>>>
>>>> Why 1st time not working when USB dongle is connected?
>>>> Also when I check Bluez debug log in logcat.
>>>> I am getting one error log when USB dongle connected during boot.
>>>> E/bluetoothd(  841): Failed to set mode: Blocked through rfkill
>>>> (0x12).
>>>
>>> I think that blocked through rfkill is pretty obvious. Check with the
>>> rfkill tool on what the current settings are. For some reason it seems
>>> Bluetooth is blocked by default. And I remember there were some kernel
>>> patches for this. Just do not remember the details.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-bluetooth"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> Hi,
>>
>> Thanks for the reply.
>>
>> In my busybox utils rfkill is not enabled. If I enable it and try
>> "rfkill
>> unblock" is that will be enough? or I need to search for Kernel patch
>> that
>> fixes this rfkill block issue?
>
> Hi,
>
> By Analysing I found 3 scenarios and only in one scenario BT is working.
> Scenario 1 : Connect USB BT Dongle and then boot the android device.Then
> Turn on from Android Bluetooth settings
>
> Result: Not working. Rfkill block error.
> E/bluetoothd(  868): Failed to set mode: Blocked through rfkill (0x12)
>
> Scenario 2: Connect USB BT Dongle and boot. Then unplug and plug again.
> Then Turn on from Android Bluetooth settings.
>
> Result: Working: BT turning on and scanning BT/BLE devices.
>
> Scenario 3: Boot Android device and then plug the USB BT Dongle.Then Turn
> on from Android Bluetooth settings.
>
> Result: Not working. Here we are not getting any debug prints from bluez.
> Whether we need to rerun the init.bluetooth.rc as BT Dongle was not
> connected during boot.
> From Logcat,observing following error messages
>   IBluetooth.configHciSnoopLog return false
>   Bluetooth module is not loaded
>
> Logcat:
>
> -------------------Start-------------------
> D/BluetoothManagerService(  543): enable():  mBluetooth =null mBinding =
> false
> D/BluetoothManagerService(  543): Message: 1
> D/BluetoothManagerService(  543): MESSAGE_ENABLE: mBluetooth = null
> D/BluetoothAdapterService( 1032): REFCOUNT: CREATED. INSTANCE_COUNT2
> D/BluetoothAdapterState( 1032): make
> I/BluetoothAdapterState( 1032): Entering OffState
> D/BluetoothManagerService(  543): BluetoothServiceConnection:
> com.android.bluetooth.btservice.AdapterService
> D/BluetoothManagerService(  543): Message: 40
> D/BluetoothManagerService(  543): MESSAGE_BLUETOOTH_SERVICE_CONNECTED: 1
> E/BluetoothManagerService(  543): IBluetooth.configHciSnoopLog return
> false
> D/BluetoothManagerService(  543): Calling onBluetoothServiceUp callbacks
> D/BluetoothManagerService(  543): Broadcasting onBluetoothServiceUp() to 5
> receivers.
> D/BluetoothAdapterState( 1032): CURRENT_STATE=OFF, MESSAGE = USER_TURN_ON
> D/BluetoothAdapterProperties( 1032): Setting state to 11
> I/BluetoothAdapterState( 1032): Bluetooth adapter state changed: 10-> 11
> D/BluetoothAdapterService( 1032): Broadcasting updateAdapterState() to 1
> receivers.
> D/BluetoothManagerService(  543): Message: 60
> D/BluetoothManagerService(  543): MESSAGE_BLUETOOTH_STATE_CHANGE:
> prevState = 10, newState=11
> D/BluetoothManagerService(  543): Bluetooth State Change Intent: 10 -> 11
> D/BluetoothBondStateMachine( 1032): make
> D/BluetoothMapService( 1032): onReceive
> I/BluetoothBondStateMachine( 1032): StableState(): Entering Off State
> D/HeadsetService( 1032): Received start request. Starting profile...
> D/HeadsetStateMachine( 1032): make
> E/BluetoothHeadsetServiceJni( 1032): Bluetooth module is not loaded
> D/A2dpService( 1032): Received start request. Starting profile...
> V/Avrcp   ( 1032): make
> E/BluetoothAvrcpServiceJni( 1032): Bluetooth module is not loaded
> D/A2dpStateMachine( 1032): make
> E/BluetoothA2dpServiceJni( 1032): Bluetooth module is not loaded
> D/A2dpStateMachine( 1032): Enter Disconnected: -2
> D/HidService( 1032): Received start request. Starting profile...
> E/BluetoothHidServiceJni( 1032): Bluetooth module is not loaded
> D/HealthService( 1032): Received start request. Starting profile...
> I/BluetoothAdapterState( 1032): Entering PendingCommandState State:
> isTurningOn()=true, isTurningOff()=false
> E/BluetoothHealthServiceJni( 1032): Bluetooth module is not loaded
> D/BluetoothAdapterService( 1032): Profile still not
> running:com.android.bluetooth.hdp.HealthService
> D/PanService( 1032): Received start request. Starting profile...
> D/BluetoothPanServiceJni( 1032): initializeNative(L110): pan
> E/BluetoothPanServiceJni( 1032): ## ERROR : initializeNative(L115):
> Bluetooth module is not loaded##
> D/BluetoothTethering(  543): got CMD_CHANNEL_HALF_CONNECTED
> E/BluetoothTethering(  543): Trying to set mAsyncChannel twice!
> D/BtGatt.DebugUtils( 1032): handleDebugAction() action=null
> D/HeadsetPhoneState( 1032): sendDeviceStateChanged. mService=0 mSignal=0
> mRoam=0 mBatteryCharge=5
> D/BtGatt.GattService( 1032): Received start request. Starting profile...
> D/BtGatt.GattService( 1032): start()
> E/BtGatt.JNI( 1032): ERROR: void android::initializeNative(JNIEnv*,
> jobject)(L694): Bluetooth module is not loaded##
> D/BluetoothAdapterService( 1032): Profile still not
> running:com.android.bluetooth.hdp.HealthService
> D/BluetoothAdapterService( 1032): Profile still not
> running:com.android.bluetooth.hdp.HealthService
> D/BluetoothMapService( 1032): Received start request. Starting profile...
> D/BluetoothMapService( 1032): start()
> D/BluetoothAdapterService( 1032): Profile still not
> running:com.android.bluetooth.map.BluetoothMapService
> D/BluetoothAdapterService( 1032): Profile still not
> running:com.android.bluetooth.map.BluetoothMapService
> D/BluetoothAdapterService( 1032): Profile still not
> running:com.android.bluetooth.map.BluetoothMapService
> D/BluetoothAdapterState( 1032): CURRENT_STATE=PENDING, MESSAGE = STARTED,
> isTurningOn=true, isTurningOff=false
> E/BluetoothAdapterState( 1032): Error while turning Bluetooth On
> D/BluetoothAdapterProperties( 1032): Setting state to 10
> I/BluetoothAdapterState( 1032): Bluetooth adapter state changed: 11-> 10
> D/BluetoothAdapterService( 1032): Broadcasting updateAdapterState() to 1
> receivers.
> I/BluetoothAdapterState( 1032): Entering OffState
> D/BluetoothManagerService(  543): Message: 60
> D/BluetoothManagerService(  543): MESSAGE_BLUETOOTH_STATE_CHANGE:
> prevState = 11, newState=10
> D/BluetoothManagerService(  543): Broadcasting
> onBluetoothStateChange(false) to 10 receivers.
> D/BluetoothA2dp(  543): onBluetoothStateChange: up=false
> D/BluetoothHeadset(  543): onBluetoothStateChange: up=false
> D/BluetoothPbap(  851): onBluetoothStateChange: up=false
> D/BluetoothHeadset(  839): onBluetoothStateChange: up=false
> D/BluetoothMap(  851): onBluetoothStateChange: up=false
> D/BluetoothHeadset(  839): onBluetoothStateChange: up=false
> D/BluetoothHeadset(  839): onBluetoothStateChange: up=false
> D/BluetoothInputDevice(  851): onBluetoothStateChange: up=false
> D/BluetoothManagerService(  543): Bluetooth State Change Intent: 11 -> 10
> E/BluetoothManagerService(  543): recoverBluetoothServiceFromError
> D/BluetoothMapService( 1032): onReceive
> D/DockEventReceiver(  851): finishStartingService: stopping service
> W/ContextImpl(  851): Calling a method in the system process without a
> qualified user: android.app.ContextImpl.startService:1487
> android.content.ContextWrapper.startService:494
> android.content.ContextWrapper.startService:494
> com.android.settings.bluetooth.DockEventReceiver.beginStartingService:134
> com.android.settings.bluetooth.DockEventReceiver.onReceive:115
> D/BluetoothManagerService(  543): Sending off request.
> D/BluetoothAdapterState( 1032): CURRENT_STATE=OFF, MESSAGE = USER_TURN_OFF
> D/BluetoothManagerService(  543): Calling onBluetoothServiceDown callbacks
> D/BluetoothManagerService(  543): Broadcasting onBluetoothServiceDown() to
> 5 receivers.
> D/BluetoothAdapterService( 1032): Cleaning up adapter native....
> D/BluetoothAdapterService( 1032): Done cleaning up adapter native....
> D/BluetoothAdapterService(746876560)( 1032): ****onDestroy()********
>
> -------------------End---------------------
>
> For Scenario 1 , I am trying to build rfkill tool for android(Currently no
> success). Can we change the state from code by opening rfkill path
> "/sys/class/rfkill/rfkill0/state" and write 1 to enable?
>
> But scenario 3 looks like I missed some configuration.
>
> What could be the problem?
>
> Regards,
> KP
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



Hi All,


I analysed the Android flow and found that Android System server will
initialize and check for bluetooth hardware on during Boot. So if we
connect the USB BT Dongle after boot Android BT service may not identify
it.
May be this is the reason because of which scenario 3 (Boot Android device
and then plug the USB BT Dongle.Then Turn on from Bluetooth setting) is
not working.
This is my understanding. Correct me If I am wrong.

Anyone tried USB BT pnp on android?

Regards,
KP

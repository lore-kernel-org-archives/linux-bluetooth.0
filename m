Return-Path: <cyrus@holtmann.org>
Message-ID: <cc6ce416e935cb348f250e29710e1830.squirrel@iwavesystems.com>
In-Reply-To: <3088225.58tBxefHLJ@leonov>
References: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
    <5a4e8eadcfd668fabdcd350e63a65308.squirrel@iwavesystems.com>
    <d2ec8d829215f8a06d693dd61ec226a2.squirrel@iwavesystems.com>
    <3088225.58tBxefHLJ@leonov>
Date: Fri, 4 Sep 2015 08:45:12 -0400
Subject: Re: StartLescan rerturns false
From: krishnaks@iwavesystems.com
To: "Szymon Janc" <ext.szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi,
>
> On Thursday 03 of September 2015 10:00:14 krishnaks@iwavesystems.com
> wrote:
>> > Hi,
>> >
>> > I have ported bluez to Android Kitkat 4.4.3 and I am testing Bluetooth
>> Low
>> > energy from android application.
>> > BluetoothAdapter's method startLeScan returns false during scanning
>> BLE
>> > devices.
>> > register-client method is getting called in hal-gatt.c. But looks like
>> > "scanStarted" function is returning false.
>> >
>> > Have anyone faced this issue.
>> >
>> > Thanks in advance
>> > KP
>>
>> Hi All,
>>
>> From the Android Logcat I found that GATT JNI is failing to initialize
>>
>> E/BtGatt.JNI(  833): ERROR: void android::initializeNative(JNIEnv*,
>> jobject)(L718): Failed to initialize Bluetooth GATT, status: 1##
>>
>> Is this could be the reason for startlescan to return false?
>
> Yes, profile must be initialized if you want to use it.
>
>> Regards,
>> KP
>>
>> ----------------Log----------------------
>> I/BtGatt.JNI(  833): void android::classInitNative(JNIEnv*,
>> jclass)(L684):
>> classInitNative: Success!
>> D/BtGatt.DebugUtils(  833): handleDebugAction() action=null
>> D/BtGatt.GattService(  833): Received start request. Starting profile...
>> D/BtGatt.GattService(  833): start()
>> D/BlueZ   (  833):
>> external/bluetooth/bluez/android/hal-bluetooth.c:get_profile_interface()
>> gatt
>> D/BlueZ   (  833): external/bluetooth/bluez/android/hal-gatt.c:init()
>> E/BtGatt.JNI(  833): ERROR: void android::initializeNative(JNIEnv*,
>> jobject)(L718): Failed to initialize Bluetooth GATT, status: 1##
>> I/ActivityManager(  523): Start proc com.android.mms for broadcast
>> com.android.mms/.transaction.MmsSystemEventReceiver: pid=897
>> D/BLE     ( 1233): Before LE Scan statusfalse
>> D/BluetoothAdapter( 1233): startLeScan(): null
>> D/BtGatt.GattService( 1059): registerClient123() -
>> UUID=e7db8dc6-dc0b-41ff-b036-41b761fd4837
>> I/audio_hw_primary(  188): start_output_stream... 2016291600, device 2
>> W/audio_hw_primary(  188): card 1, port 0 device 0x2
>> W/audio_hw_primary(  188): rate 48000, channel 2 period_size 0xc0
>> W/audio_hw_primary(  188): do_out_standby... 2016291600
>> D/BLE     ( 1233): After LE Scan statusfalse
>> --------------Log--------------
>
> There is no daemon logs here but my guess would be that required crypto
> stuff
> is missing in kernel. Check "Linux Kernel requirements" section in
> android/README for list of required kernel options.
>
> --
> BR
> Szymon Janc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi,

Thanks for your suggestion. That was the problem.
CONFIG_CRYPTO_USER_API_HASH was not enabled to Kernel. Now BLE scanning is
working.

Thanks a lot.

Regards,
KP



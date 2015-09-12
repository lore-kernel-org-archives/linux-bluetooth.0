Return-Path: <cyrus@holtmann.org>
Subject: Re: USB  BT gives problem If device plugged during boot to platform.
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=US-ASCII
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <7606666c5083217bbf33b5a55320c909.squirrel@iwavesystems.com>
Date: Sat, 12 Sep 2015 11:21:44 +0100
Cc: Szymon Janc <ext.szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <8F334E2E-98C7-4901-9ED2-574454D383DF@holtmann.org>
References: <2de8f187df4e6d13765677ed44c1ddbc.squirrel@iwavesystems.com> <4063128.4B3eOl7Vlx@leonov> <96b3bf017c42c6e749a0158c73c3084f.squirrel@iwavesystems.com> <2103677.klfxQc4oJG@leonov> <336be718ceb9032e815edb547726b5ef.squirrel@iwavesystems.com> <7606666c5083217bbf33b5a55320c909.squirrel@iwavesystems.com>
To: krishnaks@iwavesystems.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> I just checked BT enable flow from android and found that
>> When USB BT Dongle is not connected during bootm,During Bluez Init
>> (hal-bluetooth.c:init()), hal_ipc_accept is failing.
>> I hope IPC is failing as USB BT dongle is not connected.
>> 
>> From below Logcat suggests that
>> E/BlueZ   (  799): bluetoothd connect timeout
>> E/BluetoothServiceJni(  799): Error while setting the callbacks
>> E/BluetoothAdapterState(  799): Error while turning Bluetooth On
>> 
>> because of this none of the BT interfaces are initialized.
>> 
>> When we connect the USB BT dongle , hal-bluetooth.c:init() is not getting
>> called. because of this BT enable is failing.
>> 
>> 
>> But in working case (USB BT dongle connected during boot). Each time when
>> we connect BT dongle, init is getting called.
>> 
>> I also observed that If I remove the USB dongle without turning off BT
>> from android BT settings menu, at that time
>> also init is not getting called and because of that BT will not get
>> enabled properly.
>> 
>> If we make "init" function to call whenever BT dongle it connected, is
>> that will be enough for BT HAL module to work
>> properly or any other settings might be required?
>> 
> 
> I have added call to init and get_profile_interface function in Android
> JNI in enable Function so that we can initialize the BT HAL.
> With this change BT is turning on even if I connect the dongle after Boot.
> 
> Thanks for the support.
> 
> I observed one more issue when I connect different USB dongle. Was getting
> "Bluetooth address mismatch" error as in cache previous connected USB BT
> hardware address is saved.
> 
> Is that check required? After bypassing that check, BT is working with
> different USB dongle also.

for a lot of Bluetooth controllers we have support for Set Public Address management command. If the kernel driver provides the vendor specific hdev->set_bdaddr callback, then in theory you can have BlueZ for Android programming the address into the controller even if you swap it out.

If you do that, then you would not see this message. However that is just how Android handles things and we have to deal with it. Feel free to send patches to start supporting Set Public Address handling.

Regards

Marcel



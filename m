Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC 1/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BD791E25-F8C4-4A29-A76F-7C6089DF3B29@holtmann.org>
Date: Mon, 21 Jul 2014 16:13:30 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D76A5409-CE06-40FE-8EDC-4EED54659773@holtmann.org>
References: <1405750008-7652-1-git-send-email-armansito@chromium.org> <1405750008-7652-2-git-send-email-armansito@chromium.org> <BD791E25-F8C4-4A29-A76F-7C6089DF3B29@holtmann.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> This patch proposes changes to the currently unimplemented GATT D-Bus API for
>> desktop bluetoothd. This is the first step in implementing a GATT client layer
>> for bluetoothd that will change the way remote attributes are accessed via
>> bluetoothd plugins and external applications.
>> ---
>> doc/gatt-api.txt | 118 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>> 1 file changed, 104 insertions(+), 14 deletions(-)
>> 
>> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
>> index 8c7975c..bec9674 100644
>> --- a/doc/gatt-api.txt
>> +++ b/doc/gatt-api.txt
>> @@ -32,6 +32,25 @@ Properties	string UUID [read-only]
>> 
>> 			128-bit service UUID.
>> 
>> +		boolean Primary [read-only]
>> +
>> +			Indicates whether or not this GATT service is a
>> +			primary service. If false, the service is secondary.
> 
> this makes total sense. We most likely never worried about it since all devices these days have everything set as primary service.
> 
>> +
>> +		object Device [read-only, optional]
>> +
>> +			Object path of the Bluetooth device the service
>> +			belongs to. Only present on services from remote
>> +			devices.
> 
> I am not sure this is needed. What do you want to use it for?
> 
>> +
>> +		array{object} Characteristics [read-only]
>> +
>> +			Array of object paths representing the characteristics
>> +			of this service. This property is set only when the
>> +			characteristic discovery has been completed, however the
>> +			characteristic objects will become available via
>> +			ObjectManager as soon as they get discovered.
>> +
> 
> I really wonder if this is a good idea. Why not delay announcing any service or characteristic via D-Bus as long as the service discovery is still running. I think it makes more sense to allow doing it one way and one way only.
> 
>> 		array{object} Includes [read-only]: Not implemented
>> 
>> 			Array of object paths representing the included
>> @@ -48,6 +67,54 @@ Service		org.bluez
>> Interface	org.bluez.GattCharacteristic1 [Experimental]
>> Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
>> 
>> +Methods		array{byte} ReadValue()
>> +
>> +			Issues a request to read the value of the
>> +			characteristic and returns the value if the
>> +			operation was successful.
>> +
>> +			Possible Errors: org.bluez.Error.Failed
>> +					 org.bluez.Error.InProgress
>> +					 org.bluez.Error.ReadNotPermitted
>> +					 org.bluez.Error.Authentication
>> +					 org.bluez.Error.Authorization
>> +					 org.bluez.Error.Encryption
>> +
>> +		void WriteValue(array{byte} value)
>> +
>> +			Issues a request to write the value of the
>> +			characteristic.
>> +
>> +			Possible Errors: org.bluez.Error.Failed
>> +					 org.bluez.Error.InProgress
>> +					 org.bluez.Error.WriteNotPermitted
>> +					 org.bluez.Error.Authentication
>> +					 org.bluez.Error.Authorization
>> +					 org.bluez.Error.Encryption
> 
> I have objection to adding these two method. However the error codes should be a bit more descriptive on the level AuthenticationRequired or MissingAuthentication. Then again, I think this detail might be better hidden in the daemon.

this should read "no objection". Seems I am swallowing words again ;)

Regards

Marcel


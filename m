Return-Path: <cyrus@holtmann.org>
From: "Gu, Chao Jie" <chao.jie.gu@intel.com>
To: Arman Uguray <armansito@chromium.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: "Marcel Holtmann (marcel@holtmann.org)" <marcel@holtmann.org>
Subject: RE: [RFC v1 1/1] doc/gatt-api: New API properties and methods for
 the GATT D-Bus API.
Date: Mon, 28 Jul 2014 09:17:09 +0000
Message-ID: <3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
 <1405986034-29122-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1405986034-29122-2-git-send-email-armansito@chromium.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,
	In this weekend, I think about this API again , and there is one question =
for you:
	In your new proposal , bluez offer two ways for application to read charac=
teristic value, one is to get property array of value, the other is to use =
ReadValue method.
	For applications, in which condition they use property array of value and =
in which condition they use ReadValue ? will it cause a confusion for user =
when offer two ways for user at the same time?

> I have to disagree here. I think making the DBus.Properties interface wor=
k for this particular case doesn't make the API particularly simpler, in fa=
ct I think it adds unnecessary complexity and ambiguity to the semantics in=
volved. It's not clear, for instance, if Get should always return the cache=
d value or if it should issue a=20
> Read request to the remote end. You suggest making an initial read reques=
t and storing that value and updating it on notifications. What if the char=
acteristic doesn't support notifications but it's value can change? What if=
 the client is implementing a profile that warrants a read request to the r=
emote end to get the
> freshest value on demand?
You said "What if the characteristic doesn't support notifications but it's=
 value can change?" It means cached array of value cannot be trusted in the=
 condition you said exist if this value changes happen not result from writ=
ing to the remote end device.=20
So in my understanding, there is no worth to read characteristic value by p=
roperty array of value, the property's role is just to emit propertychanged=
 signal when write/read/notification operation changes its value. If so, we=
 just define a signal such as ValueUpdated to tell user value has been chan=
ged is ok.

"What if the characteristic doesn't support notifications but it's value ca=
n change?", if this value change just happen only one condition that client=
 write the value to remote, not in which remote change its value itself spo=
ntaneously and not send notification. In fact, Set/Get property also can ac=
hieve the same result as your new proposal. Because the cache value can be =
trusted in this condition. And the cache value is the freshest value becaus=
e client write value to the remote would let cache value send propertychang=
ed signal to refresh itself to newest value.

So there are two API design can be used:
1. array of value property  Get/Set  (This design just happen only one cond=
ition that client write the value to remote, not in which remote change its=
 value itself spontaneously and not send notification.)
2. ReadValue /WriteValue method and signal ValueUpdated=20

However, in the conclusion, array of value property and ReadValue/WriteValu=
e can not be coexist, otherwise that design will result in ambiguity and no=
t make sense.

Thanks
Chaojie
-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Arman Uguray
Sent: Tuesday, July 22, 2014 7:41 AM
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray
Subject: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the =
GATT D-Bus API.

This patch proposes changes to the currently unimplemented GATT D-Bus API f=
or desktop bluetoothd. This is the first step in implementing a GATT client=
 layer for bluetoothd that will change the way remote attributes are access=
ed via bluetoothd plugins and external applications.
---
 doc/gatt-api.txt | 118 +++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 106 insertions(+), 12 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt index 8c7975c..741bd18 100=
644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -32,6 +32,25 @@ Properties	string UUID [read-only]
=20
 			128-bit service UUID.
=20
+		boolean Primary [read-only]
+
+			Indicates whether or not this GATT service is a
+			primary service. If false, the service is secondary.
+
+		object Device [read-only, optional]
+
+			Object path of the Bluetooth device the service
+			belongs to. Only present on services from remote
+			devices.
+
+		array{object} Characteristics [read-only]
+
+			Array of object paths representing the characteristics
+			of this service. This property is set only when the
+			characteristic discovery has been completed, however the
+			characteristic objects will become available via
+			ObjectManager as soon as they get discovered.
+
 		array{object} Includes [read-only]: Not implemented
=20
 			Array of object paths representing the included
@@ -48,6 +67,47 @@ Service		org.bluez
 Interface	org.bluez.GattCharacteristic1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/servic=
eXX/charYYYY
=20
+Methods		array{byte} ReadValue()
+
+			Issues a request to read the value of the
+			characteristic and returns the value if the
+			operation was successful.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.ReadNotPermitted
+					 org.bluez.Error.NotPaired
+					 org.bluez.Error.NotSupported
+
+		void WriteValue(array{byte} value)
+
+			Issues a request to write the value of the
+			characteristic.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.WriteNotPermitted
+					 org.bluez.Error.NotPaired
+					 org.bluez.Error.NotSupported
+
+		void StartNotify()
+
+			Starts a notification session from this characteristic
+			if it supports value notifications or indications.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.NotSupported
+
+		void StopNotify()
+
+			This method will cancel any previous StartNotify
+			transaction. Note that notifications from a
+			characteristic are shared between sessions thus
+			calling StopNotify will release a single session.
+
+			Possible Errors: org.bluez.Error.Failed
+
 Properties	string UUID [read-only]
=20
 			128-bit characteristic UUID.
@@ -57,12 +117,19 @@ Properties	string UUID [read-only]
 			Object path of the GATT service the characteristc
 			belongs to.
=20
-		array{byte} Value [read-write]
+		array{byte} Value [read-only, optional]
+
+			The cached value of the characteristic. This property
+			gets updated only after a successful read request and
+			when a notification or indication is received, upon
+			which a PropertiesChanged signal will be emitted.
=20
-			Value read from the remote Bluetooth device or from
-			the external application implementing GATT services.
+		boolean Notifying [read-only]
=20
-		array{string} Flags [read-only, optional]
+			True, if notifications or indications on this
+			characteristic are currently enabled.
+
+		array{string} Flags [read-only]
=20
 			Defines how the characteristic value can be used. See
 			Core spec "Table 3.5: Characteristic Properties bit
@@ -79,6 +146,14 @@ Properties	string UUID [read-only]
 				"reliable-write"
 				"writable-auxiliaries"
=20
+		array{object} Descriptors [read-only]
+
+			Array of object paths representing the descriptors
+			of this service. This property is set only when the
+			descriptor discovery has been completed, however the
+			descriptor objects will become available via
+			ObjectManager as soon as they get discovered.
+
=20
 Characteristic Descriptors hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -89,6 +164,29 @@ Service		org.bluez
 Interface	org.bluez.GattDescriptor1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/servic=
eXX/charYYYY/descriptorZZZ
=20
+Methods		array{byte} ReadValue()
+
+			Issues a request to read the value of the
+			characteristic and returns the value if the
+			operation was successful.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.ReadNotPermitted
+					 org.bluez.Error.NotPaired
+					 org.bluez.Error.NotSupported
+
+		void WriteValue(array{byte} value)
+
+			Issues a request to write the value of the
+			characteristic.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.WriteNotPermitted
+					 org.bluez.Error.NotPaired
+					 org.bluez.Error.NotSupported
+
 Properties	string UUID [read-only]
=20
 			128-bit descriptor UUID.
@@ -98,16 +196,12 @@ Properties	string UUID [read-only]
 			Object path of the GATT characteristc the descriptor
 			belongs to.
=20
-		array{byte} Value [read-write]
-
-			Raw characteristic descriptor value read from the
-			remote Bluetooth device or from the external
-			application implementing GATT services.
+		array{byte} Value [read-only, optional]
=20
-		string Permissions [read-only]: To be defined
+			The cached value of the descriptor. This property
+			gets updated only after a successful read request, upon
+			which a PropertiesChanged signal will be emitted.
=20
-			Defines read/write authentication and authorization
-			requirements.
=20
 Service Manager hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
--
2.0.0.526.g5318336

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in the body of a message to majordomo@vger.kernel.org More majordomo info a=
t  http://vger.kernel.org/majordomo-info.html

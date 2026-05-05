Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA03D7D91
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971487; cv=none; b=OaDH/zesMK2nogvFMpv3UoSaRlR7ZMcsUjiqCDldp2SdENsfpXyagjmGGUQZTPFB8PIBAw4GaodxfNaQ5TB5Vk1g1ZrCV8KjqUDrjQitDhVo+Qj5kmys7yVZXZ9ylqrX5fiOVQD4fL+q+9na7sEGSPQtWI+c5Z0Q05kqR9YNP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971487; c=relaxed/simple;
	bh=gkHTpXHukrJcOCi6dsNFvZBLWuAprdS8bgayvohbo2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEdu4JPNGmT4+9QAnBCWIlr5iBYKmavPXNZxn6/TV7tKvjfUC40INT9Cx8FEJuEOjtzuCy+BLA5Z4BGQ1tcnPMVXpXCfUBOjL3yFXo6FLOnvfpZ6lY/vu/PngcTJBxzUpH6lQJ0Mcy/eMdzthWCVBWxX1GXKg+3cfxmQbVraMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6EFF3EBD0;
	Tue,  5 May 2026 08:57:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Paul Otto <potto@ieee.org>
Subject: [BlueZ v10 16/16] doc: Add introduction to GATT
Date: Tue,  5 May 2026 10:45:22 +0200
Message-ID: <20260505085741.2497401-17-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEsq12OIBCnvXFJ6W57/qCrWqui1/b+jObcFoxLtk4O5wbyAq6ZkN5O2Yn22j2EiWhRNa3kw3AEgyKo/uF5+n6lzo9ot3klu5jkSfnaYi+rqOayVpped5gttOKUMxkFsibymF9r0wd6Guco+D092t2rHQYKMMlUe3QZ1tXr7U3i1s8T3Zc79NpKQKBV36GtH4QvwEunQxkgUu2yLqwX9LPAvHC0qCJbfTl1u22LzadefVGKOB5BImvxB4jWboCV1qeid1j2nVsBpt0BSgCrTxzH63A6LNUXZv5tfIqK+D9CBMu87ws5xxdq3eJNmpi56Ub6LWLyFBbpL5tM9oDt5l15ACg6j8hndl6BN4wuGPkkC0Iu/wAs+NvwFSuDONXjPmfEirkRfAy3k3CHI8Qsf2fUsxB3Is0P4osbn0YW4kVZC4gMDmV+vTM8sB2ZEGu1uEy18QvkXiN6QG7Llx3BX7YQFLcRbN2HJq224+IZ9boYjNG5573t+CwvScZ2HKeA5G/6IHzg6nmQq5SUFacMR2kxLDqc3D1rvIxAfB15OBWwMXnqJnbSR8cZUO492dhx3cBoknhPHvegDq+OzmKypsF9RfgEj8A1cu7n37RxwQ2Gn7YzA2kAgUkPJORJAqtFfsH3yX/hz73WyLo7VYYXwTwn8Th4cYBxL1SO+iewVqS5sQ

From: Paul Otto <potto@ieee.org>

As originally written for the bluetoothctl gatt submenu at:
https://github.com/potto216/bluez/blob/master/client/bluetoothctl-gatt.rst

Closes: https://github.com/bluez/bluez/issues/747
---
 doc/dbus-gatt.rst  |   2 +
 doc/gatt-intro.rst | 141 +++++++++++++++++++++++++++++++++++++++++++++
 doc/meson.build    |   1 +
 3 files changed, 144 insertions(+)
 create mode 100644 doc/gatt-intro.rst

diff --git a/doc/dbus-gatt.rst b/doc/dbus-gatt.rst
index fb026e9f9ede..264fb12bae11 100644
--- a/doc/dbus-gatt.rst
+++ b/doc/dbus-gatt.rst
@@ -5,12 +5,14 @@ D-Bus GATT APIs
    :hidden:
    :maxdepth: 2
 
+   gatt-intro
    org.bluez.GattManager
    org.bluez.GattProfile
    org.bluez.GattService
    org.bluez.GattCharacteristic
    org.bluez.GattDescriptor
 
+* :doc:`Intro to GATT (Generic Attribute Profile) <gatt-intro>`
 * :doc:`org.bluez.GattManager <org.bluez.GattManager>`
 * :doc:`org.bluez.GattProfile <org.bluez.GattProfile>`
 * :doc:`org.bluez.GattService <org.bluez.GattService>`
diff --git a/doc/gatt-intro.rst b/doc/gatt-intro.rst
new file mode 100644
index 000000000000..271f9bac08ce
--- /dev/null
+++ b/doc/gatt-intro.rst
@@ -0,0 +1,141 @@
+=========================================
+Intro to GATT (Generic Attribute Profile)
+=========================================
+
+The Generic Attribute Profile (GATT) defines how two connected Bluetooth
+LE devices can share data using concepts called Services and Characteristics.
+Data is orgnaized into a hierarchical structure of profiles, services, and
+characteristics in the GATT database. The device containing the GATT database
+is known as the server device and the device accessing the GATT database is
+the client device. Only the database's services and characteristics are
+documented here.
+
+BlueZ provides D-Bus interfaces for accessing GATT services and profiles which
+are documented in the :doc:`D-Bus GATT APIs <dbus>` document.
+
+One-off usage and prototyping can also be done using the bluetoothctl
+command-line utility.
+
+UUIDs
+-----
+
+Services and characteristics are differentiated by Universally Unique
+Identifiers (UUIDs). For GATT there are several formats of UUIDs: 128-bit,
+32-bit, and 16-bit.
+
+128-bit UUIDs: Displayed in five groups of 32 hexadecimal digits separated
+by hyphens (e.g., 123e4567-e89b-12d3-a456-426614174000). 128-bit UUIDs allow
+for custom services and characteristics that do not conflict with those of
+other vendors or standard profiles defined by the Bluetooth SIG.
+
+32-bit UUIDs: A subset of the 128-bit UUID, where only 32 bits are used to
+represent the UUID. The UUID values fall within a certain range defined by
+the Bluetooth specification. The 32-bit value is inserted into a base UUID
+(UUUUUUUU-0000-1000-8000-00805F9B34FB) to form a full 128-bit UUID. The
+UUUUUUUU in the base UUID is replaced by the 32-bit value. This format is
+used within the Bluetooth protocol for standardized services and profiles.
+
+16-bit UUIDs: Similar to the 32-bit UUID, but more common. This is also
+used for standardized services, characteristics, and descriptors defined by
+the Bluetooth SIG. The 16-bit value is inserted into a base UUID
+(0000UUUU-0000-1000-8000-00805F9B34FB) to form a full 128-bit UUID.
+
+Services and Characteristics
+----------------------------
+
+Services: Collections of related data that together perform a specific
+function or feature of the device. Each service is identified by a
+UUID and contains Characteristics that define the actual data and behaviors
+of the service.
+
+Characteristics: Pieces of data under a service, representing a specific
+piece of information or a function of the device. Each characteristic can
+have its own unique value, associated properties and access permissions that
+define how it can be interacted with. These properties include read, write,
+notify, indicate, and more. A Characteristic may include one or more
+Descriptors that provide additional metadata or control specific aspects
+of the Characteristic's behavior.
+
+Properties
+----------
+
+Read Property: Allows a connected device to read the value of a characteristic.
+Information meant to be consumed but not altered by the client device, such
+as the device's battery level or sensor readings. Characteristics marked with
+the read property are essentially broadcasting their data to be accessed by
+other devices, ensuring that the information can be consumed without
+being modified.
+
+Write Property: Enables a connected device to change the value of a
+characteristic. An example of when a client device needs to alter data on the
+server device is a Bluetooth controlled light bulb, where the characteristic
+controlling the color or brightness of the light would have the write property,
+allowing external devices to modify these settings.
+
+Read/Write Property: Characteristics can also be configured to support both
+read and write properties simultaneously. This dual capability is useful for
+characteristics that hold information which not only needs to be displayed to
+external devices but also can be updated by them. For example, a Bluetooth
+thermostat may have a characteristic with read/write properties for the target
+temperature, enabling devices to both monitor the current setting and adjust
+it as needed.
+
+Notifications and Indications
+-----------------------------
+
+In addition to read and write properties,
+Bluetooth characteristics can also be configured to notify or indicate to
+connected devices when their value has changed. This is particularly useful
+for dynamic data that changes over time, such as sensor measurements or
+device status updates.
+
+Notifications: When a characteristic's notify property is enabled, it can
+send an update to connected devices whenever its value changes. This allows
+for real-time data streaming without the client having to continuously read
+the characteristic's value. Notifications are unacknowledged, meaning the
+sender does not receive confirmation that the message has been
+received successfully.
+
+Indications: Similar to notifications, indications inform connected devices
+about changes in a characteristic's value. The key difference is that
+indications are acknowledged; the receiver sends back a confirmation to the
+sender upon successfully receiving the update. This ensures reliable delivery
+of important data changes but at the cost of higher power consumption and
+potentially lower throughput due to the additional confirmation step.
+
+Organization of a GATT database The Bluetooth GATT database is a structured
+collection of values that are used to share information between two Bluetooth
+Low Energy (LE) devices. The GATT database is organized as a hierarchical
+structure composed of Services, Characteristics, and Descriptors. The two LE
+devices share the database information through read, writes, and subscription
+to notifications or indications of data values. The two LE devices perform
+this sharing by referencing 16-bit indexes known as "handles" which are
+numerical identifiers for each element in the GATT database. This avoids
+the need to use the UUIDs to reference the elements in the database.
+
+Service: A GATT database service is a collection of related functionalities
+that a device offers. It groups together one or more Characteristics that are
+logically related to perform a specific function or feature of the server
+device. Each service is identified by a UUID and contains Characteristics
+that define the actual data and behaviors of the service.
+
+Characteristic: Each characteristic can have its own unique value, associated
+properties, and access permissions that define how it can be interacted with.
+These properties include read, write, notify, indicate, and more. A
+Characteristic may include one or more Descriptors that provide additional
+metadata or control specific aspects of the Characteristic's behavior.
+
+Descriptors: A descriptor is an optional attribute that describes or controls
+certain aspects of a Characteristic's behavior. They provide additional context
+or metadata about a Characteristic. Some common types of Descriptors include the
+Characteristic User Description (provides human-readable description), the
+Characteristic Presentation Format (defines the format of the Characteristic
+value), and the Client Characteristic Configuration (used to enable or
+disable notifications or indications for a Characteristic).
+
+Handles: Every element in the GATT database (Service, Characteristic,
+Descriptor) is assigned a unique handle. Handles are 16-bit numerical
+identifiers that are used to reference these elements in GATT operations.
+The handles are used to avoid the need to use the UUIDs to reference the
+elements in the database.
+
diff --git a/doc/meson.build b/doc/meson.build
index 722f1407f51b..658980bda3f9 100644
--- a/doc/meson.build
+++ b/doc/meson.build
@@ -238,6 +238,7 @@ if get_option('documentation').enabled()
     'tools.rst',
     'deprecated-tools.rst',
     'dbus.rst',
+    'gatt-intro.rst',
     'dbus-gatt.rst',
     'dbus-obex.rst',
     'qualifications.rst',
-- 
2.54.0


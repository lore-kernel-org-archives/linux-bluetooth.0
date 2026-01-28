Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139F342CA7
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638558; cv=none; b=pYvPkEo9bINCw7QiJQkYjclYKQ67LCuPIPxXBKmBQpuT3g/QSohedXKYkXvziRvQCWV0d+CJZKm94mpdc/SM1g3LH1n3jfGC4eTwkPihERzDNCasjJg/YiRbQbMx+9mhwNHgHabJtZ+sK0pOcyYNf6esIke4JwnLNppmf2zxHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638558; c=relaxed/simple;
	bh=hn9Xl2XOeHBPyx+rqTk65BM70aRnx2eHhjU9+IQfn7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9pHbc5W3tLVpj/3rAMHy4IfEcUvCfYqClPfdHYM9+s5qbXdLlOFOBryxLHBXPtz2/dmn7zP5jfWG4ZPRodQQhZdNg0YHArwfJekQhXzDrzDHc5whQ9GFgrmpJoJndnyxNaiqrxX/uv/L3ARvC5eRv9Clj15v8cKS0cuO89TnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52CAB4440E;
	Wed, 28 Jan 2026 22:15:49 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Paul Otto <potto@ieee.org>
Subject: [PATCH BlueZ v7 16/16] doc: Add introduction to GATT
Date: Wed, 28 Jan 2026 23:12:06 +0100
Message-ID: <20260128221536.2319084-17-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128221536.2319084-1-hadess@hadess.net>
References: <20260128221536.2319084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedvveeiheefkeehheekkedttdejkedvledugeeukeehfedtfeekjeetgfdvfeeuhfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhsvghtthhinhhgshdrrhgvrggunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugephedvveetueeggeegtdfgpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhothhtohesihgvvggvr
 dhorhhg
X-GND-State: clean
X-GND-Score: -100

From: Paul Otto <potto@ieee.org>

As originally written for the bluetoothctl gatt submenu at:
https://github.com/potto216/bluez/blob/master/client/bluetoothctl-gatt.rst

Closes: https://github.com/bluez/bluez/issues/747
---
 doc/gatt-intro.rst | 141 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 doc/gatt-intro.rst

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
-- 
2.52.0


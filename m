Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC62FE071
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801982; cv=none; b=FHst2DCoz6aBkEWWA4BE/zIn9w4ihlqhVGl4wyq57oVHfv9edy5kaGpHQvXuuDtc3p8atZ7918zWGdxK/z1a/0i9Lqz4zGXdISqqEAEAC3Dxt3p1/0SEmJE1bpyKHU9qFwji4dz3xlhoUfmTr4Snmj8vWTzGYXspb6F5J+gNo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801982; c=relaxed/simple;
	bh=4m/eXjuor5sn/XH/m8iFrQaNnL9rLbxtPRr6zv5fRQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4rhcUhtmxXl+3tJSNUxvkyuzqeCkoSWwWo2J/hlM5qR+NacQAEhG5hoL3H7kdSFX37kRjbiFG/o8jihyrb3G5dbaCRfXfn7iWegzjOan76LZcGhHwQiFfKtRYEmIwSoG9CSAJciruUfwp2wcpIJxDNvpSq/XtVX8qBeEL4sa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIPKIv5r; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIPKIv5r"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5664393d409so934754e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801979; x=1770406779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvotALpb6c1UIWkDCkGmFEiFUaIjIkhDJVMLfM+MIK0=;
        b=aIPKIv5rRXTxLZT5hscKEvU1zW+o1kWHE3N0va1T1dc1Djz1IPohC5bhxuKINWVHcY
         GCQJQPyguZi4XqxmWrZg+H11MDWiShMUg9F9XWqlxuqFsrn+Ezww8cECb7koKuLV1AnP
         syWq1eE0lMIAXa6umaTx1XpycMxqIi5+tAU/GFsuFRdLDnC/iGOtVzZHutTtJ5droWOT
         GhnvbhZRgWo2oe/vsQfwaTRX62kNERM0SXKKHYfAUhyoJR3faQfurhh4Z52cLmdQAUc5
         +0865IAHVNCxsK3Xy9qDof18rPFc1gD4W5gJO1BFr49YT4DB3pFnQdKN/dZkw3IGL9UK
         GAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801979; x=1770406779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rvotALpb6c1UIWkDCkGmFEiFUaIjIkhDJVMLfM+MIK0=;
        b=RikPYumuv+a/Qex0+x+X3Yv7QH5s2kAviA75LFLvdgRwuBf9Z4mxFDUmCVBGJSO/G0
         ibjcqbDpdpYD46V6HEi8Ho0dyQNHQjgYzEHXHqEy62VtgksaunFKCEwZFwGVHESMhCio
         ZIpPk6PNGrLFZnzEkASgD4I7+PhqXBjdOPRVWoMYI/RYmcy7PqC3Y1bOBQKTRy9ZC8kB
         N9azi7RUygpXg3FDFyzTdXyFnl3B4p4yz+GaJ/O6bPagTOxEgjEyo8TJD9dZimPNtdKx
         owsrx4cveI9dJ2mftM05TULgcbxoXhApKBnpcMC0cvvkc4jGep+NqvuDrPrXl550BDpD
         ++qQ==
X-Gm-Message-State: AOJu0Ywp9nj6K2fki6/RzFUxPFpw8y3Cp9WC5V+HnbVDU5XDEsBZoqPn
	sRQpkm/MfdSYZWGjvL7lCJsJ0872SmkvPmTcXOg9Gxb6CtMqbHVjTHJWKPOgCWRf
X-Gm-Gg: AZuq6aL9mqRm+TqASGp2xDcCOVgrjtlRgEaK5sFa5ECCxnqsqvNkNWwy4HOh9GaeyEf
	T0IEg+Y6jHbQbP9qUSKPgm0zXqmVyOXI6lrc4bKH+9Afj3bpXsJb+CHTyYyX7zVxkLHwLliVIRg
	2k83fnsVwTlQ7sWx5evMc60hDr/jKUu+zJHZVp36FztyTz0uA2DdXqU4fNNyAbb9jRs3VsNy37i
	EjFaoaWW72TmrMQR4Rq8tCi6k9/2Ez9eKY2rlQMKjMPwbZOlkqa6LAhxobHQSLmsaxHoP6IeamP
	L05wlu5Ts5igEghLwN5T5A+3mrVNktZL+nJ6kXmzhkLARIFaEWdksknKFT6iCZ05/LrRY36XWFD
	AuhMJH1g9A4cMXo74AeFP1KRbRBnrdbLTp+y+Z/STSL7HLp9QRYlvXBgO8HA/Lstq6KBHLAWdx7
	cdZrCT8Vdzpr0/IbpurRBGufsrDDYJw33yLyOyqHvaFgMumVl9xdZ/eNkTbPLi2fV712JlczGYM
	Gh+Gg==
X-Received: by 2002:a05:6122:f93:b0:54c:da0:f711 with SMTP id 71dfb90a1353d-566a006c029mr1103889e0c.7.1769801978751;
        Fri, 30 Jan 2026 11:39:38 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/35] doc/bluetoothctl-gatt: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:50 -0500
Message-ID: <20260130193921.1273263-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-gatt.rst | 249 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 244 insertions(+), 5 deletions(-)

diff --git a/doc/bluetoothctl-gatt.rst b/doc/bluetoothctl-gatt.rst
index 6c72302ae935..493c7cf3b2c1 100644
--- a/doc/bluetoothctl-gatt.rst
+++ b/doc/bluetoothctl-gatt.rst
@@ -18,6 +18,10 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [gatt.commands]
 
+This submenu interacts with GATT services, characteristics, and descriptors
+using the **org.bluez.GattService(5)**, **org.bluez.GattCharacteristic(5)**,
+**org.bluez.GattDescriptor(5)**, and **org.bluez.GattManager(5)** interfaces.
+
 
 Generic Attribute Commands
 ==========================
@@ -30,7 +34,24 @@ encompassing services, characteristics, and handles. This command provides
 a comprehensive overview of the available Bluetooth attributes, which can
 be further interacted with using other commands.
 
-:Usage: **> list-attributes <attribute/UUID> <dev/local>**
+:Usage: **> list-attributes [dev/local]**
+:[dev/local]: Device MAC address, object path, or "local" to list locally registered attributes (optional, lists all if omitted)
+:Example List attributes for specific service:
+	| **> list-attributes /org/bluez/hci0/dev_00_11_22_33_44_55/service001a**
+:Example List attributes for specific characteristic:
+	| **> list-attributes /org/bluez/hci0/dev_00_11_22_33_44_55/service001a/char001c**
+:Example List attributes for service on different device:
+	| **> list-attributes /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/service0020**
+:Example List all Generic Access service attributes:
+	| **> list-attributes 0x1800**
+:Example List all Battery Service attributes:
+	| **> list-attributes 0x180F**
+:Example List all Device Name characteristic attributes:
+	| **> list-attributes 0x2A00**
+:Example List attributes using full UUID:
+	| **> list-attributes 00001801-0000-1000-8000-00805f9b34fb**
+:Example List attributes for custom service UUID:
+	| **> list-attributes 12345678-1234-5678-9abc-123456789abc**
 
 select-attribute
 ----------------
@@ -41,7 +62,25 @@ must select it with this command. This establishes a context for many
 other commands (read, write, notify, etc.), specifying the attribute
 they should operate on.
 
-:Usage: **> select-attribute <attribute/UUID/local>**
+:Usage: **> select-attribute <attribute/UUID/local> [attribute/UUID]**
+:<attribute/UUID/local>: GATT attribute path, UUID, or "local" to select from local attributes
+:[attribute/UUID]: Additional attribute path or UUID when using "local" (optional)
+:Example Select specific characteristic:
+	| **> select-attribute /org/bluez/hci0/dev_00_11_22_33_44_55/service001a/char001c**
+:Example Select specific descriptor:
+	| **> select-attribute /org/bluez/hci0/dev_00_11_22_33_44_55/service0020/char0022/desc0024**
+:Example Select service on different device:
+	| **> select-attribute /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/service001a**
+:Example Select Device Name characteristic:
+	| **> select-attribute 0x2A00**
+:Example Select Battery Level characteristic:
+	| **> select-attribute 0x2A19**
+:Example Select Client Characteristic Configuration descriptor:
+	| **> select-attribute 0x2902**
+:Example Select Temperature characteristic using full UUID:
+	| **> select-attribute 00002a6e-0000-1000-8000-00805f9b34fb**
+:Example Select custom characteristic:
+	| **> select-attribute 12345678-1234-5678-9abc-123456789abc**
 
 attribute-info
 --------------
@@ -52,6 +91,17 @@ attribute. This command is useful for understanding the properties and
 capabilities of an attribute.
 
 :Usage: **> attribute-info [attribute/UUID]**
+:[attribute/UUID]: GATT attribute path or UUID to get info for (optional, uses current if omitted)
+:Example Show information for currently selected attribute:
+	| **> attribute-info**
+:Example Show info for specific characteristic:
+	| **> attribute-info /org/bluez/hci0/dev_00_11_22_33_44_55/service001a/char001c**
+:Example Show info for Battery Level characteristic:
+	| **> attribute-info 0x2A19**
+:Example Show info for Device Name characteristic:
+	| **> attribute-info 0x2A00**
+:Example Show info for Temperature characteristic:
+	| **> attribute-info 00002a6e-0000-1000-8000-00805f9b34fb**
 
 read
 ----
@@ -61,6 +111,18 @@ beforehand with select-attribute. The optional offset parameter can be
 used for attributes that allow partial reads.
 
 :Usage: **> read [offset]**
+:Uses: **org.bluez.GattCharacteristic(5)** method **ReadValue**
+:[offset]: Byte offset to start reading from (optional, defaults to 0)
+:Example Read attribute value from offset 0:
+	| **> read**
+:Example Read attribute value from offset 0 (explicit):
+	| **> read 0**
+:Example Read attribute value starting from offset 4:
+	| **> read 4**
+:Example Read attribute value starting from offset 10:
+	| **> read 10**
+:Example Read attribute value starting from offset 16:
+	| **> read 16**
 
 write
 -----
@@ -70,7 +132,25 @@ be selected in advance using select-attribute. Data must be provided in
 hexadecimal format. Optional offset and type parameters can accommodate
 specific write requirements.
 
-:Usage: **> write <data=xx xx ...> [offset] [type]**
+:Usage: **> write <data="xx xx ..."> [offset] [type]**
+:Uses: **org.bluez.GattCharacteristic(5)** method **WriteValue**
+:<xx xx ...>: Hexadecimal data bytes to write to the attribute
+:[offset]: Byte offset to start writing at (optional, defaults to 0)
+:[type]: Write type - request, command, or reliable (optional, defaults to request)
+:Example Write "Hello" to attribute (ASCII bytes):
+	| **> write "48 65 6C 6C 6F"**
+:Example Write binary data to attribute:
+	| **> write "01 02 03 04"**
+:Example Write single byte value:
+	| **> write "FF"**
+:Example Write 2 bytes starting at offset 4:
+	| **> write "01 02" 4**
+:Example Write with write request (default):
+	| **> write "48 65 6C 6C 6F" 0 request**
+:Example Write with write command (no response):
+	| **> write "01 02 03" 0 command**
+:Example Write with reliable write:
+	| **> write "FF EE DD" 0 reliable**
 
 acquire-write
 -------------
@@ -80,6 +160,9 @@ is useful for applications that need a file descriptor to perform
 write operations.
 
 :Usage: **> acquire-write**
+:Uses: **org.bluez.GattCharacteristic(5)** method **AcquireWrite**
+:Example Acquire write file descriptor for current attribute:
+	| **> acquire-write**
 
 release-write
 -------------
@@ -89,6 +172,8 @@ command is necessary to clean up resources after you're done with the
 write operation.
 
 :Usage: **> release-write**
+:Example Release write file descriptor for current attribute:
+	| **> release-write**
 
 acquire-notify
 --------------
@@ -98,6 +183,9 @@ This enables applications to listen for notifications on attribute
 value changes.
 
 :Usage: **> acquire-notify**
+:Uses: **org.bluez.GattCharacteristic(5)** method **AcquireNotify**
+:Example Acquire notify file descriptor for current attribute:
+	| **> acquire-notify**
 
 release-notify
 --------------
@@ -106,6 +194,8 @@ Releases the Notify file descriptor obtained with acquire-notify. Ensures
 resources are freed once notification listening is no longer needed.
 
 :Usage: **> release-notify**
+:Example Release notify file descriptor for current attribute:
+	| **> release-notify**
 
 notify
 ------
@@ -116,6 +206,12 @@ command allows applications to be notified of attribute changes without
 polling.
 
 :Usage: **> notify <on/off>**
+:Uses: **org.bluez.GattCharacteristic(5)** methods **StartNotify**, **StopNotify**
+:<on/off>: Enable or disable notifications for the current attribute
+:Example Enable notifications for current attribute:
+	| **> notify on**
+:Example Disable notifications for current attribute:
+	| **> notify off**
 
 clone
 -----
@@ -124,6 +220,21 @@ Creates a clone of a device or attribute. This can be useful for creating
 a backup or working with a copy for testing purposes.
 
 :Usage: **> clone [dev/attribute/UUID]**
+:[dev/attribute/UUID]: Device MAC address, attribute path, or UUID to clone (optional, clones current if omitted)
+:Example Clone entire device GATT database:
+	| **> clone 00:11:22:33:44:55**
+:Example Clone another device:
+	| **> clone AA:BB:CC:DD:EE:FF**
+:Example Clone specific service:
+	| **> clone /org/bluez/hci0/dev_00_11_22_33_44_55/service001a**
+:Example Clone specific characteristic:
+	| **> clone /org/bluez/hci0/dev_00_11_22_33_44_55/service001a/char001c**
+:Example Clone Generic Access service:
+	| **> clone 0x1800**
+:Example Clone Battery Service:
+	| **> clone 0x180F**
+:Example Clone Battery Level characteristic:
+	| **> clone 0x2A19**
 
 register-application
 --------------------
@@ -133,6 +244,18 @@ management of services, characteristics, and descriptors under this
 application.
 
 :Usage: **> register-application [UUID ...]**
+:Uses: **org.bluez.GattManager(5)** method **RegisterApplication**
+:[UUID ...]: Optional list of service UUIDs to register with the application
+:Example Register GATT application without specific UUIDs:
+	| **> register-application**
+:Example Register application with Battery Service:
+	| **> register-application 0x180F**
+:Example Register with Generic Access and Battery Service:
+	| **> register-application 0x1800 0x180F**
+:Example Register application with custom service UUID:
+	| **> register-application 12345678-1234-5678-9abc-123456789abc**
+:Example Register with multiple standard services:
+	| **> register-application 0x1800 0x180F 0x180A**
 
 unregister-application
 ----------------------
@@ -140,6 +263,9 @@ unregister-application
 Removes a previously registered application from the Bluetooth system.
 
 :Usage: **> unregister-application**
+:Uses: **org.bluez.GattManager(5)** method **UnregisterApplication**
+:Example Unregister current GATT application:
+	| **> unregister-application**
 
 register-service
 ----------------
@@ -148,6 +274,24 @@ Adds a new service under a registered application. This command is
 crucial for defining new services that devices can offer.
 
 :Usage: **> register-service <UUID> [handle]**
+:<UUID>: Service UUID to register (16-bit, 32-bit, or 128-bit format)
+:[handle]: Specific attribute handle to assign (optional, auto-assigned if omitted)
+:Example Register Generic Access service (auto handle):
+	| **> register-service 0x1800**
+:Example Register Battery Service (auto handle):
+	| **> register-service 0x180F**
+:Example Register Device Information service (auto handle):
+	| **> register-service 0x180A**
+:Example Register Generic Access service at handle 1:
+	| **> register-service 0x1800 0x0001**
+:Example Register Battery Service at handle 16:
+	| **> register-service 0x180F 0x0010**
+:Example Register Device Info service at handle 32:
+	| **> register-service 0x180A 0x0020**
+:Example Register custom service (auto handle):
+	| **> register-service 12345678-1234-5678-9abc-123456789abc**
+:Example Register custom service at specific handle:
+	| **> register-service 12345678-1234-5678-9abc-123456789abc 0x0050**
 
 unregister-service
 ------------------
@@ -156,6 +300,17 @@ Removes a service from a registered application, effectively ceasing
 its availability.
 
 :Usage: **> unregister-service <UUID/object>**
+:<UUID/object>: Service UUID or object path of the service to unregister
+:Example Unregister Generic Access service:
+	| **> unregister-service 0x1800**
+:Example Unregister Battery Service:
+	| **> unregister-service 0x180F**
+:Example Unregister custom service:
+	| **> unregister-service 12345678-1234-5678-9abc-123456789abc**
+:Example Unregister service by object path:
+	| **> unregister-service /org/bluez/example/service0**
+:Example Unregister another service:
+	| **> unregister-service /org/bluez/example/service1**
 
 register-includes
 -----------------
@@ -163,14 +318,28 @@ register-includes
 Marks a service as included within another service, allowing for
 service hierarchies and complex service structures.
 
-:Usage: **>r egister-includes <UUID> [handle]**
+:Usage: **> register-includes <UUID> [handle]**
+:<UUID>: Service UUID to register as included service
+:[handle]: Specific attribute handle to assign (optional, auto-assigned if omitted)
+:Example Register Generic Access as included service:
+	| **> register-includes 0x1800**
+:Example Register Battery Service as included at handle 21:
+	| **> register-includes 0x180F 0x0015**
+:Example Register custom service as included:
+	| **> register-includes 12345678-1234-5678-9abc-123456789abc**
 
 unregister-includes
 -------------------
 
 Removes an included service relationship, simplifying the service structure.
 
-:Usage: **> unregister-includes <Service-UUID><Inc-UUID>**
+:Usage: **> unregister-includes <Service-UUID> <Inc-UUID>**
+:<Service-UUID>: Parent service UUID that contains the included service
+:<Inc-UUID>: Included service UUID to remove from the parent service
+:Example Unregister Battery Service inclusion from Generic Access:
+	| **> unregister-includes 0x1800 0x180F**
+:Example Unregister Device Info inclusion from custom service:
+	| **> unregister-includes 12345678-1234-5678-9abc-123456789abc 0x180A**
 
 register-characteristic
 -----------------------
@@ -179,6 +348,31 @@ Introduces a new characteristic under a service, specifying its properties
 and access permissions with flags.
 
 :Usage: **> register-characteristic <UUID> <Flags=read,write,notify...> [handle]**
+:<UUID>: Characteristic UUID to register (16-bit, 32-bit, or 128-bit format)
+:<Flags=read,write,notify...>: Comma-separated list of characteristic properties and permissions
+:[handle]: Specific attribute handle to assign (optional, auto-assigned if omitted)
+:Example Register Device Name (read-only):
+	| **> register-characteristic 0x2A00 read**
+:Example Register Battery Level (read + notifications):
+	| **> register-characteristic 0x2A19 read,notify**
+:Example Register Heart Rate Measurement (notify-only):
+	| **> register-characteristic 0x2A37 notify**
+:Example Register Device Name (read + write):
+	| **> register-characteristic 0x2A00 read,write**
+:Example Register Battery Level (read + write + notify):
+	| **> register-characteristic 0x2A19 read,write,notify**
+:Example Register Temperature (read + indications):
+	| **> register-characteristic 0x2A6E read,indicate**
+:Example Register Device Name at handle 3:
+	| **> register-characteristic 0x2A00 read 0x0003**
+:Example Register Battery Level at handle 19:
+	| **> register-characteristic 0x2A19 read,notify 0x0013**
+:Example Register custom characteristic with full capabilities:
+	| **> register-characteristic 12345678-1234-5678-9abc-123456789abc read,write,notify**
+:Example Register custom write-only characteristic:
+	| **> register-characteristic ABCD1234-ABCD-1234-ABCD-123456789ABC write-without-response**
+:Example Register with all flags:
+	| **> register-characteristic 0x2A00 read,write,write-without-response,notify,indicate**
 
 unregister-characteristic
 -------------------------
@@ -186,6 +380,17 @@ unregister-characteristic
 Eliminates a characteristic from a service, removing its functionality.
 
 :Usage: **> unregister-characteristic <UUID/object>**
+:<UUID/object>: Characteristic UUID or object path of the characteristic to unregister
+:Example Unregister Device Name characteristic:
+	| **> unregister-characteristic 0x2A00**
+:Example Unregister Battery Level characteristic:
+	| **> unregister-characteristic 0x2A19**
+:Example Unregister custom characteristic:
+	| **> unregister-characteristic 12345678-1234-5678-9abc-123456789abc**
+:Example Unregister characteristic by object path:
+	| **> unregister-characteristic /org/bluez/example/service0/char0**
+:Example Unregister another characteristic:
+	| **> unregister-characteristic /org/bluez/example/service1/char1**
 
 register-descriptor
 -------------------
@@ -194,6 +399,29 @@ Adds a descriptor to a characteristic, further defining its behavior and
 access controls.
 
 :Usage: **> register-descriptor <UUID> <Flags=read,write...> [handle]**
+:<UUID>: Descriptor UUID to register (16-bit, 32-bit, or 128-bit format)
+:<Flags=read,write...>: Comma-separated list of descriptor properties and permissions
+:[handle]: Specific attribute handle to assign (optional, auto-assigned if omitted)
+:Example Register Client Characteristic Configuration:
+	| **> register-descriptor 0x2902 read,write**
+:Example Register Characteristic User Description:
+	| **> register-descriptor 0x2901 read**
+:Example Register Characteristic Presentation Format:
+	| **> register-descriptor 0x2904 read**
+:Example Register CCCD at handle 5:
+	| **> register-descriptor 0x2902 read,write 0x0005**
+:Example Register User Description at handle 21:
+	| **> register-descriptor 0x2901 read 0x0015**
+:Example Register custom descriptor:
+	| **> register-descriptor 12345678-1234-5678-9abc-123456789abc read,write**
+:Example Register custom read-only descriptor:
+	| **> register-descriptor ABCD1234-ABCD-1234-ABCD-123456789ABC read**
+:Example Register Valid Range descriptor:
+	| **> register-descriptor 0x2906 read**
+:Example Register External Report Reference:
+	| **> register-descriptor 0x2907 read**
+:Example Register Report Reference:
+	| **> register-descriptor 0x2908 read**
 
 unregister-descriptor
 ---------------------
@@ -201,6 +429,17 @@ unregister-descriptor
 Removes a descriptor from a characteristic, simplifying its behavior.
 
 :Usage: **> unregister-descriptor <UUID/object>**
+:<UUID/object>: Descriptor UUID or object path of the descriptor to unregister
+:Example Unregister Client Characteristic Configuration:
+	| **> unregister-descriptor 0x2902**
+:Example Unregister Characteristic User Description:
+	| **> unregister-descriptor 0x2901**
+:Example Unregister custom descriptor:
+	| **> unregister-descriptor 12345678-1234-5678-9abc-123456789abc**
+:Example Unregister descriptor by object path:
+	| **> unregister-descriptor /org/bluez/example/service0/char0/desc0**
+:Example Unregister another descriptor:
+	| **> unregister-descriptor /org/bluez/example/service1/char1/desc1**
 
 RESOURCES
 =========
-- 
2.52.0


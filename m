Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AB1D554
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 May 2025 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748630988; cv=none; b=U71Ui0uJSDOJKVKhXcH3uTqVOw70mBqZQ9pR9RRTakD8S/LIDv5GUKufihDzs0DthZRIgYjGTr3+BIwHYyApX+ImuPUVVZHxuqOD6OMxidJZGIjHt2WhEJWTNpUUb5E8MuZQmoQTL5KolDoRd5Z7Lk4fNZk7+zvPp5BYKy/tEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748630988; c=relaxed/simple;
	bh=MhWpwFi7c77aKc3JZbntG3FghWNfz81lC8gTeoAw36A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bv4xJ3RpqHo7LldfVKLkwnh1F0RrvdxAl4AAa5CSmpaA3vpHksiM8ejjCAfK7yf6A2NNW2D3TKOY84Am5gEKpIgUWGMSQJaBpbicYHxG+u1D20GGAj+5cwCaL2V38604SlxIs7y2Rigrxqecqa9ZFbloK9uUpAbTEbAPH/NeYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKalxT8m; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKalxT8m"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-87df839c6d3so676108241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 May 2025 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748630977; x=1749235777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPOYv5crvjwn/aAX+pIeSnABbp/2cayack0ZZC9QnB0=;
        b=eKalxT8mypolJ1U/tSw69tTCJQ2O6k0YE3xsHxQy40yL7e0gD2jEM94qPh+bWJZ8M7
         Ekpall7r4jk1z0Tzv+C2cxO+mUrH8WxTL6/US8NkLKQkmR3znVDD/ZC0U4OALBXqfLyo
         L1eyMCvbMo4mVWDK40yqNytknurB0geRtio5FF53+LT6Ih3EICQrF+bSpl27sp6NWS9T
         +p7roslW0Is4/gbH5/3cPpie96M5EN/YfuV39/12CbN2b2YoevsFipVrrWgbn8QkwUhN
         V4yDvCrfo+1HjTMnrXB/HxKz1UVgdpqNk88gyBgqle7DrmOw8lM5A76uHQZyJ2oixFbo
         hATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748630977; x=1749235777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPOYv5crvjwn/aAX+pIeSnABbp/2cayack0ZZC9QnB0=;
        b=LXNnSWxnSd1r572f29KeqazktritJVync2JgqXtHXbVrTEX7qq8c6MX4vxp3e4+n3k
         voZF1qsdEVnCF3A8QykNGN0o//3cfJuQ5x1kE1lmbPYix9N/JAn6VIZPbZZZYUo0Zd6L
         MY7Coz7wUZvIv96nrKHUKFsbfswbOABO7w7BgIxnME2KqNC6KpGVpGKpPUbAV5I2AZCV
         wWQxwqBL6f40T2LbozXAtYJN9y2Jes0Geu1f4gSFdFQBW4lv11PjPmzXGKnME8/YWWc9
         bbATKjN1DSWXQ1URPcklc8GXD5iihq7b4IedMjFicGOkj1KUQT0BomzmHuaRQh10iqnU
         q35Q==
X-Gm-Message-State: AOJu0Yz2aGtJhGqTS7pzXfS0N8vYoUKy+l0r0igEzH4EDL+8dJ6wcAg5
	h96680WpPnkn/mOpn9uqDv93aSLUJZPdaS+4AEyFcqRw2aC5w/i3g8MtNRny3H/R
X-Gm-Gg: ASbGncsI5/jCqcgaqvUhWsLIpZqx9302NLhjK+BU+sKjBqonq4BSDZMoh1vddkw6b7D
	WoI1xJob0RPtEhR7tp+u+bE4NXsL538a7i0G9wj/Pkz7YknmI/syy4ijHWa/rZqBWSBfOXydGmo
	jQ1V+1Q4SuO2f7FPax4lOOP8Db+VukemY+H9TTSQgL0Sd4DwI/ZfUVud/aVLWjxyIu6PabI0K6/
	bbppFZHaMHx76TbsWV0pQpUOVZBgyZSqAOq182jCX3XL0SPqkHCcAAtZKu/Gu8axU4Z4DUsqH5J
	Rk5x8rNrscYQdKOTZ4ucBj65VfE3direpSDGngvlga+3mZ7qmqtfhMfhhb/a0NZMYrWO2pAyHN2
	LXpGyvk3d2RRw5EmKHLT1WIskh9bpfI5HO9fBqfPhfA==
X-Google-Smtp-Source: AGHT+IEWJLUxd3XH/+bShDLfIpAM/IMuszql0N0R1qcMbFbO82I/QPYZT9X7e7e05PdRmHCB1RStCA==
X-Received: by 2002:a05:6102:3746:b0:4e2:c6e4:ab1e with SMTP id ada2fe7eead31-4e6e40f5416mr4853322137.7.1748630975283;
        Fri, 30 May 2025 11:49:35 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a27d524sm3158688241.6.2025.05.30.11.49.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:49:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: Remove extra identation
Date: Fri, 30 May 2025 14:49:32 -0400
Message-ID: <20250530184932.419785-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This remove the extra identation which doesn't really matter for
manpages.
---
 doc/org.bluez.Adapter.rst                     | 409 +++++++++---------
 doc/org.bluez.AdminPolicySet.rst              |  20 +-
 doc/org.bluez.AdminPolicyStatus.rst           |   8 +-
 doc/org.bluez.AdvertisementMonitor.rst        | 116 ++---
 doc/org.bluez.AdvertisementMonitorManager.rst |  73 ++--
 doc/org.bluez.Agent.rst                       | 131 +++---
 doc/org.bluez.AgentManager.rst                |  65 ++-
 doc/org.bluez.Battery.rst                     |  15 +-
 doc/org.bluez.BatteryProvider.rst             |   2 +-
 doc/org.bluez.BatteryProviderManager.rst      |  12 +-
 doc/org.bluez.Device.rst                      | 400 ++++++++---------
 doc/org.bluez.DeviceSet.rst                   |  36 +-
 doc/org.bluez.GattCharacteristic.rst          | 372 ++++++++--------
 doc/org.bluez.GattDescriptor.rst              | 124 +++---
 doc/org.bluez.GattManager.rst                 |  29 +-
 doc/org.bluez.GattProfile.rst                 |  11 +-
 doc/org.bluez.GattService.rst                 |  24 +-
 doc/org.bluez.Input.rst                       |  33 +-
 doc/org.bluez.LEAdvertisement.rst             | 166 +++----
 doc/org.bluez.LEAdvertisingManager.rst        | 109 ++---
 doc/org.bluez.Media.rst                       | 119 +++--
 doc/org.bluez.MediaAssistant.rst              |  40 +-
 doc/org.bluez.MediaControl.rst                |  26 +-
 doc/org.bluez.MediaEndpoint.rst               | 216 +++++----
 doc/org.bluez.MediaFolder.rst                 |  61 ++-
 doc/org.bluez.MediaItem.rst                   |  92 ++--
 doc/org.bluez.MediaPlayer.rst                 | 278 ++++++------
 doc/org.bluez.MediaTransport.rst              | 298 +++++++------
 doc/org.bluez.Network.rst                     |  51 ++-
 doc/org.bluez.NetworkServer.rst               |  45 +-
 doc/org.bluez.Profile.rst                     |  28 +-
 doc/org.bluez.ProfileManager.rst              | 133 +++---
 doc/org.bluez.obex.Agent.rst                  |  31 +-
 doc/org.bluez.obex.AgentManager.rst           |  22 +-
 doc/org.bluez.obex.Client.rst                 |  55 ++-
 doc/org.bluez.obex.FileTransfer.rst           | 127 +++---
 doc/org.bluez.obex.Image.rst                  | 100 +++--
 doc/org.bluez.obex.Message.rst                | 104 ++---
 doc/org.bluez.obex.MessageAccess.rst          | 215 +++++----
 doc/org.bluez.obex.ObjectPush.rst             |  71 ++-
 doc/org.bluez.obex.PhonebookAccess.rst        | 399 +++++++++--------
 doc/org.bluez.obex.Session.rst                |  20 +-
 doc/org.bluez.obex.Synchronization.rst        |  64 +--
 doc/org.bluez.obex.Transfer.rst               |  66 ++-
 44 files changed, 2405 insertions(+), 2411 deletions(-)

diff --git a/doc/org.bluez.Adapter.rst b/doc/org.bluez.Adapter.rst
index c5b8ed8e9132..174b604136e3 100644
--- a/doc/org.bluez.Adapter.rst
+++ b/doc/org.bluez.Adapter.rst
@@ -24,210 +24,207 @@ Methods
 void StartDiscovery()
 `````````````````````
 
-	Starts device discovery session which may include starting an inquiry
-	and/or scanning procedures and remote device name resolving.
+Starts device discovery session which may include starting an inquiry and/or
+scanning procedures and remote device name resolving.
 
-	Use **StopDiscovery** to release the sessions acquired.
+Use **StopDiscovery** to release the sessions acquired.
 
-	This process will start creating Device objects as new devices are
-	discovered.
+This process will start creating Device objects as new devices are discovered.
 
-	During discovery RSSI delta-threshold is imposed.
+During discovery RSSI delta-threshold is imposed.
 
-	Each client can request a single device discovery session per adapter.
+Each client can request a single device discovery session per adapter.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.NotReady:
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.InProgress:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
 
 void StopDiscovery()
 ````````````````````
 
-	Stops device discovery session started by **StartDiscovery**.
+Stops device discovery session started by **StartDiscovery**.
 
-	Note that a discovery procedure is shared between all discovery sessions
-	thus calling StopDiscovery will only release a single session and
-	discovery will stop when all sessions from all clients have finished.
+Note that a discovery procedure is shared between all discovery sessions thus
+calling StopDiscovery will only release a single session and discovery will stop
+when all sessions from all clients have finished.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.NotReady:
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.NotAuthorized:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.Failed:
+:org.bluez.Error.NotAuthorized:
 
 void RemoveDevice(object device)
 ````````````````````````````````
 
-	Removes the remote device object at the given path including cahed
-	information such as bonding information.
+Removes the remote device object at the given path including cahed information
+such as bonding information.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.Failed:
 
 void SetDiscoveryFilter(dict filter)
 ````````````````````````````````````
 
-	Sets the device discovery filter for the caller. When this method is
-	called with no filter parameter, filter is removed.
+Sets the device discovery filter for the caller. When this method is called with
+no filter parameter, filter is removed.
 
-	Possible filter values:
+Possible filter values:
 
-	:array{string} UUIDs:
+:array{string} UUIDs:
 
-		Filter by service UUIDs, empty means match *any* UUID.
+	Filter by service UUIDs, empty means match *any* UUID.
 
-		When a remote device is found that advertises any UUID from
-		UUIDs, it will be reported if:
+	When a remote device is found that advertises any UUID from
+	UUIDs, it will be reported if:
 
-		- **Pathloss** and **RSSI** are both empty.
-		- only **Pathloss** param is set, device advertise TX power, and
-		  computed pathloss is less than Pathloss param.
-		- only **RSSI** param is set, and received RSSI is higher
-		  than RSSI param.
+	- **Pathloss** and **RSSI** are both empty.
+	- only **Pathloss** param is set, device advertise TX power, and
+	  computed pathloss is less than Pathloss param.
+	- only **RSSI** param is set, and received RSSI is higher
+	  than RSSI param.
 
-	:int16 RSSI:
+:int16 RSSI:
 
-		RSSI threshold value.
+	RSSI threshold value.
 
-		PropertiesChanged signals will be emitted for already existing
-		Device objects, with updated RSSI value. If one or more
-		discovery filters have been set, the RSSI delta-threshold, that
-		is imposed by StartDiscovery by default, will not be applied.
+	PropertiesChanged signals will be emitted for already existing Device
+	objects, with updated RSSI value. If one or more discovery filters have
+	been set, the RSSI delta-threshold, that is imposed by StartDiscovery by
+	default, will not be applied.
 
-	:uint16 Pathloss:
+:uint16 Pathloss:
 
-		Pathloss threshold value.
+	Pathloss threshold value.
 
-		PropertiesChanged signals will be emitted for already existing
-		Device objects, with updated Pathloss value.
+	PropertiesChanged signals will be emitted for already existing Device
+	objects, with updated Pathloss value.
 
-	:string Transport (Default "auto"):
+:string Transport (Default "auto"):
 
-		Transport parameter determines the type of scan.
+	Transport parameter determines the type of scan.
 
-		Possible values:
+	Possible values:
 
-		:"auto":
+	:"auto":
 
-			Interleaved scan, use LE, BREDR, or both, depending on
-			what's currently enabled.
+		Interleaved scan, use LE, BREDR, or both, depending on
+		what's currently enabled.
 
-		:"bredr":
+	:"bredr":
 
-			BR/EDR inquiry only.
+		BR/EDR inquiry only.
 
-		:"le":
+	:"le":
 
-			LE scan only.
+		LE scan only.
 
 
-	:bool DuplicateData (Default false):
+:bool DuplicateData (Default false):
 
-		Disables duplicate detection of advertisement data.
+	Disables duplicate detection of advertisement data.
 
-		When enabled PropertiesChanged signals will be generated for
-		either ManufacturerData and ServiceData everytime they are
-		discovered.
+	When enabled PropertiesChanged signals will be generated for either
+	ManufacturerData and ServiceData everytime they are discovered.
 
-	:bool Discoverable (Default false):
+:bool Discoverable (Default false):
 
-		Make adapter discoverable while discovering, if the adapter is
-		already discoverable setting this filter won't do anything.
+	Make adapter discoverable while discovering, if the adapter is already
+	discoverable setting this filter won't do anything.
 
-	:string Pattern (Default none):
+:string Pattern (Default none):
 
-		Discover devices where the pattern matches either the prefix of
-		the address or device name which is convenient way to limited
-		the number of device objects created during a discovery.
+	Discover devices where the pattern matches either the prefix of the
+	address or device name which is convenient way to limited the number of
+	device objects created during a discovery.
 
-		When set disregards device discoverable flags.
+	When set disregards device discoverable flags.
 
-		Note: The pattern matching is ignored if there are other client
-		that don't set any pattern as it work as a logical OR, also
-		setting empty string "" pattern will match any device found.
+	Note: The pattern matching is ignored if there are other client that
+	don't set any pattern as it work as a logical OR, also setting empty
+	string "" pattern will match any device found.
 
-	:bool AutoConnect (Default false):
+:bool AutoConnect (Default false):
 
-		Connect to discovered devices automatically if a Pattern has
-		been set and it matches the device address or name and it is
-		connectable.
+	Connect to discovered devices automatically if a Pattern has
+	been set and it matches the device address or name and it is
+	connectable.
 
-	When discovery filter is set, Device objects will be created as new
-	devices with matching criteria are discovered regardless of they are
-	connectable or discoverable which enables listening to non-connectable
-	and non-discoverable devices.
+When discovery filter is set, Device objects will be created as new devices with
+matching criteria are discovered regardless of they are connectable or
+discoverable which enables listening to non-connectable and non-discoverable
+devices.
 
-	When multiple clients call SetDiscoveryFilter, their filters are
-	internally merged, and notifications about new devices are sent to all
-	clients. Therefore, each client must check that device updates actually
-	match its filter.
+When multiple clients call SetDiscoveryFilter, their filters are internally
+merged, and notifications about new devices are sent to all clients. Therefore,
+each client must check that device updates actually match its filter.
 
-	When SetDiscoveryFilter is called multiple times by the same client,
-	last filter passed will be active for given client.
+When SetDiscoveryFilter is called multiple times by the same client, last filter
+passed will be active for given client.
 
-	SetDiscoveryFilter can be called before StartDiscovery.
-	It is useful when client will create first discovery session,
-	to ensure that proper scan will be started right after call to
-	StartDiscovery.
+SetDiscoveryFilter can be called before StartDiscovery.
+It is useful when client will create first discovery session, to ensure that
+proper scan will be started right after call to StartDiscovery.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.NotReady:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 array{string} GetDiscoveryFilters()
 ```````````````````````````````````
 
-	Returns available filters that can be given to **SetDiscoveryFilter**.
+Returns available filters that can be given to **SetDiscoveryFilter**.
 
-	Possible errors: None
+Possible errors: None
 
 object ConnectDevice(dict properties) [experimental]
 ````````````````````````````````````````````````````
 
-	connects to device without need of performing General Discovery.
-	Connection mechanism is similar to Connect method on
-	**org.bluez.Device1(5)** interface with exception that this method
-	returns success when physical connection is established and you can
-	specify bearer to connect with parameter. After this method returns,
-	services discovery will continue and any supported profile will be
-	connected. There is no need for calling Connect on Device1 after this
-	call. If connection was successful this method returns object path to
-	created device object or device that already exist.
+Connects to device without need of performing General Discovery.
 
-	Possible properties values:
+Connection mechanism is similar to Connect method on **org.bluez.Device1(5)**
+interface with exception that this method returns success when physical
+connection is established and you can specify bearer to connect with parameter.
 
-	:string Address (Mandatory):
+After this method returns, services discovery will continue and any supported
+profile will be connected. There is no need for calling Connect on Device1 after
+this call. If connection was successful this method returns object path to
+created device object or device that already exist.
 
-		The Bluetooth device address of the remote device.
+Possible properties values:
 
-	:string AddressType (Default "BR/EDR"):
+:string Address (Mandatory):
 
-		The Bluetooth device Address Type. This is address type that
-		should be used for initial connection.
+	The Bluetooth device address of the remote device.
 
-		Possible values:
+:string AddressType (Default "BR/EDR"):
 
-		:"public":
+	The Bluetooth device Address Type. This is address type that should be
+	used for initial connection.
 
-			Public address
+	Possible values:
 
-		:"random":
+	:"public":
 
-			Random address
+		Public address
 
-	Possible errors:
+	:"random":
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.AlreadyExists:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.NotReady:
-	:org.bluez.Error.Failed:
+		Random address
+
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.AlreadyExists:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.Failed:
 
 Properties
 ----------
@@ -235,197 +232,195 @@ Properties
 string Address [readonly]
 `````````````````````````
 
-	The Bluetooth device address.
+The Bluetooth device address.
 
 string AddressType [readonly]
 `````````````````````````````
 
-	The Bluetooth Address Type. For dual-mode and BR/EDR only adapter this
-	defaults to "public". Single mode LE adapters may have either value.
-	With privacy enabled this contains type of Identity Address and not
-	type of address used for connection.
+The Bluetooth Address Type. For dual-mode and BR/EDR only adapter this defaults
+to "public". Single mode LE adapters may have either value. With privacy enabled
+this contains type of Identity Address and not type of address used for
+connection.
 
-	Possible values:
+Possible values:
 
-	:"public":
+:"public":
 
-		Public address.
+	Public address.
 
 
-	:"random:
+:"random":
 
-		Random address.
+	Random address.
 
 string Name [readonly]
 ``````````````````````
 
-	The Bluetooth system name (pretty hostname).
+The Bluetooth system name (pretty hostname).
 
-	This property is either a static system default or controlled by an
-	external daemon providing access to the pretty hostname configuration.
+This property is either a static system default or controlled by an external
+daemon providing access to the pretty hostname configuration.
 
 string Alias [readwrite]
 ````````````````````````
 
-	The Bluetooth friendly name. This value can be changed.
+The Bluetooth friendly name. This value can be changed.
 
-	In case no alias is set, it will return the system provided name.
-	Setting an empty string as alias will convert it back to the system
-	provided name.
+In case no alias is set, it will return the system provided name. Setting an
+empty string as alias will convert it back to the system provided name.
 
-	When resetting the alias with an empty string, the property will default
-	back to system name.
+When resetting the alias with an empty string, the property will default back to
+system name.
 
-	On a well configured system, this property never needs to be changed
-	since it defaults to the system name and provides the pretty hostname.
-	Only if the local name needs to be different from the pretty hostname,
-	this property should be used as last resort.
+On a well configured system, this property never needs to be changed since it
+defaults to the system name and provides the pretty hostname.
+
+Only if the local name needs to be different from the pretty hostname, this
+property should be used as last resort.
 
 uint32 Class [readonly]
 ```````````````````````
 
-	The Bluetooth class of device.
+The Bluetooth class of device.
 
-	This property represents the value that is either automatically
-	configured by DMI/ACPI information or provided as static configuration.
+This property represents the value that is either automatically configured by
+DMI/ACPI information or provided as static configuration.
 
 boolean Connectable [readwrite]
 ```````````````````````````````
 
-	Set an adapter to connectable or non-connectable. This is a global
-	setting and should only be used by the settings application.
+Set an adapter to connectable or non-connectable. This is a global setting and
+should only be used by the settings application.
 
-	Setting this property to false will set the Discoverable property
-	of the adapter to false as well, which will not be reverted if
-	if Connectable is set back to true. If required, the application
-	will need to manually set Discoverable to true.
+Setting this property to false will set the Discoverable property of the adapter
+to false as well, which will not be reverted if Connectable is set back to true.
 
-	Note that this property only affects incoming connections.
+If required, the application will need to manually set Discoverable to true.
+
+Note that this property only affects incoming connections.
 
 boolean Powered [readwrite]
 ```````````````````````````
 
-	Switch an adapter on or off. This will also set the appropriate
-	connectable state of the controller.
+Switch an adapter on or off. This will also set the appropriate connectable
+state of the controller.
 
-	The value of this property is not persistent. After restart or
-	unplugging of the adapter it will reset back to false.
+The value of this property is not persistent. After restart or unplugging of the
+adapter it will reset back to false.
 
 string PowerState [readonly, experimental]
 ``````````````````````````````````````````
 
-	The power state of an adapter.
+The power state of an adapter.
 
-	The power state will show whether the adapter is turning off, or turning
-	on, as well as being on or off.
+The power state will show whether the adapter is turning off, or turning on, as
+well as being on or off.
 
-	Possible values:
+Possible values:
 
-	:"on":
+:"on":
 
-		Powered on.
+	Powered on.
 
-	:"off":
+:"off":
 
-		Powered off
+	Powered off
 
-	:"off-enabling":
+:"off-enabling":
 
-		Transitioning from "off" to "on".
+	Transitioning from "off" to "on".
 
-	:"on-disabling":
+:"on-disabling":
 
-		Transitioning from "on" to "off".
+	Transitioning from "on" to "off".
 
-	:"off-blocked":
+:"off-blocked":
 
-		Blocked by rfkill.
+	Blocked by rfkill.
 
 boolean Discoverable [readwrite] (Default: false)
 `````````````````````````````````````````````````
 
-	Switch an adapter to discoverable or non-discoverable to either make it
-	visible or hide it. This is a global setting and should only be used by
-	the settings application.
+Switch an adapter to discoverable or non-discoverable to either make it visible
+or hide it. This is a global setting and should only be used by the settings
+application.
 
-	If the DiscoverableTimeout is set to a non-zero value then the system
-	will set this value back to false after the timer expired.
+If the DiscoverableTimeout is set to a non-zero value then the system will set
+this value back to false after the timer expired.
 
-	In case the adapter is switched off, setting this value will fail.
+In case the adapter is switched off, setting this value will fail.
 
-	When changing the Powered property the new state of this property will
-	be updated via a PropertiesChanged signal.
+When changing the Powered property the new state of this property will be
+updated via a PropertiesChanged signal.
 
 boolean Pairable [readwrite] (Default: true)
 ````````````````````````````````````````````
 
-	Switch an adapter to pairable or non-pairable. This is a global setting
-	and should only be used by the settings application.
+Switch an adapter to pairable or non-pairable. This is a global setting and
+should only be used by the settings application.
 
-	Note that this property only affects incoming pairing requests.
+Note that this property only affects incoming pairing requests.
 
 uint32 PairableTimeout [readwrite] (Default: 0)
 ```````````````````````````````````````````````
 
-	The pairable timeout in seconds. A value of zero means that the timeout
-	is disabled and it will stay in pairable mode forever.
+The pairable timeout in seconds. A value of zero means that the timeout is
+disabled and it will stay in pairable mode forever.
 
 uint32 DiscoverableTimeout [readwrite] (Default: 180)
 `````````````````````````````````````````````````````
 
-	The discoverable timeout in seconds. A value of zero means that the
-	timeout is disabled and it will stay in discoverable/limited mode
-	forever.
+The discoverable timeout in seconds. A value of zero means that the timeout is
+disabled and it will stay in discoverable/limited mode forever.
 
 boolean Discovering [readonly]
 ``````````````````````````````
 
-	Indicates that a device discovery procedure is active.
+Indicates that a device discovery procedure is active.
 
 array{string} UUIDs [readonly]
 ``````````````````````````````
 
-	List of 128-bit UUIDs that represents the available local services.
+List of 128-bit UUIDs that represents the available local services.
 
 string Modalias [readonly, optional]
 ````````````````````````````````````
 
-	Local Device ID information in modalias format used by the kernel and
-	udev.
+Local Device ID information in modalias format used by the kernel and udev.
 
 array{string} Roles [readonly]
 ``````````````````````````````
 
-	List of supported roles.
+List of supported roles.
 
-	Possible values:
+Possible values:
 
-	:"central":
+:"central":
 
-		Supports the central role.
+	Supports the central role.
 
-	:"peripheral":
+:"peripheral":
 
-		Supports the peripheral role.
+	Supports the peripheral role.
 
-	:"central-peripheral":
+:"central-peripheral":
 
-		Supports both roles concurrently.
+	Supports both roles concurrently.
 
 array{string} ExperimentalFeatures [readonly, optional]
 ```````````````````````````````````````````````````````
 
-	List of 128-bit UUIDs that represents the experimental features
-	currently enabled.
+List of 128-bit UUIDs that represents the experimental features currently
+enabled.
 
 uint16 Manufacturer [readonly]
 ``````````````````````````````
 
-	The manufacturer of the device, as a uint16 company identifier defined
-	by the Core Bluetooth Specification.
+The manufacturer of the device, as a uint16 company identifier defined by the
+Core Bluetooth Specification.
 
 byte Version [readonly]
 ```````````````````````
 
-	The Bluetooth version supported by the device, as a core version code
-	defined by the Core Bluetooth Specification.
+The Bluetooth version supported by the device, as a core version code defined by
+the Core Bluetooth Specification.
diff --git a/doc/org.bluez.AdminPolicySet.rst b/doc/org.bluez.AdminPolicySet.rst
index 7ce4efcfed99..ff4cdd2bae8a 100644
--- a/doc/org.bluez.AdminPolicySet.rst
+++ b/doc/org.bluez.AdminPolicySet.rst
@@ -35,18 +35,18 @@ Methods
 void SetServiceAllowList(array{string} UUIDs)
 `````````````````````````````````````````````
 
-	Sets the service allowlist by specifying service UUIDs.
+Sets the service allowlist by specifying service UUIDs.
 
-	When called, **bluetoothd(8)** will block incoming and outgoing
-	connections to the service not in UUIDs for all of the clients.
+When called, **bluetoothd(8)** will block incoming and outgoing connections to
+the service not in UUIDs for all of the clients.
 
-	Any subsequent calls to this method will supersede any previously set
-	allowlist values.  Calling this method with an empty array will allow
-	any service UUIDs to be used.
+Any subsequent calls to this method will supersede any previously set allowlist
+values.  Calling this method with an empty array will allow any service UUIDs to
+be used.
 
-	The default value is an empty array.
+The default value is an empty array.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.Failed:
diff --git a/doc/org.bluez.AdminPolicyStatus.rst b/doc/org.bluez.AdminPolicyStatus.rst
index ad2dc58dec0a..18008a2b07af 100644
--- a/doc/org.bluez.AdminPolicyStatus.rst
+++ b/doc/org.bluez.AdminPolicyStatus.rst
@@ -32,7 +32,7 @@ Device
 
 :Service:	org.bluez
 :Interface:	org.bluez.AdminPolicyStatus1 [experimental]
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
 
 Properties
 ----------
@@ -40,10 +40,10 @@ Properties
 array{string} ServiceAllowList [readonly, adapter-only]
 ```````````````````````````````````````````````````````
 
-	Current value of service allow list.
+Current value of service allow list.
 
 bool IsAffectedByPolicy [readonly, device-only]
 ```````````````````````````````````````````````
 
-	Indicate if there is any auto-connect profile in this device is not
-	allowed by admin policy.
+Indicate if there is any auto-connect profile in this device is not allowed by
+admin policy.
diff --git a/doc/org.bluez.AdvertisementMonitor.rst b/doc/org.bluez.AdvertisementMonitor.rst
index 98852ac68b59..33cdf7945677 100644
--- a/doc/org.bluez.AdvertisementMonitor.rst
+++ b/doc/org.bluez.AdvertisementMonitor.rst
@@ -36,32 +36,33 @@ Methods
 void Release() [noreply]
 ````````````````````````
 
-	This gets called as a signal for a client to perform clean-up when:
+This gets called as a signal for a client to perform clean-up when:
 
-	- Monitor cannot be activated after it was exposed
-	- Monitor has been deactivated.
+- Monitor cannot be activated after it was exposed
+- Monitor has been deactivated.
 
 void Activate() [noreply]
 `````````````````````````
 
-	After a monitor was exposed, this gets called as a signal for client to
-	get acknowledged when a monitor has been activated, so the client can
-	expect to receive calls on **DeviceFound()** or **DeviceLost()**.
+After a monitor was exposed, this gets called as a signal for client to get
+acknowledged when a monitor has been activated, so the client can expect to
+receive calls on **DeviceFound()** or **DeviceLost()**.
 
 void DeviceFound(object device) [noreply]
 `````````````````````````````````````````
 
-	This gets called to notify the client of finding the targeted device.
-	Once receiving the call, the client should start to monitor the
-	corresponding device to retrieve the changes on RSSI and advertisement
-	content.
+This gets called to notify the client of finding the targeted device.
+
+Once receiving the call, the client should start to monitor the corresponding
+device to retrieve the changes on RSSI and advertisement content.
 
 void DeviceLost(object device) [noreply]
 ````````````````````````````````````````
 
-	This gets called to notify the client of losing the targeted device.
-	Once receiving this call, the client should stop monitoring the
-	corresponding device.
+This gets called to notify the client of losing the targeted device.
+
+Once receiving this call, the client should stop monitoring the corresponding
+device.
 
 Properties
 ----------
@@ -69,62 +70,64 @@ Properties
 string Type [read-only]
 ```````````````````````
 
-	The type of the monitor. See **SupportedMonitorTypes** in
-	**org.bluez.AdvertisementMonitorManager(5)** for the available options.
+The type of the monitor. See **SupportedMonitorTypes** in
+**org.bluez.AdvertisementMonitorManager(5)** for the available options.
 
 int16 RSSILowThreshold [read-only, optional]
 ````````````````````````````````````````````
 
-	Used in conjunction with **RSSILowTimeout** to determine whether a
-	device becomes out-of-range. Valid range is -127 to 20 (dBm), while 127
-	indicates unset.
+Used in conjunction with **RSSILowTimeout** to determine whether a device
+becomes out-of-range.
+
+Valid range is -127 to 20 (dBm), while 127 indicates unset.
 
 int16 RSSIHighThreshold [read-only, optional]
 `````````````````````````````````````````````
 
-	Used in conjunction with RSSIHighTimeout to determine whether a device
-	becomes in-range. Valid range is -127 to 20 (dBm), while 127 indicates
-	unset.
+Used in conjunction with RSSIHighTimeout to determine whether a device becomes
+in-range.
+
+Valid range is -127 to 20 (dBm), while 127 indicates unset.
 
 uint16 RSSILowTimeout [read-only, optional]
 ```````````````````````````````````````````
 
-	The time it takes to consider a device as out-of-range. If this many
-	seconds elapses without receiving any signal at least as strong as
-	**RSSILowThreshold**, a currently in-range device will be considered as
-	out-of-range (lost). Valid range is 1 to 300 (seconds), while 0
-	indicates unset.
+The time it takes to consider a device as out-of-range. If this many seconds
+elapses without receiving any signal at least as strong as **RSSILowThreshold**,
+a currently in-range device will be considered as out-of-range (lost). Valid
+range is 1 to 300 (seconds), while 0 indicates unset.
 
 uint16 RSSIHighTimeout [read-only, optional]
 ````````````````````````````````````````````
 
-	The time it takes to consider a device as in-range. If this many
-	seconds elapses while we continuouslyreceive signals at least as strong
-	as **RSSIHighThreshold**, a currently out-of-range device will be
-	considered as in-range (found). Valid range is 1 to 300 (seconds),
-	while 0 indicates unset.
+The time it takes to consider a device as in-range. If this many seconds elapses
+while we continuously receive signals at least as strong as
+**RSSIHighThreshold**, a currently out-of-range device will be considered as
+in-range (found).
+
+Valid range is 1 to 300 (seconds), while 0 indicates unset.
 
 uint16 RSSISamplingPeriod [read-only, optional]
 ```````````````````````````````````````````````
 
-	Grouping rules on how to propagate the received advertisement packets
-	to the client.
+Grouping rules on how to propagate the received advertisement packets to the
+client.
 
-	Possible values:
+Possible values:
 
-	:0:
-		All advertisement packets from in-range devices would be
-		propagated.
+:0:
+	All advertisement packets from in-range devices would be
+	propagated.
 
-	:255:
-		Only the first advertisement packet of in-range devices would
-		be propagated. If the device becomes lost, then the first
-		packet when it is found again will also be propagated.
+:255:
+	Only the first advertisement packet of in-range devices would be
+	propagated. If the device becomes lost, then the first packet when it is
+	found again will also be propagated.
 
-	:1 to 254:
-		Advertisement packets would be grouped into 100ms * N time
-		period. Packets in the same group will only be reported once,
-		with the RSSI value being averaged out.
+:1 to 254:
+	Advertisement packets would be grouped into 100ms * N time period.
+	Packets in the same group will only be reported once, with the RSSI
+	value being averaged out.
 
 	Currently this is unimplemented in user space, so the value is only
 	used to be forwarded to the kernel.
@@ -132,22 +135,21 @@ uint16 RSSISamplingPeriod [read-only, optional]
 array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
 `````````````````````````````````````````````````````````````````
 
-	If the **Type** property is set to **"or_patterns"**, then this
-	property must exist and have at least one entry in the array.
+If the **Type** property is set to **"or_patterns"**, then this property must
+exist and have at least one entry in the array.
 
-	The structure of a pattern contains the following:
+The structure of a pattern contains the following:
 
-	:uint8 start_position:
+:uint8 start_position:
 
-		The index in an AD data field where the search hould start. The
-		beginning of an AD data field is index 0.
+	The index in an AD data field where the search hould start. The
+	beginning of an AD data field is index 0.
 
-	:uint8 AD_data_type:
+:uint8 AD_data_type:
 
-		See https://www.bluetooth.com/specifications/assigned-numbers/
-		generic-access-profile/ for the possible allowed value.
+	See https://www.bluetooth.com/specifications/assigned-numbers/
+	generic-access-profile/ for the possible allowed value.
 
-	:array{byte} content_of_pattern:
+:array{byte} content_of_pattern:
 
-		This is the value of the pattern. The maximum length of the
-		bytes is 31.
+	This is the value of the pattern. The maximum length of the bytes is 31.
diff --git a/doc/org.bluez.AdvertisementMonitorManager.rst b/doc/org.bluez.AdvertisementMonitorManager.rst
index 477a0e9e2557..3860429b0cee 100644
--- a/doc/org.bluez.AdvertisementMonitorManager.rst
+++ b/doc/org.bluez.AdvertisementMonitorManager.rst
@@ -24,39 +24,40 @@ Methods
 void RegisterMonitor(object application)
 ````````````````````````````````````````
 
-	Registers the root path of a hierarchy of advertisement monitors
-	implementing **org.bluez.AdvertisementMonitor(5)**.
+Registers the root path of a hierarchy of advertisement monitors implementing
+**org.bluez.AdvertisementMonitor(5)**.
 
-	The application object path together with the D-Bus ystem bus
-	connection ID define the identification of the application registering
-	advertisement monitors.
+The application object path together with the D-Bus ystem bus connection ID
+define the identification of the application registering advertisement monitors.
 
-	Once a root path is registered by a client via this method, the client
-	can freely expose/unexpose advertisement monitors without re-registering
-	the root path again. After use, the client should call
-	**UnregisterMonitor()** method to invalidate the advertisement monitors.
+Once a root path is registered by a client via this method, the client can
+freely expose/unexpose advertisement monitors without re-registering the root
+path again.
 
-	Possible errors:
+After use, the client should call **UnregisterMonitor()** method to invalidate
+the advertisement monitors.
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.AlreadyExists:
-	:org.bluez.Error.Failed:
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.AlreadyExists:
+:org.bluez.Error.Failed:
 
 void UnregisterMonitor(object application)
 ``````````````````````````````````````````
 
-	Unregisters a hierarchy of advertisement monitors that has been
-	previously registered with **RegisterMonitor()**. The object path
-	parameter must match the same value that has been used on registration.
+Unregisters a hierarchy of advertisement monitors that has been previously
+registered with **RegisterMonitor()**. The object path parameter must match the
+same value that has been used on registration.
 
-	Upon unregistration, the advertisement monitor(s) should expect to
-	receive **Release()** method as the signal that the advertisement
-	monitor(s) has been deactivated.
+Upon unregistration, the advertisement monitor(s) should expect to receive
+**Release()** method as the signal that the advertisement monitor(s) has been
+deactivated.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.DoesNotExist:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.DoesNotExist:
 
 Properties
 ----------
@@ -64,27 +65,27 @@ Properties
 array{string} SupportedMonitorTypes [read-only]
 ```````````````````````````````````````````````
 
-	This lists the supported types of advertisement monitors. An application
-	should check this before instantiate and expose an object of
-	**org.bluez.AdvertisementMonitor(5)**.
+This lists the supported types of advertisement monitors. An application
+should check this before instantiate and expose an object of
+**org.bluez.AdvertisementMonitor(5)**.
 
-	Possible values:
+Possible values:
 
-	:"or_patterns":
+:"or_patterns":
 
-		Patterns with logic OR applied. With this type, property
-		**Patterns** must exist and has at least one pattern.
+	Patterns with logic OR applied. With this type, property **Patterns**
+	must exist and has at least one pattern.
 
 array{string} SupportedFeatures [read-only]
 ```````````````````````````````````````````
 
-	This lists the features of advertisement monitoring supported by
-	**bluetoothd(8)**.
+This lists the features of advertisement monitoring supported by
+**bluetoothd(8)**.
 
-	Possible values:
+Possible values:
 
-	:"controller-patterns":
+:"controller-patterns":
 
-		If the controller is capable of performing advertisement
-		monitoring by patterns, **bluetoothd(8)** would offload the
-		patterns to the controller to reduce power consumption.
+	If the controller is capable of performing advertisement monitoring by
+	patterns, **bluetoothd(8)** would offload the patterns to the controller
+	to reduce power consumption.
diff --git a/doc/org.bluez.Agent.rst b/doc/org.bluez.Agent.rst
index 6b6d75edb4ce..33c9e2144db6 100644
--- a/doc/org.bluez.Agent.rst
+++ b/doc/org.bluez.Agent.rst
@@ -24,126 +24,123 @@ Methods
 void Release()
 ``````````````
 
-	This method gets called when the service daemon unregisters the agent.
-	An agent can use it to do cleanup tasks. There is no need to unregister
-	the agent, because when this method gets called it has already been
-	unregistered.
+This method gets called when **bluetoothd(8)** unregisters the agent.
+
+An agent can use it to do cleanup tasks. There is no need to unregister the
+agent, because when this method gets called it has already been unregistered.
 
 string RequestPinCode(object device)
 ````````````````````````````````````
 
-	This method gets called when the service daemon needs to get the passkey
-	for an authentication.
+This method gets called when **bluetoothd(8)** needs to get the passkey for an
+authentication.
 
-	The return value should be a string of 1-16 characters length. The
-	string can be alphanumeric.
+The return value should be a string of 1-16 characters length. The string can be
+alphanumeric.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Rejected:
-	:org.bluez.Error.Canceled:
+:org.bluez.Error.Rejected:
+:org.bluez.Error.Canceled:
 
 void DisplayPinCode(object device, string pincode)
 ``````````````````````````````````````````````````
 
-	This method gets called when the service daemon needs to display a
-	pincode for an authentication.
+This method gets called when **bluetoothd(8)** needs to display a pincode for
+an authentication.
 
-	An empty reply should be returned. When the pincode needs no longer to
-	be displayed, the Cancel method of the agent will be called.
+An empty reply should be returned. When the pincode needs no longer to be
+displayed, the Cancel method of the agent will be called.
 
-	This is used during the pairing process of keyboards that don't support
-	Bluetooth 2.1 Secure Simple Pairing, in contrast to DisplayPasskey which
-	is used for those that do.
+This is used during the pairing process of keyboards that don't support
+Bluetooth 2.1 Secure Simple Pairing, in contrast to DisplayPasskey which is used
+for those that do.
 
-	This method will only ever be called once since older keyboards do not
-	support typing notification.
+This method will only ever be called once since older keyboards do not support
+typing notification.
 
-	Note that the PIN will always be a 6-digit number, zero-padded to 6
-	digits. This is for harmony with the later specification.
+Note that the PIN will always be a 6-digit number, zero-padded to 6 digits. This
+is for harmony with the later specification.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Rejected:
-	:org.bluez.Error.Canceled:
+:org.bluez.Error.Rejected:
+:org.bluez.Error.Canceled:
 
 uint32 RequestPasskey(object device)
 ````````````````````````````````````
 
-	This method gets called when the service daemon needs to get the passkey
-	for an authentication.
+This method gets called when **bluetoothd(8)** needs to get the passkey for an
+authentication.
 
-	The return value should be a numeric value between 0-999999.
+The return value should be a numeric value between 0-999999.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Rejected:
-	:org.bluez.Error.Canceled:
+:org.bluez.Error.Rejected:
+:org.bluez.Error.Canceled:
 
 void DisplayPasskey(object device, uint32 passkey, uint16 entered)
 ``````````````````````````````````````````````````````````````````
 
-	This method gets called when the service daemon needs to display a
-	passkey for an authentication.
+This method gets called when **bluetoothd(8)** needs to display a passkey for
+an authentication.
 
-	The entered parameter indicates the number of already typed keys on the
-	remote side.
+The entered parameter indicates the number of already typed keys on the remote
+side.
 
-	An empty reply should be returned. When the passkey needs no longer to
-	be displayed, the Cancel method of the agent will be called.
+An empty reply should be returned. When the passkey needs no longer to be
+displayed, the Cancel method of the agent will be called.
 
-	During the pairing process this method might be called multiple times to
-	update the entered value.
+During the pairing process this method might be called multiple times to update
+the entered value.
 
-	Note that the passkey will always be a 6-digit number, so the display
-	should be zero-padded at the start if the value contains less than 6
-	digits.
+Note that the passkey will always be a 6-digit number, so the display should be
+zero-padded at the start if the value contains less than 6 digits.
 
 void RequestConfirmation(object device, uint32 passkey)
 ```````````````````````````````````````````````````````
 
-	This method gets called when the service daemon needs to confirm a
-	passkey for an authentication.
+This method gets called when **bluetoothd(8)** needs to confirm a passkey for
+an authentication.
 
-	To confirm the value it should return an empty reply or an error in case
-	the passkey is invalid.
+To confirm the value it should return an empty reply or an error in case the
+passkey is invalid.
 
-	Note that the passkey will always be a 6-digit number, so the display
-	should be zero-padded at the start if the value contains less than 6
-	digits.
+Note that the passkey will always be a 6-digit number, so the display should be
+zero-padded at the start if the value contains less than 6 digits.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Rejected:
-	:org.bluez.Error.Canceled:
+:org.bluez.Error.Rejected:
+:org.bluez.Error.Canceled:
 
 void RequestAuthorization(object device)
 ````````````````````````````````````````
 
-	This method gets called to request the user to authorize an incoming
-	pairing attempt which would in other circumstances trigger the
-	just-works model, or when the user plugged in a device that implements
-	cable pairing. In the latter case, the device would not be connected to
-	the adapter via Bluetooth yet.
+This method gets called to request the user to authorize an incoming pairing
+attempt which would in other circumstances trigger the just-works model, or when
+the user plugged in a device that implements cable pairing. In the latter case,
+the device would not be connected to the adapter via Bluetooth yet.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Rejected:
-	:org.bluez.Error.Canceled:
+:org.bluez.Error.Rejected:
+:org.bluez.Error.Canceled:
 
 void AuthorizeService(object device, string uuid)
 `````````````````````````````````````````````````
 
-	This method gets called when the service daemon needs to authorize a
-	connection/service request.
+This method gets called when **bluetoothd(8)** needs to authorize a
+connection/service request.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Rejected:
-	:org.bluez.Error.Canceled:
+:org.bluez.Error.Rejected:
+:org.bluez.Error.Canceled:
 
 void Cancel()
 `````````````
 
-	This method gets called to indicate that the agent request failed before
-	a reply was returned.
+This method gets called to indicate that the agent request failed before a reply
+was returned.
diff --git a/doc/org.bluez.AgentManager.rst b/doc/org.bluez.AgentManager.rst
index fadadecb1cbf..77373c0153fd 100644
--- a/doc/org.bluez.AgentManager.rst
+++ b/doc/org.bluez.AgentManager.rst
@@ -24,59 +24,58 @@ Methods
 void RegisterAgent(object agent, string capability)
 ```````````````````````````````````````````````````
 
-	Registers pairing agent.
+Registers pairing agent.
 
-	The object path defines the path of the agent that will be called when
-	user input is needed and must implement **org.bluez.Agent(5)**
-	interface.
+The object path defines the path of the agent that will be called when user
+input is needed and must implement **org.bluez.Agent(5)** interface.
 
-	Every application can register its own agent and for all actions
-	triggered by that application its agent is used.
+Every application can register its own agent and for all actions triggered by
+that application its agent is used.
 
-	It is not required by an application to register an agent. If an
-	application does chooses to not register an agent, the default agent is
-	used. This is on most cases a good idea. Only application like a pairing
-	wizard should register their own agent.
+It is not required by an application to register an agent. If an application
+does chooses to not register an agent, the default agent is used. This is on
+most cases a good idea. Only application like a pairing wizard should register
+their own agent.
 
-	An application can only register one agent. Multiple agents per
-	application is not supported.
+An application can only register one agent. Multiple agents per application is
+not supported.
 
-	Possible capability values:
+Possible capability values:
 
-	:"":
+:"":
 
-		Fallback to "KeyboardDisplay".
+	Fallback to "KeyboardDisplay".
 
-	:"DisplayOnly":
-	:"DisplayYesNo":
-	:"KeyboardOnly":
-	:"NoInputNoOutput":
-	:"KeyboardDisplay":
+:"DisplayOnly":
+:"DisplayYesNo":
+:"KeyboardOnly":
+:"NoInputNoOutput":
+:"KeyboardDisplay":
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.AlreadyExists:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.AlreadyExists:
 
 void UnregisterAgent(object agent)
 ``````````````````````````````````
 
-	Unregisters an agent that has been previously registered using
-	**RegisterAgent**. The object path parameter must match the same value
-	that has been used on registration.
+Unregisters an agent that has been previously registered using
+**RegisterAgent**. The object path parameter must match the same value that has
+been used on registration.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.DoesNotExist:
+:org.bluez.Error.DoesNotExist:
 
 void RequestDefaultAgent(object agent)
 ``````````````````````````````````````
 
-	Requests to make the application agent the default agent. The
-	application is required to register an agent.
+Requests to make the application agent the default agent. The application is
+required to register an agent.
 
-	Special permission might be required to become the default agent.
+Special permission might be required to become the default agent.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.DoesNotExist:
+:org.bluez.Error.DoesNotExist:
diff --git a/doc/org.bluez.Battery.rst b/doc/org.bluez.Battery.rst
index d7e903c496ec..5f9c6e7c6d3f 100644
--- a/doc/org.bluez.Battery.rst
+++ b/doc/org.bluez.Battery.rst
@@ -16,7 +16,7 @@ Interface
 
 :Service:	org.bluez
 :Interface:	org.bluez.Battery1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
 
 Properties
 ----------
@@ -24,16 +24,15 @@ Properties
 byte Percentage [readonly]
 ``````````````````````````
 
-	The percentage of battery left as an unsigned 8-bit integer.
+The percentage of battery left as an unsigned 8-bit integer.
 
 string Source [readonly, optional]
 ``````````````````````````````````
 
-	Describes where the battery information comes from.
+Describes where the battery information comes from.
 
-	This property is informational only and may be useful for debugging
-	purposes.
+This property is informational only and may be useful for debugging purposes.
 
-	Providers from **org.bluez.BatteryProvider(5)** may make use
-	of this property to indicate where the battery report comes from
-	(e.g. "HFP 1.7", "HID", or the profile UUID).
+Providers from **org.bluez.BatteryProvider(5)** may make use of this property to
+indicate where the battery report comes from (e.g. "HFP 1.7", "HID", or the
+profile UUID).
diff --git a/doc/org.bluez.BatteryProvider.rst b/doc/org.bluez.BatteryProvider.rst
index b8d8b1c2ddd0..2373cebf9277 100644
--- a/doc/org.bluez.BatteryProvider.rst
+++ b/doc/org.bluez.BatteryProvider.rst
@@ -29,4 +29,4 @@ provides.
 object Device [readonly]
 ````````````````````````
 
-	The object path of the device that has this battery.
+The object path of the device that has this battery.
diff --git a/doc/org.bluez.BatteryProviderManager.rst b/doc/org.bluez.BatteryProviderManager.rst
index ab5cf2d4cadc..9724af339f25 100644
--- a/doc/org.bluez.BatteryProviderManager.rst
+++ b/doc/org.bluez.BatteryProviderManager.rst
@@ -38,13 +38,13 @@ Methods
 void RegisterBatteryProvider(object provider)
 `````````````````````````````````````````````
 
-	Registers a battery provider. A registered battery provider can then
-	expose objects with **org.bluez.BatteryProvider(5)** interface.
+Registers a battery provider. A registered battery provider can then expose
+objects with **org.bluez.BatteryProvider(5)** interface.
 
 void UnregisterBatteryProvider(object provider)
 ```````````````````````````````````````````````
 
-	Unregisters a battery provider previously registered with
-	**RegisterBatteryProvider()**. After unregistration, the
-	**org.bluez.BatteryProvider(5)** objects provided by this client are
-	ignored by **bluetoothd(8)**.
+Unregisters a battery provider previously registered with
+**RegisterBatteryProvider()**. After unregistration, the
+**org.bluez.BatteryProvider(5)** objects provided by this client are ignored by
+**bluetoothd(8)**.
diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index aaa97970524f..646e2c77ec2d 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -16,7 +16,7 @@ Interface
 
 :Service:	org.bluez
 :Interface:	org.bluez.Device1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
 
 Methods
 -------
@@ -24,136 +24,135 @@ Methods
 void Connect()
 ``````````````
 
-	Connects all profiles the remote device supports that can be connected
-	to and have been flagged as auto-connectable. If only subset of profiles
-	is already connected it will try to connect currently disconnected ones.
+Connects all profiles the remote device supports that can be connected to and
+have been flagged as auto-connectable. If only subset of profiles is already
+connected it will try to connect currently disconnected ones.
 
-	If at least one profile was connected successfully this method will
-	indicate success.
+If at least one profile was connected successfully this method will indicate
+success.
 
-	For dual-mode devices only one bearer is connected at time, the
-	conditions are in the following order:
+For dual-mode devices only one bearer is connected at time, the conditions are
+in the following order:
 
-	1. Connect the disconnected bearer if already connected.
+1. Connect the disconnected bearer if already connected.
 
-	2. Connect first the bonded bearer. If no bearers are bonded or both
-	are skip and check latest seen bearer.
+2. Connect first the bonded bearer. If no bearers are bonded or both are skip
+   and check latest seen bearer.
 
-	3. Connect last seen bearer, in case the timestamps are the same BR/EDR
-	takes precedence, or in case **PreferredBearer** has been set to a
-	specific bearer then that is used instead.
+3. Connect last used bearer, in case the timestamps are the same BR/EDR
+   takes precedence, or in case **PreferredBearer** has been set to a specific
+   bearer then that is used instead.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.NotReady:
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.AlreadyConnected:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.AlreadyConnected:
 
 void Disconnect()
 `````````````````
 
-	Disconnects all connected profiles and then terminates low-level ACL
-	connection.
+Disconnects all connected profiles and then terminates low-level ACL connection.
 
-	ACL connection will be terminated even if some profiles were not
-	disconnected properly e.g. due to misbehaving device.
+ACL connection will be terminated even if some profiles were not disconnected
+properly e.g. due to misbehaving device.
 
-	This method can be also used to cancel a preceding Connect call before
-	a reply to it has been received.
+This method can be also used to cancel a preceding Connect call before a reply
+to it has been received.
 
-	For non-trusted devices connected over LE bearer calling this method
-	will disable incoming connections until Connect method is called again.
+For non-trusted devices connected over LE bearer calling this method will
+disable incoming connections until Connect method is called again.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.NotConnected:
+:org.bluez.Error.NotConnected:
 
 void ConnectProfile(string uuid)
 ````````````````````````````````
 
-	Connects a specific profile of this device. The UUID provided is the
-	remote service UUID for the profile.
+Connects a specific profile of this device. The UUID provided is the remote
+service UUID for the profile.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotAvailable:
-	:org.bluez.Error.NotReady:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotAvailable:
+:org.bluez.Error.NotReady:
 
 void DisconnectProfile(string uuid)
 ```````````````````````````````````
 
-	Disconnects a specific profile of this device. The profile needs to be
-	registered client profile.
+Disconnects a specific profile of this device. The profile needs to be
+registered client profile.
 
-	There is no connection tracking for a profile, so as long as the
-	profile is registered this will always succeed.
+There is no connection tracking for a profile, so as long as the profile is
+registered this will always succeed.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
 
 void Pair()
 ```````````
 
-	Connects to the remote device and initiate pairing procedure then
-	proceed with service discovery.
+Connects to the remote device and initiate pairing procedure then proceed with
+service discovery.
 
-	If the application has registered its own agent, then that specific
-	agent will be used. Otherwise it will use the default agent.
+If the application has registered its own agent, then that specific agent will
+be used. Otherwise it will use the default agent.
 
-	Only for applications like a pairing wizard it would make sense to have
-	its own agent. In almost all other cases the default agent will handle
-	this just fine.
+Only for applications like a pairing wizard it would make sense to have its own
+agent. In almost all other cases the default agent will handle this just fine.
 
-	In case there is no application agent and also no default agent present,
-	this method will fail.
+In case there is no application agent and also no default agent present, this
+method will fail.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.AlreadyExists:
-	:org.bluez.Error.AuthenticationCanceled:
-	:org.bluez.Error.AuthenticationFailed:
-	:org.bluez.Error.AuthenticationRejected:
-	:org.bluez.Error.AuthenticationTimeout:
-	:org.bluez.Error.ConnectionAttemptFailed:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.Failed:
+:org.bluez.Error.AlreadyExists:
+:org.bluez.Error.AuthenticationCanceled:
+:org.bluez.Error.AuthenticationFailed:
+:org.bluez.Error.AuthenticationRejected:
+:org.bluez.Error.AuthenticationTimeout:
+:org.bluez.Error.ConnectionAttemptFailed:
 
 void CancelPairing()
 ````````````````````
 
-	Cancels a pairing operation initiated by the **Pair** method.
+Cancels a pairing operation initiated by the **Pair** method.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.DoesNotExist:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.DoesNotExist:
+:org.bluez.Error.Failed:
 
 array{array{byte}} GetServiceRecords() [experimental]
 `````````````````````````````````````````````````````
 
-	Returns all currently known BR/EDR service records for the device. Each
-	individual byte array represents a raw SDP record, as defined by the
-	Bluetooth Service Discovery Protocol specification.
+Returns all currently known BR/EDR service records for the device. Each
+individual byte array represents a raw SDP record, as defined by the Bluetooth
+Service Discovery Protocol specification.
 
-	This method is intended to be only used by compatibility layers like
-	Wine, that need to provide access to raw SDP records to support foreign
-	Bluetooth APIs. General applications should instead use the Profile API
-	for services-related functionality.
+This method is intended to be only used by compatibility layers like Wine, that
+need to provide access to raw SDP records to support foreign Bluetooth APIs.
 
-	Possible errors:
+General applications should instead use the Profile API for services-related
+functionality.
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.NotReady:
-	:org.bluez.Error.NotConnected:
-	:org.bluez.Error.DoesNotExist:
+Possible errors:
+
+:org.bluez.Error.Failed:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.NotConnected:
+:org.bluez.Error.DoesNotExist:
 
 Signals
 -------
@@ -161,51 +160,53 @@ Signals
 void Disconnected(string reason, string message)
 ````````````````````````````````````````````````
 
-	This signal is launched when a device is disconnected, with the reason
-	of the disconnection.
+This signal is launched when a device is disconnected, with the reason of the
+disconnection.
 
-	This could be used by client application, depending on internal policy,
-	to try to reconnect to the device in case of timeout or unknown
-	disconnection, or to try to connect to another device.
+This could be used by client application, depending on internal policy, to try
+to reconnect to the device in case of timeout or unknown disconnection, or to
+try to connect to another device.
 
-	Possible reasons:
+Possible reasons:
 
-	:org.bluez.Reason.Unknown:
+:org.bluez.Reason.Unknown:
 
-	:org.bluez.Reason.Timeout:
+:org.bluez.Reason.Timeout:
 
-		Connection timeout.
+	Connection timeout.
 
-		The link supervision timeout has expired for a connection or the
-		synchronization timeout has expired for a broadcast.
+	The link supervision timeout has expired for a connection or the
+	synchronization timeout has expired for a broadcast.
 
-	:org.bluez.Reason.Local:
+:org.bluez.Reason.Local:
 
-		Connection terminated by local host.
+	Connection terminated by local host.
 
-		The local device terminated the connection, terminated
-		synchronization with a broadcaster, or terminated broadcasting
-		packets.
+	The local device terminated the connection, terminated synchronization
+	with a broadcaster, or terminated broadcasting packets.
 
-	:org.bluez.Reason.Remote:
+:org.bluez.Reason.Remote:
 
-		Connection terminated by remote host.
+	Connection terminated by remote host.
 
-		This disconnection can be due to:
-		- the user on the remote device either terminated the connection
-		or stopped broadcasting packets,
-		- the remote device terminated the connection because of low
-		resources,
-		- the remote device terminated the connection because the device
-		is about to power off.
+	This disconnection can be due to:
 
-	:org.bluez.Reason.Authentication:
+	- the user on the remote device either terminated the connection or
+	  stopped broadcasting packets,
 
-		Connection terminated due to an authentication failure.
+	- the remote device terminated the connection because of low
+	  resources,
 
-	:org.bluez.Reason.Suspend:
+	- the remote device terminated the connection because the device is
+	  about to power off.
 
-		Connection terminated by local host for suspend.
+:org.bluez.Reason.Authentication:
+
+	Connection terminated due to an authentication failure.
+
+:org.bluez.Reason.Suspend:
+
+	Connection terminated by local host for suspend.
 
 Properties
 ----------
@@ -213,226 +214,227 @@ Properties
 string Address [readonly]
 `````````````````````````
 
-	The Bluetooth device address of the remote device.
+The Bluetooth device address of the remote device.
 
 string AddressType [readonly]
 `````````````````````````````
 
-	The Bluetooth device Address Type. For dual-mode and BR/EDR only devices
-	this defaults to "public". Single mode LE devices may have either value.
-	If remote device uses privacy than before pairing this represents
-	address type used for connection and Identity Address after pairing.
+The Bluetooth device Address Type. For dual-mode and BR/EDR only devices this
+defaults to "public". Single mode LE devices may have either value.
 
-	Possible values:
+If remote device uses privacy than before pairing this represents address type
+used for connection and Identity Address after pairing.
 
-	:"public":
+Possible values:
 
-		Public address
+:"public":
 
-	:"random":
+	Public address
 
-		Random address
+:"random":
+
+	Random address
 
 string Name [readonly, optional]
 ````````````````````````````````
 
-	The Bluetooth remote name.
+The Bluetooth remote name.
 
-	This value is only present for completeness. It is better to always use
-	the **Alias** property when displaying the devices name.
+This value is only present for completeness. It is better to always use the
+**Alias** property when displaying the devices name.
 
-	If the **Alias** property is unset, it will reflect this value which
-	makes it more convenient.
+If the **Alias** property is unset, it will reflect this value which makes it
+more convenient.
 
 string Icon [readonly, optional]
 ````````````````````````````````
 
-	Proposed icon name according to the freedesktop.org icon naming
-	specification.
+Proposed icon name according to the freedesktop.org icon naming specification.
 
 uint32 Class [readonly, optional]
 `````````````````````````````````
 
-	The Bluetooth class of device of the remote device.
+The Bluetooth class of device of the remote device.
 
 uint16 Appearance [readonly, optional]
 ``````````````````````````````````````
 
-	External appearance of device, as found on GAP service.
+External appearance of device, as found on GAP service.
 
 array{string} UUIDs [readonly, optional]
 ````````````````````````````````````````
 
-	List of 128-bit UUIDs that represents the available remote services.
+List of 128-bit UUIDs that represents the available remote services.
 
 boolean Paired [readonly]
 `````````````````````````
 
-	Indicates if the remote device is paired. Paired means the pairing
-	process where devices exchange the information to establish an
-	encrypted connection has been completed.
+Indicates if the remote device is paired. Paired means the pairing process where
+devices exchange the information to establish an encrypted connection has been
+completed.
 
 boolean Bonded [readonly]
 `````````````````````````
 
-	Indicates if the remote device is bonded. Bonded means the information
-	exchanged on pairing process has been stored and will be persisted.
+Indicates if the remote device is bonded. Bonded means the information exchanged
+on pairing process has been stored and will be persisted.
 
 boolean Connected [readonly]
 ````````````````````````````
 
-	Indicates if the remote device is currently connected.
-	A PropertiesChanged signal indicate changes to this status.
+Indicates if the remote device is currently connected.
+
+A PropertiesChanged signal indicate changes to this status.
 
 boolean Trusted [readwrite]
 ```````````````````````````
 
-	Indicates if the remote is seen as trusted. This setting can be changed
-	by the application.
+Indicates if the remote is seen as trusted.
+
+This setting can be changed by the application.
 
 boolean Blocked [readwrite]
 ```````````````````````````
 
-	If set to true any incoming connections from the device will be
-	immediately rejected. Any device drivers will also be removed and
-	no new ones will be probed as long as the device is blocked.
+If set to true any incoming connections from the device will be immediately
+rejected.
+
+Any device drivers will also be removed and no new ones will be probed as long
+as the device is blocked.
 
 boolean WakeAllowed [readwrite]
 ```````````````````````````````
 
-	If set to true this device will be allowed to wake the host from
-	system suspend.
+If set to true this device will be allowed to wake the host from system suspend.
 
 string Alias [readwrite]
 ````````````````````````
 
-	The name alias for the remote device. The alias can be used to have a
-	different friendly name for the remote device.
+The name alias for the remote device. The alias can be used to have a different
+friendly name for the remote device.
 
-	In case no alias is set, it will return the remote device name. Setting
-	an empty string as alias will convert it back to the remote device name.
+In case no alias is set, it will return the remote device name. Setting an empty
+string as alias will convert it back to the remote device name.
 
-	When resetting the alias with an empty string, the property will default
-	back to the remote name.
+When resetting the alias with an empty string, the property will default back to
+the remote name.
 
 object Adapter [readonly]
 `````````````````````````
 
-	The object path of the adapter the device belongs to.
+The object path of the adapter the device belongs to.
 
 boolean LegacyPairing [readonly]
 ````````````````````````````````
 
-	Set to true if the device only supports the pre-2.1 pairing mechanism.
-	This property is useful during device discovery to anticipate whether
-	legacy or simple pairing will occur if pairing is initiated.
+Set to true if the device only supports the pre-2.1 pairing mechanism.
 
-	Note that this property can exhibit false-positives in the case of
-	Bluetooth 2.1 (or newer) devices that have disabled Extended Inquiry
-	Response support.
+This property is useful during device discovery to anticipate whether legacy or
+simple pairing will occur if pairing is initiated.
+
+Note that this property can exhibit false-positives in the case of Bluetooth 2.1
+(or newer) devices that have disabled Extended Inquiry Response support.
 
 boolean CablePairing [readonly]
 ```````````````````````````````
 
-	Set to true if the device was cable paired and it doesn't support the
-	canonical bonding with encryption, e.g. the Sixaxis gamepad.
-	If true, BlueZ will establish a connection without enforcing encryption.
+Set to true if the device was cable paired and it doesn't support the canonical
+bonding with encryption, e.g. the Sixaxis gamepad.
+
+If true, BlueZ will establish a connection without enforcing encryption.
 
 string Modalias [readonly, optional]
 ````````````````````````````````````
 
-	Remote Device ID information in modalias format used by the kernel and
-	udev.
+Remote Device ID information in modalias format used by the kernel and udev.
 
 int16 RSSI [readonly, optional]
 ```````````````````````````````
 
-	Received Signal Strength Indicator of the remote device (inquiry or
-	advertising).
+Received Signal Strength Indicator of the remote device (inquiry or
+advertising).
 
 int16 TxPower [readonly, optional]
 ``````````````````````````````````
 
-	Advertised transmitted power level (inquiry or advertising).
+Advertised transmitted power level (inquiry or advertising).
 
 dict ManufacturerData [readonly, optional]
 ``````````````````````````````````````````
 
-	Manufacturer specific advertisement data. Keys are 16 bits Manufacturer
-	ID followed by its byte array value.
+Manufacturer specific advertisement data. Keys are 16 bits Manufacturer ID
+followed by its byte array value.
 
 dict ServiceData [readonly, optional]
 `````````````````````````````````````
 
-	Service advertisement data. Keys are the UUIDs in string format followed
-	by its byte array value.
+Service advertisement data. Keys are the UUIDs in string format followed by its
+byte array value.
 
 bool ServicesResolved [readonly]
 ````````````````````````````````
 
-	Indicate whether or not service discovery has been resolved.
+Indicate whether or not service discovery has been resolved.
 
 array{byte} AdvertisingFlags [readonly]
 ```````````````````````````````````````
 
-	The Advertising Data Flags of the remote device.
+The Advertising Data Flags of the remote device.
 
 dict AdvertisingData [readonly]
 ```````````````````````````````
 
-	The Advertising Data of the remote device. Keys are 1 byte AD Type
-	followed by data as byte array.
+The Advertising Data of the remote device. Keys are 1 byte AD Type followed by
+data as byte array.
 
-	Note: Only types considered safe to be handled by application are
-	exposed.
+Note: Only types considered safe to be handled by application are exposed.
 
-	Possible values:
+Possible values:
 
-	:<type>:
+:<type>:
 
-		<byte array>
+	<byte array>
 
-	Example:
+Example:
 
-		<Transport Discovery> <Organization Flags...>
-		0x26                   0x01         0x01...
+	<Transport Discovery> <Organization Flags...>
+	0x26                   0x01         0x01...
 
 array{object, dict} Sets [readonly, experimental]
 `````````````````````````````````````````````````
 
-	The object paths of the sets the device belongs to followed by a
-	dictionary which can contain the following:
+The object paths of the sets the device belongs to followed by a dictionary
+which can contain the following:
 
-	:byte Rank:
+:byte Rank:
 
-		Rank of the device in the Set.
+	Rank of the device in the Set.
 
 string PreferredBearer [readwrite, optional, experimental]
 ``````````````````````````````````````````````````````````
 
-	Indicate the preferred bearer when initiating a connection, only
-	available for dual-mode devices.
+Indicate the preferred bearer when initiating a connection, only available for
+dual-mode devices.
 
-	When changing from "bredr" to "le" the device will be removed from the
-	'auto-connect' list so it won't automatically be connected when
-	adverting.
+When changing from "bredr" to "le" the device will be removed from the
+'auto-connect' list so it won't automatically be connected when adverting.
 
-	Note: Changes only take effect when the device is disconnected.
+Note: Changes only take effect when the device is disconnected.
 
-	Possible values:
+Possible values:
 
-	:"last-used":
+:"last-used":
 
-		Connect to last used bearer first. Default.
+	Connect to last used bearer first. Default.
 
-	:"bredr":
+:"bredr":
 
-		Connect to BR/EDR first.
+	Connect to BR/EDR first.
 
-	:"le":
+:"le":
 
-		Connect to LE first.
+	Connect to LE first.
 
-	:"last-seen":
+:"last-seen":
 
-		Connect to last seen bearer first.
+	Connect to last seen bearer first.
diff --git a/doc/org.bluez.DeviceSet.rst b/doc/org.bluez.DeviceSet.rst
index c6dc8b075980..47f2ac6e0b01 100644
--- a/doc/org.bluez.DeviceSet.rst
+++ b/doc/org.bluez.DeviceSet.rst
@@ -24,27 +24,27 @@ Methods
 void Connect() [experimental]
 `````````````````````````````
 
-	Connects all **devices** members of the set, each member is
-	connected in sequence as they were added/loaded following the
-	same proceedure as described in **Device1.Connect**.
+Connects all **devices** members of the set, each member is connected in
+sequence as they were added/loaded following the same proceedure as described in
+**Device1.Connect**.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.NotReady:
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.AlreadyConnected:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.AlreadyConnected:
 
 void Disconnect() [experimental]
 ````````````````````````````````
 
-	Disconnects all **devices** members of the set, each member is
-	disconnected in sequence as they were connected following the
-	same proceedure as described in **Device1.Disconnect**.
+Disconnects all **devices** members of the set, each member is disconnected in
+sequence as they were connected following the same proceedure as described in
+**Device1.Disconnect**.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.NotConnected:
+:org.bluez.Error.NotConnected:
 
 Properties
 ----------
@@ -52,20 +52,20 @@ Properties
 object Adapter [readonly, experimental]
 ```````````````````````````````````````
 
-	The object path of the adapter the set belongs to.
+The object path of the adapter the set belongs to.
 
 bool AutoConnect [read-write, experimental]
 ```````````````````````````````````````````
 
-	Indicates if the **devices** members of the set shall be automatically
-	connected once any of its members is connected.
+Indicates if the **devices** members of the set shall be automatically connected
+once any of its members is connected.
 
 array(object) Devices [ready-only, experimental]
 ````````````````````````````````````````````````
 
-	List of devices objects that are members of the set.
+List of devices objects that are members of the set.
 
 byte Size [read-only, experimental]
 ```````````````````````````````````
 
-	Set members size.
+Set members size.
diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
index bdb3476fb04f..245f4ba665a7 100644
--- a/doc/org.bluez.GattCharacteristic.rst
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -30,7 +30,7 @@ Client
 
 :Service:	org.bluez
 :Interface:	org.bluez.GattCharacteristic1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/service#/char#
 
 Server
 ------
@@ -45,243 +45,238 @@ Methods
 array{byte} ReadValue(dict options)
 ```````````````````````````````````
 
-	Issues a request to read the value of the characteristic and returns the
-	value if the operation was successful.
+Issues a request to read the value of the characteristic and returns the value
+if the operation was successful.
 
-	Possible options:
+Possible options:
 
-	:uint16 offset:
+:uint16 offset:
 
-		Read start offset in bytes.
+	Read start offset in bytes.
 
-	:uint16 mtu (server only):
+:uint16 mtu (server only):
 
-		Exchange MTU in bytes.
+	Exchange MTU in bytes.
 
-	:object device (server only):
+:object device (server only):
 
-		Device object.
+	Device object.
 
-	:string link (server only):
+:string link (server only):
 
-		Link type.
+	Link type.
 
-		Possible values:
+	Possible values:
 
-		:"BR/EDR":
-		:"LE":
+	:"BR/EDR":
+	:"LE":
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.Failed:
+:org.bluez.Error.Failed:
 
-		Possible values: string 0x80 - 0x9f
+	Possible values: string 0x80 - 0x9f
 
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.NotPermitted:
-	:org.bluez.Error.NotAuthorized:
-	:org.bluez.Error.InvalidOffset:
-	:org.bluez.Error.NotSupported:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.NotPermitted:
+:org.bluez.Error.NotAuthorized:
+:org.bluez.Error.InvalidOffset:
+:org.bluez.Error.NotSupported:
 
 void WriteValue(array{byte} value, dict options)
 ````````````````````````````````````````````````
 
-	Issues a request to write the value of the characteristic.
+Issues a request to write the value of the characteristic.
 
-	Possible options:
+Possible options:
 
-	:uint16 offset:
+:uint16 offset:
 
-		Write start offset in bytes.
+	Write start offset in bytes.
 
-	:string type:
+:string type:
 
-		Possible values:
+	Possible values:
 
-		:"command":
+	:"command":
 
-			Use Write without response procedure.
+		Use Write without response procedure.
 
-		:"request":
+	:"request":
 
-			Use Write with response procedure.
+		Use Write with response procedure.
 
-		:"reliable":
+	:"reliable":
 
-			Use Reliable Write procedure.
+		Use Reliable Write procedure.
 
-	:uint16 mtu:
+:uint16 mtu:
 
-		Exchanged MTU (Server only).
+	Exchanged MTU (Server only).
 
-	:object device:
+:object device:
 
-		Device path (Server only).
+	Device path (Server only).
 
-	:string link:
+:string link:
 
-		Link type (Server only).
+	Link type (Server only).
 
-		Possible values:
+	Possible values:
 
-		:"BR/EDR":
-		:"LE":
+	:"BR/EDR":
+	:"LE":
 
-	:boolean prepare-authorize:
+:boolean prepare-authorize:
 
-		True if prepare authorization request.
+	True if prepare authorization request.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.Failed:
+:org.bluez.Error.Failed:
 
-		Possible values: string 0x80 - 0x9f
+	Possible values: string 0x80 - 0x9f
 
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.NotPermitted:
-	:org.bluez.Error.InvalidValueLength:
-	:org.bluez.Error.NotAuthorized:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.ImproperlyConfigured:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.NotPermitted:
+:org.bluez.Error.InvalidValueLength:
+:org.bluez.Error.NotAuthorized:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.ImproperlyConfigured:
 
 fd, uint16 AcquireWrite(dict options) [optional]
 ````````````````````````````````````````````````
 
-	Acquire file descriptor and MTU for writing. Only sockets are supported.
-	Usage of WriteValue will be locked causing it to return NotPermitted
-	error.
+Acquire file descriptor and MTU for writing. Only sockets are supported. Usage
+of WriteValue will be locked causing it to return NotPermitted error.
 
-	For server the MTU returned shall be equal or smaller than the
-	negotiated MTU.
+For server the MTU returned shall be equal or smaller than the negotiated MTU.
 
-	For client it only works with characteristic that has **WriteAcquired**
-	property which relies on write-without-response **Flag**.
+For client it only works with characteristic that has **WriteAcquired** property
+which relies on write-without-response **Flag**.
 
-	To release the lock the client shall close the file descriptor, a HUP
-	is generated in case the device is disconnected.
+To release the lock the client shall close the file descriptor, a HUP is
+generated in case the device is disconnected.
 
-	Note: the MTU can only be negotiated once and is symmetric therefore
-	this method may be delayed in order to have the exchange MTU completed,
-	because of that the file descriptor is closed during reconnections as
-	the MTU has to be renegotiated.
+Note: the MTU can only be negotiated once and is symmetric therefore this method
+may be delayed in order to have the exchange MTU completed, because of that the
+file descriptor is closed during reconnections as the MTU has to be
+renegotiated.
 
-	Possible options:
+Possible options:
 
-	:object device:
+:object device:
 
-		Object Device (Server only).
+	Object Device (Server only).
 
-	:uint16 mtu:
+:uint16 mtu:
 
-		Exchanged MTU (Server only).
+	Exchanged MTU (Server only).
 
-	:string link:
+:string link:
 
-		Link type (Server only).
+	Link type (Server only).
 
-		Possible values:
+	Possible values:
 
-		:"BR/EDR":
-		:"LE":
+	:"BR/EDR":
+	:"LE":
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
 
 fd, uint16 AcquireNotify(dict options) [optional]
 `````````````````````````````````````````````````
 
-	Acquire file descriptor and MTU for notify. Only sockets are support.
+Acquire file descriptor and MTU for notify. Only sockets are support.
 
-	Usage of StartNotify will be locked causing it to return
-	**org.bluez.Error.NotPermitted**.
+Usage of StartNotify will be locked causing it to return
+**org.bluez.Error.NotPermitted**.
 
-	For server the MTU returned shall be equal or smaller than the
-	negotiated MTU.
+For server the MTU returned shall be equal or smaller than the negotiated MTU.
 
-	Only works with characteristic that has **NotifyAcquired** property
-	which relies on presence of **"notify" or "indicate"** **Flag** and no
-	other client have called **StartNotify()**.
+Only works with characteristic that has **NotifyAcquired** property which relies
+on presence of **"notify" or "indicate"** **Flag** and no other client have
+called **StartNotify()**.
 
-	Notification are enabled during this procedure so **StartNotify()**
-	shall not be called, any notification will be dispatched via file
-	descriptor therefore the Value property is not affected during the time
-	where notify has been acquired.
+Notification are enabled during this procedure so **StartNotify()** shall not be
+called, any notification will be dispatched via file descriptor therefore the
+Value property is not affected during the time where notify has been acquired.
 
-	To release the lock the client shall close the file descriptor, a HUP is
-	generated in case the device is disconnected.
+To release the lock the client shall close the file descriptor, a HUP is
+generated in case the device is disconnected.
 
-	As a client if indication procedure is used the confirmation is
-	generated automatically once received, for a server if the file
-	descriptor is writable (POLLOUT) then upon receiving a confirmation from
-	the client one byte (0x01) is written to the file descriptor.
+As a client if indication procedure is used the confirmation is generated
+automatically once received, for a server if the file descriptor is writable
+(POLLOUT) then upon receiving a confirmation from the client one byte (0x01) is
+written to the file descriptor.
 
-	Note: the MTU can only be negotiated once and is symmetric therefore
-	this method may be delayed in order to have the exchange MTU completed,
-	because of that the file descriptor is closed during reconnections as
-	the MTU has to be renegotiated.
+Note: the MTU can only be negotiated once and is symmetric therefore this method
+may be delayed in order to have the exchange MTU completed, because of that the
+file descriptor is closed during reconnections as the MTU has to be
+renegotiated.
 
-	Possible options:
+Possible options:
 
-	:object device:
+:object device:
 
-		Object Device (Server only).
+	Object Device (Server only).
 
-	:uint16 mtu:
+:uint16 mtu:
 
-		Exchanged MTU (Server only).
+	Exchanged MTU (Server only).
 
-	:string link:
+:string link:
 
-		Link type (Server only).
+	Link type (Server only).
 
-		Possible values:
+	Possible values:
 
-		:"BR/EDR":
-		:"LE":
+	:"BR/EDR":
+	:"LE":
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.NotPermitted:
+:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.NotPermitted:
 
 void StartNotify()
 ``````````````````
 
-	Starts a notification session from this characteristic if it supports
-	value notifications or indications.
+Starts a notification session from this characteristic if it supports value
+notifications or indications.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.NotPermitted:
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.NotConnected:
-	:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
+:org.bluez.Error.NotPermitted:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.NotConnected:
+:org.bluez.Error.NotSupported:
 
 void StopNotify()
 `````````````````
 
-	Stops or cancel session previously created by **StartNotify()**.
+Stops or cancel session previously created by **StartNotify()**.
 
-	Note that notifications from a characteristic are shared between
-	sessions thus calling StopNotify will release a single session.
+Note that notifications from a characteristic are shared between sessions thus
+calling StopNotify will release a single session.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.Failed:
+:org.bluez.Error.Failed:
 
 void Confirm() [noreply, optional] (Server only)
 ````````````````````````````````````````````````
 
+Confirms value was received.
 
-	Confirms value was received.
+Possible Errors:
 
-	Possible Errors:
-
-	org.bluez.Error.Failed
+org.bluez.Error.Failed
 
 Properties
 ----------
@@ -289,102 +284,99 @@ Properties
 string UUID [read-only]
 ```````````````````````
 
-	128-bit characteristic UUID.
+128-bit characteristic UUID.
 
 object Service [read-only]
 ``````````````````````````
 
-	Object path of the GATT service the characteristic belongs to.
+Object path of the GATT service the characteristic belongs to.
 
 array{byte} Value [read-only, optional]
 ```````````````````````````````````````
 
-	The cached value of the characteristic. This property gets updated only
-	after a successful read request and when a notification or indication
-	is received, upon which a PropertiesChanged signal will be emitted.
+The cached value of the characteristic. This property gets updated only after a
+successful read request and when a notification or indication is received, upon
+which a PropertiesChanged signal will be emitted.
 
 boolean WriteAcquired [read-only, optional]
 ```````````````````````````````````````````
 
-	True, if this characteristic has been acquired by any client using
-	AcquireWrite.
+True, if this characteristic has been acquired by any client using AcquireWrite.
 
-	For client properties is ommited in case 'write-without-response' flag
-	is not set.
+For client properties is ommited in case 'write-without-response' flag is not
+set.
 
-	For server the presence of this property indicates that AcquireWrite is
-	supported.
+For server the presence of this property indicates that AcquireWrite is
+supported.
 
 boolean NotifyAcquired [read-only, optional]
 ````````````````````````````````````````````
 
-	True, if this characteristic has been acquired by any client using
-	AcquireNotify.
+True, if this characteristic has been acquired by any client using
+AcquireNotify.
 
-	For client this properties is ommited in case 'notify' flag is not set.
+For client this properties is ommited in case 'notify' flag is not set.
 
-	For server the presence of this property indicates that AcquireNotify
-	is supported.
+For server the presence of this property indicates that AcquireNotify is
+supported.
 
 boolean Notifying [read-only, optional]
 ```````````````````````````````````````
 
-	True, if notifications or indications on this characteristic are
-	currently enabled.
+True, if notifications or indications on this characteristic are currently
+enabled.
 
 array{string} Flags [read-only]
 ```````````````````````````````
 
-	Defines how the characteristic value can be used. See Core spec
-	"Table 3.5: Characteristic Properties bit field", and
-	"Table 3.8: Characteristic Extended Properties bit field".
+Defines how the characteristic value can be used. See Core spec
+"Table 3.5: Characteristic Properties bit field", and
+"Table 3.8: Characteristic Extended Properties bit field".
 
-	The "x-notify" and "x-indicate" flags restrict access to notifications
-	and indications by imposing write restrictions on a characteristic's
-	client characteristic configuration descriptor.
+The "x-notify" and "x-indicate" flags restrict access to notifications and
+indications by imposing write restrictions on a characteristic's client
+characteristic configuration descriptor.
 
-	Possible values:
+Possible values:
 
-	:"broadcast":
-	:"read":
-	:"write-without-response":
-	:"write":
-	:"notify":
-	:"indicate":
-	:"authenticated-signed-writes":
-	:"extended-properties":
-	:"reliable-write":
-	:"writable-auxiliaries":
-	:"encrypt-read":
-	:"encrypt-write":
-	:"encrypt-notify" (Server only):
-	:"encrypt-indicate" (Server only):
-	:"encrypt-authenticated-read":
-	:"encrypt-authenticated-write":
-	:"encrypt-authenticated-notify" (Server only):
-	:"encrypt-authenticated-indicate" (Server only):
-	:"secure-read" (Server only):
-	:"secure-write" (Server only):
-	:"secure-notify" (Server only):
-	:"secure-indicate" (Server only):
-	:"authorize":
+:"broadcast":
+:"read":
+:"write-without-response":
+:"write":
+:"notify":
+:"indicate":
+:"authenticated-signed-writes":
+:"extended-properties":
+:"reliable-write":
+:"writable-auxiliaries":
+:"encrypt-read":
+:"encrypt-write":
+:"encrypt-notify" (Server only):
+:"encrypt-indicate" (Server only):
+:"encrypt-authenticated-read":
+:"encrypt-authenticated-write":
+:"encrypt-authenticated-notify" (Server only):
+:"encrypt-authenticated-indicate" (Server only):
+:"secure-read" (Server only):
+:"secure-write" (Server only):
+:"secure-notify" (Server only):
+:"secure-indicate" (Server only):
+:"authorize":
 
 uint16 Handle [read-only] (Client Only)
 ```````````````````````````````````````
 
-	Characteristic handle.
+Characteristic handle.
 
 uint16 Handle [read-write, optional] (Server Only)
 ``````````````````````````````````````````````````
 
-	Characteristic handle. When available in the server it would attempt to
-	use to allocate into the database which may fail, to auto allocate the
-	value 0x0000 shall be used which will cause the allocated handle to be
-	set once registered.
+Characteristic handle. When available in the server it would attempt to use to
+allocate into the database which may fail, to auto allocate the value 0x0000
+shall be used which will cause the allocated handle to be set once registered.
 
 uint16 MTU [read-only]
 ``````````````````````
 
-	Characteristic MTU, this is valid both for **ReadValue()** and
-	**WriteValue()** but either method can use long procedures when
-	supported.
+Characteristic MTU, this is valid both for **ReadValue()** and **WriteValue()**
+but either method can use long procedures when supported.
diff --git a/doc/org.bluez.GattDescriptor.rst b/doc/org.bluez.GattDescriptor.rst
index 536ef0ca7d83..76d274464f51 100644
--- a/doc/org.bluez.GattDescriptor.rst
+++ b/doc/org.bluez.GattDescriptor.rst
@@ -30,7 +30,7 @@ Client
 
 :Service:	org.bluez
 :Interface:	org.bluez.GattDescriptor1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY/descriptorZZZ
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/service#/char#/descriptor#
 
 Server
 ------
@@ -45,77 +45,77 @@ Methods
 array{byte} ReadValue(dict flags)
 `````````````````````````````````
 
-	Issues a request to read the value of the descriptor and returns the
-	value if the operation was successful.
+Issues a request to read the value of the descriptor and returns the value if
+the operation was successful.
 
-	Possible options:
+Possible options:
 
-	:uint16 offset:
+:uint16 offset:
 
-		Read start offset in bytes.
+	Read start offset in bytes.
 
-	:object device (server only):
+:object device (server only):
 
-		Device object.
+	Device object.
 
-	:string link:
+:string link:
 
-		Link type (Server only).
+	Link type (Server only).
 
-		Possible values:
+	Possible values:
 
-		:"BR/EDR":
-		:"LE":
+	:"BR/EDR":
+	:"LE":
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.NotPermitted:
-	:org.bluez.Error.NotAuthorized:
-	:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.NotPermitted:
+:org.bluez.Error.NotAuthorized:
+:org.bluez.Error.NotSupported:
 
 void WriteValue(array{byte} value, dict flags)
 ``````````````````````````````````````````````
 
-	Issues a request to write the value of the descriptor.
+Issues a request to write the value of the descriptor.
 
-	Possible flags:
+Possible flags:
 
-	:uint16 offset:
+:uint16 offset:
 
-		Write start offset in bytes.
+	Write start offset in bytes.
 
-	:uint16 mtu:
+:uint16 mtu:
 
-		Exchanged MTU (Server only).
+	Exchanged MTU (Server only).
 
-	:object device:
+:object device:
 
-		Device path (Server only).
+	Device path (Server only).
 
-	:string link:
+:string link:
 
-		Link type (Server only).
+	Link type (Server only).
 
-		Possible values:
+	Possible values:
 
-		:"BR/EDR":
-		:"LE":
+	:"BR/EDR":
+	:"LE":
 
-	:boolean prepare-authorize:
+:boolean prepare-authorize:
 
-		True if prepare authorization request.
+	True if prepare authorization request.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.NotPermitted:
-	:org.bluez.Error.InvalidValueLength:
-	:org.bluez.Error.NotAuthorized:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.ImproperlyConfigured:
+:org.bluez.Error.Failed:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.NotPermitted:
+:org.bluez.Error.InvalidValueLength:
+:org.bluez.Error.NotAuthorized:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.ImproperlyConfigured:
 
 Properties
 ----------
@@ -123,46 +123,44 @@ Properties
 string UUID [read-only]
 ```````````````````````
 
-	128-bit descriptor UUID.
+128-bit descriptor UUID.
 
 object Characteristic [read-only]
 `````````````````````````````````
 
-	Object path of the GATT characteristic the descriptor belongs to.
+Object path of the GATT characteristic the descriptor belongs to.
 
 array{byte} Value [read-only, optional]
 ```````````````````````````````````````
 
-	The cached value of the descriptor. This property gets updated only
-	after a successful read request, upon which a PropertiesChanged signal
-	will be emitted.
+The cached value of the descriptor. This property gets updated only after a
+successful read request, upon which a PropertiesChanged signal will be emitted.
 
 array{string} Flags [read-only]
 ```````````````````````````````
 
-	Defines how the descriptor value can be used.
+Defines how the descriptor value can be used.
 
-	Possible values:
+Possible values:
 
-	:"read":
-	:"write":
-	:"encrypt-read":
-	:"encrypt-write":
-	:"encrypt-authenticated-read":
-	:"encrypt-authenticated-write":
-	:"secure-read" (Server Only):
-	:"secure-write" (Server Only):
-	:"authorize":
+:"read":
+:"write":
+:"encrypt-read":
+:"encrypt-write":
+:"encrypt-authenticated-read":
+:"encrypt-authenticated-write":
+:"secure-read" (Server Only):
+:"secure-write" (Server Only):
+:"authorize":
 
 uint16 Handle [read-only] (Client Only)
 ```````````````````````````````````````
 
-	Descriptor handle.
+Descriptor handle.
 
 uint16 Handle [read-write, optional] (Server Only)
 ``````````````````````````````````````````````````
 
-	Descriptor handle. When available in the server it would attempt to
-	use to allocate into the database which may fail, to auto allocate the
-	value 0x0000 shall be used which will cause the allocated handle to be
-	set once registered.
+Descriptor handle. When available in the server it would attempt to use to
+allocate into the database which may fail, to auto allocate the value 0x0000
+shall be used which will cause the allocated handle to be set once registered.
diff --git a/doc/org.bluez.GattManager.rst b/doc/org.bluez.GattManager.rst
index f98296b89a01..2501530d8112 100644
--- a/doc/org.bluez.GattManager.rst
+++ b/doc/org.bluez.GattManager.rst
@@ -88,27 +88,26 @@ Methods
 void RegisterApplication(object application, dict options)
 ``````````````````````````````````````````````````````````
 
-	Registers a local GATT services hierarchy as described above
-	(GATT Server) and/or GATT profiles (GATT Client).
+Registers a local GATT services hierarchy as described above (GATT Server)
+and/or GATT profiles (GATT Client).
 
-	The application object path together with the D-Bus system bus
-	connection ID define the identification of the application registering
-	a GATT based service (**org.bluez.GattService(5)**) and/or profile
-	(**org.bluez.GattProfile(5)**).
+The application object path together with the D-Bus system bus connection ID
+define the identification of the application registering a GATT based service
+(**org.bluez.GattService(5)**) and/or profile (**org.bluez.GattProfile(5)**).
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.AlreadyExists:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.AlreadyExists:
 
 void UnregisterApplication(object application)
 ``````````````````````````````````````````````
 
-	This unregisters the services and/or profiles that has been previously
-	registered using **RegisterApplication()**. The object path parameter
-	must match the same value that has been used on registration.
+This unregisters the services and/or profiles that has been previously
+registered using **RegisterApplication()**. The object path parameter must match
+the same value that has been used on registration.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.DoesNotExist:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.DoesNotExist:
diff --git a/doc/org.bluez.GattProfile.rst b/doc/org.bluez.GattProfile.rst
index 904301a9773b..5852289a2b87 100644
--- a/doc/org.bluez.GattProfile.rst
+++ b/doc/org.bluez.GattProfile.rst
@@ -32,10 +32,11 @@ Methods
 void Release()
 ``````````````
 
-	This method gets called when the service daemon
-	unregisters the profile. The profile can use it to do cleanup tasks.
-	There is no need to unregister the profile, because when this method
-	gets called it has already been unregistered.
+This method gets called when **bluetoothd(8)** unregisters the profile. The
+profile can use it to do cleanup tasks.
+
+There is no need to unregister the profile, because when this method gets called
+it has already been unregistered.
 
 Properties
 ----------
@@ -43,4 +44,4 @@ Properties
 array{string} UUIDs [read-only]
 ```````````````````````````````
 
-	128-bit GATT service UUIDs to auto connect.
+128-bit GATT service UUIDs to auto connect.
diff --git a/doc/org.bluez.GattService.rst b/doc/org.bluez.GattService.rst
index 4a1e81fc9e03..9aba1c166f74 100644
--- a/doc/org.bluez.GattService.rst
+++ b/doc/org.bluez.GattService.rst
@@ -30,7 +30,7 @@ Client
 
 :Service:	org.bluez
 :Interface:	org.bluez.GattService1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/service#
 
 Server
 ------
@@ -45,35 +45,33 @@ Properties
 string UUID [read-only]
 ```````````````````````
 
-	128-bit service UUID.
+128-bit service UUID.
 
 boolean Primary [read-only]
 ```````````````````````````
 
-	Indicates whether or not this GATT service is a primary service. If
-	false, the service is secondary.
+Indicates whether or not this GATT service is a primary service. If false, the
+service is secondary.
 
 object Device [read-only, optional]
 ```````````````````````````````````
 
-	Object path of the Bluetooth device the service belongs to. Only
-	present on services from remote devices.
+Object path of the Bluetooth device the service belongs to. Only present on
+services from remote devices.
 
 array{object} Includes [read-only, optional]
 ````````````````````````````````````````````
 
-	Array of object paths representing the included services of this
-	service.
+Array of object paths representing the included services of this service.
 
 uint16 Handle [read-only] (client only)
 ```````````````````````````````````````
 
-	Service handle.
+Service handle.
 
 uint16 Handle [read-write, optional] (Server Only)
 ``````````````````````````````````````````````````
 
-	Service handle. When available in the server it would attempt to use to
-	allocate into the database which may fail, to auto allocate the value
-	0x0000 shall be used which will cause the allocated handle to be set
-	once registered.
+Service handle. When available in the server it would attempt to use to allocate
+into the database which may fail, to auto allocate the value 0x0000 shall be
+used which will cause the allocated handle to be set once registered.
diff --git a/doc/org.bluez.Input.rst b/doc/org.bluez.Input.rst
index c3c223c913d8..e9f0d2070627 100644
--- a/doc/org.bluez.Input.rst
+++ b/doc/org.bluez.Input.rst
@@ -16,7 +16,7 @@ Interface
 
 :Service:	org.bluez
 :Interface:	org.bluez.Input1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
 
 Properties
 ----------
@@ -24,28 +24,27 @@ Properties
 string ReconnectMode [readonly]
 ```````````````````````````````
 
-	Indicates the Connectability mode of the HID device as defined by the
-	HID Profile specification, Section 5.4.2.
+Indicates the Connectability mode of the HID device as defined by the HID
+Profile specification, Section 5.4.2.
 
-	This mode is based in the two properties HIDReconnectInitiate (see
-	Section 5.3.4.6) and HIDNormallyConnectable (see Section 5.3.4.14) which
-	define the following four possible values:
+This mode is based in the two properties HIDReconnectInitiate (see Section
+5.3.4.6) and HIDNormallyConnectable (see Section 5.3.4.14) which define the
+following four possible values:
 
-	:"none":
+:"none":
 
-		Device and host are not required to automatically restore the
-		connection.
+	Device and host are not required to automatically restore the
+	connection.
 
-	:"host":
+:"host":
 
-		Bluetooth HID host restores connection.
+	Bluetooth HID host restores connection.
 
-	:"device":
+:"device":
 
-		Bluetooth HID device restores connection.
+	Bluetooth HID device restores connection.
 
-	:"any":
+:"any":
 
-		Bluetooth HID device shall attempt to restore the lost
-		connection, but Bluetooth HID Host may also restore the
-		connection.
+	Bluetooth HID device shall attempt to restore the lost connection, but
+	Bluetooth HID Host may also restore the connection.
diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index b998f40a2e06..680a6c4cb97b 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -19,7 +19,7 @@ channels and available for all devices in range.  Because of the limited space
 available in LE Advertising packets, each packet's contents must be carefully
 controlled.
 
-The service daemon acts as a store for the Advertisement Data which is meant to
+**bluetoothd(8)** acts as a store for the Advertisement Data which is meant to
 be sent. It constructs the correct Advertisement Data from the structured
 data and configured the kernel to send the correct advertisement.
 
@@ -42,10 +42,11 @@ Methods
 void Release() [noreply]
 ````````````````````````
 
-	This method gets called when the service daemon removes the
-	Advertisement. A client can use it to do cleanup tasks. There is no
-	need to call **UnregisterAdvertisement()** because when this method
-	gets called it has already been unregistered.
+This method gets called when the **bluetoothd(8)** removes the Advertisement.
+
+A client can use it to do cleanup tasks. There is no need to call
+**UnregisterAdvertisement()** because when this method gets called it has
+already been unregistered.
 
 Properties
 ----------
@@ -53,174 +54,183 @@ Properties
 string Type [readonly]
 ``````````````````````
 
-	Determines the type of advertising packet requested.
+Determines the type of advertising packet requested.
 
-	Possible values:
+Possible values:
 
-	:"broadcast":
-	:"peripheral":
+:"broadcast":
+:"peripheral":
 
 array{string} ServiceUUIDs [readonly, optional]
 ```````````````````````````````````````````````
 
-	List of UUIDs to include in the "Service UUID" field of the Advertising
-	Data.
+List of UUIDs to include in the "Service UUID" field of the Advertising Data.
 
 dict ManufacturerData [readonly, optional]
 ``````````````````````````````````````````
 
-	Manufacturer Data fields to include in the Advertising Data.  Keys are
-	the Manufacturer ID to associate with the data.
+Manufacturer Data fields to include in the Advertising Data.
+
+Keys are the Manufacturer ID to associate with the data.
 
 array{string} SolicitUUIDs [readonly, optional]
 ```````````````````````````````````````````````
 
-	List of UUIDs to include in the "Service Solicitation" field of the
-	Advertising Data.
+List of UUIDs to include in the "Service Solicitation" field of the Advertising
+Data.
 
 dict ServiceData [readonly, optional]
 `````````````````````````````````````
 
-	Service Data elements to include in the Advertising Data. The keys
-	are the UUID to associate with the data.
+Service Data elements to include in the Advertising Data.
+
+The keys are the UUID to associate with the data.
 
 dict Data [readonly, optional]
 ``````````````````````````````
 
-	Advertising Data to include. Key is the advertising type and value is
-	the data as byte array.
+Advertising Data to include.
 
-	Note: Types already handled by other properties shall not be used.
+Key is the advertising type and value is the data as byte array.
 
-	Possible values:
+Note: Types already handled by other properties shall not be used.
 
-	:<type>:
+Possible values:
 
-		<byte array>
+:<type>:
 
-	Example:
-		<Transport Discovery> <Organization Flags...>
-		0x26                   0x01         0x01...
+	<byte array>
+
+Example:
+	<Transport Discovery> <Organization Flags...>
+	0x26                   0x01         0x01...
 
 array{string} ScanResponseServiceUUIDs [readonly, optional, experimental]
 `````````````````````````````````````````````````````````````````````````
 
-	List of UUIDs to include in the "Service UUID" field of the Scan
-	Response Data.
+List of UUIDs to include in the "Service UUID" field of the Scan Response Data.
 
 dict ScanResponseManufacturerData [readonly, optional, experimental]
 ````````````````````````````````````````````````````````````````````
 
-	Manufacturer Data fields to include in the Scan Response Data. Keys
-	are the Manufacturer ID to associate with the data.
+Manufacturer Data fields to include in the Scan Response Data.
+
+Keys are the Manufacturer ID to associate with the data.
 
 array{string} ScanResponseSolicitUUIDs [readonly, optional, experimental]
 `````````````````````````````````````````````````````````````````````````
 
-	List of UUIDs to include in the "Service Solicitation" field of the
-	Scan Response Data.
+List of UUIDs to include in the "Service Solicitation" field of the Scan
+Response Data.
 
 dict ScanResponseServiceData [readonly, optional, experimental]
 ```````````````````````````````````````````````````````````````
 
-	Service Data elements to include in the Scan Response Data. The keys
-	are the UUID to associate with the data.
+Service Data elements to include in the Scan Response Data.
+
+The keys are the UUID to associate with the data.
 
 dict ScanResponseData [readonly, optional, experimental]
 ````````````````````````````````````````````````````````
 
-	Scan Response Data to include. Key is the advertising type and value is
-	the data as byte array.
+Scan Response Data to include.
+
+Key is the advertising type and value is the data as byte array.
 
 bool Discoverable [readonly, optional]
 ``````````````````````````````````````
 
-	Advertise as general discoverable. When present this will override
-	adapter Discoverable property.
+Advertise as general discoverable. When present this will override adapter
+Discoverable property.
 
-	Note: This property shall not be set when **Type** is set to
-	"broadcast".
+Note: This property shall not be set when **Type** is set to "broadcast".
 
 uint16 DiscoverableTimeout [readonly, optional]
 ```````````````````````````````````````````````
 
-	The discoverable timeout in seconds. A value of zero means that the
-	timeout is disabled and it will stay in discoverable/limited mode
-	forever.
+The discoverable timeout in seconds. A value of zero means that the timeout is
+disabled and it will stay in discoverable/limited mode forever.
 
-	Note: This property shall not be set when **Type** is set to
-	"broadcast".
+Note: This property shall not be set when **Type** is set to "broadcast".
 
 array{string} Includes [readonly, optional]
 ```````````````````````````````````````````
 
-	List of features to be included in the advertising packet.
+List of features to be included in the advertising packet.
 
-	Possible values:
+Possible values:
 
-	See **org.bluez.LEAdvertisingManager(5)** **SupportedIncludes**
-	property.
+See **org.bluez.LEAdvertisingManager(5)** **SupportedIncludes** property.
 
 string LocalName [readonly, optional]
 `````````````````````````````````````
 
-	Local name to be used in the advertising report. If the string is too
-	big to fit into the packet it will be truncated.
+Local name to be used in the advertising report. If the string is too big to
+fit into the packet it will be truncated.
 
-	If this property is available 'local-name' cannot be present in the
-	**Includes**.
+If this property is available 'local-name' cannot be present in the
+**Includes**.
 
 uint16 Appearance [readonly, optional]
 ``````````````````````````````````````
 
-	Appearance to be used in the advertising report.
+Appearance to be used in the advertising report.
 
-	Possible values: as found on GAP Service.
+Possible values: as found on GAP Service.
 
 uint16 Duration [readonly, optional]
-``````````````````````````````````````
+````````````````````````````````````
 
-	Rotation duration of the advertisement in seconds. If there are other
-	applications advertising no duration is set the default is 2 seconds.
+Rotation duration of the advertisement in seconds.
+
+If there are other applications advertising no duration is set the default is
+2 seconds.
 
 uint16 Timeout [readonly, optional]
 `````````````````````````````````````
 
-	Timeout of the advertisement in seconds. This defines the lifetime of
-	the advertisement.
+Timeout of the advertisement in seconds. This defines the lifetime of the
+advertisement.
 
 string SecondaryChannel [readonly, optional]
 ````````````````````````````````````````````
 
-	Secondary channel to be used. Primary channel is always set to "1M"
-	except when "Coded" is set.
+Secondary channel to be used.
 
-	Possible value:
+Primary channel is always set to "1M" except when "Coded" is set.
 
-	:"1M" (default):
-	:"2M":
-	:"Coded":
+Possible value:
+
+:"1M" (default):
+:"2M":
+:"Coded":
 
 uint32 MinInterval [readonly, optional]
 ```````````````````````````````````````
 
-	Minimum advertising interval to be used by the advertising set, in
-	milliseconds. Acceptable values are in the range [20ms, 10,485s].
-	If the provided MinInterval is larger than the provided MaxInterval,
-	the registration will return failure.
+Minimum advertising interval to be used by the advertising set, in milliseconds.
+
+Acceptable values are in the range [20ms, 10,485s].
+
+If the provided MinInterval is larger than the provided MaxInterval, the
+registration will return failure.
 
 uint32 MaxInterval [readonly, optional]
 ```````````````````````````````````````
 
-	Maximum advertising interval to be used by the advertising set, in
-	milliseconds. Acceptable values are in the range [20ms, 10,485s]. If the
-	provided MinInterval is larger than the provided MaxInterval, the
-	registration will return failure.
+Maximum advertising interval to be used by the advertising set, in milliseconds.
+
+Acceptable values are in the range [20ms, 10,485s].
+
+If the provided MinInterval is larger than the provided MaxInterval, the
+registration will return failure.
 
 int16 TxPower [readonly, optional]
 ``````````````````````````````````
 
-	Requested transmission power of this advertising set. The provided value
-	is used only if the "CanSetTxPower" feature is enabled on the
-	**org.bluez.LEAdvertisingManager(5)**. The provided value must be in
-	range [-127 to +20], where units are in dBm.
+Requested transmission power of this advertising set.
+
+The provided value is used only if the "CanSetTxPower" feature is enabled on the
+**org.bluez.LEAdvertisingManager(5)**.
+
+Values must be in range [-127 to +20], where units are in dBm.
diff --git a/doc/org.bluez.LEAdvertisingManager.rst b/doc/org.bluez.LEAdvertisingManager.rst
index 93eac411acb8..464a2e5fb726 100644
--- a/doc/org.bluez.LEAdvertisingManager.rst
+++ b/doc/org.bluez.LEAdvertisingManager.rst
@@ -28,41 +28,43 @@ Methods
 void RegisterAdvertisement(object advertisement, dict options)
 ``````````````````````````````````````````````````````````````
 
-	Registers an advertisement object to be sent over the LE Advertising
-	channel.  The service must implement **org.bluez.LEAdvertisement(5)**
-	interface.
+Registers an advertisement object to be sent over the LE Advertising channel.
 
-	Possible errors:
+The service must implement **org.bluez.LEAdvertisement(5)** interface.
 
-	:org.bluez.Error.InvalidArguments:
+Possible errors:
 
-		Indicates that the object has invalid or conflicting properties.
+:org.bluez.Error.InvalidArguments:
 
-	:org.bluez.Error.AlreadyExists:
+	Indicates that the object has invalid or conflicting properties.
 
-		Indicates the object is already registered.
+:org.bluez.Error.AlreadyExists:
 
-	:org.bluez.Error.InvalidLength:
+	Indicates the object is already registered.
 
-		Indicates that the data provided generates a data packet which
-		is too long
+:org.bluez.Error.InvalidLength:
 
-	:org.bluez.Error.NotPermitted:
+	Indicates that the data provided generates a data packet which is too
+	long.
 
-		Indicates the maximum number of advertisement instances has
-		been reached.
+:org.bluez.Error.NotPermitted:
+
+	Indicates the maximum number of advertisement instances has been
+	reached.
 
 void UnregisterAdvertisement(object advertisement)
 ``````````````````````````````````````````````````
 
-	Unregisters an advertisement that has been previously registered using
-	**RegisterAdvertisement()**.  The object path parameter must match the
-	same value that has been used on registration.
+Unregisters an advertisement that has been previously registered using
+**RegisterAdvertisement()**.
 
-	Possible errors:
+The object path parameter must match the same value that has been used on
+registration.
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.DoesNotExist:
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.DoesNotExist:
 
 Properties
 ----------
@@ -70,75 +72,74 @@ Properties
 byte ActiveInstances [readonly]
 ```````````````````````````````
 
-	Number of active advertising instances.
+Number of active advertising instances.
 
 byte SupportedInstances [readonly]
 ``````````````````````````````````
 
-	Number of available advertising instances.
+Number of available advertising instances.
 
 array{string} SupportedIncludes [readonly]
 ``````````````````````````````````````````
 
-	List of supported system includes.
+List of supported system includes.
 
-	Possible values:
+Possible values:
 
-	:"tx-power":
-	:"appearance":
-	:"local-name":
-	:"rsi":
+:"tx-power":
+:"appearance":
+:"local-name":
+:"rsi":
 
 array{string} SupportedSecondaryChannels [readonly]
 ```````````````````````````````````````````````````
 
-	List of supported Secondary channels. Secondary channels can be used to
-	advertise with the corresponding PHY.
+List of supported Secondary channels. Secondary channels can be used to
+advertise with the corresponding PHY.
 
-	Possible values:
+Possible values:
 
-	:"1M":
-	:"2M":
-	:"Coded":
+:"1M":
+:"2M":
+:"Coded":
 
 dict SupportedCapabilities [readonly]
 `````````````````````````````````````
 
-	Enumerates Advertising-related controller capabilities useful to the
-	client.
+Enumerates Advertising-related controller capabilities useful to the client.
 
-	Possible Values:
+Possible Values:
 
-	:byte MaxAdvLen:
+:byte MaxAdvLen:
 
-		Max advertising data length
+	Max advertising data length
 
-	:byte MaxScnRspLen:
+:byte MaxScnRspLen:
 
-		Max advertising scan response length
+	Max advertising scan response length
 
-	:int16 MinTxPower:
+:int16 MinTxPower:
 
-		Min advertising tx power (dBm)
+	Min advertising tx power (dBm)
 
-	:int16 MaxTxPower:
+:int16 MaxTxPower:
 
-		Max advertising tx power (dBm)
+	Max advertising tx power (dBm)
 
 array{string} SupportedFeatures [readonly,optional]
 ```````````````````````````````````````````````````
 
-	List of supported platform features. If no features are available on
-	the platform, the SupportedFeatures array will be empty.
+List of supported platform features. If no features are available on the
+platform, the SupportedFeatures array will be empty.
 
-	Possible values:
+Possible values:
 
-	:"CanSetTxPower":
+:"CanSetTxPower":
 
-		Indicates whether platform can specify tx power on each
-		advertising instance.
+	Indicates whether platform can specify tx power on each advertising
+	instance.
 
-	:"HardwareOffload":
+:"HardwareOffload":
 
-		Indicates whether multiple advertising will be offloaded to the
-		controller.
+	Indicates whether multiple advertising will be offloaded to the
+	controller.
diff --git a/doc/org.bluez.Media.rst b/doc/org.bluez.Media.rst
index ef13a56a9ba1..dc265d783cbe 100644
--- a/doc/org.bluez.Media.rst
+++ b/doc/org.bluez.Media.rst
@@ -24,104 +24,102 @@ Methods
 void RegisterEndpoint(object endpoint, dict properties)
 ```````````````````````````````````````````````````````
 
-	Register a local end point to sender, the sender can register as many
-	end points as it likes.
+Register a local end point to sender, the sender can register as many end points
+as it likes.
 
-	Note: If the sender disconnects the end points are automatically
-	unregistered.
+Note: If the sender disconnects the end points are automatically unregistered.
 
-	possible properties:
+possible properties:
 
-	:string UUID:
+:string UUID:
 
-		UUID of the profile which the endpoint is for.
+	UUID of the profile which the endpoint is for.
 
-		UUID must be in the list of SupportedUUIDS.
+	UUID must be in the list of SupportedUUIDS.
 
-	:byte Codec:
+:byte Codec:
 
-		Assigned number of codec that the endpoint implements. The
-		values should match the profile specification which is
-		indicated by the UUID.
+	Assigned number of codec that the endpoint implements. The
+	values should match the profile specification which is
+	indicated by the UUID.
 
-	:uint32_t Vendor [Optional]:
+:uint32_t Vendor [Optional]:
 
-		Vendor-specific Company ID, Codec ID tuple that the endpoint
-		implements.
+	Vendor-specific Company ID, Codec ID tuple that the endpoint implements.
 
-		It shall be set to appropriate value when Vendor Specific Codec
-		(0xff) is used.
+	It shall be set to appropriate value when Vendor Specific Codec (0xff)
+	is used.
 
-	:array{byte} Capabilities:
+:array{byte} Capabilities:
 
-		Capabilities blob, it is used as it is so the size and byte
-		order must match.
+	Capabilities blob, it is used as it is so the size and byte order must
+	match.
 
-	:array{byte} Metadata [Optional]:
+:array{byte} Metadata [Optional]:
 
-		Metadata blob, it is used as it is so the size and byte order
-		must match.
+	Metadata blob, it is used as it is so the size and byte order must
+	match.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotSupported:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
 
-		emitted when interface for the end-point is disabled
+	emitted when interface for the end-point is disabled
 
 void UnregisterEndpoint(object endpoint)
 ````````````````````````````````````````
-	Unregister sender end point.
+Unregister sender end point.
 
 void RegisterPlayer(object player, dict properties)
 ```````````````````````````````````````````````````
 
-	Register a media player object to sender, the sender can register as
-	many objects as it likes.
+Register a media player object to sender, the sender can register as many
+objects as it likes.
 
-	Object must implement at least org.mpris.MediaPlayer2.Player as defined
-	in MPRIS 2.2 spec:
+Object must implement at least **org.mpris.MediaPlayer2.Player** as defined in
+MPRIS 2.2 spec:
 
-		http://specifications.freedesktop.org/mpris-spec/latest/
+http://specifications.freedesktop.org/mpris-spec/latest/
 
-	Note: If the sender disconnects its objects are automatically
-	unregistered.
+Note: If the sender disconnects its objects are automatically unregistered.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotSupported:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
 
 void UnregisterPlayer(object player)
 ````````````````````````````````````
 
-	Unregister sender media player.
+Unregister sender media player.
 
 void RegisterApplication(object root, dict options)
 ```````````````````````````````````````````````````
 
-	Register endpoints an player objects within root object which must
-	implement ObjectManager.
+Register endpoints an player objects within root object which must implement
+**org.freedesktop.DBus.ObjectManager**.
 
-	The application object path together with the D-Bus system bus
-	connection ID define the identification of the application.
+The application object path together with the D-Bus system bus connection ID
+define the identification of the application.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.AlreadyExists:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.AlreadyExists:
 
 void UnregisterApplication(object application)
 ``````````````````````````````````````````````
 
-	This unregisters the services that has been previously registered. The
-	object path parameter must match the same value that has been used on
-	registration.
+This unregisters the services that has been previously registered.
 
-	Possible errors:
+The object path parameter must match the same value that has been used on
+registration.
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.DoesNotExist:
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.DoesNotExist:
 
 Properties
 ----------
@@ -129,18 +127,17 @@ Properties
 array{string} SupportedUUIDs [readonly]
 ```````````````````````````````````````
 
-	List of 128-bit UUIDs that represents the supported Endpoint
-	registration.
+List of 128-bit UUIDs that represents the supported Endpoint registration.
 
 array{string} SupportedFeatures [readonly]
 ``````````````````````````````````````````
 
-	List of strings that represent supported special features.
-	Possible values:
+List of strings that represent supported special features.
 
-	:"tx-timestamping":
+Possible values:
 
-		Bluetooth TX timestamping in media stream sockets is
-		supported by BlueZ and kernel.  Applications may check
-		kernel support for specific timestamp types via
-		SIOCETHTOOL.
+:"tx-timestamping":
+
+	Bluetooth TX timestamping in media stream sockets is supported by BlueZ
+	and kernel.  Applications may check kernel support for specific
+	timestamp types via SIOCETHTOOL.
diff --git a/doc/org.bluez.MediaAssistant.rst b/doc/org.bluez.MediaAssistant.rst
index 4940251fa232..64e689f8621d 100644
--- a/doc/org.bluez.MediaAssistant.rst
+++ b/doc/org.bluez.MediaAssistant.rst
@@ -24,21 +24,21 @@ Methods
 void Push(dict properties)
 ````````````````````````````````````````````````````````
 
-	Send stream information to the remote device.
+Send stream information to the remote device.
 
-	:dict properties:
+:dict properties:
 
-	Indicate stream properties that will be sent to the peer.
+Indicate stream properties that will be sent to the peer.
 
-	Values:
+Values:
 
-		:array{byte} Metadata [ISO only]:
+	:array{byte} Metadata [ISO only]:
 
-			See Metadata property.
+		See Metadata property.
 
-		:dict QoS [ISO only]:
+	:dict QoS [ISO only]:
 
-			See QoS property.
+		See QoS property.
 
 Properties
 ----------
@@ -46,29 +46,29 @@ Properties
 string State [readonly]
 ```````````````````````
 
-	Indicates the state of the assistant object. Possible values are:
+Indicates the state of the assistant object. Possible values are:
 
-	:"idle": assistant object was created for the stream
-	:"pending": assistant object was pushed (stream information was sent to the peer)
-	:"requesting": remote device requires Broadcast_Code
-	:"active": remote device started receiving stream
+:"idle": assistant object was created for the stream
+:"pending": assistant object was pushed (stream information was sent to the peer)
+:"requesting": remote device requires Broadcast_Code
+:"active": remote device started receiving stream
 
 array{byte} Metadata [readwrite, ISO Only, experimental]
 ````````````````````````````````````````````````````````
 
-	Indicates stream Metadata.
+Indicates stream Metadata.
 
 dict QoS [readwrite, ISO only, experimental]
 `````````````````````````````````````````````````````
 
-	Indicates stream QoS capabilities.
+Indicates stream QoS capabilities.
 
-	Values:
+Values:
 
-	:byte Encryption:
+:byte Encryption:
 
-		Indicates whether the stream is encrypted.
+	Indicates whether the stream is encrypted.
 
-	:array{byte} BCode
+:array{byte} BCode
 
-		Indicates Broadcast_Code to decrypt stream.
+	Indicates Broadcast_Code to decrypt stream.
diff --git a/doc/org.bluez.MediaControl.rst b/doc/org.bluez.MediaControl.rst
index 54e84e8c62eb..3b7796df345c 100644
--- a/doc/org.bluez.MediaControl.rst
+++ b/doc/org.bluez.MediaControl.rst
@@ -16,7 +16,7 @@ Interface
 
 :Service:	org.bluez
 :Interface:	org.bluez.MediaControl1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
 
 Methods
 -------
@@ -24,49 +24,49 @@ Methods
 void Play() [Deprecated]
 ````````````````````````
 
-	Resume playback.
+Resume playback.
 
 void Pause() [Deprecated]
 `````````````````````````
 
-	Pause playback.
+Pause playback.
 
 void Stop() [Deprecated]
 ````````````````````````
 
-	Stop playback.
+Stop playback.
 
 void Next() [Deprecated]
 ````````````````````````
 
-	Next item.
+Next item.
 
 void Previous() [Deprecated]
 ````````````````````````````
 
-	Previous item.
+Previous item.
 
 void VolumeUp() [Deprecated]
 ````````````````````````````
 
-	Adjust remote volume one step up
+Adjust remote volume one step up
 
 void VolumeDown() [Deprecated]
 ``````````````````````````````
 
-	Adjust remote volume one step down
+Adjust remote volume one step down
 
 void FastForward() [Deprecated]
 ```````````````````````````````
 
-	Fast forward playback, this action is only stopped when another method
-	in this interface is called.
+Fast forward playback, this action is only stopped when another method in this
+interface is called.
 
 void Rewind() [Deprecated]
 ``````````````````````````
 
-	Rewind playback, this action is only stopped when another method in
-	this interface is called.
+Rewind playback, this action is only stopped when another method in this
+interface is called.
 
 Properties
 ----------
@@ -77,4 +77,4 @@ boolean Connected [readonly]
 object Player [readonly, optional]
 ``````````````````````````````````
 
-	Addressed Player object path.
+Addressed Player object path.
diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index ea555a7d312b..474cc1160a17 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -18,8 +18,7 @@ Interface
 		org.bluez (Client role)
 :Interface:	org.bluez.MediaEndpoint1
 :Object path:	freely definable (Server role)
-		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/sepX
-		(Client role)
+		[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/sep# (Client role)
 
 Methods
 -------
@@ -29,121 +28,120 @@ Methods
 void SetConfiguration(object transport, dict properties)
 ````````````````````````````````````````````````````````
 
-	Set configuration for the transport.
+Set configuration for the transport.
 
-	:object transport:
 
-		Configured transport object.
+:object transport:
 
-	:dict properties:
+	Configured transport object.
 
-		Configured **org.bluez.MediaTransport(5)** properties.
+:dict properties:
 
-	For client role transport must be set with a server endpoint
-	object which will be configured and the properties must
-	contain the following properties:
+	Configured **org.bluez.MediaTransport(5)** properties.
 
-	:array{byte} Capabilities [Mandatory]:
+For client role transport must be set with a server endpoint object which will
+be configured and the properties must contain the following properties:
 
-		See Capabilities property.
+:array{byte} Capabilities [Mandatory]:
 
-	:array{byte} Metadata [ISO only]:
+	See Capabilities property.
 
-		See Metadata property.
+:array{byte} Metadata [ISO only]:
 
-	:dict QoS [ISO only]:
+	See Metadata property.
 
-		See **org.bluez.MediaTransport(5)** QoS property.
+:dict QoS [ISO only]:
+
+	See **org.bluez.MediaTransport(5)** QoS property.
 
 array{byte} SelectConfiguration(array{byte} capabilities)
 `````````````````````````````````````````````````````````
 
-	Select preferable configuration from the supported capabilities.
+Select preferable configuration from the supported capabilities.
 
-	Returns a configuration which can be used to setup a transport, see
-	**org.bluez.MediaTransport(5)** for possible values.
+Returns a configuration which can be used to setup a transport, see
+**org.bluez.MediaTransport(5)** for possible values.
 
-	Note: There is no need to cache the selected configuration since on
-	success the configuration is send back as parameter of SetConfiguration.
+Note: There is no need to cache the selected configuration since on success the
+configuration is send back as parameter of SetConfiguration.
 
 dict SelectProperties(dict capabilities)
 ````````````````````````````````````````
 
-	Select BAP unicast configuration from the supported capabilities:
+Select BAP unicast configuration from the supported capabilities:
 
-	:object Endpoint:
+:object Endpoint:
 
-	:array{byte} Capabilities:
+:array{byte} Capabilities:
 
-	:array{byte} Metadata:
+:array{byte} Metadata:
 
-	:uint32 Locations:
+:uint32 Locations:
 
-	:uint32_t ChannelAllocation:
+:uint32_t ChannelAllocation:
 
-	:dict QoS:
+:dict QoS:
 
-		:byte Framing:
-		:byte PHY:
-		:uint16 MaximumLatency:
-		:uint32 MinimumDelay:
-		:uint32 MaximumDelay:
-		:uint32 PreferredMinimumDelay:
-		:uint32 PreferredMaximumDelay:
+	:byte Framing:
+	:byte PHY:
+	:uint16 MaximumLatency:
+	:uint32 MinimumDelay:
+	:uint32 MaximumDelay:
+	:uint32 PreferredMinimumDelay:
+	:uint32 PreferredMaximumDelay:
 
-	See `MediaEndpoint Properties`_ for their possible values.
+See `MediaEndpoint Properties`_ for their possible values.
 
-	Returns a configuration which can be used to setup a transport:
+Returns a configuration which can be used to setup a transport:
 
-	:array{byte} Capabilities:
-	:array{byte} Metadata [optional]:
-	:dict QoS:
+:array{byte} Capabilities:
+:array{byte} Metadata [optional]:
+:dict QoS:
 
-	See `SetConfiguration`_ for their possible values.
+See `SetConfiguration`_ for their possible values.
 
-	Note: There is no need to cache the selected properties since on
-	success the configuration is send back as parameter of SetConfiguration.
+Note: There is no need to cache the selected properties since on success the
+configuration is send back as parameter of SetConfiguration.
 
 void ClearConfiguration(object transport)
 `````````````````````````````````````````
 
-	Clear transport configuration.
+Clear transport configuration.
 
-	**Server role:** [ISO only]
+**Server role:** [ISO only]
 
-	Close the stream associated with the given transport. If the
-	path given is the path of this endpoint, all its streams are
-	closed.
+Close the stream associated with the given transport. If the path given is the
+path of this endpoint, all its streams are closed.
 
 void Reconfigure(dict properties)
 `````````````````````````````````
 
-	[ISO only]
+[ISO only]
 
-	Reconfigure a BAP unicast endpoint. This closes all existing
-	streams of the endpoint, and restarts the configuration
-	selection flow which e.g. triggers calls to *SelectProperties*
-	allowing the sound server to modify the configuration.
+Reconfigure a BAP unicast endpoint. This closes all existing streams of the
+endpoint, and restarts the configuration selection flow which e.g. triggers
+calls to *SelectProperties* allowing the sound server to modify the
+configuration.
 
-	The following arguments are taken in *properties*:
+The following arguments are taken in *properties*:
 
-	:boolean Defer [optional]:
+:boolean Defer [optional]:
 
-		If True, mark endpoint for reconfiguration, but
-		postpone it until a non-deferred *Reconfigure()*
-		operation is made on an endpoint of the same device.
+	If True, mark endpoint for reconfiguration, but postpone it until a
+	non-deferred *Reconfigure()* operation is made on an endpoint of the
+	same device.
 
-		This is necessary to use when reconfiguring source and
-		sink streams with the intention that they be combined
-		into the same CIG, possibly forming bidirectional CIS.
+	This is necessary to use when reconfiguring source and sink streams with
+	the intention that they be combined into the same CIG, possibly forming
+	bidirectional CIS.
 
 void Release()
 ``````````````
 
-	This method gets called when the service daemon unregisters the
-	endpoint. An endpoint can use it to do cleanup tasks. There is no need
-	to unregister the endpoint, because when this method gets called it has
-	already been unregistered.
+This method gets called when **bluetoothd(8)** unregisters the endpoint.
+
+An endpoint can use it to do cleanup tasks. There is no need to unregister the
+endpoint, because when this method gets called it has already been unregistered.
 
 MediaEndpoint Properties
 ------------------------
@@ -151,118 +149,116 @@ MediaEndpoint Properties
 string UUID [readonly, optional]
 ````````````````````````````````
 
-	UUID of the profile which the endpoint is for.
+UUID of the profile which the endpoint is for.
 
 byte Codec [readonly, optional]
 ```````````````````````````````
 
-	Assigned number of codec that the endpoint implements.
-	The values should match the profile specification which is indicated by
-	the UUID.
+Assigned number of codec that the endpoint implements.
+
+The values should match the profile specification which is indicated by the
+UUID.
 
 uint32_t Vendor [readonly, Optional]
 ````````````````````````````````````
 
-	Vendor-specific Company ID, Codec ID tuple that the endpoint implements.
+Vendor-specific Company ID, Codec ID tuple that the endpoint implements.
 
-	It shall be set to appropriate value when Vendor Specific Codec (0xff)
-	is used.
+It shall be set to appropriate value when Vendor Specific Codec (0xff) is used.
 
 array{byte} Capabilities [readonly, optional]
 `````````````````````````````````````````````
 
-	Capabilities blob, it is used as it is so the size and byte order must
-	match.
+Capabilities blob, it is used as it is so the size and byte order must match.
 
 array{byte} Metadata [readonly, Optional]
 `````````````````````````````````````````
 
-	Metadata blob, it is used as it is so the size and byte order must
-	match.
+Metadata blob, it is used as it is so the size and byte order must match.
 
 object Device [readonly, optional]
 ``````````````````````````````````
 
-	Device object which the endpoint is belongs to.
+Device object which the endpoint is belongs to.
 
 bool DelayReporting [readonly, optional]
 ````````````````````````````````````````
 
-	Indicates if endpoint supports Delay Reporting.
+Indicates if endpoint supports Delay Reporting.
 
 uint32 Locations [readonly, optional, ISO only, experimental]
 `````````````````````````````````````````````````````````````
 
-	Indicates endpoint supported locations.
+Indicates endpoint supported locations.
 
 uint16 SupportedContext [readonly, optional, ISO only, experimental]
 ````````````````````````````````````````````````````````````````````
 
-	Indicates endpoint supported audio context.
+Indicates endpoint supported audio context.
 
 uint16 Context [readonly, optional, ISO only, experimental]
 ```````````````````````````````````````````````````````````
 
-	Indicates endpoint available audio context.
+Indicates endpoint available audio context.
 
 dict QoS [readonly, optional, ISO only, experimental]
 `````````````````````````````````````````````````````
 
-	Indicates QoS capabilities.
+Indicates QoS capabilities.
 
-	:byte Framing:
+:byte Framing:
 
-		Indicates endpoint support framing.
+	Indicates endpoint support framing.
 
 
-		Possible Values:
+	Possible Values:
 
-		:0x00:
+	:0x00:
 
-			Unframed PDUs supported.
+		Unframed PDUs supported.
 
-		:0x01:
+	:0x01:
 
-			Unframed PDUs not supported.
+		Unframed PDUs not supported.
 
-	:byte PHY:
+:byte PHY:
 
-		Indicates endpoint preferred PHY.
+	Indicates endpoint preferred PHY.
 
-		Possible values:
+	Possible values:
 
-		:bit 0:
+	:bit 0:
 
-			LE 1M preferred.
+		LE 1M preferred.
 
-		:bit 1:
+	:bit 1:
 
-			LE 2M preferred.
+		LE 2M preferred.
 
-		:bit 2:
+	:bit 2:
 
-			LE Coded preferred.
+		LE Coded preferred.
 
-	:byte Retransmissions:
+:byte Retransmissions:
 
-		Indicates endpoint preferred number of retransmissions.
+	Indicates endpoint preferred number of retransmissions.
 
-	:uint16 MaximumLatency:
+:uint16 MaximumLatency:
 
-		Indicates endpoint maximum latency.
+	Indicates endpoint maximum latency.
 
-	:uint32 MinimumDelay:
+:uint32 MinimumDelay:
 
-		Indicates endpoint minimum presentation delay.
+	Indicates endpoint minimum presentation delay.
 
-	:uint32 MaximumDelay:
+:uint32 MaximumDelay:
 
-		Indicates endpoint maximum presentation delay.
+	Indicates endpoint maximum presentation delay.
 
-	:uint32 PreferredMinimumDelay:
+:uint32 PreferredMinimumDelay:
 
-		Indicates endpoint preferred minimum presentation delay.
+	Indicates endpoint preferred minimum presentation delay.
 
-	:uint32 PreferredMaximumDelay:
+:uint32 PreferredMaximumDelay:
 
-		Indicates endpoint preferred maximum presentation delay.
+	Indicates endpoint preferred maximum presentation delay.
diff --git a/doc/org.bluez.MediaFolder.rst b/doc/org.bluez.MediaFolder.rst
index dd56f06b41e4..d868c5ebb380 100644
--- a/doc/org.bluez.MediaFolder.rst
+++ b/doc/org.bluez.MediaFolder.rst
@@ -18,8 +18,7 @@ Interface
 		org.bluez (Controller role)
 :Interface:	org.bluez.MediaFolder1
 :Object path:	freely definable (Target role)
-		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
-		(Controller role)
+		[variable prefix]/{hci0,hci1,...}/dev_{BDRADDR}/player# (Controller role)
 
 Methods
 -------
@@ -27,41 +26,41 @@ Methods
 object Search(string value, dict filter)
 ````````````````````````````````````````
 
-	Return a folder object containing the search result.
+Return a folder object containing the search result.
 
-	To list the items found use the folder object returned and pass to
-	ChangeFolder.
+To list the items found use the folder object returned and pass to
+**ChangeFolder**.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 array{objects, properties} ListItems(dict filter)
 `````````````````````````````````````````````````
 
-	Return a list of items found
+Return a list of items found
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void ChangeFolder(object folder)
 ````````````````````````````````
 
-	Change current folder.
+Change current folder.
 
-	Note: By changing folder the items of previous folder might be destroyed
-	and have to be listed again, the exception is NowPlaying folder which
-	should be always present while the player is active.
+Note: By changing folder the items of previous folder might be destroyed and
+have to be listed again, the exception is NowPlaying folder which should be
+always present while the player is active.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 Properties
 ----------
@@ -69,26 +68,26 @@ Properties
 uint32 NumberOfItems [readonly]
 ```````````````````````````````
 
-	Number of items in the folder
+Number of items in the folder
 
 string Name [readonly]
 ``````````````````````
 
-	Folder name:
+Folder name:
 
-	Possible values:
+Possible values:
 
-	:"/Filesystem/...":
+:"/Filesystem/...":
 
-		Filesystem scope
+	Filesystem scope
 
-	:"/NowPlaying/...":
+:"/NowPlaying/...":
 
-		NowPlaying scope
+	NowPlaying scope
 
-	Note: /NowPlaying folder might not be listed if player is stopped,
-	folders created by Search are virtual so once another Search is perform
-	or the folder is changed using ChangeFolder it will no longer be listed.
+Note: /NowPlaying folder might not be listed if player is stopped, folders
+created by Search are virtual so once another Search is perform or the folder is
+changed using ChangeFolder it will no longer be listed.
 
 Filters
 -------
diff --git a/doc/org.bluez.MediaItem.rst b/doc/org.bluez.MediaItem.rst
index 855e8a6395b7..6e7e9adf7145 100644
--- a/doc/org.bluez.MediaItem.rst
+++ b/doc/org.bluez.MediaItem.rst
@@ -19,8 +19,7 @@ Interface
 :Interface:	org.bluez.MediaItem1
 :Object path:	freely definable (Target role)
 		[variable
-		prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX/itemX
-		(Controller role)
+		prefix]/{hci0,hci1,...}/dev_{BDRADDR}/player#/item# (Controller role)
 
 Methods
 -------
@@ -28,22 +27,22 @@ Methods
 void Play()
 ```````````
 
-	Play item
+Play item
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void AddtoNowPlaying()
 ``````````````````````
 
-	Add item to now playing list
+Add item to now playing list
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 Properties
 ----------
@@ -51,81 +50,90 @@ Properties
 object Player [readonly]
 ````````````````````````
 
-	Player object path the item belongs to
+Player object path the item belongs to
 
 string Name [readonly]
 ``````````````````````
 
-	Item displayable name
+Item displayable name
 
 string Type [readonly]
 ``````````````````````
 
-	Item type
+Item type
 
-	Possible values: "video", "audio", "folder"
+Possible values:
+
+:"video":
+:"audio":
+:"folder":
 
 string FolderType [readonly, optional]
 ``````````````````````````````````````
 
-	Folder type.
+Folder type.
 
-	Possible values: "mixed", "titles", "albums", "artists"
+Available if property Type is "Folder"
 
-	Available if property Type is "Folder"
+Possible values:
+
+:"mixed":
+:"titles":
+:"albums":
+:"artists":
 
 boolean Playable [readonly, optional]
 `````````````````````````````````````
 
-	Indicates if the item can be played
+Indicates if the item can be played
 
-	Available if property Type is "folder"
+Available if property Type is "folder"
 
 dict Metadata [readonly]
 ````````````````````````
 
-	Item metadata.
+Item metadata.
 
-	Possible values:
+Possible values:
 
-	:string Title:
+:string Title:
 
-		Item title name
+	Item title name
 
-		Available if property Type is "audio" or "video"
+	Available if property Type is "audio" or "video"
 
-	:string Artist:
+:string Artist:
 
-		Item artist name
+	Item artist name
 
-		Available if property Type is "audio" or "video"
+	Available if property Type is "audio" or "video"
 
-	:string Album:
+:string Album:
 
-		Item album name
+	Item album name
 
-		Available if property Type is "audio" or "video"
+	Available if property Type is "audio" or "video"
 
-	:string Genre:
+:string Genre:
 
-		Item genre name
+	Item genre name
 
-		Available if property Type is "audio" or "video"
+	Available if property Type is "audio" or "video"
 
-	:uint32 NumberOfTracks:
+:uint32 NumberOfTracks:
 
-		Item album number of tracks in total
+	Item album number of tracks in total
 
-		Available if property Type is "audio" or "video"
+	Available if property Type is "audio" or "video"
 
-	:uint32 Number:
+:uint32 Number:
 
-		Item album number
+	Item album number
 
-		Available if property Type is "audio" or "video"
+	Available if property Type is "audio" or "video"
 
-	:uint32 Duration:
+:uint32 Duration:
 
-		Item duration in milliseconds
+	Item duration in milliseconds
 
-		Available if property Type is "audio" or "video"
+	Available if property Type is "audio" or "video"
diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rst
index 94f5b8472b24..14768cf433ac 100644
--- a/doc/org.bluez.MediaPlayer.rst
+++ b/doc/org.bluez.MediaPlayer.rst
@@ -16,7 +16,7 @@ Interface
 
 :Service:	org.bluez (Controller role)
 :Interface:	org.bluez.MediaPlayer1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/player#
 
 Methods
 -------
@@ -24,111 +24,114 @@ Methods
 void Play()
 ```````````
 
-	Resume playback.
+Resume playback.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void Pause()
 ````````````
 
-	Pause playback.
+Pause playback.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void Stop()
 ```````````
 
-	Stop playback.
+Stop playback.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void Next()
 ```````````
 
-	Next item.
+Next item.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void Previous()
 ```````````````
 
-	Previous item.
+Previous item.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void FastForward()
 ``````````````````
 
-	Fast forward playback, this action is only stopped when another method
-	in this interface is called.
+Fast forward playback, this action is only stopped when another method in this
+interface is called.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void Rewind()
 `````````````
 
-	Rewind playback, this action is only stopped when another method in
-	this interface is called.
+Rewind playback, this action is only stopped when another method in this
+interface is called.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void Press(byte avc_key)
 ````````````````````````
 
-	Press a specific key to send as passthrough command. The key will be
-	released automatically. Use Hold() instead if the intention is to hold
-	down the key.
+Press a specific key to send as passthrough command.
 
-	Possible Errors:
+The key will be released automatically. Use Hold() instead if the intention is
+to hold down the key.
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+Possible Errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void Hold(byte avc_key)
 ```````````````````````
 
-	Press and hold a specific key to send as passthrough command. It is
-	your responsibility to make sure that Release() is called after calling
-	this method. The held key will also be released when any other method
-	in this interface is called.
+Press and hold a specific key to send as passthrough command. It is the
+responsibility of the caller to make sure that Release() is called after calling
+this method.
 
-	Possible Errors:
+The held key will also be released when any other method in this interface is
+called.
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+Possible Errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 void Release()
 ``````````````
 
-	Release the previously held key invoked using Hold().
+Release the previously held key invoked using Hold().
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.Failed:
 
 Properties
 ----------
@@ -136,191 +139,190 @@ Properties
 string Equalizer [readwrite]
 ````````````````````````````
 
-	Indicates Player Equalizer setting.
+Indicates Player Equalizer setting.
 
-	Possible values:
+Possible values:
 
-	:"off":
-	:"on":
+:"off":
+:"on":
 
 string Repeat [readwrite]
 `````````````````````````
 
-	Indicates Player Repeat setting.
+Indicates Player Repeat setting.
 
-	Possible values:
+Possible values:
 
-	:"off":
-	:"singletrack":
-	:"alltracks":
-	:"group":
+:"off":
+:"singletrack":
+:"alltracks":
+:"group":
 
 string Shuffle [readwrite]
 ``````````````````````````
 
-	Indicates Player Suffle setting.
+Indicates Player Suffle setting.
 
-	Possible values:
+Possible values:
 
-	:"off":
-	:"alltracks":
-	:"group":
+:"off":
+:"alltracks":
+:"group":
 
 string Scan [readwrite]
 ```````````````````````
 
-	Indicates Player Scan setting.
+Indicates Player Scan setting.
 
-	Possible values:
+Possible values:
 
-	:"off":
-	:"alltracks":
-	:"group":
+:"off":
+:"alltracks":
+:"group":
 
 string Status [readonly]
 ````````````````````````
 
-	Indicates Player Status setting.
+Indicates Player Status setting.
 
-	Possible status:
+Possible status:
 
-	:"playing":
-	:"stopped":
-	:"paused":
-	:"forward-seek":
-	:"reverse-seek":
-	:"error":
+:"playing":
+:"stopped":
+:"paused":
+:"forward-seek":
+:"reverse-seek":
+:"error":
 
 uint32 Position [readonly]
 ``````````````````````````
 
-	Playback position in milliseconds. Changing the position may generate
-	additional events that will be sent to the remote device. When position
-	is 0 it means the track is starting and when it's greater than or equal
-	to track's duration the track has ended.
+Playback position in milliseconds.
 
-	Note that even if duration is not available in metadata it's possible
-	to signal its end by setting position to the maximum uint32 value.
+Changing the position may generate additional events that will be sent to the
+remote device. When position is 0 it means the track is starting and when it's
+greater than or equal to track's duration the track has ended.
+
+Note that even if duration is not available in metadata it's possible to signal
+its end by setting position to the maximum uint32 value.
 
 dict Track [readonly]
 `````````````````````
 
-	Track metadata.
+Track metadata.
 
-	Possible values:
+Possible values:
 
-	:string Title:
+:string Title:
 
-		Track title name
+	Track title name
 
-	:string Artist:
+:string Artist:
 
-		Track artist name
+	Track artist name
 
-	:string Album:
+:string Album:
 
-		Track album name
+	Track album name
 
-	:string Genre:
+:string Genre:
 
-		Track genre name
+	Track genre name
 
-	:uint32 NumberOfTracks:
+:uint32 NumberOfTracks:
 
-		Number of tracks in total
+	Number of tracks in total
 
-	:uint32 TrackNumber:
+:uint32 TrackNumber:
 
-		Track number
+	Track number
 
-	:uint32 Duration:
+:uint32 Duration:
 
-		Track duration in milliseconds
+	Track duration in milliseconds
 
-	:string ImgHandle: [experimental]
+:string ImgHandle: [experimental]
 
-		Track image handle, available and valid only during the lifetime of an
-		OBEX BIP connection to the ObexPort.
+	Track image handle, available and valid only during the lifetime of an
+	OBEX BIP connection to the ObexPort.
 
 object Device [readonly]
 ````````````````````````
 
-	Device object path.
+Device object path.
 
 string Name [readonly]
 ``````````````````````
 
-	Player name
+Player name.
 
 string Type [readonly]
 ``````````````````````
 
-	Player type
+Player type.
 
-	Possible values:
+Possible values:
 
-		"Audio"
-		"Video"
-		"Audio Broadcasting"
-		"Video Broadcasting"
+:"Audio":
+:"Video":
+:"Audio Broadcasting":
+:"Video Broadcasting":
 
 string Subtype [readonly]
 `````````````````````````
 
-	Player subtype
+Player subtype.
 
-	Possible values:
+Possible values:
 
-		"Audio Book"
-		"Podcast"
+:"Audio Book":
+:"Podcast":
 
 boolean Browsable [readonly]
 ````````````````````````````
 
-	If present indicates the player can be browsed using MediaFolder
-	interface.
+If present indicates the player can be browsed using MediaFolder interface.
 
-	Possible values:
+Possible values:
 
-	:True:
+:True:
 
-		Supported and active
+	Supported and active
 
-	:False:
+:False:
 
-		Supported but inactive
+	Supported but inactive
 
-	Note: If supported but inactive clients can enable it by using
-	MediaFolder interface but it might interfere in the playback of other
-	players.
+Note: If supported but inactive clients can enable it by using
+**org.bluez.MediaFolder(5)** interface but it might interfere in the playback of
+other players.
 
 boolean Searchable [readonly]
 `````````````````````````````
 
-	If present indicates the player can be searched using MediaFolder
-	interface.
+If present indicates the player can be searched using MediaFolder interface.
 
-	Possible values:
+Possible values:
 
-	:True:
+:True:
 
-		Supported and active
+	Supported and active
 
-	:False:
+:False:
 
-		Supported but inactive
+	Supported but inactive
 
-	Note: If supported but inactive clients can enable it by using
-	MediaFolder interface but it might interfere in the playback of other
-	players.
+Note: If supported but inactive clients can enable it by using
+**org.bluez.MediaFolder(5)** interface but it might interfere in the playback of
+other players.
 
 object Playlist
 ```````````````
 
-	Playlist object path.
+Playlist object path.
 
 uint16 ObexPort [readonly, experimental]
 ````````````````````````````````````````
 
-	If present indicates the player can get cover art using BIP over OBEX
-	on this PSM port.
+If present indicates the player can get cover art using BIP over OBEX on this
+PSM port.
diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index a4894a413652..2f9e5e1b1185 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -16,7 +16,7 @@ Interface
 
 :Service:	org.bluez
 :Interface:	org.bluez.MediaTransport1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/fdX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/fd#
 
 Methods
 -------
@@ -24,59 +24,65 @@ Methods
 fd, uint16, uint16 Acquire()
 ````````````````````````````
 
-	Acquire transport file descriptor and the MTU for read and write
-	respectively.
+Acquire transport file descriptor and the MTU for read and write respectively.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotAuthorized:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.NotAuthorized:
+:org.bluez.Error.Failed:
 
 fd, uint16, uint16 TryAcquire()
 ```````````````````````````````
 
-	Acquire transport file descriptor only if the transport is in "pending"
-	state at the time the message is received by BlueZ. Otherwise no request
-	will be sent to the remote device and the function will just fail with
-	org.bluez.Error.NotAvailable.
+Acquire transport file descriptor only if the transport is in "pending" state at
+the time the message is received by BlueZ. Otherwise no request will be sent to
+the remote device and the function will just fail with
+**org.bluez.Error.NotAvailable**.
 
-	Possible Errors:
+Possible Errors:
 
-	:org.bluez.Error.NotAuthorized:
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.NotAvailable:
+:org.bluez.Error.NotAuthorized:
+:org.bluez.Error.Failed:
+:org.bluez.Error.NotAvailable:
 
 void Release()
 ``````````````
 
-	Releases file descriptor.
+Releases file descriptor.
 
 void Select()
 `````````````
 
-	Applicable only for transports created by a broadcast sink. This moves
-	the transport from 'idle' to 'broadcasting'. This allows the user to
-	select which BISes he wishes to sync to via a 2 step process:
-	1) the user calls the method, changing the transport's state to broadcasting
-	2) the audio server detects that the transport is in the 'broadcasting'
-	state and automatically acquires it
+Applicable only for transports created by a broadcast sink. This moves the
+transport from "idle" to "broadcasting".
 
-	Possible Errors:
+This allows callers to select which BISes he wishes to sync to via a 2 step
+process:
 
-	:org.bluez.Error.NotAuthorized:
+1. the user calls the method, changing the transport's state to broadcasting
+
+2. the audio server detects that the transport is in the 'broadcasting' state
+   and automatically acquires it
+
+Possible Errors:
+
+:org.bluez.Error.NotAuthorized:
 
 void Unselect()
 ```````````````
 
-	Applicable only for transports created by a broadcast sink. This moves
-	the transport from 'broadcasting' or 'active' to 'idle'. This allows the
-	user to terminate the sync to a BIS to via a 2 step process:
-	1) the user calls this method, changing the transport's state to idle
-	2) the audio server detects this event and releases the transport
+Applicable only for transports created by a broadcast sink. This moves the
+transport from "broadcasting" or "active" to "idle".
 
-	Possible Errors:
+This allows callers to terminate the sync to a BIS to via a 2 step process:
 
-	:org.bluez.Error.NotAuthorized:
+1. the user calls this method, changing the transport's state to idle
+
+2. the audio server detects this event and releases the transport
+
+Possible Errors:
+
+:org.bluez.Error.NotAuthorized:
 
 Properties
 ----------
@@ -84,245 +90,249 @@ Properties
 object Device [readonly]
 ````````````````````````
 
-	Device object which the transport is connected to.
+Device object which the transport is connected to.
 
 string UUID [readonly]
 ``````````````````````
 
-	UUID of the profile which the transport is for.
+UUID of the profile which the transport is for.
 
 byte Codec [readonly]
 `````````````````````
 
-	Assigned number of codec that the transport support.
-	The values should match the profile specification which is indicated by
-	the UUID.
+Assigned number of codec that the transport support.
+
+The values should match the profile specification which is indicated by the
+UUID.
 
 array{byte} Configuration [readonly]
 ````````````````````````````````````
 
-	Configuration blob, it is used as it is so the size and byte order must
-	match.
+Configuration blob, it is used as it is so the size and byte order must match.
 
 string State [readonly]
 ```````````````````````
 
-	Indicates the state of the transport. Possible values are:
+Indicates the state of the transport. Possible values are:
 
-	:"idle": not streaming
-	:"pending": streaming but not acquired
-	:"broadcasting": streaming but not acquired, applicable only for transports
-		created by a broadcast sink
-	:"active": streaming and acquired
+:"idle": not streaming
+:"pending": streaming but not acquired
+:"broadcasting":
+	streaming but not acquired, applicable only for transports created by a
+	broadcast sink
+:"active": streaming and acquired
 
 uint16 Delay [readwrite, optional]
 ``````````````````````````````````
 
-	Transport delay in 1/10 of millisecond, this property is only writeable
-	when the transport corresponds to a sink endpoint and it was acquired by
-	the sender.
+Transport delay in 1/10 of millisecond, this property is only writeable when the
+transport corresponds to a sink endpoint and it was acquired by the sender.
 
 uint16 Volume [readwrite, optional]
 ```````````````````````````````````
 
-	Indicates volume level of the transport, this property is only writeable
-	when the transport was acquired by the sender.
+Indicates volume level of the transport, this property is only writeable
+when the transport was acquired by the sender.
 
-	Possible Values: 0-127 (A2DP)
-			 0-255 (BAP)
+Possible Values:
+
+:0-127 (A2DP):
+:0-255 (BAP):
 
 object Endpoint [readonly, optional, experimental]
 ``````````````````````````````````````````````````
 
-	Endpoint object which the transport is associated with.
+Endpoint object which the transport is associated with.
 
 uint32 Location [readonly, ISO only, experimental]
 ``````````````````````````````````````````````````
 
-	Indicates transport Audio Location.
+Indicates transport Audio Location.
 
 array{byte} Metadata [readwrite, ISO Only, experimental]
 ````````````````````````````````````````````````````````
 
-	Indicates transport Metadata.
+Indicates transport Metadata.
 
 array{object} Links [readonly, optional, CIS only, experimental]
 ````````````````````````````````````````````````````````````````
 
-	Linked transport objects which the transport is associated with.
+Linked transport objects which the transport is associated with.
 
 array{object} Links [readwrite, BIS only, experimental]
 ```````````````````````````````````````````````````````
 
-	For a Broadcast Sink, the BIG sync procedure requires all
-	desired streams to be enumerated from the start and it cannot
-	be later reconfigured by adding or removing BISes. To avoid
-	terminating and recreating the BIG sync everytime a new
-	transport is selected for acquire, all transports selected via
-	Transport.Select need to be linked together. When the first
-	transport is acquired via Transport.Acquire, all links are
-	included in the BIG sync command. An acquired transport will
-	create and set fds for all its links. Then, each link needs
-	to be acquired separately, to get the fd and start receiving
-	audio.
+For a Broadcast Sink, the BIG sync procedure requires all desired streams to be
+enumerated from the start and it cannot be later reconfigured by adding or
+removing BISes.
+
+To avoid terminating and recreating the BIG sync everytime a new transport is
+selected for acquire, all transports selected via **Select** need to be linked
+together.
+
+When the first transport is acquired via Transport.Acquire, all links are
+included in the BIG sync command.
+
+An acquired transport will create and set fds for all its links. Then, each link
+needs to be acquired separately, to get the fd and start receiving audio.
 
 dict QoS [readwrite, optional, ISO only, experimental]
 ``````````````````````````````````````````````````````
 
-	Only present when QoS is configured.
+Only present when QoS is configured.
 
-	Possible values for Unicast:
+Possible values for Unicast:
 
-	:byte CIG:
+:byte CIG:
 
-		Indicates configured CIG.
+	Indicates configured CIG.
 
-		Possible values:
+	Possible values:
 
-		:0x00 - 0xef:
+	:0x00 - 0xef:
 
-			Valid ID range.
+		Valid ID range.
 
-		:0xff:
+	:0xff:
 
-			Auto allocate.
+		Auto allocate.
 
-	:byte CIS:
+:byte CIS:
 
-		Indicates configured CIS.
+	Indicates configured CIS.
 
-		Possible values:
+	Possible values:
 
-		:0x00 - 0xef:
+	:0x00 - 0xef:
 
-			Valid ID range.
+	Valid ID range.
 
-		:0xff:
+	:0xff:
 
-			Auto allocate.
+		Auto allocate.
 
-	:byte Framing:
+:byte Framing:
 
-		Indicates configured framing.
+	Indicates configured framing.
 
-		Possible values:
+	Possible values:
 
-		:0x00:
+	:0x00:
 
-			Unframed.
+		Unframed.
 
-		:0x01:
+	:0x01:
 
-			Framed.
+		Framed.
 
-	:uint32 PresentationDelay:
+:uint32 PresentationDelay:
 
-		Indicates configured transport presentation delay (us).
+	Indicates configured transport presentation delay (us).
 
-	:byte TargetLatency:
+:byte TargetLatency:
 
-		Indicates the requested target latency.
+	Indicates the requested target latency.
 
-		Possible values:
+	Possible values:
 
-		:0x01:
+	:0x01:
 
-			Low Latency.
+		Low Latency.
 
-		:0x02:
+	:0x02:
 
-			Balanced Latency/Reliability.
+		Balanced Latency/Reliability.
 
-		:0x03:
+	:0x03:
 
-			High Reliability.
+		High Reliability.
 
-	Possible values for Broadcast:
+Possible values for Broadcast:
 
-	:byte BIG:
+:byte BIG:
 
-		Indicates configured QoS BIG.
+	Indicates configured QoS BIG.
 
-	:byte BIS:
+:byte BIS:
 
-		Indicates configured BIS.
+	Indicates configured BIS.
 
-	:byte SyncFactor:
+:byte SyncFactor:
 
-		Indicates configured broadcast sync factor.
+	Indicates configured broadcast sync factor.
 
-	:byte Packing:
+:byte Packing:
 
-		Indicates configured packing.
+	Indicates configured packing.
 
-	:byte Framing:
+:byte Framing:
 
-		Indicates configured framing.
+	Indicates configured framing.
 
-	:array{byte} BCode:
+:array{byte} BCode:
 
-		Indicates the string used for encryption/decryption.
+	Indicates the string used for encryption/decryption.
 
-	:byte encryption:
+:byte encryption:
 
-		Indicates if the stream is encrypted.
+	Indicates if the stream is encrypted.
 
-	:byte Options:
+:byte Options:
 
-		Indicates configured broadcast options.
+	Indicates configured broadcast options.
 
-	:uint16 Skip:
+:uint16 Skip:
 
-		Indicates configured broadcast skip.
+	Indicates configured broadcast skip.
 
-	:byte SyncTimeout:
+:byte SyncTimeout:
 
-		Indicates configured broadcast sync timeout.
+	Indicates configured broadcast sync timeout.
 
-	:byte SyncType:
+:byte SyncType:
 
-		Indicates configured broadcast sync CTE type.
+	Indicates configured broadcast sync CTE type.
 
-	:byte MSE:
+:byte MSE:
 
-		Indicates configured broadcast MSE.
+	Indicates configured broadcast MSE.
 
-	:uint16 Timeout:
+:uint16 Timeout:
 
-		Indicates configured broadcast timeout.
+	Indicates configured broadcast timeout.
 
-	Possible values for both Unicast and Broadcast:
+Possible values for both Unicast and Broadcast:
 
-	:uint32 Interval:
+:uint32 Interval:
 
-		Indicates configured ISO interval (us).
+	Indicates configured ISO interval (us).
 
-	:uint16 Latency:
+:uint16 Latency:
 
-		Indicates configured transport latency (ms).
+	Indicates configured transport latency (ms).
 
-	:uint16 SDU:
+:uint16 SDU:
 
-		Indicates configured maximum SDU.
+	Indicates configured maximum SDU.
 
-	:byte PHY:
+:byte PHY:
 
-		Indicates configured PHY.
+	Indicates configured PHY.
 
-		Possible values:
+	Possible values:
 
-		:bit 0:
+	:bit 0:
 
-			LE 1M
+		LE 1M
 
-		:bit 1:
+	:bit 1:
 
-			LE 2M
+		LE 2M
 
-		:bit 2:
+	:bit 2:
 
-			LE Coded
+		LE Coded
 
-	:byte Retransmissions:
+:byte Retransmissions:
 
-		Indicates configured retransmissions.
+	Indicates configured retransmissions.
diff --git a/doc/org.bluez.Network.rst b/doc/org.bluez.Network.rst
index d81a69d3c8af..bc775f5dd48f 100644
--- a/doc/org.bluez.Network.rst
+++ b/doc/org.bluez.Network.rst
@@ -16,7 +16,7 @@ Interface
 
 :Service:	org.bluez
 :Interface:	org.bluez.Network1
-:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
 
 Methods
 -------
@@ -24,45 +24,44 @@ Methods
 string Connect(string uuid)
 ```````````````````````````
 
-	Connects to the network device and return the network interface name.
+Connects to the network device and return the network interface name.
 
-	Possible uuid values:
+Possible uuid values:
 
-	:"panu", "00001115-0000-1000-8000-00805f9b34fb":
+:"panu", "00001115-0000-1000-8000-00805f9b34fb":
 
-		Personal Network User role.
+	Personal Network User role.
 
-	:"nap", "00001116-0000-1000-8000-00805f9b34fb":
+:"nap", "00001116-0000-1000-8000-00805f9b34fb":
 
-		Network Access Point role.
+	Network Access Point role.
 
-	:"gn", "00001117-0000-1000-8000-00805f9b34fb":
+:"gn", "00001117-0000-1000-8000-00805f9b34fb":
 
-		Group Network role.
+	Group Network role.
 
-	The connection will be closed and network device released either upon
-	calling **Disconnect()** or when the client disappears from the
-	message bus.
+The connection will be closed and network device released either upon calling
+**Disconnect()** or when the client disappears from the message bus.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.NotSupported:
-	:org.bluez.Error.InProgress:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotSupported:
+:org.bluez.Error.InProgress:
+:org.bluez.Error.Failed:
 
 void Disconnect()
 `````````````````
 
-	Disconnects from the network device.
+Disconnects from the network device.
 
-	To abort a connection attempt in case of errors or timeouts in the
-	client it is fine to call this method.
+To abort a connection attempt in case of errors or timeouts in the client it is
+fine to call this method.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Failed:
-	:org.bluez.Error.NotConnected:
+:org.bluez.Error.Failed:
+:org.bluez.Error.NotConnected:
 
 Properties
 ----------
@@ -70,14 +69,14 @@ Properties
 boolean Connected [readonly]
 ````````````````````````````
 
-	Indicates if the device is connected.
+Indicates if the device is connected.
 
 string Interface [readonly, optional]
 `````````````````````````````````````
 
-	Indicates the network interface name when available.
+Indicates the network interface name when available.
 
 string UUID [readonly, optional]
 ````````````````````````````````
 
-	Indicates the connection role when available.
+Indicates the connection role when available.
diff --git a/doc/org.bluez.NetworkServer.rst b/doc/org.bluez.NetworkServer.rst
index d15d223c5eca..ce5e61940979 100644
--- a/doc/org.bluez.NetworkServer.rst
+++ b/doc/org.bluez.NetworkServer.rst
@@ -25,44 +25,43 @@ Methods
 void Register(string uuid, string bridge)
 `````````````````````````````````````````
 
-	Registers server for the provided UUID.
+Registers server for the provided UUID.
 
-	Every new connection to this server will be added the bridge interface.
+Every new connection to this server will be added the bridge interface.
 
-	Possible uuid values:
+Possible uuid values:
 
-	:"panu", "00001115-0000-1000-8000-00805f9b34fb":
+:"panu", "00001115-0000-1000-8000-00805f9b34fb":
 
-		Personal Network User role.
+	Personal Network User role.
 
-	:"nap", "00001116-0000-1000-8000-00805f9b34fb":
+:"nap", "00001116-0000-1000-8000-00805f9b34fb":
 
-		Network Access Point role.
+	Network Access Point role.
 
-	:"gn", "00001117-0000-1000-8000-00805f9b34fb":
+:"gn", "00001117-0000-1000-8000-00805f9b34fb":
 
-		Group Network role.
+	Group Network role.
 
-	Initially no network server SDP is provided. Only after this method a
-	SDP record will be available and the BNEP server will be ready for
-	incoming connections.
+Initially no network server SDP is provided. Only after this method a SDP record
+will be available and the BNEP server will be ready for incoming connections.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.AlreadyExists:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.AlreadyExists:
+:org.bluez.Error.Failed:
 
 void Unregister(string uuid)
 ````````````````````````````
 
-	Unregisters the server for provided UUID which was previously
-	registered with **Register()** method.
+Unregisters the server for provided UUID which was previously registered with
+**Register()** method.
 
-	All servers will be automatically unregistered when the calling
-	application terminates.
+All servers will be automatically unregistered when the calling application
+terminates.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.Failed:
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.Failed:
diff --git a/doc/org.bluez.Profile.rst b/doc/org.bluez.Profile.rst
index d8ae669c7323..2968e17cead5 100644
--- a/doc/org.bluez.Profile.rst
+++ b/doc/org.bluez.Profile.rst
@@ -24,28 +24,28 @@ Methods
 void Release() [noreply]
 ````````````````````````
 
-	This method gets called when the service daemon unregisters the profile.
-	A profile can use it to do cleanup tasks. There is no need to unregister
-	the profile, because when this method gets called it has already been
-	unregistered.
+This method gets called when **bluetoothd(8)** unregisters the profile.
+
+A profile can use it to do cleanup tasks. There is no need to unregister the
+profile, because when this method gets called it has already been unregistered.
 
 void NewConnection(object device, fd, dict fd_properties)
 `````````````````````````````````````````````````````````
 
-	This method gets called when a new service level connection has been
-	made and authorized.
+This method gets called when a new service level connection has been made and
+authorized.
 
-	Possible fd_properties values:
+Possible fd_properties values:
 
-	:uint16 Version [optional]:
+:uint16 Version [optional]:
 
-		Profile version.
+	Profile version.
 
-	:uint16 Features [optional]:
+:uint16 Features [optional]:
 
-		Profile features.
+	Profile features.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.Rejected:
-	:org.bluez.Error.Canceled:
+:org.bluez.Error.Rejected:
+:org.bluez.Error.Canceled:
diff --git a/doc/org.bluez.ProfileManager.rst b/doc/org.bluez.ProfileManager.rst
index ccd7a2673d77..bde179f69e69 100644
--- a/doc/org.bluez.ProfileManager.rst
+++ b/doc/org.bluez.ProfileManager.rst
@@ -24,118 +24,119 @@ Methods
 void RegisterProfile(object profile, string uuid, dict options)
 ```````````````````````````````````````````````````````````````
 
-	Registers profile agent.
+Registers profile agent.
 
-	The object path defines the path of the profile that will be called
-	when there is a connection and must implement **org.bluez.Profile(5)**
-	interface.
+The object path defines the path of the profile that will be called when there
+is a connection and must implement **org.bluez.Profile(5)** interface.
 
-	If an application disconnects from the bus all its registered profiles
-	will be removed.
+If an application disconnects from the bus all its registered profiles will be
+removed.
 
-	Possible uuid values:
+Possible uuid values:
 
-	:"0000111f-0000-1000-8000-00805f9b34fb":
+:"0000111f-0000-1000-8000-00805f9b34fb":
 
-		HFP AG, default profile Version is 1.7, profile Features is
-		0b001001 and RFCOMM channel is 13. Authentication is required.
+	HFP AG, default profile Version is 1.7, profile Features is 0b001001 and
+	RFCOMM channel is 13. Authentication is required.
 
-	:"0000111e-0000-1000-8000-00805f9b34fb":
+:"0000111e-0000-1000-8000-00805f9b34fb":
 
-		HFP HS, default profile Version is 1.7, profile Features is
-		0b000000 and RFCOMM channel is 7. Authentication is required.
+	HFP HS, default profile Version is 1.7, profile Features is 0b000000 and
+	RFCOMM channel is 7. Authentication is required.
 
-	:"00001112-0000-1000-8000-00805f9b34fb":
+:"00001112-0000-1000-8000-00805f9b34fb":
 
-		HSP AG, default profile Version is 1.2, RFCOMM channel is 12 and
-		Authentication is required. Does not support any Features,
-		option is ignored.
+	HSP AG, default profile Version is 1.2, RFCOMM channel is 12 and
+	Authentication is required. Does not support any Features, option is
+	ignored.
 
-	:"00001108-0000-1000-8000-00805f9b34fb":
+:"00001108-0000-1000-8000-00805f9b34fb":
 
-		HSP HS, default profile Version is 1.2, profile Features is 0b0
-		and RFCOMM channel is 6. Authentication is required.
-		Features is one bit value, specify capability of Remote Audio
-		Volume Control (by default turned off).
+	HSP HS, default profile Version is 1.2, profile Features is 0b0 and
+	RFCOMM channel is 6. Authentication is required.
 
-	:"<vendor UUID>":
+	Features is one bit value, specify capability of Remote Audio Volume
+	Control (by default turned off).
 
-		Vendor defined UUID, no defaults, must set options.
+:"<vendor UUID>":
 
-	Possible options values:
+	Vendor defined UUID, no defaults, must set options.
 
-	:string Name:
+Possible options values:
 
-		Human readable name for the profile
+:string Name:
 
-	:string Service:
+	Human readable name for the profile
 
-		The primary service class UUID (if different from the actual
-		profile UUID).
+:string Service:
 
-	:string Role:
+	The primary service class UUID (if different from the actual profile
+	UUID).
 
-		For asymmetric profiles that do not have UUIDs available to
-		uniquely identify each side this parameter allows specifying the
-		precise local role.
+:string Role:
 
-		Possible values:
+	For asymmetric profiles that do not have UUIDs available to uniquely
+	identify each side this parameter allows specifying the precise local
+	role.
 
-		:"client":
-		:"server":
+	Possible values:
 
-	:uint16 Channel:
+	:"client":
+	:"server":
 
-		RFCOMM channel number that is used for client and server UUIDs.
+:uint16 Channel:
 
-		If applicable it will be used in the SDP record as well.
+	RFCOMM channel number that is used for client and server UUIDs.
 
-	:uint16 PSM:
+	If applicable it will be used in the SDP record as well.
 
-		PSM number that is used for client and server UUIDs.
+:uint16 PSM:
 
-		If applicable it will be used in the SDP record as well.
+	PSM number that is used for client and server UUIDs.
 
-	:boolean RequireAuthentication:
+	If applicable it will be used in the SDP record as well.
 
-		Pairing is required before connections will be established.
-		No devices will be connected if not paired.
+:boolean RequireAuthentication:
 
-	:boolean RequireAuthorization:
+	Pairing is required before connections will be established.
 
-		Request authorization before any connection will be established.
+	No devices will be connected if not paired.
 
-	:boolean AutoConnect:
+:boolean RequireAuthorization:
 
-		In case of a client UUID this will force connection of the
-		RFCOMM or L2CAP channels when a remote device is connected.
+	Request authorization before any connection will be established.
 
-	:string ServiceRecord:
+:boolean AutoConnect:
 
-		Provide a manual SDP record.
+	In case of a client UUID this will force connection of the RFCOMM or
+	L2CAP channels when a remote device is connected.
 
-	:uint16 Version:
+:string ServiceRecord:
 
-		Profile version (for SDP record)
+	Provide a manual SDP record.
 
-	:uint16 Features:
+:uint16 Version:
 
-		Profile features (for SDP record)
+	Profile version (for SDP record)
 
-	Possible errors:
+:uint16 Features:
 
-	:org.bluez.Error.InvalidArguments:
-	:org.bluez.Error.AlreadyExists:
+	Profile features (for SDP record)
+
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.AlreadyExists:
 
 void UnregisterProfile(object profile)
 ``````````````````````````````````````
 
-	Unregisters profile object that has been previously registered using
-	**RegisterProfile**.
+Unregisters profile object that has been previously registered using
+**RegisterProfile**.
 
-	The object path parameter must match the same value that has been used
-	on registration.
+The object path parameter must match the same value that has been used on
+registration.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.Error.DoesNotExist:
+:org.bluez.Error.DoesNotExist:
diff --git a/doc/org.bluez.obex.Agent.rst b/doc/org.bluez.obex.Agent.rst
index 74e0145707cc..f4367e9d5b81 100644
--- a/doc/org.bluez.obex.Agent.rst
+++ b/doc/org.bluez.obex.Agent.rst
@@ -24,31 +24,30 @@ Methods
 void Release()
 ``````````````
 
-	This method gets called when **obexd(8)** daemon unregisters the agent.
-	An agent can use it to do cleanup tasks. There is no need to unregister
-	the agent, because when this method gets called it has already been
-	unregistered.
+This method gets called when **obexd(8)** daemon unregisters the agent.
+
+An agent can use it to do cleanup tasks. There is no need to unregister the
+agent, because when this method gets called it has already been unregistered.
 
 string AuthorizePush(object transfer)
 `````````````````````````````````````
 
-	This method gets called when the **obexd(8)** needs to accept/reject a
-	Bluetooth object push request.
+This method gets called when the **obexd(8)** needs to accept/reject a Bluetooth
+object push request.
 
-	Returns the full path (including the filename) or the folder name
-	suffixed with '/' where the object shall be stored.
+Returns the full path (including the filename) or the folder name suffixed with
+'/' where the object shall be stored.
 
-	The transfer object, see **org.bluez.obex.Transfer(5)** will contain a
-	Filename property that contains the default location and name that can
-	be returned.
+The transfer object, see **org.bluez.obex.Transfer(5)** will contain a Filename
+property that contains the default location and name that can be returned.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.Rejected:
-	:org.bluez.obex.Error.Canceled:
+:org.bluez.obex.Error.Rejected:
+:org.bluez.obex.Error.Canceled:
 
 void Cancel()
 `````````````
 
-	This method gets called to indicate that the agent request failed before
-	a reply was returned. It cancels the previous request.
+This method gets called to indicate that the agent request failed before a reply
+was returned. It cancels the previous request.
diff --git a/doc/org.bluez.obex.AgentManager.rst b/doc/org.bluez.obex.AgentManager.rst
index cdacd4d2fc7f..d32309d2b73d 100644
--- a/doc/org.bluez.obex.AgentManager.rst
+++ b/doc/org.bluez.obex.AgentManager.rst
@@ -24,22 +24,24 @@ Methods
 void RegisterAgent(object agent)
 ````````````````````````````````
 
-	Registers an agent, which must implement **org.bluez.obex.Agent(5)**, to
-	request authorization of the user to accept/reject objects.
+Registers an agent, which must implement **org.bluez.obex.Agent(5)**, to request
+authorization of the user to accept/reject objects.
 
-	Object push service needs to authorize each received object.
+Object push service needs to authorize each received object.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.AlreadyExists:
+:org.bluez.obex.Error.AlreadyExists:
 
 void UnregisterAgent(object agent)
 ``````````````````````````````````
 
-	Unregisters the agent that has been previously registered using
-	**RegisterAgent()**. The object path parameter must match the same value
-	that has been used on registration.
+Unregisters the agent that has been previously registered using
+**RegisterAgent()**.
 
-	Possible errors:
+The object path parameter must match the same value that has been used on
+registration.
 
-	:org.bluez.obex.Error.DoesNotExist:
+Possible errors:
+
+:org.bluez.obex.Error.DoesNotExist:
diff --git a/doc/org.bluez.obex.Client.rst b/doc/org.bluez.obex.Client.rst
index f20dd5baa335..c4e03f9e9707 100644
--- a/doc/org.bluez.obex.Client.rst
+++ b/doc/org.bluez.obex.Client.rst
@@ -24,51 +24,50 @@ Methods
 object CreateSession(string destination, dict args)
 ```````````````````````````````````````````````````
 
-	Connects to the destination address and then proceed to create an OBEX
-	session object which implements **org.bluez.obex.Session(5)** interface.
+Connects to the destination address and then proceed to create an OBEX session
+object which implements **org.bluez.obex.Session(5)** interface.
 
-	The last parameter is a dictionary to hold optional or type-specific
-	parameters.
+The last parameter is a dictionary to hold optional or type-specific parameters.
 
-	Possible args values:
+Possible args values:
 
-	:string Target:
+:string Target:
 
-		Type of session to be created.
+	Type of session to be created.
 
-		Possible values:
+	Possible values:
 
-		:"ftp":
-		:"map":
-		:"opp":
-		:"pbap":
-		:"sync":
-		:"bip-avrcp":
+	:"ftp":
+	:"map":
+	:"opp":
+	:"pbap":
+	:"sync":
+	:"bip-avrcp":
 
-	:string Source:
+:string Source:
 
-		Local address to be used.
+	Local address to be used.
 
-	:byte Channel:
+:byte Channel:
 
-		Channel to be used.
+	Channel to be used.
 
-	:uint16 PSM:
+:uint16 PSM:
 
-		L2CAP PSM to be used.
+	L2CAP PSM to be used.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 void RemoveSession(object session)
 ``````````````````````````````````
 
-	Disconnects and removes session previously created by
-	**CreateSession()** aborting any pending transfers.
+Disconnects and removes session previously created by **CreateSession()**
+aborting any pending transfers.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.NotAuthorized:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.NotAuthorized:
diff --git a/doc/org.bluez.obex.FileTransfer.rst b/doc/org.bluez.obex.FileTransfer.rst
index b0a2f8495308..c4b02f43f8b2 100644
--- a/doc/org.bluez.obex.FileTransfer.rst
+++ b/doc/org.bluez.obex.FileTransfer.rst
@@ -24,132 +24,129 @@ Methods
 void ChangeFolder(string folder)
 ````````````````````````````````
 
-	Changes the current folder of the remote device.
+Changes the current folder of the remote device.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 void CreateFolder(string folder)
 ````````````````````````````````
 
-	Creates a new folder in the remote device.
+Creates a new folder in the remote device.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 array{dict} ListFolder()
 ````````````````````````
 
-	Returns a dictionary containing information about the current folder
-	content.
+Returns a dictionary containing information about the current folder content.
 
-	Possible return values:
+Possible return values:
 
-	:string Name:
+:string Name:
 
-		Object name in UTF-8 format.
+	Object name in UTF-8 format.
 
-	:string Type:
+:string Type:
 
-		Either "folder" or "file".
+	Either "folder" or "file".
 
-	:uint64 Size:
+:uint64 Size:
 
-		Object size or number of items in folder.
+	Object size or number of items in folder.
 
-	:string Permission:
+:string Permission:
 
-		Group, owner and other permission.
+	Group, owner and other permission.
 
-	:uint64 Modified:
+:uint64 Modified:
 
-		Last change.
+	Last change.
 
-	:uint64 Accessed:
+:uint64 Accessed:
 
-		Last access.
+	Last access.
 
-	:uint64 Created:
+:uint64 Created:
 
-		Creation date.
+	Creation date.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.Failed:
 
 object, dict GetFile(string targetfile, string sourcefile)
 ``````````````````````````````````````````````````````````
 
-	Copies the contents of the source file (from remote device) to the
-	target file (on local filesystem).
+Copies the contents of the source file (from remote device) to the target file
+(on local filesystem).
 
-	If an empty target file is given, a name will be automatically generated
-	for the temporary file.
+If an empty target file is given, a name will be automatically generated for the
+temporary file.
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or
-	if the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 object, dict PutFile(string sourcefile, string targetfile)
 ``````````````````````````````````````````````````````````
 
-	Copies the contents of the source file (from local filesystem) to the
-	target file (on remote device).
+Copies the contents of the source file (from local filesystem) to the target
+file (on remote device).
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or if
-	the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 void CopyFile(string sourcefile, string targetfile)
 ```````````````````````````````````````````````````
 
-	Copies the contents from source file to target file on the remote
-	device.
+Copies the contents from source file to target file on the remote device.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 void MoveFile(string sourcefile, string targetfile)
 ```````````````````````````````````````````````````
 
-	Moves a file within the remote device from source file to the target
-	file.
+Moves a file within the remote device from source file to the target file.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 void Delete(string file)
 ````````````````````````
 
-	Deletes the specified file/folder.
+Deletes the specified file/folder.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.Image.rst b/doc/org.bluez.obex.Image.rst
index c40d3f481b46..16f3ee5ad7d1 100644
--- a/doc/org.bluez.obex.Image.rst
+++ b/doc/org.bluez.obex.Image.rst
@@ -24,14 +24,13 @@ Methods
 object, dict Get(string targetfile, string handle, dict description)
 ````````````````````````````````````````````````````````````````````
 
-	Retrieves the image corresponding to the handle and the description, as
-	one of the descriptions retrieved by GetImageProperties, and store it in
-	a local file.
+Retrieves the image corresponding to the handle and the description, as one of
+the descriptions retrieved by GetImageProperties, and store it in a local file.
 
-	If the "transform" property description exists it should be set to one
-	of the value listed by GetImageProperties for this description.
+If the "transform" property description exists it should be set to one of the
+value listed by GetImageProperties for this description.
 
-	If description is an empty dict, the native image will be retrieved.
+If description is an empty dict, the native image will be retrieved.
 
 	Possible errors:
 
@@ -41,78 +40,77 @@ object, dict Get(string targetfile, string handle, dict description)
 array{dict} Properties(string handle)
 `````````````````````````````````````
 
-	Retrieves the image properties corresponding to the handle.
+Retrieves the image properties corresponding to the handle.
 
-	The first dict entry is mandatory and correspond to 'handle' and 'name'
-	of the image.
+The first dict entry is mandatory and correspond to 'handle' and 'name' of the
+image.
 
-	The second dict entry is mandatory and correspond to the native
-	description ('type':'native') of the image.
+The second dict entry is mandatory and correspond to the native description
+('type':'native') of the image.
 
-	The following dict entries are optional and correspond to variant
-	descriptions of the image. If the 'transform' entry exists in the
-	description, it lists the available possible image transformations and
-	should be set to one of them before using the description as parameter
-	to GetImage.
+The following dict entries are optional and correspond to variant descriptions
+of the image. If the 'transform' entry exists in the description, it lists the
+available possible image transformations and should be set to one of them before
+using the description as parameter to **GetImage**.
 
-	Possible property values:
+Possible property values:
 
-	:string type:
+:string type:
 
-		Type of dict properties. Mandatory for each dict.
+	Type of dict properties. Mandatory for each dict.
 
-		Possible values:
+	Possible values:
 
-		:"native":
-		:"variant":
+	:"native":
+	:"variant":
 
-	:string encoding:
+:string encoding:
 
-		File encoding format.
+	File encoding format.
 
-		Possible values:
+	Possible values:
 
-		:"BMP":
-		:"GIF":
-		:"JPEG":
-		:"JPEG2000":
-		:"PNG":
-		:"WBMP":
+	:"BMP":
+	:"GIF":
+	:"JPEG":
+	:"JPEG2000":
+	:"PNG":
+	:"WBMP":
 
-	:string pixel:
+:string pixel:
 
-		File encoding format size of form "<width>*<height>".
+	File encoding format size of form "<width>*<height>".
 
-	:uint64 size:
+:uint64 size:
 
-		File size.
+	File size.
 
-	:uint64 maxsize:
+:uint64 maxsize:
 
-		File maximum size.
+	File maximum size.
 
-	:string transformation:
+:string transformation:
 
-		List of available transformations separated by space.
+	List of available transformations separated by space.
 
-		Possible values:
+	Possible values:
 
-		:"crop":
-		:"fill":
-		:"stretch":
+	:"crop":
+	:"fill":
+	:"stretch":
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 object, dict GetThumbnail(string targetfile, string handle)
 ```````````````````````````````````````````````````````````
 
-	Retrieves the image thumbnail corresponding to the handle and store it
-	in a local file.
+Retrieves the image thumbnail corresponding to the handle and store it in a
+local file.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.Message.rst b/doc/org.bluez.obex.Message.rst
index 9878dffe755e..d16ed061db74 100644
--- a/doc/org.bluez.obex.Message.rst
+++ b/doc/org.bluez.obex.Message.rst
@@ -24,23 +24,23 @@ Methods
 object, dict Get(string targetfile, boolean attachment)
 ```````````````````````````````````````````````````````
 
-	Download message and store it in the target file.
+Download message and store it in the target file.
 
-	If an empty target file is given, a temporary file will be automatically
-	generated.
+If an empty target file is given, a temporary file will be automatically
+generated.
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or if
-	the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 Properties
 ----------
@@ -48,131 +48,131 @@ Properties
 string Folder [readonly]
 ````````````````````````
 
-	Folder which the message belongs to
+Folder which the message belongs to
 
 string Subject [readonly]
 `````````````````````````
 
-	Message subject
+Message subject
 
 string Timestamp [readonly]
 ```````````````````````````
 
-	Message timestamp
+Message timestamp
 
 string Sender [readonly]
 ````````````````````````
 
-	Message sender name
+Message sender name
 
 string SenderAddress [readonly]
 ```````````````````````````````
 
-	Message sender address
+Message sender address
 
 string ReplyTo [readonly]
 `````````````````````````
 
-	Message Reply-To address
+Message Reply-To address
 
 string Recipient [readonly]
 ```````````````````````````
 
-	Message recipient name
+Message recipient name
 
 string RecipientAddress [readonly]
 ``````````````````````````````````
 
-	Message recipient address
+Message recipient address
 
 string Type [readonly]
 ``````````````````````
 
-	Message type
+Message type
 
-	Possible values:
+Possible values:
 
-	:"email":
-	:"sms-gsm":
-	:"sms-cdma":
-	:"mms":
+:"email":
+:"sms-gsm":
+:"sms-cdma":
+:"mms":
 
 uint64 Size [readonly]
 ``````````````````````
 
-	Message size in bytes
+Message size in bytes
 
 string Status [readonly]
 ````````````````````````
 
-	Message reception status
+Message reception status
 
-	Possible values:
+Possible values:
 
-	:"complete":
-	:"fractioned":
-	:"notification":
+:"complete":
+:"fractioned":
+:"notification":
 
 boolean Priority [readonly]
 ```````````````````````````
 
-	Message priority flag
+Message priority flag
 
 boolean Read [read/write]
 `````````````````````````
 
-	Message read flag
+Message read flag
 
 boolean Deleted [writeonly]
 ```````````````````````````
 
-	Message deleted flag
+Message deleted flag
 
 boolean Sent [readonly]
 ```````````````````````
 
-	Message sent flag
+Message sent flag
 
 boolean Protected [readonly]
 ````````````````````````````
 
-	Message protected flag
+Message protected flag
 
 string DeliveryStatus [readonly] [optional]
 ```````````````````````````````````````````
 
-	Message delivery status
+Message delivery status
 
-	Possible values:
+Possible values:
 
-	:"delivered":
-	:"sent":
-	:"unknown":
+:"delivered":
+:"sent":
+:"unknown":
 
 uint64 ConversationId [readonly] [required]
 ```````````````````````````````````````````
 
-	Message conversation id sent by Server
-	Unique identification of the conversation
+Message conversation id sent by Server which servers as Unique identification of
+the conversation.
 
 string ConversationName [readonly] [optional]
 `````````````````````````````````````````````
 
-	Human readable name of the conversation
+Human readable name of the conversation
 
 string Direction [readonly] [required]
 ``````````````````````````````````````
 
-	Indicate the direction of the message
+Indicate the direction of the message
 
-	Possible values:
+Possible values:
 
-	:"incoming":
-	:"outgoing":
-	:"outgoingdraft":
-	:"outgoingpending":
+:"incoming":
+:"outgoing":
+:"outgoingdraft":
+:"outgoingpending":
 
 string AttachmentMimeTypes [readonly] [optional]
 ````````````````````````````````````````````````
 
-	MIME type of the attachment
+MIME type of the attachment
diff --git a/doc/org.bluez.obex.MessageAccess.rst b/doc/org.bluez.obex.MessageAccess.rst
index 6962520a2809..7d784fc62a6d 100644
--- a/doc/org.bluez.obex.MessageAccess.rst
+++ b/doc/org.bluez.obex.MessageAccess.rst
@@ -24,181 +24,180 @@ Methods
 void SetFolder(string name)
 ```````````````````````````
 
-	Set working directory for current session.
+Set working directory for current session.
 
-	Possible name:
+Possible name:
 
-		Directory name or '..[/dir]'.
+	Directory name or '..[/dir]'.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 array{dict} ListFolders(dict filter)
 ````````````````````````````````````
 
-	Returns a dictionary containing information about the current folder
-	content.
+Returns a dictionary containing information about the current folder content.
 
-	Possible filter:
+Possible filter:
 
-	:uint16 Offset (default 0):
+:uint16 Offset (default 0):
 
-		Offset of the first item.
+	Offset of the first item.
 
-	:uint16 MaxCount (default 1024):
+:uint16 MaxCount (default 1024):
 
-		Maximum number of items.
+	Maximum number of items.
 
-	Possible return:
+Possible return:
 
-	:string Name:
+:string Name:
 
-		Folder name
+	Folder name
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 array{string} ListFilterFields()
 ````````````````````````````````
 
-	Return all available fields that can be used in **Fields** filter.
+Return all available fields that can be used in **Fields** filter.
 
-	Possible values:
+Possible values:
 
-	:"subject":
-	:"timestamp":
-	:"sender":
-	:"sender-address":
-	:"recipient":
-	:"recipient-address":
-	:"type":
-	:"size":
-	:"status":
-	:"text":
-	:"attachment":
-	:"priority":
-	:"read":
-	:"sent":
-	:"protected":
-	:"replyto":
+:"subject":
+:"timestamp":
+:"sender":
+:"sender-address":
+:"recipient":
+:"recipient-address":
+:"type":
+:"size":
+:"status":
+:"text":
+:"attachment":
+:"priority":
+:"read":
+:"sent":
+:"protected":
+:"replyto":
 
-	Possible errors: None
+Possible errors: None
 
 array{object, dict} ListMessages(string folder, dict filter)
 ````````````````````````````````````````````````````````````
 
-	Returns an array containing the messages objects found in the given
-	subfolder of the current folder, or in the current folder if folder is
-	empty.
+Returns an array containing the messages objects found in the given subfolder of
+the current folder, or in the current folder if folder is empty.
 
-	Possible Filters:
+Possible Filters:
 
-	:uint16 Offset (default 0):
+:uint16 Offset (default 0):
 
-		Offset of the first item.
+	Offset of the first item.
 
-	uint16 MaxCount (default 1024):
+uint16 MaxCount (default 1024):
 
-		Maximum number of items.
+	Maximum number of items.
 
-	:byte SubjectLength (default 256):
+:byte SubjectLength (default 256):
 
-		Maximum length of the Subject property in the message.
+	Maximum length of the Subject property in the message.
 
-	:array{string} Fields:
+:array{string} Fields:
 
-		Message fields, default is all values.
+	Message fields, default is all values.
 
-		See **ListFilterFields()** for possible values.
+	See **ListFilterFields()** for possible values.
 
-	:array{string} Types:
+:array{string} Types:
 
-		Filter messages by type.
+	Filter messages by type.
 
-		Possible values:
+	Possible values:
 
-		:"sms":
-		:"email":
-		:"mms":
+	:"sms":
+	:"email":
+	:"mms":
 
-	:string PeriodBegin:
+:string PeriodBegin:
 
-		Filter messages by starting period.
+	Filter messages by starting period.
 
-		Possible values:
+	Possible values:
 
-			Date in "YYYYMMDDTHHMMSS" format.
+		Date in "YYYYMMDDTHHMMSS" format.
 
-	:string PeriodEnd:
+:string PeriodEnd:
 
-		Filter messages by ending period.
+	Filter messages by ending period.
 
-		Possible values:
+	Possible values:
 
-			Date in "YYYYMMDDTHHMMSS" format.
+		Date in "YYYYMMDDTHHMMSS" format.
 
-	:boolean Read:
+:boolean Read:
 
-		Filter messages by read flag.
+	Filter messages by read flag.
 
-		Possible values:
+	Possible values:
 
-			True for read or False for unread
+		True for read or False for unread
 
-	:string Recipient:
+:string Recipient:
 
-		Filter messages by recipient address.
+	Filter messages by recipient address.
 
-	:string Sender:
+:string Sender:
 
-		Filter messages by sender address.
+	Filter messages by sender address.
 
-	:boolean Priority:
+:boolean Priority:
 
-		Filter messages by priority flag.
+	Filter messages by priority flag.
 
-		Possible values:
+	Possible values:
 
-			True for high priority or False for non-high priority.
+		True for high priority or False for non-high priority.
 
-	Each message is represented by an object path, which implements
-	**org.bluez.obex.Message(5)** interface, followed by a dictionary
-	of its properties.
+Each message is represented by an object path, which implements
+**org.bluez.obex.Message(5)** interface, followed by a dictionary of its
+properties.
 
 void UpdateInbox(void)
+``````````````````````
 
-	Requests remote to update its inbox.
+Requests remote to update its inbox.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.Failed:
 
 object, dict PushMessage(string sourcefile, string folder, dict args)
 `````````````````````````````````````````````````````````````````````
 
-	Transfers a message (in bMessage format) to the remote device.
+Transfers a message (in bMessage format) to the remote device.
 
-	The message is transferred either to the given subfolder of the current
-	folder, or to the current folder if folder is empty.
+The message is transferred either to the given subfolder of the current folder,
+or to the current folder if folder is empty.
 
-	Possible args: Transparent, Retry, Charset
+Possible args: Transparent, Retry, Charset
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or if
-	the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 Properties
 ----------
@@ -206,26 +205,26 @@ Properties
 array{string} SupportedTypes [readonly]
 ```````````````````````````````````````
 
-	List of supported message types.
+List of supported message types.
 
-	Possible values:
+Possible values:
 
-	:"EMAIL":
+:"EMAIL":
 
-		Email messages.
+	Email messages.
 
-	:"SMS_GSM":
+:"SMS_GSM":
 
-		GSM short messages.
+	GSM short messages.
 
-	:"SMS_CDMA":
+:"SMS_CDMA":
 
-		CDMA short messages.
+	CDMA short messages.
 
-	:"MMS":
+:"MMS":
 
-		MMS messages.
+	MMS messages.
 
-	:"IM":
+:"IM":
 
-		Instant messaging.
+	Instant messaging.
diff --git a/doc/org.bluez.obex.ObjectPush.rst b/doc/org.bluez.obex.ObjectPush.rst
index aba2282a8480..32e587ec8f70 100644
--- a/doc/org.bluez.obex.ObjectPush.rst
+++ b/doc/org.bluez.obex.ObjectPush.rst
@@ -24,61 +24,60 @@ Methods
 object, dict SendFile(string sourcefile)
 ````````````````````````````````````````
 
-	Sends local file to the remote device.
+Sends local file to the remote device.
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or if
-	the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 object, dict PullBusinessCard(string targetfile)
 ````````````````````````````````````````````````
 
-	Request the business card from a remote device and store it in the local
-	file.
+Request the business card from a remote device and store it in the local file.
 
-	If an empty target file is given, a name will be automatically
-	generated for the temporary file.
+If an empty target file is given, a name will be automatically generated for the
+temporary file.
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or if
-	the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 object, dict ExchangeBusinessCards(string clientfile, string targetfile)
 ````````````````````````````````````````````````````````````````````````
 
-	Push the client's business card to the remote device and then retrieve
-	the remote business card and store it in a local file.
+Push the client's business card to the remote device and then retrieve the
+remote business card and store it in a local file.
 
-	If an empty target file is given, a name will be automatically
-	generated for the temporary file.
+If an empty target file is given, a name will be automatically generated for the
+temporary file.
 
-	The returned path represents the newly created transfer, which should
-	be used to find out if the content has been successfully transferred or
-	if the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.PhonebookAccess.rst b/doc/org.bluez.obex.PhonebookAccess.rst
index 0e126b1b46c6..5b22d67f56d6 100644
--- a/doc/org.bluez.obex.PhonebookAccess.rst
+++ b/doc/org.bluez.obex.PhonebookAccess.rst
@@ -24,319 +24,321 @@ Methods
 void Select(string location, string phonebook)
 ``````````````````````````````````````````````
 
-	Selects the phonebook object for other operations. Should be call before
-	all the other operations.
+Selects the phonebook object for other operations.
 
-	Possible location values:
+Should be call before all the other operations.
 
-	:"int", "internal" (default):
+Possible location values:
 
-		Store in the Internal memory.
+:"int", "internal" (default):
 
-	:"sim{#}":
+	Store in the Internal memory.
 
-		Store in the sim number.
+:"sim{#}":
 
-	Possible phonebook values:
+	Store in the sim number.
 
-	:"pb":
+Possible phonebook values:
 
-		Store as contact.
+:"pb":
 
-	:"ich":
+	Store as contact.
 
-		Store as incoming call.
+:"ich":
 
-	:"och":
+	Store as incoming call.
 
-		Store as outgoing call.
+:"och":
 
-	:"mch":
+	Store as outgoing call.
 
-		Store as missing call.
+:"mch":
 
-	:"cch":
+	Store as missing call.
 
-		Store as a combination of incoming, outgoing and missing call.
+:"cch":
 
-	"spd":
+	Store as a combination of incoming, outgoing and missing call.
 
-		Store as speed dials entry ( only for "internal" )
+"spd":
 
-	"fav":
+	Store as speed dials entry ( only for "internal" )
 
-		Store as favorites entry ( only for "internal" )
+"fav":
 
-	Possible errors:
+	Store as favorites entry ( only for "internal" )
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+Possible errors:
+
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 object, dict PullAll(string targetfile, dict filters)
 `````````````````````````````````````````````````````
 
-	Returns the entire phonebook object from the PSE server in plain string
-	with vcard format, and store it in a local file.
+Returns the entire phonebook object from the PSE server in plain string with
+vcard format, and store it in a local file.
 
-	If an empty target file is given, a name will be automatically generated
-	for the temporary file.
+If an empty target file is given, a name will be automatically generated for the
+temporary file.
 
-	The returned path represents the newly created transfer, which should
-	be used to find out if the content has been successfully transferred or
-	if the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible filters:
+Possible filters:
 
-	:string Format:
+:string Format:
 
-		Items vcard format.
+	Items vcard format.
 
-		Possible values:
+	Possible values:
 
-		:"vcard21" (default):
-		:"vcard30":
+	:"vcard21" (default):
+	:"vcard30":
 
-	:string Order:
+:string Order:
 
-		Items order.
+	Items order.
 
-		Possible values:
+	Possible values:
 
-		:"":
-		:"indexed":
-		:"alphanumeric":
-		:"phonetic":
+	:"":
+	:"indexed":
+	:"alphanumeric":
+	:"phonetic":
 
-	:uint16 Offset (default 0):
+:uint16 Offset (default 0):
 
-		Offset of the first item.
+	Offset of the first item.
 
-	:uint16 MaxCount (default 65535):
+:uint16 MaxCount (default 65535):
 
-		Maximum number of items.
+	Maximum number of items.
 
-	:array{string} Fields (default all fields):
+:array{string} Fields (default all fields):
 
-		Item vcard fields.
+	Item vcard fields.
 
-		See **ListFilterFields()** for possible values.
+	See **ListFilterFields()** for possible values.
 
-	:array{string} FilterAll:
+:array{string} FilterAll:
 
-		Filter items by fields using AND logic, cannot be used
-		together with **FilterAny**.
+	Filter items by fields using AND logic, cannot be used together with
+	**FilterAny**.
 
-		See **ListFilterFields()** for possible values.
+	See **ListFilterFields()** for possible values.
 
-	:array{string} FilterAny:
+:array{string} FilterAny:
 
-		Filter items by fields using OR logic, cannot be used together
-		with **FilterAll**.
+	Filter items by fields using OR logic, cannot be used together with
+	**FilterAll**.
 
-		See **ListFilterFields()** for possible values.
+	See **ListFilterFields()** for possible values.
 
-	:bool ResetNewMissedCalls:
+:bool ResetNewMissedCalls:
 
-		Reset new the missed calls items, shall only be used for folders
-		mch and cch.
+	Reset new the missed calls items, shall only be used for folders mch and
+	cch.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Forbidden:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Forbidden:
 
 array{string vcard, string name} List(dict filters)
 ```````````````````````````````````````````````````
 
-	Returns array of vcard-listing data where every entry consists of a
-	pair of strings containing the vcard handle and the contact name.
-	For example:
+Returns array of vcard-listing data where every entry consists of a pair of
+strings containing the vcard handle and the contact name.
 
-	:"1.vcf": "John"
+For example:
 
-	Possible filters:
+:"1.vcf": "John"
 
-	:string Order:
+Possible filters:
 
-		Contact order.
+:string Order:
 
-		Possible values:
+	Contact order.
 
-		:"":
-		:"indexed":
-		:"alphanumeric":
-		:"phonetic":
+	Possible values:
 
-	:uint16 Offset:
+	:"":
+	:"indexed":
+	:"alphanumeric":
+	:"phonetic":
 
-		Start offset.
+:uint16 Offset:
 
-	:uint16 MaxCount:
+	Start offset.
 
-		Maximum number of contacts.
+:uint16 MaxCount:
 
-	Possible errors:
+	Maximum number of contacts.
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Forbidden:
+Possible errors:
+
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Forbidden:
 
 object, dict Pull(string vcard, string targetfile, dict filters)
 ````````````````````````````````````````````````````````````````
 
-	Retrieves the vcard in the current phonebook object and store it in a
-	local file.
+Retrieves the vcard in the current phonebook object and store it in a local
+file.
 
-	If an empty target file is given, a name will be automatically generated
-	for the temporary file.
+If an empty target file is given, a name will be automatically generated for the
+temporary file.
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or if
-	the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible filters:
+Possible filters:
 
-	:string Format:
+:string Format:
 
-		Contact data format.
+	Contact data format.
 
-		Possible values:
+	Possible values:
 
-		:"":
-		:"vcard21":
-		:"vcard30":
+	:"":
+	:"vcard21":
+	:"vcard30":
 
-	:array{string} Fields:
+:array{string} Fields:
 
-		See **ListFilterFields()** for possible values.
+	See **ListFilterFields()** for possible values.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Forbidden:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Forbidden:
+:org.bluez.obex.Error.Failed:
 
 array{string vcard, string name} Search(string field, string value, dict filters)
 `````````````````````````````````````````````````````````````````````````````````
 
-	Searches for entries matching the given condition and return an array of
-	vcard-listing data where every entry consists of a pair of strings
-	containing the vcard handle and the contact name.
+Searches for entries matching the given condition and return an array of
+vcard-listing data where every entry consists of a pair of strings containing
+the vcard handle and the contact name.
 
-	Possible field values:
+Possible field values:
 
-		:"name" (default):
+	:"name" (default):
 
-			Search by name.
+		Search by name.
 
-		:"number":
+	:"number":
 
-			Search by number.
+		Search by number.
 
-		:"sound":
+	:"sound":
 
-			Search by sound.
+		Search by sound.
 
-	value: the string value to search for
+value: the string value to search for
 
-	Possible filters:
+Possible filters:
 
-	:string Order:
+:string Order:
 
-		Contact order.
+	Contact order.
 
-		Possible values:
+	Possible values:
 
-		:"":
-		:"indexed":
-		:"alphanumeric":
-		:"phonetic":
+	:"":
+	:"indexed":
+	:"alphanumeric":
+	:"phonetic":
 
-	:uint16 Offset:
+:uint16 Offset:
 
-		Start offset.
+	Start offset.
 
-	:uint16 MaxCount:
+:uint16 MaxCount:
 
-		Maximum number of contacts.
+	Maximum number of contacts.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Forbidden:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Forbidden:
+:org.bluez.obex.Error.Failed:
 
 uint16 GetSize()
 ````````````````
 
-	Returns the number of entries in the selected phonebook object that are
-	actually used (i.e. indexes that correspond to non-NULL entries).
+Returns the number of entries in the selected phonebook object that are actually
+used (i.e. indexes that correspond to non-NULL entries).
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.Forbidden:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.Forbidden:
+:org.bluez.obex.Error.Failed:
 
 void UpdateVersion()
 ````````````````````
 
-	Attempts to update PrimaryCounter and SecondaryCounter.
+Attempts to update PrimaryCounter and SecondaryCounter.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.NotSupported:
-	:org.bluez.obex.Error.Forbidden:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.NotSupported:
+:org.bluez.obex.Error.Forbidden:
+:org.bluez.obex.Error.Failed:
 
 array{string} ListFilterFields()
 ````````````````````````````````
 
-	Returns all Available fields that can be used in Fields filter.
+Returns all Available fields that can be used in Fields filter.
 
-	Possible return:
+Possible return:
 
-	:"VERSION":
-	:"FN":
-	:"N":
-	:"PHOTO":
-	:"BDAY":
-	:"ADR":
-	:"LABEL":
-	:"TEL":
-	:"EMAIL":
-	:"MAILER":
-	:"TZ":
-	:"GEO":
-	:"TITLE":
-	:"ROLE":
-	:"LOGO":
-	:"AGENT":
-	:"ORG":
-	:"NOTE":
-	:"REV":
-	:"SOUND":
-	:"URL":
-	:"UID":
-	:"KEY":
-	:"NICKNAME":
-	:"CATEGORIES":
-	:"PROID":
-	:"CLASS":
-	:"SORT-STRING":
-	:"X-IRMC-CALL-DATETIME":
-	:"X-BT-SPEEDDIALKEY":
-	:"X-BT-UCI":
-	:"X-BT-UID":
-	:"BIT-{#}":
+:"VERSION":
+:"FN":
+:"N":
+:"PHOTO":
+:"BDAY":
+:"ADR":
+:"LABEL":
+:"TEL":
+:"EMAIL":
+:"MAILER":
+:"TZ":
+:"GEO":
+:"TITLE":
+:"ROLE":
+:"LOGO":
+:"AGENT":
+:"ORG":
+:"NOTE":
+:"REV":
+:"SOUND":
+:"URL":
+:"UID":
+:"KEY":
+:"NICKNAME":
+:"CATEGORIES":
+:"PROID":
+:"CLASS":
+:"SORT-STRING":
+:"X-IRMC-CALL-DATETIME":
+:"X-BT-SPEEDDIALKEY":
+:"X-BT-UCI":
+:"X-BT-UID":
+:"BIT-{#}":
 
-	Possible errors: None
+Possible errors: None
 
 Properties
 ----------
@@ -344,43 +346,40 @@ Properties
 string Folder [readonly]
 ````````````````````````
 
-	Current folder.
+Current folder.
 
 string DatabaseIdentifier [readonly, optional]
 ``````````````````````````````````````````````
 
-	128 bits persistent database identifier.
+128 bits persistent database identifier.
 
-	Possible values:
+Possible values:
 
-		32-character hexadecimal such as
-		A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
+	32-character hexadecimal such as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
 
 string PrimaryCounter [readonly, optional]
 ``````````````````````````````````````````
 
-	128 bits primary version counter.
+128 bits primary version counter.
 
-	Possible values:
+Possible values:
 
-		32-character hexadecimal such as
-		A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
+	32-character hexadecimal such as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
 
 string SecondaryCounter [readonly, optional]
 ````````````````````````````````````````````
 
-	128 bits secondary version counter.
+128 bits secondary version counter.
 
-	Possible values:
+Possible values:
 
-		32-character hexadecimal such as
-		A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
+	32-character hexadecimal such as A1A2A3A4B1B2C1C2D1D2E1E2E3E4E5E6
 
 bool FixedImageSize [readonly, optional]
 ````````````````````````````````````````
 
-	Indicate support for fixed image size.
+Indicate support for fixed image size.
 
-	Possible values:
+Possible values:
 
-		True if image is JPEG 300x300 pixels otherwise False.
+	True if image is JPEG 300x300 pixels otherwise False.
diff --git a/doc/org.bluez.obex.Session.rst b/doc/org.bluez.obex.Session.rst
index fc5f14e5dccd..ee2f40ef410d 100644
--- a/doc/org.bluez.obex.Session.rst
+++ b/doc/org.bluez.obex.Session.rst
@@ -25,12 +25,12 @@ Methods
 string GetCapabilities()
 ````````````````````````
 
-	Get remote device capabilities.
+Get remote device capabilities.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.NotSupported:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.NotSupported:
+:org.bluez.obex.Error.Failed:
 
 Properties
 ----------
@@ -38,29 +38,29 @@ Properties
 string Source [readonly]
 ````````````````````````
 
-	Bluetooth adapter address
+Bluetooth adapter address
 
 string Destination [readonly]
 `````````````````````````````
 
-	Bluetooth device address
+Bluetooth device address
 
 byte Channel [readonly]
 ```````````````````````
 
-	Bluetooth channel
+Bluetooth channel
 
 uint16 PSM [readonly]
 ```````````````````````
 
-	Bluetooth L2CAP PSM
+Bluetooth L2CAP PSM
 
 string Target [readonly]
 ````````````````````````
 
-	Target UUID
+Target UUID
 
 string Root [readonly]
 ``````````````````````
 
-	Root path
+Root path
diff --git a/doc/org.bluez.obex.Synchronization.rst b/doc/org.bluez.obex.Synchronization.rst
index a41197dfb926..20360017fb4b 100644
--- a/doc/org.bluez.obex.Synchronization.rst
+++ b/doc/org.bluez.obex.Synchronization.rst
@@ -24,59 +24,59 @@ Methods
 void SetLocation(string location)
 `````````````````````````````````
 
-	Sets the phonebook object store location for other operations. Should be
-	called before all the other operations.
+Sets the phonebook object store location for other operations. Should be called
+before all the other operations.
 
-	Possible location:
+Possible location:
 
-	:"int" ( "internal" which is default ):
+:"int" ( "internal" which is default ):
 
-		Store in the interval memory.
+	Store in the interval memory.
 
-	:"sim{#}":
+:"sim{#}":
 
-		Store in sim card number #.
+	Store in sim card number #.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.InvalidArguments:
 
 object, dict GetPhonebook(string targetfile)
 ````````````````````````````````````````````
 
-	Retrieves an entire Phonebook Object store from remote device, and
-	stores it in a local file.
+Retrieves an entire Phonebook Object store from remote device, and stores it in
+a local file.
 
-	If an empty target file is given, a name will be automatically
-	calculated for the temporary file.
+If an empty target file is given, a name will be automatically calculated for
+the temporary file.
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or if
-	the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
 
 object, dict PutPhonebook(string sourcefile)
 ````````````````````````````````````````````
 
-	Sends an entire Phonebook Object store to remote device.
+Sends an entire Phonebook Object store to remote device.
 
-	The returned path represents the newly created transfer, which should be
-	used to find out if the content has been successfully transferred or if
-	the operation fails.
+The returned path represents the newly created transfer, which should be used to
+find out if the content has been successfully transferred or if the operation
+fails.
 
-	The properties of this transfer are also returned along with the object
-	path, to avoid a call to GetProperties, see
-	**org.bluez.obex.Transfer(5)** for the possible list of properties.
+The properties of this transfer are also returned along with the object path, to
+avoid a call to GetProperties, see **org.bluez.obex.Transfer(5)** for the
+possible list of properties.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.InvalidArguments:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.InvalidArguments:
+:org.bluez.obex.Error.Failed:
diff --git a/doc/org.bluez.obex.Transfer.rst b/doc/org.bluez.obex.Transfer.rst
index 733d82851f42..f053def7929b 100644
--- a/doc/org.bluez.obex.Transfer.rst
+++ b/doc/org.bluez.obex.Transfer.rst
@@ -24,38 +24,37 @@ Methods
 void Cancel()
 `````````````
 
-	Cancels the current transference.
+Cancels the current transference.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.NotAuthorized:
-	:org.bluez.obex.Error.InProgress:
-	:org.bluez.obex.Error.Failed:
+:org.bluez.obex.Error.NotAuthorized:
+:org.bluez.obex.Error.InProgress:
+:org.bluez.obex.Error.Failed:
 
 void Suspend()
 ``````````````
 
-	Suspends transference.
+Suspends transference.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.NotAuthorized:
-	:org.bluez.obex.Error.NotInProgress:
+:org.bluez.obex.Error.NotAuthorized:
+:org.bluez.obex.Error.NotInProgress:
 
-		If transfer is still in with **Status** **"queued"**.
+	If transfer is still in with **Status** **"queued"**.
 
 void Resume()
 `````````````
 
-	Resumes transference previously suspended with use of **Suspend()**
-	method.
+Resumes transference previously suspended with use of **Suspend()** method.
 
-	Possible errors:
+Possible errors:
 
-	:org.bluez.obex.Error.NotAuthorized:
-	:org.bluez.obex.Error.NotInProgress:
+:org.bluez.obex.Error.NotAuthorized:
+:org.bluez.obex.Error.NotInProgress:
 
-		If transfer is still in with **Status** **"queued"**.
+	If transfer is still in with **Status** **"queued"**.
 
 Properties
 ----------
@@ -63,9 +62,9 @@ Properties
 string Status [readonly]
 ````````````````````````
 
-	Indicates the current status of the transfer.
+Indicates the current status of the transfer.
 
-	Possible values:
+Possible values:
 
 	:"queued":
 	:"active":
@@ -76,48 +75,47 @@ string Status [readonly]
 object Session [readonly]
 `````````````````````````
 
-	The object path of the session the transfer belongs to.
+The object path of the session the transfer belongs to.
 
 string Name [readonly, optional]
 ````````````````````````````````
 
-	Name of the object being transferred.
+Name of the object being transferred.
 
-	Either Name or Type or both will be present.
+Either Name or Type or both will be present.
 
 string Type [readonly, optional]
 ````````````````````````````````
 
-	Type of the object transferred being transferred.
+Type of the object transferred being transferred.
 
-	Either Name or Type or both will be present.
+Either Name or Type or both will be present.
 
 uint64 Time [readonly, optional]
 ````````````````````````````````
 
-	Time of the object being transferred if this is provided by the remote
-	party.
+Time of the object being transferred if this is provided by the remote party.
 
 uint64 Size [readonly, optional]
 ````````````````````````````````
 
-	Size of the object being transferred.
+Size of the object being transferred.
 
-	If the size is unknown, then this property will not be present.
+If the size is unknown, then this property will not be present.
 
 uint64 Transferred [readonly, optional]
 ```````````````````````````````````````
 
-	Number of bytes transferred.
+Number of bytes transferred.
 
-	For transfers with **Status** set to **"queued"**, this value will not
-	be present.
+For transfers with **Status** set to **"queued"**, this value will not be
+present.
 
 string Filename [readonly, optional]
 ````````````````````````````````````
 
-	Complete name of the file being received or sent.
+Complete name of the file being received or sent.
 
-	For incoming object push transaction, this will be the proposed default
-	location and name. It can be overwritten by the **AuthorizePush()** in
-	**org.bluez.obex.Agent(5)** and will be then updated accordingly.
+For incoming object push transaction, this will be the proposed default location
+and name. It can be overwritten by the **AuthorizePush()** in
+**org.bluez.obex.Agent(5)** and will be then updated accordingly.
-- 
2.49.0


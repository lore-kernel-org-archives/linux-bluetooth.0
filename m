Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAA3ACEE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929649; cv=none; b=nxF3+EiKcKwpxtf4vOEUg3K9Z7KhqGc1QyJKYnZtEi38nfM46Ou0ohTKJBIMOyL4KQyLpPcSFlgqqfS3GwLeqlR4YXzv0Va6A+G1SgywI5AzZf9LDrBbt4cUXyYkkJz0PPF185JHlUgfznWANGOIQF+L78anqkKWPfGw2stqcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929649; c=relaxed/simple;
	bh=Afa2ebCVW3heV5517dBuC4GMJtBCnFZ1p6mt6FLUjpM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrlO4oWzL9dIIgRATg/+0E6nn5STjKETwXhsstcnRJmwrH5/30o0Z+jA9WmKFEmDv0RaM5sal9HIPn0MXOIRxUQ9nFKYQnauhM/64mdvxZpa56bAab1CmKM+MyAn+MoRGrheS4Jrocsl8DQkijO5IqO6XdFCo5l0UG9JEBO+VTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D25A344387
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:20:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 7/7] doc: Port health-api.txt to RST
Date: Tue, 20 Jan 2026 18:18:52 +0100
Message-ID: <20260120172034.3463151-8-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120172034.3463151-1-hadess@hadess.net>
References: <20260120172034.3463151-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepteegheeghfehhfdvkedutdfhffejjefgvdevgfekkeevleetheekhfetleelueefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepffdvheetfeeggeefkeejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: 0

---
 Makefile.am                     |  12 ++-
 doc/health-api.txt              | 152 --------------------------------
 doc/org.bluez.HealthChannel.rst |  72 +++++++++++++++
 doc/org.bluez.HealthDevice.rst  |  94 ++++++++++++++++++++
 doc/org.bluez.HealthManager.rst |  68 ++++++++++++++
 5 files changed, 244 insertions(+), 154 deletions(-)
 delete mode 100644 doc/health-api.txt
 create mode 100644 doc/org.bluez.HealthChannel.rst
 create mode 100644 doc/org.bluez.HealthDevice.rst
 create mode 100644 doc/org.bluez.HealthManager.rst

diff --git a/Makefile.am b/Makefile.am
index 8396849831f1..938b127cd052 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -403,6 +403,9 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 man_MANS += doc/org.bluez.SimAccess.5
+man_MANS += doc/org.bluez.HealthChannel.5 \
+	    doc/org.bluez.HealthDevice.5 \
+	    doc/org.bluez.HealthManager.5
 
 endif
 manual_pages += src/bluetoothd.8
@@ -445,6 +448,9 @@ manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 manual_pages += doc/org.bluez.SimAccess.5
+manual_pages += doc/org.bluez.HealthChannel.5 \
+		doc/org.bluez.HealthDevice.5 \
+		doc/org.bluez.HealthManager.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -487,8 +493,6 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/test-runner.rst \
 				doc/settings-storage.txt
 
-EXTRA_DIST += doc/health-api.txt
-
 EXTRA_DIST += doc/hci.rst doc/mgmt.rst doc/l2cap.rst doc/rfcomm.rst \
 	      doc/sco.rst doc/iso.rst
 
@@ -536,6 +540,10 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 
 EXTRA_DIST += doc/org.bluez.SimAccess.rst
 
+EXTRA_DIST += doc/org.bluez.HealthChannel.rst \
+	      doc/org.bluez.HealthDevice.rst \
+	      doc/org.bluez.HealthManager.rst
+
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
 
diff --git a/doc/health-api.txt b/doc/health-api.txt
deleted file mode 100644
index 2c48ff20449d..000000000000
--- a/doc/health-api.txt
+++ /dev/null
@@ -1,152 +0,0 @@
-BlueZ D-Bus Health API description
-**********************************
-
-
-HealthManager hierarchy
-=======================
-
-Service		org.bluez
-Interface	org.bluez.HealthManager1
-Object path	/org/bluez/
-
-Methods		object CreateApplication(dict config)
-
-			Returns the path of the new registered application.
-			Application will be closed by the call or implicitly
-			when the programs leaves the bus.
-
-			config:
-				uint16 DataType:
-
-					Mandatory
-
-				string Role:
-
-					Mandatory. Possible values: "source",
-									"sink"
-
-				string Description:
-
-					Optional
-
-				ChannelType:
-
-					Optional, just for sources. Possible
-					values: "reliable", "streaming"
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-
-		void DestroyApplication(object application)
-
-			Closes the HDP application identified by the object
-			path. Also application will be closed if the process
-			that started it leaves the bus. Only the creator of the
-			application will be able to destroy it.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotFound
-					 org.bluez.Error.NotAllowed
-
-
-HealthDevice hierarchy
-======================
-
-Service		org.bluez
-Interface	org.bluez.HealthDevice1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		boolean Echo()
-
-			Sends an echo petition to the remote service. Returns
-			True if response matches with the buffer sent. If some
-			error is detected False value is returned.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.OutOfRange
-
-		object CreateChannel(object application, string configuration)
-
-			Creates a new data channel.  The configuration should
-			indicate the channel quality of service using one of
-			this values "reliable", "streaming", "any".
-
-			Returns the object path that identifies the data
-			channel that is already connected.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.HealthError
-
-		void DestroyChannel(object channel)
-
-			Destroys the data channel object. Only the creator of
-			the channel or the creator of the HealthApplication
-			that received the data channel will be able to destroy
-			it.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotFound
-				         org.bluez.Error.NotAllowed
-
-Signals		void ChannelConnected(object channel)
-
-			This signal is launched when a new data channel is
-			created or when a known data channel is reconnected.
-
-		void ChannelDeleted(object channel)
-
-			This signal is launched when a data channel is deleted.
-
-			After this signal the data channel path will not be
-			valid and its path can be reused for future data
-			channels.
-
-Properties	object MainChannel [readonly]
-
-			The first reliable channel opened. It is needed by
-			upper applications in order to send specific protocol
-			data units. The first reliable can change after a
-			reconnection.
-
-
-HealthChannel hierarchy
-=======================
-
-Service		org.bluez
-Interface	org.bluez.HealthChannel1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/chanZZZ
-
-Only the process that created the data channel or the creator of the
-HealthApplication that received it will be able to call these methods.
-
-Methods		fd Acquire()
-
-			Returns the file descriptor for this data channel. If
-			the data channel is not connected it will also
-			reconnect.
-
-			Possible Errors: org.bluez.Error.NotConnected
-					 org.bluez.Error.NotAllowed
-
-		void Release()
-
-			Releases the fd. Application should also need to
-			close() it.
-
-			Possible Errors: org.bluez.Error.NotAcquired
-					 org.bluez.Error.NotAllowed
-
-Properties	string Type [readonly]
-
-			The quality of service of the data channel. ("reliable"
-			or "streaming")
-
-		object Device [readonly]
-
-			Identifies the Remote Device that is connected with.
-			Maps with a HealthDevice object.
-
-		object Application [readonly]
-
-			Identifies the HealthApplication to which this channel
-			is related to (which indirectly defines its role and
-			data type).
diff --git a/doc/org.bluez.HealthChannel.rst b/doc/org.bluez.HealthChannel.rst
new file mode 100644
index 000000000000..f91a1ff94dc1
--- /dev/null
+++ b/doc/org.bluez.HealthChannel.rst
@@ -0,0 +1,72 @@
+=======================
+org.bluez.HealthChannel
+=======================
+
+----------------------------------
+BlueZ D-Bus Health API description
+----------------------------------
+
+:Version: BlueZ
+:Date: July 2010
+:Author: José Antonio Santos Cadenas <santoscadenas@gmail.com>
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.HealthChannel1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/chanZZZ
+
+Only the process that created the data channel or the creator of the
+HealthApplication that received it will be able to call these methods.
+
+Methods
+-------
+
+fd Acquire()
+````````````
+
+Returns the file descriptor for this data channel. If
+the data channel is not connected it will also
+reconnect.
+
+Possible Errors:
+
+:org.bluez.Error.NotConnected:
+:org.bluez.Error.NotAllowed:
+
+void Release()
+``````````````
+
+Releases the fd. Application should also need to
+close() it.
+
+Possible Errors:
+
+:org.bluez.Error.NotAcquired:
+:org.bluez.Error.NotAllowed:
+
+Properties
+----------
+
+string Type [readonly]
+``````````````````````
+
+The quality of service of the data channel. ("reliable"
+or "streaming")
+
+object Device [readonly]
+````````````````````````
+
+Identifies the Remote Device that is connected with.
+Maps with a HealthDevice object.
+
+object Application [readonly]
+`````````````````````````````
+
+Identifies the HealthApplication to which this channel
+is related to (which indirectly defines its role and
+data type).
+
diff --git a/doc/org.bluez.HealthDevice.rst b/doc/org.bluez.HealthDevice.rst
new file mode 100644
index 000000000000..568f854b7768
--- /dev/null
+++ b/doc/org.bluez.HealthDevice.rst
@@ -0,0 +1,94 @@
+======================
+org.bluez.HealthDevice
+======================
+
+------------------------------------
+BlueZ D-Bus Health API documentation
+------------------------------------
+
+:Version: BlueZ
+:Date: July 2010
+:Author: José Antonio Santos Cadenas <santoscadenas@gmail.com>
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.HealthDevice1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods
+-------
+
+boolean Echo()
+``````````````
+
+Sends an echo petition to the remote service. Returns
+True if response matches with the buffer sent. If some
+error is detected False value is returned.
+
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.OutOfRange:
+
+object CreateChannel(object application, string configuration)
+``````````````````````````````````````````````````````````````
+
+Creates a new data channel.  The configuration should
+indicate the channel quality of service using one of
+this values "reliable", "streaming", "any".
+
+Returns the object path that identifies the data
+channel that is already connected.
+
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.HealthError:
+
+void DestroyChannel(object channel)
+```````````````````````````````````
+
+Destroys the data channel object. Only the creator of
+the channel or the creator of the HealthApplication
+that received the data channel will be able to destroy
+it.
+
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotFound:
+:org.bluez.Error.NotAllowed:
+
+Signals
+-------
+
+void ChannelConnected(object channel)
+`````````````````````````````````````
+
+This signal is launched when a new data channel is
+created or when a known data channel is reconnected.
+
+void ChannelDeleted(object channel)
+```````````````````````````````````
+
+This signal is launched when a data channel is deleted.
+
+After this signal the data channel path will not be
+valid and its path can be reused for future data
+channels.
+
+Properties
+----------
+
+object MainChannel [readonly]
+`````````````````````````````
+
+The first reliable channel opened. It is needed by
+upper applications in order to send specific protocol
+data units. The first reliable can change after a
+reconnection.
+
diff --git a/doc/org.bluez.HealthManager.rst b/doc/org.bluez.HealthManager.rst
new file mode 100644
index 000000000000..1eaaf7935eeb
--- /dev/null
+++ b/doc/org.bluez.HealthManager.rst
@@ -0,0 +1,68 @@
+=======================
+org.bluez.HealthManager
+=======================
+
+------------------------------------
+BlueZ D-Bus Health API documentation
+------------------------------------
+
+:Version: BlueZ
+:Date: July 2010
+:Author: José Antonio Santos Cadenas <santoscadenas@gmail.com>
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.HealthManager1
+:Object path:	/org/bluez/
+
+Methods
+-------
+
+object CreateApplication(dict config)
+`````````````````````````````````````
+
+Returns the path of the new registered application.
+Application will be closed by the call or implicitly
+when the programs leaves the bus.
+
+Possible config value:
+
+:uint16 DataType:
+
+        Mandatory
+
+:string Role:
+
+	Mandatory. Possible values: "source", "sink"
+
+:string Description:
+
+	Optional
+
+:ChannelType:
+
+	Optional, just for sources. Possible
+	values: "reliable", "streaming"
+
+Possible Errors:
+
+:org.bluez.Error.InvalidArguments:
+
+void DestroyApplication(object application)
+```````````````````````````````````````````
+
+Closes the HDP application identified by the object
+path. Also application will be closed if the process
+that started it leaves the bus. Only the creator of the
+application will be able to destroy it.
+
+Possible errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotFound:
+:org.bluez.Error.NotAllowed:
+
-- 
2.52.0


Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE53C00BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929649; cv=none; b=o5GO9bqNvn6Dqy5RZH/3HMzuyKvgU4QhpnQNGRMnsLN3yi2sDhvWxF3K91b8d1pIQFxuJDJrUVR4YS7Oo8C2siVO7XBTkgXcb5z88NKcN7X5ljCco288unlIKZECCVpTLyYLhBbC1xl4ZkHc1KXvjtZKmw4JHLlT0NEM9NV7OBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929649; c=relaxed/simple;
	bh=FjAUPLLTOQQVawmt+/Xkel9F7gQd3/eXCifiut+bar8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDYbFpKRolcrzPK4Pv8SOCYRUHyoRAa8MqZ/UQMEV3RjQyD/fJyGLrafT+X9cheMP5mw+yk6aEDRYhrlOtSTCIxtiDIDTuU5pQ13uiYqaa8KRUNtz1F9sfR1/TEV2lxOwM4DPgTrsA90qSrVdeC4ZymTt16DIA6K8EuqzdyKGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CFE24437E
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:20:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 2/7] doc: Port thermometer-api.txt to RST
Date: Tue, 20 Jan 2026 18:18:47 +0100
Message-ID: <20260120172034.3463151-3-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120172034.3463151-1-hadess@hadess.net>
References: <20260120172034.3463151-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedvffeiveehfedufeeuveekgeegteetudegfedutedvtdfghedutdduhfdtheevleenucffohhmrghinhepsghluhgviidrtggrlhhlnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepleevhffgvdeggeefjefgpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: 0

---
 Makefile.am                          |  10 ++
 doc/org.bluez.Thermometer.rst        |  51 ++++++++++
 doc/org.bluez.ThermometerManager.rst |  64 +++++++++++++
 doc/org.bluez.ThermometerWatcher.rst |  79 ++++++++++++++++
 doc/thermometer-api.txt              | 134 ---------------------------
 5 files changed, 204 insertions(+), 134 deletions(-)
 create mode 100644 doc/org.bluez.Thermometer.rst
 create mode 100644 doc/org.bluez.ThermometerManager.rst
 create mode 100644 doc/org.bluez.ThermometerWatcher.rst
 delete mode 100644 doc/thermometer-api.txt

diff --git a/Makefile.am b/Makefile.am
index acd28732aa2d..d80c1250a417 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -399,6 +399,9 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
 		doc/org.bluez.obex.Image.5
 man_MANS += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
+man_MANS += doc/org.bluez.ThermometerManager.5 \
+		doc/org.bluez.Thermometer.5 \
+		doc/org.bluez.ThermometerWatcher.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -436,6 +439,9 @@ manual_pages += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agent.5 \
 		doc/org.bluez.obex.Image.5
 manual_pages += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
+manual_pages += doc/org.bluez.ThermometerManager.5 \
+		doc/org.bluez.Thermometer.5 \
+		doc/org.bluez.ThermometerWatcher.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -522,6 +528,10 @@ EXTRA_DIST += doc/org.bluez.obex.Client.rst doc/org.bluez.obex.Session.rst \
 
 EXTRA_DIST += doc/org.bluez.Telephony.rst doc/org.bluez.Call.rst
 
+EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
+	      doc/org.bluez.Thermometer.rst \
+	      doc/org.bluez.ThermometerWatcher.rst
+
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
 
diff --git a/doc/org.bluez.Thermometer.rst b/doc/org.bluez.Thermometer.rst
new file mode 100644
index 000000000000..cc7e4f8d19c2
--- /dev/null
+++ b/doc/org.bluez.Thermometer.rst
@@ -0,0 +1,51 @@
+=====================
+org.bluez.Thermometer
+=====================
+
+------------------------------------------------
+BlueZ D-Bus Health Thermometer API documentation
+------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2011
+:Author: Santiago Carot-Nemesio <sancane@gmail.com>
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.Thermometer1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties
+----------
+
+boolean Intermediate [readonly]
+```````````````````````````````
+
+True if the thermometer supports intermediate
+measurement notifications.
+
+uint16 Interval (optional) [readwrite]
+``````````````````````````````````````
+
+The Measurement Interval defines the time (in
+seconds) between measurements. This interval is
+not related to the intermediate measurements and
+must be defined into a valid range. Setting it
+to zero means that no periodic measurements will
+be taken.
+
+uint16 Maximum (optional) [readonly]
+````````````````````````````````````
+
+Defines the maximum value allowed for the interval
+between periodic measurements.
+
+uint16 Minimum (optional) [readonly]
+````````````````````````````````````
+
+Defines the minimum value allowed for the interval
+between periodic measurements.
diff --git a/doc/org.bluez.ThermometerManager.rst b/doc/org.bluez.ThermometerManager.rst
new file mode 100644
index 000000000000..5e46fd54a456
--- /dev/null
+++ b/doc/org.bluez.ThermometerManager.rst
@@ -0,0 +1,64 @@
+============================
+org.bluez.ThermometerManager
+============================
+
+-------------------------------------------------------
+BlueZ D-Bus Health ThermometerManager API documentation
+-------------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2011
+:Author: Santiago Carot-Nemesio <sancane@gmail.com>
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.ThermometerManager1
+:Object path:	[variable prefix]/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterWatcher(object agent)
+``````````````````````````````````
+
+Registers a watcher to monitor scanned measurements.
+This agent will be notified about final temperature
+measurements.
+
+Possible Errors:
+
+:org.bluez.Error.InvalidArguments:
+
+
+void UnregisterWatcher(object agent)
+````````````````````````````````````
+
+Unregisters a watcher.
+
+void EnableIntermediateMeasurement(object agent)
+````````````````````````````````````````````````
+
+Enables intermediate measurement notifications
+for this agent. Intermediate measurements will
+be enabled only for thermometers which support it.
+
+Possible Errors:
+
+:org.bluez.Error.InvalidArguments:
+
+void DisableIntermediateMeasurement(object agent)
+`````````````````````````````````````````````````
+
+Disables intermediate measurement notifications
+for this agent. It will disable notifications in
+thermometers when the last agent removes the
+watcher for intermediate measurements.
+
+Possible Errors:
+
+:org.bluez.Error.InvalidArguments:
+:org.bluez.Error.NotFound:
diff --git a/doc/org.bluez.ThermometerWatcher.rst b/doc/org.bluez.ThermometerWatcher.rst
new file mode 100644
index 000000000000..2f115f66ab94
--- /dev/null
+++ b/doc/org.bluez.ThermometerWatcher.rst
@@ -0,0 +1,79 @@
+============================
+org.bluez.ThermometerWatcher
+============================
+
+--------------------------------------------------------
+BlueZ D-Bus Health Thermometer Watcher API documentation
+--------------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2011
+:Author: Santiago Carot-Nemesio <sancane@gmail.com>
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	unique name
+:Interface:	org.bluez.ThermometerWatcher1
+:Object path:	freely definable
+
+Methods
+-------
+
+void MeasurementReceived(dict measurement)
+``````````````````````````````````````````
+
+This callback gets called when a measurement has been
+scanned in the thermometer.
+
+Possible measurement values:
+
+:int16 Exponent:
+:int32 Mantissa:
+
+	Exponent and Mantissa values as extracted from float value defined by
+	IEEE-11073-20601.
+
+	Measurement value is calculated as
+	(Mantissa) * (10^Exponent)
+
+	For special cases Exponent is
+	set to 0 and Mantissa is set to
+	one of following values:
+
+.. csv-table::
+        :header: "Value", "Description"
+        :widths: auto
+
+        +(2^23 - 1), NaN (invalid or missing data)
+        -(2^23), NRes
+        +(2^23 - 2), +Infinity
+        -(2^23 - 2), -Infinity
+
+:string Unit:
+
+	Possible values: "celsius" or
+			"fahrenheit"
+
+:uint64 Time (optional):
+
+	Time of measurement, if
+	supported by device.
+	Expressed in seconds since epoch.
+
+:string Type (optional):
+
+	Only present if measurement type
+	is known.
+
+	Possible values: "armpit", "body",
+		"ear", "finger", "intestines",
+		"mouth", "rectum", "toe",
+		"tympanum"
+
+:string Measurement:
+
+	Possible values: "final" or "intermediate"
+
diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
deleted file mode 100644
index c7c8a5dadee0..000000000000
--- a/doc/thermometer-api.txt
+++ /dev/null
@@ -1,134 +0,0 @@
-BlueZ D-Bus Thermometer API description
-***************************************
-
-	Santiago Carot-Nemesio <sancane@gmail.com>
-
-Health Thermometer Manager hierarchy
-====================================
-
-Service		org.bluez
-Interface	org.bluez.ThermometerManager1
-Object path	[variable prefix]/{hci0,hci1,...}
-
-Methods		RegisterWatcher(object agent)
-
-			Registers a watcher to monitor scanned measurements.
-			This agent will be notified about final temperature
-			measurements.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-
-		UnregisterWatcher(object agent)
-
-			Unregisters a watcher.
-
-		EnableIntermediateMeasurement(object agent)
-
-			Enables intermediate measurement notifications
-			for this agent. Intermediate measurements will
-			be enabled only for thermometers which support it.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-
-		DisableIntermediateMeasurement(object agent)
-
-			Disables intermediate measurement notifications
-			for this agent. It will disable notifications in
-			thermometers when the last agent removes the
-			watcher for intermediate measurements.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					org.bluez.Error.NotFound
-
-Health Thermometer Profile hierarchy
-====================================
-
-Service		org.bluez
-Interface	org.bluez.Thermometer1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-
-Properties	boolean Intermediate [readonly]
-
-			True if the thermometer supports intermediate
-			measurement notifications.
-
-		uint16 Interval (optional) [readwrite]
-
-			The Measurement Interval defines the time (in
-			seconds) between measurements. This interval is
-			not related to the intermediate measurements and
-			must be defined into a valid range. Setting it
-			to zero means that no periodic measurements will
-			be taken.
-
-		uint16 Maximum (optional) [readonly]
-
-			Defines the maximum value allowed for the interval
-			between periodic measurements.
-
-		uint16 Minimum (optional) [readonly]
-
-			Defines the minimum value allowed for the interval
-			between periodic measurements.
-
-
-Health Thermometer Watcher hierarchy
-====================================
-
-Service		unique name
-Interface	org.bluez.ThermometerWatcher1
-Object path	freely definable
-
-Methods		void MeasurementReceived(dict measurement)
-
-			This callback gets called when a measurement has been
-			scanned in the thermometer.
-
-			Measurement:
-
-				int16 Exponent:
-				int32 Mantissa:
-
-					Exponent and Mantissa values as
-					extracted from float value defined by
-					IEEE-11073-20601.
-
-					Measurement value is calculated as
-					(Mantissa) * (10^Exponent)
-
-					For special cases Exponent is
-					set to 0 and Mantissa is set to
-					one of following values:
-
-					+(2^23 - 1)	NaN (invalid or
-							missing data)
-					-(2^23)		NRes
-					+(2^23 - 2)	+Infinity
-					-(2^23 - 2)	-Infinity
-
-				string Unit:
-
-					Possible values: "celsius" or
-							"fahrenheit"
-
-				uint64 Time (optional):
-
-					Time of measurement, if
-					supported by device.
-					Expressed in seconds since epoch.
-
-				string Type (optional):
-
-					Only present if measurement type
-					is known.
-
-					Possible values: "armpit", "body",
-						"ear", "finger", "intestines",
-						"mouth", "rectum", "toe",
-						"tympanum"
-
-				string Measurement:
-
-					Possible values: "final" or
-							"intermediate"
-- 
2.52.0


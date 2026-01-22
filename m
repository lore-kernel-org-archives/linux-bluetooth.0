Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FF349B1F
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073022; cv=none; b=e9kul707U089lT2nqmTRTqu3++lOHOpJ/3cYPU2gL1uSpPkWmGuDGhXNL2drDwGiaCQI6GEYRMs/Dr4KAZHSWN0wwHPohz2kLgBx4tBf2bWsg/Xcsc93hx4ZdHWrZbQGVbtiVwYgQuzh+N5p23HR1SYAPpBI3z6hspmDgZqyMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073022; c=relaxed/simple;
	bh=U4X6zmnc+0dFT8K8uxoFR99sa5PoDnZl4iSKfdmHTtU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3qnkbKkkuitJvFiSz0YdGpn1kKhJ90AafqxwTDkK0F/j/+O+Lq5Km2VdysjKGSktR0avSHCSAoEMJq0nJI5M24v3F+yUZJL7btvxzbbT4m3l/+p+ceLnPNd1MnxmwhvkOSivT/aQVaHV2K31y+1xQxPKt7lEXskY6zu74+t7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5313443123
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:10:13 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 4/9] doc: Port thermometer-api.txt to RST
Date: Thu, 22 Jan 2026 10:05:03 +0100
Message-ID: <20260122091003.398400-5-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122091003.398400-1-hadess@hadess.net>
References: <20260122091003.398400-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedvffeiveehfedufeeuveekgeegteetudegfedutedvtdfghedutdduhfdtheevleenucffohhmrghinhepsghluhgviidrtggrlhhlnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepheefudefgeegfeduvdefpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
index 1498535e2524..2217bcf15e4f 100644
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
 manual_pages += doc/bluetoothd.8
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
@@ -523,6 +529,10 @@ EXTRA_DIST += doc/org.bluez.obex.Client.rst doc/org.bluez.obex.Session.rst \
 
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


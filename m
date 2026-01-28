Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45E305057
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615767; cv=none; b=uTLGp7t5wskrX4xw/jgp+fZq+K4sL/edvpPTaaisNv683RrnvJZLyWK3V6CJp9GXGQyYOrNxa4D53o8z1ZVjw7juH0FbQfkzBRWmicSZvqWLhMLoERw4jwEX2IqvqRsUuE3rWhJWLak77tNazG+Yjwy3ojRJqOAJ2Uk8h0WtLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615767; c=relaxed/simple;
	bh=z78lFQH4y9CONyRAKMwA2bVs92Qbi30jYrZGvOfGmvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt1yL8Wbc6AlhZ4ZifXyIhJDlo0lIDn49mOBSwa8o643RUOMRcaP29rqTI+Clx5AR9gNuxYUTmf7k5dfxVg/jcjuUcrAkHQ5qnCfAaXxBqhR0D3Q4ZOnyCzsRcKuh8KgvrXQWdvvv1hfc6rMF61BLW4Z66qrzWitywspQ6Xw6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2034443FCA
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:55:57 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 01/20] doc: Port sap-api.txt to RST
Date: Wed, 28 Jan 2026 16:11:39 +0100
Message-ID: <20260128155548.2025252-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128155548.2025252-1-hadess@hadess.net>
References: <20260128155548.2025252-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedvffeiveehfedufeeuveekgeegteetudegfedutedvtdfghedutdduhfdtheevleenucffohhmrghinhepsghluhgviidrtggrlhhlnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepvddtfeeggeegfefhveetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean

---
 Makefile.am                 |  8 ++++++--
 doc/org.bluez.SimAccess.rst | 40 +++++++++++++++++++++++++++++++++++++
 doc/sap-api.txt             | 20 -------------------
 3 files changed, 46 insertions(+), 22 deletions(-)
 create mode 100644 doc/org.bluez.SimAccess.rst
 delete mode 100644 doc/sap-api.txt

diff --git a/Makefile.am b/Makefile.am
index 1f73a4fa0ee7..c6bb0c91d4f8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -404,6 +404,8 @@ man_MANS += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
+man_MANS += doc/org.bluez.SimAccess.5
+
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -444,6 +446,7 @@ manual_pages += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
+manual_pages += doc/org.bluez.SimAccess.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -486,8 +489,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/test-runner.rst \
 				doc/settings-storage.txt
 
-EXTRA_DIST += doc/health-api.txt \
-		doc/sap-api.txt
+EXTRA_DIST += doc/health-api.txt
 
 EXTRA_DIST += doc/hci-protocol.rst doc/mgmt-protocol.rst \
 	      doc/l2cap-protocol.rst doc/rfcomm-protocol.rst \
@@ -535,6 +537,8 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 	      doc/org.bluez.Thermometer.rst \
 	      doc/org.bluez.ThermometerWatcher.rst
 
+EXTRA_DIST += doc/org.bluez.SimAccess.rst
+
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
 
diff --git a/doc/org.bluez.SimAccess.rst b/doc/org.bluez.SimAccess.rst
new file mode 100644
index 000000000000..ac86e7eb220c
--- /dev/null
+++ b/doc/org.bluez.SimAccess.rst
@@ -0,0 +1,40 @@
+===================
+org.bluez.SimAccess
+===================
+
+----------------------------------------
+BlueZ D-Bus Sim Access API documentation
+----------------------------------------
+
+:Version: BlueZ
+:Date: February 2011
+:Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.SimAccess1
+:Object path:	[variable prefix]/{hci0,hci1,...}
+
+Methods
+-------
+
+void Disconnect()
+`````````````````
+Disconnects SAP client from the server.
+
+Possible errors:
+
+:org.bluez.Error.Failed:
+
+Properties
+----------
+
+boolean Connected [readonly]
+````````````````````````````
+
+Indicates if SAP client is connected to the server.
+
diff --git a/doc/sap-api.txt b/doc/sap-api.txt
deleted file mode 100644
index b28c4e305964..000000000000
--- a/doc/sap-api.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-BlueZ D-Bus Sim Access API description
-**************************************
-
-
-Sim Access Profile hierarchy
-============================
-
-Service		org.bluez
-Interface	org.bluez.SimAccess1
-Object path	[variable prefix]/{hci0,hci1,...}
-
-Methods		void Disconnect()
-
-			Disconnects SAP client from the server.
-
-			Possible errors: org.bluez.Error.Failed
-
-Properties	boolean Connected [readonly]
-
-			Indicates if SAP client is connected to the server.
-- 
2.52.0


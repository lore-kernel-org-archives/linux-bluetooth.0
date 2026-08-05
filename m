Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFD329C48
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939148; cv=none; b=E9HBplSTDI4RMerUsfIy98i4w6pth7gfoFi2Q3Isrt0hBlC4uIwKn0L5AkzoIKCKD3wB4CjtshhnbbxRFj7U7A1IVC61p5am9zDGDDYqrQ/ddNyD7xEDSTzkUSDmZP+Bgut2OLGrAw7bZdkTDZr14sf8Z1He2GI3ZvVucN4UW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939148; c=relaxed/simple;
	bh=rqlEmK/ig5NIcaQRrNRJFc16oVQ1FCL81ZIlEVZeVUU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DQBorD2TAR/M2Qf1H5rVNJguKEaC22ykqPbF7peHclBBYAvhueCAxdUABUBVHfl7nLkBRVurU9BPPp9YmnE7jE6jqrr7j+CbvXEkOQmVC1AMGl/aMSgMzt8P9xBIgizy+sZUSa8td9K2+IWUt5517hSAfpJaz3/zVBt9OGwd8/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id AFDD1581FB7
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 13:52:44 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C17091F6BE
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 13:52:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v1] unit: Add test for sdp_xml_parse_record()
Date: Wed,  5 Aug 2026 15:52:20 +0200
Message-ID: <20260805135228.2653665-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 49
X-GND-Cause: dmFkZTFfUkm97i/0C4MGgFMMkemgtMbOybsAB8fn+2b5b2IlSp1GH/UQwjveYdC0X499RCy5gFFhhaKkbl/q2aDdTb21yLHF2xIdYfZ5CbQYNoIAgHzWdvDVCgIpmeh1wbaTjukyb7eZFbE813XG23/TTnFEsH6aWqccIFQoISLGBucA+T8/2lUYuQ/bZK7pWXra3ueFR34MT7M1y1Q2zFd7+C0JcmIUlUS/te8HTOq2eG140Wo1ivI8Iei1w4Nrev6QL7OwJL6Vll5FFm4hkvG2P6k3fsTZIW9iHQlMcPTzBSGGqjs9DGkjvd6DcRs5bvoiBKyDiQD38IHDMu/EYRiXPRUNbGLjfzmQFFvkVm9f4x7RLwLjtxtAhtGsFVOHMRUrMR4f49I1Cs4aW4lwEslpKFPa/CiTGwOXQsufQiBqUQcOLez6arHMaJQH3cWt3uJtzBz6vMSvf8V0OsZcHcV64QtNcPh01ZPFdZELfYGxBMhuo0yZIgollgkulqGMBoXFeRziOOiIUm2NeloKwIB1gsHO6CpgKHiC2Py6LZvcVh04v1c5M092ItL7ay/31QAyOm5/5h3lioIOu0rtLARQtTQ4KGq0ajjk6PcwgI0GyIujvN7GmuuBxo4/iX4Q7ZdG6FcAEXt6AwDOk5AiK96VB1yOh17eFvV7cY6p+HyKDAnDuQ

This adds 2 example XML files from other repositories, under a fair use
license exception.
---
 Makefile.am                               |  10 ++
 unit/sdp-xml/Bluetooth_HID-sdp_record.xml | 123 ++++++++++++++++++++++
 unit/sdp-xml/qt-SerialPortSDPRecord.xml   |  57 ++++++++++
 unit/test-sdp-xml.c                       |  69 ++++++++++++
 4 files changed, 259 insertions(+)
 create mode 100644 unit/sdp-xml/Bluetooth_HID-sdp_record.xml
 create mode 100644 unit/sdp-xml/qt-SerialPortSDPRecord.xml
 create mode 100644 unit/test-sdp-xml.c

diff --git a/Makefile.am b/Makefile.am
index 19c468d3a504..1c62ee66bdce 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -637,6 +637,16 @@ unit_test_sdp_SOURCES = unit/test-sdp.c \
 unit_test_sdp_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
+unit_tests += unit/test-sdp-xml
+
+unit_test_sdp_xml_SOURCES = unit/test-sdp-xml.c \
+				src/sdp-xml.c src/sdp-xml.h \
+				src/log.h src/log.c
+unit_test_sdp_xml_LDADD = lib/libbluetooth-internal.la \
+				src/libshared-glib.la $(GLIB_LIBS)
+unit_test_sdp_xml_CFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) -DTOP_SRCDIR=\""$(srcdir)"\"
+unit_test_sdp_xml_CPPFLAGS = -I$(srcdir)/lib
+
 unit_tests += unit/test-avdtp
 
 unit_test_avdtp_SOURCES = unit/test-avdtp.c \
diff --git a/unit/sdp-xml/Bluetooth_HID-sdp_record.xml b/unit/sdp-xml/Bluetooth_HID-sdp_record.xml
new file mode 100644
index 000000000000..687b0b15b520
--- /dev/null
+++ b/unit/sdp-xml/Bluetooth_HID-sdp_record.xml
@@ -0,0 +1,123 @@
+<?xml version="1.0" encoding="UTF-8" ?>
+
+<!--
+
+ From: https://github.com/AnesBenmerzoug/Bluetooth_HID/blob/master/sdp_record.xml
+ A description of these fields can be found in the following links:
+ http://www.bluecove.org/bluecove/apidocs/javax/bluetooth/ServiceRecord.html
+ https://www.bluetooth.com/specifications/assigned-numbers/service-discovery
+
+ -->
+
+<record>
+	<attribute id="0x0001"> <!-- Service Class ID List -->
+		<sequence>
+			<uuid value="0x1124" /> <!-- Human Interface Device -->
+		</sequence>
+	</attribute>
+	<attribute id="0x0004"> <!-- Protocol Descriptor List -->
+		<sequence>
+			<sequence>
+				<uuid value="0x0100" /> <!-- L2CAP -->
+				<uint16 value="0x0011" /> <!-- HIDP -->
+			</sequence>
+			<sequence>
+				<uuid value="0x0011" /> <!-- HIDP -->
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x0005"> <!-- Browse Group List -->
+		<sequence>
+			<uuid value="0x1002" />
+		</sequence>
+	</attribute>
+	<attribute id="0x0006"> <!-- Language Based Attribute ID List -->
+		<sequence>
+			<uint16 value="0x656e" /> <!-- code_ISO639 -->
+			<uint16 value="0x006a" /> <!-- encoding -->
+			<uint16 value="0x0100" /> <!-- base_offset -->
+		</sequence>
+	</attribute>
+	<attribute id="0x0009"> <!-- Bluetooth Profile Descriptor List -->
+		<sequence>
+			<sequence>
+				<uuid value="0x1124" /> <!-- Human Interface Device -->
+				<uint16 value="0x0100" /> <!-- L2CAP -->
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x000d"> <!-- Additional Protocol Descriptor Lists -->
+		<sequence>
+			<sequence>
+				<sequence>
+					<uuid value="0x0100" /> <!-- L2CAP -->
+					<uint16 value="0x0013" />
+				</sequence>
+				<sequence>
+					<uuid value="0x0011" /> <!-- HIDP -->
+				</sequence>
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x0100">
+		<text value="Bluetooth_Keyboard/Mouse" />
+	</attribute>
+	<attribute id="0x0101">
+		<text value="USB > BT Keyboard/Mouse" />
+	</attribute>
+	<attribute id="0x0102">
+		<text value="Raspberry Pi 3" />
+	</attribute>
+	<attribute id="0x0200">
+		<uint16 value="0x0100" />
+	</attribute>
+	<attribute id="0x0201">
+		<uint16 value="0x0111" />
+	</attribute>
+	<attribute id="0x0202">
+		<uint8 value="0x40" />
+	</attribute>
+	<attribute id="0x0203">
+		<uint8 value="0x00" />
+	</attribute>
+	<attribute id="0x0204">
+		<boolean value="false" />
+	</attribute>
+	<attribute id="0x0205">
+		<boolean value="false" />
+	</attribute>
+	<attribute id="0x0206">
+		<sequence>
+			<sequence>
+				<uint8 value="0x22" />
+				<text encoding="hex" value="05010906A1018501A100050719E029E71500250175019508810295017508810195087508150025650507190029658100C0C005010902A10185020901A1000509190129031500250175019503810275059501810105010930093109381581257F750895038106C0C0"/>
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x0207">
+		<sequence>
+			<sequence>
+				<uint16 value="0x0409" />
+				<uint16 value="0x0100" />
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x020b">
+		<uint16 value="0x0100" />
+	</attribute>
+	<attribute id="0x020c">
+		<uint16 value="0x0c80" />
+	</attribute>
+	<attribute id="0x020d">
+		<boolean value="true" />
+	</attribute>
+	<attribute id="0x020e">
+		<boolean value="false" />
+	</attribute>
+	<attribute id="0x020f">
+		<uint16 value="0x0640" />
+	</attribute>
+	<attribute id="0x0210">
+		<uint16 value="0x0320" />
+	</attribute>
+</record>
diff --git a/unit/sdp-xml/qt-SerialPortSDPRecord.xml b/unit/sdp-xml/qt-SerialPortSDPRecord.xml
new file mode 100644
index 000000000000..1f62ccf11a41
--- /dev/null
+++ b/unit/sdp-xml/qt-SerialPortSDPRecord.xml
@@ -0,0 +1,57 @@
+<?xml version="1.0" encoding="UTF-8" ?>
+
+<!--
+ This is an XML file describing an SDP service record for a Serial Port
+ service.
+
+ You can use the linux sdptool command to create a file like this for
+ publishing your Bluetooth services. See the "Creating a Bluetooth service"
+ tutorial for more details.
+
+ From: https://radekp.github.io/qtmoko/api/bluetooth-bluetoothservice-serialportsdprecord-xml.html
+-->
+
+ <record>
+         <attribute id="0x0001">
+                 <sequence>
+                         <uuid value="0x1101" />
+                 </sequence>
+         </attribute>
+         <attribute id="0x0004">
+                 <sequence>
+                         <sequence>
+                                 <uuid value="0x0100" />
+                         </sequence>
+                         <sequence>
+                                 <uuid value="0x0003" />
+                                 <uint8 value="0x05" />
+                         </sequence>
+                 </sequence>
+         </attribute>
+         <attribute id="0x0005">
+                 <sequence>
+                         <uuid value="0x1002" />
+                 </sequence>
+         </attribute>
+         <attribute id="0x0006">
+                 <sequence>
+                         <uint16 value="0x656e" />
+                         <uint16 value="0x006a" />
+                         <uint16 value="0x0100" />
+                 </sequence>
+         </attribute>
+         <attribute id="0x0009">
+                 <sequence>
+                         <sequence>
+                                 <uuid value="0x1101" />
+                                 <uint16 value="0x0100" />
+                         </sequence>
+                 </sequence>
+         </attribute>
+         <attribute id="0x0100">
+                 <text value="Serial Port" />
+         </attribute>
+         <attribute id="0x0101">
+                 <text value="COM Port" />
+         </attribute>
+ </record>
diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
new file mode 100644
index 000000000000..bdb10fa5831b
--- /dev/null
+++ b/unit/test-sdp-xml.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+
+#include "bluetooth/sdp.h"
+#include "bluetooth/sdp_lib.h"
+
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+#include "src/log.h"
+#include "src/sdp-xml.h"
+
+static void parse_xml(gconstpointer data, gsize len)
+{
+	sdp_record_t *rec = NULL;
+
+	rec = sdp_xml_parse_record(data, len);
+	if (rec) {
+		tester_test_passed();
+		sdp_record_free(rec);
+	} else {
+		tester_test_failed();
+	}
+}
+
+static void parse_xml_for_filename(gconstpointer data)
+{
+	const char *filename = (const char *) data;
+	char *path = NULL;
+	GError *error = NULL;
+	char *contents = NULL;
+	gsize len;
+
+	path = g_build_filename(TOP_SRCDIR, "unit", "sdp-xml", filename, NULL);
+	if (!g_file_get_contents(path, &contents, &len, &error)) {
+		g_warning("Can't load file '%s': %s", path, error->message);
+		g_free(path);
+		g_error_free(error);
+		tester_test_failed();
+	}
+	parse_xml(contents, len);
+	g_free(contents);
+	g_free(path);
+}
+
+#define DEFINE_TEST(fname)							\
+	tester_add("/" fname, fname, NULL, parse_xml_for_filename, NULL);
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	DEFINE_TEST("Bluetooth_HID-sdp_record.xml");
+	DEFINE_TEST("qt-SerialPortSDPRecord.xml");
+
+	return tester_run();
+}
-- 
2.55.0


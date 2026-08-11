Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E2391842
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461030; cv=none; b=Ii/JP6kxoIteC+uLRoGZjVViL8QyuoNnRy1ZijQXOwbHgli11fqnFG9jy7n2JRN0ABHmaAX4Wt82jJt7w0Sx5JXM3LkV7vxrRVDg6JY4HjTMRBl3V/Na2ZL+7RKuHq2WixuLkKMaJjahgK+/BwbgU5c8NMeoALvhbzWxGiAYxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461030; c=relaxed/simple;
	bh=hbWWkxpKzd9+AdGSwFaqSECMUZ2KgZVqxU+e0FPQBtw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTPLUdmN23lbCC2VC0pZaAtk3Kaws1Qrdli472vuBAO3YEHu52TR5NmOsxvoTDHxcOJzoDClnjK4+cVtklP6TWYSU/1Ygua3oAMjcK+2lVCrLoGd8j3J9yTY02V9fM1fz237/o0KzLmFCR4f1nbzWV82FRDxhskW7+TYUtu++mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7F7B958234E
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4FC03ED08
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:13 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 1/9] unit: Add test for sdp_xml_parse_record()
Date: Tue, 11 Aug 2026 16:54:04 +0200
Message-ID: <20260811145704.1766949-2-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811145704.1766949-1-hadess@hadess.net>
References: <20260811145704.1766949-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 49
X-GND-Cause: dmFkZTEwU3btEmpVhS32rHn4h67v14sPA5//NuArCLLV03kpnLMiKqAq+JrbSeo+MmAtILo84DHRUIJOwAa9x3tsrTJore6GYyQL2gJTvY43a1WJvBiuca1JSBJNhObSOhs6IGWjLWMSS35qZ+UvafnVLDo5xsu+OYIid8L4xjOvk7QrSXsBHia+gWFfplkv/OFPTyyfLRjxeV8mq36ubtJBUK9p94vwb+4KmEIwCpef7xlGniQGa3iZe4wREx0YlupBr3lR8Y93ptt1RDfhqP3o8MDuKj2n9M5JLj9SzqGkQK8p6P0nqjWXSD3Ep+XVF8atAMH5LJ2CD51yfFP90ogNT/bjHkjiKkXMNyOkhleQRHUSBJDW6IXrPEKxBMMsQCg/pajaEZXBrI2NOpTBXLhxp5CoQH8jIA8pwEDLFUZoDDcqd29qAKAITvS37y+do7j5MyNYms1PrGtyO2n9G37Rxr35zgyapl1HKq8g5QKf2mLHXQ6kCn2lo801+w3iXJVFG9hlYB/LNyJGbAzEFYhDtypNNDNMarE1Znaeizm0HROQsDxaAPBtaEHrTolZkRYGfod3/3TiJ92QY4UppURZkGpP3pBQ/LLSUC58pKfzDB6ILAjOF/7cK1wHyfHL0J5eeVZNpKSIy2/u7EVGh97IdyNmi5w6NooukAs8j8FHcTy4Hg
X-GND-State: clean

This adds 2 example XML files from other repositories, under a fair use
license exception.
---
 Makefile.am                               |  10 ++
 unit/sdp-xml/Bluetooth_HID-sdp_record.xml | 123 ++++++++++++++++++++++
 unit/sdp-xml/qt-SerialPortSDPRecord.xml   |  57 ++++++++++
 unit/test-sdp-xml.c                       |  82 +++++++++++++++
 4 files changed, 272 insertions(+)
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
index 000000000000..11a83951678d
--- /dev/null
+++ b/unit/test-sdp-xml.c
@@ -0,0 +1,82 @@
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
+struct test_data {
+	GString *s;
+	char *filename;
+	gboolean expected_result;
+};
+
+static void parse_xml(gconstpointer data, gsize len, gboolean expected_result)
+{
+	sdp_record_t *rec = NULL;
+	gboolean ret;
+
+	rec = sdp_xml_parse_record(data, len);
+	ret = rec ? TRUE : FALSE;
+	if (ret == expected_result)
+		tester_test_passed();
+	else
+		tester_test_failed();
+	if (rec)
+		sdp_record_free(rec);
+}
+
+static void parse_xml_for_filename(gconstpointer data)
+{
+	struct test_data *t = (struct test_data *) data;
+	char *path = NULL;
+	GError *error = NULL;
+	char *contents = NULL;
+	gsize len;
+
+	path = g_build_filename(TOP_SRCDIR, "unit", "sdp-xml", t->filename, NULL);
+	if (!g_file_get_contents(path, &contents, &len, &error)) {
+		g_warning("Can't load file '%s': %s", path, error->message);
+		g_free(path);
+		g_error_free(error);
+		tester_test_failed();
+		return;
+	}
+	parse_xml(contents, len, t->expected_result);
+	g_free(contents);
+	g_free(path);
+}
+
+#define DEFINE_TEST(fname, res)							\
+	data.expected_result = res;						\
+	data.filename = fname;							\
+	tester_add("/" fname, &data, NULL, parse_xml_for_filename, NULL);
+
+int main(int argc, char *argv[])
+{
+	struct test_data data;
+
+	tester_init(&argc, &argv);
+
+	DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE);
+	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
+
+	return tester_run();
+}
-- 
2.55.0


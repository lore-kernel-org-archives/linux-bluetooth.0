Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/9] Adds XML record samples from Nonin Oximeter
Date: Tue, 11 May 2010 12:38:15 -0300
Message-Id: <1273592303-18234-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The XML record is slightly edited to be diff'able against
Python minidom prettyPrint()'s output.
---
 test/hdp/record_sample1.raw |   45 +++++++++++++++++++++++++++
 test/hdp/record_sample1.xml |   72 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 0 deletions(-)
 create mode 100644 test/hdp/record_sample1.raw
 create mode 100644 test/hdp/record_sample1.xml

diff --git a/test/hdp/record_sample1.raw b/test/hdp/record_sample1.raw
new file mode 100644
index 0000000..2721f64
--- /dev/null
+++ b/test/hdp/record_sample1.raw
@@ -0,0 +1,45 @@
+Sequence
+	Attribute 0x0000 - ServiceRecordHandle
+		UINT32 0x0001002e
+	Attribute 0x0001 - ServiceClassIDList
+		Sequence
+			UUID16 0x1401 - HDPSource
+	Attribute 0x0004 - ProtocolDescriptorList
+		Sequence
+			Sequence
+				UUID16 0x0100 - L2CAP
+				UINT16 0x1001
+			Sequence
+				UUID16 0x001e
+				UINT16 0x0100
+	Attribute 0x0006 - LanguageBaseAttributeIDList
+		Sequence
+			UINT16 0x656e
+			UINT16 0x006a
+			UINT16 0x0100
+	Attribute 0x0009 - BluetoothProfileDescriptorList
+		Sequence
+			Sequence
+				UUID16 0x1400 - HDP
+				UINT16 0x0100
+	Attribute 0x000d - AdditionalProtocolDescriptorLists
+		Sequence
+			Sequence
+				Sequence
+					UUID16 0x0100 - L2CAP
+					UINT16 0x1003
+				Sequence
+					UUID16 0x001f
+	Attribute 0x0100
+		String Nonin Oximeter
+	Attribute 0x0200
+		Sequence
+			Sequence
+				UINT8 0x01
+				UINT16 0x1004
+				UINT8 0x00
+				String Nonin Oximeter
+	Attribute 0x0301
+		UINT8 0x01
+	Attribute 0x0302
+		UINT8 0x18
diff --git a/test/hdp/record_sample1.xml b/test/hdp/record_sample1.xml
new file mode 100644
index 0000000..946f717
--- /dev/null
+++ b/test/hdp/record_sample1.xml
@@ -0,0 +1,72 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!-- Sample record obtained from Nonin Oximeter -->
+
+<record>
+	<attribute id="0x0000">
+		<uint32 value="0x00010030"/>
+	</attribute>
+	<attribute id="0x0001">
+		<sequence>
+			<uuid value="0x1401"/>
+		</sequence>
+	</attribute>
+	<attribute id="0x0004">
+		<sequence>
+			<sequence>
+				<uuid value="0x0100"/>
+				<uint16 value="0x1001"/>
+			</sequence>
+			<sequence>
+				<uuid value="0x001e"/>
+				<uint16 value="0x0100"/>
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x0006">
+		<sequence>
+			<uint16 value="0x656e"/>
+			<uint16 value="0x006a"/>
+			<uint16 value="0x0100"/>
+		</sequence>
+	</attribute>
+	<attribute id="0x0009">
+		<sequence>
+			<sequence>
+				<uuid value="0x1400"/>
+				<uint16 value="0x0100"/>
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x000d">
+		<sequence>
+			<sequence>
+				<sequence>
+					<uuid value="0x0100"/>
+					<uint16 value="0x1003"/>
+				</sequence>
+				<sequence>
+					<uuid value="0x001f"/>
+				</sequence>
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x0100">
+		<text value="Nonin Oximeter"/>
+	</attribute>
+	<attribute id="0x0200">
+		<sequence>
+			<sequence>
+				<uint8 value="0x01"/>
+				<uint16 value="0x1004"/>
+				<uint8 value="0x00"/>
+				<text value="Nonin Oximeter"/>
+			</sequence>
+		</sequence>
+	</attribute>
+	<attribute id="0x0301">
+		<uint8 value="0x01"/>
+	</attribute>
+	<attribute id="0x0302">
+		<uint8 value="0x18"/>
+	</attribute>
+</record>
-- 
1.7.0.4


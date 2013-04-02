Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Cc: keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v3 1/2] input: Documentation for new Input1 interface
Date: Mon,  1 Apr 2013 17:40:25 -0700
Message-Id: <1364863226-10566-2-git-send-email-deymo@chromium.org>
In-Reply-To: <1364863226-10566-1-git-send-email-deymo@chromium.org>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org>
 <1364863226-10566-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Adds new documentation for a new Input1 interface exposing two properties.
---
 doc/input-api.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 doc/input-api.txt

diff --git a/doc/input-api.txt b/doc/input-api.txt
new file mode 100644
index 0000000..44bbde6
--- /dev/null
+++ b/doc/input-api.txt
@@ -0,0 +1,21 @@
+BlueZ D-Bus Input API description
+*********************************
+
+Input hierarchy
+===============
+
+Service		org.bluez
+Interface	org.bluez.Input1
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties	boolean NormallyConnectable [readonly]
+
+			Exposes the value of HIDNormallyConnectable as defined
+			by the HID profile specification. If this optional value
+			is not specified by the HID device, the value is asumend
+			as FALSE.
+
+		boolean ConnectInitiate [readonly]
+
+			Exposes the value of ConnectInitiate as defined by the
+			HID profile specification.
-- 
1.8.1.3

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144BEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Nov 2022 00:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKHAny (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiKHAnx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Nov 2022 19:43:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCED62E3
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Nov 2022 16:43:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso466586pjn.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Nov 2022 16:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+nhdfT3cdXP76KxYS051VDFf3VC/0+N6jv1G3TssSv0=;
        b=WgE5ZhwlT47RUbJBGTEnsWPPnEWgs0EkMNdbnamCCXrVtwEdA9v2ejUA0ICi6jBbID
         q/Ef4PFkWpmb5vVzXiWasyihYDGTwZZAqu27p5EjsGFTX/liRTTGwoBJFDoMyIgbklwm
         Iwz7rirzZZFDUs0Fx6o8vXXpqj6Do3TCJukcymqf+PoFTkzDNVNYs4dQzRqq1PkdsVYZ
         b+NGDCI4IARUN2utP8eywy/CLxD9EreF262IozlxsgWBxgbQPAZs2S+YI0gm8eWu+SHh
         N0QFowbLcJRqahW6xQFsAP7zNWABo5yuwC5v/2mYW19w5Dw19tCcTEAU/LOINzATKOrZ
         JKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nhdfT3cdXP76KxYS051VDFf3VC/0+N6jv1G3TssSv0=;
        b=nRUgRq81xJp+wBbVSKTENdAy89cGmpvi9r8CEW314Do1009ehhpFK6kvFJe87C5CF7
         XONNPsQG+uYhgEYUAX65bLkKc8e2m7lNTTbDyn/k4KUJlnVMM4+UbvXbtQQCxISHAoo0
         VjASzqYNNxaqsvp4BeubZg7ilU4/cT4wVNV33HpiFkzSuAGloNjXyVhSiEU2hUxrJZm1
         ncefZFrxLqP/eBTJp7d90MlvimmgP3g1GUTnE/gIkzGNSQlynRCF9H+O8dx+h/miD926
         s5KNp7C+K7ayxawWfZbO5BOhkfLd3DTEkz3c3Qam3c1/g1iQ6W24IbBZebfK6q6DTuM/
         g10w==
X-Gm-Message-State: ANoB5pmm5gMkQWXvSgJe1TNeS4DaKkkB2BLTv6TT5wh080oZ+lCj8bqE
        Wm0nF7vqeQpiDLHEvb4wBLBQwV2y2EBy/g==
X-Google-Smtp-Source: AA0mqf6sz4PciLYv8RtCFtKgjCYsgZ1+2DN5nCekztZnIb1M2r0ualbBqDdkJb71ogIEH9EZojgKYg==
X-Received: by 2002:a17:902:a401:b0:188:79ba:d542 with SMTP id p1-20020a170902a40100b0018879bad542mr12263459plq.126.1667868230066;
        Mon, 07 Nov 2022 16:43:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y13-20020aa78f2d000000b0056babe4fb8asm5062427pfr.49.2022.11.07.16.43.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:43:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] unit: Introduce test-bap
Date:   Mon,  7 Nov 2022 16:43:48 -0800
Message-Id: <20221108004348.582197-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

/bap/basic - init
/bap/basic - setup
  bt_gatt_client:src/shared/gatt-client.c:exchange_mtu_cb() MTU exchange complete, with MTU: 64
  bt_gatt_client:src/shared/gatt-client.c:discover_primary_cb() Primary services found: 2
  bt_gatt_client:src/shared/gatt-client.c:discovery_parse_services() start: 0x0001, end: 0x0013, uuid: 00001850-0000-1000-8000-00805f9b34fb
  bt_gatt_client:src/shared/gatt-client.c:discovery_parse_services() start: 0x0014, end: 0x0023, uuid: 0000184e-0000-1000-8000-00805f9b34fb
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() Characteristics found: 11
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0002, end: 0x0004, value: 0x0003, props: 0x12, uuid: 00002bc9-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0005, end: 0x0007, value: 0x0006, props: 0x12, uuid: 00002bca-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0008, end: 0x000a, value: 0x0009, props: 0x12, uuid: 00002bcb-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x000b, end: 0x000d, value: 0x000c, props: 0x12, uuid: 00002bcc-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x000e, end: 0x0010, value: 0x000f, props: 0x12, uuid: 00002bcd-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0011, end: 0x0014, value: 0x0012, props: 0x12, uuid: 00002bce-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0015, end: 0x0017, value: 0x0016, props: 0x12, uuid: 00002bc4-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0018, end: 0x001a, value: 0x0019, props: 0x12, uuid: 00002bc4-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x001b, end: 0x001d, value: 0x001c, props: 0x12, uuid: 00002bc5-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x001e, end: 0x0020, value: 0x001f, props: 0x12, uuid: 00002bc5-0000-1000b
  bt_gatt_client:src/shared/gatt-client.c:discover_chrcs_cb() start: 0x0021, end: 0x0023, value: 0x0022, props: 0x18, uuid: 00002bc6-0000-1000b
/bap/basic - setup complete
/bap/basic - run
/bap/basic - test passed
/bap/basic - teardown
/bap/basic - teardown complete
/bap/basic - done

Test Summary
------------
/bap/basic                                           Passed
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
---
 Makefile.am     |   6 +
 unit/test-bap.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 305 insertions(+)
 create mode 100644 unit/test-bap.c

diff --git a/Makefile.am b/Makefile.am
index 5fd137bbab4e..4ad2ca398d6b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -569,6 +569,12 @@ unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
 			src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
 
+unit_tests += unit/test-bap
+
+unit_test_bap_SOURCES = unit/test-bap.c
+unit_test_bap_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 if MIDI
 unit_tests += unit/test-midi
 unit_test_midi_CPPFLAGS = $(AM_CPPFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
diff --git a/unit/test-bap.c b/unit/test-bap.c
new file mode 100644
index 000000000000..fbcd449fd487
--- /dev/null
+++ b/unit/test-bap.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <fcntl.h>
+
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+#include "src/shared/util.h"
+#include "src/shared/io.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/bap.h"
+
+static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	if (success)
+		tester_setup_complete();
+	else
+		tester_setup_failed();
+
+	bt_gatt_client_unref(client);
+}
+
+static const struct iovec setup_data[] = {
+	/* ATT: Exchange MTU Response (0x03) len 2
+	 *   Server RX MTU: 64
+	 */
+	IOV_DATA(0x02, 0x40, 0x00),
+	/* ATT: Exchange MTU Request (0x02) len 2
+	 *    Client RX MTU: 64
+	 */
+	IOV_DATA(0x03, 0x40, 0x00),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute type: Server Supported Features (0x2b3a)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+	/*
+	 * ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute group type: Primary Service (0x2800)
+	 */
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	/*
+	 * ATT: Read By Group Type Response (0x11) len 37
+	 *   Attribute data length: 6
+	 *   Attribute group list: 2 entries
+	 *   Handle range: 0x0001-0x0013
+	 *   UUID: Published Audio Capabilities (0x1850)
+	 *   Handle range: 0x0014-0x0023
+	 *   UUID: Audio Stream Control (0x184e)
+	 */
+	IOV_DATA(0x11, 0x06,
+		0x01, 0x00, 0x13, 0x00, 0x50, 0x18,
+		0x14, 0x00, 0x23, 0x00, 0x4e, 0x18),
+	/* ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0024-0xffff
+	 *   Attribute group type: Primary Service (0x2800)
+	 */
+	IOV_DATA(0x10, 0x24, 0x00, 0xff, 0xff, 0x00, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0024
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x10, 0x24, 0x00, 0x0a),
+	/* ATT: Read By Group Type Request (0x10) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute group type: Secondary Service (0x2801)
+	 */
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0x0023
+	 *   Attribute group type: Include (0x2802)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0x23, 0x00, 0x02, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Group Type Request (0x10)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0x0023
+	 *   Attribute type: Characteristic (0x2803)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0x23, 0x00, 0x03, 0x28),
+	/* ACL Data RX: Handle 42 flags 0x02 dlen 80
+	 *   ATT: Read By Type Response (0x09) len 75
+	 *   Attribute data length: 7
+	 *   Attribute data list: 10 entries
+	 *   Handle: 0x0002
+	 *   Value: 120300c92b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0003
+	 *   Value UUID: Sink PAC (0x2bc9)
+	 *   Handle: 0x0005
+	 *   Value: 120600ca2b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0006
+	 *   Value UUID: Sink Audio Locations (0x2bca)
+	 *   Handle: 0x0008
+	 *   Value: 120900cb2b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0009
+	 *   Value UUID: Source PAC (0x2bcb)
+	 *   Handle: 0x000b
+	 *   Value: 120c00cc2b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *  Value Handle: 0x000c
+	 *  Value UUID: Source Audio Locations (0x2bcc)
+	 *  Handle: 0x000e
+	 *  Value: 120f00cd2b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x000f
+	 *  Value UUID: Available Audio Contexts (0x2bcd)
+	 *  Handle: 0x0011
+	 *  Value: 121200ce2b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x0012
+	 *  Value UUID: Supported Audio Contexts (0x2bce)
+	 *  Handle: 0x0015
+	 *  Value: 121600c42b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x0016
+	 *  Value UUID: Sink ASE (0x2bc4)
+	 *  Handle: 0x0018
+	 *  Value: 121900c42b
+	 *  Properties: 0x12
+	 *    Read (0x02)
+	 *    Notify (0x10)
+	 *  Value Handle: 0x0019
+	 *  Value UUID: Sink ASE (0x2bc4)
+	 */
+	IOV_DATA(0x09, 0x07,
+		0x02, 0x00, 0x12, 0x03, 0x00, 0xc9, 0x2b,
+		0x05, 0x00, 0x12, 0x06, 0x00, 0xca, 0x2b,
+		0x08, 0x00, 0x12, 0x09, 0x00, 0xcb, 0x2b,
+		0x0b, 0x00, 0x12, 0x0c, 0x00, 0xcc, 0x2b,
+		0x0e, 0x00, 0x12, 0x0f, 0x00, 0xcd, 0x2b,
+		0x11, 0x00, 0x12, 0x12, 0x00, 0xce, 0x2b,
+		0x15, 0x00, 0x12, 0x16, 0x00, 0xc4, 0x2b,
+		0x18, 0x00, 0x12, 0x19, 0x00, 0xc4, 0x2b),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0x0023
+	 *   Attribute type: Characteristic (0x2803)
+	 */
+	IOV_DATA(0x08, 0x19, 0x00, 0x23, 0x00, 0x03, 0x28),
+	/* ATT: Read By Type Response (0x09) len 75
+	 *   Attribute data length: 7
+	 *   Attribute data list: 3 entries
+	 *   Handle: 0x001b
+	 *   Value: 121c00c52b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x001c
+	 *   Value UUID: Source ASE (0x2bc5)
+	 *   Handle: 0x001e
+	 *   Value: 121f00c52b
+	 *   Properties: 0x12
+	 *     Read (0x02)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x001f
+	 *   Value UUID: Source ASE (0x2bc5)
+	 *   Handle: 0x0021
+	 *   Value: 182200c62b
+	 *   Properties: 0x18
+	 *     Write (0x08)
+	 *     Notify (0x10)
+	 *   Value Handle: 0x0022
+	 *   Value UUID: ASE Control Point (0x2bc6)
+	 */
+	IOV_DATA(0x09, 0x07,
+		0x1b, 0x00, 0x12, 0x1c, 0x00, 0xc5, 0x2b,
+		0x1e, 0x00, 0x12, 0x1f, 0x00, 0xc5, 0x2b,
+		0x21, 0x00, 0x18, 0x22, 0x00, 0xc6, 0x2b),
+	/* ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0022-0x0023
+	 *   Attribute type: Characteristic (0x2803)
+	 */
+	IOV_DATA(0x08, 0x22, 0x00, 0x23, 0x00, 0x03, 0x28),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0022
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x23, 0x00, 0x0a),
+	/* ACL Data TX: Handle 42 flags 0x00 dlen 11
+	 *   ATT: Read By Type Request (0x08) len 6
+	 *   Handle range: 0x0001-0xffff
+	 *   Attribute type: Database Hash (0x2b2a)
+	 */
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b),
+	/* ATT: Error Response (0x01) len 4
+	 *   Read By Type Request (0x08)
+	 *   Handle: 0x0001
+	 *   Error: Attribute Not Found (0x0a)
+	 */
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
+};
+
+static void print_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	tester_debug("%s%s", prefix, str);
+}
+
+static void test_setup(const void *data)
+{
+	struct bt_att *att;
+	struct gatt_db *db;
+	struct bt_gatt_client *client;
+	struct io *io;
+
+	io = tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
+	g_assert(io);
+
+	att = bt_att_new(io_get_fd(io), false);
+	g_assert(att);
+
+	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+
+	db = gatt_db_new();
+	g_assert(db);
+
+	client = bt_gatt_client_new(db, att, 64, 0);
+	g_assert(client);
+
+	bt_gatt_client_set_debug(client, print_debug, "bt_gatt_client:", NULL);
+
+	bt_gatt_client_ready_register(client, client_ready_cb, client, NULL);
+
+	bt_att_unref(att);
+	gatt_db_unref(db);
+}
+
+static void test_client(const void *data)
+{
+	tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	tester_add("/bap/basic", NULL, test_setup, test_client, NULL);
+
+	return tester_run();
+}
-- 
2.37.3


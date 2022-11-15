Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B282C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 00:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiKOAaz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 19:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiKOAay (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 19:30:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F333A1758B
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:52 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso12364901pjc.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PVqJU8D0u3Vt6JBa/jWX2Ee3j2Z/ScRjgf8mzBKGpY=;
        b=DsgafJst1Bdtg/z3quPrM1sem6mRLzNpFVqTZqPcG+owe9kO49+QfWqHhH1yj1C21o
         MZu+8mODEuiffWNjf5OLqhVUF4hP7uM9xdeiWWPpeV+jEQaYHEeZgjXzNfZayvIzB4iq
         j4Q/pWV84qXTOSJA3WOf1DfW2eg1tcyson4ZUcwrkwvO2HyXKfBQdaUbYd5MIvuOF8H6
         EpN9/O3WNVh79lplaJIS+D+UaD4k53hejXVlTAV5ACAR2AafZtnJkuL5WHky9akoHd5p
         WlFgMVNMr3wDuP8XSAx9YmhEl3QAn1hFXi8Txm2c8uu6A7QmZFdPZ1XscZD8Wcq7JzNf
         ldEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PVqJU8D0u3Vt6JBa/jWX2Ee3j2Z/ScRjgf8mzBKGpY=;
        b=l/flOsKI9+aH7AAjDnm0cZ6nr8XatYCJP061PrWqInFeN8DhgtfE9jdmuY4TUTz5+H
         9ThNYm+Jqkr0QE71ZRRMfZ7P7UlFfTLofIwvvQkwFoRRG7nTMrRyN2n/paYLi7Ft/dLj
         0FvUB3OQOr0h2a6DXUKbnJYXXtMcUMD3boKzvGG6N7WSPs4/8DM2lOhm0UPnBFCoMJTX
         LLux78aHkuuzBGNdyD1eZkDvBM311lp2YqRbyQQhJ5L4Ibn/iOHJ9qb46DL7ieqY8N+a
         fkek8i5Q+1czqcw6WKBWxTLt3IWWi+6b4gY0Xr7sfxykKg8l9W0ZbGDgZlXCDOlYHPvP
         oaVA==
X-Gm-Message-State: ANoB5pmi0jXON9CIS/+wMr0BlhkaRUkOy00jJIHggY7veDNKy8YqOiqG
        P3OW6W/aLPTG8TirEeaJ97rHHgfxvs0=
X-Google-Smtp-Source: AA0mqf5EbNRVyLKpcNP1iiUuPsklWyTe0tH9xvfc+aUDh82j9rYN96yXVIFVuR5yEA7wYpjrjS9A1w==
X-Received: by 2002:a17:90a:a410:b0:211:7e51:9d65 with SMTP id y16-20020a17090aa41000b002117e519d65mr15479943pjp.220.1668472251465;
        Mon, 14 Nov 2022 16:30:51 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a3d0300b0020a28156e11sm10307888pjc.26.2022.11.14.16.30.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:30:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] unit: Introduce test-bap
Date:   Mon, 14 Nov 2022 16:30:38 -0800
Message-Id: <20221115003038.2134340-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221115003038.2134340-1-luiz.dentz@gmail.com>
References: <20221115003038.2134340-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Test Summary
------------
BAP/UCL/DISC/BV-01-C                                 Passed
BAP/UCL/DISC/BV-02-C                                 Passed
BAP/UCL/DISC/BV-06-C                                 Passed
BAP/UCL/DISC/BV-05-C                                 Passed
BAP/UCL/DISC/BV-03-C                                 Passed
BAP/UCL/DISC/BV-04-C                                 Passed
Total: 6, Passed: 6 (100.0%), Failed: 0, Not Run: 0
---
 Makefile.am     |   6 +
 unit/test-bap.c | 568 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 574 insertions(+)
 create mode 100644 unit/test-bap.c

diff --git a/Makefile.am b/Makefile.am
index 7041f8eeb52b..aa3a5e053cd8 100644
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
index 000000000000..afeefac84091
--- /dev/null
+++ b/unit/test-bap.c
@@ -0,0 +1,568 @@
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
+struct test_data {
+	struct bt_gatt_client *client;
+	struct bt_bap *bap;
+	size_t iovcnt;
+	struct iovec *iov;
+};
+
+#define iov_data(args...) ((const struct iovec[]) { args })
+
+#define define_test(name, function, args...)			\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data data;			\
+		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		tester_add(name, &data, test_setup, function,	\
+				test_teardown);			\
+	} while (0)
+
+static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	if (!success)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
+/* GATT Discover All procedure */
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
+	/* ATT: Read By Type Response (0x09) len 57
+	 * Attribute data length: 7
+	 * Attribute data list: 8 entries
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
+	/* ATT: Read By Type Response (0x09) len 22
+	 * Attribute data length: 7
+	 * Attribute data list: 3 entries
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
+	if (tester_use_debug())
+		tester_debug("%s%s", prefix, str);
+}
+
+static void test_setup(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct bt_att *att;
+	struct gatt_db *db;
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
+	data->client = bt_gatt_client_new(db, att, 64, 0);
+	g_assert(data->client);
+
+	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
+						NULL);
+
+	bt_gatt_client_ready_register(data->client, client_ready_cb, data,
+						NULL);
+
+	bt_att_unref(att);
+	gatt_db_unref(db);
+}
+
+static void test_complete_cb(const void *user_data)
+{
+	tester_test_passed();
+}
+
+static void test_client(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct io *io;
+	struct gatt_db *db;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(test_complete_cb);
+
+	db = gatt_db_new();
+	g_assert(db);
+
+	data->bap = bt_bap_new(db, bt_gatt_client_get_db(data->client));
+	g_assert(data->bap);
+
+	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
+
+	bt_bap_attach(data->bap, data->client);
+}
+
+static void test_teardown(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	bt_bap_unref(data->bap);
+	bt_gatt_client_unref(data->client);
+	util_iov_free(data->iov, data->iovcnt);
+
+	tester_teardown_complete();
+}
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0003 Type: Sink PAC (0x2bc9)
+ * ATT: Read Response (0x0b) len 24
+ *   Value: 010600000000100301ff0002020302030305041e00f00000
+ *   Handle: 0x0003 Type: Sink PAC (0x2bc9)
+ *     Number of PAC(s): 1
+ *       PAC #0:
+ *         Codec: LC3 (0x06)
+ *         Codec Specific Capabilities #0: len 0x03 type 0x01
+ *         Sampling Frequencies: 0x00ff
+ *           8 Khz (0x0001)
+ *           11.25 Khz (0x0002)
+ *           16 Khz (0x0004)
+ *           22.05 Khz (0x0008)
+ *           24 Khz (0x0010)
+ *           32 Khz (0x0020)
+ *           44.1 Khz (0x0040)
+ *           48 Khz (0x0080)
+ *       Codec Specific Capabilities #1: len 0x02 type 0x02
+ *         Frame Duration: 0x0003
+ *           7.5 ms (0x01)
+ *           10 ms (0x02)
+ *       Codec Specific Capabilities #2: len 0x02 type 0x03
+ *         Audio Channel Count: 0x03
+ *           1 channel (0x01)
+ *           2 channels (0x02)
+ *       Codec Specific Capabilities #3: len 0x05 type 0x04
+ *         Frame Length: 30 (0x001e) - 240 (0x00f0)
+ * ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0006 Type: Sink Audio Location (0x2bca)
+ * ATT: Read Response (0x0b) len 4
+ *   Value: 03000000
+ *   Handle: 0x0006 Type: Sink Audio Locations (0x2bca)
+ *     Location: 0x00000003
+ *       Front Left (0x00000001)
+ *       Front Right (0x00000002)
+ */
+#define DISC_SINK_PAC \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x01, 0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
+		0x1e, 0x00, 0xf0, 0x00, 0x00), \
+	IOV_DATA(0x0a, 0x06, 0x00), \
+	IOV_DATA(0x0b, 0x03, 0x00, 0x00, 0x00)
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0009 Type: Source PAC (0x2bcb)
+ * ATT: Read Response (0x0b) len 24
+ *   Value: 010600000000100301ff0002020302030305041e00f00000
+ *   Handle: 0x0009 Type: Source PAC (0x2bcb)
+ *     Number of PAC(s): 1
+ *       PAC #0:
+ *         Codec: LC3 (0x06)
+ *         Codec Specific Capabilities #0: len 0x03 type 0x01
+ *         Sampling Frequencies: 0x00ff
+ *           8 Khz (0x0001)
+ *           11.25 Khz (0x0002)
+ *           16 Khz (0x0004)
+ *           22.05 Khz (0x0008)
+ *           24 Khz (0x0010)
+ *           32 Khz (0x0020)
+ *           44.1 Khz (0x0040)
+ *           48 Khz (0x0080)
+ *       Codec Specific Capabilities #1: len 0x02 type 0x02
+ *         Frame Duration: 0x0003
+ *           7.5 ms (0x01)
+ *           10 ms (0x02)
+ *       Codec Specific Capabilities #2: len 0x02 type 0x03
+ *         Audio Channel Count: 0x03
+ *           1 channel (0x01)
+ *           2 channels (0x02)
+ *       Codec Specific Capabilities #3: len 0x05 type 0x04
+ *         Frame Length: 30 (0x001e) - 240 (0x00f0)
+ * ATT: Read Request (0x0a) len 2
+ *   Handle: 0x000c Type: Source Audio Location (0x2bcc)
+ * ATT: Read Response (0x0b) len 4
+ *   Value: 03000000
+ *   Handle: 0x000c Type: Source Audio Locations (0x2bcc)
+ *     Location: 0x00000003
+ *       Front Left (0x00000001)
+ *       Front Right (0x00000002)
+ */
+#define DISC_SOURCE_PAC \
+	DISC_SINK_PAC, \
+	IOV_DATA(0x0a, 0x09, 0x00), \
+	IOV_DATA(0x0b, 0x01, 0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
+		0x1e, 0x00, 0xf0, 0x00, 0x00), \
+	IOV_DATA(0x0a, 0x0c, 0x00), \
+	IOV_DATA(0x0b, 0x03, 0x00, 0x00, 0x00)
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
+ * ATT: Read Response (0x0b) len 4
+ *   Value: ff0f0e00
+ *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
+ */
+#define DISC_CTX \
+	DISC_SOURCE_PAC, \
+	IOV_DATA(0x0a, 0x0f, 0x00), \
+	IOV_DATA(0x0b, 0xff, 0x0f, 0x0e, 0x00)
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
+ * ATT: Read Response (0x0b) len 4
+ *   Value: ff0f0e00
+ *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
+ */
+#define DISC_SUP_CTX \
+	DISC_CTX, \
+	IOV_DATA(0x0a, 0x12, 0x00), \
+	IOV_DATA(0x0b, 0xff, 0x0f, 0x0e, 0x00)
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0016 Type: Sink ASE (0x2bc4)
+ * ATT: Read Response (0x0b) len 4
+ *   Value: 0100
+ *   Handle: 0x0016 Type: Sink ASE (0x2bc4)
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x0017 Type: Client Characteristic Configuration (0x2902)
+ *     Data: 0100
+ *       Notification (0x01)
+ * ATT: Write Response (0x13) len 0
+ * ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0019 Type: Sink ASE (0x2bc4)
+ * ATT: Read Response (0x0b) len 4
+ *   Value: 0200
+ *   Handle: 0x0019 Type: Sink ASE (0x2bc4)
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x001a Type: Client Characteristic Configuration (0x2902)
+ *     Data: 0100
+ *       Notification (0x01)
+ * ATT: Write Response (0x13) len 0
+ */
+#define DISC_SINK_ASE \
+	DISC_SUP_CTX, \
+	IOV_DATA(0x0a, 0x16, 0x00), \
+	IOV_DATA(0x0b, 0x01, 0x00), \
+	IOV_DATA(0x12, 0x17, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x0a, 0x19, 0x00), \
+	IOV_DATA(0x0b, 0x02, 0x00), \
+	IOV_DATA(0x12, 0x1a, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13)
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x001c Type: Source ASE (0x2bc5)
+ * ATT: Read Response (0x0b) len 4
+ *   Value: 0300
+ *   Handle: 0x001c Type: Source ASE (0x2bc5)
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x001d Type: Client Characteristic Configuration (0x2902)
+ *     Data: 0100
+ *       Notification (0x01)
+ * ATT: Write Response (0x13) len 0
+ * ATT: Read Request (0x0a) len 2
+ *   Handle: 0x001f Type: Source ASE (0x2bc5)
+ * ATT: Read Response (0x0b) len 4
+ *   Value: 0400
+ *   Handle: 0x001f Type: Source ASE (0x2bc5)
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x0020 Type: Client Characteristic Configuration (0x2902)
+ *     Data: 0100
+ *       Notification (0x01)
+ * ATT: Write Response (0x13) len 0
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x0023 Type: Client Characteristic Configuration (0x2902)
+ *     Data: 0100
+ *       Notification (0x01)
+ * ATT: Write Response (0x13) len 0
+ */
+#define DISC_SOURCE_ASE \
+	DISC_SINK_ASE, \
+	IOV_DATA(0x0a, 0x1c, 0x00), \
+	IOV_DATA(0x0b, 0x03, 0x00), \
+	IOV_DATA(0x12, 0x1d, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x0a, 0x1f, 0x00), \
+	IOV_DATA(0x0b, 0x04, 0x00), \
+	IOV_DATA(0x12, 0x20, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x12, 0x23, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13)
+
+static void test_disc(void)
+{
+	/* The IUT discovers the characteristics specified in the PAC
+	 * Characteristic and Location Characteristic columns in Table 4.4.
+	 * The IUT reads the values of the characteristics specified in the PAC
+	 * Characteristic and Location Characteristic columns.
+	 */
+	define_test("BAP/UCL/DISC/BV-01-C", test_client, DISC_SINK_PAC);
+	define_test("BAP/UCL/DISC/BV-02-C", test_client, DISC_SOURCE_PAC);
+
+	/* BAP/UCL/DISC/BV-06-C [Discover Available Audio Contexts]
+	 *
+	 * The IUT successfully reads the value of the Available Audio Contexts
+	 * characteristic on the LowerTester.
+	 */
+	define_test("BAP/UCL/DISC/BV-06-C", test_client, DISC_CTX);
+
+	/* BAP/UCL/DISC/BV-05-C [Discover Supported Audio Contexts]
+	 *
+	 * The IUT successfully reads the value of the Supported Audio Contexts
+	 * characteristic on the Lower Tester.
+	 */
+	define_test("BAP/UCL/DISC/BV-05-C", test_client, DISC_SUP_CTX);
+
+	/* BAP/UCL/DISC/BV-03-C [Discover Sink ASE_ID]
+	 * BAP/UCL/DISC/BV-04-C [Discover Source ASE_ID]
+	 *
+	 * The IUT successfully reads the ASE_ID values of each discovered ASE
+	 * characteristic on the LowerTester.
+	 */
+	define_test("BAP/UCL/DISC/BV-03-C", test_client, DISC_SINK_ASE);
+	define_test("BAP/UCL/DISC/BV-04-C", test_client, DISC_SOURCE_ASE);
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	test_disc();
+
+	return tester_run();
+}
-- 
2.37.3


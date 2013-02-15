Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 01/13] unit: Add initial SDP library unit tests
Date: Fri, 15 Feb 2013 11:07:44 -0400
Message-Id: <1360940876-6314-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These tests will cover all public SDP library API not covered yet by the
tests in test-sdp.c (which focus on the SDP server).
---
 .gitignore      |    1 +
 Makefile.am     |    5 ++
 unit/test-lib.c |  164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 unit/test-lib.c

diff --git a/.gitignore b/.gitignore
index b818659..9483b92 100644
--- a/.gitignore
+++ b/.gitignore
@@ -65,6 +65,7 @@ unit/test-uuid
 unit/test-textfile
 unit/test-gdbus-client
 unit/test-sdp
+unit/test-lib
 unit/test-mgmt
 tools/mgmt-tester
 tools/gap-tester
diff --git a/Makefile.am b/Makefile.am
index 5ebf5e6..cbcde3e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -270,6 +270,11 @@ unit_test_gobex_apparam_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
 						unit/test-gobex-apparam.c
 unit_test_gobex_apparam_LDADD = @GLIB_LIBS@
 
+unit_tests += unit/test-lib
+
+unit_test_lib_SOURCES = unit/test-lib.c
+unit_test_lib_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+
 noinst_PROGRAMS += $(unit_tests)
 
 TESTS = $(unit_tests)
diff --git a/unit/test-lib.c b/unit/test-lib.c
new file mode 100644
index 0000000..0be6d80
--- /dev/null
+++ b/unit/test-lib.c
@@ -0,0 +1,164 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013  Instituto Nokia de Tecnologia - INdT
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <glib.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+
+static void test_sdp_get_access_protos_valid(void)
+{
+	sdp_record_t *rec;
+	sdp_list_t *aproto, *apseq, *proto[2];
+	const uint8_t u8 = 1;
+	uuid_t l2cap, rfcomm;
+	sdp_data_t *channel;
+	int err;
+
+	rec = sdp_record_alloc();
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm);
+	channel = sdp_data_alloc(SDP_UINT8, &u8);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(rec, aproto);
+	sdp_set_add_access_protos(rec, aproto);
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto, NULL);
+
+	err = sdp_get_access_protos(rec, &aproto);
+	g_assert(err == 0);
+	sdp_list_foreach(aproto, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(aproto, NULL);
+
+	err = sdp_get_add_access_protos(rec, &aproto);
+	g_assert(err == 0);
+	sdp_list_foreach(aproto, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(aproto, NULL);
+
+	sdp_record_free(rec);
+}
+
+static void test_sdp_get_access_protos_nodata(void)
+{
+	sdp_record_t *rec;
+	sdp_list_t *aproto;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	err = sdp_get_access_protos(rec, &aproto);
+	g_assert(err == -1 && errno == ENODATA);
+
+	err = sdp_get_add_access_protos(rec, &aproto);
+	g_assert(err == -1 && errno == ENODATA);
+
+	sdp_record_free(rec);
+}
+
+static void test_sdp_get_access_protos_invalid_dtd1(void)
+{
+	const uint32_t u32 = 0xdeadbeeb;
+	sdp_record_t *rec;
+	sdp_list_t *aproto;
+	sdp_data_t *data;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	data = sdp_data_alloc(SDP_UINT32, &u32);
+	g_assert(data != NULL);
+	sdp_attr_replace(rec, SDP_ATTR_PROTO_DESC_LIST, data);
+
+	err = sdp_get_access_protos(rec, &aproto);
+	g_assert(err == -1 && errno == EINVAL);
+
+	data = sdp_data_alloc(SDP_UINT32, &u32);
+	g_assert(data != NULL);
+	sdp_attr_replace(rec, SDP_ATTR_ADD_PROTO_DESC_LIST, data);
+
+	err = sdp_get_add_access_protos(rec, &aproto);
+	g_assert(err == -1 && errno == EINVAL);
+
+	sdp_record_free(rec);
+}
+
+static void test_sdp_get_access_protos_invalid_dtd2(void)
+{
+	uint8_t dtd = SDP_UINT8, u8 = 0xff;
+	void *dtds = &dtd, *values = &u8;
+	sdp_record_t *rec;
+	sdp_list_t *aproto;
+	sdp_data_t *data;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	data = sdp_seq_alloc(&dtds, &values, 1);
+	g_assert(data != NULL);
+	sdp_attr_replace(rec, SDP_ATTR_PROTO_DESC_LIST, data);
+
+	err = sdp_get_access_protos(rec, &aproto);
+	g_assert(err == -1 && errno == EINVAL);
+
+	data = sdp_seq_alloc(&dtds, &values, 1);
+	g_assert(data != NULL);
+	sdp_attr_replace(rec, SDP_ATTR_ADD_PROTO_DESC_LIST, data);
+
+	err = sdp_get_add_access_protos(rec, &aproto);
+	g_assert(err == -1 && errno == EINVAL);
+
+	sdp_record_free(rec);
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_func("/lib/sdp_get_access_protos/valid",
+					test_sdp_get_access_protos_valid);
+	g_test_add_func("/lib/sdp_get_access_protos/nodata",
+					test_sdp_get_access_protos_nodata);
+	g_test_add_func("/lib/sdp_get_access_protos/invalid_dtd1",
+				test_sdp_get_access_protos_invalid_dtd1);
+	g_test_add_func("/lib/sdp_get_access_protos/invalid_dtd2",
+				test_sdp_get_access_protos_invalid_dtd2);
+
+	return g_test_run();
+}
-- 
1.7.9.5


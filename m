Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967A35E93D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144735; cv=none; b=Y/fhZCIBUp8zi8hv//PrpBQHLyKHAQY3rQeEnaiyQOFF9NspgXp6H7dLd+gc4KM9687ZgXNHAsXwKO6IMXBMQLcuqCiXEu8VwOEBTpBPhZ4XkBr3On+ncg6jwmWzUow4UT8MWfSfHiRYKAyKAjWBl33aKN5wL1sV3RhGbiY/wBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144735; c=relaxed/simple;
	bh=ibt31NdexvkJSEQCvJuRtDKBSo0RH8H2vjpCgIUWcgU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d3FsSYRooRRZP1e6zmm4L4ULF4fJJBd8eSsgxeljebda34vlBBhjoDEhigYUQ3RQT3rJjLasDIheRHdZgBwoq3USFqmaJdCjCfM1qD2BNgGhnGuHurBCTxBxPq4hE+aFgwzJ7cZeVstqL7QFyCUka53yAeJAaTfEHz2gwwNqEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF9723EC4C
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:45:25 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared: Add single-link list implementation
Date: Thu,  2 Apr 2026 17:44:41 +0200
Message-ID: <20260402154520.48939-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFUgh5cVu1BouxoJ+Wg84jsEB6ipMd+x8I1VSGEie2qW8nF1LLNt8fxusave1/KA0YOqejfKDUl83k+NQHXWHQc0kHp34mFPq2XqEocFLr1BxmPWvdqyYic9NdxV0Txl2EA0v7Whu553RuBj34udBSm/2XBqTN4mBm3hNInGiXoA28aTfkk6nh8pBhrY6ajL/WdhUsWq64C0tHS6CzHs8weavbaqYSojP0NcaRmpbh6trkhDnzifdk95hoshSfUomBx6xGruPq7NUw6RkDlS9TvyQGmvPrLAmjqQRY5jJK8Lp3hhckxuvQPhAJam/L9kyD6KKUucM5KS6zmHF7YNw2OgLqJUcrC7azIRLj11rWAbHnEKtwHKYFX71XGu4x8wmNUZgTeb8b5v5928vKZ068lFjptq1pA0ycAp7P/LCyrl2/z7YfuIHvCbRT322uJiQ2YJuGe5wtDSpUauSrzQ27uMKgt26b1b3OoDfnezfkeXSk4y/Qm3LcfVJgQ7HHUuYXmeLwN2Wna62pikG8DqqZxcWzyLeiZ0yM3Q8Kpp8fZHFwOB2LFEfi6ak5zZOlud+RQQBsN1DVGSusup3gqDR4AWIUiL7f7O7egtQ4mvzFEhnMQ9hPueOPNqpR6t0p3pTPbjU0y1ArU3DZ7OaNTlWV28s34MFHHv/7H7eoQm2sRxQ

This will allow some parts of the project to stop relying on glib
headers without linking to glib, or glib dependencies being introduced
in shared sources that need to be able not to link with glib.

ell doesn't include any linked-list API either, so it's glib or
home-made.
---
 Makefile.am       |  5 +++
 src/shared/list.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/list.h | 26 ++++++++++++++
 unit/test-list.c  | 68 +++++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 src/shared/list.c
 create mode 100644 src/shared/list.h
 create mode 100644 unit/test-list.c

diff --git a/Makefile.am b/Makefile.am
index d9de71d587d8..2d28f93d611e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -214,6 +214,7 @@ endif
 shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/queue.h src/shared/queue.c \
 			src/shared/util.h src/shared/util.c \
+			src/shared/list.h src/shared/list.c \
 			src/shared/mgmt.h src/shared/mgmt.c \
 			src/shared/crypto.h src/shared/crypto.c \
 			src/shared/ecc.h src/shared/ecc.c \
@@ -700,6 +701,10 @@ unit_tests += unit/test-util
 unit_test_util_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
+unit_tests += unit/test-list
+unit_test_list_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 unit_tests += unit/test-gatt
 
 unit_test_gatt_SOURCES = unit/test-gatt.c
diff --git a/src/shared/list.c b/src/shared/list.c
new file mode 100644
index 000000000000..1eb617a9e40f
--- /dev/null
+++ b/src/shared/list.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026 Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "src/shared/list.h"
+
+#include <stddef.h>
+#include <stdlib.h>
+
+static slist_t*
+slist_last(slist_t *list)
+{
+	slist_t *last;
+
+	if (list == NULL)
+		return NULL;
+	last = list;
+	while (last->next != NULL)
+		last = last->next;
+	return last;
+}
+
+slist_t* slist_append(slist_t *list, void *data)
+{
+	slist_t *new_item;
+
+	new_item = malloc(sizeof(slist_t));
+	new_item->data = data;
+	new_item->next = NULL;
+
+	if (list != NULL) {
+		slist_t *last;
+		last = slist_last(list);
+		last->next = new_item;
+		return list;
+	}
+	return new_item;
+}
+
+void slist_clear(slist_t *list, free_func func)
+{
+	slist_t *l;
+
+	l = list;
+	while (l != NULL) {
+		slist_t *next = l->next;
+		if (func != NULL)
+			(func)(l->data);
+		free(l);
+		l = next;
+	}
+}
+
+void slist_free(slist_t *list)
+{
+	slist_clear(list, NULL);
+}
+
+slist_t* slist_find(slist_t *list, const void *data, compare_func func)
+{
+	slist_t *l;
+
+	if (func == NULL)
+		return NULL;
+	for (l = list; l != NULL; l = l->next) {
+		if ((func)(data, l->data) == 0)
+			return l;
+	}
+	return NULL;
+}
+
+void slist_foreach(slist_t *list, foreach_func func, void *user_data)
+{
+	slist_t *l;
+
+	if (func == NULL)
+		return;
+	for (l = list; l != NULL; l = l->next)
+		(func)(l->data, user_data);
+}
diff --git a/src/shared/list.h b/src/shared/list.h
new file mode 100644
index 000000000000..3a01d0425315
--- /dev/null
+++ b/src/shared/list.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ */
+
+#pragma once
+
+typedef struct slist {
+	void *next;
+	void *data;
+} slist_t;
+
+typedef void (*free_func) (void *data);
+typedef int (*compare_func) (const void *a, const void *b);
+typedef void (*foreach_func) (void *data, void *user_data);
+
+slist_t* slist_append(slist_t *list, void *data);
+void slist_clear(slist_t *list, free_func func);
+void slist_free(slist_t *list);
+slist_t* slist_find(slist_t *list, const void *data, compare_func func);
+void slist_foreach(slist_t *list, foreach_func func, void *user_data);
diff --git a/unit/test-list.c b/unit/test-list.c
new file mode 100644
index 000000000000..5dc41ebf3ebd
--- /dev/null
+++ b/unit/test-list.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ */
+
+#include <assert.h>
+
+#include "src/shared/list.h"
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+
+#define ONE 1
+#define TWO 2
+#define THREE 3
+#define ADDITION (ONE + TWO + THREE)
+
+static void add_up(void *data, void *user_data)
+{
+	int *total = (int *) user_data;
+	*total += PTR_TO_UINT(data);
+}
+
+static int int_equal(const void *a, const void *b)
+{
+	if (PTR_TO_UINT(a) == PTR_TO_UINT(b))
+		return 0;
+	return 1;
+}
+
+static void test_list_common(const void *data)
+{
+	slist_t *l;
+	slist_t *head;
+	slist_t *two;
+	int total;
+
+	l = slist_append(NULL, UINT_TO_PTR(ONE));
+	head = l;
+	l = slist_append(l, UINT_TO_PTR(TWO));
+	l = slist_append(l, UINT_TO_PTR(THREE));
+
+	assert(l == head);
+	total = 0;
+	slist_foreach(l, add_up, &total);
+	assert(total == ADDITION);
+
+	two = slist_find(l, UINT_TO_PTR(TWO), int_equal);
+	assert(two == l->next);
+
+	slist_clear(l, NULL);
+
+	tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	tester_add("/list/common", NULL, NULL,
+			test_list_common, NULL);
+
+	return tester_run();
+}
-- 
2.53.0


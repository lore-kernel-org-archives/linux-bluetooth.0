Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/22] cbuffer: Circular buffer initial implementation
Date: Mon, 14 Oct 2013 10:34:17 +0200
Message-Id: <1381739678-16260-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds circular buffer needed by the AT command parser.
---
 src/shared/cbuffer.c |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/cbuffer.h |   33 ++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 src/shared/cbuffer.c
 create mode 100644 src/shared/cbuffer.h

diff --git a/src/shared/cbuffer.c b/src/shared/cbuffer.c
new file mode 100644
index 0000000..7dde707
--- /dev/null
+++ b/src/shared/cbuffer.c
@@ -0,0 +1,124 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdlib.h>
+#include <errno.h>
+
+#include "cbuffer.h"
+
+struct circular_buffer {
+	int size;
+	int start;
+	int end;
+	char *data;
+};
+
+/* find next closest power of 2 */
+static int cbuffer_find_next_po2(unsigned int size)
+{
+	size--;
+	size |= size >> 1;
+	size |= size >> 2;
+	size |= size >> 4;
+	size |= size >> 8;
+	size |= size >> 16;
+	size++;
+	return size;
+}
+
+struct circular_buffer *cbuffer_init(unsigned int size)
+{
+	struct circular_buffer *cbuff = malloc(sizeof(struct circular_buffer));
+
+	if (!cbuff)
+		return NULL;
+
+	/* Need 2^x size for this implementation of circular buffer */
+	cbuff->size  = cbuffer_find_next_po2(size);
+	cbuff->start = 0;
+	cbuff->end   = 0;
+	cbuff->data = NULL;
+
+	cbuff->data = malloc(cbuff->size);
+	if (!cbuff->data) {
+		free(cbuff);
+		return NULL;
+	}
+
+	return cbuff;
+}
+
+void cbuffer_free(struct circular_buffer *cbuff)
+{
+	free(cbuff->data);
+	cbuff->data = NULL;
+	free(cbuff);
+}
+
+void cbuffer_drain(struct circular_buffer *cbuff)
+{
+	cbuff->start = 0;
+	cbuff->end   = 0;
+}
+
+int cbuffer_is_full(struct circular_buffer *cbuff)
+{
+	/* Most significant bit inverted for comparison - index mirroring */
+	return cbuff->end == (cbuff->start ^ cbuff->size);
+}
+
+int cbuffer_is_empty(struct circular_buffer *cbuff)
+{
+	return cbuff->end == cbuff->start;
+}
+
+static void cbuffer_incr(struct circular_buffer *cbuff, int *p)
+{
+	/* Modulo 2*size offset incrementation - index mirroring */
+	*p = (*p + 1) & (2 * cbuff->size - 1);
+}
+
+int cbuffer_write(struct circular_buffer *cbuff, char source)
+{
+	if (!cbuffer_is_full(cbuff)) {
+		cbuff->data[cbuff->end & (cbuff->size - 1)] = source;
+		cbuffer_incr(cbuff, &cbuff->end);
+		return 0;
+	}
+	return -ENOSPC;
+}
+
+int cbuffer_read(struct circular_buffer *cbuff, char *dest)
+{
+	if (!cbuffer_is_empty(cbuff)) {
+		*dest = cbuff->data[cbuff->start & (cbuff->size - 1)];
+		cbuffer_incr(cbuff, &cbuff->start);
+		return 0;
+	}
+	return -ENODATA;
+}
+
+unsigned int cbuffer_get_size(struct circular_buffer *cbuff)
+{
+	return cbuff->size;
+}
diff --git a/src/shared/cbuffer.h b/src/shared/cbuffer.h
new file mode 100644
index 0000000..8865f1f
--- /dev/null
+++ b/src/shared/cbuffer.h
@@ -0,0 +1,33 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct circular_buffer;
+
+struct circular_buffer *cbuffer_init(unsigned int size);
+void cbuffer_free(struct circular_buffer *cbuff);
+int cbuffer_write(struct circular_buffer *cbuff, char source);
+int cbuffer_read(struct circular_buffer *cbuff, char *dest);
+void cbuffer_drain(struct circular_buffer *cbuff);
+int cbuffer_is_full(struct circular_buffer *cbuff);
+int cbuffer_is_empty(struct circular_buffer *cbuff);
+unsigned int cbuffer_get_size(struct circular_buffer *cbuff);
-- 
1.7.9.5


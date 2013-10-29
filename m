Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 8/9] android: Add thread-safe helpers
Date: Tue, 29 Oct 2013 12:21:57 +0200
Message-Id: <1383042118-21205-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382957047-31775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add thread safe helpers to make HAL debug printing thread-safe. The code
is inherited from Android bionic and it is used for strerror, strsignal,
etc.
---
 android/pthread-local.h |   58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 android/pthread-local.h

diff --git a/android/pthread-local.h b/android/pthread-local.h
new file mode 100644
index 0000000..bc3c0b3
--- /dev/null
+++ b/android/pthread-local.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2012 The Android Open Source Project
+ * Copyright (C) 2013 Intel Corp.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *  * Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *  * Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+ * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
+ * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include <pthread.h>
+#include <stdlib.h>
+
+#define GLOBAL_INIT_THREAD_LOCAL_BUFFER(name) \
+	static pthread_key_t __tls_ ## name ## _key; \
+	static void __tls_ ## name ## _key_destroy(void *buffer) \
+	{ \
+		free(buffer); \
+	} \
+	static void __attribute__((constructor)) __tls_ ## name ## _key_init() \
+	{ \
+		pthread_key_create(&__tls_ ## name ## _key, \
+					__tls_ ## name ## _key_destroy); \
+	}
+
+/*
+ * Leaves "name_tls_buffer" and "name_tls_buffer_size" defined and initialized.
+ */
+#define LOCAL_INIT_THREAD_LOCAL_BUFFER(type, name, byte_count) \
+	const size_t name ## _tls_buffer_size \
+					__attribute__((unused)) = byte_count; \
+	type name ## _tls_buffer = \
+		(pthread_getspecific(__tls_ ## name ## _key)); \
+	if (name ## _tls_buffer == NULL) { \
+		name ## _tls_buffer = (calloc(1, byte_count)); \
+		pthread_setspecific(__tls_ ## name ## _key, \
+							name ## _tls_buffer); \
+	}
-- 
1.7.10.4


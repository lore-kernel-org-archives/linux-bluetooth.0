Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android: Fix btmgmt build for Android
Date: Fri, 13 Feb 2015 20:16:13 +0100
Message-Id: <1423854975-16515-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android doesn't provide readline and wordexp libraries. Since
interactive mode is not necessary for now just provide stubbed
implementation.

Since those headers are loosly based on those libraries original
licence and copyright are present.
---
 android/Android.mk                          |   2 +
 android/compat_includes/readline/history.h  |  31 ++++++++
 android/compat_includes/readline/readline.h | 110 ++++++++++++++++++++++++++++
 android/compat_includes/wordexp.h           |  44 +++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 android/compat_includes/readline/history.h
 create mode 100644 android/compat_includes/readline/readline.h
 create mode 100644 android/compat_includes/wordexp.h

diff --git a/android/Android.mk b/android/Android.mk
index 289c1df..720e988 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -493,9 +493,11 @@ LOCAL_SRC_FILES := \
 	bluez/src/shared/util.c \
 	bluez/src/shared/gap.c \
 	bluez/src/uuid-helper.c \
+	bluez/client/display.c \
 
 LOCAL_C_INCLUDES := \
 	$(LOCAL_PATH)/bluez \
+	$(LOCAL_PATH)/bluez/android/compat_includes \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
diff --git a/android/compat_includes/readline/history.h b/android/compat_includes/readline/history.h
new file mode 100644
index 0000000..decc2f4
--- /dev/null
+++ b/android/compat_includes/readline/history.h
@@ -0,0 +1,31 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 1987-2011 Free Software Foundation, Inc.
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
+#ifndef _HISTORY_H_
+#define _HISTORY_H_
+
+static inline void add_history(const char *c)
+{
+}
+
+#endif
diff --git a/android/compat_includes/readline/readline.h b/android/compat_includes/readline/readline.h
new file mode 100644
index 0000000..aaf6f31
--- /dev/null
+++ b/android/compat_includes/readline/readline.h
@@ -0,0 +1,110 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 1987-2011 Free Software Foundation, Inc.
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
+#ifndef _READLINE_H_
+#define _READLINE_H_
+
+typedef void (*rl_vcpfunc_t)(char *c);
+typedef void (*rl_compdisp_func_t)(char **c, int i, int j);
+typedef char *(*rl_compentry_func_t)(const char *c, int i);
+typedef char **(*rl_completion_func_t)(const char *c, int i, int j);
+
+#define RL_STATE_DONE 0x1000000
+#define RL_ISSTATE(x) (rl_readline_state & (x))
+
+static int rl_end;
+static int rl_point;
+static int rl_readline_state;
+static int rl_erase_empty_line;
+static int rl_attempted_completion_over;
+static char *rl_prompt;
+static char *rl_line_buffer;
+static rl_compdisp_func_t rl_completion_display_matches_hook;
+static rl_completion_func_t rl_attempted_completion_function;
+
+static inline void rl_callback_handler_install(const char *c, rl_vcpfunc_t f)
+{
+	printf("readline not available\n");
+	exit(1);
+}
+
+static inline int rl_set_prompt(const char *c)
+{
+	return -1;
+}
+
+static inline void rl_replace_line(const char *c, int i)
+{
+}
+
+static inline void rl_redisplay(void)
+{
+}
+
+static inline char **rl_completion_matches(const char *c, rl_compentry_func_t f)
+{
+	return NULL;
+}
+
+static inline int rl_insert_text(const char *c)
+{
+	return -1;
+}
+
+static inline int rl_crlf(void)
+{
+	return -1;
+}
+
+static inline void rl_callback_read_char(void)
+{
+}
+
+static inline int rl_message(const char *c, ...)
+{
+	return -1;
+}
+
+static inline void rl_callback_handler_remove(void)
+{
+}
+
+static inline char *rl_copy_text(int i, int j)
+{
+	return NULL;
+}
+
+static inline void rl_save_prompt(void)
+{
+}
+
+static inline void rl_restore_prompt(void)
+{
+}
+
+static inline int rl_forced_update_display(void)
+{
+	return -1;
+}
+
+#endif
diff --git a/android/compat_includes/wordexp.h b/android/compat_includes/wordexp.h
new file mode 100644
index 0000000..ff1f21c
--- /dev/null
+++ b/android/compat_includes/wordexp.h
@@ -0,0 +1,44 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 1991-2013 Free Software Foundation, Inc.
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
+#ifndef _WORDEXP_H_
+#define _WORDEXP_H_
+
+#define WRDE_NOCMD 0
+
+typedef struct {
+	size_t we_wordc;
+	char **we_wordv;
+	size_t we_offs;
+} wordexp_t;
+
+static inline int wordexp(const char *c, wordexp_t *w, int _i)
+{
+	return -1;
+}
+
+static inline void wordfree(wordexp_t *__wordexp)
+{
+}
+
+#endif
-- 
1.9.3


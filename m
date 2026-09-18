Received: from mail-ua2-f25.google.com (mail-ua2-f25.google.com [74.125.226.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503485158BE
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748075; cv=none; b=N7McqZlq6eF9NXlYLZUgsfrT9gGf3RJ+lb4FovxKBK5kcZHsReWBRVBnlF/iBVps2+Ou3KkEgjIlRcOAwS5WHDmRhYGgwbnF1w42OuItc+QVTdVQF68hqKzJYxHNLLLUS5OQdi5xUlpPwjFAjPJQVWl/OgyU4KkL0y1H/AP2Rb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748075; c=relaxed/simple;
	bh=P3IxVqBIW3C+Gs3UVKBWjGjj2fgk3i20SfxFSbQOyto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e450vks1xU7PlxAWTrQaQTJaKl9QBuFMTKRp7rEK4RrfHfg9/SA/+6ObQ5CzNg28HUiKiTIVxXU+GR9q7zoUS+zh4xqEab5ET/ULTgDbfctdPR50c93Tk7xnW7nfxMutpdnUw83mRxoa+WYL1bytPabDFKoCwPs9i5VMvWJynX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2WeMmpe; arc=none smtp.client-ip=74.125.226.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2WeMmpe"
Received: by mail-ua2-f25.google.com with SMTP id a1e0cc1a2514c-982e8fa91d3so190453241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748072; x=1790352872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BkY24KUWUS8lz4jJjG7K0x00vWf67EqQWSwygh3gDCk=;
        b=U2WeMmpep0PTcJSoc8vUkxfF3Yz+3L8tYSlnYc4rrfLbkfIWnQGuee83I7IOK/OrFK
         ZBNq/zgodiFl6MhZ8NyHViTnes3oWRyoTEDknzmREpMRsEFZiWGZVMdu5OKPw3huGzdV
         w+3iZeNUmq1rAUKPakWwXU0RF3a5a2Jcdomv6UjzycgB7nLcx3/Wo0P8UzjX+fjXzEt4
         guWXv3c0fl+vreZYRcu7R8/zETjfMaQsXTnHtHppke8CYG+7BDR8I9Dg0ypYv3i5KA4+
         VU9E7z17kWXLfHrXXA83mJKiqUa9W/vMOukfKicm4gbsoc8CMghX2UAzvzZzHSNrWP8I
         WT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748072; x=1790352872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BkY24KUWUS8lz4jJjG7K0x00vWf67EqQWSwygh3gDCk=;
        b=EbCdbp+PuXEz9vfFRyDE1BOPW/YSuvbJRCFjGeDcdw3cJbvV0We21JYGHPHlvZoYzA
         JGbOMQSqMO/lUWf/mECPuGVDcv9XYRritnoTRenYs9XqkzISu8z7leYkwn/ADaz3Ytag
         SZMDQFYoPnraIE/CPIL+RqBa8VXI/bRosWC/XXrjq3e52g9w0iWPNzH3PlJE+sgJWXTr
         MN/9O4JQqQ8Yltgys2kSN+kZXElnDkFOduWn2FLZRg0kgKlntNqeaC8t9cfWrKRee9j2
         FneNewswHod2wKMVRxlplTXSyjoS+DWxYWHO39cfVgE+lTz44ynavGvjaF6kpl3BJ+iF
         qijQ==
X-Gm-Message-State: AFuF++nrAdSwtDWY5dbLH6mFJyP0dYgPOuj/z0usTE+9nebsqGfiepkp
	QLKdTkAHnkdstDbuyagj7dYazhKFkxVFZpbspwUKN+L7MgMjeDcdPRg2Y2UdEIeb
X-Gm-Gg: AYBFou2v0scPXdt2zUkLiaI1Rn2J5D5yCtymAIxhIAJG7TB25ZYx0I93O3VUX24CsjF
	NJekdvgcxG+vPAVJVQi5S8FCyTBtZKt+zpWrJOJv9Ti9Df5MZp+TV+hYgXdLuTJJabmVwbAPREA
	V9HACqC4GP4P/rHYKa4HZq6VH2TkF6WAug0n3n3KB8xgwj1Fg6mFC2Ebb9UW/9J6Hw6Cw/hZEYu
	p1Jo1OTuu1N1fAVXHPe7NXDCv59AUBlwzfuRYF+BgPwOxp7tPP0V0O8x1hdBhQgB67gnjiVA0T6
	diprjRoRO80L7vkU8CjhUaKrrzewgOFfPWCNsjG3LZHadKVQl0Olr3sHCmXjTECA/pbgcsf+cgD
	P8vpz+jBgcaPZvknT+umJKDeRveqnR30XcJr8Q9xYsNzkMZGv5rKJq+X3p96Uscz0/dFa5J5RxV
	Fjbsuc3Rp+DvrPA2EPyRXJEKa+8pB37dLtNjzRry3rQLBOhw8peP4CxbGS62wKCZIjs/IuP2k2f
	fJD49cN6Grs76GJ3E9cofSL64tXpxJUcqWyA245k780u9qQb588baNERtWpxbQO
X-Received: by 2002:a05:6102:1609:b0:79d:a035:b6e6 with SMTP id ada2fe7eead31-7a55961fbffmr759888137.3.1789748072108;
        Fri, 18 Sep 2026 09:14:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/9] monitor: Prefer fzf as the pager when one is not set
Date: Fri, 18 Sep 2026 12:14:07 -0400
Message-ID: <20260918161408.2464981-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918161408.2464981-1-luiz.dentz@gmail.com>
References: <20260918161408.2464981-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A trace is a poor fit for a plain pager. Every frame spans several lines
and what identifies one is spread between its header and its contents, so
finding something means paging through by hand.

Use fzf when PAGER is not set and it is installed, asking it for whole
frames, for the colours to be rendered rather than shown as escape
sequences, and for the most recent frame first:

  fzf --ansi --read0 --tac

PAGER is still honoured when set, and setting it to cat or leaving it
empty still turns the pager off. The choice is shared with the frames
seen so far being handed over while capturing, so both arrive at the same
pager.

Frames are separated only when a pager that reads records is going to
read them, so redirected output and a pager that reads lines are both
left exactly as they were.

Assisted-by: opencode:claude-opus-5
---
 monitor/display.c | 119 ++++++++++++++++++++++++++++++++++++++++++++--
 monitor/display.h |   3 ++
 monitor/find.c    |  20 +++++---
 monitor/find.h    |   2 +-
 monitor/main.c    |   4 +-
 5 files changed, 134 insertions(+), 14 deletions(-)

diff --git a/monitor/display.c b/monitor/display.c
index f8ece0a3a755..a93e3a7d8a8b 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -20,6 +20,8 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
+#include <limits.h>
 #include <signal.h>
 #include <sys/wait.h>
 #include <sys/prctl.h>
@@ -117,6 +119,114 @@ static void wait_for_terminate(pid_t pid)
 	}
 }
 
+/* Look for a command in PATH, so that it can be preferred if present */
+static bool have_command(const char *name)
+{
+	const char *path = getenv("PATH");
+	char *dirs, *dir, *save = NULL;
+	bool found = false;
+
+	if (!path)
+		return false;
+
+	dirs = strdup(path);
+	if (!dirs)
+		return false;
+
+	for (dir = strtok_r(dirs, ":", &save); dir;
+					dir = strtok_r(NULL, ":", &save)) {
+		char file[PATH_MAX];
+
+		if (snprintf(file, sizeof(file), "%s/%s", dir, name) < 0)
+			continue;
+
+		if (!access(file, X_OK)) {
+			found = true;
+			break;
+		}
+	}
+
+	free(dirs);
+
+	return found;
+}
+
+bool pager_disabled(void)
+{
+	const char *pager = getenv("PAGER");
+
+	return pager && (!*pager || !strcmp(pager, "cat"));
+}
+
+/*
+ * What a fuzzy finder needs to make sense of a trace: an entry has to be a
+ * whole frame rather than a line of one, the colours have to be rendered
+ * instead of shown, and the most recent frame is the one usually being
+ * looked for.
+ */
+static const char * const fzf_options[] = {
+	"--ansi",
+	"--read0",
+	"--tac",
+	NULL
+};
+
+#define FZF_COMMAND "fzf --ansi --read0 --tac"
+
+/* Match a whole option, so a longer one starting the same is not it */
+static bool has_option(const char *cmd, const char *opt)
+{
+	size_t len = strlen(opt);
+	const char *p = cmd;
+
+	while ((p = strstr(p, opt))) {
+		char next = p[len];
+
+		if ((p == cmd || isspace(p[-1])) &&
+				(!next || isspace(next) || next == '='))
+			return true;
+
+		p += len;
+	}
+
+	return false;
+}
+
+const char *pager_command(void)
+{
+	static char cmd[512];
+	const char *pager = getenv("PAGER");
+	size_t pos = 0;
+	int i, n;
+
+	if (!pager || !*pager)
+		return have_command("fzf") ? FZF_COMMAND : NULL;
+
+	if (!strstr(pager, "fzf"))
+		return pager;
+
+	n = snprintf(cmd, sizeof(cmd), "%s", pager);
+	if (n < 0 || (size_t)n >= sizeof(cmd))
+		return pager;
+
+	pos = n;
+
+	for (i = 0; fzf_options[i]; i++) {
+		if (has_option(pager, fzf_options[i]))
+			continue;
+
+		n = snprintf(cmd + pos, sizeof(cmd) - pos, " %s",
+							fzf_options[i]);
+		/* Leave it as given rather than pass something truncated */
+		if (n < 0 || (size_t)n >= sizeof(cmd) - pos)
+			return pager;
+
+		pos += n;
+	}
+
+	return cmd;
+}
+
 void open_pager(void)
 {
 	const char *pager;
@@ -126,11 +236,10 @@ void open_pager(void)
 	if (pager_pid > 0)
 		return;
 
-	pager = getenv("PAGER");
-	if (pager) {
-		if (!*pager || strcmp(pager, "cat") == 0)
-			return;
-	}
+	if (pager_disabled())
+		return;
+
+	pager = pager_command();
 
 	if (!(isatty(STDOUT_FILENO) > 0))
 		return;
diff --git a/monitor/display.h b/monitor/display.h
index 93773e651ef1..cad182f77c94 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -135,5 +135,8 @@ static inline void print_hex_field(const char *label, const uint8_t *data,
 void set_default_pager_num_columns(int num_columns);
 int num_columns(void);
 
+bool pager_disabled(void);
+const char *pager_command(void);
+
 void open_pager(void);
 void close_pager(void);
diff --git a/monitor/find.c b/monitor/find.c
index 6536afa054e6..58de96fde58b 100644
--- a/monitor/find.c
+++ b/monitor/find.c
@@ -61,6 +61,7 @@ static bool store;	/* Keep the frames for handing to the pager */
 static bool records;	/* Separate the frames with a NUL */
 static bool printed;	/* Something has been written out already */
 static bool print0;
+static bool use_pager;
 static bool raw_mode;
 static int poll_id = -1;
 static struct termios saved_term;
@@ -347,16 +348,14 @@ static void pager_open(void)
 	const char *pager;
 	int fd;
 
-	if (pager_pid || !num_frames)
+	if (pager_pid || !num_frames || !use_pager || pager_disabled())
 		return;
 
 	fd = frames_to_file();
 	if (fd < 0)
 		return;
 
-	pager = getenv("PAGER");
-	if (pager && (!*pager || !strcmp(pager, "cat")))
-		pager = NULL;
+	pager = pager_command();
 
 	fflush(stdout);
 
@@ -462,13 +461,22 @@ static bool want_records(void)
 	if (print0)
 		return true;
 
-	pager = getenv("PAGER");
+	/*
+	 * Only separate the frames if something is actually going to read
+	 * them as records. Nothing does when the output is redirected or
+	 * the pager has been turned off.
+	 */
+	if (!use_pager || pager_disabled() || !isatty(STDOUT_FILENO))
+		return false;
+
+	pager = pager_command();
 
 	return pager && strstr(pager, "--read0");
 }
 
-void find_setup(bool live)
+void find_setup(bool live, bool pager)
 {
+	use_pager = pager;
 	records = want_records();
 
 	if (live && isatty(STDIN_FILENO) && isatty(STDOUT_FILENO)) {
diff --git a/monitor/find.h b/monitor/find.h
index 3048ab69e4c9..e7dad7aaf25c 100644
--- a/monitor/find.h
+++ b/monitor/find.h
@@ -11,7 +11,7 @@
 #include <stdbool.h>
 
 void find_set_print0(void);
-void find_setup(bool live);
+void find_setup(bool live, bool pager);
 
 void find_frame_begin(void);
 void find_frame_end(void);
diff --git a/monitor/main.c b/monitor/main.c
index 25de945446a9..1a7a25713de1 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -286,7 +286,7 @@ int main(int argc, char *argv[])
 		if (ellisys_server)
 			ellisys_enable(ellisys_server, ellisys_port);
 
-		find_setup(false);
+		find_setup(false, use_pager);
 
 		control_reader(reader_path, use_pager);
 		return EXIT_SUCCESS;
@@ -310,7 +310,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 
 	/* Watch for the key that brings the pager up */
-	find_setup(true);
+	find_setup(true, use_pager);
 
 	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
-- 
2.55.0


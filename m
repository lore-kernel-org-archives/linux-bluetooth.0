Received: from mail-ua2-f41.google.com (mail-ua2-f41.google.com [74.125.226.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724B3AB26E
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677960; cv=none; b=C1XMLKRu54muXXOig2P8arcUQd3SAp/4MZoLGVdQPrO9UyLpI1Q4KLbYljWcp0m6rXJXCHy3LrcsePkKuZ2c4C0rhHjtJQrLDD0lsMKtd/0A2tUiSSXYLzJOEjhy0f1xlbgunBGF0nNrq9PtEIRrUcLOjDC1wCM0OJPycnkHN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677960; c=relaxed/simple;
	bh=yFhLzHrCj2nI2qRtWcN9ORRLXZzKbFNjK8KSpk6IiZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iy6Xb15Qi5GLfWBvOGFMBexuuWfob6vuzpct0jZNWWrRuvmE2SzecukvrP9jrmTPgi5p1JJ97PiE2ePd2shU46Q6xdTJg/TERHF/uKjdFYhUdyikGP2uFBMbRGy8LucmsnoGWKg5zZg0shisXMqiUofq0AIV9fT+YOMN5+SL1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjk7j/RO; arc=none smtp.client-ip=74.125.226.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjk7j/RO"
Received: by mail-ua2-f41.google.com with SMTP id a1e0cc1a2514c-9809f3af20cso2488241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677957; x=1790282757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NDezUfDXOON9mQnYZnKr829vtjugH0QOqymMMaOIpkQ=;
        b=qjk7j/RO49dNn0cL5/XS8FI5qdVTKfuyFjgP074V77L5UFBEFWtOxhv4T/UgyLx2R0
         6zJX0Kk1q6VfgXMqDN5HsK8JGfJe77BjJLUFlGzLdnJBOiNPWt9T59S/Hbtu+9Yimrt0
         e/G+vURSIySfQWmSA5klcdI4DEbtWLRk0PAA2DZmtZ1wB0BGw5NEp7CHjSCwcXxkOgmP
         Gn8RDVskbPvcLNeWcY/e+nJhjKwor6utsEWzYkb8gYeC+JrKN4MleIvSeXrYw56WRA26
         Dx4cXV0H8KXw/hA0IV2vUYU3pa7U1ccRhUSMOqGHRgtbLZe1NJmnQ13xyoPZrN/pF7MN
         unDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677957; x=1790282757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NDezUfDXOON9mQnYZnKr829vtjugH0QOqymMMaOIpkQ=;
        b=YI//lUspr5UqQy2dPe4mkF6W5jKPmZUb2Bbten+4h5a0VLUbK6UFnjuIivqkLIFeen
         9g7EQtmI/GHa1hfOtJByuDOcPv+cUUp9HoDSaoMussYOmqgKLGy9OrtBmotUzPviiM+z
         H9/2jOL/kzUGKExWgZ9ZJMaqi7uWIX19dmzcV7Ocqsvnf6m9OIA1CIpOMJLfZWMiG9Oa
         XwbTutxDAMjxzspLtrLjsmtD9axTseaHj4wuH72Wt0ay1iZPzvdig44hKfrTTthZ/l0T
         onbM0AiTnZjv5QfWeOiy/Wm25udlPE/OTWnxNM/ENLXZDYbBVgAETbudGEpac00pfVj7
         3LgQ==
X-Gm-Message-State: AFuF++mAcEM4ZmvsKlEk6JOAwaBZriom2+qtFs49Vq2VyuPeXdQ6Pk/3
	dhmKQFrn5nSPTqHEwHa6xjkiQlT3QoYFoKtOVZs0IwPBY+jzsdZEKRhZ0Dwl3nKhUtACCQ==
X-Gm-Gg: AYBFou37pnOSRkuKrh8isRyLJfL7X/rSI/XujzO5ye2vN2fNAfGPdO1gLRrWd7/hJLd
	vJeB2co2+nPkQy3XpG6M4sVYrP5y0q7+ZSQi8+Ek2WTaPSYwrJVXZTIT8lb3ZAjW/9EkR19Fi9I
	xfzKLey1FXHlfGQ5sBL2TdHvF0b5flXbeApGg2iUMNMcKaX86K5OrEwCdGhvBJ/tEBwzmvaHaV8
	tV3QCTCiJXNPIcLx93XmmhsFtCQIsBQUVL6IFa7smX/FFlWGTrzuy2rK0ELVe/YrDbnZ9eguQDC
	H1EbJdHxvq3s7T2a5uP9xDXV0BuolD4JRfi9NxsMv9kATG6nfIOMMWCPbQC4J/X9Cg3EjE9f7rS
	rmXc47bY0w9mirUAWUjVh38hratK3sR277hFptMWbw+k6QHyt6GixldBDQWLLyNJH2f8f++wvPD
	fDFHqY1UwirY4em8Lsko2bk6puNTLJO3lOgD5OigE3p01UvL9Vomk2m6AHe96+PEVVbhSoJZq84
	CLBxRwujcxuWVcBDne1N8KRQ0HQ8fVgewER6eQB7z0epT5l3C9ae1wbcB1Dr5eWWQ==
X-Received: by 2002:a05:6102:370c:b0:7a1:f7d2:e80a with SMTP id ada2fe7eead31-7a55c0747e4mr138288137.18.1789677956838;
        Thu, 17 Sep 2026 13:45:56 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1dcea8a67sm4584833137.0.2026.09.17.13.45.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:45:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/6] monitor: Prefer fzf as the pager when one is not set
Date: Thu, 17 Sep 2026 16:45:40 -0400
Message-ID: <20260917204541.2176720-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917204541.2176720-1-luiz.dentz@gmail.com>
References: <20260917204541.2176720-1-luiz.dentz@gmail.com>
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
frames and for the colours to be rendered rather than shown as escape
sequences:

  fzf --ansi --read0

PAGER is still honoured when set, and setting it to cat or leaving it
empty still turns the pager off. The choice is shared with the frames
seen so far being handed over while capturing, so both arrive at the same
pager.

Frames are separated only when a pager that reads records is going to
read them, so redirected output and a pager that reads lines are both
left exactly as they were.

The model wrote this, which the author reviewed and verified by checking
which pager is started for each setting of PAGER, that the colours are
rendered rather than shown, and that redirected output is unchanged.

Assisted-by: opencode:claude-opus-5
---
 monitor/display.c | 73 +++++++++++++++++++++++++++++++++++++++++++----
 monitor/display.h |  3 ++
 monitor/find.c    | 20 +++++++++----
 monitor/find.h    |  2 +-
 monitor/main.c    |  4 +--
 5 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/monitor/display.c b/monitor/display.c
index b540155319a0..8d767e77e464 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -20,6 +20,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <limits.h>
 #include <signal.h>
 #include <sys/wait.h>
 #include <sys/prctl.h>
@@ -117,6 +118,69 @@ static void wait_for_terminate(pid_t pid)
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
+ * A fuzzy finder is a far better fit for a trace than a plain pager, so
+ * prefer it when one is installed and nothing was asked for. Wherever it
+ * is used it is told to take whole frames rather than lines, and to
+ * render the colours instead of showing the escape sequences.
+ */
+const char *pager_command(void)
+{
+	static char cmd[256];
+	const char *pager = getenv("PAGER");
+
+	if (!pager || !*pager)
+		return have_command("fzf") ? "fzf --ansi --read0" : NULL;
+
+	if (!strstr(pager, "fzf"))
+		return pager;
+
+	snprintf(cmd, sizeof(cmd), "%s%s%s", pager,
+			strstr(pager, "--ansi") ? "" : " --ansi",
+			strstr(pager, "--read0") ? "" : " --read0");
+
+	return cmd;
+}
+
 void open_pager(void)
 {
 	const char *pager;
@@ -126,11 +190,10 @@ void open_pager(void)
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
index 32600964faf1..58c4f51d8bfb 100644
--- a/monitor/find.c
+++ b/monitor/find.c
@@ -60,6 +60,7 @@ static bool store;	/* Keep the frames for handing to the pager */
 static bool records;	/* Separate the frames with a NUL */
 static bool printed;	/* Something has been written out already */
 static bool print0;
+static bool use_pager;
 static bool raw_mode;
 static int poll_id = -1;
 static struct termios saved_term;
@@ -312,16 +313,14 @@ static void pager_open(void)
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
 
@@ -427,13 +426,22 @@ static bool want_records(void)
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


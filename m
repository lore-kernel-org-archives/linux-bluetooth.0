Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429F515887
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748072; cv=none; b=DuzV2lmq97GDUrYTRuRva7ChrQtjHysnSjPqOyFQdmQoPF1exK+JhjyEio00O+qdwywzlrxIYdXejJ4r4mAQKtL8BK5IpsVSIV7IduquUIxB5xIadhc+3u7e7ajxCP8RTx/rw+1C+KhDRm/uaRZW2TSCBs5JUbyUauRaEFlbXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748072; c=relaxed/simple;
	bh=X/ri3CAOgL7s5DiIWMNkPZPNRN9v2EcReh4twky7mo8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMV8DsKTLyeVrlEuu2HeV1OcVEkxJSLfQ/XZ4bhK2I/QPiqMNlrdTI2HaOV5fCTPTcrTYySuCfbKzQU/vP9Y8pvf3nTxqLKk7Rx+gaNer64f7vXh2LSMCI3BDnsgf3mz4poC/zIxkgB1tFvThAsDBrIIzx0vBwjWILddTYYh4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUhtzr4c; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUhtzr4c"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78ffc0e2f23so346337137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748068; x=1790352868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f2PhH5uQ5W70kAKcWxF2c/uysdw+AExkVpi1dbX5q3M=;
        b=lUhtzr4c66v9IUcTA7sgpklwV/8OK7/aIz1E4YBAvzE6OtYlXCFdU1iZiMXntNYKD2
         O+CqiKx4XlZ2v0Uq/KvccR48YptCg3Gd4cVyBuKzHSSMkkWGJc5jbS0wGeeTKv49Gix5
         uOciO7yD+5MdshaG3UzHy/l8S8aTEKmTIVtzvnTpuRDClp6ROX6I1xU0BhbktJWlqrqm
         k/cnnmpW8FK9MYSTFZCxXGNVaGlMkbczVrXOzGn844/TlYEPTIKVzaTXeOYC1Ppt44bp
         98e1RdsRMXVP6GTXZfNM/tvghxiU1v1o2qAOXbmcC7hXymcfAIQr4n0taguU84aO+asq
         Km9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748068; x=1790352868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f2PhH5uQ5W70kAKcWxF2c/uysdw+AExkVpi1dbX5q3M=;
        b=INl+LjhYkoGzJD726VnmDXRJhgENU59i9KMdTu4qg7k2hYq9Bav00Ct0iGpHxjEbGs
         8lEwmeyu+AQFdEDOSmqq1EVNZsX5GBsWs6W+E1O70E01haHg+E9DvvFx++JlrOP4MMYw
         ADqDnplBixg21bAuDm6qGHu4gJBnkNFADvlAd6lqMwiI+SCHb3kQt7S5cB6anD/edwkV
         xgU5UchyzTsMCO6xBO29jx47mSBsu9aUsY4r9REvKPG2kMUqFzopO4Te6MQHlr4KaVEL
         Jr0IO6r3YKzoI7UqmszydAPP+AfEAf1FbeBTIcCNZ/PjziJKL7ndvbdgQ/0Eq3IwjObU
         PQKw==
X-Gm-Message-State: AFuF++necZDYNiDmVZbluyn4WwfI5HmSsTro2MectnZtgjO6poU3kHrH
	4hi5I9rI7fqfrUUKIzUKFzeeYst4z9wnJXSQP4rOkirACKoT8ZmsCoWG9htlIQ3T
X-Gm-Gg: AYBFou1gKi5f0OctaqtQgCJo/HRnq0pD34E7RHpcBOe99G1WCQNO1MSUZ8UAC6GB5uw
	fYPWyaq8fJOVHrkZYJQLeaFICreHltVaCXkveN2MEwgYB8zVsYW85nEP+kccW1lQjhJV3bmYvE7
	aM223eg7YjbTjPyS8JJqzJuSEmvuo+DFzd4RlDd5qJyuR7/bXsdtR5sto7g88xnn3uqgX93/jcm
	yjKjcMlEXprA0ebI2fJwl7+FTNlcqwG+uUMhax3UyulXsmGLynCThqVLUNOyD07WCP6wqfT5d3a
	9fyVnfDtXHYu6E3EMYwWhztnVnFuo7LUNNT2iu27SRtsPJaaqleVdzXoG7xdteFR9sa+fFqmZSC
	5jIpR/51Y2eDiCAC4heravPjXv6tXnMLmgE9pgpT6VhcYfiJoA1whS6dBlwzHcYK+grxmTxU3/g
	+8jP0rWW+nv71sGNhak1ZviUo9qOAOl9sP+N10fZRwe4UeRyQ02QZolNjZe6H/52BNPllnT0iWp
	6uPebIIInNqDeb1Yi42XmLBN8Vg128K+QqAUh2K3Xd+guWWUJbMZpA1l03GdFUXCwGrH7anqXM=
X-Received: by 2002:a05:6102:41aa:b0:7a1:f951:f2fd with SMTP id ada2fe7eead31-7a55c8841d8mr1494031137.16.1789748068080;
        Fri, 18 Sep 2026 09:14:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/9] monitor: Hand the captured frames to the pager on Ctrl-R
Date: Fri, 18 Sep 2026 12:14:05 -0400
Message-ID: <20260918161408.2464981-7-luiz.dentz@gmail.com>
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

Looking for something in a running capture means stopping it and reading
back the log, losing whatever would have arrived meanwhile, or scrolling
the terminal by hand while the trace keeps moving.

Collect the frames as they are printed and hand them to the pager on
Ctrl-R, in the manner of the shell. The capture keeps running underneath,
and closing the pager returns to it, printing whatever arrived while it
was up so that the trace on the terminal has no gap.

The capture is never paused for this. Anything not read in time is
dropped by the kernel, so the pager runs on its own and is only checked
for having closed, rather than being waited for.

The frames are handed over as a file rather than through a pipe, so that
filling it cannot block the monitor and cost the capture any packets,
separated as they are elsewhere when the pager is going to read records.

Frames are only collected when the output is a terminal, so a capture
that is piped or redirected behaves exactly as it always has. The
terminal is switched to reading keys as they are typed, but signals are
left enabled so that Ctrl-C still interrupts the capture as before.

A capture runs for as long as it is left running, so the frames are held
in a ring and the oldest are dropped once it is full.

Assisted-by: opencode:claude-opus-5
---
 monitor/find.c | 520 +++++++++++++++++++++++++++++++++++++++++++------
 monitor/find.h |   2 +-
 monitor/main.c |   5 +-
 3 files changed, 463 insertions(+), 64 deletions(-)

diff --git a/monitor/find.c b/monitor/find.c
index 649d722ee197..6536afa054e6 100644
--- a/monitor/find.c
+++ b/monitor/find.c
@@ -17,19 +17,434 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <errno.h>
+#include <termios.h>
+#include <signal.h>
+#include <sys/epoll.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/prctl.h>
 
+#include "src/shared/mainloop.h"
+#include "src/shared/util.h"
 #include "monitor/display.h"
 #include "monitor/find.h"
 
+/*
+ * A capture runs for as long as it is left running, so the oldest frames
+ * are dropped once this many are held rather than letting the monitor be
+ * killed for using too much memory.
+ */
+#define FIND_MAX_FRAMES 200000
+
+/* How often the pager is checked for having been closed */
+#define FIND_POLL_MSEC 100
+
+struct find_frame {
+	char *text;
+	size_t len;
+	uint64_t seq;
+};
+
+/*
+ * The frames are held in a ring, so that the oldest can be dropped once it
+ * is full without having to move the rest.
+ */
+static struct find_frame *frames;
+static unsigned int num_frames;		/* Held right now */
+static unsigned int max_frames;		/* Allocated */
+static unsigned int first_frame;	/* Oldest, within the ring */
+static uint64_t next_seq;
+
 static bool enabled;
+static bool store;	/* Keep the frames for handing to the pager */
 static bool records;	/* Separate the frames with a NUL */
 static bool printed;	/* Something has been written out already */
 static bool print0;
+static bool raw_mode;
+static int poll_id = -1;
+static struct termios saved_term;
+
+static pid_t pager_pid;
+static int saved_stdout = -1;
+static uint64_t pager_seq;	/* Frames from here are yet to be printed */
 
 static char *capture_buf;
 static size_t capture_len;
 static FILE *capture;
 
+static struct find_frame *frame_at(unsigned int n)
+{
+	return &frames[(first_frame + n) % max_frames];
+}
+
+static void frame_free(struct find_frame *frame)
+{
+	free(frame->text);
+	memset(frame, 0, sizeof(*frame));
+}
+
+/* Make room for one more frame, dropping the oldest once the ring is full */
+static struct find_frame *frame_next(void)
+{
+	struct find_frame *frame;
+
+	if (num_frames == FIND_MAX_FRAMES) {
+		frame = &frames[first_frame];
+		frame_free(frame);
+		first_frame = (first_frame + 1) % max_frames;
+		return frame;
+	}
+
+	if (num_frames == max_frames) {
+		unsigned int size = max_frames ? max_frames * 2 : 1024;
+		void *tmp;
+
+		if (size > FIND_MAX_FRAMES)
+			size = FIND_MAX_FRAMES;
+
+		tmp = realloc(frames, size * sizeof(*frames));
+		if (!tmp)
+			return NULL;
+
+		frames = tmp;
+		max_frames = size;
+	}
+
+	frame = &frames[(first_frame + num_frames) % max_frames];
+	num_frames++;
+
+	return frame;
+}
+
+void find_frame_begin(void)
+{
+	if (!enabled)
+		return;
+
+	capture_buf = NULL;
+	capture_len = 0;
+
+	capture = open_memstream(&capture_buf, &capture_len);
+	if (!capture)
+		return;
+
+	display_set_output(capture);
+}
+
+void find_frame_end(void)
+{
+	struct find_frame *frame;
+
+	if (!enabled || !capture)
+		return;
+
+	display_set_output(NULL);
+	fclose(capture);
+	capture = NULL;
+
+	/* A frame that was filtered out produces no output */
+	if (!capture_len) {
+		free(capture_buf);
+		capture_buf = NULL;
+		return;
+	}
+
+	/*
+	 * Keep the trace on the terminal while the pager is not up. What
+	 * arrives while it is up is printed once it closes, so that the
+	 * trace on the terminal has no gap.
+	 */
+	if (!pager_pid) {
+		const char nul = '\0';
+		size_t len = capture_len;
+
+		/*
+		 * Only what is read as records is written as records. While
+		 * capturing this is the trace on the terminal, which keeps
+		 * its newlines or the next frame carries on the same line.
+		 * The pager is given its own copy.
+		 */
+		if (records && !store) {
+			/*
+			 * The newline ending the frame is what separates
+			 * the lines within it, so leave it out of a record
+			 * or it shows as a blank line at the end of the
+			 * entry.
+			 */
+			if (len && capture_buf[len - 1] == '\n')
+				len--;
+
+			if (printed)
+				fwrite(&nul, 1, 1, stdout);
+		}
+
+		fwrite(capture_buf, 1, len, stdout);
+		fflush(stdout);
+		printed = true;
+	}
+
+	if (!store) {
+		free(capture_buf);
+		capture_buf = NULL;
+		return;
+	}
+
+	frame = frame_next();
+	if (!frame) {
+		free(capture_buf);
+		capture_buf = NULL;
+		return;
+	}
+
+	frame->text = capture_buf;
+	frame->len = capture_len;
+	frame->seq = next_seq++;
+	capture_buf = NULL;
+}
+
+static void term_restore(void);
+
+/*
+ * Leaving the terminal not echoing what is typed would make the shell
+ * unusable, so put it back however the monitor happens to be leaving.
+ * tcsetattr() may be called from a signal handler.
+ */
+static void fatal_signal(int sig)
+{
+	term_restore();
+
+	signal(sig, SIG_DFL);
+	raise(sig);
+}
+
+static void term_hooks(void)
+{
+	static const int fatal[] = { SIGSEGV, SIGBUS, SIGABRT, SIGQUIT,
+								SIGHUP };
+	struct sigaction sa;
+	unsigned int i;
+
+	atexit(term_restore);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = fatal_signal;
+	sa.sa_flags = SA_RESETHAND;
+
+	for (i = 0; i < ARRAY_SIZE(fatal); i++)
+		sigaction(fatal[i], &sa, NULL);
+}
+
+/*
+ * Read the keys as they are typed rather than a line at a time. Signals are
+ * left enabled so that Ctrl-C still interrupts the capture as it always has.
+ */
+static void term_raw(void)
+{
+	struct termios term;
+
+	if (raw_mode)
+		return;
+
+	if (tcgetattr(STDIN_FILENO, &saved_term) < 0)
+		return;
+
+	term = saved_term;
+	term.c_lflag &= ~(ICANON | ECHO);
+	term.c_cc[VMIN] = 1;
+	term.c_cc[VTIME] = 0;
+
+	if (tcsetattr(STDIN_FILENO, TCSANOW, &term) < 0)
+		return;
+
+	raw_mode = true;
+
+	term_hooks();
+}
+
+static void term_restore(void)
+{
+	if (!raw_mode)
+		return;
+
+	tcsetattr(STDIN_FILENO, TCSANOW, &saved_term);
+	raw_mode = false;
+}
+
+/*
+ * Hand the frames over as a file rather than through a pipe, so that
+ * filling it cannot block the monitor and cost the capture any packets.
+ * They are separated by a NUL so that a pager able to take records, such
+ * as fzf with --read0, sees a whole frame as one entry instead of matching
+ * the individual lines within it.
+ */
+static int frames_to_file(void)
+{
+	unsigned int i;
+	int fd;
+
+	fd = memfd_create("btmon-frames", MFD_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	for (i = 0; i < num_frames; i++) {
+		const struct find_frame *frame = frame_at(i);
+		const char nul = '\0';
+		size_t len = frame->len;
+
+		if (records) {
+			if (i && write(fd, &nul, 1) < 0)
+				break;
+
+			/* Leave out the newline ending the frame */
+			if (len && frame->text[len - 1] == '\n')
+				len--;
+		}
+
+		if (write(fd, frame->text, len) < 0)
+			break;
+	}
+
+	if (lseek(fd, 0, SEEK_SET) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static void pager_close(void)
+{
+	unsigned int i;
+
+	if (!pager_pid)
+		return;
+
+	pager_pid = 0;
+
+	/* Put the monitor back in charge of the terminal */
+	if (saved_stdout >= 0) {
+		dup2(saved_stdout, STDOUT_FILENO);
+		close(saved_stdout);
+		saved_stdout = -1;
+	}
+
+	term_raw();
+
+	/* Print whatever arrived while the pager was up */
+	for (i = 0; i < num_frames; i++) {
+		const struct find_frame *frame = frame_at(i);
+
+		if (frame->seq >= pager_seq)
+			fwrite(frame->text, 1, frame->len, stdout);
+	}
+
+	fflush(stdout);
+}
+
+static void pager_open(void)
+{
+	const char *pager;
+	int fd;
+
+	if (pager_pid || !num_frames)
+		return;
+
+	fd = frames_to_file();
+	if (fd < 0)
+		return;
+
+	pager = getenv("PAGER");
+	if (pager && (!*pager || !strcmp(pager, "cat")))
+		pager = NULL;
+
+	fflush(stdout);
+
+	/* The pager reads the terminal from here on */
+	term_restore();
+	mainloop_remove_fd(STDIN_FILENO);
+
+	saved_stdout = dup(STDOUT_FILENO);
+
+	pager_pid = fork();
+	if (pager_pid < 0) {
+		pager_pid = 0;
+		close(fd);
+		close(saved_stdout);
+		saved_stdout = -1;
+		term_raw();
+		return;
+	}
+
+	if (!pager_pid) {
+		dup2(fd, STDIN_FILENO);
+		close(fd);
+
+		if (prctl(PR_SET_PDEATHSIG, SIGTERM) < 0)
+			_exit(EXIT_FAILURE);
+
+		if (pager) {
+			execlp(pager, pager, NULL);
+			execl("/bin/sh", "sh", "-c", pager, NULL);
+		}
+
+		execlp("pager", "pager", NULL);
+		execlp("less", "less", NULL);
+		execlp("more", "more", NULL);
+
+		_exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+
+	pager_seq = next_seq;
+}
+
+static void key_callback(int fd, uint32_t events, void *user_data)
+{
+	char buf[32];
+	ssize_t len, i;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_quit();
+		return;
+	}
+
+	len = read(STDIN_FILENO, buf, sizeof(buf));
+	if (len <= 0)
+		return;
+
+	/*
+	 * Anything else typed at a running capture is left alone, so that
+	 * the terminal behaves as it did before.
+	 */
+	for (i = 0; i < len; i++) {
+		if (buf[i] == 0x12) {	/* Ctrl-R */
+			pager_open();
+			return;
+		}
+	}
+}
+
+static void arm_keys(void)
+{
+	mainloop_add_fd(STDIN_FILENO, EPOLLIN, key_callback, NULL, NULL);
+}
+
+/*
+ * The pager runs on its own so that the monitor keeps draining the socket
+ * while it is up, as anything not read in time is dropped by the kernel.
+ */
+static void poll_callback(int id, void *user_data)
+{
+	if (pager_pid && waitpid(pager_pid, NULL, WNOHANG) == pager_pid) {
+		pager_close();
+		arm_keys();
+	}
+
+	mainloop_modify_timeout(id, FIND_POLL_MSEC);
+}
+
 void find_set_print0(void)
 {
 	print0 = true;
@@ -52,77 +467,60 @@ static bool want_records(void)
 	return pager && strstr(pager, "--read0");
 }
 
-void find_setup(void)
+void find_setup(bool live)
 {
 	records = want_records();
 
+	if (live && isatty(STDIN_FILENO) && isatty(STDOUT_FILENO)) {
+		enabled = true;
+		store = true;
+
+		term_raw();
+		arm_keys();
+
+		poll_id = mainloop_add_timeout(FIND_POLL_MSEC, poll_callback,
+								NULL, NULL);
+		return;
+	}
+
 	/*
-	 * Nothing is kept, but the output still has to be seen to know
-	 * where one frame ends and the next begins.
+	 * Nothing is kept when only the separators are wanted, but the
+	 * output still has to be seen to know where a frame ends.
 	 */
 	if (records)
 		enabled = true;
 }
 
-void find_frame_begin(void)
-{
-	if (!enabled)
-		return;
-
-	capture_buf = NULL;
-	capture_len = 0;
-
-	capture = open_memstream(&capture_buf, &capture_len);
-	if (!capture)
-		return;
-
-	display_set_output(capture);
-}
-
-void find_frame_end(void)
-{
-	if (!enabled || !capture)
-		return;
-
-	display_set_output(NULL);
-	fclose(capture);
-	capture = NULL;
-
-	/* A frame that was filtered out produces no output */
-	if (!capture_len) {
-		free(capture_buf);
-		capture_buf = NULL;
-		return;
-	}
-
-	if (records) {
-		const char nul = '\0';
-		size_t len = capture_len;
-
-		/*
-		 * The newline ending the frame is what separates the lines
-		 * within it, so leave it out of a record or it shows as a
-		 * blank line at the end of the entry.
-		 */
-		if (len && capture_buf[len - 1] == '\n')
-			len--;
-
-		if (printed)
-			fwrite(&nul, 1, 1, stdout);
-
-		fwrite(capture_buf, 1, len, stdout);
-	} else {
-		fwrite(capture_buf, 1, capture_len, stdout);
-	}
-
-	fflush(stdout);
-	printed = true;
-
-	free(capture_buf);
-	capture_buf = NULL;
-}
-
 void find_cleanup(void)
 {
+	unsigned int i;
+
+	if (pager_pid) {
+		kill(pager_pid, SIGTERM);
+		waitpid(pager_pid, NULL, 0);
+		pager_pid = 0;
+	}
+
+	if (saved_stdout >= 0) {
+		dup2(saved_stdout, STDOUT_FILENO);
+		close(saved_stdout);
+		saved_stdout = -1;
+	}
+
+	term_restore();
+
+	if (poll_id >= 0) {
+		mainloop_remove_timeout(poll_id);
+		poll_id = -1;
+	}
+
+	for (i = 0; i < num_frames; i++)
+		frame_free(frame_at(i));
+
+	free(frames);
+	frames = NULL;
+	num_frames = 0;
+	max_frames = 0;
+	first_frame = 0;
 	enabled = false;
 }
diff --git a/monitor/find.h b/monitor/find.h
index c6b2036ba3a6..3048ab69e4c9 100644
--- a/monitor/find.h
+++ b/monitor/find.h
@@ -11,7 +11,7 @@
 #include <stdbool.h>
 
 void find_set_print0(void);
-void find_setup(void);
+void find_setup(bool live);
 
 void find_frame_begin(void);
 void find_frame_end(void);
diff --git a/monitor/main.c b/monitor/main.c
index ce7bae7f5cae..25de945446a9 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -286,7 +286,7 @@ int main(int argc, char *argv[])
 		if (ellisys_server)
 			ellisys_enable(ellisys_server, ellisys_port);
 
-		find_setup();
+		find_setup(false);
 
 		control_reader(reader_path, use_pager);
 		return EXIT_SUCCESS;
@@ -309,7 +309,8 @@ int main(int argc, char *argv[])
 	if (jlink && control_rtt(jlink, rtt) < 0)
 		return EXIT_FAILURE;
 
-	find_setup();
+	/* Watch for the key that brings the pager up */
+	find_setup(true);
 
 	exit_status = mainloop_run_with_signal(signal_callback, NULL);
 
-- 
2.55.0


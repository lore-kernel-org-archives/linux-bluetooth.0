Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DB38F65B
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677958; cv=none; b=cM63ST3YhLJnI742gxyyX8B+r224ZVVafaJYQRMPrGVMKAvwI2S5ih94LVEJMRMAcpmSx4cxs3mFrNAPl1yj0RRT/iMhak0FEvnwvyolzOpm1O9dX7J90MQs8CD45hETRZlzhuAnVz+4fjigUq3Gok4TD78ZeN48wjr/Y97aAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677958; c=relaxed/simple;
	bh=d9ok8sgbhroF4ZpslVW9jDDuXqHJDA4NUUbIHM5t55w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdOIcm646bZMFYik7QTjFCfoZGQwRyOKX/oetsu8EZXEFNb2D5YCn0PSCoZP6cV3lE9CkLkqQnjHCRC2lM6i7SxyDv/xffdYjMQPusm914C54A4hUMXi0h6/eMsPEq+gnLCDISQXJ5CUO8R5It7cjN4KtmFCXv0MylGgsmWjHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjkdC/4c; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjkdC/4c"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-785692e59a4so39374137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677955; x=1790282755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UceWGS2HIgXIrwvBkBXBlsVgY1IL8nC2X37/yjozcNc=;
        b=cjkdC/4czn1kexzXXLPFpIUld5lDsaKXSZijiztJohXkf/XmC30BFjz7WWKloV013E
         cNllpbogW12GemCUGW9DXrMSZqz7s49Hx1qaCVjbK8UVAKJh7NpP2Q9yWgzTd8rAlZEb
         +1688syrz9basGQpOPGqsEEilh9T4pIrQf+i8or82oOqEotnXI7x5fThnu14NiEGy2nw
         qw86VlOsd2NtQawg6FwR1uPlXY5bN1bapNAcZTm9YNjMsX82CWMqY5ow+q0Guv7iFeYb
         0Qc9PYRJAnMQF2ImoYnkKfZWexWFt/gcgflDtb9P2FkLwxgeKar7dbPihhtp8ynNChI+
         OYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677955; x=1790282755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UceWGS2HIgXIrwvBkBXBlsVgY1IL8nC2X37/yjozcNc=;
        b=ywn6aFDsTWjFDVbfs69ZHh45jVzGE7hrnFVIm9kPIgndarB49luailUWbuCDa4UV4A
         RA+N8xDyimAC1xkC5eNC+MpkAYlpF8gAPossez1gHDZuYC8SZGKiFV3OkRzwgb5L0+pX
         eHlmRzdDynG4YemVMTtfPP1saOjcT1HV/S5OwwV2fn9UiH7fDJgBIAjjoMkN7mj1zB4t
         mGNmNHnYP4xqpNoxeC28uq/USXj1ikeey2yuwkiqq7y/a/SM9ZUbG0UZAX72v1qK3AIM
         lIX+8akA7g6vcNHzakoj6BVkXplJNq2Ltgeq+b2YedvoCxb4dDQDeDZT9euW4njvdABa
         KONQ==
X-Gm-Message-State: AFuF++knFXIME61O6s+LZ/sQ2hdyIeg83bR0EijTw92B9/0YavrvNvM7
	uKv4UM4X2vEZnXYPfqYb1vD58jttkaVqVP8C3UrVhh134pZGeghhQsyVSdT8WPt+S0qCAg==
X-Gm-Gg: AYBFou2qNqoQuiV/IQPUo3WCxFJkv90r5uoikTadSWUn9gUGisrYleLRO0PyKf5E1qf
	oYj3bu8Sa4cpUpqEQ+U77auj2bzwU6YgUsA09bJwVDD0CHdG91r0CyWmh88CXE1rEgmTRsHXV/v
	ZdoQj4wd6HPPFVuYhsVu+vJb+lm7M8Lh+BwiIxqyvTQAoaCJnFk4I6iCYglwibYziINLl9S5Xu+
	AML93b26niIDaU6b3GZdjadp9mO6iUJg7vSA1ZsfRBNCW315loIqC1cvQXTIBARCGvQ+aQ72y9u
	ubAmRNTmX2xoZVVuEGWU+tG4XelAJ9ofNFRvtoawWuWmzrbUtZvfWI+4AhzAiJNMSQbXIvhprap
	ieV7TcRXx7ccb+DWy5lhB/QN0xRNau2fFNJaqlEFlia6UorAOTo/lgb6XEuV0gMdRRFUuJsAQK+
	DMbmMEp2srtZrXoJfQjX7nko3HwsK7xQceh+NlmDee2zHn3q7LZ+9oABvbxczMeutkU1SIR1uFX
	zYNkvsn5ZmwD1RB5thf21XvYdNR2o3q8+9eKcKDXu9i8uEdTn5olWHs1ZKFAv4n8A==
X-Received: by 2002:a05:6102:b11:b0:7a1:f951:664b with SMTP id ada2fe7eead31-7a55c888b37mr170636137.18.1789677954981;
        Thu, 17 Sep 2026 13:45:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1dcea8a67sm4584833137.0.2026.09.17.13.45.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:45:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/6] monitor: Hand the captured frames to the pager on Ctrl-R
Date: Thu, 17 Sep 2026 16:45:38 -0400
Message-ID: <20260917204541.2176720-4-luiz.dentz@gmail.com>
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

The model wrote this, which the author reviewed and verified against a
capture fed through a terminal, covering the printing before and after,
the capture continuing to be collected while the pager was up, the
frames arriving then being printed on close, and a piped capture being
left alone.

Assisted-by: opencode:claude-opus-5
---
 monitor/find.c | 485 ++++++++++++++++++++++++++++++++++++++++++-------
 monitor/find.h |   2 +-
 monitor/main.c |   5 +-
 3 files changed, 428 insertions(+), 64 deletions(-)

diff --git a/monitor/find.c b/monitor/find.c
index 649d722ee197..32600964faf1 100644
--- a/monitor/find.c
+++ b/monitor/find.c
@@ -17,19 +17,399 @@
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
@@ -52,77 +432,60 @@ static bool want_records(void)
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


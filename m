Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684047;
	b=uEPwCVlhQDB+vb/GqF927dcWPWBEfvbh3036yzMKDtj+pyFw0q1+f8Dgid1mATzd+nw7
	 7cIkbws86bGPNKMNLRKwRC4NUl3BA6d8Luay1abId01hE/uNiypauL2bllDGv1Y7ryZYk
	 jk6q/YwnEXN24jLmTJO1E4jTI3baRVhxV8IHX5dEDI0yD8b2kD79FlUwzqBgjIs+iV0SJ
	 0ZxZlcp8O26mCGtb87q9b4fBue9WZWNO+zBLLdJhXwXFh55y/0eR2SWiPhWt8Jm6nsAbj
	 OfeatCa5GRfTRVReolH2QzO6oTaotL7clWibxrW4ewydrRE6PoRKG4qOFLFAT+iBSoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B/IX0rqZts1ZTtLfQCKn+KFvruKQYuVb9jrBCEV1hr8=;
	b=crip2DcWGsZBPdNZHf0TkVCnGrcxpQt9ShJRF9sr4bPW0LlyXa6Z/uCA1abxoO40gZY5
	 GF4Dmkb8O+sz21K8QDLvXuEhi9JHk1KlUerKKcfV+KWAqpCo7SO6E/LRJE3e8knhfNVfi
	 fyjX7k91JopcUIzvvgtuF8cmfODVAmw//Cmi1FF8Dblg5kqDdYiolKa7JJl+v7AhUvUO2
	 pMCtHlsw55uEeRAiIPmaC5dGql6md5IF/geIvNsx2Uq+N1DUllbiubfYe+j2mAHj9jcIv
	 RZ1WZQ9SukpkOjh4iX9k6DR+OTUembftHL/od9feYPsanhNbSMWsdD00ZLkHRXaPrwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SgVeVWpr;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F28606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0F28606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SgVeVWpr
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eae12762c9so9078e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684045; x=1793288845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B/IX0rqZts1ZTtLfQCKn+KFvruKQYuVb9jrBCEV1hr8=;
        b=SgVeVWpr0q5Fr8XUhY75QM5YZafM0juD6YRdAS6RVTNMM8hEja7fa0ARXAhh8gtiE6
         s1cyILIyilM8SAv2vrWG0Ol+8z/EXsbTJ/dGwQyGw2uE0VMSd/QDi2SDaEKYgFQqC5Wn
         zqolGuIbCXbyWdQiECpF5/MLnlYUxa0QdDEcPNs+oCvKEaxzpZCIIZI7CWZvtz9pWU/T
         Hreeq5Y2cLRVFqEu/c/D77Gh/rR+9iFPxYqE38saebQ9XHl/TxZfFu1ScHyxrZSUDzMB
         8OmttCtWZW6pT4YQANyoYXr7pJSemdaoNF57LT28PZTUTfvRq3+SHJq2pPg7mM9frERU
         Hftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684045; x=1793288845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B/IX0rqZts1ZTtLfQCKn+KFvruKQYuVb9jrBCEV1hr8=;
        b=GW04pZ+KMj94dasL+cpFl4U5zZ1oygcMt2lb00pdZ7rZP0KvZHeeLl11haq3kmKQOG
         EJ9nm6PMuq7BglNIIMpK+RcG3cTIV7fOufUfDJ8YpLuudjVpGHFb6/zwYcc/3HY0Py9m
         qftJkIh2ixntsBqQEE7xn+wlmde1HJkoKvsshGUHIfsT8pwI0JmEPPEaL63w40iXmHEl
         +aVGa7f4oS/aCeFx33HnMayO4SzxpAOw+k1agZWKoK1F+uztLkWaTNA+S1v7Nu3J7W/7
         U4ZMLLps2YcghxQP/uK2oME75bpEa0HcNMVB1+Tm/QeqOg0eVlho9XHqy/nkTS/S/s3K
         7/+w==
X-Gm-Message-State: AFq9FYIZyegVovTQfcv8w80ubcqxw0OzLjkm7r2MpDWHhpYmBp+iAB6C
	9WWn1ty335j14fQob+KYKVS7whBtrxeBNKtwXCK1qE7UlL7Z21D11N2760StsctfmPs=
X-Gm-Gg: AYBFou2VbBfBBuWwrUgPFPe8t1antZDc9TAet6mTtOtNQ8TWWITMKPc29vOzaMtoYYI
	sRgxeMBGPNOs5VguBuESepYA5118KqIaBXqfEyfEkweEC10ztLjUimSGRSZCE2i6DuvWrQ/BhF+
	Lvw6ifPOzhBHm4wxpUx8rBKEwhP4pqiWN4P1vfqHjQVD+ChGQFMoi875AJv4umTYyfbOHIV3AZx
	V4mnVgAPzo1wfqsK1BivcTGxt49ONcFOSylpgdKBPGFyEShUBOElibZzoa2Kcd+9VY+pibaGEjG
	x7XB1qbh7RFuaJcgMZMQ72YnTXioMhBxFNWVwb9oe/hewHNsXASDuVdsWbeae/lT+3dOGJaPCVS
	oQJ3PzwR/RUY3S+l5g5wm8EmhXfEJsMEgLE1IGU4/CC6VqsXFAkAUWtSBtAew9YMLn7i5Z2929N
	Vd5BgHLG9GkkzY+7B6PXiOHUFKeyI2zHvbDC7SVEXkvVoJf4VrPf3HsTWZNWxUylQqNAwILV/Oj
	pdjuMRAFPTyn17LxiPg2UeJST4cVcUiRpQEmXJPWheNw8ZlN9imtNHpK72AVDytTo0UsbrUGHuI
	SjLPaJ79Eo9ahwk7HfFlIUuewuZ1OMUnlpOlkqD/EQgTfQ==
X-Received: by 2002:a05:6122:1354:b0:5ea:a0f0:192f with SMTP id 71dfb90a1353d-5eaebde6b10mr2134738e0c.10.1792684045492;
        Thu, 22 Oct 2026 08:47:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 17/27] shared/mainloop: Add idle callbacks
Date: Thu, 22 Oct 2026 11:46:50 -0400
Message-ID: <20261022154701.3959500-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add mainloop_add_idle(), whose callback runs once no file descriptor is
ready, after everything pending was handled, as GLib's idle sources do.
It is armed again with mainloop_modify_timeout() with 0 and removed with
mainloop_remove_timeout(), its id being above the file descriptors.

A timeout of 0 cannot be used for this: mainloop_add_timeout() leaves it
disarmed, and a short timer would run before pending events.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/mainloop-ell.c  |   6 ++
 src/shared/mainloop-glib.c |   6 ++
 src/shared/mainloop.c      | 156 ++++++++++++++++++++++++++++++++++++-
 src/shared/mainloop.h      |   2 +
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/src/shared/mainloop-ell.c b/src/shared/mainloop-ell.c
index 1aec7fad9e96..1dda9c9ef761 100644
--- a/src/shared/mainloop-ell.c
+++ b/src/shared/mainloop-ell.c
@@ -100,6 +100,12 @@ int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
 	return -ENOSYS;
 }
 
+int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy)
+{
+	return -EOPNOTSUPP;
+}
+
 int mainloop_modify_timeout(int fd, unsigned int msec)
 {
 	return -ENOSYS;
diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 042119baf1ad..971562610e02 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -94,6 +94,12 @@ int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
 	return -ENOSYS;
 }
 
+int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy)
+{
+	return -EOPNOTSUPP;
+}
+
 int mainloop_modify_timeout(int fd, unsigned int msec)
 {
 	return -ENOSYS;
diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index b3ec0f2b1773..652436be944d 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -19,6 +19,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <stddef.h>
+#include <stdbool.h>
 #include <string.h>
 #include <signal.h>
 #include <sys/signalfd.h>
@@ -88,6 +89,10 @@ void mainloop_exit_failure(void)
 	epoll_terminate = 1;
 }
 
+static bool idle_pending(void);
+static void run_idles(void);
+static void remove_all_idles(void);
+
 int mainloop_run(void)
 {
 	unsigned int i;
@@ -96,10 +101,16 @@ int mainloop_run(void)
 		struct epoll_event events[MAX_EPOLL_EVENTS];
 		int n, nfds;
 
-		nfds = epoll_wait(epoll_fd, events, MAX_EPOLL_EVENTS, -1);
+		nfds = epoll_wait(epoll_fd, events, MAX_EPOLL_EVENTS,
+						idle_pending() ? 0 : -1);
 		if (nfds < 0)
 			continue;
 
+		if (!nfds) {
+			run_idles();
+			continue;
+		}
+
 		for (n = 0; n < nfds; n++) {
 			uint64_t id = events[n].data.u64;
 			int fd = id % MAX_MAINLOOP_ENTRIES;
@@ -129,6 +140,8 @@ int mainloop_run(void)
 		}
 	}
 
+	remove_all_idles();
+
 	close(epoll_fd);
 	epoll_fd = 0;
 
@@ -309,8 +322,138 @@ int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
 	return data->fd;
 }
 
+/* Idle callbacks run when no file descriptor is ready, after everything
+ * pending was handled, as with GLib. Their ids are above the file
+ * descriptors, so the timeout functions tell them apart.
+ */
+#define IDLE_ID_BASE 0x10000
+
+struct idle_data {
+	int id;
+	bool armed;
+	bool removed;
+	mainloop_timeout_func callback;
+	mainloop_destroy_func destroy;
+	void *user_data;
+	struct idle_data *next;
+};
+
+static struct idle_data *idle_list;
+static int idle_next_id = IDLE_ID_BASE;
+
+static struct idle_data *find_idle(int id)
+{
+	struct idle_data *idle;
+
+	for (idle = idle_list; idle; idle = idle->next) {
+		if (idle->id == id && !idle->removed)
+			return idle;
+	}
+
+	return NULL;
+}
+
+static bool idle_pending(void)
+{
+	struct idle_data *idle;
+
+	for (idle = idle_list; idle; idle = idle->next) {
+		if (idle->armed && !idle->removed)
+			return true;
+	}
+
+	return false;
+}
+
+static void free_removed_idles(void)
+{
+	struct idle_data **prev = &idle_list;
+
+	while (*prev) {
+		struct idle_data *idle = *prev;
+
+		if (!idle->removed) {
+			prev = &idle->next;
+			continue;
+		}
+
+		*prev = idle->next;
+
+		if (idle->destroy)
+			idle->destroy(idle->user_data);
+
+		free(idle);
+	}
+}
+
+static void remove_all_idles(void)
+{
+	struct idle_data *idle;
+
+	for (idle = idle_list; idle; idle = idle->next)
+		idle->removed = true;
+
+	free_removed_idles();
+}
+
+/* Run the idle callbacks armed before this pass, once each */
+static void run_idles(void)
+{
+	struct idle_data *idle;
+	int last = idle_next_id;
+
+	for (idle = idle_list; idle; idle = idle->next) {
+		if (idle->removed || !idle->armed || idle->id >= last)
+			continue;
+
+		idle->armed = false;
+		idle->callback(idle->id, idle->user_data);
+	}
+
+	free_removed_idles();
+}
+
+/* Run callback once the mainloop is idle, again after
+ * mainloop_modify_timeout() with 0; removed with mainloop_remove_timeout().
+ */
+int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy)
+{
+	struct idle_data *idle, **last;
+
+	if (!callback)
+		return -EINVAL;
+
+	idle = malloc(sizeof(*idle));
+	if (!idle)
+		return -ENOMEM;
+
+	memset(idle, 0, sizeof(*idle));
+	idle->id = idle_next_id++;
+	idle->armed = true;
+	idle->callback = callback;
+	idle->destroy = destroy;
+	idle->user_data = user_data;
+
+	for (last = &idle_list; *last; last = &(*last)->next)
+		;
+	*last = idle;
+
+	return idle->id;
+}
+
 int mainloop_modify_timeout(int id, unsigned int msec)
 {
+	if (id >= IDLE_ID_BASE) {
+		struct idle_data *idle = find_idle(id);
+
+		if (!idle)
+			return -ENOENT;
+
+		idle->armed = true;
+		return 0;
+	}
+
 	if (msec > 0) {
 		if (timeout_set(id, msec) < 0)
 			return -EIO;
@@ -324,5 +467,16 @@ int mainloop_modify_timeout(int id, unsigned int msec)
 
 int mainloop_remove_timeout(int id)
 {
+	if (id >= IDLE_ID_BASE) {
+		struct idle_data *idle = find_idle(id);
+
+		if (!idle)
+			return -ENOENT;
+
+		/* Freed after the current pass, which may be running it */
+		idle->removed = true;
+		return 0;
+	}
+
 	return mainloop_remove_fd(id);
 }
diff --git a/src/shared/mainloop.h b/src/shared/mainloop.h
index fb02dd34109b..2dd07ce03818 100644
--- a/src/shared/mainloop.h
+++ b/src/shared/mainloop.h
@@ -33,6 +33,8 @@ int mainloop_remove_fd(int fd);
 int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
 				void *user_data, mainloop_destroy_func destroy);
 int mainloop_modify_timeout(int fd, unsigned int msec);
+int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy);
 int mainloop_remove_timeout(int id);
 
 int mainloop_set_signal(sigset_t *mask, mainloop_signal_func callback,
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684051;
	b=fCCK0a4oAw8DJ0H8RPM3QFCryhy89/ICxhJB4AdM6SamAoaakjTGoaAGn0uFHut5Reg8
	 ozYx4N1LiraR42SaMRB2CWbjmYVnEodC+g/9Vkdf7rCYYU1tj535ItJoV2rKTqQPaY8/q
	 0OrWaVp0z6qOKyDIHzS0vTCE66GXAgrJ3SWr8QDOoI8cAYrTr3uyjyKD9r77HQcNdcMSJ
	 aGcnlwHD6hUwXDV8sLIJGzCZQBM46klpIS8bj/pkt56/GhA50ri1rv9o4pfqSDXM2bLVb
	 v5fYrc4NyUQ6Nlb1OtXTlNbtPLHuScBKa70F5mUSJQaIZsEqTNNsyOeVF+gzBKlV9Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uUOU0pgpxjzd6Tbr0QOQdULFVUtXUjk5PcQ0l2+cu7Q=;
	b=myaUZLQTG1A9+kqAeBIr5ig4yxjqvpDHTJMrHZDTjY90dOYGpenfnxqK1dfyGjiBYOds
	 Oi5oGglP3tbG9/ZiS/0JX/oPbeCtSSF7jOs3pXGqRZJoCVKhDHjQJC0Wv+iGt4R5zY8ya
	 Xu3aqgXBcdEErRB7k4C9D8YWuMpsc0KF3h6XBjbAFx2vcUnU7eaqVTUJpBmWxgTqHJcM0
	 Hn6Dty3WbLbLqj8l31i1TY4kEQTeCTAKt9c/ZvIO4qx9HjFcFwxdYATZfG8xEFsQw0Z74
	 KTceUoI30QTh13hRVTYZmDIZqfJYyl7jGQ48Uf440iWVPwEUiJCbAbfncmGvpyN/YsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C8DaaAHB;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC4606A324
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDAC4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C8DaaAHB
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-990703f817fso3634241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684050; x=1793288850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uUOU0pgpxjzd6Tbr0QOQdULFVUtXUjk5PcQ0l2+cu7Q=;
        b=C8DaaAHB1k9n3tVjHrEQLnGWznGUMPnbyUbaEmGhzS0F8ykgz9f+Y59n5OmRk3bXZD
         y/rCWVW692W3NP2vhHNL8RhyvXGvEBL2twqVBq/RrCVIQrwQmK/nsAtpoddfTbYNlJFV
         4F0XOX3Wqb17hrX1sWk+Tdtc+kg9LwtA6WvxgX0dpAgjYD6VzKwLO5dSsYnVHY+eCB1/
         WAbbp6oQSTNgzB4+iYAiSOv3JiQXPRwsuBTlkRlm8KAeutIZakHYvFofX13UXl/X5u9K
         QVlNlryDPEB5BMH1g4xDJLyCsjkWbyGWja9GgoSn5XDBosw5Lzmry7BefKbmq4omi4XX
         Kr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684050; x=1793288850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uUOU0pgpxjzd6Tbr0QOQdULFVUtXUjk5PcQ0l2+cu7Q=;
        b=Kt3ecMa3SPWRZxCieOtLw+iAImqx/SabMNHsx5yyIVxIVVqGmwzYP5hDdUv3pnAuea
         oRfOz/Tr2NobEPLlMpJmdd73xAIVAZLcFjQTACR/1Sz5o80XJGEmdWVgEm9JNaKp4fsN
         2ribZ8Lu2L7xScjnn4OEWmnhV9rqBBV6mUkROKRTQCd7EndnMemIqRY3JDwrd77QOzFv
         EoQtQUIJv8GA2FKK+wKJcYS0VM2Q4vu+WABL4t/sxkTLyegPSChYP4D2w3oVld71hG+Q
         D1WyYPjag1S6u9vdwK49RZe+ODt45zYJGEEV9JggW73psNzcJRVyOtRoJGsskbnUiCEY
         a40g==
X-Gm-Message-State: AFq9FYL4KM+GoHX9/x4m14hO7P0/EyIJjxT4UmqmQPC4S7WN6n2I58lE
	s6jyVOJBcZeZLCCO6QN62nFPNIurkdRMNbaKw7jQOjpJ8PiL1xipeqjrt7TKPje0OKo=
X-Gm-Gg: AYBFou1enmc9tnYqAj5XjRgqSD/kxrZFMY7Dvtr0OWMehuyZkejJU9xR/4Bp7Y42N1U
	hAeodQNBMcn2njHBXTHVkqEzcj7/6AXwDvic+xyiglwADLT+iVT0Qiu2EnYDv9Li5V4k1kpoOI6
	0ouwmTFztv5FntVVJkxk8B0yxdep4KbKScOwXqdPisIEwGbOcyPWJbtv6V8pSK4N5RPzx/uJSbc
	5fwKdXUmqHwbimDDKgdtm9KIBp+PJuYe18iCgfizndK6R6p/FC0VHX/hCyFJHOHMFUu+JRIRUp+
	dgOJrJ8krk6q+sNBZqv0+J747H69mJ3Go1MDc8+9FN1/GC+6BzeP2yE3qPTA41ITgWejw/WRK9a
	qTTOSamzGpAejqWqaQZ34fMhF+jpouIWLsT4RTLWJE7mUMMEfAI2RaZ5j9jGyfgEKjxFTvbwyV+
	RtCtN1ZmZe3URYhWgLF5JRuNyssx9yaKIJH6BWvzMnkMbJSuH/09ixl64vj+D2vrjoz9wNCu8Jn
	TVT0/UmJa6kjawYJDXdo9wmr7wowFWY8MHOSea1Br7wwsHMzNiVwmBzkLYhfAYwIZDIp4Kvl8EV
	Nxy6tdJvih1hl4egDTYvsMDioCjczZcbc9po4GfSMmve6w==
X-Received: by 2002:a05:6102:5094:b0:7cc:776:6c5c with SMTP id ada2fe7eead31-7cc925f87e2mr2466183137.7.1792684049733;
        Thu, 22 Oct 2026 08:47:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 22/27] shared/mainloop: Add deferred callbacks
Date: Thu, 22 Oct 2026 11:46:55 -0400
Message-ID: <20261022154701.3959500-23-luiz.dentz@gmail.com>
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

Add mainloop_add_deferred(), whose callback runs once the descriptors
ready at the time were handled, before the idle callbacks, like a GLib
source of default priority dispatched after those added before it.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/mainloop-ell.c  |  6 ++++++
 src/shared/mainloop-glib.c |  6 ++++++
 src/shared/mainloop.c      | 41 ++++++++++++++++++++++++++++----------
 src/shared/mainloop.h      |  2 ++
 4 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/src/shared/mainloop-ell.c b/src/shared/mainloop-ell.c
index 1dda9c9ef761..873950743f52 100644
--- a/src/shared/mainloop-ell.c
+++ b/src/shared/mainloop-ell.c
@@ -106,6 +106,12 @@ int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
 	return -EOPNOTSUPP;
 }
 
+int mainloop_add_deferred(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy)
+{
+	return -EOPNOTSUPP;
+}
+
 int mainloop_modify_timeout(int fd, unsigned int msec)
 {
 	return -ENOSYS;
diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 971562610e02..705dbd3bec63 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -100,6 +100,12 @@ int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
 	return -EOPNOTSUPP;
 }
 
+int mainloop_add_deferred(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy)
+{
+	return -EOPNOTSUPP;
+}
+
 int mainloop_modify_timeout(int fd, unsigned int msec)
 {
 	return -ENOSYS;
diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index 652436be944d..653f22db70e6 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -90,7 +90,7 @@ void mainloop_exit_failure(void)
 }
 
 static bool idle_pending(void);
-static void run_idles(void);
+static void run_idles(bool deferred);
 static void remove_all_idles(void);
 
 int mainloop_run(void)
@@ -107,7 +107,8 @@ int mainloop_run(void)
 			continue;
 
 		if (!nfds) {
-			run_idles();
+			run_idles(true);
+			run_idles(false);
 			continue;
 		}
 
@@ -123,6 +124,8 @@ int mainloop_run(void)
 			data->callback(data->fd, events[n].events,
 							data->user_data);
 		}
+
+		run_idles(true);
 	}
 
 	for (i = 0; i < MAX_MAINLOOP_ENTRIES; i++) {
@@ -330,6 +333,7 @@ int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
 
 struct idle_data {
 	int id;
+	bool deferred;
 	bool armed;
 	bool removed;
 	mainloop_timeout_func callback;
@@ -396,14 +400,15 @@ static void remove_all_idles(void)
 	free_removed_idles();
 }
 
-/* Run the idle callbacks armed before this pass, once each */
-static void run_idles(void)
+/* Run the idle or deferred callbacks armed before this pass, once each */
+static void run_idles(bool deferred)
 {
 	struct idle_data *idle;
 	int last = idle_next_id;
 
 	for (idle = idle_list; idle; idle = idle->next) {
-		if (idle->removed || !idle->armed || idle->id >= last)
+		if (idle->removed || !idle->armed || idle->id >= last ||
+						idle->deferred != deferred)
 			continue;
 
 		idle->armed = false;
@@ -413,11 +418,8 @@ static void run_idles(void)
 	free_removed_idles();
 }
 
-/* Run callback once the mainloop is idle, again after
- * mainloop_modify_timeout() with 0; removed with mainloop_remove_timeout().
- */
-int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
-				mainloop_destroy_func destroy)
+static int add_idle(bool deferred, mainloop_timeout_func callback,
+			void *user_data, mainloop_destroy_func destroy)
 {
 	struct idle_data *idle, **last;
 
@@ -430,6 +432,7 @@ int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
 
 	memset(idle, 0, sizeof(*idle));
 	idle->id = idle_next_id++;
+	idle->deferred = deferred;
 	idle->armed = true;
 	idle->callback = callback;
 	idle->destroy = destroy;
@@ -442,6 +445,24 @@ int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
 	return idle->id;
 }
 
+/* Run callback once the mainloop is idle, again after
+ * mainloop_modify_timeout() with 0; removed with mainloop_remove_timeout().
+ */
+int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy)
+{
+	return add_idle(false, callback, user_data, destroy);
+}
+
+/* Run callback after the events ready now were handled, before the idle
+ * callbacks, like a source of default priority added last with GLib.
+ */
+int mainloop_add_deferred(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy)
+{
+	return add_idle(true, callback, user_data, destroy);
+}
+
 int mainloop_modify_timeout(int id, unsigned int msec)
 {
 	if (id >= IDLE_ID_BASE) {
diff --git a/src/shared/mainloop.h b/src/shared/mainloop.h
index 2dd07ce03818..e7bc470c53d4 100644
--- a/src/shared/mainloop.h
+++ b/src/shared/mainloop.h
@@ -35,6 +35,8 @@ int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
 int mainloop_modify_timeout(int fd, unsigned int msec);
 int mainloop_add_idle(mainloop_timeout_func callback, void *user_data,
 				mainloop_destroy_func destroy);
+int mainloop_add_deferred(mainloop_timeout_func callback, void *user_data,
+				mainloop_destroy_func destroy);
 int mainloop_remove_timeout(int id);
 
 int mainloop_set_signal(sigset_t *mask, mainloop_signal_func callback,
-- 
2.56.0


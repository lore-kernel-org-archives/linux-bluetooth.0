Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737840;
	b=kFJ1OTAGKs0h2GOdSGt3wFmzAxtKqeTRsywa6rD3a5carQTcsU68km399IRW5aznolQi
	 c3aKSeyjIhPqaniUiPrqLKUIYi3SeGfcpLMbCM6jpws3wSP8C+hxGTjqEI/3PiwH9BfKk
	 EFsvbssq8Sv/IOPPxqcN1Xp4BV31DZeYWXUXfkUjMgV1l6OU9dwgOx/ybehytE6w75iaY
	 oVz3dTds1nlOSQTGbC9Y+Hvn+87bQX+5cO8aY70vCues/r26k8MPbLL6dfxyCFGVBC9Wo
	 mMMdBmNb4DUpHkTEoP0GEFNDJSeO5QlKtcX9tdyfmKydU1bsohcq8mcK6ZHYZaccQAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q0zJcegewNsF8yxAs0IuKZW5hBYRafjWd/7Gdg0Y8kI=;
	b=5G9DGzjFvWqdIX/xHSmqpzpGfkVM8dmLs5VHBaoTYyVVeyZ0EeadLSrFPfCnP11dh/b4
	 kgV35DTXuQvZ6Bu38i+WL+RkliZUNl07ZXnHihIEMQfiW080VMQx+Q014LEto/i/qaf87
	 h3cX3dhBex80Me0qWNrF+JkHBWA4+6OxVq0jbJnOdVOsGk2TPGNh2sxx1t9ATEmL2Eu78
	 pB7/HZLGVt38mYhx1nRq+AmPFbwidV4dfl10KOf3KsgrYJN1umUJO0/A5v25rqPAbQmaI
	 AG0iS+0eHQW1hjwNqFSBc+p955jTU8WMK6kyXSPFVgBgSsNbd46oxrw7Z60foDA9O0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EmUPcNxB;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B04606A329
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B04606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EmUPcNxB
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7ce78f9d6baso769871137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737839; x=1794342639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q0zJcegewNsF8yxAs0IuKZW5hBYRafjWd/7Gdg0Y8kI=;
        b=EmUPcNxBa4LnevOMKRNwDWlR6o0ovqnxnrlNVGvzvMflR8VIdZs3GKodu/yn1ND3lh
         bpkpOUT8ujlRkLP1tlgFa9X/lVt5fSv5TGAARlPbIahb6eHXuMWp/iidGv/tJaZMxGTc
         d9VsjAlmM0p20mhcmnY8USXMWvP3C5hgtPnAcNK8F6fldNxUGVvjSOQT4QTtkxH2f9H3
         kZKRA2L9+gxkvgrqgOpeBe2a354miZfPLC5skdnEZB8hxAZTPRwqNF3Q2mQruzr5dBFK
         pIfLO9vtOZz9nyR8aco7bQ6CjaG3C95LIvJ0L7e57k8XYUTMpAJxUi8F+6TtqjbvIUAn
         /tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737839; x=1794342639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q0zJcegewNsF8yxAs0IuKZW5hBYRafjWd/7Gdg0Y8kI=;
        b=p9vRbCBvxKOb8KXZlQwxb4uJlD9zgfIE7VzPQdb5fFBCz4UMWcmqxwD2Je+GecRlnP
         UinjLeOsGKbXbDg4/GHYMW14ujOIAX1rjlpJ4cwDuJXC0qJ6bDAqY9x2K9UD0bf879LR
         37BIpPtoBYuSCLQIZGTvFBZn9yOgSyEFU3Go1zNtgp9sDP8DG9wchhKj5EoW9qSNV8f3
         GSYfTg2NcVe1C4vcGLVvhixGBBnSLFYFtifboU6Lwfs5vsNaLdu8KJpqTtANYu5yCnTn
         hunE28PMPhtTA5CsUReVu78hwEn1Q/O8tTmXOstDWxN//529dhyqtXHlf681OW6B1EPN
         NSPw==
X-Gm-Message-State: APuU4Z9a9viIXT+2Ti7mA6Hd1Ozy9dmRQLJpyQgLxGy67Yso6vdzN10s
	vjxFGJO79ersoPl0E6fa+isN3ClkEZlahXJcmz5mpozkEd4RLvK8eqiWPgTgFA==
X-Gm-Gg: AYBFou1WZ2162U7pQB/3YXLVHkne0aWrJGWYjoEtif3/SKbjFBUoPppb28mYadLePWV
	BVUsdgvJIlUeZm5WgZDvU90KO4dF4ynWZai25bGQbYtmGvhi9HFW7V2x/1+B0kIRllXGJwFjYnk
	JnrSzPKZCCPMvQbMSzEmsPwqjC7II0f/2sEP9OUcCvTKzA1tyKML0GPV4vsAqcYKF6VSYWJwXjG
	6isRkORFFLLQMtzH43VqbmajJ+fp3u5APhZ7bv4rX8hBoVc7ypLr1MxOYbUHT1EAjSjcT9nXM1L
	YZYqkYRCV71t/Os2nu3luIZtosRbYFEcp8EXMzS+gLNN+48a4OrSbwTiiYSdeq43YX3FRuTPogs
	MYJE/jm1hsM8oupqhcblrwKN+bzrqeapNaH1EyT9YLAGGDUlI8N6gQbxS7axxIpl0yyBTk5Pn3N
	mN9bFeLFr1zUajP3sqhiiZzMbs/FVqSiZY+oB5hs/nxYjzrr9vuozco9xdX8R3py0GKtwq/ITVI
	BLT7UNL9RVEHC3ebCrcQJ6XjF9rtTj9Q1HJVxpD0NKTQ4DjsIWTLIwA+IgJuQqNHHf3mmePkv/K
	SxHqDYM9l4FjleyDedoIuRLw3p3AaaOEhi/hItAlYvtB6sLJC7y9TT7chn2dt/C623oi2XckT3L
	sGl+O+wYMcTXffoZNC/0+mccDVVYMeoN3rbhPe+hXSst7RpeQJ49hitGGTk8aAbBWzlfgGnD9jD
	sxwZr6
X-Received: by 2002:a05:6102:160e:b0:7aa:d0a9:c5aa with SMTP id ada2fe7eead31-7d054215e44mr5192505137.18.1793737838991;
        Tue, 03 Nov 2026 12:30:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d69af021sm167865241.1.2026.11.03.12.30.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/5] shared/mainloop: Fix idle ID overflow
Date: Tue,  3 Nov 2026 15:30:31 -0500
Message-ID: <20261103203034.3904499-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203034.3904499-1-luiz.dentz@gmail.com>
References: <20261103203034.3904499-1-luiz.dentz@gmail.com>
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

Idle IDs were allocated from a signed counter that was never recycled,
so it would eventually overflow and wrap negative, after which
run_idles() would skip the pending idles, since it used the IDs to tell
the ones added during the pass, and timeout_add() would reject the new
IDs.

Fix this by recycling the IDs within the idle range and marking the
idles to be run at the start of each pass instead.
---
 src/shared/mainloop.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index 27de2b02ae09..c3db4932c7df 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -21,6 +21,7 @@
 #include <stddef.h>
 #include <stdbool.h>
 #include <string.h>
+#include <limits.h>
 #include <signal.h>
 #include <sys/signalfd.h>
 #include <sys/timerfd.h>
@@ -335,6 +336,7 @@ struct idle_data {
 	int id;
 	bool deferred;
 	bool armed;
+	bool ready;
 	bool removed;
 	mainloop_timeout_func callback;
 	mainloop_destroy_func destroy;
@@ -357,6 +359,18 @@ static struct idle_data *find_idle(int id)
 	return NULL;
 }
 
+static bool idle_in_use(int id)
+{
+	struct idle_data *idle;
+
+	for (idle = idle_list; idle; idle = idle->next) {
+		if (idle->id == id)
+			return true;
+	}
+
+	return false;
+}
+
 static bool idle_pending(void)
 {
 	struct idle_data *idle;
@@ -407,13 +421,19 @@ static void remove_all_idles(void)
 static void run_idles(bool deferred)
 {
 	struct idle_data *idle;
-	int last = idle_next_id;
+
+	/* Mark the ones armed before this pass, so the ones added or armed by
+	 * the callbacks only run on the next pass.
+	 */
+	for (idle = idle_list; idle; idle = idle->next)
+		idle->ready = idle->armed && !idle->removed &&
+						idle->deferred == deferred;
 
 	for (idle = idle_list; idle; idle = idle->next) {
-		if (idle->removed || !idle->armed || idle->id >= last ||
-						idle->deferred != deferred)
+		if (!idle->ready || idle->removed)
 			continue;
 
+		idle->ready = false;
 		idle->armed = false;
 		idle->callback(idle->id, idle->user_data);
 	}
@@ -434,7 +454,13 @@ static int add_idle(bool deferred, mainloop_timeout_func callback,
 		return -ENOMEM;
 
 	memset(idle, 0, sizeof(*idle));
-	idle->id = idle_next_id++;
+
+	/* Recycle the IDs within the idle range, skipping the ones in use */
+	do {
+		idle->id = idle_next_id;
+		idle_next_id = idle_next_id < INT_MAX ? idle_next_id + 1 :
+								IDLE_ID_BASE;
+	} while (idle_in_use(idle->id));
 	idle->deferred = deferred;
 	idle->armed = true;
 	idle->callback = callback;
-- 
2.56.0


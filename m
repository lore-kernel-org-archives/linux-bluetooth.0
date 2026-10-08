Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC882931F4
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430869; cv=none; b=auJ6LdGgNuXn78oERlvGqN3LsPcACayP1d0uqqZKJmDUNiSUQwVA5l7hIvMPl1xHwmRDEXTAOUhO7OzX9dzE0AWOUrLaDHE+K44TIWFfcj2da4I/wXNTtUlF295YbQNYTKA1bCwIoPtwC9fgBkmdc5Czjx17CIYCDuq64JuKCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430869; c=relaxed/simple;
	bh=dKREz0BI7YLkafZWKbhGzx6A0RFItAzlw6QsfIV9e/g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hOq4n0eUkZrj3CTSqvTVQeS6IWXMgK8mDxnCcuw4ZFQlrq3b9XxqDwVKCz6aFww0cV6cN6MyoIUn0zRQH6EHtEDwhOIrW86zgNd9Ch8nSZHA4V7GpYA2RF8M6urWW3pZAsZ8Q7a1p+igGNPqVwITpLJHfUjaw4tc9HoSOeqIKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYtkoV6T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYtkoV6T"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49fd4e9e1f6so466635e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791430864; x=1792035664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y4rRgcr7K1sNtI7BtbsTT4OJRNyKHOotv9tUjEAu5b4=;
        b=XYtkoV6T/QbSSPkPPMHB+LKEs3ruMmbFa6cQB4fRLb80rQ98liP+Mi/k4Ji19ohJpC
         6pwmOiVrY8nfCcwUQgF+q9ApeDQn9FbQ+c5rQ6eIkSnAxFHYwx3EuEmfrhG7FdRsnvKv
         R3qFCNAKOyuKnlsXh7/0z9WiO4SJe43dv5tcBA/hQoR1gpM/HAWLQPl8kpXxWwucVU0P
         9GlXL4PiwheNEn8XqLqki+3aLwhGy5m3khqPI/Cp0rrBGMPy3FR0Np4exauk6QMvNN2q
         fO3SPlTg+NsAkw9mzoi9GdYP6zVLHRefUhoPYR+gveStAcDdXoFPFO0iXLQ+r149w0Os
         hTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430864; x=1792035664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y4rRgcr7K1sNtI7BtbsTT4OJRNyKHOotv9tUjEAu5b4=;
        b=nyr9oqq3GwrtAggjJQN97px8EiWX4wMG7DHbKYQKzUF55qpbZGb2t6spcoHpU36/zE
         vFaRJsDSWoi4BFNt2o2GslcCGOvODZbLUTQotv8f8UgP5ki79v96WkX2Ons81c7C296c
         PO3lcQvxLIpbRG1nsRWbms9Sev5R5V/DoTiuOgbAy0eP6Q8C9LaAOWUia6SORWcwiH2Y
         M4SczC9rIs3qPa5Lb143l0aO2UEwIdLrAREyu6vPk8qOoI5/NfpY4u1FI4H2KQTAmBwo
         sn6+cG3Hn0uGdb79AxKqMSy4fz7z3D+Fm4elvblbsF3Z8hFjc33zjetdIW6mgGgS+8hF
         RX3A==
X-Gm-Message-State: AFq9FYKoOHNd2K0ZpIK5COG95pC4W1we5zKKdjte2OOl3DmfdWpSR/MS
	m2e5lt+J94vKeXiUlFUzotiGKhCwz+qvdSGAPcVP7WAmmDCNG3+NqaphetzBZ/Arj+o=
X-Gm-Gg: AYBFou09b2U4cLq48PVdLb2VXTMcCkzZO6DsnmWcdYCJ1ZZOxRDpM9vxafZxLIKUhV8
	rNuLJ2uGlUI49+MunNxVgJpn8Nmay6loQ33QZyxpdGSK9wYd+kDYSvDlx7VY64CUGUztmwdtVl4
	mDR3ewKnetX6ccFVwH1gK+zqufcb+qSqsDdC3Y3SExF02s5wd/GYKANEPl52SCSiyKXBtFOebC+
	cax4XOPE7bUhoJt3zAioyEItmMVu9MSED7M6y6cNr7vbwrAvp/KFuh0tGy2jM2NbiPzTnYJzi+Q
	tMFTl2wZQEOHHdlAWQccBNLNoqft8s82Im2fWnjN9gV7quFR+yz+zJEnvPGMOM+3u2qJ5xA+MpQ
	JRNjGBKXQbFFouelI4C7FPLGWdXCIjubr6X3ceWJ/w0vTuN5kRWOwjBBkIzRDbV1sd7gl1VAvQ9
	m2RpiM62AzcxVH0m8C5aOZvYdV9+mfRd4zaXIebHvhnUZz/yeDDUgZhDprkRz7mNCPy5qAfgPwE
	r0knoTanEn6KLD525VjSt2lrRzR80sVGN6CuRpvyoMuMnJDW6GwTbSoCAX/WBrejw==
X-Received: by 2002:a05:6000:2002:b0:48c:6611:82 with SMTP id ffacd0b85a97d-48c7e21f07cmr2075756f8f.1.1791430863843;
        Wed, 07 Oct 2026 20:41:03 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1f3f7sm8423010f8f.32.2026.10.07.20.41.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:41:03 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/mgmt: Fix notify leak in mgmt_unregister()
Date: Thu,  8 Oct 2026 05:41:01 +0200
Message-ID: <20261008034102.707451-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mgmt_unregister() called from a notification callback takes the entry
off notify_list and marks it removed instead of freeing it.
process_notify() frees the removed entries still on notify_list once
the walk is done, so this one is never freed and its destroy callback
never runs.

If the callback unregisters the next entry rather than its own, this
is also a use-after-free: queue_foreach() has already saved that
entry's queue node, and queue_remove_if() frees it. That is the crash
fixed for mgmt_unregister_index() by commit 872729a91632
("shared/mgmt: Fix crash when removing index"), still present in
mgmt_unregister().

Leave the entry on the list while notifying, as mgmt_unregister_index()
and mgmt_unregister_all() do, and let process_notify() free it.
Unregistering an entry that is already marked removed now returns
false, since it is no longer registered; for an entry marked by
mgmt_unregister_index() or mgmt_unregister_all(), mgmt_unregister()
used to return true, take it off the list and leak it. No caller
checks the return value.

mgmt-tester, mesh-tester and userchan-tester unregister from event
callbacks, and under ASan each reports these entries as leaked, for
example userchan-tester:

  Direct leak of 80 byte(s) in 2 object(s) allocated from:
    #0 in malloc
    #1 in util_malloc src/shared/util.c:46
    #2 in mgmt_register src/shared/mgmt.c:974
    #3 in test_open_success tools/userchan-tester.c:275

Fixes: 872729a91632 ("shared/mgmt: Fix crash when removing index")
---
 src/shared/mgmt.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index f56bcee14..f5aeecf3f 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -999,18 +999,28 @@ bool mgmt_unregister(struct mgmt *mgmt, unsigned int id)
 	if (!mgmt || !id)
 		return false;
 
-	notify = queue_remove_if(mgmt->notify_list, match_notify_id,
+	/*
+	 * While notifying, leave the entry on the list for process_notify()
+	 * to free once it is done with it.
+	 */
+	if (mgmt->in_notify) {
+		notify = queue_find(mgmt->notify_list, match_notify_id,
 							UINT_TO_PTR(id));
-	if (!notify)
-		return false;
+		if (!notify || notify->removed)
+			return false;
+
+		notify->removed = true;
+		mgmt->need_notify_cleanup = true;
 
-	if (!mgmt->in_notify) {
-		destroy_notify(notify);
 		return true;
 	}
 
-	notify->removed = true;
-	mgmt->need_notify_cleanup = true;
+	notify = queue_remove_if(mgmt->notify_list, match_notify_id,
+							UINT_TO_PTR(id));
+	if (!notify)
+		return false;
+
+	destroy_notify(notify);
 
 	return true;
 }

base-commit: d84171e6cd68a5ab95d0f3a384279c36bd108a13
-- 
2.43.0


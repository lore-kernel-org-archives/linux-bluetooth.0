Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C7946A
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820493; cv=none; b=eSzTgfcfkrUEwlCDesvLk4DsKPSSYy6d/IRKI+8Z5lNXfXR5Q96tTRK8pShphQGpDSQpo0p8lRQfuS/tUaiTxX9Gxt855Dz56o9j0ITjulYEm6o6wDDMlT/peBfIZAIxnf0/ELbBT0PJ9tlXhC1hpU3JqUtYUFcpbLLOUHjhEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820493; c=relaxed/simple;
	bh=m4o3o3Ix1Pv5Vmik6EioobXOvqo6HN3aS6ELsnlCG7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0cyDECM39Uqd75aDxEU8382Gkbz3WIL8XBWdIS4TeDa+mYfCCaDCtNyTQ6or1corAp0cjf5CElq625OmSxYNn+nGqyXQPr3g0NZ0a2D9aMN3yl6SV4IMaoP/i1IxRgQQB6TN+sr6w5EcTML86BquyvofB5Uv1+Po8oj+AGIqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9euCabu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9euCabu"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d6d5e45c43so564313785a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 18:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776820491; x=1777425291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pth4Do9OIcsliF6wBT8TKjxxUfEAzwCUqydUSwp3CVE=;
        b=B9euCabuFR8XYd9pz75qQXMcPZ9Q7TAMHWRkldcYfGsuvVoRjN3TedUmVs54eOMFtt
         iB8iuYBZGkz30KSV9CDZm/DUcmdRQgmoFB/xuXA75tgnLJn2egXST804RF7qyBZSFRh5
         QAhszN4TVab57DOU/jjyMtG0IiRoPWCY/WLp+lq9zbTeeCyifNqiqiciIjtT5WsAEvHw
         gfLjwYgvEmOHH2N5o0LlZsQontcFgMtzPYGwo0Sq3jY6/0b4sBT98Yk1+XxvbVMr2cIV
         GZYg5jkjJcW5ELxmvKsGIUQHvPKQB3n24fqvkc/sTzu7YJVuPcpjK8AkVOCmHiRSNtfH
         48hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776820491; x=1777425291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pth4Do9OIcsliF6wBT8TKjxxUfEAzwCUqydUSwp3CVE=;
        b=cLj+fIB2bBt2LeB+4k1jVjtqPnOuso/D0H4GhXoaoKqi6gCK+vgBv1D0Q+cNeVrlne
         1rTuO0BkQy4RZHE1zvNeVLkmbcoXKexv0KZe3AhOnm/wNZ4TdpDyeVso/m17+aIcpoF+
         semNjRod9mH0rUMqTcO+XR0psDhWvyZuRZWEvIGBmjSlCbYo0rXpq7hniaCHaImFCwfW
         mVvgXKbw85PHF1cQ1mbZwsqTUxZGg3UFESJc7vvUFyJjBoSQ3KCgNmw7NCbrm+BhKf6B
         3PWqaFUVroxD5mkpiQf/G6J0BjE1/sRhD3kxdnonBK/X1tDyheGrWRCa3Wrr5+knPH7S
         k+EQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Pp9LPmw36J4PhEXUZz9U++bI8we0OQIQuD1vbKsn8JVlPv7zPGIByUGDGgg9PhUGnLw4xazAIFrqMGxw6TuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw119qrIOcJ9n0+fFUQk0iP5FKPgTe/yiq4I+Pc0e+jQxNbEDwZ
	pea1+6H8WX2yqv8uusrGu6F3iOn8jIcAb8l6VCQL/onI4ezRRrdN5W7x
X-Gm-Gg: AeBDiesHpYFGieCWHWJG6X+EG6lDEeVAHP9Praa7e/jc8ZQVqcr/89bUAr1qgia5sc+
	n/lbuQrTJKSEhNpFiAZvzdQWJ/GKhlc3TFgD8qSNvDCKRMQxhv7qdJlluP4qb5Jz0+O9qbi1hGm
	lq7rExYtZzyBWrrg6o+/EGq/JxlTNWBeQ/Flaljzk32rGnWMdMtpRWSFIDLCjc9Qe4X2QyqJSDF
	0c0HDnLyDbY7esacX0gnw0R2DWvLnmI1gPrOLwPBT5nY5HVehWz1vXjTjIMZO1JqEoyQdFukG4I
	AuQdQlpVkAjq4X5NWigKZ14XkTHAoUoLRb5WN0dKo1eH8ewXZLuMQfTKvi9ENHQBQ/Tz3/KJEj5
	F8mkD13pYwMURbwOBdzL1BHFqE26Qd+T+/8/HFSqmuvUbSFUamAOtACy66wKVlny+dGvXz0z2FE
	bnVh2GXWt+9oQ4R/WCoB/nKQhR2h6LsuGBn3/RMEYbkdfXOSmj3YcjpCX5iC7AGOfd3SJiffXSQ
	dKaKax9xcI4XO+5Tm5PpPVuC0lSWmM=
X-Received: by 2002:a05:620a:2556:b0:8cf:cf7b:7ef4 with SMTP id af79cd13be357-8e78fa1ddecmr2985502885a.13.1776820491148;
        Tue, 21 Apr 2026 18:14:51 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm1163614385a.19.2026.04.21.18.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:14:50 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: HIDP: guard session->conn in hidp_connection_del
Date: Tue, 21 Apr 2026 21:14:37 -0400
Message-ID: <20260422011437.176643-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306023155.554597-1-luiz.dentz@gmail.com>
References: <20260306023155.554597-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit dbf666e4fc9b ("Bluetooth: HIDP: Fix possible UAF") changed
hidp_session_remove() to drop the L2CAP reference and set
session->conn = NULL once the session is considered removed, and
added an if (session->conn) guard around the l2cap_unregister_user()
call at the kthread-exit site in hidp_session_thread().

The sibling call site in hidp_connection_del() still invokes
l2cap_unregister_user(session->conn, &session->user) unconditionally.
hidp_session_find() takes the session refcount under
down_read(&hidp_session_sem) and returns; between the find() and the
call at :1421, hidp_session_remove() can run on another thread
(driven by the remote peer disconnecting or local teardown), take
down_write(&hidp_session_sem), set session->conn to NULL, and return.
The HIDPCONNDEL ioctl path then dereferences a NULL l2cap_conn inside
l2cap_unregister_user(), which acquires conn->lock without a NULL
check.  Result: kernel NULL-pointer dereference.

Apply the same if (session->conn) guard used at the twin site.  No
functional change when session->conn is non-NULL.

Discovery and verification:

- Found via static audit of every session->conn read in hidp/core.c
  after the referenced commit landed.  The other reads are safe
  (creation-time in hidp_session_dev_init, already-guarded in
  session_free / hidp_session_thread / hidp_session_remove; the other
  hidp_session_find callers do not touch session->conn at all), so
  :1421 is the only remaining unguarded site.
- Runtime A/B confirmed in UML with CONFIG_BT_HIDP=y + CONFIG_KASAN=y:
  a late_initcall stub that injects a fake hidp_session with
  conn=NULL into hidp_session_list and invokes hidp_connection_del()
  panics on the pre-fix tree at __mutex_lock from
  l2cap_unregister_user+0x2d, and returns cleanly on the post-fix
  tree with the new guard short-circuiting before the deref.

Fixes: dbf666e4fc9b ("Bluetooth: HIDP: Fix possible UAF")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 net/bluetooth/hidp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 7bcf8c5ceaee..9192efd1b156 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1417,7 +1417,7 @@ int hidp_connection_del(struct hidp_conndel_req *req)
 				       HIDP_TRANS_HID_CONTROL |
 				         HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
 				       NULL, 0);
-	else
+	else if (session->conn)
 		l2cap_unregister_user(session->conn, &session->user);
 
 	hidp_session_put(session);
-- 
2.53.0


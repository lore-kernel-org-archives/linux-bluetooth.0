Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB134F7CAF
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625664; cv=none; b=ZgEYv1sGFpXdFVdqZHEXjxW4zxfwhNCjkKicW2bg0PuefpXrkbti16MMzYPDSQEfc/5n8oG2CXjtXFym4opNUrAJVNJQDCtnt3sUprzMeD6Nd0A7Vr/lUn8G9KrMF8SEKlFXRliTop0Yp3N8SlTr7m8OA0IlmOOB1On7edEn+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625664; c=relaxed/simple;
	bh=kMcWyTYb0L98QVIl4p5gDSEMPg0occSJqIvPJRstig4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+hPYhxoDzHokUUIXKivnDwficDvrlZg9T3COWPhEE70VdRipH73u+F5Axmxk+365wDeZkHVP8irsfJRxfVqKq7WQJj4394Am/h+7vBFhNcJfjdkrt27a+dmtO8uVCiccsvP9iGGrUGPeC9Bs7VqAqIZIMlTcR0ALjUAxzVzlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvosZQvq; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvosZQvq"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e512ee5so1171876e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625662; x=1791230462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vt9DTVwWOVFKkxYyXvnNVrbf98nmMxbog94vYtf3ZD0=;
        b=lvosZQvqBQJ/WGw8V7+jtFPS83XmFiIdbdGMAC7ebYGgI64wny5F3vUmEnJJErCqS8
         WRForGqrZ6m7j/ThXdRsATRQCeVdelx5oo712UYSoilyQzfE3yqn7GGrHwmhTTMzm5Jl
         oPspnUZuuikoHDa2h5zzhvS1aRUIVgdHVco9yxgYOBg+BUpZjIGf5pS3QJlzhdec0Xfk
         sJxEtnfnMCW0BOwWfNXwaXR9GiW6kMmATWb0b+2xg700i4k0I9JEm3qBSlogR58CyA/9
         GRJ7Lq6+9g0+YGhTmE9sFcLqqzjf37F65/Bzi1Q3+m2KGgxG3s8IMol3Ty2VuKJ3uJT+
         kzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625662; x=1791230462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vt9DTVwWOVFKkxYyXvnNVrbf98nmMxbog94vYtf3ZD0=;
        b=KzCOWrPCwjx6IRMfOOA/JbQhuOZvrL7s4Y66fm1GkhsK/X2WU7B44YN0O0CeE1wH/l
         iklt4ZRAy68+dsG02A5NRqy9fMUzw0hlHz748F1Z4yyFetS7Xj4J1jeyJ8lVUm6VKlSW
         tdO1BzGnfS7n7z1+asJdRz3T1tgFWdSJsZy728xLnWEecBHPc9zEaWg9rc8Po1OTf5pH
         njCDS9fyuEzQO0h7Z+dkq1ENpvm1ngmBX802nztfzQEAgINop2kXmEtoUjTHG2dBRNI8
         c3RVCzvruqJwoj58/EgBl0EWZyQVsa38Hv3EqIX7DUMw5R/v0ShFAmP5iRZGK//hWlpz
         3hgQ==
X-Gm-Message-State: AFq9FYJCNyNqg4umPL+MzKEMRb/+AXiX7hSu88Qkn0nXClGOImVH9uAt
	8B8d99lG6D+8KBzBXYr2Dd77dgos/X6CzVHk6xiM8O6ITKyVeqRjy7k4TpN1wrIT13c=
X-Gm-Gg: AYBFou1nuINyP8A/loelh+Bx+BZReqH3nFbXYMnYhvy/WQYd/FzQgfWUoQ2N0Pfx4bH
	/PgnvFJSgPUjfVerU9LZyp9lkg9ZOdlKUDw1aVKH2tD4n/fy2sk3SX086SLhL7msMWCWGQkC1qH
	Rmt3I8xYEahKOpmyJkBw1FeKHNBrFISRlKjXxmqA6833kuIPAIOB6zEQi1j5aV94pCEudfp0W8D
	264Y1ejkVmzUjF5QQ75IQCdw9JzwtwnmdukvPbrpzbDjOHYVwsxUhn+77xgfmE8J6sJvanwpHwT
	FpOq17HeIeds+s+AjQ0OKVzObgkeWdGQwjYGPYqMKkAKoy1ulaAR6dwtf3xAMSzpVeElZeuBlbj
	s2+3E8C1LTeRSRkGPYUMXYjnggYXOjM8dZ5xT5iWNr5ILhRv3iAZpuJSOhxpD4aCOlxNBJS8dK1
	kWRAgIl1GpM8xCjbBJZ7bvvDgugQAFUPghZoj+JK9NyFTZ9zjqw/X3SH4C7FjeJHzFtjbCC47c4
	XoaS7wbbUUZINsmwSBSvk8OlQ/qPPmyizCMNltLBilNkUKcsVLWuw5XmTCpeMRh
X-Received: by 2002:a05:6122:54e:b0:5c9:c60a:e9b6 with SMTP id 71dfb90a1353d-5cc97f37a55mr3809455e0c.22.1790625661664;
        Mon, 28 Sep 2026 13:01:01 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 09/23] client/agent: Fix crash on Cancel with no pending request
Date: Mon, 28 Sep 2026 16:00:15 -0400
Message-ID: <20260928200031.1209311-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The auto agent replies to the requests right away, so there is no
pending request when bluetoothd cancels one, e.g. when pairing fails,
and dbus_message_unref is then called with NULL, which libdbus aborts
on:

 #5  ?? () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
 #6  _dbus_warn_check_failed () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
 #7  cancel_request (...) at client/agent.c:258
 #8  process_message (...) at gdbus/object.c:293

Only release the pending request if there is one, as done when the
agent is released.

Assisted-by: OpenCode:claude-opus-5.5
---
 client/agent.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index a678d5f785a9..2dd0113dc624 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -255,8 +255,14 @@ static DBusMessage *cancel_request(DBusConnection *conn,
 	bt_shell_printf("Request canceled\n");
 
 	agent_release_prompt();
-	dbus_message_unref(pending_message);
-	pending_message = NULL;
+
+	/* There is no pending request with the auto agent, which replies
+	 * right away, or if it has already been replied.
+	 */
+	if (pending_message) {
+		dbus_message_unref(pending_message);
+		pending_message = NULL;
+	}
 
 	return dbus_message_new_method_return(msg);
 }
-- 
2.55.0


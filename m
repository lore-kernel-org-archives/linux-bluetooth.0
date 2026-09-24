Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444842254A
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289067; cv=none; b=pEyMJ7CdrVi9phnMp1oEIeVWFeh8DBQAZDxF5ULitExgbUCbEhTReXPLvvTbI5VGl3ZmG+FmUNUN5bXV8uvcjsS8ieEhsuDgPi9NE6S5Qx1dwkATVFVhWVpGrzZe50MeQkgYo30rcPA2vare9hi6/SOtYBF/1UJOxJuuDnqljJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289067; c=relaxed/simple;
	bh=kMcWyTYb0L98QVIl4p5gDSEMPg0occSJqIvPJRstig4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9StfWbi7s9HvvxIuyLduXlcMTzlZs6irNTYzWGlq897nUiU494Pkz8gfkVV8l+ZO3xAO3v3RwbIPtu4WLLsvPkGJzncFSLEgPOUDqzl9isRmNtaz5YgOYkUxTEl1gcZnoGN/YIMan6yqSR5RW6hIIbxLpYJ1jwTTk+qAl514k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGl54Pct; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGl54Pct"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7ac5b4011a4so180411137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289064; x=1790893864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vt9DTVwWOVFKkxYyXvnNVrbf98nmMxbog94vYtf3ZD0=;
        b=nGl54PctSOEpKNBxwx7pAvVEc7tBq0w6JwXiisH91E4/KMEiriXpQlGDYSkB8JQG0f
         +FijqWF5geG27vjNbPc2lmhhnotPw44367EaqxpsPkAgoVqOgEJYAXBT4qgyUgD1RTit
         AtQ8yQEfs//fk1PhSsLO/23OO3bHmcPACLhDcJ0sly8FFl0XBFOeIM/RYys5bKMYMdAP
         i/9qO5z1INHoSEzXhpY21RbGQM4ZY8YJLibpVnm0FxG/hET9lUDprviEfLVbb423/QSS
         Vb/NE/BcER4aI365jwf1DwqekCLFu4MhaJ4JnmjDbNjhs7KEmgihlXICh7ID59UQnpgs
         2y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289064; x=1790893864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vt9DTVwWOVFKkxYyXvnNVrbf98nmMxbog94vYtf3ZD0=;
        b=ZqQuu5J1cQicqfvk5qd97IO9p70g72EmMODR9OLbCsedCpLguYqqTElgPYcCu3d/4u
         La+xFW/kEeWrep2Ngl9eTmDLzesgC1uxiKSfgJWaMXKAAue4U+SJcs+ntshmtoWZp39v
         v+0NX4ADSZ7KLNYmqqNfNCZoHgbfNKsYFyLydFmuNLAjeIgw8WOdkrVFlU2v+3PPlsps
         yXsHskBaMV6HkNCeYVBSIpwQc2ZMLSQknlVm1kK4gtbuzH1UwdoPh5iOgC86d1mt6C6g
         k5FZXkWfdhAmPiocLWUkF3F/XD/xpEkqLTevNHT07r0AOqWtlY3e4xc0quXi8U/U5WlL
         9IoA==
X-Gm-Message-State: AFuF++nLiGshEW/0KhUI0sfDbFeyL/b/vhYU8G4v/d+d76CJhzgm5U2r
	EZatPzwhc/iSZlpr1iC8T7h4OdqWQvQFlWclYDXBNLBOXlQuIgFMETY3OFAavy6H44XPVQ==
X-Gm-Gg: AYBFou23dXtx4BGv6nvp1EAgx5g0tHg9s6TjFcTL0jX/53KJnJvFX8khCtx3b6pOboV
	UxI/JcX3QvNP4bz6zA0LArkMWaiGYC7nb2mRXAgmVdSs4vtWsLfL0W5O7+2KtVCWfGlCMXdY0XL
	jqYgpVS8g15JRk5D6XUAuA+pONCYd7XYDDtNSLdMUROl13DOoFqyINpBEHtDq0cxzEjQONKVSQ/
	qiN+VBoQYkQHuNuXlE2aEZxR+jSUxocP0HH3hdJQxQ6XiX9IHYbtUwXQhsJeNVmI9rWTjcA45JN
	spC8U1IbgYrR48SY6nZP9FjryWVZUNNKTX7cQ0ECyPWvE8IiI6wy/NeHHGFqvJzAv9C471T4GKM
	ToYFJ43lDmdNsqRHV0X/OyXoiFvE/KvRZB5J2QLKTnqzSBf8IyD7vNLAZ+88wGDS/RALX/X6F4u
	DlLXMGzkzE55CDR2dpIJKVLAlAv/27t6YO1K+HSOZ2sHQG7j7uhcstDt/xZIZGvb/0f8u0az0tW
	hUmdMEwOgQ8AVNV4LL6vLmJS+wwD0fULXH0EmDSy0dFGBpWCLbatohOsb/42qsu
X-Received: by 2002:a05:6102:6a83:b0:7a2:2068:6b67 with SMTP id ada2fe7eead31-7af1dddb820mr1756685137.25.1790289064540;
        Thu, 24 Sep 2026 15:31:04 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 09/20] client/agent: Fix crash on Cancel with no pending request
Date: Thu, 24 Sep 2026 18:30:34 -0400
Message-ID: <20260924223046.605543-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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


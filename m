Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2A4D9F62
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616791; cv=none; b=UXcD8U5DXmWP+0+Cl/cw28/+UDfaLKpxAV+sTubtOeuSu5gQJ3xpQBH6+qgYDqOjC1LLLWQDyVnIoevxf0QZvDdwLEbsm3ovRFOpmmZtdF9LZI08yVIDYTvSN1rjhvjeOY4ALaoItOAmwiRNIM4JIu7Ui9CFjXrECpqeyq7pnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616791; c=relaxed/simple;
	bh=kMcWyTYb0L98QVIl4p5gDSEMPg0occSJqIvPJRstig4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5nQVvqdjqxF22/TjrGxz+09688L1fZroq6lwUJcR2lW7sJJMdE/RsnJZ/dcSdOxiyN65f12mCB298V2l0crLZjkmznMUm8tbA4DLN2spRXnCliC4NqZYHu6aToCEuTZeetqO7RbbXyGmtWljikxmQSB3FXIoqjGvqLeQ/iLXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+0q1Ef3; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+0q1Ef3"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97eaa1155fdso742539241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616789; x=1791221589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vt9DTVwWOVFKkxYyXvnNVrbf98nmMxbog94vYtf3ZD0=;
        b=U+0q1Ef3q2Je5DqTmHmGHXROWxiq0MxYmYbkeC58O966jI2ux2ee5fM6QQtz6lY6Tn
         ChvlbF3BWoXCHYLh1JPhfOBKvgG9Y2ERK/RJiaVk2JUkNGBJce8x+86cP8BEFU95ovMd
         bm0VeVMHVU+n6gKFXpEbOrT7xpzj74YqC1b59BaCkrBDXkELcjG1kVQl+wQNMfjdDtWA
         c+Z/J/q2LuHXuFGP5O8CbOIMtEwrM8EXOeJHN1ZJQEEbcJSZp7ctxTOoweeqvksSzHC5
         MGvoiURXXjCwxMv1pBMhxE7KEYPPdeMAuXk71XLj9XHCzAzQXDeimBgHlx5twV4XhRf1
         On+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616789; x=1791221589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vt9DTVwWOVFKkxYyXvnNVrbf98nmMxbog94vYtf3ZD0=;
        b=eEZyWUkMm6wCJnB8bjghWramnB6HFAZeuNHG0s5TBhB+FOrFBM3MIZF1F70hwLOxBr
         YYoaf50VYywI9xIrDfQq9ZeUisr9eu/YGfkOdNBQlMPuSzHiDA3MU5W98NT9Bpbo1ory
         Xpgckahb029ptTv82DlzX/1RMAzQl+W8V+kBqoM0sOKoOEm0nClscphjKWLS8djcwJY9
         RfP+s0Jbtc3u/kQ4CyyfzIgSrAFgzzjpKDYkRM7GGDNsgWxY1WVsyAqSSqQQG7CJtKzS
         XnJKznynyNW4UKwmQH8VgSYjCdW+DUfGgfH/D0hAc6lVY6AyIsGwIhEWI18KZVWgMzbe
         fXyg==
X-Gm-Message-State: AFq9FYLwBGR5RWlM6NaFfZ0imRDX2w3xrTabsWCAblmhAliG8PZ0X0TS
	+vpEhrS/r9QttBl48ZAI+lSeboqdv0iZ6a0dQyihzxAR7N2LrTgaHmbijyt/RKfNcMg=
X-Gm-Gg: AYBFou0lx9JD9c0SF5o/FaSnM6np2NtcmU91Ms1xSv0mF0k91vb1Va7TzXfOKny3X+5
	pwlqwXTXROnaIql78IAsZQ0WOzkfhoTrPIU+3jE4m98T4ujZWMuCE2nGcWevP6Rh2Cu6tgIGNgR
	TtY0I+BAAZKNy/b+lRS1LEF2r9o6wwE/EiIhh2W+K7MUEYuAqEX1PogD0cINtHFlmmZUm0PsVWh
	xHeSl9lNwZ1iGO6qKubU/m8A7fXSBz8kjf8juObPBtBgTxXQGHresmj82TlQiurQEVuwf84wn+K
	iQ6KMRvjVFQUk5tQFkR2Dx6DnObub1Tqc+MbivX0ZvMyDaXHO5AP4wwZIRQTlNyDHj07e+Ww7aB
	lcVDvZFT4fusW6l9Evqp3fGbaQ+LZ0ZgT545dkx3Ne4V0RsAzzbB4aupj6hS5aVFIExvWY8d+sD
	GxV+QYFKNycXy2Y++IL27RJsVylbH+OPRGomPDnv7Yld6xrUiwspt41Nb0FdRgu5heCeDgdUiQe
	xPk8VskQ4PQz4pRYba+fM3Zmgn8caU8NEwQGxYfwJcCNMdTstm/crNimAvL5MiU
X-Received: by 2002:a05:6102:869c:10b0:7af:7db1:8291 with SMTP id ada2fe7eead31-7af7db19351mr2705475137.5.1790616789318;
        Mon, 28 Sep 2026 10:33:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 09/21] client/agent: Fix crash on Cancel with no pending request
Date: Mon, 28 Sep 2026 13:32:28 -0400
Message-ID: <20260928173243.1073509-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
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


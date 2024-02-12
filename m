Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10CD481B4
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768160; cv=none; b=DVstvQqXWmrR5OtA7gIpTfYpd+7DP/sKFpXnFVWgIvlTu/ldOWhbwwgeipKKibCcsaLr3aBS8d6z8VnWIqxaGBAagsSJf7lFqit4EaMZj+HNxXzb7cb8XrW387w3gg63k46Y0vvqCsXXivtomG8gzsx9URg9+zHw+0T9fkN6Qtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768160; c=relaxed/simple;
	bh=qZ2uzciqi4+RwnW8iju+QrSzvIe2nSE2ggeNLNb1+Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0J4Upgt5CptghgQDdYNK2937vErpaTcevxFuq6tO1LGReA30fFHxq1W+gwZNCzm04jT2NmDybTAjOrC6AlLFU3daWWcs//SGGP16H85yku3tF8Ehm6lwO4qLwkr5AJ2xHvz+xxLYg5Ns2gdabhbpIjdaB86KvZ1iPWsAkziyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWh6xI+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWh6xI+m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39172C43609;
	Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768160;
	bh=qZ2uzciqi4+RwnW8iju+QrSzvIe2nSE2ggeNLNb1+Tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RWh6xI+mFVWMPK1zDRwmRAXCdfBi/j0Py+40kcX4Z3vWwKVrqcDqpWEsKedTKPFpj
	 R/tdyRuASQvC+KeYlI19MC07ybY84N8HL1UXCODCpiY8mpifKfFktufZ5dU29V/6R7
	 olPxAlQL40MGp5BHeyQ6ZfRfgHDKJsKUffQXMpGVdnDjT/4ATKLDiLVL2mlkmBa5DT
	 +ZefTV9StX03LzeZqZIvhW2yyv70uG2tMAQX9oyzBMkyPQUFVImmQS0jhAecY1yvO7
	 fNfti0HFyMVHQWxnzTX33p7RpXT8Z85XkrOQj6vrrLXIqXLwz+huWr7l24vrJP+7T+
	 2ZkdSvjXPzlgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA5C48BC1;
	Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 20:02:45 +0000
Subject: [PATCH BlueZ v2 09/10] obex: Use GLib helper function to
 manipulate paths
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-disto-patches-v2-9-8bab1bd08f4d@gmail.com>
References: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
In-Reply-To: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707768157; l=1584;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=GCUo/Nwzng2MpKTdvtQwQRt2p4nwTwzY0gaSQk+Xr7Y=;
 b=RRoKj0QjKCRqD8xfnN2FNs9AmfqfPFWy3NGEAPoYb6kR9t3DnLMdKUnhKvXrkYoKTz7Ee4YDh
 oCs3Rd8L+1SCgjpDZsqTWrUAYOxxG+cjQZVsJyJRhV9dvB9NwvH4wrK
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Bastien Nocera <hadess@hadess.net>

Instead of trying to do it by hand. This also makes sure that
relative paths aren't used by the agent.

[Emil Velikov]
Originally this patch was posted in 2013, but deferred since bluez was
planning to move away from glib. Presently there's no obvious action
towards that goal, so I think we can safely land this.

As mentioned by the author, current code allows for relative paths and
considering that obexd service runs without meaningful sandboxing and on
some distributions it is ran as root, we should plug the whole before
anyone (ab)uses it.
---
 obexd/src/manager.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 73fd6b9af..cc1de7ae2 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -644,18 +644,13 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
 				DBUS_TYPE_STRING, &name,
 				DBUS_TYPE_INVALID)) {
 		/* Splits folder and name */
-		const char *slash = strrchr(name, '/');
+		gboolean is_relative = !g_path_is_absolute(name);
 		DBG("Agent replied with %s", name);
-		if (!slash) {
-			agent->new_name = g_strdup(name);
+		agent->new_name = g_path_get_basename(name);
+		if (is_relative)
 			agent->new_folder = NULL;
-		} else {
-			if (strlen(slash) == 1)
-				agent->new_name = NULL;
-			else
-				agent->new_name = g_strdup(slash + 1);
-			agent->new_folder = g_strndup(name, slash - name);
-		}
+		else
+			agent->new_folder = g_path_get_dirname(name);
 	}
 
 	dbus_message_unref(reply);

-- 
2.43.0


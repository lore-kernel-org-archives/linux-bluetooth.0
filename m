Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC201487F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125071; cv=none; b=czl5FKZR5poSMLdq0F1Bpfrs7xnh3FWG5/ol8BQJVp7FvPIt3P7s5k3/ALZeGuutnzOpvUjARlUdyoG142qypLUMAr2c3rq+gHV9mNuIQU0oj0anpV+BIPyRFBYdumZ5xbKUlmA5fdzgNeiBKK9xuf2GfUUTFiDLuHttslq+Uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125071; c=relaxed/simple;
	bh=k1utIIAk6WcWlrE2Ld/X0uHgBt4Cmr8j8H3isV7mdA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=UDwOq6QoQbgvv117xyGy/FQMm3hAbMZgJpXioUSKgarMVWt09AZYtFDud1HPUiDAOdxhrAeW7YmwtWWYAEVKmdwJl/sUlNlNgSea1l1WJ4BqKJZfkk4q7MeomfHV7CxO79AdJBzsZBu6oUjFu3Wab4U78DX833InlONHgTUUo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMnMkBOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMnMkBOu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BADDC433B1
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125071;
	bh=k1utIIAk6WcWlrE2Ld/X0uHgBt4Cmr8j8H3isV7mdA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To:From;
	b=eMnMkBOu/76XNdqyjepzYPDZwUFPXyuJIRtERywQKiMtPhJWmt21SJJqux7WfDGLB
	 4CLBsBHYkE8HrnM46N/PRKe7LPciKf8FrDBBN6kfVZw+IUUgGKzcffqKthpZeoKENM
	 T1fETyAKM7CaOUmkRZdGNSnHUfl0jfv9rPF6ijfGHgrWYy/0r82mp1hPulrFDAvynz
	 HtpZaz29ivx/M8W/Ff5vXrADJSP7+WRdqtHK/OxnfZ0/cvFt4Pv/wTx0/WWA/z6yD8
	 JBLyDyL016ideWfOlCXN73kn90JHvy6i9LAtmwnuVazez9jmLLDRDxWAQShEHj3SXH
	 FiO7EkBrCsG2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19406C48260
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 16 Feb 2024 23:11:10 +0000
Subject: [PATCH BlueZ v2 06/10] build: drop explicit -fPIC from obexd
 CFLAGS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-hook-fixup-v2-6-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708125068; l=777;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=RWIlAJI/f0bffjXcuxiy9osevTreZ+4pUs/NPwBF2tA=;
 b=Q7XgNCkkxFOJ7c+3UFQmzJduYnXLnGLmxVvhtPRhndRPtTVw0GFrYBUJIBV302Tf+ZKJLdavi
 hGm3G6GV0YiCy4ViuvukEbJeTIc5BhQlxn7GmWgqdjgIGFRw47WCjWk
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

The option is handled by the global --enable-pic. Drop the local
explicit argument.

With that we can drop the standalone CFLAGS.

Aside: the -D_FILE_OFFSET_BITS=64 also seems off - we should either be
setting it globally or not at all... Something for another rainy day.
---
 Makefile.obexd | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index e8e4a6144..01aa3a9c7 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -104,8 +104,6 @@ obexd_src_obexd_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
 				-D_FILE_OFFSET_BITS=64 \
 				-I$(builddir)/lib -I$(builddir)/obexd/src
 
-obexd_src_obexd_CFLAGS = $(AM_CFLAGS) -fPIC
-
 else
 obexd-add-service-symlink:
 obexd-remove-service-symlink:

-- 
2.43.1


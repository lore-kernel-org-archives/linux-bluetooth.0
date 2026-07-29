Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B63A545F
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307908; cv=none; b=JWRHor/nNd1jxSZrkTKkA76JrXrREZCpDpnjSEKfNKdfToIcC1K6e70qrryGxTTBu05pxiiWdjEENKbuklgtLhpx+k/5cRGXgY4OSh6razbIOnOitsNUPk2jfR0n8y+xwfCwZH5Hr/pdRHmWp/xa7gLTZELtGr9dMrbtkT5MGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307908; c=relaxed/simple;
	bh=EB0RRFSs8YU/AloSup9EyQOYWnUoVgxVarIQcHkoI1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kiMcFZl/IHGg9X8Bf5eXpfVW+Wu9UCHn4wsmywMLPs3vI/J1nGRuoT5f00lcOyUJ0Lq93QucIENGz9sPrDR2xpNipkBMOS4wfxBw+7dwOQ29TlPTE0msoThFm3GA7+Tno8AQqL41jc0qDNP6+pdWj38stw6o1geqPRcR7Xcy22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvB6tjSn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvB6tjSn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A7B0C2BCB3;
	Wed, 29 Jul 2026 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785307907;
	bh=EB0RRFSs8YU/AloSup9EyQOYWnUoVgxVarIQcHkoI1Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=DvB6tjSnoS6HWiD1vGeeKtD+IBAY1U2tqogYK8PIUmwIzTMHVd6U7H514T8zGrWF9
	 gVCv5ardE+6nUdUEyWbt0qJwFunxdnq3OzuvQauc+Vy5Dt9XxZdAIEK93Ls2MPgzCZ
	 u4pBYsp9bDJ7GvBlLWweWkokwkFlDWJ1uuyLXvKjHzlpuVTBCM2jm/jhgrmaDG1uwk
	 cda6QXHbHtYEozP00QAp9bIG4vUnp+JkV/otwS143MFEsZNr2nSHfExQVWEgVXVCoN
	 VP22ZwRMXvNMtFhM2BqTgWz6yr/FYoSN+O2pEinOKIGadv0xNWL2dhBMGI4ysuER2l
	 mTOnWHdJMUtdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEEC54F51;
	Wed, 29 Jul 2026 06:51:47 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 29 Jul 2026 14:51:43 +0800
Subject: [PATCH BlueZ bluez v2] bap: fixed the return value of GIOFunc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-fix_iofunc-v2-1-f4043eff6664@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAP6iaWoC/22NwQ6CMBBEf4Xs2Rq6hko9+R+GmLIusAlQ0wpRC
 f9u07PHmZd5s0HkIBzhUmwQeJUofk4BDwXQ4OaelTxSBizRlGe0qpP3XXy3zKTYIDFRhW3NkAb
 PwIlm2Q3aceEvNKkeJL58+OSLVWf4z7ZqpZWpTlSzdYTWXd00+l7oSH6CZt/3H5b2YZ2tAAAA
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785307903; l=1305;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=q+aq5JL61eNx++8p/sEr4k79bC6hbLuCs+m2n68IdDE=;
 b=fk6Vx41A1pLsRmVDE0khF4diCp6VSCM4LxjztDjU2+eZezLRynRuy0Yer5sgb7V/1vuxh945B
 5QBerRvHgobBbNT0oqDUVM01qyUec5rAwyuAA1G0aIFcdocOB7s0LBF
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

The GIOFunc should return FALSE if the event source should be removed.

Fixes: 322c39a64 ("bap: Start BIG sync after receiving BIGInfo")

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Fix BAD_FIXES_TAG
- Link to v1: https://patch.msgid.link/20260729-fix_iofunc-v1-1-653c8e9ac29a@amlogic.com
---
 profiles/audio/bap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 473e4cfc2..ff8f58a12 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3683,7 +3683,6 @@ static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
 			BT_IO_OPT_INVALID)) {
 		error("bt_io_set: %s", err->message);
 		g_error_free(err);
-		return FALSE;
 	}
 
 	if (!bt_io_bcast_accept(io,
@@ -3694,10 +3693,9 @@ static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
 			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
 		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
-		return FALSE;
 	}
 
-	return TRUE;
+	return FALSE;
 }
 
 static void long_pa_sync_confirm_cb(GIOChannel *io, void *user_data)

---
base-commit: 729f96089cf66831d911385623ca932e0c245913
change-id: 20260729-fix_iofunc-e62cecc52b8e

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



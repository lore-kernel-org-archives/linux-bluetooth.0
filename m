Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395791;
	b=oGcW5pN6QEHcAvZnuK/ZFKkNUheVtdoK9Bt7tCgKL/JtEKVSOrK/Aq5MiDZYc0DZ55oU
	 Bysa0FBs07kod5pVhJ3r6vej8SkGaekulhXfVk+5hAJmB5fJI0j49FXSb1+Iphs91str2
	 Qj7whskvVdFg15fa/dR+Se1DjC+6rzT74+6hnJwOetBsTbGZ4htAxRU5Y6JWTiQ7FC5Q3
	 Ak4FfqseMEgBl6fh/9j8PwpgQ3WB3ttFNKniyzNCzkj3h+FFuJfK18DnsXw+gtIFVulPF
	 Gx0vQ8Ac9OQklx0sjUeaT/G4Xw9uD/Ee3/AzW0Mc+btk68+g4DJ4exfc+jbNWDccomA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q9qsRUv+pAKz8XBSBaIUzxMz5sZdB+AN13IJdxVfmt8=;
	b=sBj3V4xu3G1fNbQVgfegV89qRaM7QIgaRn+E1HBmYK+E+KvGhRLNpO429zFE4WKx0dvW
	 Q12IfFmPAC/65D05mhM5j6M6XpgSZ2Jh4bOH+bkxNCnjElOSc0L4yIwULS/7xEO1rsdUk
	 pJJiyreeBxSdNcN2NO+BYPqIpo0jFixdRHKSap2wWOOPdPWi9HxX76GBXgtGNE6qOiOU3
	 CKazl0UTtYqVLZLJbLyoah/dJRz5kEtZF3svm6lTs/+wq92aGD1vTQQaBGlWLXh1nFonZ
	 6Mt11Hu/SMh8AjATtO7pYod1M2V2/4pBasEMMrKrTyjRuh2gRST0Rlw+TCF5suQIO7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ix8/iNKk";
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308FB606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 308FB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ix8/iNKk
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so975862e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395790; x=1794000590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q9qsRUv+pAKz8XBSBaIUzxMz5sZdB+AN13IJdxVfmt8=;
        b=Ix8/iNKkq6PfpWRyGnENjrobot7mMEwaFWOtlCJ/UOjiJrclSshZX6tQbRPDydIWyc
         x8QA/z1t6zA/cbobKAekrSVNiaskicZHOdizvUVBBcZvvlH2doIEDjBO7kv3gzLD+a1A
         +LIirj2nr7eGca/vTjrTDDydpm4GH/5a8Wzhb8TULrCYaNb8qhSCQvseDAxYzgGbxss3
         7cmMEuzZ9bm2hF7H8qEF6c/uuWS9kStgtMXiSok00Gzp723PUzeBR+xVpiHjdVbaTGSv
         m2MFkM1ks2iqFOfQHSRPfzGpPUYwRakC72UGfxczBStkgRiLfxN/DWO8InU7HO9B35nc
         Sttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395790; x=1794000590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q9qsRUv+pAKz8XBSBaIUzxMz5sZdB+AN13IJdxVfmt8=;
        b=0A2UEIbaNguvHrMkQi/RS095/HYpleQv4CTmNecpxLlD2Cc4GjBamgm/7gjOkNG4+1
         t/am4lkv0Q85sSmhzRLFSQ8CWdb3TUJV/ri8FBmf8v9h6FKMRfnDaoYqFzAUpE94uZKW
         IKxohcncdCnR+N+RfEAgmCz+sZ7tJv36hAwEqoyQ16LqgYt9DiGT9UIZkmSEDRgMXX6f
         SnLp5Z315JS/QVrTm25Nx44U4xJ21UW29svJY25vl2Mqr5sZVV6pQdaK0opwNM+YZTqZ
         kIeMG4sWJgwOXyoLyw/37tIn2q7h03ETLWsGMIAEXcTbLkdZoZaZmt2mkCLMTkURAi0F
         bMEA==
X-Gm-Message-State: AFq9FYIeMp8/lC6F32HmnFnFHMDdygVtJl4dE8UlrlFfjS9S5Ie8+Bd/
	eUttvvlRhfPc7cgljgKd69KMxU7agpfcitmLF/nIsQyJ+zB0crdNmOLO13BG3A==
X-Gm-Gg: AYBFou3CjEQ0Tyb/Nvf1LeIooWQQOg76g4e95oWBgeJJOCqDtdbpHRblgXjdxII0V08
	MS6zwMZub6DOX5AmmcB/eLm1yreXvOJGPIHU/O5qBBofajAWPwpnMi9fTCUnKbCMctbWMNxzVMv
	4UHJ/y6wRh4MzHKIKzOjuK9xpVSEO3sUswaTWgXcdnTM1l2w7vkv8UMMv5Kla9LCP+Z0Ow32cjx
	PpcVMRycGXt6l/CcEzA+vRlsDByzXYcYuNDI5T45/foz7NlOY5txtgYBKfui0XTImyqJajBfKeJ
	u34iL6+hGGQIxoHf/+ymv/ybJOGYT/FwqVWVDp/tkYYvqcuAnqgBNrCga4hlFdKkJPE8lxvagkI
	532F/05KX7TYftRMd2klJPMgW8yZ//AoH6QdkN9jk69bAJnKg/v72FiIz6qAlSUcXTKjxOHGrJE
	b5F6SNQRIkgNtLeS96RMBkGbnHcew0f5synmo/Sbn7Ib6K8x/PXiW/BylUzQzkUhaesBKQecjZf
	y/UL9KWF6ZeAf3L4+qLHZ9mOBY0TK2LUk799V+Nw6KXClk5EqlrRf9y2FWKRWZ1hRW0affcMjPl
	UV8Cr1+96W2IJcP71D63bp8coZgRyaH1brvu5/rs/rntmPmJU7M0MhcOpwSPdzEqLoWs/2ekpZO
	VMjGyrr2tueht/UkiQa0LHadn8DHtlOAg2oDy2iEZbNDOdUiQEid716AP+SvU0GlgdRChgsuQqM
	noKP7Z
X-Received: by 2002:a05:6122:54c:b0:5ea:c37b:450 with SMTP id 71dfb90a1353d-5ec68980d64mr2035234e0c.20.1793395790136;
        Fri, 30 Oct 2026 14:29:50 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/10] shared/mcp: Don't drop commands before supported opcodes are read
Date: Fri, 30 Oct 2026 17:29:35 -0400
Message-ID: <20261030212940.753771-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
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

The remote player is created once the CCID of the service is read,
before Media Control Point Opcodes Supported is, and until then every
command was dropped. As the player returned the request id as error
code, the D-Bus call succeeded anyway, so e.g. a Play right after the
player appeared was silently lost.

Only refuse opcodes once the supported ones are known, letting the
server reject them otherwise, and report commands that were not sent as
errors.

Fixes: 9027edc4604e ("shared/mcp, mcp: support multiple MCP, and add non-stub MCS server")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/mcp.c | 10 +++++-----
 src/shared/mcp.c     |  8 +++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 314bce2439df..7522ca4e6ea3 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -253,35 +253,35 @@ static int remote_mp_play(struct media_player *mp, void *user_data)
 {
 	struct remote_player *remote = user_data;
 
-	return bt_mcp_play(remote->mcp, remote->ccid);
+	return bt_mcp_play(remote->mcp, remote->ccid) ? 0 : -EIO;
 }
 
 static int remote_mp_pause(struct media_player *mp, void *user_data)
 {
 	struct remote_player *remote = user_data;
 
-	return bt_mcp_pause(remote->mcp, remote->ccid);
+	return bt_mcp_pause(remote->mcp, remote->ccid) ? 0 : -EIO;
 }
 
 static int remote_mp_stop(struct media_player *mp, void *user_data)
 {
 	struct remote_player *remote = user_data;
 
-	return bt_mcp_stop(remote->mcp, remote->ccid);
+	return bt_mcp_stop(remote->mcp, remote->ccid) ? 0 : -EIO;
 }
 
 static int remote_mp_next(struct media_player *mp, void *user_data)
 {
 	struct remote_player *remote = user_data;
 
-	return bt_mcp_next_track(remote->mcp, remote->ccid);
+	return bt_mcp_next_track(remote->mcp, remote->ccid) ? 0 : -EIO;
 }
 
 static int remote_mp_previous(struct media_player *mp, void *user_data)
 {
 	struct remote_player *remote = user_data;
 
-	return bt_mcp_previous_track(remote->mcp, remote->ccid);
+	return bt_mcp_previous_track(remote->mcp, remote->ccid) ? 0 : -EIO;
 }
 
 static bool remote_mp_set_setting(struct media_player *mp, const char *key,
diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index 4ee14d1567fe..8ddc072dacaa 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -108,6 +108,7 @@ struct bt_mcp_service {
 	struct bt_mcs_db rdb;
 
 	bool ready;
+	bool op_supported_known;
 
 	unsigned int notify_id[MAX_ATTR];
 	unsigned int notify_id_count;
@@ -1256,7 +1257,11 @@ static unsigned int mcp_command(struct bt_mcp *mcp, uint8_t ccid, uint8_t op,
 	if (!service || !cmd)
 		return 0;
 
-	if (!(service->rdb.media_cp_op_supported_value & cmd->support))
+	/* The service is added once its CCID is read, so commands may come
+	 * before the supported opcodes are known: let the server reject them
+	 */
+	if (service->op_supported_known &&
+		!(service->rdb.media_cp_op_supported_value & cmd->support))
 		return 0;
 
 	DBG_SVC(service, "%s %d", cmd->name, arg);
@@ -1686,6 +1691,7 @@ static void update_media_cp_op_supported(bool success, uint8_t att_ecode,
 	DBG_SVC(service, "Media CP Op Supported: %d", v);
 
 	service->rdb.media_cp_op_supported_value = v;
+	service->op_supported_known = true;
 }
 
 static void update_add_service(void *data, void *user_data)
-- 
2.56.0


Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928C28B503
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420986; cv=none; b=TYOxFHQvFFV9NlTFIJZKEvZ0t2Liin7CTZ+3HAhCy3ZBeF7MPOy9+6bavHv78jcELtgEt81hN3p1KISdbNOKWpf4o3o5hXW3ayqUYmkZfXpunqObchA/8EZrubV1FhCWzSyio1PoggVDMpG4RiQ7LHDiVNd64LVs9G61Ho21Vso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420986; c=relaxed/simple;
	bh=SxjVySoPnr5ZWmPh6jsYJN+WWxAIWrGd5uAstAKUIFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDY9kv7mhQagGzdvMu9Y2HurG1InVyZrzq4MFUaqOiI0ri0JjK6L2CAc2IIUgLUiAO8JqyqK7B3EkcJ5NRmZP6xsY9SsvoZ8mxDvZe3N+bcPvF2DgwSB1MpOjaSl+UGDdayZnMlg+d6920BN2rsM/JiwDNYEnDp3b3nfdiI2nrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=ceygFh0R; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="ceygFh0R"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47ae894e9b7so109725281cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1745420983; x=1746025783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVhPt6MnDoPuk2Qnb2PNXtcL1RsGqtNeRByAXpMT8a4=;
        b=ceygFh0R9/Jx5Oiktn5462CR5kA7qUieSn17HJItcZoU1JKvo5w7HWCfTSE4Uwqre7
         0kBkUQ36W8oczoFPBvlpr+VyOYxbhFGQynHKtToqc0bFuWu37t0TK46zNHJTQo4BtrDR
         v82LfPM0A6cILfwqmq8jMP7dsK9ParacITii/1mcQsa+vYHGyRFFSy11Z0C4cQD+Xofg
         nDMLeWrYhuNiMv6WIhweSAMyHapssAQK0jdKUOWVHyqp+KnjRxboHCocULqHHe+NiXrp
         kjF06Yy+mrMNYTLT7k6osaHiNLpAkXiznf/U6pyrxn1mdH62je2rdGGJzcH/3jyZ4shV
         Lbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420983; x=1746025783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVhPt6MnDoPuk2Qnb2PNXtcL1RsGqtNeRByAXpMT8a4=;
        b=FJ7Oh9/zLvIM595O7ENfcjfsmoUZkKfozYSIN6m4mHR97Ka8cZR7aDxJkoTxmZlIYU
         LWAI32qIoEAW8UbOWkwMXUkIb/kRD5Bo6q0U2kC9p3mSj0ih9ixIyNmXQf7210AMJmBn
         XwhAZK+V0JAqCsbzKPnpALSzHKLxpS9rWjU2gSLGNRhuHh+5Zxc0NHY+Qjwydp2UlcP3
         zvjzYNqjPvgPeP+OG2tY4pf495cTXoi5fi3f1Fs5H1PlSiwnJxD5xXQ0wePevKDFRsQZ
         yEXByjOz88KjU1WUj1u0Kyn7bo98Afj2le8ClFpiGM/l8/gq8nicn3RS3zJPxo9dmnX6
         SmvQ==
X-Gm-Message-State: AOJu0YwkuOHXIhPmxSrDZEiEFNPu7T2Rn285DF7SHf+lg8VMEToSext2
	PKcNopXDxP2HpfOfCSnZRIPm4sON1MBlx70bwPFn/nFaJcWI8kCa4cqTE5em2cZV81OcBNmoPvY
	Y
X-Gm-Gg: ASbGncv85x5ZEnhfwhMV2g+eD92hDGLpYK/ODqdj3fcyiayriCZzBt/e9Pt1xJvVQ7H
	9orn/zQyCF3IbghB0diAS1SXpJ/RLNqzsIfYRBr2rftT8EFw8pKD0ESBQFsyFQi3DxNNHVyV/O2
	ERQFeDHzTyKFmRQ9guPBARlIpI4hPCy+KPYdTJinYSqIjT8kjXGoTUb73kYGHATUKvA4E6zCOXg
	mhVyjkQZyoA/F9AjYtkpoESHPqGrEnzzS86+jWO5fEGR+QO8OUTjD/jqtdrSIgr6u1mYtcXDJCA
	GwBVu3QydBrL05nD8lXC4hXiVs8vvMx59IubRg==
X-Google-Smtp-Source: AGHT+IGMliHYY9qk/rVr3aoZ1UyK9dkEgZRm0PSb/iVSk1y8wB7psmWF0YAFsgk20/W0YgIfOWooNg==
X-Received: by 2002:a05:622a:144e:b0:476:bb72:f429 with SMTP id d75a77b69052e-47aec49fe7dmr316374101cf.42.1745420983058;
        Wed, 23 Apr 2025 08:09:43 -0700 (PDT)
Received: from andromeda.lan ([74.15.9.135])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cfa3f1sm68953601cf.79.2025.04.23.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:09:42 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	sanchayan@asymptotic.io
Subject: [PATCH BlueZ v2 3/3] shared: asha: Use a more descriptive name for the state callback
Date: Wed, 23 Apr 2025 11:07:42 -0400
Message-ID: <20250423150742.319463-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423150742.319463-1-arun@asymptotic.io>
References: <20250423150742.319463-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/shared/asha.c | 24 ++++++++++++------------
 src/shared/asha.h |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index d99ae4d8b..bcaf6b843 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -189,8 +189,8 @@ void bt_asha_state_reset(struct bt_asha *asha)
 {
 	asha->state = ASHA_STOPPED;
 
-	asha->cb = NULL;
-	asha->cb_user_data = NULL;
+	asha->state_cb = NULL;
+	asha->state_cb_data = NULL;
 }
 
 void bt_asha_free(struct bt_asha *asha)
@@ -210,8 +210,8 @@ static void asha_acp_sent(bool success, uint8_t err, void *user_data)
 	} else {
 		error("Failed to send AudioControlPoint command: %d", err);
 
-		if (asha->cb)
-			asha->cb(-1, asha->cb_user_data);
+		if (asha->state_cb)
+			asha->state_cb(-1, asha->state_cb_data);
 
 		bt_asha_state_reset(asha);
 	}
@@ -226,8 +226,8 @@ static int asha_send_acp(struct bt_asha *asha, uint8_t *cmd,
 		return -1;
 	}
 
-	asha->cb = cb;
-	asha->cb_user_data = user_data;
+	asha->state_cb = cb;
+	asha->state_cb_data = user_data;
 
 	return 0;
 }
@@ -439,8 +439,8 @@ static void audio_status_notify(uint16_t value_handle, const uint8_t *value,
 	struct bt_asha *asha = user_data;
 	uint8_t status = *value;
 	/* Back these up to survive the reset paths */
-	bt_asha_cb_t cb = asha->cb;
-	bt_asha_cb_t cb_user_data = asha->cb_user_data;
+	bt_asha_cb_t state_cb = asha->state_cb;
+	bt_asha_cb_t state_cb_data = asha->state_cb_data;
 
 	if (asha->state == ASHA_STARTING) {
 		if (status == 0) {
@@ -457,10 +457,10 @@ static void audio_status_notify(uint16_t value_handle, const uint8_t *value,
 		DBG("ASHA stop %s", status == 0 ? "complete" : "failed");
 	}
 
-	if (cb) {
-		cb(status, cb_user_data);
-		asha->cb = NULL;
-		asha->cb_user_data = NULL;
+	if (state_cb) {
+		state_cb(status, state_cb_data);
+		asha->state_cb = NULL;
+		asha->state_cb_data = NULL;
 	}
 }
 
diff --git a/src/shared/asha.h b/src/shared/asha.h
index 39e55f22e..680a27010 100644
--- a/src/shared/asha.h
+++ b/src/shared/asha.h
@@ -44,8 +44,8 @@ struct bt_asha {
 	int8_t volume;
 
 	enum bt_asha_state_t state;
-	bt_asha_cb_t cb;
-	void *cb_user_data;
+	bt_asha_cb_t state_cb;
+	void *state_cb_data;
 
 	bt_asha_attach_cb_t attach_cb;
 	void *attach_cb_data;
-- 
2.49.0


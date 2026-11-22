Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348252;
	b=WWuymZBIp6ZCAW1GJGB1H489GIRH/h2sCEeRNW+Y0HZ3uN/PGI6BDLhguDNtims7Z2pA
	 8fxo+mNIW7vUTzuW2XQai7GPJxTOTBLGto1h6V7Xyo12YNNEcUmxeOF91nrlGPiPOdpZJ
	 zqWqiWCm8vMqoBpYxpQDcorJY5YHitQCESv/ruNqSHyUBglIhXHcdlU7pO0Xy3A9oEo/C
	 vABpwmDF1D6gtmSdpdlsVF/ahte98+kT7bBK6+7N6B/Rq4cev/xIKVSyvgMrqadRZ3dqt
	 +2LSJki1KbrQYrmluxy3zycxuFLI4d2CrTXu9Ry2IV7KErytzpNnnc0ZEN+IEg/iC2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=56EPQfN7S5UupsGHthVs2omQi6+P/G2URMrDtJBLdtE=;
	b=Td3BKq9SMj+aAqAeWynP/6TnpHVgX5EE5+dTgmRs9v7GflJ0pg4DkWFX0KYzjt20BnRB
	 kxLwJUDSoPn0N5S/Eq5ksJCztiUUupS+eZkNCadSzGVHRvVXyoXOpFdoakmnSsS4MhIIy
	 F5sYS8mf3abUG3hxKcX5y5OL9XwmEyuBcBryAXLkHuaJP3sJXmG1nLtdSktKC18zILJ4R
	 FvMjJK8jRuCfMSaNWn6h6f1nk2f9A8GMOtD8r1ONfw3vmkFn2+BRqGrSlPLbcOJt69SRo
	 INksX+877/vcbIZ0grKDJvMsIzyDfHzU5zj+p/E/OF0HewTh/BjvpERWfe7SNSE/liw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=XQYNS610;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AC606A335
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A5AC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=XQYNS610
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so28300955e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 03:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795348250; x=1795953050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56EPQfN7S5UupsGHthVs2omQi6+P/G2URMrDtJBLdtE=;
        b=XQYNS610Em3IqnRVAZS8iRbJMYDXhxkrCWYtd2v95hlqRAbmBEEN6WjwgP6JmulEEY
         TVBO7P9bM/FlEJExJ35XT6il7i2hxSZnFLaFRM0qVMkXuJe2h4amh/JqPJCJEx/our3o
         ZD8x6ZKI5O0P6g2ZAbVZ/rp7V5Cv6tlqrMRd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348250; x=1795953050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56EPQfN7S5UupsGHthVs2omQi6+P/G2URMrDtJBLdtE=;
        b=khZkYypSVNmQFiSTeXpWLzgOttjHnuEm11TK8c8OCpejzZsejwYmpG+nDKel74XUvB
         4OlOAX4t7wnW5KxvEegTU9UmfQ3F0mTpD0JWDgM9sLr4l/APkt9SGAYR74NFI9pJ+jKN
         ES+qcHIu18TdYSdIw/yQhFBTZSqZaPWg3KF0H7MnDymJK2x8yViKVaa3FKE2Rx61IvEU
         chv69xTU54cPKjvsJmjVbBUWkT0dPEU/3IRPObK9JhSNTjmabGdjZ3WoginvvVIrj5rW
         tsOKDiYy9m5QZ+LhqW2pQ4RUAIeq1UN8yvQwlpMOUlS88ihWW2t3y+NeH+ldmP3dQVSD
         h8lw==
X-Gm-Message-State: APuU4Z8tsXUHCAi6Aus8toEJGgN7y6nfo8bwIg6txsrrmIwsqVMyYIx4
	jN79QNrf8yLvQ88pA9UHicDBWFiniy1cFnvB2U8hQDWlkFihyI+8+JSoP3zosff5HtyNOJ9doJ1
	lu3WW
X-Gm-Gg: AZFdTZek8BDEFa5dIPK07YcFyjKnL2/mSzMXNoWfoagqzXNClwySf0ODTKCzSI2vdxN
	Cx6NBEnxMNSsTgxCzP61IaMRB4xpK9UHhZnejp01mR5g8b87u7bkg5ADVzxQ0tm9nXagnnTfF7v
	Sp2f1aoCWH9wV3t1hGVEijABFA2NS8ZTRu2vtSmII0VShQ1B1E1gAXxAtay2Bpvt1K97GGAsDaH
	OZyveY9TdWSOadWHMsxmw1HpdE6objCvfnXP0Op57F/AHKdBEXeLHSEfcGFg3jAG8U7Jk7lJGaI
	fUnxut9/1SskCmyZMAtWhNaq30uzwnSKiTtVTfrQg3XFQM1426Dm3NghgbGrbS+TG9Er0E4LE3h
	+AVn414IT4Tpx4v4k6y9yBTjoYLeNuQ2RmCCQT9/InTt8xqy0xIJTcyayqzP0dTu6D56E9vuZNp
	F9dvfK/YidItdNxMiAvZrpbXU0C956NAbIV/YCOnAktznBCCmYPMlnLwi1kfbFqWDV67/Kt4Vhe
	lZcFj3htkzSUc+ePz7HWivI21jt6Ks31EW9MNz9nWOWUqMTmwedCMa907fM4gwBCQUc2NAgMKo9
	FUCt1btaS2wRzPLIhimxmbJPrhAkl5h66z64E5gwItOF+Prq9w==
X-Received: by 2002:a05:600c:5308:b0:4bb:76d6:1f5d with SMTP id 5b1f17b1804b1-4bb887ca192mr191605085e9.2.1795348250570;
        Sun, 22 Nov 2026 03:50:50 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c248b75sm16538513f8f.54.2026.11.22.03.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:50:50 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 4/4] bap: Close a pending PA or BIG sync when a broadcast sink session ends
Date: Sun, 22 Nov 2026 12:50:45 +0100
Message-ID: <20261122115045.1077168-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
References: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
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

bap_bcast_disconnect() frees the broadcast sink setups, but listen_io
stays open with a callback on one of them. A PA sync that completes
after the session ended crashes bluetoothd:

    #4  iso_do_big_sync (io=0xaaaad1ab3a30, user_data=0xaaaad1a87110)
        at profiles/audio/bap.c:3689
    #5  server_cb (io=0xaaaad1aabd30, cond=<optimized out>,
        user_data=0xaaaad1ad1310) at btio/btio.c:285

Close listen_io before freeing the setups.

Fixes: feb4ee9dcd4b ("bap: Fix use-after-free in broadcast sink cleanup")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 5e717cbef..af532537b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -4284,6 +4284,16 @@ static int bap_bcast_disconnect(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return -EINVAL;
 	}
+
+	/* A pending PA or BIG sync calls back with one of the setups freed
+	 * below, close it.
+	 */
+	if (data->listen_io) {
+		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+		g_io_channel_unref(data->listen_io);
+		data->listen_io = NULL;
+	}
+
 	/* Clean up broadcast sinks before detach (like unicast does) */
 	if (data->bcast_snks) {
 		bcast_snks = data->bcast_snks;
-- 
2.43.0


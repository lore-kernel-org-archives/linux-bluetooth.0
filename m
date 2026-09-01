Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FA4A33E1
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295288; cv=none; b=GwiJtGCsUv9H3ry31b0Bp4xjotMD2B4OonFL2AlkOYj9AO2dYCIjjuoErLSEL94wdxaDDSyLbHo/ELnkFFjW/G5FSY1PEKUMhfUW5xidROt2uCDbk0bO5Orq1c9iLIWWjuhwi8/oZHSLoHLJ88aW2bsdcjYM/jSl57OwGGwfVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295288; c=relaxed/simple;
	bh=4I1DukrCS35B88zO6iruti94ZVm9wd5gNKVwfpFupb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHtyFg5iA/pGFBICGBSGlL9N4LlSe92+tLBOOg5O3GkEE5rK9hyUj/50UqbuYPFRz6lkyPQqBjPqPOf9aGJSnaDVSgCDd0swf+qpsrCd0+H5uhUIUw+XnobYcSv+zvFstM+lhdxFJnqisy3JiXj8mmuxLMCbjUoIJpn4YA9aKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoVNxz6I; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoVNxz6I"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482e067e908so284268f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788295285; x=1788900085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H47NzTGKEo5jxThIouZ6Of+htbmdYJ+s/sP3vnCuWlA=;
        b=NoVNxz6IFk4rFTkyunlsLtJlfX3c3eKd2mKdMsxn0kjo97MmhKXGCNmBphdSWHfWeU
         k7lDUjSueitiVYEpeQSne5N9PG5C7cvgUkcgZmOHh4RQ4TovAmFL0uBpbqUblnHIJaNg
         nq+HXA6k4AdIh6mpdLApryneGdRqGIXe2TPFkuW/jxKwZkCOnRX4eqvLgwkic9939QoN
         OzAvH5DsaSgd9PDIqeLTF2BIogXHQnd6n33YocH3RIpsYRWk4YQcMp4cJKhquVvsHigQ
         OePwQlh3Tb/AP+6o5eLt+bXMCsOBx2f1DlQRnaYQ1nWgfcII0DFXcNB5OiCa9cdWhWo1
         A9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788295285; x=1788900085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H47NzTGKEo5jxThIouZ6Of+htbmdYJ+s/sP3vnCuWlA=;
        b=Pnp+kwCMtuDvlVQ1OAt01SYagMQu9i3JqV/QqGfJA3DaC86B7WWqabIZTeoCI6TCyd
         ZiYpP8/aLKfzNj2JSyZNobNMcUwBp1+FwKJdwOifM1tl0Hluvy7mZvnatVDe5KSzjeTC
         hLT9gRGKmC1Lzz8tmzQGwltNJWHO/YkO1MjOf+XyQRl4TBG+IOoOBPTPgtxwRw9sZuVM
         2wjH00/i8yaLqLqsfki/p5vjreN1vdG9dqJMZcTVh9GuPWd0ecJTTgGtLmDrQidp8yY+
         N+WjTZa557Pi0zqtgW/gzpO7zagYzT4ipG7T+meG7EAi390S62qOiwAHBJ0pWzyqKqno
         EfoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmbzko3GGM35JfidDNsE57kQzeq6i7GYzQlLq8dzOClldlXmtGaRk08FB32fqw79Q1zHie13DcRdT2rDC/tvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kfjULSltzSBz6EHUdavvOZWPNkH0NAgivQ+NNUFBENAD19mPoj
	kfsRZsag/k/PFQ4hEWtqA4UyH3HhNHeogSsd2E0uJwkOVJCUecDihZov
X-Gm-Gg: AYBFou0Ey7Hq9lQv6UMSbpV/BsFRJtLxor1KsLZS5oQCbLp9b1Wov9cBO49b/1b/cYa
	SzT1Np6y6rwGVNW0eo+cpfqyjl7bZzBt49duN+F7I7BMk+Od2IGTJ0F9vnb5hAFbfSTbUuTmos+
	USUuzobRvQAuRrBGy3nvLZKt84g76771NbH1MuFNN7zu7euB9NO3u/se2r1rjj4zC6wkxiNj1nL
	To1YS0RPF+iSSBIfDhPHh5R/dB1wZXmCTypgOa2U6jcqGn4z/nn4POKcWzEkWE216vpdsjWiVa4
	NF3GxJRlgS8NVAMYYz5on8w17fhqJeu2VXS4GEOyqZVb1u9Axtfi2cNsDRrPKtgjwyYN9MOjgsL
	jwD6RYokRtqb1M4uWE3V3F2QKvLCa0YRZ8F46MEHnkr1cU0tKCdgIkzvnLPpVju853CSUlIKN4R
	uqY+H9JXb/wwUTcTW7gRBpzXjaeKFb3yJzM8s8PB1Wvf/hQeBw2d4HRigsrqKUDrFByfUi43/Nx
	J5I+b6UevtoUSK7d0Edag2w9UUNVlxGifaAFJoxvuz832q3lARkWIKsXtmHwT1XwzVjSuo=
X-Received: by 2002:adf:e18e:0:b0:47f:e721:1f77 with SMTP id ffacd0b85a97d-48488f0f80dmr24176f8f.13.1788295284572;
        Tue, 01 Sep 2026 13:41:24 -0700 (PDT)
Received: from cdev ([2a02:8071:68c3:bd00::8998])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm1511223f8f.34.2026.09.01.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 13:41:24 -0700 (PDT)
From: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>,
	Sergey Lebedev <lsa.uz@pm.me>
Subject: [PATCH] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Date: Tue,  1 Sep 2026 22:37:44 +0200
Message-ID: <20260901203818.112189-2-vladimirkondratyev2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_set_dxstate() falls back to checking the controller state via
btintel_pcie_in_d3/d0() when the alive interrupt is missed. However, these
helpers read boot_stage_cache, which is only updated by the interrupt
handler. As such, if the interrupt was missed, the cache is stale and the
fallback check always fails, exhausting all retries and returning -EBUSY,
causing suspend to abort.

The fix involves re-reading the hardware register before the fallback state
check, consistent with btintel_pcie_resume().

Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")

Signed-off-by: Vladimir V. Kondratyev <vladimirkondratyev2@gmail.com>
Tested-by: Sergey Lebedev <lsa.uz@pm.me>
---
 drivers/bluetooth/btintel_pcie.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index fda474406003..7fca8eea6e01 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2778,9 +2778,13 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 					  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
 
 		/* A hardware bug may cause the alive interrupt to be missed.
-		 * Check if the controller reached the expected state and retry
-		 * the operation only if it hasn't.
+		 * Refresh boot_stage_cache from hardware since it is only
+		 * updated by the interrupt handler, then check if the
+		 * controller reached the expected state and retry the
+		 * operation only if it hasn't.
 		 */
+		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
+							       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
 		if (dxstate == BTINTEL_PCIE_STATE_D0) {
 			if (btintel_pcie_in_d0(data))
 				return 0;
-- 
2.55.0


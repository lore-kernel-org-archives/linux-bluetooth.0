Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7522773DA
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701923; cv=none; b=feQXVv5DS8rGMWFij3rx0elSH8a+5nBISBbATHnpPSzTjsMdaLAajq9jNGjNobh+1d8rRIgtUTI58uFG9/hBZ3FdfaBoO4NRv7qWwZcwZO9I5RNvRAWtDcNXi69mN7IvW7ZrgScyKf9rU6zG6pPs7WU/tKL3rdOZrT1zNjfmwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701923; c=relaxed/simple;
	bh=G7KuGFXke6wrTj1iOuTGQ/WiPLOkEi7ZUVUNM5wHT4c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g2VfP1vSGRiFaSxzyrC8ovOzrWMdrRVSdRAaaoUsw8ovqqU36iqcW1C4atK1H9XX2sGtUTs4NH2YEk+fXwn6lAKefgOOuN7+cqmBeErLAYWkHk31Y0YHDnniYNXRAi3gEjE3qCs4cprdB7+s0/VgOUiauDz3S9CpCmUTGOskoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr47rzI4; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr47rzI4"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-50f831f6b82so693787137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755701920; x=1756306720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LuiMHM/qdYzBFF33KdXfMKW7k6NZGWrSfnb61tTjX0U=;
        b=hr47rzI4pSWHrDNIDs4kWt3tNgjwlnt3rw3oh4VcjM5Kvo16TYvOYAROk9PXvn1shj
         jtp8uL/+bpfGJEgXUzVz3H/yE+fnho/Vjaa/0xpEMu3FoWouj66D4xJzqDBI7vG7vaNS
         pCzyDJIEqPCg9p1Ow0xtKwCdEzg2z2+n9sR2mmpzr5/8b0zxlZcgPkqGB6xcCnSW1RCt
         n04O5XZ7dj7wTXOQ4xo/YygwHfE27RQRHcJINYuGp7LZ4imjU8Uu1FoH6bK/f/17DqHs
         JL3A9GlrbjJChITOxUY54Fa4XhcLRbTYYpUn7EOPU3P0hIq65dSkyFs+ZCHBq4IIpQet
         wJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755701920; x=1756306720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuiMHM/qdYzBFF33KdXfMKW7k6NZGWrSfnb61tTjX0U=;
        b=OG7QQq1oJ6BOpe7cXncgdjhBZP4UVuK7kJQtCVXD3pu5ZFLTTok+1MlMGxgnrkUz28
         aXt0PIHTQLmDXEE0D3nGFotmlvNwM/GktvWMg0CmILp/YYWymJ4UXSsr5g19YBf0uCvr
         T9QIfp1dGsQze/uILUqp2yjUXUKDnYxThtH2FFpSp80QflYneN0bBtQG52GWyGUD2ccI
         9Uei1gag3pqb6KU2kR6XgcqpOCSipjwv8gb2nNGDW5+KkNdCIjupCtutO/QFlbJLP1Pt
         2aiAvtBbegtJhwg79eUrZUXJQoOEG0CXQB4vA0sODinIIllCMTUjkbaYJNccLemIpaed
         2Y5Q==
X-Gm-Message-State: AOJu0Yw6WMyWmx/Ro/SdMz/TcdfgNFncUibMRLFqgGJEEc//bORYACde
	H+uoiK1SaMdhBHTPs4qmcvie4y9y9/pLQCqPJYpBHp8wjMGYcRYN3jVhM9Acow==
X-Gm-Gg: ASbGncsLpkw9CBl80AHGooIO+QZxEjG5xV9CrjwtOq/m+2ea1K2JaoMCWAjMxKVSvZO
	I1In3bcVRpGtMZayW0E0ufIEggUkhPdAPR+W7WanCR6Ei0oKyS1uZGa8LoIETMaES1KDGuhtRME
	8Dv/aJQJ6gzVSGlqXHS+T+WUZUDGMGElNb6PFDgMA3T+rwgdGBohfe6XyzURFJHbrS3u+jPfmUT
	rGW0CGyWsKQU3foy9QEdwDU9h3iuvizRhoI1AdfHOX91SrRACLMnMU9uKyCR0ZdA2wHnsflJXTP
	wFtJRMrFKTz40Wg7u9Y4O7JBKdI5Hlpu1mWl9a3or40rUFCIVd9GK+vMXNESNjha9VNd72SJszQ
	vffvamkz36cdpZbIVi9aedez1/VztKG4P+LdszYnrowiHiNplnJ7ii3DZGTGlEfrW
X-Google-Smtp-Source: AGHT+IHG/2RE9ukQFH5+YtWJmNk/nveB0mmNi0WTdcmUS1bvX24A18tRMOqE6rUH8ssSAk275rmlgA==
X-Received: by 2002:a05:6102:83cd:10b0:50d:feb0:316e with SMTP id ada2fe7eead31-519238331d2mr1401623137.2.1755701920369;
        Wed, 20 Aug 2025 07:58:40 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89218a5c338sm33075241.13.2025.08.20.07.58.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:58:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
Date: Wed, 20 Aug 2025 10:58:29 -0400
Message-ID: <20250820145829.1766185-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The debug UUID was only getting set if MGMT_OP_READ_EXP_FEATURES_INFO
was not called with a specific index which breaks the likes of
bluetoothd since it only invokes MGMT_OP_READ_EXP_FEATURES_INFO when an
adapter is plugged, so instead of depending hdev not to be set just
enable the UUID on any index like it was done with iso_sock_uuid.

Fixes: e625e50ceee1 ("Bluetooth: Introduce debug feature when dynamic debug is disabled")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3166f5fb876b..2db93b70e07f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4413,13 +4413,11 @@ static int read_controller_cap(struct sock *sk, struct hci_dev *hdev,
 				 rp, sizeof(*rp) + cap_len);
 }
 
-#ifdef CONFIG_BT_FEATURE_DEBUG
 /* d4992530-b9ec-469f-ab01-6c481c47da1c */
 static const u8 debug_uuid[16] = {
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
 	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
 };
-#endif
 
 /* 330859bc-7506-492d-9370-9a6f0614037f */
 static const u8 quality_report_uuid[16] = {
@@ -4468,15 +4466,13 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	if (!rp)
 		return -ENOMEM;
 
-#ifdef CONFIG_BT_FEATURE_DEBUG
-	if (!hdev) {
+	if (IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)) {
 		flags = bt_dbg_get() ? BIT(0) : 0;
 
 		memcpy(rp->features[idx].uuid, debug_uuid, 16);
 		rp->features[idx].flags = cpu_to_le32(flags);
 		idx++;
 	}
-#endif
 
 	if (hdev && hci_dev_le_state_simultaneous(hdev)) {
 		if (hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
-- 
2.50.1


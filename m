Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F84052A2
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339264; cv=none; b=clRWg1Rxa1cew8zufaxUmn5Z1+n7ka1rosrS0CPY2HPfy7qgifSTGEdI2HslHhnHXFuai/49C122dU1nhmjgeywQGCns/ukt9FcpYS4lAcSuqeJSBdQmNwnGqAMV54z1sivysWGoQlP/sk8g0jrRXudv4woRdaBezxORSpKSCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339264; c=relaxed/simple;
	bh=FTZvxnJgmOJXIylCJGBhAmG9TNfZKGbZ0On++E5Oqeg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtICKKt/EE10pHXPwkY/zlB7qQ+EOkV/ZlqhIBni2mZ6xO3JDRNJlGdS24UHwq+cQU8oQy+/V5MyBMUeKWnJexXKEQ+seA9InCsbovBd+m9/IAyngF8B3gE74B9UMXi2kXdc5rUvmSgId/Fede0TPyuwhkETHnpqBHZKxmOPU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCC99+bY; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCC99+bY"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7466771f1caso411668137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785339260; x=1785944060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zbzrFLRsHcF82vTXp3HI4m2wFpO5PWZJ3g7zftwDtnM=;
        b=bCC99+bYmOt8K5dwZ7Ld/zPbC9GyMa/sDuUX9k51iKCy1lY4tBnzNOt4DyZx7Mhdzt
         JubL67/nD1F6aqA1qKKL4iLDkjTDh1SmVum7W4QWNPAsTYVK0ICGtG7NoNRvmocp/Aac
         X78R2IXO2JkwDR1FxKQYV+LF9ucN0ssch1NWSDXqr71BcdM/F84yTGHbNpoz+FakrfI2
         mUlh1kc/zXlmmI1DtjdHKd/6Wy0D6ZB2yFgQ2J+feXrrfRtl8KgEWJg6tyRlZIZbb/Uy
         b+PRQQUqDiNJMtWmsmWs9qyCExf7mS0em9kUpoDwlQry0cYbroVOjyR1xycFKD3gThDV
         zoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339260; x=1785944060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zbzrFLRsHcF82vTXp3HI4m2wFpO5PWZJ3g7zftwDtnM=;
        b=aUiRRQ8xBhC206Lu2PxOC7Fol4G69pv8brHC67OHTh9nkCrnBDtDRB/xZwuhCQV0q2
         l1ZIiZQWltMVB5qFFoE5Uxxuqn19YrzDXEOZ3sO64RtIHKyKbzQTFd1IP7QMomkRi6/Q
         wT41PfoexAhmtZJDh5Y1jfJBgvWhojJzygRONSXaxVveVd6rrcmbTj94HHfPK9lZE883
         AVAvYu4JoJEx7D4IDnYriYfQUVWCnu7wq4yTvfIFa0N/jVJTUraR6V098T+ag1DxmbP0
         0k/wzKGnvEVh+NuAK31hSuoyq25gvSDunYgjnahFIm66Y8W7mqmFnm3fOsXx+jBi7D79
         ibNw==
X-Gm-Message-State: AOJu0Yy2ZwyanYBljyivZtrlgtnmDRI/IttXGDIA6UsyUhxVPwIC4BNt
	TByHxGX58+MVkUHWNKuCW6NNS9/pj4gz/muMIJ6ko4ZudciYho9FPmNrPdotNX7c
X-Gm-Gg: AR+sD11uwTPhz8W/zi1kwS4oHlS67gayygiKbpEWAYBs+yhOHtwvF2rHA8TWdaftAru
	As9OH7rdj+C/gqVjpATa+igb1VIvSD82Ln/CRpUn+w0qIobPnjOAelqJuvnJuJPojZooP9XMi8g
	dsBqe2xkL36bJTcV9h4lS2we7WDsFGGSgPmnE229/71xcqRyd5giFqVWQNXzVmML5EMsg5rpbQe
	e1i7380gx+Cew8nt+mKqMkOmo5sG0GkDsxfur+N2VpZP/n3ee7CPCZXAigi7GnUhDjnnaYzgq6q
	6lz4JtWRu77bZUHYACDOusDa6g2CWnmnDWMw2RMZY2HQDjynNXaHmQDH5za+MnZopnhOWaITzW1
	CNV4p5VtM26Z0NKJiTVydEIt7IvIyLtJk4DyWQTuF4BRn2LX/nnMm/gWeifNvpQKS/mtfJwBMRC
	e9LbgtsoyZ5sLrG1N4k+HqyKW3Vrodyfj8o3JnWl0S0u4OZqDLeX501j7Vz3oKTwO5tZuT7gFl0
	auUdJpR7jA2CU00/iSNgcfPSALD7NXrAjQwPKNWTnBcd9mfNScVTaAkve+RxQCloy5QmA==
X-Received: by 2002:a05:6102:3e85:b0:745:7f23:a876 with SMTP id ada2fe7eead31-7549f1461ecmr3279954137.1.1785339259493;
        Wed, 29 Jul 2026 08:34:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-755a74c0b80sm1820585137.4.2026.07.29.08.34.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:34:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: Add MGMT Shorter Connection Interval setting
Date: Wed, 29 Jul 2026 11:34:11 -0400
Message-ID: <20260729153412.2564039-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729153412.2564039-1-luiz.dentz@gmail.com>
References: <20260729153412.2564039-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add MGMT_SETTING_SCI (bit 25) to advertise support for the Shorter
Connection Interval (SCI) feature. It is reported in the supported
settings whenever the controller is SCI capable, and in the current
settings whenever LE is enabled and the controller is SCI capable
(SCI has no separate enable command, so it is a passive capability).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 include/net/bluetooth/mgmt.h     | 1 +
 net/bluetooth/mgmt.c             | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8126fed34613..3c279c032547 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2084,6 +2084,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define le_sci_capable(dev) \
 	((dev)->le_features[9] & HCI_LE_SCI)
+#define le_sci_enabled(dev) \
+	(le_enabled(dev) && le_sci_capable(dev))
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 08daed7a96d5..b285441db55b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -118,6 +118,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
 #define MGMT_SETTING_PAST_SENDER	BIT(23)
 #define MGMT_SETTING_PAST_RECEIVER	BIT(24)
+#define MGMT_SETTING_SCI		BIT(25)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4fd37ac79986..58f01fbfcf71 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -861,6 +861,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (past_receiver_capable(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_capable(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -952,6 +955,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (past_receiver_enabled(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_enabled(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	return settings;
 }
 
-- 
2.54.0


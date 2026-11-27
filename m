Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769742;
	b=uXGSxdLRNADIqCC/FB63mFSN8XOsI0gb7yw7KB1wi0EW0HzEUDTaeBnrrEhh8FXNRw8g
	 b7hWnzSsOTu1iAynh4fx56LNABShiuZkj6UFDH0YLHux7L25MsLP2JmFnqiOkke0U1MHK
	 JBN+FGQnNiUuZaXwBroNw2IJx9AsgrAzz6OhiY6CMkNXOOLbWGHywnDmoPMOcnJh6T4RJ
	 LbWoxHxjYCZVE7c8NyIEh3ch3lxSMkdKF8DvaPYocDtFat4IjWoXirvug8D3ff1VPSzD3
	 P1Mue1x+IV4M4fSxKh+jF5CjLFYVRPHh3aoPJBi2A05YD3Cm7Z44FLbGBh5Y6hw8Fmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wkmASdNojnE/dFdJzl488IUck3iPOOUDgyjv66vYn00=;
	b=TIC2CcCd7BapMsGsEH9pN1LYeSSyD4ajdiMQSvxvdcTN9OqRQZxykrwJYQcXwZKMiw8+
	 nfU3ao1TNRFLQQqKK0t5PGwN0uHkkLbQaSDr2pZc3mJX+uhIhKZ3Er9rayUEg+QMYtHRE
	 o2MGJiWjuNFkmWPklqgrmAijX+Wet+5GOH5QeoPv2BlmKuSKGcH0c2kNJnJp+cZMj8zAA
	 7cG5f0keDwoEazahVQf5r/iSYF5vqTau69Qp+7300FtGpNOgJq9a9GV+s+7qxw8jUryhi
	 VdIkXyEPhVuppm4UBc6Y3S6b1Peg71qKGSZ1R4jF0c88zc14jeAXVqszFEz2+qbNW5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b4v0wC6z;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B93606A336
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0B93606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b4v0wC6z
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a3ac4ac65bso447799f8f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769740; x=1796374540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkmASdNojnE/dFdJzl488IUck3iPOOUDgyjv66vYn00=;
        b=b4v0wC6z9FtUBDaLlDR7BBiQmvAMEZp740PcKhVTpWGN122E6p4YE4lG0yLjWk/nwh
         VKLLq4qRsTNdx2fNLGNXs4V8COh0xDk4rgO/TebfCcS7ZplB6HPIkIBqkVdjANK1uT5q
         TtRY2yPwfiQHuPm/Hz89u3DvUoynUHxCTF9jgYTeUEQzXSZwvWfPx1uoXVU1hsUa+9ms
         7wIFGIP/6QpvDzUgNpIdOer9g3EaWMIzQt3RY1cNZpJ4781gvqGl9ax/raGMxwniRNQL
         Zqfz1uwHZOMZgBgH37BmjKyOK+5lmdL/J/q3fpRgeZ5QI2YN8R1N/lxN9tZDhbzJFpei
         zJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769740; x=1796374540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wkmASdNojnE/dFdJzl488IUck3iPOOUDgyjv66vYn00=;
        b=HaNUkVXXviBYIa1UBvmU1E7G9jLPsB08cAAG4X2akAvVgOMD0YIzsAz6laVhYU7bxB
         T8gxlfJlQdNM4e5VBG/z8BPSfPspDjNnklvaqUrfKfQyJB9WNXK8mcqKsuLv1QlNtXPk
         pT65Xrp7/IQLfUiZJO8pIUMq/fPWWbyoS+cM8wbCHlzFF8+VusbxfzVIe3Gxk80YkGZH
         Lm/VZ1b3IB8hhJ4aRkU+/fTxGLbhdjPYWX7kx3Vr3UG81hJZGxdUPbQRoxlj43jO7cKy
         s/6xv/FQg1X+7vjzNrGgZyhSs06S62//2cm0nV9ta39wlk/l8CTNtPKBrVGm/ky45qOO
         5CVw==
X-Gm-Message-State: APuU4Z8/4vp3KtgjU/M6y6ss2w/aKlNjsONtEn1IrIGiVRR+Hrbs+596
	US1f32/96xoalZQrO3zqfEd7c8AkxjAk5JJIcCnEnI/kbdECTMZA7wLZ2EAlUNtZ
X-Gm-Gg: AZFdTZeqJCD2siNJt+kuPgyR0vEeztugtK5mnQr3CaITjlRHfpGOP9S+ujM/W9tV053
	C9ZbCveHaA8DZj1bUNVRzF9Qj5xihnlTftM62ol+shuNvvIwANCcUAjQT44i9gI0ULsq09bGges
	u8GAkOwD10qsMrwEhUsZtCM7Lzc1iljmmw0JHfDJuBJMvk0HA1aozaiH4j2/5C96KUFX461ymfj
	vouCOEoHcv8zNX4U14+LdzsrtMSIREE0+2CdC84kxNF9pBWVP7kBD4xfkVF6e0IJ6dMIEh+OOYw
	JbfZGfsJ0yVqGDf1ViWHQVCOKmFlGVVfGDbjPv3vGAWzkyxk/xOj+esqq1m4qItoDVhQGavIegH
	Uo3JkFcMmQNkfg1CSArYgi2/BzCS02kovgoomSL43ppR2ftOHtsiDaVimbGtvXjGt1CbzgsOLFo
	YNv2prc2cizET8YOQzi88IYwcQcY10tK1KckUYs1l+IEFjdBzHkMMMjYiF/A0ueAEJGyM8hpnBI
	0kkuWzUYUDXUThbMagDkp9sxoHPqKMNZmeh3o+ljzT6A4fWwoKJ5VxhbDZLrU1KEdO5vjmZprR3
	0uOdt+BR6yjtRvKorUFZ/magP71bLjKgLm8=
X-Received: by 2002:a05:600c:154c:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4bb887f43d8mr455514395e9.1.1795769740170;
        Fri, 27 Nov 2026 00:55:40 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:39 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 7/9] emulator/btdev: Keep advertising sets with periodic advertising
Date: Fri, 27 Nov 2026 09:55:23 +0100
Message-ID: <20261127085525.264299-8-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
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

LE Remove Advertising Set and LE Clear Advertising Sets are answered
with Command Disallowed while periodic advertising is enabled on the
set, as the specification says. A reset disables periodic advertising.

Assisted-by: Claude:claude-fable-5-2
---
 emulator/btdev.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1140acd90..c4ade031e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -266,6 +266,7 @@ struct btdev {
 	uint16_t le_pa_max_interval;
 	uint8_t  le_pa_data_len;
 	uint8_t  le_pa_data[MAX_PA_DATA_LEN];
+	uint8_t  le_pa_handle;
 	uint8_t  le_ltk[16];
 	uint8_t  hdt_def_mic_len;
 	uint8_t  hdt_def_format;
@@ -693,6 +694,8 @@ static void btdev_reset(struct btdev *btdev)
 		btdev->inquiry_id = 0;
 	}
 
+	btdev->le_pa_enable = 0x00;
+
 	queue_remove_all(btdev->conns, NULL, NULL, conn_remove);
 	queue_remove_all(btdev->le_ext_adv, NULL, NULL, le_ext_adv_free);
 	queue_remove_all(btdev->le_per_adv, NULL, NULL, free);
@@ -5981,7 +5984,8 @@ static int cmd_remove_adv_set(struct btdev *dev, const void *data,
 		return 0;
 	}
 
-	if (ext_adv->enable) {
+	if (ext_adv->enable || (dev->le_pa_enable &&
+				dev->le_pa_handle == cmd->handle)) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
 		cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ADV_SET, &status,
 						sizeof(status));
@@ -6003,6 +6007,13 @@ static int cmd_clear_adv_sets(struct btdev *dev, const void *data,
 	const struct queue_entry *entry;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 
+	if (dev->le_pa_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_ADV_SETS, &status,
+							sizeof(status));
+		return 0;
+	}
+
 	for (entry = queue_get_entries(dev->le_ext_adv); entry;
 							entry = entry->next) {
 		struct le_ext_adv *ext_adv = entry->data;
@@ -6036,6 +6047,7 @@ static int cmd_set_pa_params(struct btdev *dev, const void *data,
 		dev->le_pa_properties = le16_to_cpu(cmd->properties);
 		dev->le_pa_min_interval = cmd->min_interval;
 		dev->le_pa_max_interval = cmd->max_interval;
+		dev->le_pa_handle = cmd->handle;
 	}
 
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_PARAMS, &status,
-- 
2.47.3


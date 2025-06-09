Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79525CC47
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479921; cv=none; b=apPhlb4QuYIAa1c32FpDfMP3fU3A8hcmdN5xifenUc2XyP80j2SrhOBe0ZdnU5mjXXoKMeU89Qa6xdJG4LT+p7jb4gl1e9l6y8AdU2wfKS0Ij4Yh7o3SfPUmZzCeFU25XQpERgoKYY56e+M+3sSIDHXUabATXIFouL8PNgcwKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479921; c=relaxed/simple;
	bh=CARJzuCD62NiugVU5IfvkFLzmfWKWprypgaZ87qOQog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ne4oaZN1gfpnfNxixlX74mAZgMifay3gaXmvLL5q3CrmYN7C0Bj8KZzPu/EOemWBtH+gnDAIyVH+7pKCrIVr2CpAnT637IxEKvQMkcuRPRv+GAQFFjE57lSNf1h6sGUpk6nn+J9plkob3DAJU85Ydy3AKK+A/TwWGulKiJtSC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhN2iEoC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhN2iEoC"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad572ba1347so634111166b.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749479917; x=1750084717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aByIZHicOQ2HsLCTCCgDEfZpuMBO3JBFAAo4do5Gh+w=;
        b=ZhN2iEoColi3lVjdMUKX9erEr3abLTMVID0kx3p5otCRPj+g3cgthPiMP8BNgyRX9/
         TAsgWA8WpHS3HX5uOWjESMs+LyzDjZ4DPGC2RRsFrH7b98pr+xslD+9GSPSnUXWoAeU3
         uZJYLxmNR8Zbm0ggwyNe8RYBTAt1ji3y2uVvuh1mrazqEdjElFZfbOPQkAQYopEJypp8
         2YVuUYEUd4QnWKXLM//v8bOnhw2o18FI+366ZD5JdLbUG8YQp/gd5ku4cKogTc9Fs4wj
         CXPKG0aPtsObkkWqrO9CfGFv8o6Ckr7NByBAeGHnNqIJCxCvg57iL5M2SAtKNj5f3U7l
         mmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479917; x=1750084717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aByIZHicOQ2HsLCTCCgDEfZpuMBO3JBFAAo4do5Gh+w=;
        b=oWhfNgTHzSLsw57s14XpDfS5m7MixY8aQT/YkFcOAgyumfPoImLqMBhi2/KzSMMWwk
         LPgvOqE7QUFKRDowk+rl8WZ4i5uquGUFr6Z3mPyrtF2Bz3X98oTRi7la4JEr3vzGuFCz
         bJg0ox1Hxq6xE6xzNajh9MtCHyT1aTEutUswt+GvtzCu+w1xcypNcuysJvt+ZknhPW7V
         OyPSZOoPUT5zK20ULHbCwYo5CLgcukkmlO09w9t9HbLCDwY3EmrKo0dkzK4BEysTb3rW
         Y98DahubwnIUz3hHbbnDCQVhO+CsxLEKMwV2VlPE1GKmL0efKdCRVkTqpwPVXSZRy4sM
         6hHg==
X-Gm-Message-State: AOJu0YzfpKcYeRWN1CznsEo6eSHNyj6pQHcW/AaMv8iNXgpg/YGQ78nH
	knTehjFArgn1tunsqwfY/KcPSzopaVvQv5LR9OcoVIZjOOdnbAA708vgKxrUWw==
X-Gm-Gg: ASbGncsWD78ejTVpfAhQcbqISxa+i6ewzGOj/+YrIofGDteVFYF4LiWIesYURVmV1fr
	4x+QU4smaJLSs5xV19nf/rKCJG2tSz8Vava3UybqIIGmivDCXFaZbJJCzOOnI0QVFd8vegd9gst
	nZbErdArHPc5ULGi4cobikVghNa1i9VyiqRkhdrxYfDodKesvAOXWzptZorULLjdR0jqbjxfS1L
	CEUAbSskCiM6LQN/fEMsWt/UCdNM/FwKYm3sMSOp4tIv10uyr/z/EOOV1xbzgFRStvz8JHuPg4D
	IGdK8RVWrTvjucmUpEyZ1ief0LPqtk9bXQZnBOOpZuL3Tn88MG6UALy0lzfPCyI2Xfpv3uliRt0
	TKwFb0MaDYldEBcb4XZI=
X-Google-Smtp-Source: AGHT+IF3EybT6bfI8i/e7uzeth+78zo7igmTGQ8Cc79DQRFADJY9LiCX7wbzyfMxbbB44tZAWWuBjg==
X-Received: by 2002:a17:906:c145:b0:ad5:6969:2086 with SMTP id a640c23a62f3a-ade1a9c786bmr1200823966b.37.1749479916774;
        Mon, 09 Jun 2025 07:38:36 -0700 (PDT)
Received: from hyperion.tail59961f.ts.net (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade34ea5adesm452017866b.80.2025.06.09.07.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 07:38:36 -0700 (PDT)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Subject: [PATCH BlueZ 1/4] btdev: implement extended advertising
Date: Mon,  9 Jun 2025 16:38:08 +0200
Message-ID: <20250609143811.566331-2-d3dx12.xx@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609143811.566331-1-d3dx12.xx@gmail.com>
References: <20250609143811.566331-1-d3dx12.xx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase maximum advertising data length and implement
LE Read Maximum Advertising Data Length command.

As expected by Zephyr BAP Server
---
 emulator/btdev.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7bb40670c..4cf48a5af 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -25,6 +25,8 @@
 #include <fcntl.h>
 #include <unistd.h>
 
+#include <glib.h>
+
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
 
@@ -45,6 +47,7 @@
 #define CIG_SIZE		3
 
 #define MAX_PA_DATA_LEN	252
+#define MAX_EXT_ADV_LEN 252
 
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
@@ -99,9 +102,9 @@ struct le_ext_adv {
 	uint8_t filter_policy;		/* filter_policy */
 	uint8_t random_addr[6];
 	bool rpa;
-	uint8_t adv_data[252];
+	uint8_t adv_data[MAX_EXT_ADV_LEN];
 	uint8_t adv_data_len;
-	uint8_t scan_data[252];
+	uint8_t scan_data[MAX_EXT_ADV_LEN];
 	uint8_t scan_data_len;
 	unsigned int broadcast_id;
 	unsigned int timeout_id;
@@ -4950,7 +4953,7 @@ static int cmd_set_ext_adv_data(struct btdev *dev, const void *data,
 		return 0;
 	}
 
-	ext_adv->adv_data_len = cmd->data_len;
+	ext_adv->adv_data_len = MIN(cmd->data_len, MAX_EXT_ADV_LEN);
 	memcpy(ext_adv->adv_data, cmd->data, cmd->data_len);
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_DATA, &status,
 						sizeof(status));
@@ -4974,7 +4977,7 @@ static int cmd_set_ext_scan_rsp_data(struct btdev *dev, const void *data,
 		return 0;
 	}
 
-	ext_adv->scan_data_len = cmd->data_len;
+	ext_adv->scan_data_len = MIN(cmd->data_len, MAX_EXT_ADV_LEN);
 	memcpy(ext_adv->scan_data, cmd->data, cmd->data_len);
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA, &status,
 						sizeof(status));
@@ -5008,7 +5011,7 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 		uint8_t num_reports;
 		union {
 			struct bt_hci_le_ext_adv_report lear;
-			uint8_t raw[24 + 31];
+			uint8_t raw[24 + MAX_EXT_ADV_LEN];
 		};
 	} meta_event;
 
@@ -5213,8 +5216,16 @@ exit_complete:
 static int cmd_read_max_adv_data_len(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	struct bt_hci_rsp_le_read_max_adv_data_len rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.max_len = MAX_EXT_ADV_LEN;
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_MAX_ADV_DATA_LEN, &rsp,
+							sizeof(rsp));
+
+	return 0;
 }
 
 static int cmd_read_num_adv_sets(struct btdev *dev, const void *data,
-- 
2.49.0


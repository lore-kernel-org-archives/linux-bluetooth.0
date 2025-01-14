Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957220F968
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852208; cv=none; b=ua14e0SWH1eDFRp4Uj8+gcMxDDOiC8ZiguEVa1jTW3+wdrKHce8bSBw98ULsxHTIwDfCA5qaZ+91jzjrAGE3AZt5+HS6VDvN6bVEEZy+iBiANj8jLE2/EvoO8VMobrO1ESoRR/aekc4VcDFx9/3lsBNtuMK7tqB5ChQRHBu6Arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852208; c=relaxed/simple;
	bh=TG/8seqngn40G/0uo2/TuAvyW9NOt6h4rq97t0K+y2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAE0niLRRyk4Y5ybhRbQfvVrfOU6Ipa5w89VF0Ll1LfmGRGg8Z/LRYpHvWbw0pRgBjtNB/uM5HwyxB3s11gpVAyBJ1fzFK56kNRS4LAZXRSSEjke60cIdmeRZ2HqE/auMfGJoiTwk2Gi2kzkITxq67lAmNrsRTCs0nVAcitlgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjt14f6i; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjt14f6i"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa676e4f36cso66853866b.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736852205; x=1737457005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv8xOrPcHkPlaXmRS2RH96AOxuG34frapdG0yNHUuJY=;
        b=gjt14f6iO76qj3IS0/0/w4uAWeA18V6BmPFgmyG2RWVnD+RTk5ivE6Bb1kzymQfgO3
         WJ16lsjNoUJCD/Eemp5aP+0EZL7niN5tVABOFsUOZYUSNartS4qvnJAQyKRcWLzhR3nD
         CjgHwsuf1di+ii+lDPbJJT8pPF4t2eqTAufHUZYm8CM+saN8rdifYH2njw+UlOnQEvGs
         7oimhoBtQrvyK4B35/ajGcPDtPnuTGy/BnO+Xenz1I/Grs0vbLRlBO+KqisGvL636hXM
         Ica+1iO+GbES8d4yjzlI4cNrN/teMx0/xnbSlC7YlVCgAG4+26x9Zuoe3iFy9aHAVF6U
         P6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736852205; x=1737457005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dv8xOrPcHkPlaXmRS2RH96AOxuG34frapdG0yNHUuJY=;
        b=lQCsmcF9bpk3Dm2ogmWZE5XdcLU9l0VlfgK2LBy8YWMfaLHEX6Bd/OG0U9asC/BwrB
         3nw7UMngIqBDGJME8QXa+0xA8Lma2UDIH9MYhAJjyoHLuoigBg5QEXfzjNt8thtpGiBq
         Pq7rgGnZ2Dl3/hC4cbynrirbb0K3M4jvXXzjD0JGwWu+Flg18xzB4XZpvTvJCITCjwSq
         wVGnVuZVBtOOvq9L899Ojfmz/QLq1Li/QIY4jUzlrpfw4bWm72iPIPxQown1cj76O9IJ
         DlmQB5mHKNQfXGzws4l8EI1QN74XWqTxsjI2wUkA3PCnaYmBLncZU7febOIuofue8rJK
         fMCg==
X-Forwarded-Encrypted: i=1; AJvYcCWZT3nP4aUJzFX19mQw6GKzqk9uUbKszAa/op6D/+yw5bSXtRB3zo06PQIYTd8yGyO8Nw6ttKFmaM2gTW4ore8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7X+Iod+U2YXhEEoohV4EZHyB+jXheXTbrl+oQtT0T72b+oZM
	e04yadxGrOkqdo8NCu6Seqjwwt+HuKDXkBTuERY0Kczvm2EC+R1w/KO5YsvOvmc=
X-Gm-Gg: ASbGncsJJ+HcgMPU4gWbWXZPER0S52OP3erxP06MIJ0H+E+drpGYayXIF2Fiq6uo/V6
	APJTV3Au002rb7rgAq2aOv2tEU+hml7NsKVz8L68ljbY8Wd+FkvJRrIlEhAPkRTxS56Rw5R8B6/
	XVZ1V2+ckIduEBYLmm0U8HNMNpiaVsBV5Ft5hkstJkDvKE0FyxK6CNYhKwyF/Uco4hycqbJDtex
	DeIWf6+yv7+//Yyi31XUWqpasqAbqceNwLE6OWyA7E38SM2Mdh0JEHekbf0tL9s535SmKs=
X-Google-Smtp-Source: AGHT+IFDYSZs2EgXOxOs0j3TmkpApoppsmbQrtPhAy21A4L/1ijy2TMTCPfDFzQkImZHkPV0ZUNLKw==
X-Received: by 2002:a17:907:d1b:b0:a9a:1a17:e1cc with SMTP id a640c23a62f3a-ab2aa7d1518mr822062866b.0.1736852204563;
        Tue, 14 Jan 2025 02:56:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95aede8sm616837166b.136.2025.01.14.02.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:56:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Bluetooth: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 11:56:41 +0100
Message-ID: <20250114105641.273451-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/btintel.c     | 17 +++++++++--------
 drivers/bluetooth/btmrvl_main.c |  3 ++-
 drivers/bluetooth/hci_qca.c     |  5 +++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d496cf2c3411..d2540b28bc7a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/regmap.h>
+#include <linux/string_choices.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <linux/unaligned.h>
@@ -506,13 +507,13 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 
 		bt_dev_info(hdev, "Device revision is %u", version->dev_rev_id);
 		bt_dev_info(hdev, "Secure boot is %s",
-			    version->secure_boot ? "enabled" : "disabled");
+			    str_enabled_disabled(version->secure_boot));
 		bt_dev_info(hdev, "OTP lock is %s",
-			    version->otp_lock ? "enabled" : "disabled");
+			    str_enabled_disabled(version->otp_lock));
 		bt_dev_info(hdev, "API lock is %s",
-			    version->api_lock ? "enabled" : "disabled");
+			    str_enabled_disabled(version->api_lock));
 		bt_dev_info(hdev, "Debug lock is %s",
-			    version->debug_lock ? "enabled" : "disabled");
+			    str_enabled_disabled(version->debug_lock));
 		bt_dev_info(hdev, "Minimum firmware build %u week %u %u",
 			    version->min_fw_build_nn, version->min_fw_build_cw,
 			    2000 + version->min_fw_build_yy);
@@ -927,16 +928,16 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 		    le16_to_cpu(params->dev_revid));
 
 	bt_dev_info(hdev, "Secure boot is %s",
-		    params->secure_boot ? "enabled" : "disabled");
+		    str_enabled_disabled(params->secure_boot));
 
 	bt_dev_info(hdev, "OTP lock is %s",
-		    params->otp_lock ? "enabled" : "disabled");
+		    str_enabled_disabled(params->otp_lock));
 
 	bt_dev_info(hdev, "API lock is %s",
-		    params->api_lock ? "enabled" : "disabled");
+		    str_enabled_disabled(params->api_lock));
 
 	bt_dev_info(hdev, "Debug lock is %s",
-		    params->debug_lock ? "enabled" : "disabled");
+		    str_enabled_disabled(params->debug_lock));
 
 	bt_dev_info(hdev, "Minimum firmware build %u week %u %u",
 		    params->min_fw_build_nn, params->min_fw_build_cw,
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 18f34998a120..e26b07a9387d 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/string_choices.h>
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <linux/mmc/sdio_func.h>
@@ -88,7 +89,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 			else
 				adapter->psmode = 0;
 			BT_DBG("PS Mode:%s",
-				(adapter->psmode) ? "Enable" : "Disable");
+			       str_enable_disable(adapter->psmode));
 		} else {
 			BT_DBG("PS Mode command failed");
 		}
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5d75087cca99..0cfe40393600 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -31,6 +31,7 @@
 #include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
+#include <linux/string_choices.h>
 #include <linux/mutex.h>
 #include <linux/unaligned.h>
 
@@ -343,8 +344,8 @@ static void serial_clock_vote(unsigned long vote, struct hci_uart *hu)
 		else
 			__serial_clock_off(hu->tty);
 
-		BT_DBG("Vote serial clock %s(%s)", new_vote ? "true" : "false",
-		       vote ? "true" : "false");
+		BT_DBG("Vote serial clock %s(%s)", str_true_false(new_vote),
+		       str_true_false(vote));
 
 		diff = jiffies_to_msecs(jiffies - qca->vote_last_jif);
 
-- 
2.43.0


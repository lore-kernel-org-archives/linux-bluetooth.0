Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8049659
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940856; cv=none; b=UT2yVRvtC7k7TfE5cICkEEt9IW8V72OHlceIq4iEuC0tHtdYsJM1eY02APgSx+/lS2SIqDJVbgvh/6t7MIXlKeAID5ta4/WH3sdiNqIhtLJ00ZKveMoSQ1HqflqFIA47HHXXl2E8jTlrcPhLxw6ZwlhnRoPDY4hzYm1eDseGCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940856; c=relaxed/simple;
	bh=Jmbn9FKn0ok8sGgVoqY3qtPe94Odyq/GLVKAqsWx3GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPBLyDsLWNMZzy7bHYUFpsvu39NdKY8U+qUffOD0pctsjO2MxQn0MR5y4Amht0X+fLzuqOfAL0WDiB6xshaX9ZnB3OGk8PPPIQvr/9D0r1smFHrScXsfeDdUn+rtUrInCDOClo1Es+yhPCP8w42VQ7+TfOO8xjSoI0RQLFF/zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=I+uALB1q; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="I+uALB1q"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60410a9c6dcso68293a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1748940852; x=1749545652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVInuKL9ig8LdauoSC54cVMi6mpCZDxCkLHbsXtjBmQ=;
        b=I+uALB1qxUEMXyojPSpnUxi/2Y4Z46ult4MVTdJLmYtMt6qwoU9vpklxJQl5YsiH5T
         mF91h/5QsQVG73vxcBFmsFKi05WPqwYwcN8OOeXGLdZ2U86Esb+R8jYyxtizlTE8LHsl
         Y+2ND7R3NGsY27Vf8I3z58yVxwIDhbLOlsIsfmFZZ7LpcWk+lPmiInSM++GvP/0c8MN4
         Sk7XyNhhrMuIopn0r3HRq0Q+GIWGMnJSbwJK991wTC+QtKT+AIEig76zkx/G5f9ObY8Y
         fHGpa5x/hf2+SNQEZUUzExw18F+/36mks1WSZ0rKumMIq9Zfkqz+zJhhr1O/peCjGhkc
         6j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748940852; x=1749545652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVInuKL9ig8LdauoSC54cVMi6mpCZDxCkLHbsXtjBmQ=;
        b=ksU9waf6Gh6hhsYgbqO3K+jOycr6tC/Q+2acxwJ9HB5hYrYx7Q2iuzK1r+wpWLTlgJ
         8AoXA1MApF+mSNXBPmKnZe9fPMlTw+Ybwn5SDSdRa2GUa+LiT7urrOKILIySb2lLZyKh
         6qBh1uL0eDYbqJOLtA1W3FJFaGlCYpumhi0XvhSGNCRR9ex6EN4mWIwIVFcF4YoTBxJu
         JABtAYmy6P0zqiMbg7sbgGFpRc+WAZL4qRsRZb0/eJJaqnqwZrbxe/orii/c+uTSUELG
         basujlMpQd5DpXIOuQgPJx+M5dlYXTvdqq0d/DsfVrh9ZOqt92yVwQX8hbMBsqRzSB+j
         T64Q==
X-Gm-Message-State: AOJu0YxO77LzmXCDpweCxpzVa1nCisnUcQOAcxsgztPapWIO7U+/ycZz
	MgzuZSAGvvlRLKMHCye0dXc/K+YfxhzFAD399TT4Y1dc3YUAoTn6TRvJgVzzwW5o+lRdu24Ed+S
	0aFxIePE=
X-Gm-Gg: ASbGnctZ2z9bJIxAsaeyvoAYE6W7SWwgX4Rqeku4TdoOX4Y8v3czxg3xQvXCovsSMb0
	brVnM7DRlBrPEfvkIsrl8+lFqwF/9Q2IpkBnhyPrXthVEPnKVYr/iLRdjA54cyr96zKV6/CzU+G
	W+CQmh5gx6nVzsv0T96f4S3y+ZvJBNrSD/YeS29jx+Snk2hxLp3OiDhzKEKmEX4MWTyYd3kkVDu
	CnF5HP6i8aj6SlXq5zuGlHkkAIgAxJnFCP1OVq504t/IMB+fxKE2J19L7GfnvGWWa6AMaWjhjCk
	bugUtF6TRRfYgsZZllHD1ca8F1OxfOR2OYqq7OTbvvYWXhMuAz0lMekCdSnZvBrxVJZJcxxmjA=
	=
X-Google-Smtp-Source: AGHT+IG+K1LUDc1cXDAllpL8QkZHOqK8PaRXunC7Af9L63JZl5EXlNscqn3FQvSPxX/sO+XzJDeLEA==
X-Received: by 2002:aa7:cf92:0:b0:606:a08e:b8d6 with SMTP id 4fb4d7f45d1cf-606a08eb951mr2728045a12.22.1748940841481;
        Tue, 03 Jun 2025 01:54:01 -0700 (PDT)
Received: from ThinkPad-Ryzen7.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606add9c4afsm777366a12.4.2025.06.03.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 01:54:01 -0700 (PDT)
From: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Subject: [PATCH BlueZ 1/1] monitor: Fix bit for HCI_LE_Read_ISO_Link_QUALITY
Date: Tue,  3 Jun 2025 10:53:52 +0200
Message-Id: <20250603085352.1297099-2-magdalena.kasenberg@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603085352.1297099-1-magdalena.kasenberg@codecoup.pl>
References: <20250603085352.1297099-1-magdalena.kasenberg@codecoup.pl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the bit ID of the HCI_LE_Read_ISO_Link_QUALITY command to match
the assigned value defined in Supported_Commands table in the Bluetooth
Core Specification.
---
 monitor/bt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index bc84d6b94..dd67750dc 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2920,7 +2920,7 @@ struct bt_hci_cmd_le_set_host_feature {
 } __attribute__ ((packed));
 
 #define BT_HCI_CMD_LE_READ_ISO_LINK_QUALITY	0x2075
-#define BT_HCI_BIT_LE_READ_ISO_LINK_QUALITY	BT_HCI_CMD_BIT(45, 1)
+#define BT_HCI_BIT_LE_READ_ISO_LINK_QUALITY	BT_HCI_CMD_BIT(44, 2)
 struct bt_hci_cmd_le_read_iso_link_quality {
 	uint16_t handle;
 } __attribute__ ((packed));
-- 
2.34.1


Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516E43AB7
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743473091; cv=none; b=cdF+GHABzFf7GXJegX8bsucz9VWClxm8GjmRqdTnoVO23VxOj5/bXA3fd28k6vuRFpWQ5Y9rPv4rMg17ijestnvrVPYWIy2vju8Cp1NP3vlrKOLd9B/9E+vHqiSPK2FNkEJwov8wWUT7ioR0Hhz+d3iZIzZuYi2QlucV7p4z79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743473091; c=relaxed/simple;
	bh=dlYLHy5/WHM1QFwQwrhb/tDr3KUlz40cYPmP13Ofr6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yz5A+WfpMpPVof7Hx/FUjwGPWW1UhEn7WFKmI5rg8l1uYd8UXuBxuDBoi3kroYtETMBJcQVW9R9JTDy/UtW3sszTSYuuBf2k7H6XdmJIGnIb0GqX6fTWThsEomY+kjLJh3AmBo5te/GF3KKvHOyGBKRyzj6FFdB0ijsZesOLKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mahpIK2I; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mahpIK2I"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BB663F880
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 02:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1743473082;
	bh=gsebR6Npq5QZ08qOfLdxjEyTfj/E8fT4/O8QrxOwzIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=mahpIK2I6gzueX5RCh9x5Vo981Y4JZ/kkMsFcys1r+QWyqMIAhnxNC4VfpvbXXzmu
	 JPJks6ESGf9iE+NpFza9euYpikqoeYshFC3kak/7y0ixUzDYgwLUMCiDySXytwRp0m
	 R24EuAppbMq2MRHv7qOMeuS9GhTQhG2oN2cATH/r6pniNAHC2jNQx9j/YVZZ+NZ0v/
	 8WU5oOMkWYwCD2dtG/vbFCAWSbfX1IUyG1gzj+OTb3EqlyWa/nvZdD/UAMZwQcR0id
	 hoqSLRTERqqmoWXdUltY0AU54V3iFvk9VlMqIP9zgujjyQ48cwfHnGnp7+cUumYlCI
	 B+k8pfXJIaBGg==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22403329f9eso88829805ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 19:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743473081; x=1744077881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsebR6Npq5QZ08qOfLdxjEyTfj/E8fT4/O8QrxOwzIM=;
        b=AfSsuIWTKcKCiqxYFAX2h/cowaD8kAmRItnHVFL3tkG/fWRQBi7nL37+0Y4UJU5Nyn
         8wShHZsE9P6AnSj8qGL+58Gl0oepLoDuQmYTX0GE1K2v4mEWIJlQn0QQZYdMOqIfDc9f
         k7yI52XxzOdwOLroNGwsEA5D3USGn/xCXuU013uibGdL4Yq2Pk0wIeBivzsCP8dB9fHq
         Et9FgUUoCq3D6lrt+XZ0qBNicCe7lP+/27g2lzLS+wRN53DAknC0SmQMKt7DxSFQ8mAw
         0/djOalfMBoWyYlSOvcZlB8Xfgu9e2pGU41odWmHjN8f9fYf2oIwz08EnPpF4G2dek0r
         S9BA==
X-Gm-Message-State: AOJu0YwwElwMALGjpWCopmFQG0thEnlkaWeJGSD3S2d6YgYP0r6lsGOf
	O01a/q7Nd7n1K1mm3CKHQUPtq5ymibIuiFVAoibsCc/uQzPhZfKCCmVMgTO9MYokPUJb+7BZVrx
	pwWZSZkLSStZS3e6OdR9kz/ueLWZ1INIBzpouGfrh+UyjwuUiHTHrAOH49LJ8BkTafFzJ/Eo1dJ
	Y2Dq0cg8aLynnQmg==
X-Gm-Gg: ASbGncuT0+LFyd3GNtQkcaqVIL6inOEkKwl0qG6UVEhIx+vPmVUCUhpwXG/xX51OBUQ
	kQfWibWfd6huNbiFDrS7sU8ADrPuYtQ31T9e3HjZUkcu/Z0swWGdHwI9yX6oJijfAJg5gYt4UYF
	0IS21Auvjwoh/DbqEmIZsB09kLPadxc3phuVd70KI7XRR/XB6wWPGvWBZu7FKaiK+uVAZCgY0aI
	eIffi03WLuLbgFsiQff3HbBkLWr0YThIZeB8UQly24HU76yCiKcL/mvHsKUEOYCzAuiRrOwDRSw
	aZN9GGqSGJ8Oj+7DwJkMAoRmFARkVsuoB9WG3j+8jB1creoR1BQiT0aZvJ7CKK0lLFE=
X-Received: by 2002:a17:902:ebc7:b0:224:160d:3f54 with SMTP id d9443c01a7336-2292f97caa0mr189890375ad.31.1743473081009;
        Mon, 31 Mar 2025 19:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFAWjl7alzPtHu0YQntb4W4DxLpjK15/vQSgHYhNZAo+QhBC5SAuttgigcTvmFtB5KwbxxGg==
X-Received: by 2002:a17:902:ebc7:b0:224:160d:3f54 with SMTP id d9443c01a7336-2292f97caa0mr189890095ad.31.1743473080636;
        Mon, 31 Mar 2025 19:04:40 -0700 (PDT)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf51asm76903225ad.151.2025.03.31.19.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 19:04:40 -0700 (PDT)
From: =?UTF-8?q?Yao=20Wei=20=28=E9=AD=8F=E9=8A=98=E5=BB=B7=29?= <yao.wei@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Yao=20Wei=20=28=E9=AD=8F=E9=8A=98=E5=BB=B7=29?= <yao.wei@canonical.com>
Subject: [PATCH BlueZ 1/1] policy: fix HSP/HFP reconnection
Date: Tue,  1 Apr 2025 10:02:21 +0800
Message-ID: <20250401020221.119615-2-yao.wei@canonical.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401020221.119615-1-yao.wei@canonical.com>
References: <20250401020221.119615-1-yao.wei@canonical.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes checking whether A2DP service initiates the
connection starting HSP/HFP connection, instead just start timer
when HSP/HFP is not connected, also move order so that setting
HSP/HFP connection timer is not blocked by AVRCP connection.

The previous patch also did not get HSP service if HFP is not
available.  This patch adds it in.
---
 plugins/policy.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 360d1359f..0e533ba1f 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -312,6 +312,14 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 			data->sink_timer = 0;
 		}
 
+		/* Try connecting HSP/HFP if it is not connected */
+		hs = btd_device_get_service(dev, HFP_HS_UUID);
+		if (hs == NULL)
+			hs = btd_device_get_service(data->dev, HSP_HS_UUID);
+		if (hs && btd_service_get_state(hs) !=
+						BTD_SERVICE_STATE_CONNECTED)
+			policy_set_hs_timer(data);
+
 		/* Check if service initiate the connection then proceed
 		 * immediatelly otherwise set timer
 		 */
@@ -321,16 +329,6 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 						BTD_SERVICE_STATE_CONNECTED)
 			policy_set_ct_timer(data, CONTROL_CONNECT_TIMEOUT);
 
-		/* Also try connecting HSP/HFP if it is not connected */
-		hs = btd_device_get_service(dev, HFP_HS_UUID);
-		if (hs) {
-			if (btd_service_is_initiator(service))
-				policy_connect(data, hs);
-			else if (btd_service_get_state(hs) !=
-						BTD_SERVICE_STATE_CONNECTED)
-				policy_set_hs_timer(data);
-		}
-
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
-- 
2.49.0


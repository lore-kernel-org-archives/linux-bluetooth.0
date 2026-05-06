Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8A324B20
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096524; cv=none; b=X0r655fLCuwY3rpl9D1ohdKuD6Ga8cFsDjGlwXxt3kHGp97YsEZefK6+7DgbpxhiUgIWJMswm/ryd7oxzRvBWFi6SrSsVTR9rdpasD3LwlBPlT4pTKmLNbKz/XiQ1B8gyE0JgqbBq1enx4ZAhLbVvwLy9kXKHwrRp3M99i1N9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096524; c=relaxed/simple;
	bh=x8Renar3e25LndIbzhLFFhvHK8GbIWfIoHST3Z+YWsw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HFxQ/n1rQqmBEJFE6gz+b7+4/EhJu/w5uVAuDUlmFmKqf9oXVCdD5ypbJVCsGhDI/BMtuTDM2iqp7e4nfh+lOQox7rCx2sno61mP73T7dlSs8+Yrw/R6lJ+SumvWoAsxFSsEmUNaXOjEh29r8F3fcdbKJ2RUoj9toxzmW2eKztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS2mHmAf; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS2mHmAf"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-610e2e8f57dso39379137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778096522; x=1778701322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tj/hCn57+zbQELeafq/xrpFh/47oaBSQ56uTm7Cej6g=;
        b=fS2mHmAf5UErtUHFEWUzoZMB+FH1EZ9i3t7u7W3vNpAY5k5ILae6+bVaxFGEN3TInD
         jU9TZ58x+nQMkD73OXSwvGloF17gq/2aUT26eITW5LPoARh9w+aFWDgAM1yl9mUXi1UN
         alZkxRnKD674iJGTmWCnzWJ9SWqk1/QMDhgDTnXNBgibjEyf2NHhuxaIDYY+FFmEpyYp
         msXtwEpbBJurTJNg4eMuN98r3HLfQvL/AePYz+UcBmYe5fof0+WZiyzH0f8iO7udRlfM
         B6XR0dxUywOxexgQnfB+caSAtLdcdAto7WdKlDAk0F7CmQ+9dAXtD5+kJbD33pIALcS9
         4Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096522; x=1778701322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tj/hCn57+zbQELeafq/xrpFh/47oaBSQ56uTm7Cej6g=;
        b=jr9lMBvAqQErX8fbwBqvOdEexDf8QbufJ6ERMH5p3sJAw2Q7c/4oMU+V0JSYrJQg82
         A56vfmnkkSnTkfU8H9g7qzCPda6wGheyYlrgX8+tz8/yCCzJfiEPnC0+Miw72twsy76y
         HURzR+LARvDMDWxY/p91QkRy7y1RSa3Ve5xs40HciMh+hEB4VkRhvzPYneLuz380tpoZ
         qPyak2A6apDAJx793qbA67QDM9Syw0bBq4D8V50e4IxEQGmsDZSHMCn2Lerj/K0wuuyb
         Yz3c7g4kBLPnQGKquQCc5I7RimSDK7V5KPO1jzDABL9Dw4aCvNTDHHSM8X09QMHo+nz4
         UMXA==
X-Gm-Message-State: AOJu0YwL5rf50fhxMWgQSYxQKpuYZI0hT4O+cynFzSwTs46Ld7FYBYZt
	Y4duNl9KnR2tOP0Fy/IHq4QMUUREKkyaiPCvE253Au9DQ4ueiKVNx4XGxh4Z8Eqf
X-Gm-Gg: AeBDieuH70BYqGlxH7+2QXsyg+DlCPwsGyUpCtkcahdaHkpFNXpnjuuFUBPp4tCrp55
	bwQqMfTBb5QHGB1u56BX6HJeGbN1X5q3SNjrI2GWvs66Gou+0SepKmeEj1XKiOwh1N2k48Gxdf9
	1Md+3POEI9bMH6z26Y81fKumoD6b+BIamItyvQpZb5gwpp1ofAIsv4hliSvPdF8eGOMUVmzSZd4
	B6MGLGWJUDJ24757oNrNrXhqQBWwsNLUiwQJtNNcLjgd0yF4wExovIR6Y7Sst5xbV6XMzNR013d
	AtEr1qMb48wDCkhYYheXB/oEOS9eE2vATn5doWXx4SxXt+vJmAZhXx4VSJJeUmET+4MtTXq8HE2
	sbYOrnxo/UDWxC9Kk3QZ9bL+dKTbZp6w/R2DwfbCUNXEWGkdlke69c64wMvHi8Bq7FQUC4RfkKK
	uEqJFayfyaAhevc0b+qbafBPnrZEy1En3v4pgWFs5fZ1p095HellsOQkzvSIxjEEhO8fBVlmyKQ
	9nwNhLwnzEZXaqi0ILMQDWfMvBmJdkMAAcDhrQ=
X-Received: by 2002:a05:6102:5a96:b0:611:61d3:819c with SMTP id ada2fe7eead31-630f8ee055dmr2799208137.10.1778096521458;
        Wed, 06 May 2026 12:42:01 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfb14fbfasm9613805137.1.2026.05.06.12.42.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:42:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] tools/tester: Fix crash when hciemu_new fails
Date: Wed,  6 May 2026 15:41:48 -0400
Message-ID: <20260506194150.1701855-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When hciemu_new returns NULL, the mgmt object was not being unreferenced
before returning from the pre-setup failure path. This could lead to a
NULL dereference in read_info_callback when it later calls
hciemu_get_address on the NULL hciemu pointer.

Add mgmt_unref and return to the error path across all testers.
---
 tools/6lowpan-tester.c  | 2 ++
 tools/bnep-tester.c     | 3 +++
 tools/ioctl-tester.c    | 3 +++
 tools/iso-tester.c      | 2 ++
 tools/l2cap-tester.c    | 3 +++
 tools/mesh-tester.c     | 3 +++
 tools/mgmt-tester.c     | 3 +++
 tools/rfcomm-tester.c   | 3 +++
 tools/sco-tester.c      | 2 ++
 tools/smp-tester.c      | 3 +++
 tools/userchan-tester.c | 3 +++
 11 files changed, 30 insertions(+)

diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index 65dba173b18e..2b43719f153e 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -181,6 +181,8 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
 		return;
 	}
 
diff --git a/tools/bnep-tester.c b/tools/bnep-tester.c
index 2a9b843098f4..581f54c20829 100644
--- a/tools/bnep-tester.c
+++ b/tools/bnep-tester.c
@@ -162,6 +162,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
+		return;
 	}
 
 	if (tester_use_debug())
diff --git a/tools/ioctl-tester.c b/tools/ioctl-tester.c
index e0627eef5bdc..969fbd955b76 100644
--- a/tools/ioctl-tester.c
+++ b/tools/ioctl-tester.c
@@ -230,6 +230,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
+		return;
 	}
 
 	if (tester_use_debug())
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 4c30e9951bcb..8dfea0b417f0 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -637,6 +637,8 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
 		return;
 	}
 
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index c3aa96f84ea0..5c013d4704e5 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -217,6 +217,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
+		return;
 	}
 
 	if (tester_use_debug())
diff --git a/tools/mesh-tester.c b/tools/mesh-tester.c
index 7c42dff76fb1..27628b627957 100644
--- a/tools/mesh-tester.c
+++ b/tools/mesh-tester.c
@@ -419,6 +419,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		test_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
+		return;
 	}
 
 	if (tester_use_debug())
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 90dfa35272c0..213fd996b032 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -431,6 +431,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		test_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
+		return;
 	}
 
 	if (tester_use_debug())
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 25b3a41e0f4f..06e9fbdd6143 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -167,6 +167,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
+		return;
 	}
 
 	if (tester_use_debug())
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 3d6b590924db..f09ba04aeaf7 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -195,6 +195,8 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
 		return;
 	}
 
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 04b7ee088705..aaf149c0deb7 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -185,6 +185,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
+		return;
 	}
 
 	if (tester_use_debug())
diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index f61d2779ed26..a03f64d84c0b 100644
--- a/tools/userchan-tester.c
+++ b/tools/userchan-tester.c
@@ -156,6 +156,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		mgmt_unref(data->mgmt);
+		data->mgmt = NULL;
+		return;
 	}
 
 	if (tester_use_debug())
-- 
2.53.0


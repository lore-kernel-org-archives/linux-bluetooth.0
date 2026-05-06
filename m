Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B726332EB1
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096527; cv=none; b=kfuL4NbRiXkN1erM/1l27dY36ueN296bRU2VPXrtaLMbw+fPeO2quG5CwJf483VvxM05sV7MXuWjXEg49g1XQt16m1sFDyKb/i0IYhvkWjJcs9oc3LPuPnnwvTrAwBqPIkGGVYlqXtm0T7iQkPkfj41hDvVZ2E7mKXuehnzbwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096527; c=relaxed/simple;
	bh=3SHdphOsndkT7QOOqKgaRwv9Vi8YEHNwi+H+NzYlTiM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOqj8YOLG9R3oZb2vrXEGMFJ41IdJu99/gF/wKB9hfi+i/+kPf7vWp/BCXDS093yopVCnj1F7aaASR5Sf/kk8av4TgBdbZdW3loKatgrIStefsC51JoFzLcYvsqe1G9wBVT1L/e8Gt5eFJUMI2toZcT/rUjMW3ZnZ8kKITDXUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiKAON7j; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiKAON7j"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-95d18b33f93so38540241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778096525; x=1778701325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IK3nrYiRSW48KKXuNEnb9Smw2nTqDWc82L6/xaQASFw=;
        b=UiKAON7jbZknDXx69QSqRbuBCnkTP5YPh6IuN17X0JpMSfHXz71Ug5UTTcLHucYyKQ
         5SGRjgVnOfkpM9C7H+uzUuJK4LBSdmr2PhhGxOGiEc/mPkAyFtY/rw2R1P/3VVZns/5b
         hS8GpjrtuaI9pqJhXnEERC0+BksVy/fXlCG1aM4yaVwS8KI93gQ+JNyZczEC7u58Z2+5
         wQCqfMSry5wp0D/0rhT8ToNzQ77aCBsfmzAe19FwuzPLhNn1XnQWF1BHpTcXwtw/+Nqg
         ErqAIdhXW8dggntp/xj1CjxVfwKeRrWxfQ0n/4NaqDRXUp9aqpVRXJ2OiEDnrGzVEwn/
         LBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096525; x=1778701325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IK3nrYiRSW48KKXuNEnb9Smw2nTqDWc82L6/xaQASFw=;
        b=gYMHz6mPqtRpfusVgDjyrt/ZJEGZtPQ4zYEjYTvHHiQ28MRI27/9o6Up0Ynyv7+MDq
         YbZklFBePdT4sE6xM0pxB5EKPAhgMZtel0dwlRNwALTE12wV7gEKu/3t4mUUgzklL3mG
         Awip+OJuyQubeW2q1iihdv3EyuImmQEnyM1t3XH1A6Ye+WxtUpNhkXfknRMChYXb8imJ
         z/3Uiy4PPHLt1hYH1vy4oos9erwl1vLND70QX8oL6FJmxmxoOkcJSx6vNbNh++/V8MaW
         qGABNGZfom0cmsJaYA+rsK4ZIajcPDKoZJ7bG5Zgiv7uHu+nmcY9eAVYOeaDAiyTrMEq
         XMmg==
X-Gm-Message-State: AOJu0YwrhWLRN9HKHHxvYd+x/hph7AADaseOoLqMMBR6rS2+LXZJpRn7
	JzyATYNG0a708mzOhLcocTf0KoU4mJa1AyHYWL/M8S/anRmO9EXhuaPOSgRKxr6Q
X-Gm-Gg: AeBDietXGPBlLYJlVdmn5xgKDBVWmsl0roZGAmttIGHTuCMa5lXlaK39Os1emWS+bix
	X26B9uI/sJGJ73F7y5urnycUHeYrB3JDCFXPvqzq1UWuYYxu2BYALXXovdXQsi3PUNxEY/aHgVX
	VCMkKTg4XGOGasmlmKWAy2+0pOMyDJPUkmJpWaJn0+TexfrGt7OJLsyIOqjH1OfMsDt5GgxuiIZ
	/doLUdVeo+8YgYt1bLPGKUmQTRKJsGyomOHRRtZFUk3HI18gL093rO+AM4ylpOYlnx1SvSAlTfM
	GG+hP1YN8mT3Kd1kKVP8yTj8JST1eVy2rSa0ovX2cbYa34RVunkALZ3e5y19WPwo2hOHbZt4XbL
	ZAVWlVYqnfO1BSNBNCQQ6jNnQZVKUcY36vTyL5XkQWDEEhnCGZGep+6qmuet5Aaex0XG33OEWPH
	esYkSAB3XlyPJ4t2Jh5aWBqCZY3++EQ8zLRvCF+hLdKW11OOPlSY6psmYpWmZpdt+VAAwFySMtn
	mAugiqvZ7uVosm/l9HLI512PrWPqUg78s5m7x0=
X-Received: by 2002:a05:6102:2d09:b0:62b:5299:fced with SMTP id ada2fe7eead31-630f762d616mr1958949137.9.1778096524735;
        Wed, 06 May 2026 12:42:04 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfb14fbfasm9613805137.1.2026.05.06.12.42.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:42:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] tools/tester: Retry with debug on hciemu_new failure
Date: Wed,  6 May 2026 15:41:50 -0400
Message-ID: <20260506194150.1701855-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506194150.1701855-1-luiz.dentz@gmail.com>
References: <20260506194150.1701855-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When hciemu_new fails, retry using hciemu_new_debug to capture early
initialization errors before reporting the failure. This helps diagnose
issues like vhci or client creation failures in CI.
---
 tools/6lowpan-tester.c  | 3 +++
 tools/bnep-tester.c     | 3 +++
 tools/ioctl-tester.c    | 3 +++
 tools/iso-tester.c      | 4 ++++
 tools/l2cap-tester.c    | 3 +++
 tools/mesh-tester.c     | 3 +++
 tools/mgmt-tester.c     | 3 +++
 tools/rfcomm-tester.c   | 3 +++
 tools/sco-tester.c      | 3 +++
 tools/smp-tester.c      | 3 +++
 tools/userchan-tester.c | 3 +++
 11 files changed, 34 insertions(+)

diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index 2b43719f153e..95fdf206fc0c 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -178,6 +178,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(HCIEMU_TYPE_LE);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(HCIEMU_TYPE_LE, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
diff --git a/tools/bnep-tester.c b/tools/bnep-tester.c
index 581f54c20829..1c53d024c0f8 100644
--- a/tools/bnep-tester.c
+++ b/tools/bnep-tester.c
@@ -159,6 +159,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(data->hciemu_type, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
diff --git a/tools/ioctl-tester.c b/tools/ioctl-tester.c
index 969fbd955b76..e957b0d01bfa 100644
--- a/tools/ioctl-tester.c
+++ b/tools/ioctl-tester.c
@@ -227,6 +227,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(data->hciemu_type, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 8dfea0b417f0..767ee0c57c47 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -634,6 +634,10 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new_num(HCIEMU_TYPE_BREDRLE52, data->client_num);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_num_debug(HCIEMU_TYPE_BREDRLE52,
+						data->client_num, hciemu_debug,
+						"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 5c013d4704e5..a8cac3902b32 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -214,6 +214,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(data->hciemu_type, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
diff --git a/tools/mesh-tester.c b/tools/mesh-tester.c
index 27628b627957..4412bfdb727e 100644
--- a/tools/mesh-tester.c
+++ b/tools/mesh-tester.c
@@ -416,6 +416,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 			index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(data->hciemu_type, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		test_pre_setup_failed();
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 213fd996b032..4d28090271e9 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -428,6 +428,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(data->hciemu_type, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		test_pre_setup_failed();
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 06e9fbdd6143..b7f7d9ebd794 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -164,6 +164,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(data->hciemu_type, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index f09ba04aeaf7..a2185b8ef198 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -192,6 +192,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(HCIEMU_TYPE_BREDRLE);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(HCIEMU_TYPE_BREDRLE, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index aaf149c0deb7..581f3a233704 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -182,6 +182,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(data->hciemu_type, print_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index a03f64d84c0b..9164fc33f5d9 100644
--- a/tools/userchan-tester.c
+++ b/tools/userchan-tester.c
@@ -153,6 +153,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_added_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu)
+		data->hciemu = hciemu_new_debug(data->hciemu_type, mgmt_debug,
+							"hciemu: ", NULL);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
-- 
2.53.0


Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D134753C
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892873; cv=none; b=asF/vMJYgtRu4RzokHjVxlV1N6Il5v0Kw6ExpyBDsisM1P4VqE3L16jXjSrgAEETT/75pSm+pFQS69S7tFFKZ1xcgzKgFv1OA+wQ0fWzIkjGxv4jZg5NHe7tDv1PCMjvKqI9ln9cm7K8EWexIXR5fNWfw8HY4C+BKL3UULz+Axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892873; c=relaxed/simple;
	bh=YS+rDan5POV92QQ1pWqNM37ehdnynw+C2e650sl7HyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6kfJurb6zc7Kq5zWbVYxld3/SU2dNN2apIPpAMMxIzPSdTIb1IkoMHukCRJKhSW5ME/HHLOskavlGdiioaAR9qrqHoPOxmG+cq4B7/uykeUtIhtzpf/HolnAU7VxBX9mrk/mMwSsB0/cIXUHNHVfAJ/HAtImd0N/izxaF2ppqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLiBmJmQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLiBmJmQ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so9032974e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776892871; x=1777497671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evXKjRMD/RGxUKRmoPmW1ITvGrEanwdq9iZUlOBdSzg=;
        b=oLiBmJmQov1uztwFD2wREWWUcaNat94JEL411X7tvo7tOu44lRyeQVWHAjHK2X9YYa
         9VtQxOtqCBSK4hQZ39H8NvCkpkN8DqZq+Vu6j4ejLK9cEEHiRnuBb04CWJReQIWfN4QQ
         dM3Qc88duI6G0GzAq+5L31OgSr6Q+DKDCUkMXGtdZQ5qKQSEPZq4O+NtRwlT5to8t0Vb
         l2k65zgKQjcOes742oDGmmeunJCCsDT6A/JoVlooVUe5aj/5K67G/1e83fcAZ7O+kysI
         SteyxDaMyv6KEk7lQEQpZ5gRxfgpdk6zZwnpIJMgPyXS4X7NCGwLs9+pz9LhUUjZwFR4
         8wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892871; x=1777497671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evXKjRMD/RGxUKRmoPmW1ITvGrEanwdq9iZUlOBdSzg=;
        b=mG16N41NfNyZPr9Yb07YLTkehRdOD21CW7TJtN/JthRVwrSeOV6XGa3F12V+2FRHqk
         aarP5ioqjZJDqNygDTDQAqPfIVamQgHZzYfY/jJpGVpnm4XRKfcGTIFjWoqacav154VX
         p/EcY9zPg2d5tgeDYNlqkKvC7/WLMVSV30IWbreWcRPWftgrAaZpOyxcbOMNFi+Y3yyq
         AqjGWoy8j08yfcfwwkIZ3b/nr5Okw/KCTBV06QJ8YMDLypOFhNwzODPNvyD8aE5au9zW
         M8/2RKv4LAkkvTqOcUrq3t7zJmhnGMQmqoCzX61CpS8gClqP3reJ3j6Nv8F4/p1KkkJb
         WTvw==
X-Gm-Message-State: AOJu0YyoNHmsJL2eMq2v5sEUvNavUN/uRltuwmtefDFBg0aI3Wqp2SWI
	ATl6c1J+t5kyFZVRGD0yo+GpuogFAboIuNGSCf0PQgdba1W822cqFBE=
X-Gm-Gg: AeBDiettyk8rRDXqS53sAH7w9jkUWGo7ja7dU2lW7QGckBLxyGAYBL4enMUIjuKA40V
	Z/M/gsSX+ptg+NC8MlyTqnxNOBNhtPEMJBSWqetsamV3vZhGndcyFaEKRSc6mSgqjit6oQaqGfj
	CDHWDWI/9ZyLhRPewaRAynJVOp74bCmIa+im8nryLsYaIsJ1KKUJElqCXDb+TxGjgZxoG0n7NCC
	EYEekjxSsKUrP5mLDXuOv5pjCrlF40E6fhQxCIm2qjvD078QStpTOiGVPcMtbSxgAbYZ0FHJhw1
	z7mPsx0QQmHlu0sGD3MvGRwcRuEEbg8COAsjcs4ZziWhfmavwJuDmqTKsPyEpte8wYKjTS73cqw
	CTjieRoXWNfxDLuuC73n6tWw6hC/1s+9pasbG3dGewqKpkIOwGHSkzaF0/0HS+ZVFh9r3dUoJ+e
	ucbrh1v6DPGAovijaDkikJxyrMSaQyu6uc+/erlw==
X-Received: by 2002:a05:6512:138e:b0:5a3:d1d9:6080 with SMTP id 2adb3069b0e04-5a4172e275amr7271218e87.29.1776892870309;
        Wed, 22 Apr 2026 14:21:10 -0700 (PDT)
Received: from mczerski.lan ([2a02:a311:43ab:e720:ae0f:5ce8:c45d:a5a0])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad138sm4740917e87.9.2026.04.22.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:21:09 -0700 (PDT)
From: Marek Czerski <ma.czerski@gmail.com>
To: hadess@hadess.net
Cc: linux-bluetooth@vger.kernel.org,
	ma.czerski@gmail.com
Subject: [PATCH BlueZ v2] sixaxis: Fix pairing Esperanza EGG109k controller
Date: Wed, 22 Apr 2026 23:20:45 +0200
Message-ID: <20260422212045.1325603-1-ma.czerski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <59197f235800db69549ec163391ac1ac1f1ffe65.camel@hadess.net>
References: <59197f235800db69549ec163391ac1ac1f1ffe65.camel@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change is required for Esperanza EGG109k ps controller clone.
EGG109k looks like PS3 controller but presents itself to the system
as PS4 controller. It does not respond to 0x81 command.
Command 0x12 contains both the device bluetooth address as well as
configured host bluetooth address, so it can be used to query
both. Kernel driver hid-playstation also uses 0x12 command for that.

Manufacturer link:
https://esperanza.pl/esperanza-gamepad-bezprzewodowy-ps3-marine-czarny,176,1701.html
---
 plugins/sixaxis.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 27bc09815..a04a76d39 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -39,6 +39,9 @@
 #include "profiles/input/server.h"
 #include "profiles/input/sixaxis.h"
 
+#define DS4_FEATURE_REPORT_PAIRING_INFO		0x12
+#define DS4_FEATURE_REPORT_PAIRING_INFO_SIZE	16
+
 struct authentication_closure {
 	guint auth_id;
 	char *sysfs_path;
@@ -111,12 +114,12 @@ static int sixaxis_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 
 static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 {
-	uint8_t buf[7];
+	uint8_t buf[DS4_FEATURE_REPORT_PAIRING_INFO_SIZE];
 	int ret;
 
 	memset(buf, 0, sizeof(buf));
 
-	buf[0] = 0x81;
+	buf[0] = DS4_FEATURE_REPORT_PAIRING_INFO;
 
 	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
 	if (ret < 0) {
@@ -163,12 +166,12 @@ static int sixaxis_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
 
 static int ds4_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
 {
-	uint8_t buf[16];
+	uint8_t buf[DS4_FEATURE_REPORT_PAIRING_INFO_SIZE];
 	int ret;
 
 	memset(buf, 0, sizeof(buf));
 
-	buf[0] = 0x12;
+	buf[0] = DS4_FEATURE_REPORT_PAIRING_INFO;
 
 	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
 	if (ret < 0) {
-- 
2.43.0


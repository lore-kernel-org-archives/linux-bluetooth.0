Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EAF2DFA20
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753698; cv=none; b=DBWZbEK4vIXS3Fiv4iKd3Q8Vb37VcZ323lbCRh7Enhp5Pn/zlex1v57LB2+aeXfGKgPCTkRUrXQoyk/hur7LjNVDv7/hPUthaNBdMYGdSIFr4xw3uSUEnL9PNQWo3BjDyBKTgvMedNPKJl6oNrqsl15uzzMz62ARmMMQxob/lpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753698; c=relaxed/simple;
	bh=r32oAtmJV4GUBVTcyRweY8W3ZwcYF9lzM96+0PEcaBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CjTBza9XlIXb3eUXLXkY86V1VvbASpToh27Dzp5TXUEwrYlEAyDpfM0SprkiiyHxvLWfFhOpBLK4ciOaI0/mI63uafugVmMaz/6ujHgLeLlQnUL6jOL4RMFraJpR5uA14d4pmUM4VEVZa1ImwFXOCwuymeUi+7MCZC3L3ldaQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7CB0C38; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7CB0C38"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523f721bc63so105218e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753695; x=1745358495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aO8ssM0dfDJUhN473dOwaJoGRWoeMmAGYDR1boXBPUI=;
        b=h7CB0C38oA4h5qfimlrKjVW3KMZPRBzA6zTwOcW/IoqkGEk86UI8RHK8Nk7qU4jnbu
         Eud1hKn8U8SykOFRlBpmoZqcirfb4nEkz/PgGn/WqD423zGE3MbILSobQ+N3wmbh1Uve
         DqSAW53YBgBVBgtlm91FePpG17QxLtmUmneagH/Dmz+/iM9VT6/yaCV1dR8dPCQL+HUn
         KjtG5K3gsQhW/NEFfmu4VKD087C6kA6weSH7K2hEigNDHnK0XlsDSEUEOBU75+UjFoAC
         TSjRDxU+fsleN/u9X6bw0i+MtRq+yy6JFOiMwhakoEKsPX7EE2dotbMTuMBtoHiu2nhp
         gZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753695; x=1745358495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO8ssM0dfDJUhN473dOwaJoGRWoeMmAGYDR1boXBPUI=;
        b=LDskO8oFv8d1dNcWEO/hXdO9brfZHI0fd2Er6NOSWTQll2ElKQ19RAcZSo1uRvSDBO
         f8gDPDyYOL/KtLa/Re0NELo+c+puU8gQ/e7P2SFFKx4dwyw/xpXlgjo/PgZ7E1pHy8To
         mt7resUfY9QeXjhM9lgXrEeijjEwMA1S5mVXPNZVYrY9dMc7lH65j+Mz3Jke7vuPlUTJ
         KqYpkUeoz8wYsm0LazR4d8fMy2y4dDdEHFMFn2hbp/sToSC+VGSOKZSh5h1tiy6LS7AT
         AxaQJTf4GDKKjV6FrG66uFVI15ZgWJGdk9nEjrD0Rhrbq4Q/WhnlSZJCyG7g+CXxw2hS
         fpOg==
X-Gm-Message-State: AOJu0YwQRa4GLszgNu8EwgXH3PwNiPwPrA+dMgyRC/0pThyoz5bbFb4m
	sVflZwzjDERjUPp1ituJzsN6KNlRk+n2tTvRDM6k+TE+ExNoXe9Q0Y2105d7ZHI=
X-Gm-Gg: ASbGncsr1UEi50OLEzCZ2u0rZYpAgXfuz6hz0oH5Gaj9WN6oHngD6A86ju9MoN4tblm
	obTusldZ4Fp5NlhQl1xjXQlzqhY9N3KEMV8NXkmKwcHyfbSRjMY9g9WBCpZcqAaZEBzuTXSFuiJ
	CQnYc+a03SOf24Xd6e3eOBGrz7jk5HQumGTnUPEEMrQjUQlmL+VtrDpX1JzrPs7APhwocLIXB9q
	SZF0wWDoPYEms1uToNeDrhH0V5ieEyZx5bvf4cGGiHns+pvJfkKB8u5AY8ku5c3lsy8e9F2/ML8
	SyjyA2fEYdVSf/Q5S+N1FBhgM3MZ7CKQr7L8RASQ34NBBYiYQ31lebdoEc1z96lOXhETW4CW1tl
	McvkBUmSVDg==
X-Google-Smtp-Source: AGHT+IHGl6YJrT0kUUlQMcC55dE6TA7U7DKEjH8NUSU0Nzmc2L6f3pNfpKHRWSqPoV+3ailaD4Zsvw==
X-Received: by 2002:a05:6122:1d8a:b0:51f:a02b:45d4 with SMTP id 71dfb90a1353d-529085e897fmr1302344e0c.1.1744753694768;
        Tue, 15 Apr 2025 14:48:14 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d740sm2844459e0c.33.2025.04.15.14.48.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/7] bap: Fix not setting SID for broadcast receiver
Date: Tue, 15 Apr 2025 17:48:04 -0400
Message-ID: <20250415214811.1677842-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SID most be set otherwise 0x00 is assume which may not be what the
broadcast source is using over the air. but since we don't have access
to the SID of the advertisement in userspace mark de SID as invalid
(0xff) so the kernel fill it up while scanning when creating the PA
sync.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fd9b751cc1bf..24763666ce96 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2813,6 +2813,7 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 static int pa_sync(struct bap_data *data)
 {
 	GError *err = NULL;
+	uint8_t sid = 0xff;
 
 	if (data->listen_io) {
 		DBG("Already probed");
@@ -2833,6 +2834,7 @@ static int pa_sync(struct bap_data *data)
 		btd_device_get_bdaddr_type(data->device),
 		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_ISO_BC_SID, sid,
 		BT_IO_OPT_INVALID);
 	if (!data->listen_io) {
 		error("%s", err->message);
-- 
2.49.0


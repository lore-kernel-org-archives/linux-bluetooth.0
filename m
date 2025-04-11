Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700D27781C
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398888; cv=none; b=fkdIe+/7W4PDogzHDade2bzus6+Vfjqkbbe6oteX0Ila9dT2+BeUHw4S1B5LV4GdxN0xswR56BZc+2r9MhJIoE3EG1aKVI1SJsSC8bzXXUAJF6Tg3D5S0j7DsxLh2bMc7ynmsYFTqNymtRsAYEvdPgXRPZe6OuR4Sk7TtAlLsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398888; c=relaxed/simple;
	bh=4BWYmKtqGVeePnMR5W0iVGdLU1gm3be+WgGzxQbEYFc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AHiS9G2V8TwoSE5POyUaOOQsoCkaxaOUXc7YiqjYpK/xQWvzM7pFaIFb2Fe0wVrl5B12AhXk4KjgPCH3nq5jBYm8uy94VoHDaMdWXL3K9eI5W553CbZ/ZaO5DB/dMBUL36Fs/koAo90Ngyb8hTeFWoF093ctiAC34JMLptV+gDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA0Ff2T0; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA0Ff2T0"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523f670ca99so1047122e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744398885; x=1745003685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYb54oIDbts//AnEHEkrNKDhs4KQf1Et+9uC/qSXGTs=;
        b=cA0Ff2T0h21viVjIndD5HJtq3NQgvoGhpQSWntJv+LbauqqDYBksBL/bNxeHsvy53E
         smLLic6Ftcvf/QS4kGfAFPSxCu3Zhoxzlc2tFtcOnHvrW2LWis2nfjMihtxfLzKI4AHD
         BqIhIN7Op+OL3SexWhniRzCKQxVVDvmU7/wEW2lwBAeoMQsdD9Tqu5rplCo7piniIUMC
         lT7OnrCdyyxrT5LlnRt7tCny9Xdyc4gt+qZoeWUNGFHtEscgX7hp3n3wugS7X3ttpMpS
         Bxz6JbjZdg5VyotTP7IB44/iMtrb9oxfKOvKkaGhQbqqshd15QcbPJfnAjUZKp3/9k5n
         Hwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744398885; x=1745003685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYb54oIDbts//AnEHEkrNKDhs4KQf1Et+9uC/qSXGTs=;
        b=BbojSokCt9aADIWWttPBbYVmaaibFfKDFVEYVhEExUQ1DHMx60+IDuDnIyjHUu6lqz
         +CJBLFem5j2pg4Qe1gK0eSfBk09RmBksNoCvZdJHRxrGGs4dQHOEuu7Q/4P1GxaasJTz
         H3C4y8fE3bRfR7xKFy4FdWIaxtNlc553duRQ02sp+oiHEEe6kG4KaTwPU3Ya7MvRRVAb
         P6XEwqIomuvS2j17l7g5fz/5D2TxqHazYlggEiYqkx+okQhsXDftvnIlxyvp3Q7Qy6Ld
         +powRSn8qPyqK5vE4h6sj/81tubxYa2Nu9sfDd+P5qqfBWThyC9HivN1KyGl+3E5Z7vv
         CDxQ==
X-Gm-Message-State: AOJu0Yz/OmYFc6LOpxagYov1NwpU8addB7iJsmX5LkteBOm9BGD/FWbI
	D0N4vz5LVbOOfWz07dHvIIzIZBR1VviSYu1W0a7lK0sdwwxkQgLZ/zLOq4b3
X-Gm-Gg: ASbGncvTo5S5V2VnV7eOfuM8ssm/cM0USkgmSUDJUFwrVaMzfNG/3kpyj1Ad3/xZvfF
	KCq4dAs4odY50h5KYehuvrbBo/B76tBnYdfMxSzNAmoi1truB+SsNt3EknoRpmcx0VLTHyWhaq+
	I3gFOBow7oOLmfifwvsN9AqEToGoZfjaoBMrxTtpjGRGB9VEHzLebycdII+VG0XUcODum/u9vH9
	ImjllYAT5BUSBYL/Ppjf96Mr2UZglLc0/+FXnKe3MU7S7FXtb4neRBFjLx1jj2IdIlfkPUwNy05
	Q/KGqi21QAFehWFYF0qduxVrWkIwTIW6UciSQH09aKz3kRBI7egqjffy62IITlr5cEwGxA017SE
	RYy4YMdCgoQ==
X-Google-Smtp-Source: AGHT+IGjx5BQFEQsdWD9MGI4S//eL2sCJryRStdCdRXvLmYKNnxJQnoTfe99U8KmR3RytPvgt0P7fA==
X-Received: by 2002:a05:6122:1d89:b0:518:a0ac:1f42 with SMTP id 71dfb90a1353d-527c3464832mr2477169e0c.1.1744398884857;
        Fri, 11 Apr 2025 12:14:44 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-875572b3676sm1157480241.29.2025.04.11.12.14.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 12:14:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bap: Fix not setting SID for broadcast receiver
Date: Fri, 11 Apr 2025 15:14:42 -0400
Message-ID: <20250411191442.51864-1-luiz.dentz@gmail.com>
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
index fd9b751cc1bf..2b2eb3afb74f 100644
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
+		BT_IO_OPT_ISO_BC_SID, &sid,
 		BT_IO_OPT_INVALID);
 	if (!data->listen_io) {
 		error("%s", err->message);
-- 
2.49.0


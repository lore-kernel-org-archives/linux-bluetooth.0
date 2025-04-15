Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A15256C7A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753714; cv=none; b=Ndm0CbDAYBss835H1XeVsEGXT7gZDIjsBqwex+4B/bBdcsIC9vTDKUs3xjA5CVRI+svSe3QL2vfHdkbYHDMlBSXeSaf5y1oF7utfAGnMw+HsSn1HDMNblA4DzqAtmsTWv+c8wpLNp5rEBD0XsXz9/UEK/+NXRIUHWGdybMoGmWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753714; c=relaxed/simple;
	bh=r32oAtmJV4GUBVTcyRweY8W3ZwcYF9lzM96+0PEcaBo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrmT3BZsq6GzdpxFEZX0z0fFou2owhwdYf2FEIMEffD69g4vtGYWcFck0bRxpVpmo5QlEmTJkR2aBa+cR19nbcxj1XD/iTJbKfmYQVXiEzSW4X3K8AW3tGr9tzbbmq2u3jQQ6a4bORyyisIkgxdZnkX3NMIbrZ+X50FUdGklAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md8BjTxL; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md8BjTxL"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523fa0df55dso101719e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753710; x=1745358510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aO8ssM0dfDJUhN473dOwaJoGRWoeMmAGYDR1boXBPUI=;
        b=Md8BjTxL2k3LHRHAu/d4kjAffLesJnGYhq0eYfZ0hOVW37K6hXskCoS+ejDmaWpetY
         k/6/YuJXjJnlKYW1p8ufmLfvI6f4nKoMnVMKgFmlJhtaaiNseDvLo4g4deeNdJlyYPhK
         Za8y6LxHTkM7053b8eXAow2Lse3Zu+n0vSkWBCJd9d1GUiGCqi1S0zUl2fS2DPaL7Y6u
         gAQm5EmQFwyaPI55dmFR0+76dTb2iu7zkAiaLiJdExZfF8lZ7VcjwUs6wPqmrbPbe5zy
         SDT7cp4KOoKG0Db3FcdY9+AI9ZbDs+jbs878Bn5xObJUqgjEGdVwyFGR/KNjskeeuC8f
         rBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753710; x=1745358510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO8ssM0dfDJUhN473dOwaJoGRWoeMmAGYDR1boXBPUI=;
        b=c3iM1KluUjAdSeo7ag9BAjsLUu3VaDWRkEV4kn1NC/KCX8tWZJ0KiHg1+rtxb2uahw
         jQVPgzNpcCN7xoijJkOQLXW/AxqEMBjB7F7c6mjN231bZ3z+AfXdQg06/hLnenFA2nN4
         ck1rA/AkL46Fq46wAsvQDq5T7FvMOJPGqPxHWeZFqX72tEWwumPBqx2Ik8tRQznfHedR
         dnwhM1OkSGdYLdi6sZWjbyDt1MeDSGCZk3hhT4GIMyP93bp0BLJl9U/el+fFMG0D8ubk
         jao7B0F5rMZrZTVJlGxK6tqSV9SuIOL3M5Z1bHWntNaS1RiEtSVjnSyEOZ2rjSTG1QwO
         Hhcw==
X-Gm-Message-State: AOJu0Ywpc6mdO8fnr0KjXXo3QLGW2B2RtbxkXeRXcskRDO10XsPEof3s
	Pko2C9JyJ8MDp/+dJeUV+LykdnpIzVQ5bgIsteDSTK2Kso4atQV7gO+LDdQV+nk=
X-Gm-Gg: ASbGncuRpBczPKEJiDhce/8J0Y/T+ZrH+tjtAHuWLpiHKKM+kxjypu3sWkONUlFRvVD
	0K3Aik8c8uP/mFVLOYKUmqKSCS3v13/uk0YellYvPgt+f/91qEbN1MC7S5L1BqoPTGFxHrji1j1
	S1xwLehS6E96S8aZr9LznoZb1AqcBXOxyqA7G4+pFNrcLjLfuV26909a1cXRJxYngHZeWrXqlja
	nuc7W1OxfaCEW3Jp7VRqjvq3GcIOeENkNjmHdO7HXi3VKIb81/b/uuF3441V2IGkKARCat/PW+m
	aZicgqjtqIxJRVN7uuj5jYOugpV5gv7uaNv96VR6PAEo+iz92A8Z4MhRFZDS4PMm2pAwE85apHp
	BdJzlYgJozA==
X-Google-Smtp-Source: AGHT+IEh7Xb8lr7HRfTwH9FSWdEbx8QJBefd4E07jT3DpTzAFNS4r5XT49KvXEPkqmjG29BgR5sKUQ==
X-Received: by 2002:a05:6122:547:b0:523:6eef:af62 with SMTP id 71dfb90a1353d-528f0c5b625mr4436688e0c.4.1744753710128;
        Tue, 15 Apr 2025 14:48:30 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d740sm2844459e0c.33.2025.04.15.14.48.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] bap: Fix not setting SID for broadcast receiver
Date: Tue, 15 Apr 2025 17:48:11 -0400
Message-ID: <20250415214811.1677842-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214811.1677842-1-luiz.dentz@gmail.com>
References: <20250415214811.1677842-1-luiz.dentz@gmail.com>
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


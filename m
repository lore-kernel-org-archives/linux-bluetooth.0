Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1C18DB19
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017516; cv=none; b=C+g50L0GVLggD75PVIUjUG1ab6HIvLMNYi88cg/zgzM4PL2CHGZYYUhtZ3uk/ABV8mJbCfHFM6JcvNNTWSRKV7FdudMbR/9S+3mlKbWCIvCuUTAIPgb4Yxh2nP1iWHNXubAz2qhNmVNpC0pwPFWwFdH8XM2ggKUmDwzF3GimX8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017516; c=relaxed/simple;
	bh=ZXY8byP9dQrVc5B5b2BRNnvuew3SQyUj4T1zCT9fjYA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6d+gAGofiNINE4pSaercKqKqzyJQrEk7+qI11+ZfFIu2XW45UjhaF+1mBXdRO3mYeo+BAF9n2p0nkYBPPdmfg8I9IpNFIr9QWlZ1Jyb4eHHOQAN2ipbIqXnGGNdKooX0XpdGxuY5DdAyMPWXj/9jW3e1qNkVajrtfCMJOr/NSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4miZjDj; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4miZjDj"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5240764f7c1so103141e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743017513; x=1743622313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EycdN3E1BSZiORJ6XzALLnkt7w3brNrRMBKjtqd4mzs=;
        b=B4miZjDjbD7bwevH1dxaTi4yK+YVE6ATwIPSiJpNrj0SL31WDdcqhTWQT5YV/SixAH
         BRIezA7B6J7ldn6mIliik1583BGa+TAKfCASpyPF44JKVnpIjlUn1ZVhKy9WF0yxXJML
         wBi4Y8XqgyNmLzbuAafb6NKTLjG9f9y9rhYSDDiRgc9n8meRxeRHrZ35j2RShl4QXNEe
         J9F7jLz1dGtnZ2OjXUr9RFwlWGK8N+rOp+WjTxyOz1mRXne4nOXYu1GwdXQFpNje8KtP
         k5H/9iSHpAUFv4Lx8OwiRv4ZDxAhf3YCySe9C56YWcB2Oz8GZ+FQzTu7X2va7IVWWBpz
         wVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017513; x=1743622313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EycdN3E1BSZiORJ6XzALLnkt7w3brNrRMBKjtqd4mzs=;
        b=ftHbCroWOD7bo6k4ltPkNwiNZCNLMK6iJBwDQgDjBBMjzyFPVbM9t8OmZRUOxKXJMv
         uFvX6evAp3bRPAglZFkNVCnlS5lNdLHGLugdSLwpMOXtrOEhjRc+NUuVtH8RIOInWDn5
         QRZK79DaPfvtnpp6TkQcVNW7smTgfWy6rX/F8/IuLQfTHUrmzinzfVqnuRNpsY7DA0Dz
         iRL6Um+qymMk8rxfRR+3d1xNuNnJLjO28x73NsZ7D3OXet06TnMa/qXU0X1JgvR6fm3K
         Yt1CniPdlvPITSX3cv/y8Zx5Z7gAWidUimjflFY2toN+Q+MHO/vt3Yi5l2qFEsSBn/bg
         Itlw==
X-Gm-Message-State: AOJu0YyN67tgHi5h70IMybR768AUyOyeFJAO4OXzVm9H4LfVvMl4u4Gm
	0Zncz6+iYchn1ancVrIfY1GlJ4tnYRir7whmQQc26yZ3SjZReOE3AcRFZrodv4g=
X-Gm-Gg: ASbGnct7uCBl4mdPFrnfglh9eo63+GMjVZizuuZ+qGYoQkPKpupIAfxL3STbEfv9HBM
	H5hIDSLw8oWCQ0Qxy+Y9v5ISqb4qBGJ3JbSfwbTeHuB8bdgqeMtKQ3bXs4AGgxO7a9Q/wDU9y6e
	mUljZlqtGq9Xgh74iDCjiGUNjS2OovW1UaUadMJ/D+GL+Opla+LMMSON00OdCm3xP6DJbpuuvYN
	uKOxswIx4dnvtFBhSWGna7sRRT0jS+rAENPsQj9okwZBEAJz8BtRqoEpPFNzghTZLKsbeqHzhNj
	TgVeqhki2x6MwClOvS2UaN4E4TKdxfhoqqcsPC7JMl4ykYGqZ6p9Qo/t4nikNOYaRTaA+mS89tl
	evspEeMIms/KCkA==
X-Google-Smtp-Source: AGHT+IGYR8ND60QxsfmpxCzXgxQCtYNYjtcJ8a8i9kmkioJzuSks91yatnqYIc+nsUA1me80uvp2kg==
X-Received: by 2002:a05:6102:2ad1:b0:4c1:9f48:617e with SMTP id ada2fe7eead31-4c5870b58a4mr1296327137.21.1743017513227;
        Wed, 26 Mar 2025 12:31:53 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bd75e84sm2497804137.20.2025.03.26.12.31.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 12:31:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] device: Elevate bt_att security if bonding is in progress
Date: Wed, 26 Mar 2025 15:31:33 -0400
Message-ID: <20250326193133.2718934-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326193133.2718934-1-luiz.dentz@gmail.com>
References: <20250326193133.2718934-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When bonding is in progress it means Device.Pair has been called thus
the user indicated the intend to pair/bond from the start so the
security of bt_att shall be set in order for it to wait until pairing
process complete before attempting to proceed with GATT discovery and
any other traffic.

Fixes: https://github.com/bluez/bluez/issues/1125
---
 src/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index 034491b59d30..057d116be6fc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5797,6 +5797,11 @@ static void gatt_client_init(struct btd_device *device)
 	if (btd_opts.gatt_channels > 1)
 		features |= BT_GATT_CHRC_CLI_FEAT_EATT;
 
+	if (device->bonding) {
+		DBG("Elevating security level since bonding is in progress");
+		bt_att_set_security(device->att, BT_ATT_SECURITY_MEDIUM);
+	}
+
 	device->client = bt_gatt_client_new(device->db, device->att,
 						device->att_mtu, features);
 	if (!device->client) {
-- 
2.48.1


Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC442E3378
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849159; cv=none; b=pa4thP/eePOCQtoxFAl/M90u2uFkc+eNqnsBq+ZFChSlBTbOznWHaOBIPxpDUT+oISGl979D05qqhDf4qzNO1+cJR/MFfUzA0CQdIMmD8TvfewUO4aa2FTe2sYFlzwxVxbY4S9R7MaSwpFvFo8UU0rnb8td5gK4RfzYi/4PkkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849159; c=relaxed/simple;
	bh=trHHDe/axTazYnHpvZg+VdC358TFl+T2zUlGiXmpuXM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ogQyK73BoLPEHX0t6vqL+t5PDt/enyugX1VuKUh5Wv+yvV7qxy7Ef2PuYMAEVfiqk7LyB4hLO0VVZZWriGHJaDa6YIHcYZfVHQrf2XtEoAI4SKElVykETSz8F/60npKl9INlxTzea468ep0xYABrQQCZm+UxJKd51Uv2gUA2chA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+ypOZYq; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+ypOZYq"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-525da75d902so447511e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742849155; x=1743453955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TL3v6KIlz2szGEYgLrDIAIlO82Ze9/4tokRKWluZnP8=;
        b=i+ypOZYqflUg2r4Vv0Fc8Uq1KLYDLJs9zW5VsovubPg8puy3okAo5VIN1E+V9YwlwW
         JjXpUUTBF1lNPsGgy2/iC4nvh+kUnuAJscjFCZOa088ib6ynefbA/C6xXz6L85Y0KwdI
         xnYRAr6kYcLLYyzQdEme4OWXEUMSAWxIrbdkj8c9+l5NgkbnCfxOXJJkvCrh1pHD/fSc
         O7s8popgrNPd0I8jwvnhsipwq2WfwwrthC1fGhBtiVZkAOVaur1WyT7YHwxkaQK5ocRA
         HOzUby8A5D0drd+Eu2Q5ZwC3/lsieQz4GA2P3Y4fJRKmRelH1Hutg/c/1lw5UaM7g6Cm
         wAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849155; x=1743453955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TL3v6KIlz2szGEYgLrDIAIlO82Ze9/4tokRKWluZnP8=;
        b=ZTXC7ybaTlKrQ5teD9dYM/A9B8QqYPfbG17GXAwn1Ot4N3wy1FYNHVWkCledxxAFKc
         WSf9m4bU0yktnj/iLSFy+tuN02dEiPk0YK9a/56+Iceqlo2RP41AIn99lliZszN5TRAk
         BKEVXBeQB8Ppiysb+nU0eGRURmEqC6/mBF9b+9qdevx3ME8m1SDdaVcSai13SlHhMv58
         /D25RzgcGvBxuO1S4oXR00mgWJJBtz6KrYv2hLqCgix+ORqXIvVU1zDaZfmbob+QCJiU
         AsX1YJA7lS5ep4LPEsaB6uMSC7pb3PKaym/n8YybjhwZB9IoxrK3j6NP5rXfdCOZlErY
         x9Ig==
X-Gm-Message-State: AOJu0Yx5ia1KMjBq4RWG1cVGwfWJgVLHFZcScRck3atp6CucUODz3Ovi
	v9Ah7cvI2nu1F8FG2hylIOU8ViUjRBE5f8rg9gswLxzTnM92SuHrB8x53zVo
X-Gm-Gg: ASbGnctWZB/QOVFeF/5LGi+umBceRuUhxxms9ZxvFejzdwQbo2KquYc9hIxImCe03uJ
	MukMcuYp6fOgnhqc8mXPYcsTFR0t4O+Kca74rEF/xF35YQG9PLI0zs+qLHSn56ABqXPdwyCQlOT
	n5MVJbakRHd6NEn7L/EvNiHC655o22ON/qe2g5AQT7S1E1Bels5OYwomTYcgPiB0XcGgLA/+l/g
	0rCdtbXCQHKMXr9a/5K/0B7jNw2Hk3M3LGNxtKKHGBMhY2Qvm0DTwgl1jI6nnVutfAPuGJDDqlq
	cqBFt+HBDnzBw88gF8IQtP5LMJP/qf3UfqgVBq7Mc5FSyfp08vjMWRoUFGp89EGqFThg+1eVi/A
	HxE9rgKPEdKff3g==
X-Google-Smtp-Source: AGHT+IHOOH7v/7UVcjmdLFmak31SOQ8wvR82Cp/oEXRFmyNsFa5FV9kGDuZyDchc1OM0nwwY1NxWBg==
X-Received: by 2002:a67:c40c:0:b0:4c4:e409:5f9e with SMTP id ada2fe7eead31-4c514b5c608mr7667544137.2.1742849155003;
        Mon, 24 Mar 2025 13:45:55 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc119afsm1690015137.10.2025.03.24.13.45.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:45:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] device: Attempt to elevate security on Pair while connected
Date: Mon, 24 Mar 2025 16:45:49 -0400
Message-ID: <20250324204550.2196697-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This would make Pair act behave the same as when the device reconnect
and bonding already exists.
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 57577e57920a..a04eebe1dff6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3185,10 +3185,13 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 
 		if (!state->connected && btd_le_connect_before_pairing())
 			err = device_connect_le(device);
-		else
+		else if (!state->connected || !bt_att_set_security(device->att,
+						BT_ATT_SECURITY_MEDIUM))
 			err = adapter_create_bonding(adapter, &device->bdaddr,
 							device->bdaddr_type,
 							io_cap);
+		else
+			err = 0;
 	} else {
 		err = adapter_create_bonding(adapter, &device->bdaddr,
 							BDADDR_BREDR, io_cap);
-- 
2.48.1


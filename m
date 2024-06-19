Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C213E034
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798684; cv=none; b=WlCdeZSaI0sVmkH5jUadyyhdit7a6RR+pQAZH4ixZ9EhE5kedpIqocXo+RQ9Ej+0EUjlFmAzYANI/mYQijjHKcxJFboTPQZYX3OaIwL6mX/+6M2kxjMADMA7Oc/jR2I9spSBWKesP/I7FDL6iypB9hBUAEYzfWfvrkMPtTwIGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798684; c=relaxed/simple;
	bh=zUMYWZyOwxd54E5QCfXgl4+x+El5GgiuzbBzYO0TouU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrDTlVzi3QwViDtKfExQBtm7zrjiOo4ZmDuF/PY1cMx2uR88LfCsR2TpSVlatUxm68xQnELKEVvww706zW3ZpAxxwc3OG4ia6fkSqxrYGHJvdOUc+ob3P69fgfbR4BZ0Vauhgez1DAM0cE0nVpmGqehfsy+TX421FLEB3Hwvywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softeq.com; spf=pass smtp.mailfrom=softeq.com; dkim=pass (1024-bit key) header.d=softeq.com header.i=@softeq.com header.b=vADONvGL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softeq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softeq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=softeq.com header.i=@softeq.com header.b="vADONvGL"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso7510189a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=softeq.com; s=google; t=1718798680; x=1719403480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g01fuQ/egb0KsfwVElzInDADskQN0NVK6D3DFRl3S0=;
        b=vADONvGLfDbk1BK2I+VtptZpoWLQUYQ3lMEva+smk4vEt7LyCWruqocW2a//+OpFaM
         c0Mc6Zq6Gz1N2FQO35VOCZVW+i2zbgLoo22n9uMpm1tGOveclSrFRTdC/2Z/29xry3tr
         HUI0rZr7ClKpqH3iAg6CQC+fDQy6R8hSTo0po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798680; x=1719403480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g01fuQ/egb0KsfwVElzInDADskQN0NVK6D3DFRl3S0=;
        b=Itt4Vwku3mFqk3sI4pCzqxy7m9Zh01dWrEblqEMSqj5l4xql6v4RWdGo2EgHJLUpwo
         gPYcV6rjsuHClJa17E0OsnXzn3j0AO32RozbBlj7CYdXseM8EhLT6zMI9D63iuVjuv6p
         rqJNCjIm+WRJEMrUME1eGWDPkvTWFvCvq4DR24qCS6YDcD2hdteFMYjjLDF1L3FCODPH
         usKmaMk8amHSMNsm3BlJbiMAok1E6kkOd9kfpOJtarpGyIOv8WG7kNQi+1o17JpZtUtB
         3tP/7DlRh68MEpcUuh9oEN4FMgLeBJpvrzK3dlpPdViqjBdMYwq+JsHDj1v49elzawIe
         caqg==
X-Gm-Message-State: AOJu0YyE4g2unbSTUSug+Cs82CzYT0V4U+ti9Hzmc+Gn2vhctNQZObWT
	AvzGu8hk0h4IfIjRsFsJp40/5MsbipAP4bcO4W282oBFAkzbE15bkF/9UG3MwDt4PKvWkjEk/Cl
	5
X-Google-Smtp-Source: AGHT+IGjl8NsWTHmefFwtpXWmMPb3Tc6GdJK6AzYnhm7TuuXZ9iJRmb71zpOyQukdpdXyzs4zNqvrA==
X-Received: by 2002:a50:c358:0:b0:57c:7486:3f7d with SMTP id 4fb4d7f45d1cf-57d07e66a64mr1315344a12.19.1718798680164;
        Wed, 19 Jun 2024 05:04:40 -0700 (PDT)
Received: from localhost.localdomain ([212.59.15.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d0d9c3b7fsm406365a12.55.2024.06.19.05.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:04:39 -0700 (PDT)
From: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
Subject: [PATCH BlueZ v2 2/2] mcp: Implement Next Track and Previous Track commands
Date: Wed, 19 Jun 2024 15:04:33 +0300
Message-ID: <20240619120433.3666313-2-yauhen.kharuzhy@softeq.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619120433.3666313-1-yauhen.kharuzhy@softeq.com>
References: <20240619120433.3666313-1-yauhen.kharuzhy@softeq.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add implementation of Next/Previous Track commands to the audio/mcp profile.

It is used by the Bluetooth media control widget in KDE, for example.
---
 profiles/audio/mcp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index b410b3d2a..8d1b7588e 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -224,13 +224,27 @@ static int ct_stop(struct media_player *mp, void *user_data)
 	return bt_mcp_stop(mcp);
 }
 
+static int ct_next(struct media_player *mp, void *user_data)
+{
+	struct bt_mcp *mcp = user_data;
+
+	return bt_mcp_next_track(mcp);
+}
+
+static int ct_previous(struct media_player *mp, void *user_data)
+{
+	struct bt_mcp *mcp = user_data;
+
+	return bt_mcp_previous_track(mcp);
+}
+
 static const struct media_player_callback ct_cbs = {
 	.set_setting	= NULL,
 	.play		= &ct_play,
 	.pause		= &ct_pause,
 	.stop		= &ct_stop,
-	.next		= NULL,
-	.previous	= NULL,
+	.next		= &ct_next,
+	.previous	= &ct_previous,
 	.fast_forward	= NULL,
 	.rewind		= NULL,
 	.press		= NULL,
-- 
2.45.1


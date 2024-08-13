Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11619D892
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559383; cv=none; b=mfKGtQflHh7LMQYynaMn+5tu+BZ1j8uOZDYI7u0KfzQ9DWkKJS/mOMqttjGOIsdNi9QsQk/0P2IfwkqDOEmTFUnbeiTB90pB/Be2M7JXenkHBMBcvSirgoIt5hLVESbcz19q8K1uv6mixud5f1jiCftopyLEuycIxXBvsjG20Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559383; c=relaxed/simple;
	bh=JdYrkUeaP66JYzGEqJQsDoK7qzVCUSpCT7ikA9Lkzwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKLe0J/XsaZRAmsmbQBI9iU/eENms2Uk+i+9ndKI4Y5bq1/Nsrz0z8TfR9ijIdiCRDgNHp3xCPkwg+3F4UqWEHRLLfSUJdqzEaysLKN9lDMXVA8sV0FxqVD891LxTDRTdeG5rbLjXrgIMYGAeZFMc33jVksO440Ud2hWM3iC7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo6s59s3; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo6s59s3"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-83120879efcso1476972241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559380; x=1724164180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLeCCjRQbtE+6uHqfLqj785ZOij2hG+XYPUIz2qnexM=;
        b=Zo6s59s3aefHyCi0ztUcWjjjvP261jPRKeoJUV3rClYAS0M4xDHJxkPlTr/edLER9v
         nasZ/lHLmHa34uFs/kPGAsgzb0zyCdR+WnJwZ+HVD+l/R3O/qDtPJ2rrgfs0DZOAYZcI
         Gp6MOn5Xy6jRU0/PWFe2rXY5B4+q0jWzapJv8haY+l9U3wy+YWCmGJ+xec6FZANRjF+l
         ysGXojYhnn/Xjkn1FKviO/47Am57e7NhrUjKYXc02Olv/d807UkQnnQoioWyTRYzm8zV
         Okawgn/7/W4IStH/TPfDoDYVG7Cxlu/T7GDciwXdadJe0kNBw1PYUC2n8mC6uSyofwmh
         WF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559380; x=1724164180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLeCCjRQbtE+6uHqfLqj785ZOij2hG+XYPUIz2qnexM=;
        b=gHL9EGvJjA2UOc1cYfbXr4Qe2H2niyxV5UTM88tso8DZd3W2X912iJog1q0YPI8IoZ
         4Q/D/AquR3m/xtrZpOFkDkdUJGiUnsXLmU8scbzk9cvKVG/gdakv+dqPvGSXO7v06Zm0
         etBm1EAYEULMTnjoa2kII/+JMx7V8okewcopm1a+jO2YLSJ0ZO73o6IvWN/Ottesf835
         nvyzAbHCvOscEYZTh7p25ug/hwuCEKKuQ5Un0BhEF2iFEfyfyElFj1WUsgyc8Ro8YNwO
         qmoR6n9MbbV5OmLbFs1S3lwDoawLhRUKhYO3kHDaaFqHPZY9zj/uU9r/3aLL7toBwgtR
         lfoA==
X-Gm-Message-State: AOJu0YzE8vsrqqLg8YIfiH0gqn6/b/o5tyIBaR6Iza1Qd83GEX3lbq1L
	nHEcYhvTa/RF70QyPF1ygA8oId27faxT3TSLS+KFy/vYiIs85hp1DOu+rw==
X-Google-Smtp-Source: AGHT+IGjIQaCb4PVNhWiyMsLQPysfYT9sA6rY4fmJF9gZDqMZYwLS0Xiwg/07vKorBwwp53Ga1nn1w==
X-Received: by 2002:a05:6122:4701:b0:4eb:39c9:c935 with SMTP id 71dfb90a1353d-4fabf0d0207mr4247504e0c.14.1723559380212;
        Tue, 13 Aug 2024 07:29:40 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f941903530sm833577e0c.36.2024.08.13.07.29.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:29:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/2] shared/uhid: Fix not cleanup input queue on destroy
Date: Tue, 13 Aug 2024 10:29:35 -0400
Message-ID: <20240813142935.504400-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813142935.504400-1-luiz.dentz@gmail.com>
References: <20240813142935.504400-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The input queue shall be cleanup on bt_uhid_destroy since that shall not
be carried to the next session even if the input node is not destroyed.
---
 src/shared/uhid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 4f149fdb8c4d..98d6198c7d0a 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -504,6 +504,10 @@ int bt_uhid_destroy(struct bt_uhid *uhid, bool force)
 	if (!uhid)
 		return -EINVAL;
 
+	/* Cleanup input queue */
+	queue_destroy(uhid->input, free);
+	uhid->input = NULL;
+
 	/* Force destroy for non-keyboard devices - keyboards are not destroyed
 	 * on disconnect since they can glitch on reconnection losing
 	 * keypresses.
-- 
2.46.0


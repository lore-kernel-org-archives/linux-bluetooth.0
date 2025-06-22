Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724AEC2;
	Sun, 22 Jun 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750611489; cv=none; b=jwCvQxnkkZHCZN3a3YDSNsiPZd+gLj3cGbUZ3Fi1ysHf/R64zZME4ueTiE/EgxAahprFBzSsKlPdbaEuswUTSfQaXGtWoKsRExdVVSBSi6xmHYxq0u/ypoZmbH9SK8WHa3Cyo9OOa4vkJlxgoDuj4sXuRs1y0eJNhh3DhbpigpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750611489; c=relaxed/simple;
	bh=rOVpL9hYzvCT5GZEhiHfaK9LPKp2hOf8C2uhsw2yo+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQgOqYgYnihe4CW3+kd0mRXV7OyfujuLJr5mmj3pnCrkx3lGGTlhrlJLh7rpua61WlVbHhxpAKWAHNN59vfIz9z9vmzKo71AE1BbtNvHdJXzyVCy/hxikLp4QxqTi5gRTfvbcZSJdLbvNHdIlZuWZixxGObSL2UNfduWyjvBWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS6pgGjb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS6pgGjb"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2355360ea88so6407765ad.2;
        Sun, 22 Jun 2025 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750611487; x=1751216287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+7TppqGvsREnHGgpRvwQAWJkzsnrqFs/bVySJ4eKvc=;
        b=GS6pgGjba6xj6MPS83e93enLeCnwKaE1x4sj2DtGJZAd+Hn8I59DgGd9jZCD/AZWc/
         8Ose7CwN2jh/Y6K2YjhiU5nDNkEVjTDoT+HGP0uVNxyCjXNIQoWl1sZ8q8IrUKsFUJKj
         IGFO20De/yXytBHJm68Q5egatdx1HQqjuLmOhN2dzUfwgL3zzVPXe2U+uJDiL6fPyCfv
         WZcFCeZ1bSD9wtWW2cEPd9T4BIzR++3fR+Qk8Fz2q8ERDRUS7pm7sZCtfIv16KUCCYgx
         3QaTd2jBi8xfYmbZPucfOOUkG2mfKhCmgPg+OwVUQe21jDNsLM/EoHQBIp0f33o0f8c5
         n4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750611487; x=1751216287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+7TppqGvsREnHGgpRvwQAWJkzsnrqFs/bVySJ4eKvc=;
        b=cj9JU/K5BfMVT9kutgB4IRgTWUU227JIR5L02Y/naDZLR7RP2YdkxYAWOnVwgCgnFm
         FkZOc8Z1yqGCnBZCwBqpGllj6lXjg1TPAlAVhalchtYJ+lOJRtYYuigSeddFQBUkxM5h
         w/yii0tCKzTMLebC22G7YLa6Ch7IcyQxLszzhPExNOdjTHe3GB4OlSllb5KdhDNCpG+S
         CepkH1n+Fb0Hx2yZ174UphWTl0TdW2JSBpIg/ZDWGyhUWKP2wUPgxcq6ot1yWt49/P+l
         B3HTKXMen7pTqNTXvJ/Fs+W1l0p+uLWbQnb9i97Fu3Rhn6KjqWv5HV8Ldb4QdpeyPE25
         UJug==
X-Forwarded-Encrypted: i=1; AJvYcCU3V7IPhvMAtvssTM+3oCkSYM/Loc1qGvib7xWxJVcxqTkZFVoGASgAm5u6aDOhOmP3rgC/PMUqzD5J45KN@vger.kernel.org, AJvYcCWZaNwTlFNjhPW5U8LXEAdy6hRmCAzsVrjXA7Tuy3aFyeak/qb0kDJ+qsBv0Gb2gLjfszRlqLUPgetVnHJyiW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUhim/MLTg9pOU+qgQBSMObvyjHWiSPJ57guhGI70AUppfS4H0
	Kx4QCoCgEnH3BQM65wCTybVSGXD92qKFdm7wolQobxije1DlhKdoV1hE
X-Gm-Gg: ASbGncvxfQonSLJC6NnWGRtE104D3AVwY2CuS1nAJzokCqwtrn9eDqwG6zyQH3nhnxK
	eLvfyRSjhlobkx8X1fjL33t6DrdDhObBU1+2E+7X3W6cDdIS2HUQ6DOik1Z8OJUhwWBVr3L6YZm
	Ss4Cno2peEcNUv5m7rnpIBNP/txbIz13V87zMS0YdUCJBHLyNI1apeK/Iz0uaHil0UxfdzlmyXV
	Bu/1B45tbKYATGSz+E/ZpOe7E5dNjO5yKWUkAUWY/NyCX71J61dIAAhY36nEcNn62xNwFtarq3C
	dXDVmcRJnYMX1ByPuQUH5OpmARYwENyqaZn64ykjZvHS3RobNfuRio6FUo31VHNZpMn9WHo4ybb
	+sKqGbjTtS4n0r/eCm1wiAhgRmw==
X-Google-Smtp-Source: AGHT+IGqUISVjmPgXM99AwpxbOm641DaKJLZqy13bL0ayC1pZCSk+2PVf6A2nDpFeUlJ05jmxgsFwg==
X-Received: by 2002:a17:903:41c6:b0:236:7050:7464 with SMTP id d9443c01a7336-237d9a68349mr52343675ad.11.1750611486844;
        Sun, 22 Jun 2025 09:58:06 -0700 (PDT)
Received: from sumedh-ThinkStation-P348.domain.name ([2401:4900:8813:976e:582e:2d00:8d9a:ec1c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ce860sm63981975ad.65.2025.06.22.09.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 09:58:06 -0700 (PDT)
From: "Sumedh W. Jambekar" <linuxsumedh@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Sumedh W. Jambekar" <linuxsumedh@gmail.com>
Subject: [PATCH] Bluetooth btusb.c: Add pr_info() for logging.
Date: Sun, 22 Jun 2025 22:27:09 +0530
Message-ID: <20250622165753.65461-1-linuxsumedh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, the pr_info() call is added in the
probe function for logging purposes. This is done
as part of the assignment in the LFD103 course.

Signed-off-by: Sumedh W. Jambekar <linuxsumedh@gmail.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9ab661d2d1e6..5ecb9a61a33b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3858,6 +3858,7 @@ static int btusb_probe(struct usb_interface *intf,
 	unsigned ifnum_base;
 	int i, err, priv_size;
 
+    pr_info("SWJ changed the btusb driver in the Linux Kernel\n");
 	BT_DBG("intf %p id %p", intf, id);
 
 	if ((id->driver_info & BTUSB_IFNUM_2) &&
-- 
2.43.0


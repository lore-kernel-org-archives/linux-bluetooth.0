Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43068F7D
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542901; cv=none; b=TfqEjeyou4IXIxHZvXKmoMN2udmeOH/aCfTkPY1SemZSS2rV5d+0Jlxd8ffSdVpMaukUTnCJNV54I4Kq4lODxGd1HNa4rbVK8/d1l/w0gxRmEol3HXd5ZZrUCtQofvk/oUE57zwN+wuy6fdcbaWYeAPw9/OFz8WsNVH8eUoSR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542901; c=relaxed/simple;
	bh=icU5PsDYBes2DKqDbnf1HYywgEsHxtnc1ddCAYZ4Yv8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VUqGqUfiojJsC3heE3NDglxIeutnFOM/9guoTlMGe6OCE6AG8ZqI3QH/Od7L9gWsn34C1IImrDHdB99zNqSfTeFfeXISDma2kTtvqFNw03bV40JI7GMe2D3qpCsx+DNarDkZSCSLQURcQmIWuGb1wvT2mkgdEE8kf9s3oPQGslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOWqGccS; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOWqGccS"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-524168b16d3so3777605e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 May 2025 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746542897; x=1747147697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz2X/jn1Af0DiWOdEMUL2nWTSLBccD0zDvS3LPIHg8k=;
        b=MOWqGccSd883Kz1wGtIAA2bJrgNRjN54D/XIRE6E1MNx+4jDqBYj6cpgJHcSzbF8z6
         p6iagz9/Cm01268H3O+vqdkB+LXkJ1DCBwgEQ2jiVUd5/eKyI+tm7fPzmQhkMlhk3UIB
         p2qsO08EcGYZG9KQyhiWysWmVR9bLSstr5ZhlmVhfBxE3MS4q11vc17Q7eEomGYq2/7u
         36IldTC/0zUZizfqAvamXI+47F2c1o+YriTH4Qc/5RsNcZIOAz8Cypu82RBFAxHZUW9v
         sXET84jD1mRptGeUAYcuHesiVGSYKXTM4tGsSNnCsuo9fbetaCCIhoh9DkSSu60Jh5Fq
         Ce5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746542897; x=1747147697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz2X/jn1Af0DiWOdEMUL2nWTSLBccD0zDvS3LPIHg8k=;
        b=nH7dsKaIsbHj0SOCd0QibYOi7xZSgluFdRRBk7KvdOsOcjGTORoEzbs7+koHZZa9h6
         2sAYS5cjFwTwbIZKpcTgU8oQ1zX7VG76pxugCIARFruNWvcQKdDXIdXZN3Rmqbiqy8az
         Re7YRgEM7lKJHrX4eeIWlez7M6qKdRnSboSP2biVe7LWYDxRbJ47E3LFqqabF0z/1mg4
         jsVPhw9p59pG1TZt/62TFdbl0MmUebZKqUgzY7IZ5sRKufRe7KOt5GbFKiEo05nH8U3T
         UBcRL+1alTf1692/CMuWAxV6w8aXF72g7qNUVzgtkblHZHR7597mPaeOngOWaTlJ/WFQ
         uG2g==
X-Gm-Message-State: AOJu0YzjeCMaYmsRvvnbWzQ+4NftTU10ZU5zpcpxGcAsgOh/Dxh1C7Cv
	tlojRPTdmYpxawEheWKleLyaMm72v1VqHAMZ5Q4hTHsYBhueq/d1DooKeQ==
X-Gm-Gg: ASbGnctzgcxvyiqamZyZA0EXbb0e9o+0Lf97ZlBZWsv+LUowYAC8dqFyUYFkoULeulW
	6IjbkAlAdI52zFWfvKEvvMaB39eAeAxpeiDX9f4ngKJz5dlluA/VSwGx9C06q+VmrKs+pSNTqEi
	DYBKfNKiGQ0p4y6p/vzaEgSHW4spJyhfPJjMUhXuVhSFm33Tfa6kfyFOQNlwfFe7Zm4YWfyDD0b
	StBfzZTE/m9Qm/tN9Md7Rep0Ns33GyRLzAe/sYzcJsZNAocmII6DLR8X0vzSr9fH7YW4/Yfh7ja
	o49H7OeiWs/I5u7B8PwKLXXomwC/OQEyXV8+BEQZkwaXYgZDciE3zmZ11VSV6TqcUSRb8zG2LP1
	n3itCLJcUvg==
X-Google-Smtp-Source: AGHT+IEXXg/LPNqQ5rjcKaIvJNzCubpcYkcQ6qJ3m+ZTaDTG08s1QU/9TVMQpU2UzrS2XPB86hEfjQ==
X-Received: by 2002:a05:6122:920:b0:520:61ee:c821 with SMTP id 71dfb90a1353d-52b06889a5dmr6505440e0c.3.1746542897303;
        Tue, 06 May 2025 07:48:17 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ae419d6b0sm1946454e0c.38.2025.05.06.07.48.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:48:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] main.conf: Fix documentation of TemporaryTimeout=0
Date: Tue,  6 May 2025 10:48:14 -0400
Message-ID: <20250506144814.49996-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Setting TemporaryTimeout to 0 never enables temporary_timer which means
device_disappeared will never be called and the device will remain
temporary forever (until the service is restarted).

Fixes: https://github.com/bluez/bluez/issues/1100
---
 src/main.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.conf b/src/main.conf
index e9c7552a2c2d..ada9b9b5ebf1 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -104,7 +104,7 @@
 
 # How long to keep temporary devices around
 # The value is in seconds. Default is 30.
-# 0 = disable timer, i.e. never keep temporary devices
+# 0 = disable timer, i.e. temporary devices stay around forever
 #TemporaryTimeout = 30
 
 # Enables the device to issue an SDP request to update known services when
-- 
2.49.0


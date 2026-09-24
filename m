Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA040B110
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289068; cv=none; b=Ukhy6Y3gLxaKUorFpIyVVL82Nv2Y0EM+ICbWT12iRtHt0+VWjKeVtoKHdVHy59SJeZcjCNWCnxn2VLFyA+XGV3gy1RvurBAzfkFZ1IzCE3u1zTmT5QaND7KQ0ddeFQDvAykYwzQ/rfGaBFEY56+3W2xJCNwaedxw49m5KT/PqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289068; c=relaxed/simple;
	bh=ncqkUYW50ac0++iN6nTDr/JlZhpfLWfwrOoC6057Ed0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYuDCqXnZiTy+NgPiY1p4V1OYbUPPFSGeubQdWLsteDB8TDjquGFUuPH9YB8n9zVTTqzuGis7gk8o7wosCxnhmTA2gMnysG5Dh/1yG0Q1UNNrWwEcpxL05vsb5TDEKlTkGYyO4KUC6+2JHDMoVcawT20EultR3vM0j58NJ88mPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ/25MYD; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ/25MYD"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so211170241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289066; x=1790893866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gFs3sSjC3QU/qGM/StIg9u+W7HIgI8p0VPqO4E/7wSA=;
        b=gQ/25MYDaOCUZmvuOlopru174r5L0oowSMq0b2JOAaVzAVjOiPP93OaeNhcnHW8Upm
         xBYpbB5t3/XHBX04D8eLSnwQhrZYRvw8PuJUeE8OCqLIcpgnD415VylYCaZL0C5YToOz
         2K1+eOs7OFoJe3R4GGgv18/ihxL8AFTSCqOWxNYG8NlBd0zeO8Se6IBrVDNmYly/bRYf
         Dg1BxlUg7Vs7bFCZafTcVY7NlU068RMqPB1qSshDClX2nBpqQYoKcc8CN4HW5KWUL+By
         PwwuH51NQ0DTv5k4bUbTDH81EiUh8mECYavliMILV6Uu9O5mKYClSNy3YFJH4eSoqV3L
         tCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289066; x=1790893866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gFs3sSjC3QU/qGM/StIg9u+W7HIgI8p0VPqO4E/7wSA=;
        b=OqmNL+I2bpdHGYgCm50a09ZAfmMBWmY2WZ5BKiVS6K6cYHEV0QNYkKLATbjfGVufMs
         sA8gT3nPIkw950Dfa8mc3J7oU6UH1cxPgXJPaDlEejlHr2wv+wsTQnWYDycom+ITus8a
         wfVKwSngzGkOPoUXH/aJtIYwc5dy6i+xH5tksAtEykgF6WipGjUqddvDwG5kP3zDKrHJ
         Tk1zQ2ExCelv6K6mKnoHtk56XDCsVvWKCvDcf440iMdGQAH+8pJA+jZt9iKrgxsM/Gdm
         SirAm+QO6AMh7ldayBBYMUFdwaMj9dcXvRZzXFcJH6oOsU4mK4ImXGpQd+tqut3a8HVr
         51Fw==
X-Gm-Message-State: AFuF++njia8QP80HbLyFkeBQf8M58HwxcaX6mYC/yWVeybuZlUl1H8c7
	UpM+Kdp5Prk3t1A3oAMfOkssaC/g1CWTYv4xUB78ocn15R4BIi6cYga2AsqRabRsBFVEYg==
X-Gm-Gg: AYBFou1rJzQbr1S+1LAGqOszJGfGX78qNezVWWFCSQ6wBSMRx61HK4JW9S1En5+f3QN
	Acwt0D96Mfqtf2m6YulJpIH+DJMdYbIDBJpuDZ0XvA8werKzeHv7doc0R9AKm51jyzyo3xBjl5T
	Q4UwAlDGh/cL7NqX+ALesxWdhsbjVWKanZrtFewbGmYT8anYLqtJvR7Kfo6HDvaNe1Gi/LkRday
	NA6Ih1W2G1Y9/WGTiFsG6JLN0Hvxh+IHhxxjWCNi4rcjeZYDGeRgY0OoeBQRaIVkvzwRUimON4S
	JrV3xIkukdbadaopQnCUtEMAbK+ipFIOqv0abqhR/2htHR4ztCRNW+h2U+kUkjuO9oRaI5vC8fw
	udLNX8+TdYmo93cR0B3j6lHGqJVN/RyRzGCkkgBrWeQDKNGClZ5WSfwU+eaYcwklz0eQVR8cD1H
	lNHjSOFwfccN+bQ3ArEYneRzrkJx/MSs6fPCabU8HCK6r217E2iANeeVgY5ZUbzZEEIolqWe+pI
	Rna/NLurRs2r9EnjVlQOKWbSjDlikjX1QxfoADZdcwfzmqw3ur+1qfK1xGK1cSE
X-Received: by 2002:a05:6102:3f87:b0:7a2:6b90:3d7b with SMTP id ada2fe7eead31-7af1c691fddmr2213102137.8.1790289065920;
        Thu, 24 Sep 2026 15:31:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 11/20] shared/uhid: Keep reading when an event is not available
Date: Thu, 24 Sep 2026 18:30:36 -0400
Message-ID: <20260924223046.605543-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the fd is non-blocking an event may have been consumed by another
reader of the same fd, e.g. multiple instances of HID over GATT sharing
the fd of the uHID device in unit tests, so keep reading on EAGAIN
instead of stopping.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/uhid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 36a16c331e83..20c55f63b82a 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -169,7 +169,10 @@ static bool uhid_read_handler(struct io *io, void *user_data)
 
 	len = read(fd, &ev, sizeof(ev));
 	if (len < 0)
-		return false;
+		/* Keep reading if the event was consumed by another reader of
+		 * a non-blocking fd.
+		 */
+		return errno == EAGAIN || errno == EINTR;
 
 	if ((size_t) len < sizeof(ev.type))
 		return false;
-- 
2.55.0


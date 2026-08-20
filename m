Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B372E54D1
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250653; cv=none; b=OtG5Qs+r048c+amW8Llb2M3up4mnESuUH3vfi8oxHKvOOst9UtfR+7zqXqsV7k2ap0RfkcK0H7+2vbGjuulKosWyc4fLpdeEknJWyDUaH4veO37jIlHhKWwaOv/TpdJZ3OimqJ5D41b4uASdbokhB4Z6KHIW2xsrAv1EfosFgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250653; c=relaxed/simple;
	bh=ypIEF/rDiLS64vsW9V9PxNZcJN066pr/ldbRBS4bOIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jap41vVkmuLHYY2aZlz8DYQ3q6PA1bphzNc5Bek/+XLddxhqlkJ1X8urMFb7rBEgIp+F//qlY4eeFwD1Zeexu8+EIec8UhYhDGoJCUQh57vXRy58RzeF/f8TP85k+vyfP3KbnPgRMc915//WOT6mXRPU3W10nlu666ZKwY1Rcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByY7VN7T; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByY7VN7T"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bfb3347ce0so132138e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250651; x=1787855451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t6aAuYcDY2XCsE70YPL3E9QCuWra/WWiQqMzg4Qd5Rc=;
        b=ByY7VN7TystPrjbyhc5Pdr0y1kiphV4G955vci0pM4IKwa4aBKeFdH0nRM4qAZ8exf
         DjLc2QIaAr/GXDw6ksZAUVa3arIfElcMNcgW/7PHE4MZnNgsLX3iGOXGO4bz7A7v4oj3
         YNtUB4uWynVLPMWcjLthkKqTZqa45hC5fKkC1h6pjqf+t7uKeL4Uf/WBJlNc4GruvKPn
         67niZMHHCR8tUlBqQyixDwOoNUARmQ3iT7VP/iOQIIvVB8vzruE9VZZqP+jk0bE7DU8o
         gePlNUWjab4npKhfoWVxXSWCm49CvRY57YKeQfpvhbCpjJQ6x3hSGAGxjNz5OZd55NOs
         L9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250651; x=1787855451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t6aAuYcDY2XCsE70YPL3E9QCuWra/WWiQqMzg4Qd5Rc=;
        b=R8MEvRI4FzMWvBVr1bN2apxjFIsW1n4NsGaiKBZhMLVex/p79KVMpukCFxHo3sRIya
         oblHEnriFicUghcReubsGZwAU8MATi4Ix8vJIIDVhFqaaDhyAHw3303lJID23UuFU2W5
         cAGPF/GOA2kVzLnmnhrZHeoUHezn07h546EIDPyayUkQ8MwtAh10EKaZvmXmRbgZOEQZ
         k5Jv6E7d3HEjps3ufUerLxrp18eiPkTaQ04ihrTCJSRNwMxbmQyCzYnihPl84fM1BZjc
         0PzOLJ0pxq0119235S63dFhbQOBT1yf0eKnT3UAjmkGaMN05CkX8eilk4YlGdfk6cpSe
         J4gA==
X-Gm-Message-State: AFuF++nJA4gQHAjBIscV6ds7BB6knvVQaXt6+pccGHITxcMV8lpuSe7F
	U7+VUaawfnqKMqyiecBoWU0TyMjd5aTpdvLETSMMFw3DgEHVr9TncVpq2ax9OILe
X-Gm-Gg: AR+sD10VT1pTIXzjTcuZC1xnUGKQtPB1RZ5OriaX2oS4nJfPudF1eBP72h9iZbS+mwa
	guLCouw/lWCvNt2FH3XTCpKXk5iuZ8qArFuHYZW4i3O5ZrTOCkVMPjwd00ysAuXmZ75NnV6CMXG
	9GWB1bqKLkschuGlm6CCJ8g/QhAvoAObQfnF5IbisWe6YCrwiEKhugqoOxL1TyYYHHdonsTHCXj
	VkidxKBXwUqZVz3len5AbPhtI0yA5Bw2bC/ytJezCmbBKbL4Tz43DgkigHpex5YujA+zKenaY+D
	B2uPAookYwqtAJwCcTiqYIm8M3zd11khFQGjw+jkEGd5NlEnp6BRxc8qhId0OHIotwlmMl9IZnH
	BGLzmrodHoV9IqpQi4UMkTYSZabOshZgxOMej05GGpa8wIFoNtkcESiNFTdcVg95L+KNCnl0fl/
	mu+gE5qq5ZQT76m+ZHcK0kBG5EpHAI0m9ur3+ZdRc12c6FbspOm1Moi57MoDae6xDINzdWmYQEh
	Dgx5zCE3l6GD4/8VAugZTELhvI8IAHTLK3Zkll7XmL342PtQGYpZSE=
X-Received: by 2002:a05:6122:220c:b0:5bf:8955:a8ce with SMTP id 71dfb90a1353d-5c5ff6a184emr339927e0c.1.1787250650775;
        Thu, 20 Aug 2026 11:30:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/10] shared/ad: Fix reading past the name that was copied
Date: Thu, 20 Aug 2026 14:30:29 -0400
Message-ID: <20260820183037.2713973-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820183037.2713973-1-luiz.dentz@gmail.com>
References: <20260820183037.2713973-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ad_replace_name() copies at most HCI_MAX_NAME_LENGTH bytes of the name
into its buffer, but then hands the full iov_len to strisutf8() and
strtoutf8().

The advertising data is up to 255 bytes, so a complete local name field
can hold 253 of them, and both end up reading 253 bytes out of a 250
byte buffer, 3 of them past its end.

Use the same clamped length throughout.

Assisted-by: Claude:claude-opus-5
---
 src/shared/ad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index b1d1b84611aa..ebee078500c6 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -276,15 +276,15 @@ static bool ad_replace_uuid128(struct bt_ad *ad, struct iovec *iov)
 static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
+	size_t len = MIN(iov->iov_len, (size_t) HCI_MAX_NAME_LENGTH);
 
 	memset(utf8_name, 0, sizeof(utf8_name));
-	strncpy(utf8_name, (const char *)iov->iov_base,
-			MIN(iov->iov_len, HCI_MAX_NAME_LENGTH));
+	strncpy(utf8_name, (const char *)iov->iov_base, len);
 
-	if (strisutf8(utf8_name, iov->iov_len))
+	if (strisutf8(utf8_name, len))
 		goto done;
 
-	strtoutf8(utf8_name, iov->iov_len);
+	strtoutf8(utf8_name, len);
 
 	/* Remove leading and trailing whitespace characters */
 	strstrip(utf8_name);
-- 
2.54.0


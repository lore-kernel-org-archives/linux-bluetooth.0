Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8C2FE05C
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250663; cv=none; b=RBx+cxF7fiIWK7pvqREb9qknjisGPuxyLPShhjbX9ne0TSb2AtnOuyvTXfaNkn9KEb6m1vGs26GlhsdKiXDkn7+zAuebOPBf7S01YSKwdlYRHzb0IzkaHZBBP4OdsCzXr98ZnHE94Z5SKGn7WGrGs5VichXjwu1OIDHSSPt1N/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250663; c=relaxed/simple;
	bh=UZexpsVgJWH+MSGm7ckXdN94jfxuvsoDQHlJCjHWRjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJqiT2wtCKaOe254yV2ijDk2kGYcFk0dY3zLgJzyPeldHHvTnPSCxMSjzMs71rgXbg8LB/Nvwa8gRCSZ3zZj9GXWDDTq70kSCfyw2Best3zQa5GZDu9d/b7niBBSBxNI2/seI4BsivbLCB+q5lAX7d4KPMFiLoIgNDuZYZQo66g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnNABfDK; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnNABfDK"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c30d9adfa7so128075e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250661; x=1787855461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Sk3Cim+mY+syRWvGmQcz+ZIKAoU0Mbr6TXZR+FTlUM=;
        b=jnNABfDKmg9M5bd8MQdGA3ox7SUoBuK6ZkKlfrP1FRvkohUTKqMqrPn5ZAIyKUOAou
         677Op+00fSqX9VHIWcIh5wjIQG9nQhJP6OH6xxvT9jPMqDiCJ7m/q87tOk/1xlpbHKEW
         fOw+qTE9nTj3oP3Fk0N9fsbT4MoeN8BWtWQrQiu9du8/wjFC7PbRrgpY3IE7Nsq7Dz+c
         tsjLou3jG3iUUCPGA9hAk+/HXtFQG01+3eqFB5J0D8TThy7LcOarsqWplefJB2fbD3x+
         jRXqCXaSY+gkT6Yl+V8uqi+9A298jCBfMpLG2BoR6dFYQ9gBH3Y5iLYsrT8l3bMoEQb9
         71Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250661; x=1787855461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Sk3Cim+mY+syRWvGmQcz+ZIKAoU0Mbr6TXZR+FTlUM=;
        b=RCqdJCh85peRcODS1e4HLHYi+as7zvOMBMsiTmjhXT2H76AaYX8WaSVT/PywNBDVUX
         3EtEVl5+RWL8BEeVG4cb66QRIzGcKay+wBsQOp6xU1de3Ju6JFK7loLVem38Zhl1HB78
         75cbHh76vt2cst1mggg/4iZDLTl2xVflN7iw76J43VIjapADZKq/c8H/mVlMj44IEuVP
         qyNYGsexX7dW0Txk46X0wep7dEvfDDPc2k3HvyTmLe3enwzwbq9/t3w3PrDMAR6NdeuO
         mMQgfNSzz4orw1G9f/hj3v3B0jCfBfhlNEysc6rY3pvSBB4gWBcZ097fAGV3n/nQNgiz
         efAQ==
X-Gm-Message-State: AFuF++kgk4k+PB8R9XswLIQ1PKAkRXIz8bsTM+aK1BsQ6dbbuCw9eCsO
	M/vQZ/0hCzAq1Rwmy2Sds49ET0RaC/9fdtZeXPQhunCqjge9JemP+yWlbqHm76aL
X-Gm-Gg: AR+sD11olBFKQjcOeBHXpzVcO7yna5O56E1mU/iG6XxzLrklCLFIxb+h7DsnobxOym7
	L0HayZUPAnAv//Y1CmThrxsYj2EJgRkXpCrIDcQPENK9216Qe3FiMX5aDDITd2vqfJkF6r7ldEf
	m7gWjWLkdNDB971HyK9f58yhX7l7R/cDIK8JKygfvJA7XAZKyts1nSSjW4t5sH036WAapynMxUi
	76QssD5xrGkTPXgZ7jnG1crHJ7I+A3kkOjra3j8BjqaS4PDbWQaO4a8uyQXQruNIYFt2foHRwNp
	mRbO1MYZ5GgE6RzwpDrGOnD6W+rIlJiZ4ZBRoIHgPnQwJM+R076wP9dhQZPWtHEHEgKgNnlFLIJ
	v/CFI0iFaWp16wbgheTrlwMM/jto2V8Lu9UJeOZ5vETflY7c8eLja9nRwmmpVW7Xz8QwOr0B1gP
	M1H27RjdbFVHZ9f1VDJKGWbSq/LhP6gmaZDgNLU055x36/voKlTlGCM7tzrKwjCKPTeE91HpxoL
	UtxsnKKdkm/Ej94mB8SAt2SNqWfJq0F2m1vRnwGj57uipQ4H8YBeEok0trJ
X-Received: by 2002:a05:6122:134e:b0:5c3:b805:1106 with SMTP id 71dfb90a1353d-5c5fef8d437mr455808e0c.0.1787250660836;
        Thu, 20 Aug 2026 11:31:00 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.30.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:31:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/10] device: Fix the name truncation splitting UTF-8 sequences
Date: Thu, 20 Aug 2026 14:30:35 -0400
Message-ID: <20260820183037.2713973-9-luiz.dentz@gmail.com>
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

btd_device_device_set_name() copies the name with

	strncpy(device->name, name, MAX_NAME_LENGTH);

which cuts at 248 bytes without any regard for where the UTF-8
characters start and end, so a longer name can be left with a partial
sequence. The result is no longer valid UTF-8 and D-Bus rejects it when
the Name property is emitted.

A name made of 249 U+FFFD characters is 747 bytes long and cutting it at
248 leaves a trailing "ef bf", two thirds of a character.

Truncate on a character boundary instead. The same name now ends up 246
bytes long and stays valid.

This also means a name that is not valid UTF-8 to begin with, as can be
had from the neard and sixaxis plugins, is now cut at the first
ill-formed sequence rather than passed on as is.

Assisted-by: Claude:claude-opus-5
---
 src/device.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 65d84be56ca5..df607f718be1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5103,12 +5103,22 @@ char *btd_device_get_storage_path(struct btd_device *device, const char *name)
 
 void btd_device_device_set_name(struct btd_device *device, const char *name)
 {
+	size_t len;
+
 	if (strncmp(name, device->name, MAX_NAME_LENGTH) == 0)
 		return;
 
 	DBG("%s %s", device->path, name);
 
-	strncpy(device->name, name, MAX_NAME_LENGTH);
+	/*
+	 * Truncate on a character boundary, so that a name longer than
+	 * MAX_NAME_LENGTH does not end up with a partial sequence, which
+	 * would no longer be valid UTF-8 and would be rejected by D-Bus.
+	 */
+	len = strnlenutf8(name, MIN(strlen(name), (size_t) MAX_NAME_LENGTH));
+
+	memcpy(device->name, name, len);
+	device->name[len] = '\0';
 
 	store_device_info(device);
 
-- 
2.54.0


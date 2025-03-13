Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF61A270
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741899252; cv=none; b=fPWgeAKzvburnyGYZH08PlJ+zNzGqe1C+NpQpJ5GzIkdPWzkJqlruIh2VCez4XcFGHjjwGVbuM6nSQxeQJuVElSoxL6ijIswWp0KkItIGh+GOeXM4XidE9k0VwqLw7MceUlLJb4yUYuVMTbMRB2ngfDgxVShW8aRtZQPUCJwAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741899252; c=relaxed/simple;
	bh=euKARkQhemrK0mEHZwawFeFRvjV7bVivEYr8yikYSsg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h0BypNuW5HMSzpkPsFr+F1wbvT99q1Qo5r2rAWRIEdsLUvsYneBi61CaMZ0QqHo3opDnMLciSTjKzfVBXV4zTWXaGPWKwHBSeS4wfCxGHlAMtPaK5duYIeTr001+wsDKe+IrYRipgn/UcgqQValLgw1spWvx53e+hb6XMEkVng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUZBEC/u; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUZBEC/u"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5240317b3e0so539767e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741899249; x=1742504049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0HDYSOy2zPROmaJmkJ4WhyWjQg41oOWEgtdzqz56iQ=;
        b=cUZBEC/u8K+3COHMRxLsAReaxJqXGbERJsoaBLYVeFQmF3tC65c0qIXvTfggEgSw3y
         S5Hy+hF+8DqAZnQ/i6IunA0Z/hMf8V4eVOS38oCQb8sNIO8HHhgzQv9RU8jhb+rryHKG
         96L+7VLmf15ErW5mwMb2D3L9vkYUqrOJTnQNyevOa6aZfamNbOqSQ4pr9pmmqT7AnPAI
         zEmLm9EQZkkvg8l7FT3FrmM0DR7cDrRsk5YpgdGKzBf9DWvfBrDMEDVxrJQDxKR3WV6i
         11xxRtr0Z35OHL/+4u9q/KuAXfS26TsH417UJDVHr7dKtKMjg74qfQol9QwEgIzIev5A
         SRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741899249; x=1742504049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0HDYSOy2zPROmaJmkJ4WhyWjQg41oOWEgtdzqz56iQ=;
        b=Y9D+ZSYQbDmOPxFa2pZS+2w5bd0HjRMIPXdNEyJImmrW3e8osmiw8sJIzECxKADf7j
         kd3aVdx0nzAnMv0d0psVvWvi3WnIYcXjZTnVuooFiXRu63GlhNxPPr4xt7vhRsXfYuxA
         DYoizYW3zP8QHo3lqjiaxTWgEg57FGuWV7Uh5WxqqxguUkQIXm72NS2Fe6T2kYjyw/BJ
         O43WbwJcKfR4xeq36+v4StoTEqMdYLhRVENvGojt0FwcU2RXjXszS8ys/xK2vN+XYUMr
         2GkLNYymF7iESMMiVoke9RCqLxjmmKsJK54lfg6POL7DtoqiPN2yG8Ns45W7OOEpV53U
         LiCQ==
X-Gm-Message-State: AOJu0YwCASqapUZZztwE1CvY7WmPvLsd9S9X9Wvow16xldFg/O+MBJwT
	njxq2ttQH26UB7O+gjpZAjEriWtGsYdhtQ2cg6czclK5YXBsCTFn1A2lQng2
X-Gm-Gg: ASbGncttwj0B/iccOYUDTsfOr9qhgL2QB2rB9SACphAiPE+1c73xBtiicqaRnAsUrAB
	nvogQrAmGunTzZ9xfpZuTJzAFY8s9GfNJ0QbG/PA0hqrQoJQDNxXNgmqBKOLZ2aqP6skOXb5is6
	obx0CFCwE4qDuMzKtZlnVHpd+SMfBBqEVL3lyVs3QYFB9+/ZodJPsPvRu1EiAfAe0IV1l/9ponE
	hS6Xnbimy7ppamwcqJyE2ri5fNDxHSEW+px9zZ0ae9dLwUpIhyUcrIgNPjH2FQCKviP02GpWSZH
	kpb42KP7MAgK9BFAY5nJYKRe9JNd+PsmCw1M1YD1lKOyqqwKiRgtCtv8hPIGnZUpZFRYVcYbtCp
	IVAoPwVXJCPJj+g==
X-Google-Smtp-Source: AGHT+IEHVq9HIMVEs7PA/6zVWGimtu0kO0FJoOP0Hh2cqJEa87jfQ6Cb6alkb7VKrIuGYpx6qsGAcw==
X-Received: by 2002:a05:6122:4b18:b0:523:bf8b:5dc3 with SMTP id 71dfb90a1353d-524499d944amr99345e0c.9.1741899248685;
        Thu, 13 Mar 2025 13:54:08 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5ccc18sm349007e0c.22.2025.03.13.13.54.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:54:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] gatt-client: Fix Handle property of descriptors
Date: Thu, 13 Mar 2025 16:54:04 -0400
Message-ID: <20250313205404.534383-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Patch cda5549f2475 ("gatt-client: Add read-only handles to dbus")
introduced support for Handle properties to GATT attributes but the
function descriptor_get_handle do access the user_pointer as it was a
service not a descriptor.

Fixes: https://github.com/bluez/bluez/issues/1133
---
 src/gatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index da7c16fc14af..3c31a422eaba 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -141,8 +141,8 @@ static bool uuid_cmp(const bt_uuid_t *uuid, uint16_t u16)
 static gboolean descriptor_get_handle(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
-	struct service *desc = data;
-	uint16_t handle = desc->start_handle;
+	struct descriptor *desc = data;
+	uint16_t handle = desc->handle;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &handle);
 
-- 
2.48.1


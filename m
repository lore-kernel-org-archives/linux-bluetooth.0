Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5EE3AEF4E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065756; cv=none; b=ELtpjV0NLQR6kCvQu5MxgfkigXpOFoLG3nBFlJQfIs5Wh9xPiveRINGa0LztC4Jmie9oqdE3r+g3XpHfM2oCeO3JA3hZKRLbrHEOBY659BQ3MAp+zINwCy89njtpJTe354d2GAkbCSACEP3gkgjg6mzXubmzftvLU7kN6v+8YRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065756; c=relaxed/simple;
	bh=5YJZ/jnULpe7PtYtLeMF7f1VDdDvKItM15AigbBuCxc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WA71Z42802cg4qVWsS5X3/0WZrKCSMvO/q8lTsz4bzOpGm8pe/vk7Np4f7jOVE1seL6HUR7jLN1FwMCGTLijUV2U3Mn6Dvyvr9LiUOlIsOqGZDrA3TL5Hsnyn1mnML3OIDkYN5Q9BXXz+UPSxx4WZ7NNvJH0xiQV0244oa7RHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTkB+9uE; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTkB+9uE"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c7d65c83feso208857e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065752; x=1789670552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0ngVFHqPAAFZpq3ZKNLkCnMzrXmZuPChOt5jECR1lA=;
        b=JTkB+9uEQM+b4OyCnArcGbGbWgBnZb77NNU0VHnvA4EhI/zi6VEjaxKMLyxDnRgmz2
         ieZWHsOK8nnQ+L5T1gen89iViTiNpTnXdOy7uWWTdJ9vMdd4WSmo7wg7Qjc31cOXin+9
         zSULFF8BooBPMcdEaReRi8uHJK+XiRHZmsEn4OmqytZrBnH2d9VpHZyXeNuLsyYIxjyG
         5mA7q0gb6EklzupA9pnYhWZHCht03R8eLPMy2vUUlGxm/sd2AzU0PacxxcF25GpUR4r3
         A2QZ0X+2yYtRigLK/BUdmziQXRiH3LkjlbuKEW/2sMV/in2+EAQ3XKE7aPvE3Oe0fR/J
         dFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065752; x=1789670552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q0ngVFHqPAAFZpq3ZKNLkCnMzrXmZuPChOt5jECR1lA=;
        b=qjEFl2ikG3ZTjDfEsiacQE0LE8oCn3OKH/dABPeECFyXMV71xZQC3cvUFy2YyRlzq+
         /VuTJkCmWnVA9hlyOvm/uF9pe6wA7sKXmry6DH9ABqJUKWtL8in+xRId6Mfu5DTtr20T
         geQnPeWVL8cfsz2/ym5hY/GtNCZwnyZ3o8XF5lSqiWlkgfIds9iS41taOi7Ckr3qRhN6
         JAwkshcQTZs5eh2hQMwKtXK4Ao2b8+q2840gLw65ZRs219G1EMyNi12r04LZUHMKDtx6
         nay6U7c0Pn31d08A3uGznbIIzbA6EKT5lZN4RaB7FtxjrLzOwqfENbYrkWe7CO47J6/U
         IlPA==
X-Gm-Message-State: AFuF++nSwlXA/8CcKn0fi5RfGxwZD6grKKpMzd7tVF35iSxKlEwHLkVb
	1vlogdXKUys1LAMSS54xEcgPKBw3yZafb9/Ow4ZxFWLgjK6+732b55QHxSxXa767
X-Gm-Gg: AYBFou068NgEeczTGqbavPok3S76SpVTd2y+PSnIM3M4nbDzwdR9AuQ0riGa/9A41pY
	4aZMh+lDW/NViecOtDSrtw47pkaPcm9iuDd66u4+XxaYnNmicJR/h/9M9qh8yggX7+Xfakkcg3O
	cmRvYQZE+2KyR/XlQw5JX/VkKTgbe2ZtlpgMYe8es38hmRRLekCthi4M9nfgrmrTeLwwP4bXclr
	AniLHlx4A9fq0/jm3qvYiUhxGLaCHMHQmE8b4H/m5nolW15BF7ArL+EeUMIOL+KYn4JBgT1GbSm
	lE/5FO1n47HmcTixaG8t1f7EFr9nMxLJgIlAdoHjoEOCVYGjog+GDNZLoJgAwrqFXD6zlvpQuP7
	B2ud5ja4mXZLYNsJLB8HygJv4YswQl6PYeNGRDGzwTcPU/+zk1/V63fBi+CXonMXOf/vu/YQoUG
	nxIPqHTJ/o07o1uzGVPQd3e84a4HdB/j5+xNZC8P1najKFGM1LdMS8Q+VEi9vTn7AY0bkIkIQpD
	9dK/to9mabRWSdnAHGxNDSnWU+yvxcyah7tEndukCejwiiXU8D5qlxn2fT6nKXbgA==
X-Received: by 2002:a05:6122:4d08:b0:5bf:9461:91d with SMTP id 71dfb90a1353d-5c8462916f5mr1740583e0c.5.1789065747485;
        Thu, 10 Sep 2026 11:42:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470ae7dcsm222256e0c.4.2026.09.10.11.42.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:42:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] gatt-server: Check prepare write length before reallocating
Date: Thu, 10 Sep 2026 14:42:13 -0400
Message-ID: <20260910184216.1601639-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

append_prep_data() grew the buffer and copied the new fragment into it
before rejecting a total length above UINT16_MAX. On overflow the
allocation had already been enlarged and written while prep_data->length
was left at its previous value, desynchronising the buffer from its
tracked size.

Move the bound check ahead of the realloc() so an oversized prepare
write queue is rejected without touching the buffer.

Assisted-by: opencode:claude-opus-5
---
 src/shared/gatt-server.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 516fceb8ed00..fde791aae867 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1207,6 +1207,8 @@ static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
 		return true;
 
 	len = (size_t)prep_data->length + (size_t)length;
+	if (len > UINT16_MAX)
+		return false;
 
 	val = realloc(prep_data->value, len);
 	if (!val)
@@ -1215,9 +1217,6 @@ static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
 	memcpy(val + prep_data->length, value, length);
 
 	prep_data->value = val;
-
-	if (len > UINT16_MAX)
-		return false;
 	prep_data->length = (uint16_t)len;
 
 	return true;
-- 
2.55.0


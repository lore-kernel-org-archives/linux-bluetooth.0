Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429599;
	b=juPMa+7mCWoaZvD6uBDIdb2qpesrsqNrqs+MPPeJr/2lzF2Gzf6N0K4f0x/LVJTdK2qa
	 ENXjX3pRkJzYDGxYNXnc/n6+LWQz19NRINjsFEibVx1OGUNGcWvY9vQF5fPqpl5kIum8N
	 2XE5+SCfyYOQmWdUHLm6t2hQC6696wBcBypOizWLHtXzi7dhaFKCTgMKYmc1hjphrDkDV
	 x5kDeleJ+JBYr7nH2wFiheg/Z8+CpgB+7YBKyL4Y94gzLM51ORScyPgs7GoAYD7zGL2yi
	 jeRZUgVU+VvNjyr8A3lKM2ZbULubrBHpKj5+uwFNDZLGr7hfnjMIUumb+iercDpjdhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fi/0KmJM++Tc5jekDTv90W89b0hRJ4ZV+gb4dSyaduc=;
	b=tVbQB0m7GhtNu9kCFuVaTQ/deOCY/8Z9ATSDMEtDUn2JB3zKFT+xXENwrhw7qCCOuhRU
	 MnUxjHUVf8Fu0BSfDtZYOJMYquQ+6synRHvmnkBxbzjOm2dPGfGOiNr8J/ez6nNngzX6n
	 pu5rxtwFtskLBRoFb+z5rx9e+kp2kmsM9+hI6d5llqa7JuU+IKuPPTKOV2bPVIbFOGgOW
	 0naWehVH3yWuPLKYnnNBYfiYU3OeEdgPEztQaLhta0hVMTKYhYlwwdkZ3uf5jM/nD1fw1
	 JZSLxw0dXMjjChGh5IskUs5K41TsJUJiCFUGHE/W+NjXL48V4cQr2svo7USr5VqTj+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i9UWbTG+;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776A606A8AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7776A606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i9UWbTG+
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso2226936e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429598; x=1795034398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fi/0KmJM++Tc5jekDTv90W89b0hRJ4ZV+gb4dSyaduc=;
        b=i9UWbTG+fMHKCBx2aqoZeNvkrcMPjhIs2RK3u6F6l1YS6uMuwFy9Eckm5AQv4WXNBS
         beJ7Ew/7mLpfo+77l5wbiEPH+U7izO01ZYnYHh9cGJfhVaisng1waIMV4DKX28CkNgMG
         pp0feNjYorZLER3sWKVDzj5x4a5AK7Ocw4eaZ19StjmxVKz05UP/GSAEUoafF4K/P0QY
         kTpv71tRTKMpyUzMv7vzYM/1QqvO7vX4WC6EKJ8l1bZajqT+PV4ZV5zm86j1yqPDQlu9
         WiKdGb4YdhBoyobZsSVfDTZ19O99jUGTBlqyaxE/yizzHbjATIf8Bfqx4ukW/IWcIioA
         tb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429598; x=1795034398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fi/0KmJM++Tc5jekDTv90W89b0hRJ4ZV+gb4dSyaduc=;
        b=mmS6nR7lnyhfIPIwbETEDSZkfjaG2a1aNAeWJpKw9tDaKsPvQOgTAxD60cfNaN3Cqb
         R19SQK0GDD7gqLSwFM4zyHOHLVLn2iOznXaNuX8SxAHsejkg/T2cXzbt7pEnFpjDYk79
         fnIdc2F4JKTkEcwO1NxjnDEbjmtHOSteQYu7tNWHUmUOuC8a55vYSj0CluB4yoBzGNcO
         XjftbP0IegRlHKz7iU6K4/x4Ct9fi9sfXG/aQUKQC0MXeehEJ8XXsOckhOidti91EvMk
         HOcbh3PFktIMD8UFn7wzolvB1Ec0s9yIG1JElNMcbZ6dZT1ypogYgl0Mjyv2N60zpMTK
         o41g==
X-Gm-Message-State: APuU4Z+DLY1fkYcefXsNaHRHXMsUoGX0cc0507PJuP1mIZpK5crOENZ9
	bqQtWb4J5V1E8GphTMBkVD2HSL2Zy/Y9eWLTGQ5klH73Su+GGAfwd+2vE3iCLw==
X-Gm-Gg: AYBFou0egYdvjvfGtWTLDMPjMIdpYCvb9MaeGvoix6kmMR1vXl6eui3Ser1htDdg401
	E9QApBMM8P0BH6NmaMFTziA+pUTpMBvcKxRhCM6vM2wuzmauRMUS8IrP4MU6lRx0Y92PmuCCnLl
	EoL/VahvXpHZuOe9sU0Hanlh5h5LfpPLUtDpF0yiprkmLEhTuOvG1n9rGh6jdw/u+Df5WxkkJc/
	kYhkRZyxb1ngtNEbM/VgfbParzcg0lhnp0l5uZvmtD0ixajqvtI4Rm3U9iVfQ0jfXM+2cv1ipAi
	xF0xbP5eMbtuIvkQ95TfeAUynNU+4lFXu3fTOErTeJeOvqgCAl/x5315isr5DbmjAMaTA0eNVm6
	v7LqI+8zKKgD0qIqL6KLcxDI67eVk1mC4hFGjMMJ6pG6LNwcdBrjsM5gU+PQKEvwxQ7+bjng3bv
	yaTh88fpIeODydjh6BMoAqS4tmsXOOgW4OWs1/hqOTC51ayS+xfU4nBc9UznuuTELEWVjHTYrto
	5IRPeVdkigKT13m+5A/ExvlOyp5b+fvp5HEs9GuvSHegHKdz+OXG38mmuAudQhRfMcAl4uLILw7
	iU9x6ibWbKCNsewJM7HwYkSKPJKG5dUlVIfuC11EwtzhdtpOmTzDLzI0dJ3M3vO7pUT5bwSgWh4
	9vk6j2MHUAXFi9deianY4ku9HCajnqczfEfda8YvbCbAWYIOMLTpItYAFQi+PCJqCVHQR5LC1fX
	fKIHojuoh1rB5iaeOx+XSb4SNX
X-Received: by 2002:a05:6122:3410:b0:5ea:c3bc:c567 with SMTP id 71dfb90a1353d-5ee1c424fd7mr1757972e0c.9.1794429598461;
        Wed, 11 Nov 2026 12:39:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c2f3bfasm4301380e0c.0.2026.11.11.12.39.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:39:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] shared/micp: Use util_iov_pull_mem instead of a local helper
Date: Wed, 11 Nov 2026 15:39:49 -0500
Message-ID: <20261111203949.3874673-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111203949.3874673-1-luiz.dentz@gmail.com>
References: <20261111203949.3874673-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Drop the local iov_pull_mem, which duplicates util_iov_pull_mem.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/micp.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/src/shared/micp.c b/src/shared/micp.c
index 7df8f8346f55..ebc21eb3c8b0 100644
--- a/src/shared/micp.c
+++ b/src/shared/micp.c
@@ -79,19 +79,6 @@ struct bt_micp_notify {
 	void *user_data;
 };
 
-static void *iov_pull_mem(struct iovec *iov, size_t len)
-{
-	void *data = iov->iov_base;
-
-	if (iov->iov_len < len)
-		return NULL;
-
-	iov->iov_base += len;
-	iov->iov_len -= len;
-
-	return data;
-}
-
 static struct bt_micp_db *micp_get_mdb(struct bt_micp *micp)
 {
 	if (!micp)
@@ -397,9 +384,9 @@ static void mics_mute_write(struct gatt_db_attribute *attrib,
 		goto respond;
 	}
 
-	micp_op = iov_pull_mem(&iov, sizeof(*micp_op));
+	micp_op = util_iov_pull_mem(&iov, sizeof(*micp_op));
 	if (!micp_op) {
-		DBG(micp, "iov_pull_mem() returned NULL");
+		DBG(micp, "util_iov_pull_mem() returned NULL");
 		goto respond;
 	}
 
@@ -746,7 +733,7 @@ static void read_mute_state(struct bt_micp *micp, bool success,
 		return;
 	}
 
-	mute_state = iov_pull_mem(&iov, sizeof(uint8_t));
+	mute_state = util_iov_pull_mem(&iov, sizeof(uint8_t));
 	if (mute_state == NULL) {
 		DBG(micp, "Unable to get Mute state");
 		return;
-- 
2.56.0


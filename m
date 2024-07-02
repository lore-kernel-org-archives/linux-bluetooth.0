Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A014F10E
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910152; cv=none; b=RaXuMVmNPhHuxVpZlXKIO9WSZ6YJbytFthG5g/JXrZjS6zAD5sXRXZMUgcehOftA2nLCzzqlyLqDWLftWMtWCBU91QwqnT112EmPDvOOASwFYEJk4NT/24v9mwNhRw1NstApPT3THoZ0k+GrWq7w9a/s1hgZK9Tphgmvj3JCjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910152; c=relaxed/simple;
	bh=pEFwQqrxZ7hYKYFfzvdo3ASO2CPzdk2+VAZswynkeqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0LfsFKAPVWOl6g8eXwiTs37Vp1kDzY6eMkH49YD4JS+ADzjXX7wQj9moT4+tmp3uUO0P4YRgcoT5Fz1jlt5SK0bB0NUMN1cbInkBitwzCBVasiH0Qyq9yYe/YI3xXx0y3Bgg7Zrw+8KSAzKq+7XyGY3uGZxG9b1a+07lQa4KdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7E70E0005;
	Tue,  2 Jul 2024 08:49:02 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 7/9] health/mcap: Fix memory leak in mcl struct
Date: Tue,  2 Jul 2024 10:47:22 +0200
Message-ID: <20240702084900.773620-8-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702084900.773620-1-hadess@hadess.net>
References: <20240702084900.773620-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def40] [important]
bluez-5.76/profiles/health/mcap.c:2052:3: alloc_arg: "set_default_cb" allocates memory that is stored into "mcl->cb".
bluez-5.76/profiles/health/mcap.c:2055:4: leaked_storage: Freeing "mcl" without freeing its pointer field "cb" leaks the storage that "cb" points to.
2053|			if (util_getrandom(&val, sizeof(val), 0) < 0) {
2054|				mcap_instance_unref(mcl->mi);
2055|->				g_free(mcl);
2056|				goto drop;
2057|			}
---
 profiles/health/mcap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index b544b9a0a9b4..7eceaa88a3a9 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -2052,6 +2052,7 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 		set_default_cb(mcl);
 		if (util_getrandom(&val, sizeof(val), 0) < 0) {
 			mcap_instance_unref(mcl->mi);
+			g_free(mcl->cb);
 			g_free(mcl);
 			goto drop;
 		}
-- 
2.45.2


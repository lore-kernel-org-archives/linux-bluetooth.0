Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429598;
	b=PDAqemt2Z07rP2gvtjBglS6bL3NNLmK6bBLFOoDa1SJEf5u64w5vtN+2botg/v4KG1lV
	 K1oKTOnYLDcONs1fQTQnEuaIAEPEjprQ8+etrLjJDHHBNb7K0JuY0wvZwas/zdfSxm/0F
	 fRoat9m9JVvp+bNxynEBfh80NbGui0Vj1triELkkIWX4VM+v+24DAecrK+Cib+LPTYHdP
	 ke5GBj1im2ygUGCaumss4kVK8xhOvVjq2DKg1G8CTUFkN8C04j1LbRGyKMwbxYuFXd0Ir
	 BAjphTvapz7K1w659SBSvWR+7upeq+1BChWAVt8kTw0NxxXqFivLtNcKJQ/Y9VEE7ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cRu86cbbp78Atizqq5ggRsbZJFjI2Eu7oH8XJQQzxrY=;
	b=eM9lr1e6mXHCZJZJU70o/PIwEQUYokfH40NdJt8aCt4pXNz6SUGZFRaJWeI1j6HJpc1v
	 lktWOu11glltW2AKPoQWjn0N9+qhio5AiOjvsLQ+mpJhpXqXdaVFP6gKGeILh0Qv4L0ZP
	 gMvnDVxbcsHkEtaoWzKf0JH/wGrzcOa9HtbAka40rpmWUti6rQWEnLdfA4vr13dOVdXcR
	 EXfQMGnnuh2zWZnBLSWYwSBypBeftPNgbg1MuO0XfeY9KdoJlXwJVxBPtXZ+cdM/IudBi
	 L/n7efxX9qz0B+kMkLmHYPz5/yLZDAA41a7Ci5AntZuq8SzIeCkm6jwukJyCAObACWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xocaJD6/";
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D75606A891
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59D75606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xocaJD6/
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so2374845e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429597; x=1795034397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cRu86cbbp78Atizqq5ggRsbZJFjI2Eu7oH8XJQQzxrY=;
        b=xocaJD6/sefxV6MvB287zYCubT3ddbi6Gb3WmQjrNfgBPDYP9NtyQSPAHTcVseXiGe
         2P9+uGk0VKBP7x3EkXcy+C3eoZ6T5y7RoPqjK8SNOCh9J0hLvaLdYq8+dIQ+q5lgvitH
         WybTlJ6qlBbeI0mtU1fuKE7nfZrzB2WwBXRA6aq/+1TstLYEo06rviFDlz7V/eG2GT3z
         wC8KfKdi/i7TaaKVc4beWLMdWMi4FHWmIXbcF0sbh+J269TzthmlvShGSdanw8ZZJVCR
         hJ6EXT1KLcHwHFtLk54CAOFPnHK2gjNqvawKoBh8oE8UKq/Ohg6jJVfLm/shZWFP7ovt
         mDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429597; x=1795034397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cRu86cbbp78Atizqq5ggRsbZJFjI2Eu7oH8XJQQzxrY=;
        b=I1bynOejcUqoQPYWH5AZvhmTLBkMqFQ866DUh8N7HqgvYb0Ni1Uq1/Y+dJJicfXtVw
         D7MtXw2mj50+zLRG5KUTLhp4o69q8cr5xI2D/THqVJRv4l4zI95DyaAjhwlttFWZUZkT
         zbkByi1GKf6vFdPKr+225o8vCmQS1jKVk7homDp2TjyYozoZ4/X4rLkX5BaIFYPBNVZ7
         N9olLNlEMSeqaDrdLDDlmRRUkiceD7I4n1VTNJONizQTd2awCVnuDNxRAyBcYCWHBR4Q
         hnewFBlRUvurbl4TGro9Ui3Sht1ueOI0TKYnHtjnKlrzWN1ZZSvpYfPLjL+0ZDsnBN7Q
         c7yA==
X-Gm-Message-State: APuU4Z/8eRk7M9tm0t/Wdv7OrsWBalaXAQyG/uVYLTJfBhxEjDHOBQ6k
	xgz9+8cgRuzLiZZDi2l06wHkwRAtitJWfY9nXjEpLPrYiJM3iUPILrSmTmvMdg==
X-Gm-Gg: AYBFou1nW58uJPQ8pIj6MgEeN+J2sxjxHgnXVNbkURHEPp/We7gdjh6s6VrX2vVUPNR
	eTdsHWMXVCjbo+AzXekg4ZTmXDC/IioQZGlAM2+OMWFHTrDX5jR6ycjFtfWGHfBvv1gAjvV+MiY
	R689zEVWcFe/+L3lFM4w3Hze6VH6x6QIkGDuLUE0YdhL1CSgp4KJi9DJn4Fh3dhukux9jABRtwK
	L7B2AaT77xhz4tZGNZ6Q+YFcgAM1DV056pdBX3GqBRmJ56PW4r7EAK736LAplz8De6O9uu2iT5l
	x5KVHOKfHInB+wvYz0MpWBVvY0ZdwzBo3gqyUtVa9roHxy6LTufEATlYeQVjQq/O5nh6ggYj2/n
	bUpnHcKuboUPe4Q9l56dlE0r4HI0Fq07IBB9sLnMQ2yjTTud23jEu/JyhWjKd05jasguxn5bRXH
	M4tZLmmF68mAdvwthq0TZ1fzA8HuuUJnb2y/su9ngkCnDwYDPxcYiBSnQ9KnCp2Pn9ZcSf9uvbv
	7XRcdtA1xHdJCyLBdmIV1mxW0rNFTxwZXVgluL/DG1ueUzQ/cyTWuQVTGqDYl4P7/1LjLZKn+N8
	ulBNZW+rWOvujtzCpyBEAK+H+5CHEHzHkTMoaBGmxwujkDPCjAeocEwDcJ8Hbw7k1gzi00LgNAs
	dgnkb2Hh6vczLfSgTOJIcENlk9OqPNjObX/WUZqibwwaYhM9XfX6eJZ7irlyvz2bsl6R95uowhx
	bAB6Q=
X-Received: by 2002:a05:6122:e184:b0:5ea:f399:781d with SMTP id 71dfb90a1353d-5ee1c4a2151mr1717926e0c.23.1794429597239;
        Wed, 11 Nov 2026 12:39:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c2f3bfasm4301380e0c.0.2026.11.11.12.39.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:39:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] shared/micp: Fix reading Mute State from an empty notification
Date: Wed, 11 Nov 2026 15:39:48 -0500
Message-ID: <20261111203949.3874673-5-luiz.dentz@gmail.com>
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

micp_mute_state_notify copied one byte from the notification value
without checking its length, so a notification with no value made it
read past the value.

Pull the byte from the value instead and ignore the notification if it
is missing.

Fixes: 5c788b73 ("src/shared/micp.c: To implement MICP profile MICS service")
Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/micp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/shared/micp.c b/src/shared/micp.c
index 98baff689fcc..7df8f8346f55 100644
--- a/src/shared/micp.c
+++ b/src/shared/micp.c
@@ -717,9 +717,16 @@ static void micp_mute_state_notify(struct bt_micp *micp, uint16_t value_handle,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
 {
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = length,
+	};
 	uint8_t mute_state;
 
-	memcpy(&mute_state, value, sizeof(mute_state));
+	if (!util_iov_pull_u8(&iov, &mute_state)) {
+		DBG(micp, "Unable to get Mute state");
+		return;
+	}
 
 	DBG(micp, "Mute state: 0x%x", mute_state);
 }
-- 
2.56.0


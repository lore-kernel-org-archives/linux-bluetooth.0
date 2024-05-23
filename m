Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1413F011
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460188; cv=none; b=p507VCC9FoHVw/nwBzLgSxS3m+a2W6LKg8kFiRGTjTgnYpAVlDxLRGP00vSlDIVt+klB4GQXP+KUyXjZ05aGOwr1LIubH5G0sS0xUNLQ5qYJ+qJW8Nn8aaoyD4G1n5SR5pW8LLuIYsXbvSxyK9Lm8kO2bkYMRP+laDptSfXLSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460188; c=relaxed/simple;
	bh=/Q//LODPerr/zMrUtETkysTiZB2ujIJSbJ2XMf63y+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB6pht9bwuzC4aTFAOHWSRA3+/fmTqOFIgcT3hjrkBzvjjt2hj0enh2VdeShLstitppo3eG49rm4L+3iS2SzhLFCyv6xke2jj2KOxeZP2TE+fc3FMMvIru2I735JmFvrZL2bQoOuVNBEa2gKacRbzQb5lYFSmnLC23gSKoxccts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=nC0tmR8F; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="nC0tmR8F"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so106680761fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716460184; x=1717064984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg+yvwJ4dNqbE1D9ZjAWHqOFTyIsrrxz86KwwF0jPnI=;
        b=nC0tmR8FxqNwXhaVMqtoE4MQ8xhEHkmFnNXfXADRgg5/qOyGeeZA4b4txp1g6DXUWx
         oCXXE7/WSr/t3zDmonQ/y43JQ8Jil0FO1YqBS8loIeu/b+RnVsyXJi8iOW/r+8dybe3j
         PcFokcbIk8wrod4nxdkArP+HPYEu5HLXnzjSwyVrtP8i5KLEc5gdeAkNjMPaQfFdmpYn
         z7+9QkGSbgo6iphxS8r70D+2lEDQ+nbAbEN3tIYrHMJgXc6S7DWpfaOYRni2KJZ1kqbg
         yH6wqBYjIyoQH+zUtYfLPclg/GmaVBsu+KJB57229Uq+36F1pbNFjBYxJUCrKR8AYEno
         QD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460184; x=1717064984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg+yvwJ4dNqbE1D9ZjAWHqOFTyIsrrxz86KwwF0jPnI=;
        b=j3ZDeX5dXDJw0Hss2IObWyDdIwEXX+ZX3Z+J5uCNIpUHi3B6Oc+0lwcF6t2BpD3T8N
         /S5+TcFhcKQ+WcnlDO0JAsarKLeFItO/I1m9i9sfsVHs59CnG9L3tn2UVLm+tVg0bfEb
         3oA3xb4tRWq/Cs2WpPg0CRQk0RY8j/IifL7BBpi8wiEiOZx/xrbCmWQZ8F7uYCTBWWjt
         uYqK6efOxi4Y5YkiAJcndC7MYVPGFYxQ457IRCptmnLSOX+GTjWeMSmXvRkc9uIVUa2E
         aAXjNkQ3p9zvlV8OMU8gmuchO5sF0Re3omsN2hb99jxAWpopWFQO3ebyXH7TQYmuHGp8
         eAWg==
X-Gm-Message-State: AOJu0YyHkDpUm/l4USE24zv8My0FtQ4rLKw0QFqC/PJDM7/XI/NG5VAG
	gV+6SOuDhNx0IHNWSO9F8mYmUgj1NaUhXKmNi6eYoX5csWdX4O/YqXvagg1otzw05Gj27huhfoy
	2
X-Google-Smtp-Source: AGHT+IGg7lwIAO6Qo2hMcNuALA6vk8AzqpqyskyfMf82XeqBCgQ9ZpwJHTTJNbwTpercWouTwVUbrw==
X-Received: by 2002:a05:6512:1587:b0:51c:b8ec:c46f with SMTP id 2adb3069b0e04-526bf173473mr3239357e87.22.1716460184289;
        Thu, 23 May 2024 03:29:44 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a50365669sm1673515666b.193.2024.05.23.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:29:43 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v7 6/6] profiles/asha: Use new btd connection parameters API
Date: Thu, 23 May 2024 06:29:29 -0400
Message-ID: <20240523102929.37761-7-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523102929.37761-1-arun@asymptotic.io>
References: <20240523102929.37761-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should set up the parameters expected by the spec / ASHA
implementation, given a kernel that supports connection parameter
updates.
---
 profiles/audio/transport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 7ed633e1c..84805bf64 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1814,6 +1814,12 @@ static guint transport_asha_resume(struct media_transport *transport,
 	struct bt_asha *asha = transport->data;
 	guint ret;
 
+	btd_device_set_conn_param(transport->device,
+			0x0010 /* min interval = 1.25ms intervals => 20ms */,
+			0x0010 /* max interval = 1.25ms intervals => 20ms */,
+			0x000A /* 10 events' latency */,
+			0x0064 /* 1s timeout */);
+
 	ret = bt_asha_connect_socket(asha);
 	if (ret < 0)
 		return ret;
-- 
2.45.1


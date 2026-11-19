Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071467;
	b=gCC/onuDZ1v5grgq5uBEzAsl+L70FEWL4/SGadB8WRXjblco42vTzSUQbHd2XFAIjPcT
	 /ArLiKNhK+e/LDflTLkflr4pKD+QHNrRVk6hgwliQJsbMxss5KF2yWEz0lCmeq6Rvz6ZS
	 tKyZP3yPhHmmz4++zfcAtD2FV4qcleYTUHa4qynJKVfq/Xeo42jjtOfQVpWt3NV5FCGBo
	 dy8lrFHcU6aKSWV2rqGRQpFcxBDAsUo0lX8vpwbdkbC9BihtxaeGkU1yB7ZZChWQb6Rgm
	 BCPmAOuKMuj4+rCT+OuQzFPIjCIMpdJC1S3JOjBIwgjhrCdpWGOvbn7DBS1r5ggZ/Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=hL0coRvU9yookVUAS31HxXmF1qWpYW10skJrWIpzCaI=;
	b=5UD9cSokAevEZYzCfga9nN5CX3t5RXYISQH9lKWYnfgB6Pulh3rw5fJmV7Z3jKR+JNkd
	 5K8ARcGUtFsL3FVw8zClav7zdy7JMTdGQLRKXIThcbXIs6DtWT30mTt/FsizJctj7MHSm
	 WDJJ5ENzjW416/dg+V5+tlx3XBicUheMxHImQ+1t3nHRy0V27yf+xDairJvK+fnMq1LTV
	 y4ULxGVyJfTWyn7Tb3sxkhHdB7Nbn3/dkF/vb87Mtl8Luy9bvR0PlnrIms33I67I3dp0C
	 viI2nVCZ/0NzHocrpnCiBnOA2C2uq1ZZV0IYSdTWHaJ0f/LGROng01T1G7loGnSfC1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aSwXNeoZ;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A2606A324
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 06:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 423A2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aSwXNeoZ
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2118664eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 22:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795071466; x=1795676266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hL0coRvU9yookVUAS31HxXmF1qWpYW10skJrWIpzCaI=;
        b=aSwXNeoZVulFSRrSxfxUbvy1wjlFThSJ2KvwiV4QTs1wwpIUqedVQnfIXAmR3Jk9c/
         +J1hFDPWe/EEoHmpbMGdShKOibCx8n8PpurlfibexDfn7meHJ2KMqUx9tJGOuGGegxqi
         kkjNBgufnSGJHNGQAlwcMW3gvjEjLkRmclW115lEfBbOS+BzIKY0vnRYSGkXfPoGHJZH
         0f5O/rpKLbO/TILcpekrH0Qy2Ppi4tPJz/pEQj7awejomVGOgbcpil6ZKoesDUgfcojw
         gwBxUHg5VtLLQxbZwI6GRRVZCFZCrS3KtwxYx4SHckZHATRn+YC/UbpPXKaPOrQ5gJan
         RJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795071466; x=1795676266;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hL0coRvU9yookVUAS31HxXmF1qWpYW10skJrWIpzCaI=;
        b=pK/NDZPh7rSm21uX1t2oxAB4uL8aZU4AyWU7G0CSsE7Ksd3/jva1MGgVnbAT+3tnQ2
         HjO4cTsc95AjKgplnOuQOZYm+vZS7FaRv1ErObYBPos0DcdAR9lpmdz82GqOFj+rkf9H
         sr0gTwX7eBoG5trHUhCNmKWRY0CVW98VluNO22u3zXET5PnioCmkWRjgDL2ndHqlNeXN
         bXH+IGViEIbL1f2IXP43BLFHBF7SmfsEaiz31BFnnsxWMgrTxVte3ranKj8b/BIUTc2e
         bvWA9zGlrdJHs1RPtAsbq8WRSycWQhEzQOLuSz4GstIZ2OrvGr5UQGIAu1ZPnXmpJI5M
         AFLQ==
X-Gm-Message-State: APuU4Z8Eg29bGIcYZzRNzOHZJ4G1T/tywOOBNFlVR+Llq3sSP8815XeZ
	VHyeIjuWEtpbBVR5FcOLKo8xWwVv1WAyZmCppDFADYo/cBwE9LtTGLFBzMYHbn8t7QMbwQK8h0F
	+a+ni++tzUuDNgHkddEjVpC4Osz+SsefXyKI0fsUhAMV7sImRU/iRpDWxV2dEMPUmJRfl/dwmWW
	wi8papjpTQePKLE+xoaR87RtGXVTO1pqYwDN2fc+yP83JmBiZZOT2wKQ==
X-Received: from dycmq8.prod.google.com ([2002:a05:7301:788:b0:368:2c6d:de10])
 (user=apusaka job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:18a3:b0:376:b957:c01
 with SMTP id 5a478bee46e88-3828016fedbmr4933602eec.16.1795071465748; Wed, 18
 Nov 2026 22:57:45 -0800 (PST)
Date: Thu, 19 Nov 2026 06:56:41 +0000
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119065641.2510361-1-apusaka@google.com>
Subject: [PATCH BlueZ] shared/ad: Return NULL instead of false in bt_ad_has_data
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"

From: James Y Knight <jyknight@google.com>

bt_ad_has_data() returns a pointer, but its NULL-ad check returns
false. In C23, false is no longer a valid null pointer constant and
cannot be implicitly converted to a pointer type, which breaks the
build. Return NULL instead.
---
 src/shared/ad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 236e71950..c772d4b51 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1245,7 +1245,7 @@ struct bt_ad_data *bt_ad_has_data(struct bt_ad *ad,
 					const struct bt_ad_data *data)
 {
 	if (!ad)
-		return false;
+		return NULL;
 
 	return queue_find(ad->data, data_match, data);
 }
-- 
2.56.1.708.g77570a6a1d-goog


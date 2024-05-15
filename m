Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85613EFE5
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789577; cv=none; b=XHCdDI48TdU2kXU+CQp8AcsCAYvCAEBPTsXovye0gsbe1VRvCCPBlqT5iQTlMtCzVHA//dvPrBrmES8GNZ9Pul5useRrhKlPIb6IERS5HqaCkZNzHTCI142FjVlZlnq2NyiVc8bRLAIZx7lNYOAnTrcMTXQUfmTBlMPiuFj9r5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789577; c=relaxed/simple;
	bh=I84OuA88hN8g10G7raMl68EbjgGBQiR0QXvR+m062MU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a2zY+kKOYwg6gwflHjhIodp9ibaPOCjIJIBkAW4rtF+4qqp6rMMebJIyQpaAw4+IsuceNFnHtX82pcC/kL2HAfDcalJqdQBxmGkZkZtOuZsDuOnfUk8ofSM+tXvB6WQMOYE7DTvEmzbYZZTUche6pMNrYixy1DxPsfRO7A+PjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feYI/oRM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feYI/oRM"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b8d989e8so467640785a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715789574; x=1716394374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHe5Ac02Z+ezAadv0j/nYeTMV0ARsiPZjb374QiVn3Y=;
        b=feYI/oRMXd9JBGHAQVSacK/zZphePbu7oEuH6k8ipvwh/uPT84AVDWmfSAP0nxJI3L
         xXFW2sG/k0i5zO9x8Y6ojGyjvJPvLgKXxROaQNd1HIyXMhGsSgLHd+eNoui9nHq9GOw8
         r/a4gx9Ab2741umuVPRCHwiq86bQ2wf2fT+DGJiLNQeaJI0vWWU/3bnLs843CbU20FAf
         bd/aB28+RxHzygTqA4JeFhMcl+hJWzTeTvsJEZ/8k/uwKGc8/QkRW9tqVvUcE6jZj1jg
         mcf98KW5x8UQKv51YDuf9lU8c0IfydHQluEo0x/ugQq8DH3UrhstJXFnY7KI84CPC5yi
         1Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715789574; x=1716394374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHe5Ac02Z+ezAadv0j/nYeTMV0ARsiPZjb374QiVn3Y=;
        b=hxDFWrV6AA+09gd5+zQ8TGpHiAxn8G9mDbSSH1rhK72CtLNufT4ssfaSoXT768lvbq
         HqUPSkwnaMflsLaVhUvWh1+Z1Af3siJo/hHfU+JNdqbybnj2hWoBU5shzXTYMzrhDZnV
         YREDTlmjJYM07QYqwIbESuqNykPOGg7yUj8krKpLvvAR4fuH0e9s3aO1q3/UyLjxDzQo
         wVkMtJdgX3WlLnET7OEdEMdR+1sz6AdqeTdoqfl/n08GnHazWmb3VIvH6E1DY0tvsBo6
         lqxUofb14pOl0DsZB0tmxdBekYWccKSfvsEpBPKuL/eqrv5NVigUMPAq/9iDGqVit//X
         0Wsw==
X-Gm-Message-State: AOJu0YyBek6ptlz4bt7nadkIPItB30F73L9nESckRChpDSLg/ZW4L8vV
	3d9ADlFwOizfBGo+V2AfFisN7E2fb8t80bzdbbPHqXxQnGMEE3ApWJAatQ==
X-Google-Smtp-Source: AGHT+IGmJd4akbQpF0cEPDfSHHrmBU0AoGCUi1nWpRNlblRMnSTok3KSCK8spXRq26li29yt66MZbQ==
X-Received: by 2002:a05:620a:1a8c:b0:792:f467:6d40 with SMTP id af79cd13be357-792f4676daemr664730885a.17.1715789573847;
        Wed, 15 May 2024 09:12:53 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df7bf7beb9sm1819877e0c.20.2024.05.15.09.12.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:12:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/ad: Add bt_ad_length
Date: Wed, 15 May 2024 12:12:49 -0400
Message-ID: <20240515161250.1714375-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_ad_length which can be used to return the current size of
the bt_ad data.
---
 src/shared/ad.c | 11 ++++++++---
 src/shared/ad.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index f3fb428e25c6..d08ce7af9b85 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -520,9 +520,14 @@ static size_t data_length(struct queue *queue)
 	return length;
 }
 
-static size_t calculate_length(struct bt_ad *ad)
+size_t bt_ad_length(struct bt_ad *ad)
 {
-	size_t length = 0;
+	size_t length;
+
+	if (!ad)
+		return 0;
+
+	length = 0;
 
 	length += uuid_list_length(ad->service_uuids);
 
@@ -698,7 +703,7 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 	if (!ad)
 		return NULL;
 
-	*length = calculate_length(ad);
+	*length = bt_ad_length(ad);
 
 	if (*length > ad->max_len)
 		return NULL;
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 11900706f9ed..90cc82de9d63 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -108,6 +108,8 @@ struct bt_ad *bt_ad_ref(struct bt_ad *ad);
 
 void bt_ad_unref(struct bt_ad *ad);
 
+size_t bt_ad_length(struct bt_ad *ad);
+
 uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length);
 
 bool bt_ad_is_empty(struct bt_ad *ad);
-- 
2.45.0


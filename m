Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450711ABEA5
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233310; cv=none; b=gLzljUAdKVkMHsf8TkDwH1YJIVX55bwq7+7/fKvEIGkn0S+lYs6jYpAlLG8j0xCodmjFC3Xg9inOgyU0bDDN8K+7AzYivCzEh6jUt8BxxAhs+efYNRLqqJqQrB8SCr+R0LJLbv6Fjr3hpyqodT/F7cLqgKUIYiRN0E2isnAfZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233310; c=relaxed/simple;
	bh=b3gz1ICEj2WDlmBHFYa8jNMwsMYG+oat2NahhzwjwhY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FA34puvmX6zHrUOyHkRPlI9To0h9bhJ+zfEVNKkEnyUve+AaFrwjMuxvFr7/cT8Ap2UOtB8l2IjznUgjq4QZJH5WySsJCBiMNQs5cZTz/e298RWuqlzpTyO5qHnhvD8Bqaz0t+v7qFtA1m/RtJf/M5otMLeLd9adFCXypwOq7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3wHh3z3; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3wHh3z3"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5242f137a1eso1808302e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233307; x=1742838107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDQtr1XPipaV9zLTD8EFfnJ+RUFZSo42IHpceNO5PO4=;
        b=j3wHh3z3MYFHanxEtC/WBUf91SXOFLGKX0Gi1qQXkUwCcOf7Sz3CXZNAvSvC+Nsp98
         hll/t/VbFCCD9335B8SldUIHmV2VLMginrlAj2g/AK56BRGbvN6qSqaTbxcUv5LbC9L9
         chQW7KMV37852NsAxfdh+zuhWRzfNAj2evX5AquzCFt0WQ86PwTHxmY05KdSCy3YO6ou
         YmPiU8utzfptqHwS8RefJbzHfsWB09BtemB2BH2tDWT5hsPpXXvdK/KuzzTKEtL8tTr2
         wFTt0yq44cF4bUxLjxir/gzfzKT+51raN+/x/mo+VLsOjVr1sQBmXfKIDXYcB30wtF/Z
         e+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233307; x=1742838107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDQtr1XPipaV9zLTD8EFfnJ+RUFZSo42IHpceNO5PO4=;
        b=LALJMb3FMsVqpLY2WQa9B3DpofIlRCgpQJh6olAMKn5CAMh5tDnJsfCLcfn1NZxwWO
         dlmDJMWO0aD+WVPgR0K29BwKWfdphQP68ocb1aA9mLctl/vloCy+3TXAeKUw1GW6tTYR
         qE/b7LHPyxsljcytZ76IxYr0UvmaQemKSkKmATxRs7j0lskPs+DXMbSVuTm1TmdEJXhN
         hj6ixWTd4VkfC0KXdNUrlGuVTUtyEOswkr1vZryQxyyP+BeNYdql0xHLy4ZyAWQ9EBsr
         ACko7Ht/hUnQrXeHBuDytmOnr6QKcjE53MSTsRAHTpfyG2lndzBaOB2MBFJtzJVZxi+w
         hwzw==
X-Gm-Message-State: AOJu0YywyEnVKJ4cqFLfrSdMT0QMx4Ga/99UTYJFUI4e7oXrzd5vPNrk
	321gDGxu+aiHmUP211ALFzuTMc3Cs65ViTb6hfm8UQHKbX44Ab3iTooiZOclOhc=
X-Gm-Gg: ASbGncvj3ghW39fNDFhoZzRfQoD9bgPVAwATwf7kFEfmI+RHKwSpGmRJyKj3+hARqcy
	dWpatZTi7Qq+wweZDoKzMn3Xh9cRoU4EGpECh62actOrWHi4xy/K3cB2GR7wpgoVmjbvm5LyuEt
	OYCFiMuYrI7bMiY/kBd8nyFmiymrpm5gk7Hi3WgPHn4SP7d2QScl+21K0DWwFW/0H2audQ01uiK
	ikT08g0YbN+fBMbIw4Qvbfn9manastvmCXoAo3y/1RiZ7ut6SriRMu253v3eXLlF5fkQkyimS5D
	/Fr7bPsjOTR8fdtRGHff/5CghYGWPlOX/rv1NORcKhNV2jia41jlz+ZCK6mBFn8tlcsguAsv3qX
	R3IYCSTaloXLPqBrgs2imOa8+
X-Google-Smtp-Source: AGHT+IHx68M8Bux21cHocTrbFg6lGj6Xn/fGvcZ83slXQgyyTz/zNCb7XxsjDvDh+VLOm6+RH/SVTA==
X-Received: by 2002:a05:6122:510:b0:520:60c2:3fd with SMTP id 71dfb90a1353d-524498a275dmr9133649e0c.3.1742233307186;
        Mon, 17 Mar 2025 10:41:47 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a581473sm1702127e0c.3.2025.03.17.10.41.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:41:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix missing options not using most recent value
Date: Mon, 17 Mar 2025 13:41:43 -0400
Message-ID: <20250317174143.530997-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

According to the core specification the most recent value, not its
default, must be used in case it is missing on L2CAP_CONFIGURATION_REQ:

 'Any missing configuration parameters are assumed to have their most
 recently explicitly or implicitly accepted values.'

Fixes: c1360a1cf351 ("Bluetooth: use bit operation on conf_state")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7b4adab353cf..7719f263f5c4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3385,6 +3385,20 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 
 	BT_DBG("chan %p", chan);
 
+	/* 4.4. L2CAP_CONFIGURATION_REQ (code 0x04):
+	 * ...
+	 * Any missing configuration parameters are assumed to have their most
+	 * recently explicitly or implicitly accepted values.
+	 */
+
+	/* If MTU has been previously set, use it instead of default. */
+	if (test_bit(CONF_MTU_DONE, &chan->conf_state))
+		mtu = chan->omtu;
+
+	/* If Mode has been previously set, use it instead of default. */
+	if (test_bit(CONF_MODE_DONE, &chan->conf_state))
+		rfc.mode = chan->mode;
+
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
 		if (len < 0)
-- 
2.48.1


Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A5212FB3
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378438; cv=none; b=tMgeiKGaqMqCVH3Qh4wP2IS6TaDe6Edgck+g+QaJnwGnEgQqtqlIt+5986FSzH401gbyBPC3KyQE2fLPAJjWYJMQU94x38yUD1hC/+ZboMA6BGaBzp1sRR04vh4oGghJ6KFCxHiBsDIpxIbODhb0ayTbv54WgyvsW7y/ebH85d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378438; c=relaxed/simple;
	bh=fIvihShcE39cxMOgvzvAE4sHjptoKE7mi4lhmy0B4f0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rcx5sfzCWr5S1lsPWVh3KgghtPi/4SMZA0cFkQ1QP5v2SgI2ZuIceyTRkh5xn38kvCB50PfHp6sUMT7uZ/6gY6vfpmr/Eqylurv7PIZi6ak0f96RMRh0WSe1Sb+c79pYDQCQLh/6h4cEiDFMdzdpXrdwDhQck/ImVk6eD25ezsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MjV59ihk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjV59ihk"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de4a8b4f86so8553148a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739378434; x=1739983234; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypsXxYmlUDNAgS7vll0CP7szhdB/OHfZFzs1nsbbuTk=;
        b=MjV59ihkdzLi+A18alBCA9M/pl8qcWykYSoTS/yohdfWRFby4TGv7imNQVrw/S6Rl+
         DwMfxZKoJOU7ZHiise1pEN8+nNXH1iv8i4IUuiRGBJfjSnE2Tz3I0mUIsQEryR2fIPek
         DMAoN+Jfywkb///gIf6AzMhkRg/EoS/+FZpD8V8JE/iCqvVP82q5CXZ7xybyvmdkZm52
         KDVtR7dD95CW6mFjeUV6IBLPvdaaDHbIWgY6t4rbbPdU/Ox4GipKs0GwrCq7d43s/DVU
         RHGk+DZFagmT5ACeud3MSOQF8PTo5TWSArVCSJL0u4XSxOvRCzke0Nw52HAL5SLodmpr
         gC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378434; x=1739983234;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypsXxYmlUDNAgS7vll0CP7szhdB/OHfZFzs1nsbbuTk=;
        b=jJstwDjDBNlz4zU3A6XuImfBzvUTb5dKuvXLfC26JKsclFcGypfgyYjhx3NSqtpgGL
         AS2ewJSZafgizS6Tqs57Ngir2W0GGvAPhalDxD1ZiWFOl3DKHq/BYkz1avGsJxzt4PxW
         ca0TmDryX6LznU8nk3/Wev9wJytRYoxB/jGlm1R5v41Y89VB5z0E1PunYXE9dZhnVoTg
         IJ117QipixHc3rezh4rNFkfQgHl/dIUJPjrOl+TKagPl08q0LnO26RXpy/QlbHBc7L5U
         D7VOEd2DRxukLjAquwp27/EV1XxC6jYz9YMXkbz4syLlQN+HFWAM/LdkAMBauRe7XzQm
         ibgg==
X-Forwarded-Encrypted: i=1; AJvYcCXGSV7QQQ67VmI0XgNaBVndLDn1ZfDp4p4z6MIjD8rTexzR/7MQcM8pnvmdB26iB4yODCsKXbsJm+c2n3ccYUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOuTa12XPKhbHFUSQZMRCkiiKM+uflfDN+qkkC8jX3enZZUImx
	PDHi3gJj87jiUBbNT8mphIaqZJqzMYlirhR2BZjFG++Uu1K5j0jI/e8AaayYhu0=
X-Gm-Gg: ASbGncvp9IWfT2XT9psdd+zwihnXIbBXw8nQFdbu0SWYj9+H0fXB2WxZiaoWY2AksB0
	tm2zRlhNi39Xia7po1wi9ZyVUPleoOAgSK4SGFr0udD+7k62PGa+BmC21wgmLP4JIW47kUgmC5S
	KxGWcrW5DgXpFTsxEmsWrjHMSZTwzLPjsucUxKZqqlc0+lZyQK07uFdj7GeKGv04+MQFYNDAO9D
	7qNKUDhKlwbisldKYkVN2n9FXFp/930OVliYQbSVKKP/pj8QX81JtJQ0cCgxE829Xj1osw6fZht
	3Nz7JnWDK8DBY1nvdElZ
X-Google-Smtp-Source: AGHT+IEMax/OSHUJltNQhKyJlOjabg9OH0ij65Z9dSRbXrh3omUujr+vpFNHmyS95enTpRBK7kAIBg==
X-Received: by 2002:a05:6402:2688:b0:5dc:d913:f896 with SMTP id 4fb4d7f45d1cf-5deadd75028mr3104581a12.4.1739378434362;
        Wed, 12 Feb 2025 08:40:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de4cbdb434sm10348391a12.20.2025.02.12.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:40:34 -0800 (PST)
Date: Wed, 12 Feb 2025 19:40:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] Bluetooth: L2CAP: Fix NULL dereference in
 l2cap_recv_acldata()
Message-ID: <f9975604-6a65-4bcc-b532-15fcaa6da0e5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "conn" pointer is NULL so this "goto drop;" will lead to a NULL
dereference when we call mutex_unlock(&conn->lock). Free the skb and
return directly instead.

Fixes: dd6367916d2d ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6cdc1dc3a7f9..fec11e576f31 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7456,8 +7456,10 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 	hci_dev_unlock(hcon->hdev);
 
-	if (!conn)
-		goto drop;
+	if (!conn) {
+		kfree_skb(skb);
+		return;
+	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
 
-- 
2.47.2


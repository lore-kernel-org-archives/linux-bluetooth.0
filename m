Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453777;
	b=Xxzl6eEhIjkwrTuzFWeU7HtodaqkmxtANUM250mgfWT18+ccetbELTSuxdgYAY9nnpez
	 mCFwyWEKQCiKGJEQhCznm+/QX3g0AI/Nch6AF/7yCCPmUz+kudjujURuKkRTDFE0WTcZj
	 tPbK5ohhUD4h2qlUemznBaVI1ctKeChrz31+F3igJtrUsmx3ibA4cxh0jz+2B/MRGkPgQ
	 M9FKFJj+Et/IaBPozIJwcFCUY3ImL0dH+dbtrTDFX3dD0oNEqeN4HT7lEKz4COa3Gwl4O
	 uUwdEuEmgreoOWLQL+AzfPiPNZEN0dJcAf22otDb0b2EJqjVuGoHDTSCnf/PZFwa/Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oS526sacYKfHFr6kOJ4+2ywOZliNkhvCdoAu+3e/jvo=;
	b=5UxSIJ9oNCDzjN44WVwuFnob8nkwpq5mXXAmyPO1MnIvdABg4q9wH7s3fyUsl4O1YI1R
	 81k6OuxhTkwjrxO9D/sE87gq0/Nxj80ZB+pPm9RGXss+70UZXSvDWDEwW09WCFf/utKXR
	 jtbj6HXtFxNXdy7ZfGk53EWNkyV25jynHFfFxvEoHQrY+LdJ9CI4U9XXRtnreRAqdbKc1
	 Jq0ID6Rz6CYzlV1zKmYw7fdDbjzCeVMiHZ/rjeXNbq5IyxlfBCiM/MQrXWMknKspEY7c6
	 jiOC3FAZNO3J/oFhFIXr7P+scIFV4gggzMTAB062gKK02XxTV2NK/CxsIdOhLWHl2DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=azAABp01;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14B606A335
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 03:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E14B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=azAABp01
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso8064379eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794453776; x=1795058576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oS526sacYKfHFr6kOJ4+2ywOZliNkhvCdoAu+3e/jvo=;
        b=azAABp01CMdIU/7tliabhrzjM/bTtHMrGJvk5oHU48vHdNnB9EulehNmnmRXd5Dd1k
         P+hA3GQfffo7viFMwMdrpJF+6d8iASTq2t22jimBdbvQNA4d/Ig3VZVqMqIvy9afmbSv
         B5vPd3B37uLiaY5XJk81jgZWwIzOThTl536ZzJVTMTe7xl3zfoElOfR3eD98Q9QdOX6Y
         59yWKxym5RYLloOz0vkVddPOu8JATGnd8//2XIuyfnpvxUXjbGFgu8G6R7ZafELmT8Ya
         n0p9uuoxCo3ts6+l2sjC+2oa9qTrh/qOPgG/MjYip9TArCIHedg8OnuVroUCFrzCdJL5
         pGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453776; x=1795058576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oS526sacYKfHFr6kOJ4+2ywOZliNkhvCdoAu+3e/jvo=;
        b=SUxf6kBykqoO3cOjhOu6hNPPPOV2wFJ1ygHGCn1P7WaNS0Znw7XY5tutqOxTenih3U
         5/SNNaA5D/RtXHoZoocaZeSahDCCtpbpb8GsFUj75AmRYKU2jUzNg3+Okq4Gx2aB3AXn
         mFD9KfSHlzeKSPRwWaLlin+zjXKHoiQctrKxGbdd/R0B3eQT2W00XArvCKayweJP5dFc
         NHWEcvUo6Pb8WZu0K8dWJnOxp1APmgKQkB5WHS2Div6jUZSDuP8WcesfFWQrg8M3AnE0
         cz5O4c32m70Q0EgYenXgmSoWdwfLXiIObq9NaculiaJ4xo5DHvvb9j+yQE+rQttjcRAR
         QdCA==
X-Gm-Message-State: APuU4Z/wb3b3h5J6INGqurPOMw/W9t4qLGXqQWGHZE+O3hjEFTTtg1Dy
	lBzhPSjuz0qVBDni1HAc4+DJneCpmYkeFwgw/ILKgBk/YM6mKcUdZNRYUvRV66dHhsS3qzrVoL2
	jZwrxST4=
X-Gm-Gg: AYBFou3xxlsHo5NoD+xHNjixrhpXonM7zU28JNhTwWrNKslett233fff4S1w4tSS6RD
	5whlFx18pBaNv05WG//B2+XhHia/+cKACocrGY2j1d9K47CHcvN0OLraoSowFEAnB2m3WM9XefP
	8ziImE5y0lW5s+ZEI1/K8Ot7ObU00UYG6MV8GLLxmA4S3CQ0H7LAgllhz8eP5WwtnAHkJEn8GbZ
	Q3v61a2sGz4GKiJRPIUxF6YNC9+WcPWHd9enT5bN9qSaxA2yYbI1JG4uq5Y8e+2v2k23m9apEox
	Xoq3SVa9sBC4tajgzMR/c/Z+yaESX/Qx4zfiIyE3N25cvZL8I5nk6fnv/+DtJwGoWyjD6+Qdv6+
	j19UCSbpRjL8t4J95uSCCXSbYymjCSVDeuWSu5mAeiTQSkKrKjcSgFFziSdEU+8EIYr5ivdksgd
	/iKfltEPjCX/UP9Gd/ygt3RNhANFwvsmwHtOGKWQZxZZAVNmUIiVSKH5pMpubKxZhsU17FcKTYY
	R9kP9ResoFjzxPJ+MxHoLbbBlKz5lj7tHSVXSDUodOftieimrK8ISFK72XvkZDFF5/rmcHU36Vi
	cEQBz3RIs9INYRmHllaIqNOUQlqTCVBNZ1vNYAQEgFTfYk0Sp+ZIbJ+5h5oFCxV7A3fc6ZRzd3x
	2JamGg65gTr0gBObAwf24kVCXfl3FJz4xXnPqSlCOGT0qqqXToWXHODJx7XSJBPpVf7y9XsSV
X-Received: by 2002:a05:7301:77c6:b0:36f:d53:cf2f with SMTP id 5a478bee46e88-37682f94242mr4733200eec.1.1794453776138;
        Wed, 11 Nov 2026 19:22:56 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm21340765eec.5.2026.11.11.19.22.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 19:22:55 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [RFC PATCH BlueZ 2/4] adapter: Add btd_adapter_get_conn_info
Date: Wed, 11 Nov 2026 19:22:48 -0800
Message-ID: <20261112032250.37687-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112032250.37687-1-kevin@simpleble.org>
References: <20261112032250.37687-1-kevin@simpleble.org>
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

Add a function to send Get Connection Information for a connection, and
one to cancel a pending mgmt request.

Assisted-by: Claude:claude-opus-5.5
---
 src/adapter.c | 22 ++++++++++++++++++++++
 src/adapter.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 6588a6e2b..c4258fd76 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -11600,3 +11600,25 @@ unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
 				adapter->dev_id, sizeof(pkt.cp) + length,
 				&pkt, callback, user_data, destroy);
 }
+
+unsigned int btd_adapter_get_conn_info(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
+					btd_adapter_reply_event_t callback,
+					void *user_data)
+{
+	struct mgmt_cp_get_conn_info cp;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, bdaddr);
+	cp.addr.type = bdaddr_type;
+
+	return mgmt_send(adapter->mgmt, MGMT_OP_GET_CONN_INFO,
+				adapter->dev_id, sizeof(cp), &cp,
+				callback, user_data, NULL);
+}
+
+void btd_adapter_cancel_request(struct btd_adapter *adapter, unsigned int id)
+{
+	mgmt_cancel(adapter->mgmt, id);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 583168f4b..3c777afe1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -328,3 +328,10 @@ unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
 					void *user_data,
 					btd_adapter_destroy_func_t destroy,
 					uint8_t timeout);
+
+unsigned int btd_adapter_get_conn_info(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
+					btd_adapter_reply_event_t callback,
+					void *user_data);
+void btd_adapter_cancel_request(struct btd_adapter *adapter, unsigned int id);
-- 
2.54.0 (Apple Git-157)


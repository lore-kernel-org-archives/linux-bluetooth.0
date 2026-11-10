Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349167;
	b=LTAC8TamA88WZ20sOHTL6n3jbGgkDVXl10PLFoYialWCiG0AdomuyeuWCrvB3bhiMgco
	 HxLQGJIlGAtpURv+0TqCLBYvsQOkIbUjiKEIrMTsdJFU9Bu4dzHKns8B92V8C6zkLz/DG
	 uvr5XvVdv7sMGlJz3YlAXx7EHU+njMQwTBDT7/acJ4PXHKRnqVhRVdasOowxkjFteH0QK
	 TtuvCvxD2tgsKuJ2yDlrGZ7tjp3r000mf9e5StJcKcgJepscGqioPzhg615GcraEtZOe6
	 tTNYO6bUiYFzMSepH/erMFcr9vMF+P1XQRBgzysjO05s15Pz37Ae7VwlisU8w04iDvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
	b=QpCU/hJKxo6DaOVGUo8JH6ZtuR1dkGuyK11L6kHz5ftr2f9LKhpy5FsM0/xiZQlFPO4N
	 k+eBONFIavKtKq2HqweQVdpEpJe+63HVJHzzsK/vDzXUvmWjTY/xK/xhdESASey4PmZwB
	 73arKlp9Yn3Fi6qzPL+eHBxvwyZmzn2oBOWoAiIErHmTcCEjnjJTsppKQ9dQ1u0/iooNX
	 aX1l6e84sbVW3B82JLqWVOPVGDduY1Xc00yu1FTmzf8XhFnBXSHHiv/Bx6sUL1mfA0v31
	 t4FYjpXclXOODPzkTXaDzqg/sQvtxD7XkIM8AU41m0fXQX2qccXSSbxh/46e6VQOCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dLMIXuCN;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B1606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856B1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dLMIXuCN
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2db1b9bf2so847986137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349166; x=1794953966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=dLMIXuCNfBqlQiIQZ16bUef8D1+aeRyOcyvHc6+mPLiWIUzkL+361QtIfscI1EJpe1
         1eoGejwpNXDsnxpihdqx8c2R3bxAn+LEktJPcUwW9YCY+vyssZWVbd7s/5bfTPNi1daO
         BNHd+yHBgqf899gJtB7N6tyX8WCcsgLoAlCeWVQC1UhugPq1v/r9SDqiiknL963qtaty
         EMXXICc/HM/d39s3NMjgDnAFAjEVYcDPX4etQLe6gAFb79Q2ZqC1lKy3q68FWDbkxcbv
         m7dQdzTPQw7uT5R3pK7EAkOlYuY/t5T4N54mvES6FZI1/u914oUGb3DxaS3NBudsU+Mu
         4D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349166; x=1794953966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=MOhpBvi9lBRDEX5l3s8PyMVtHwcFejMpopFStgSK1l18hbeG41hhWzirXXhLKn5/9y
         9HgGSoOuJpHm5vOrK2eApGSRSnw0rXx/cr6yq7cdtIfx5KniK6yDw/H3aNEQ/mfluKw5
         OukzOkEcc0sPfBXfrBSUBpPbYdAyBKdDYvK7bm0hVjf9vuVHCerOlJlryuuqSY+M/ENB
         oJuX6C+grRO4ZHL2mxeBKqcHKaTQvUu+U7Oa+sREGbDMzgP04ZIMP+kJZ34l3NrRdHlV
         ohhcDP7y+z5sceAl2hdB5jzN//8tM85pSTFh/wdg/cu200iej2zBTRormZCIjK6OkELB
         lViw==
X-Gm-Message-State: APuU4Z/rf2M47Qb+IxOXFUlMRmmKgqvEBjyoybwv9fWdlXzst7szfm7c
	7MbDuyfQXWv4788rQlgAgCksBFeG4FT/vIbLjId7caBdb/TdeyFjpCVkgH9CKg==
X-Gm-Gg: AYBFou2RpK067QfUQKlm4LITwDTKAmiZBxbvDXq5yc9UqfpnrwsS1NL96y6OCOQ08Gw
	R0icsrJN+9sOJQWesutvbRY/GYhZttuVBgfoQhgwbalKYl6kQUqkaXGKWQJDP7xNNQhi+JslSj0
	Vcn2UXgMU/GkuPLcuc9EEr9oTAnS2sVDxDIDryFEzGsVtTL1hxskACujf7wyV1AwbXNeCpvrzv0
	/SD2HHy77pMdd1YGSPhXabLcRFw286Yb0qs8s7uKlEIzyEVsUl9sXbfZU8RTR9yVeWFYfkzVFWI
	3JloZN/RYXd4dKPK7Mr1gm75z8y1Y1f2tEras/5YDvUE8aWbejP+TQW/Kiz+jPJUrGLl6bpVvZ3
	pcEmO+HGYMrilsguQYaemt5xcLmJc6TOfcaVhZbATS2SbefeEGZzZXewc9AmslhovXQdsY8nhd2
	gayKg4rsXaehDU6AcJOGApZX5mCUPAqFevwpkJ7rfjEnazv55AEPPml3uFQM9A4oNetmp6SldFP
	JX7qJSU0XjhzP7nAdOk+oG3JINPAIZLHUlNaHk0jXPmq4GNA7s9u6gERO4wZ6harcamnAkoa87m
	97yxWYsjpmJIQFCP9NRvS2+pPgfbfPPsEWQyYKTgGh6QkILPu8e+Er4QjcMZdKdHZQdGIzFBz/9
	y0PyQfJ+eCRqv3YRE89hAC6nPVSdeYLxBVP2ndcHWxDbpKQ67auTl847m9jjkvHdgLqXlLzxS1k
	tNBFM=
X-Received: by 2002:a05:6102:54a1:b0:7d0:6db8:dc43 with SMTP id ada2fe7eead31-7d506157ee1mr115936137.24.1794349166371;
        Tue, 10 Nov 2026 14:19:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/5] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
Date: Tue, 10 Nov 2026 17:19:04 -0500
Message-ID: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794348982.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794348982.git.luiz.von.dentz@intel.com>
References: <cover.1794348982.git.luiz.von.dentz@intel.com>
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

Allow iterating over the streams of a session and getting the remote
PAC of a stream, so streams can be found by their remote endpoint.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 31 +++++++++++++++++++++++++++++++
 src/shared/bap.h |  8 ++++++++
 2 files changed, 39 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8cb7fb40f16c..e45d12144acb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4740,6 +4740,14 @@ bool bt_bap_stream_is_client(struct bt_bap_stream *stream)
 	return stream->client;
 }
 
+struct bt_bap_pac *bt_bap_stream_get_rpac(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	return stream->rpac;
+}
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 {
 	if (!stream)
@@ -7020,6 +7028,29 @@ struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
 	return stream->bap;
 }
 
+struct stream_foreach_data {
+	bt_bap_stream_foreach_t func;
+	void *user_data;
+};
+
+static void stream_foreach(void *data, void *user_data)
+{
+	struct stream_foreach_data *d = user_data;
+
+	d->func(data, d->user_data);
+}
+
+void bt_bap_foreach_stream(struct bt_bap *bap, bt_bap_stream_foreach_t func,
+							void *user_data)
+{
+	struct stream_foreach_data d = { func, user_data };
+
+	if (!bap || !func)
+		return;
+
+	queue_foreach(bap->streams, stream_foreach, &d);
+}
+
 uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 242bfbb39b30..00b74de0f272 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -124,6 +124,8 @@ uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
 bool bt_bap_stream_is_client(struct bt_bap_stream *stream);
 
+struct bt_bap_pac *bt_bap_stream_get_rpac(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -172,6 +174,12 @@ const char *bt_bap_stream_statestr(uint8_t state);
 void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 			bt_bap_pac_foreach_t func, void *user_data);
 
+typedef void (*bt_bap_stream_foreach_t)(struct bt_bap_stream *stream,
+							void *user_data);
+
+void bt_bap_foreach_stream(struct bt_bap *bap, bt_bap_stream_foreach_t func,
+							void *user_data);
+
 int bt_bap_pac_get_vendor_codec(struct bt_bap_pac *pac, uint8_t *id,
 				uint16_t *cid, uint16_t *vid,
 				struct iovec **data, struct iovec **metadata);
-- 
2.56.0


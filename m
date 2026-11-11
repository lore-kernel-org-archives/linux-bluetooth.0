Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414347;
	b=KuvNP+TsiYjRCKxFAuc/71RfUy8S+oqln86ewNMTHamvieAEpXZYeuMKNi34bSpj9HwA
	 Ahfrl95KYGs5Hsyu9Olfj/oK6bFMfnfNsnxYTT5smFrNAnm6ThVIKVYm4+hl1MgI2jKV6
	 SHxa3jLeMtbpoGvkQklqXa06+1acAD8YMVdnXQivME5Gr37mZ62TKfY7bOuQAD568sciX
	 LnUm8W/lZEmzPfS7OP0JIdCWLeRwOX9QqmRtQ/N7x3Nt5h+6MBpvszlqhcbfEWgTIExhE
	 DIAbFFcBUO2OusNQX9DYGTS8jaHyoK2G2IT8bmsSNJmhyuJxceN/kORDt4jBV6HI1QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b7avWbK+BwAJ1yCz/AaQUgybWIzyGmwbgkDAcJk7EB4=;
	b=TI9NfQ9dc4A/0zUxFuDrAduQ8IuNtrc58VGZp9AVdXr8S3PSYfvGRG5NeeW8JOH5+KvM
	 dZyJr/tCekiTRPiFZcgED6pX0lIx3zIze6lXxqjRLybcgb+f0IBrz3ZghhOr9GtXAsgOU
	 NxfKTWuxWe8qWX/RtlGyGYK4SsvWYcyT8TA6mFZjQfNJGJszQ3bJ0Sj0EgChb0uJce6cr
	 sAsxSKdwoCYZQtNVPLU0Y2cUz996NzbhUaZQ4MmJlbJH78SCPTx40zmm8xLnAWzEj/Vmb
	 7CgK1jeDnqPbdAY7eC+Gdc/xZCIPfpdvAI14D6GsPkM4dw8n3pJu424mUWeGwhuI2Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHugQPXO;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E99606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E99606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHugQPXO
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so900287241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414346; x=1795019146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b7avWbK+BwAJ1yCz/AaQUgybWIzyGmwbgkDAcJk7EB4=;
        b=JHugQPXO2ryGslTEXKVtmNugc8UaWfeaV2DQghV6OA/OGaveQR9RcIv7/NWtylSL5f
         sx6PlVvVTiAjLZ21dGkJUBXqiPvTyhD5yg9y7mj8dMYa7vxTqewip4HkSt18S59B+Z0m
         HSMiM75SQDbDJkEkkSQbxk+OaoBH6WtWq2qLAvOHur01SRwfLXXclIwE8pDVsa/PsedY
         4/ERiU5WAROKxqs0pTFlKz4nEPfrEiszZzNT0tahuNYlFw/OsSPG2igyeWCAnCkn5hmY
         tFdZTu9jiShmCQw7Al5ecO9in5kZHT5Y2x1TdcObExuucQ+m19B/WfxU6ck85KkWc+zE
         fPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414346; x=1795019146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=b7avWbK+BwAJ1yCz/AaQUgybWIzyGmwbgkDAcJk7EB4=;
        b=0T2PrO+i/37EOckyPNxlqmP5Cp5tD/H+hJfNAPT51f9WgvYmBHgqzS9CKmstKEUOMC
         QGIFzF3Cyp1YVmig653MwnKNqALdXxscL+2+6PGb0dW2iU1S7raGCNfNuoXU7LOJBsrN
         EPe0YKiewKTnNLpGyv/4UAoAr/onM1gswCC0QWJgXxQFHSQrzF3n9JugG1cAABnd6dpS
         6t62rhH5V9jQCb2146ckcSyD40L+7kwdJ2lHE3h88Aq+EFRdK/Ez8lfsCprCcFso+pjQ
         aLkPLnTjg+l64a0iGDMWLmTt4utKUnEz4Qj0tqF884UJj6gcnep23HONN2KO9XxshDel
         thAQ==
X-Gm-Message-State: APuU4Z/yvQMd0AFidxPni20ruNgENY3yU3h/hpmxOENSK6FVQ93U/inc
	tih2Tbz/BkCcPqbuYZBxgbefLVdY1Xq58KidkLBDEnS/8dHK9Nij6fGSqAvpcg==
X-Gm-Gg: AYBFou1KzHe5prqK5bRRUSKRD2ybLiGu4Z0Ofs5RimgKve4BssTnHLjMehglwI9OucJ
	owWP125Bto3R3oluv0cKa413fGH6Eg7PAoQYe7dtkv7d5LK6Q7JwntOdS9L3OXGGLXWVBacduNK
	QoEU1kvP+nqPEVlUlRBRNaZnVSx/ltv+J9psxTSvQqjYwOceaeh990QPZpv0dkK2CONPEXWps+L
	A/izZ5pi6s0btlfdiju45J+NPuBECg7Nn3LZbcHwWk4oBSPBhI1B5MB9sxM+pT52DFxy4NqFct0
	8UYo1bW/9aS1eY67xy/IO98398mQfnKFDIXomlt+0W+GpElta+lYdRl2yRbV8YyZbekuCQecc97
	9Bow25I8/GNdhEMubmAtJbvCXhpNVqEczPzfHYr15aMc4+BguwzbbilbnW51Ygp4Y2W6bvQrPc1
	bY54/58IkRC7ZUFUNOW1BQBY34EkhuJZGoLvim0Tbf3qcW5Wt9ztnQMNQPDW1eVq2zra1LjFH8Q
	9BmeWxkwzFPD9W5nWjJhAK6kaATCx8vjMWzDChcOYh7mOifrw+gfwKPm6EUUpuSxNCBirTJ9EXk
	CbQMdngv0E5uucKOHR06jlifcHkZvAl8ncG3te39B36OZOLsv2PlUsTPLUVXQw08UAiOhjGNw1g
	XWt4X/m5BfgFVzzE9ODEN7ilvlI4qIzZREMep2AZKtP9cWr5nuAd8gem/1sCi/J8SWZxur2WwCb
	/w9bw=
X-Received: by 2002:a05:6102:510d:b0:7d2:b21f:ce1d with SMTP id ada2fe7eead31-7d505804c37mr893496137.25.1794414345755;
        Wed, 11 Nov 2026 08:25:45 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/6] bap: Release cached ASEs on ClearConfiguration of an endpoint
Date: Wed, 11 Nov 2026 11:25:19 -0500
Message-ID: <4f5ebd77be3c3ae4ef9682a5bd4e685dc1f63b1b.1794413813.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794413813.git.luiz.von.dentz@intel.com>
References: <cover.1794413813.git.luiz.von.dentz@intel.com>
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

Once a stream is released, the server may cache the codec configuration
of its ASE, leaving it in Codec Configured state, while the setup of
the stream is freed. ClearConfiguration only closed the streams that
have a setup, so it could not release such an ASE anymore.

When ClearConfiguration is given the path of the endpoint, also release
its streams in Codec Configured state that have no setup, as a client
may release an ASE in that state (ASCS Table 3.2, BAP 5.6.6).

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 53 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a0e0ba60d817..55404668680c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1035,7 +1035,44 @@ static void ep_close_setup(void *data, void *user_data)
 		epdata->count++;
 }
 
-static void ep_close(struct bap_ep *ep, const char *transport_path,
+static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
+					struct bt_bap_stream *stream);
+
+struct cached_release_data {
+	struct bap_ep *ep;
+	struct ep_close_data *epdata;
+};
+
+static void ep_release_cached_cb(struct bt_bap_stream *stream, uint8_t code,
+					uint8_t reason, void *user_data)
+{
+	struct ep_close_data *epdata = user_data;
+
+	ep_close_setup_cb(NULL, epdata);
+}
+
+static void ep_release_cached(struct bt_bap_stream *stream, void *user_data)
+{
+	struct cached_release_data *data = user_data;
+	struct bap_ep *ep = data->ep;
+
+	/* The server may have cached the codec configuration of a released
+	 * ASE, which has no setup anymore, so release it again.
+	 */
+	if (bt_bap_stream_get_rpac(stream) != ep->rpac ||
+			bt_bap_stream_get_state(stream) !=
+					BT_BAP_STREAM_STATE_CONFIG ||
+			bap_find_setup_by_stream(ep->data, stream))
+		return;
+
+	DBG("stream %p", stream);
+
+	data->epdata->remaining++;
+	if (!bt_bap_stream_release(stream, ep_release_cached_cb, data->epdata))
+		data->epdata->remaining--;
+}
+
+static void ep_close(struct bap_ep *ep, const char *transport_path, bool cached,
 			void (*cb)(int count, void *user_data), void *user_data)
 {
 	struct ep_close_data *epdata;
@@ -1051,6 +1088,15 @@ static void ep_close(struct bap_ep *ep, const char *transport_path,
 	if (ep)
 		queue_foreach(ep->setups, ep_close_setup, epdata);
 
+	/* The cached streams have to be released before replying, as an ASE
+	 * still being released can't be configured again.
+	 */
+	if (cached && ep && ep->rpac) {
+		struct cached_release_data data = { ep, epdata };
+
+		bt_bap_foreach_stream(ep->data->bap, ep_release_cached, &data);
+	}
+
 	epdata->path = NULL;
 	ep_close_setup_cb(NULL, epdata);
 }
@@ -1338,7 +1384,8 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 	cbdata->all = (path == NULL);
 
 	DBG("%p %s %s", cbdata, ep->path, path ? path : "NULL");
-	ep_close(ep, path, clear_configuration_cb, cbdata);
+
+	ep_close(ep, path, !path, clear_configuration_cb, cbdata);
 	return NULL;
 }
 
@@ -1424,7 +1471,7 @@ static void ep_close_if_reconfigure(void *obj, void *user_data)
 
 	if (ep->reconfigure) {
 		data->remaining++;
-		ep_close(ep, NULL, reconfigure_close_cb, data);
+		ep_close(ep, NULL, false, reconfigure_close_cb, data);
 	}
 }
 
-- 
2.56.0


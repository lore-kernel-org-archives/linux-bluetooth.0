Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643183;
	b=DSVLjTVNnudIYmyxHaMM50Kk4Xn5llMu7Vtk0qjY1eY3Gx7KGEgf1n8ESkExqw8NJrcN
	 dEONRWgd2g4qIhOJmDBOsxsU64UDQ68YOxz1e9KhlA/4b6kpMjbAJZSKTr/CfyZG6CeSY
	 MtYVIdvD07im6poQdWX84ZrHzCATMncmDVIYPlOdjas8RtXIcSv4ac+Kbvbjgpsu7o9y2
	 NOlBL7v+knyhLTKGR5UY8Fbh28vj8rGXWYv8rVFe2lkPfpODYO+87sf51W4u+7NWjnGnE
	 5ca0BvxUVqnuTyHrBxAprzeQJ3ThYi0B4FQFhSO0cH28CCAGcs2Qp6hbWcy0DuOVtgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E0IcfN1ut/RcVzoOjOl/M5N3ZCrmzDsSFPzaDDBuuKU=;
	b=z907xBcCa+qiVaHB85lKv+oxxVXfF5eu0ed+mhunh8IazCKq2wmeTVu0WUBLPuv6A4jN
	 p6ZPgFc77nWRs2R23QHi2Vny08CaFzxBCQGqYhvBRc4XZ4MadrpLXURDkwbEkEteC5M5O
	 3xYAzrTO4mKVHv6noWTZePyOGmaKlOVdUl/yU9rfegDaB8uDpAyoJ9Ne1AAB7PX76tBNe
	 TzbYFncSCDhmohnk8+6gNcI4GvcmzCKrk2z+RI2r9IofaTeM1YoeYfuGhL4Af49nDkygV
	 d1gux7nKKBkCithsphIwLcLOZwsHMLfykk5/sRSKgR9qHDeSIWDnPhhyxzCy7HIgRMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui9TMuWd;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E2606A336
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 18:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92E2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui9TMuWd
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cbbb7b90efso766820137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643182; x=1794247982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E0IcfN1ut/RcVzoOjOl/M5N3ZCrmzDsSFPzaDDBuuKU=;
        b=Ui9TMuWdfKg9jmukP+HJfdDzuQIgdhv5KuAyS6SE2S+wiBTDV+AHEqPwnEPC/iUs+v
         7IF0YaK3DYOOR6ZVEtGCjX1NCS/G5eqDlNxm9OQgmquNnzdT8D3VxPULYRWDBnYv53aS
         +7QNAILHfkakxfMnyesJdNME1xWQnozqBuyNl304oDp3B0PkLjS08Fn7Qopjq9oHqwvR
         pF2baKuJoiyTCnx2f5R3fnf5cfENp8lM3b62JmduILZP5RiJvU03uszcQmKYbEocyGRK
         xrzZPjM9RaY2c7so+uMXdvhP2IcsfFK5Y25kLzifqrp4csrEKl3tCyJrSPK73Cg9Zzdx
         BRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643182; x=1794247982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=E0IcfN1ut/RcVzoOjOl/M5N3ZCrmzDsSFPzaDDBuuKU=;
        b=GS8ShSLRei7HrJRTX99an5ffnz/5QoIoO/kXLJiI1ehsg/1fvI8fU/OtZk1gtH3pD1
         yE62KMEkpFeKuvPvhPGqGxRp4KLr3KXoGo4Nz37fkpEuNpnemR/S2+bVo9+ZyEDIccCr
         Z7TcGuW/q0fTUe+RCMalgizNWJEJz4HHlP+tkw/3nbF5dGE5VyZtDunulYvGLrUh6CqR
         Uz48jG7mo5oIgPZZ2VzmFXozDNB/YrXJU03brn2gzJQXPNYZu27mroLpqMKmvn4oQjjV
         OGokTQeWrJQaNINHxke+bBgzt5Wd3e1G2/WuW9e7UNASeWiSZJPoin8V/tX04aj7z0Ty
         yAcQ==
X-Gm-Message-State: APuU4Z/AyI41omYHSrG4pBDeB3kkVKIlh0iOMmvJWfZNUaZ2gKD6fcri
	aFB4M+UUNa5Ve6G21rA7o5dpG/YWO80wa8LlvZ1Z77V5cBdKKHcGMKHvV58rzjpB
X-Gm-Gg: AYBFou13HhJ+JcyL7KUPmi4/HyZkdqR8pDCZJXdfUl7OZYXCeoRECFOjK6xs8aW2hn/
	4/LHCVxg3JtCrQ2d3Yc52rCnpcjyFxbQarU6SW3Acrv+rPI6xtd93DfbLtx6DFOM6DjCA1GVdzf
	kuoYJaYj7z2IZEU8ZyAZ7r0rKF8I1sDf0zk0SsrcJ5cfQe3g/+OxOdaF53Ic5n7na/4vFXmSsln
	4bGQLx4pUKvsPk9cBs74iQ/Vv4XEOEUolA3P8VyeK+EyzlfvU0iSk5jyybo9yHC8sgwiMGyl1Ba
	dchiFh8l7JSGjOl+xKyXJk/ZVb33hvOu/KHy9YkKFOeDxx0Mu2EEEOOAjfeaVpD89spnQX6CAGC
	nZ/0PASRnLSF701o1N+wn6qrTxuU2XWpNv/6INS0DUvMWASghxc7428Xz7OV36MPCJJ5tIAfbzD
	6Q+mZvSjXa14nGl95F35hSlJu30m/jeuL/FAJl/r4wDwWHg8PigKyeJE9w6cB8/IBCSSlmwYtlq
	wlj3wWVDw2SFmKYOhzAugO5xdsG8ZCHmT36Jm9Buo9TLPd0wOuR1YfBxFVoxcYbBMS+OK6coeRq
	AHJYbK5kqkkPxwcfSHyR5p0uYAg7hE7DI/Sa8cnFhU/aSwWhkOa1d50no3GvaUOHeTnBB7mR1ft
	T46+2vH8VCaix18K1fCBDFtMwu78lLLNKCgamSRpls7rO/iYjLcupFGDb0E1Ff0smkLF2vnC8rw
	BSS+nC
X-Received: by 2002:a05:6102:d90:b0:7cc:21cd:9b46 with SMTP id ada2fe7eead31-7d07265f36cmr3576222137.33.1793643181760;
        Mon, 02 Nov 2026 10:13:01 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf220esm10300208e0c.7.2026.11.02.10.13.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:13:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/6] shared/bap: Add bt_bap_stream_is_client
Date: Mon,  2 Nov 2026 13:12:54 -0500
Message-ID: <20261102181256.2321329-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102181256.2321329-1-luiz.dentz@gmail.com>
References: <20261102181256.2321329-1-luiz.dentz@gmail.com>
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

Tell whether the stream is handled by the local client, which enables
its ASEs, or by the server, whose ASEs are enabled by the remote.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 8 ++++++++
 src/shared/bap.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 10cc81a51c3e..b1180b532b8d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4549,6 +4549,14 @@ struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac)
 	return pac->metadata;
 }
 
+bool bt_bap_stream_is_client(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return false;
+
+	return stream->client;
+}
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 5bdc5f8dbc34..242bfbb39b30 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -122,6 +122,8 @@ struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
+bool bt_bap_stream_is_client(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
-- 
2.56.0


Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679251CC15D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629270; cv=none; b=mKKC6Bi3vtK/fSOG+0jy3LL1sKOD9o8oTj5R/9c7n4qywu8gUl+yHdYXOmHy23zTd9TlbP3Xe50jXLxVzLzJfJerx9pdwMvyHPrVlXhcC/YlDmTkcyUdmmfClBEXh5vwZR2WHfGJtoTbrmzygBz2/5B3VMzI+TGleHzG7kVXyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629270; c=relaxed/simple;
	bh=9/iTX2jG97Dk7t/mgUJXBDBHW7LbDhsgJ/gzpLi1C0A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU3r0SnyVDJsZOgtdfStoZDza+jWCW8l0O20Z7dHwzr991gc48PbsyoxGhZea+34h9T/wNfyN7fNdZ560fOJZ3j409IMbd1NX9hAHO7l8WkfTypa3drezuBCdTxE7YFAIePpLzHn1/Ei0bUwh+0D0ymmWh5scZtGSxu9kBxWQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVFrckO6; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVFrckO6"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d3998923dso2062347e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729629267; x=1730234067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KG94hjXvosBZhhpCApfNd8l4CTGNZbXs+ebt8jHsEQ=;
        b=PVFrckO6sGgWGVkyMhHp3k6KEOUo7wVyrb+M+rvWx6KKO2XSdBIyEkFVJDREwklpWC
         dgXV96zns/2214SA+HpQRVSi3dHNgYT4ciIqrEhZCjE48gFQXR5CTM9yjDeLrAA38WLs
         KFdVj8NgXAupdcjGSJskhFie3+FAqCR6QFQE/McrJWUwGToKsk3/v5iwZ87VAFxMrdEy
         lJgqF55m4cCTl/cL9y+P8TVUrhQhO9eT+yYjYdYMJBSZUazVauwLSy31XFnWx3ETTtEL
         g8OEOzSeYd+QVITK1titWMtWiAKrtgCxWWlJNLJ9/Tyszzr5MMSGZhmFM9QFZxs6zV3V
         zSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629267; x=1730234067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KG94hjXvosBZhhpCApfNd8l4CTGNZbXs+ebt8jHsEQ=;
        b=O2NEb/uetJrdycMsrMtot0bC7TNGxcM8MpfeLPq2iq2U3YPszxgd0pehX2zCzOjAYI
         85QqRyBIx0jnvMSGHchXfvZtYwjOfBIEevqg18CurWPsKsWaBKkLioGT1+QiRRisUnbJ
         AIC667evePZjf/J17xo7gMvf9V2SU0lUo85JOKYKFThbvREKQ6ZFrjOpCyjYdpslSLNF
         QMOJpcB1ygmlGVSAaYIuyyU1Amc2lfoCl3/poXwbOo5y3Ze8YQJOJiOBg2dnfaI7dzUx
         u3RlPaD/UB2DShpY/AqW+xffiWQ3vhbknQ7UFiGRbPp0LHbBB15uc6dDT7UDwB8ansXw
         CXDg==
X-Gm-Message-State: AOJu0YyUjCF010pxqvgWsRWDSNlnNqdmyUqBkE6on3g4mgbYMsV2+3hA
	ahfgOzRC3VOkrlcNd0cfJ6BCgaZURnoq1pniCDmBnV8g2WogTCawRAHj4A==
X-Google-Smtp-Source: AGHT+IFmITv3TSNXyU+ohW4X5uV1ZrNUvZSeJ1Fcqyzxhucvk3hDhXLPe0qIqgy/aHsGseI6q6BGdg==
X-Received: by 2002:a05:6122:178f:b0:50d:bfd3:c834 with SMTP id 71dfb90a1353d-50fd020eb5fmr605557e0c.4.1729629267542;
        Tue, 22 Oct 2024 13:34:27 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19e0dc78sm834971e0c.2.2024.10.22.13.34.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:34:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: ISO: Fix UAF on iso_sock_timeout
Date: Tue, 22 Oct 2024 16:34:21 -0400
Message-ID: <20241022203421.2126673-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022203421.2126673-1-luiz.dentz@gmail.com>
References: <20241022203421.2126673-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

conn->sk maybe have been unlinked/freed while waiting for iso_conn_lock
so this checks if the conn->sk is still valid by checking if it part of
iso_sk_list.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index c9eefb43bf47..7a83e400ac77 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -93,6 +93,16 @@ static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
 #define ISO_CONN_TIMEOUT	(HZ * 40)
 #define ISO_DISCONN_TIMEOUT	(HZ * 2)
 
+static struct sock *iso_sock_hold(struct iso_conn *conn)
+{
+	if (!conn || !bt_sock_linked(&iso_sk_list, conn->sk))
+		return NULL;
+
+	sock_hold(conn->sk);
+
+	return conn->sk;
+}
+
 static void iso_sock_timeout(struct work_struct *work)
 {
 	struct iso_conn *conn = container_of(work, struct iso_conn,
@@ -100,9 +110,7 @@ static void iso_sock_timeout(struct work_struct *work)
 	struct sock *sk;
 
 	iso_conn_lock(conn);
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
 	if (!sk)
@@ -209,9 +217,7 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	iso_conn_lock(conn);
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
 	if (sk) {
-- 
2.47.0


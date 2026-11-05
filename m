Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917010;
	b=rcfblBS5ca/rYFYFrOxXa5DzBNFhcPbcV7S0pzmreLyfYfuGSxqkbeCF6p+Pl6bFdQvR
	 qOA6OBS4KOyBNFCezepLzx9KFJK7aAUPkE9Y6TCqqpb2g1cDeY8wfGatRzGLONsso3kC/
	 c0ONyreJBco5zJ6M+xaeU0Dh8ixi+rgvcFOcWsrCqgA/6S6nrXHDSdWKxKMPB5S6FXSzo
	 LD01oisDghF7OVsFC8gdQS5wI+LpaZJrcqYfBNHUiqZHogvfLySSjUKQ8TZltoBFolV7A
	 jbQaihnRGB8skrLYTyyQ/pLdyL+srbWJShNRkWa/94SQdI3zZUICnWSb9+XN8mNd81g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iY7ECxd32TnNv502uJ1rAotlskVRvjNW6gjJt+Iv7TI=;
	b=vkCK4/WH1btavKuIqDWtZ5WhVimYX+CN2XDfPt1pURjGOSDw2VvUjdSy0Hxok1eNMYLx
	 XV8l/i9lNu0IcbvjG6wBAcfgrAYCPVOs8qRQd0p04TsacmLd+UfMOYAeOtx2vm0XYH4ng
	 OYpn87GW4a+MbS/jNazKYFT9dr1rkrB+mvSNkm9EG7aT/9As0OAkKkFlyu3YruKNlhl+T
	 kS4/t27XhigVYHbF+ymd0X0FRH/kT2bXlruiiMA2K2JBALfk4y1eET/kw2FfRkKukAiUT
	 v4DrrsvQUum7/0ZdYaU6jQU+XYPlFFVGi1Np0KkeE/DoqRFtRcBM4xukJg6fYOu7/fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="X4UE7t7/";
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0DF606A328
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB0DF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X4UE7t7/
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-78fb1fb9508so926506137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917009; x=1794521809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iY7ECxd32TnNv502uJ1rAotlskVRvjNW6gjJt+Iv7TI=;
        b=X4UE7t7/fGu7YL53oSsQ2Xk5DGjTIlfRuaAPUeAoQsn/8PFAxZjW87b3djupiggqC8
         yiZJP5bq1v9U+vmvPu4Tsx7YMgJLthmGmx83AcyV+l/VsfwzKGdrszDZVueJGHuI3vg1
         qq4lhgC6c0RG/47fhCDFiWWY0BvAMZTCjwRjuZJGjZFZbRK362Y8c6ujqqx+aRHt99yQ
         GDYXL7g6EB7wYjxF+x/Bp56437GRbfoRa52NLDB4xlqhsp2XQCB5WaEgo9BJe0jWmePO
         G6zS/5NCa9TssO0g7XGnqMqDx80wtvtIbhHDK2OO2JUvCeQG+NAeykILvD0lwuTz/JWW
         Fa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917009; x=1794521809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iY7ECxd32TnNv502uJ1rAotlskVRvjNW6gjJt+Iv7TI=;
        b=f3KV7OsxE0ZE7GaSrxC9EU0nO73EVoDpgezeC1cp52Yb1lkjYpb2j+jLAihkjatUHi
         DJ/2XZEkIfyeZ5iTKw5g11fq9bi4kfUjAO7n5mw9c6qVVbF67Ek0Yedqs/hk52mrmOuR
         HxjJNYvu9LTyAUlISwZIBqjunLvg1pFlLa3dPiyHZRfWpdqpcAnFZF8I1ZEfi6eCKsYH
         TYtTgjqLb3TT+zuJ8vbPHq0Dl27vWuP8/CT+Fc7woIQ0RzLF5V92+IvyOMiOEvvKDJme
         7s9hCrW16UA8ydtUNc27UMIb09XlKwFZmxObkttUHIf4yO97T1k40PM+MZScPWb1Rt6e
         jweA==
X-Gm-Message-State: APuU4Z+Wr8yMw5BzzZVA36nBO9hg/z219E3OJ+Ldx9n2nDFvxdKj4nPE
	7nFJULW8aQR/4olKh0uYQhEfAnf9ed6tuW16qkOKs4t15eGJzt1UharmNP3y9A==
X-Gm-Gg: AYBFou0zkHlELegC+UFVZy63l77S2KakMGf2qO3Xk7PHPEXq+K8NOT/4R3fwyR6yJXS
	zT0L102DBeJguv1Kdw87fx/YJzNq4dHKdyqHxAwFeQF9rOqL+LJgVadqjbdL4IEWpU+ks/+4COg
	BRCaPxNawS8uSYmJQW8AMlW7k+Ixkuq4qGtX17QBsBv3yfiSBp3rs/hNZQfb+/gWNQPyZhdE12e
	EfFornXVnpoi5GRrDsfDXCrSyRnNdrtjL8s0a3497/rFc/Ld3pqLdHC+2y0rRWulIT55pYkfavv
	NkyEuprfN27QyRuYOc17n0+wSeTID2q3PyvN9wQAmCjtiVwDT1PxbDL6gqTvFT03qr6eiChdhz4
	7IWfQ+H73UCsmworBzyh9hA8dyDlZVrE6Glp1JHO0OpCIuFc62WP4L5dBnjFCY21o56lw1NLCQ4
	D3ebkvIvTg3TUNlZSE0re1AdOwd0I8BiEPYIO9LHsTvkpDD5ixSSC6MVkbsnvt7zrzy52ywKhaJ
	thtTek93W7f2DIIzlhdQdAb3RjU4Nfxbx5idJDtfGGiw+Mly7OuGhu1FQppgS1YkGhG78U3eejX
	5PRoiiBpN1+lSXyB7bNbp+ufzJEc4ARahEkXAY89KYDE0CuPzEUnIxVAXBvEJXH8xgo0QK8NI81
	/fyAWRfYLhLResCtldSa766hrnN8TPM8RVczdHaSLJf95Zoly8cFW5C1C/RTRhMRjhg5FSI/rnB
	uH75fsH93+zTisBW87O9qq0Gvp9Q==
X-Received: by 2002:a05:6102:508d:b0:7cc:905a:331a with SMTP id ada2fe7eead31-7d2a160da60mr490484137.14.1793917008564;
        Thu, 05 Nov 2026 14:16:48 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 7/8] shared/gatt-client: Check value lengths before reading them
Date: Thu,  5 Nov 2026 17:16:37 -0500
Message-ID: <20261105221638.2332398-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105221638.2332398-1-luiz.dentz@gmail.com>
References: <20261105221638.2332398-1-luiz.dentz@gmail.com>
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

Check the iterator result when reading the Database Hash and avoid
reading the Extended Properties value when the response is empty.

Fixes: 0f67d5e2f19f ("shared/gatt-client: Read database hash if available")
Fixes: 6b3f0f3ab935 ("gatt-client: Read extended props on service discovery")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6902903e7b02..ad3bacbb56af 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -887,7 +887,8 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 	if (!success)
 		goto done;
 
-	DBG(client, "Ext. prop value: 0x%04x", (uint16_t)value[0]);
+	DBG(client, "Ext. prop value: 0x%04x",
+				length ? (uint16_t)value[0] : 0);
 
 	desc_attr = queue_pop_head(op->ext_prop_desc);
 	if (!desc_attr)
@@ -1475,8 +1476,10 @@ static void db_hash_read_cb(bool success, uint8_t att_ecode,
 	if (!success)
 		goto discover;
 
-	bt_gatt_iter_init(&iter, result);
-	bt_gatt_iter_next_read_by_type(&iter, &handle, &len, &value);
+	if (!bt_gatt_iter_init(&iter, result) ||
+			!bt_gatt_iter_next_read_by_type(&iter, &handle,
+							&len, &value))
+		goto discover;
 
 	DBG(client, "DB Hash found: handle 0x%04x length 0x%04x",
 							handle, len);
-- 
2.56.0


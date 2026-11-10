Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346539;
	b=mU/unjqWEWd/1kJOsMB/vni7vv0dqa+GWQAZ/ZOfepjE9F5OOncniQfznbVo3WYm0r4P
	 4L3+HEVKRU4xuFkoxtPq0H6zX9xjHNO7wfbhRnZTvEE8ahVa9LVSNUGgReviNW38zVyrQ
	 i9VxP7XYKOJPr8ivFm75Xkx+7LultsRgc4OCKDZZgy4ITyUkEcDjRTPv9oCfVY3Wu7cF/
	 FSWesGO5OEN+ZZlvvBV9lc60gUVEKz5Tq+owz1PyKutyB/VJ/Q+koLceT0lu4EbRSrihB
	 2W4v54eTNpQl+jBnHeY90l6DqOvJrsn6N28gBwgnBJ13tpHpiGC3afUq/70Cb8z4Vmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fi/0KmJM++Tc5jekDTv90W89b0hRJ4ZV+gb4dSyaduc=;
	b=KEwDhkOGzj4rVh3XuzUhuGpSlH58FVCCB2K6RNx/P+qcdbUiSkcQkj6nRIL6wXzYExP5
	 ZEN1Abz3dOhO5mSk2nPuiZkh1KQ7K3mSmOE2FtfpEvDgMziz2HdxjOP7QJzH9fdUaInjC
	 SshqK/rR/RDDmuru9jkkZYccW+KIREpNDDHuFS4afQL7BwNYMRiqcJwwhoAJcT6mV191/
	 IwepKQi28nc1fXUdjKiQVpfPOHGxe0dLL828KNji1dFmdXaNm+F61NIhmktxFoK1O+WEG
	 hD4aIx4dxUUISwtbjGKkGn6FxM1rCmlyBtSVZolti10bsgWO0ShkaK8UR08v4dbIiBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNkX0fs3;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AC606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 21:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 167AC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNkX0fs3
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5edf97136aaso1309617e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346538; x=1794951338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fi/0KmJM++Tc5jekDTv90W89b0hRJ4ZV+gb4dSyaduc=;
        b=sNkX0fs3XziTxMgKofUT5XWVcizff+OPHz+jVwSo5x+jQQxn4uo1KsT6tKiChGgNO3
         ofxCXAqH2C5wnzBHnGTwqg8BAfva/gTZR9S+UZ4jiIz2wXAH0upHo75QrPeFmHVTAcql
         5iI+rH85XLeA11zyc934DcoO3WbnyqaMPZ9Xi/Nm+Qr7R2EfbexhPWXOJ/QSVV56oXQM
         fal+2kET3ZWgls0eVkRDpxEQr0kHl3UCSYvUVG2S2S1mfsuOcfeK/zmdP0a0pS9p683V
         lDQi28tb1XBjjn+VdGtIXAUJwHPsonZWWuqtEeJGzB0QMx2ZmWwFxKHaslL8b1Bq1BWb
         5t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346538; x=1794951338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fi/0KmJM++Tc5jekDTv90W89b0hRJ4ZV+gb4dSyaduc=;
        b=t8lUQoMIf/HclfOIdM0Puer8uexTRc8isNTyUnJq9ZhQ8qgUDHfZh29DQa4To4nEE5
         AejviZhRopvSDCmXLAHxOOBg+6VoZzDi8QghBbniF2889sshqVDu48grQYPNwOKKE48d
         QDKdO5T9iNaeLVw0AOuQusSDlikblt/nak/WoFhnH2OklpWfUmTCU6pp9TTP+VwhFcEI
         G4S8fBRh8FNdMzDLgwnAdGt8J9xBwog0gH0QI8Ex9ZS5YOUEd3BJthfm4Sjk0sjo9akc
         QBhvrHrdyhUdeqQjMqqgZWXb0Ykf74YbILuTiLs5UT0zmHijTBf/RR79kzalgg2iI3Tj
         zCcg==
X-Gm-Message-State: APuU4Z9A5lLYOdj6nNmEYfVTQ2mIfUpipjkbSSH4wT9uiZHDc4+LiLKq
	pzZnDo8Q1q3Iqjmnzl3hsqez9c7yDb9Qtkldm0G2PhZrOi2rwxygQSYpdFostA==
X-Gm-Gg: AYBFou3+Pp9ZpUUmQrkqBTm+kbwUBbqkHLJri5d37Nh9rFpxKeQBtVk1wdXYO+crSwz
	5qwGyjUAyhjVcnj8p1JSiFM4RuETloVP99/FP8MpiwcJ2X9Ubh+piTak/reaTXQY5YdSYzi7ZoJ
	myelQjsxh002vdaABa+nT1TibXXK13jzrvolunTS1ZhlmViolyZ1x9h6L9WeeV0sMG5AJqhhAxP
	5JKIusQz71S6RZxMfrgCOXQnJoAyth2EBI4xNGVNf+SYPcKPm7MFbRMpV2kZV0zFp3+p7bXS/F9
	Sme95dIKlqEnDqsLg2CmhYPLRvmjmHTTdZxlZ8fPUOgL3dwRQyZ0G3tewZbYawprJY7KUsUUwkl
	c8Jqo6s7Gxew/mvMy4ZHu5sQrPEDM1GkHxrI/ANZV3AfxEdK7n7hhwv7CzWQ4VEXV2fVYtWce0a
	yBKLCiQTQpORYAjhSORIlFULBMtG2ZcXayghohlb6DKrOMcgwjYCklthbb+3U/TjCsxh1HV07Ag
	arWaxI6wnONexjXXUM9tw5/X35ByrGK9VuYlVmlEadLJOIcdRqupulI8fQ2Ca6lwGwRFBvAIOlY
	7jm2XndlQZGnAc4rX50vuObJMpuy3zROiF44XGXKrjqmJQ1ymeHAbUwTCpzSTS4c++vLeqHgcpK
	izyOfGh6pbe9ykzjer2+w3na5uvt3ZZjfwqFHt1hHHqAd1e2ahzLjli5nqULDMfI98AjBj7X9Je
	p77Dw=
X-Received: by 2002:a05:6123:106:b0:5ea:df96:c394 with SMTP id 71dfb90a1353d-5ee1c3e68bemr78580e0c.5.1794346533029;
        Tue, 10 Nov 2026 13:35:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c614572sm2482189e0c.17.2026.11.10.13.35.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:35:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/5] shared/micp: Use util_iov_pull_mem instead of a local helper
Date: Tue, 10 Nov 2026 16:35:25 -0500
Message-ID: <20261110213525.2942339-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110213525.2942339-1-luiz.dentz@gmail.com>
References: <20261110213525.2942339-1-luiz.dentz@gmail.com>
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

Drop the local iov_pull_mem, which duplicates util_iov_pull_mem.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/micp.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/src/shared/micp.c b/src/shared/micp.c
index 7df8f8346f55..ebc21eb3c8b0 100644
--- a/src/shared/micp.c
+++ b/src/shared/micp.c
@@ -79,19 +79,6 @@ struct bt_micp_notify {
 	void *user_data;
 };
 
-static void *iov_pull_mem(struct iovec *iov, size_t len)
-{
-	void *data = iov->iov_base;
-
-	if (iov->iov_len < len)
-		return NULL;
-
-	iov->iov_base += len;
-	iov->iov_len -= len;
-
-	return data;
-}
-
 static struct bt_micp_db *micp_get_mdb(struct bt_micp *micp)
 {
 	if (!micp)
@@ -397,9 +384,9 @@ static void mics_mute_write(struct gatt_db_attribute *attrib,
 		goto respond;
 	}
 
-	micp_op = iov_pull_mem(&iov, sizeof(*micp_op));
+	micp_op = util_iov_pull_mem(&iov, sizeof(*micp_op));
 	if (!micp_op) {
-		DBG(micp, "iov_pull_mem() returned NULL");
+		DBG(micp, "util_iov_pull_mem() returned NULL");
 		goto respond;
 	}
 
@@ -746,7 +733,7 @@ static void read_mute_state(struct bt_micp *micp, bool success,
 		return;
 	}
 
-	mute_state = iov_pull_mem(&iov, sizeof(uint8_t));
+	mute_state = util_iov_pull_mem(&iov, sizeof(uint8_t));
 	if (mute_state == NULL) {
 		DBG(micp, "Unable to get Mute state");
 		return;
-- 
2.56.0


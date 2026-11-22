Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348251;
	b=iftnTV4Y0i6eUoH3SDZTe1TNILISwZaw/vScGVXgLaJos2vMLMExHYcB2bfGzhjsoPHZ
	 de6hApB39+OtOJmZe8rysmZeA2HdDWtWTLjX0Hq7riX1mBrB528wRjUSEWDzbbmxGNeeI
	 5MoUCN8j31kxR84GMLmcA4FsTiej5hr0nW9jIwWseHVmvMqrcJHuazUUwPu5n2UajgdqU
	 8EA7AsAsLRMm6hIQNR34GbQNKSX0tXQQxY/wkLmWDDUpZHaJc0ZHCDvPwwfYDz8Tljwez
	 mGvgtbXObKKnfnJF2DkJSVgmZXKqry4RunDOPpt6z0bvj+PRuAtmnKVZon8ESK3G+QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
	b=2KWcOKM/cE1DosxWwd3QcyrQMT40HOJKslvl2GeHno4lEUJeBRTsA0ZiqhCUcmBI4BNi
	 zQKee6MvPh3VnB8SVVK+iKQMNhYIO1MPbX7lYjuUWw3FH5G32dzVACWITtDQwJO+BaMJC
	 W471OsUUQxjc9svk7lxUVmyQp5VRMFSJ4WwNvHOWhL2fFwxYxIJ2OG0Zp0npTl3nzGJHK
	 Lc+/bG/7aXI1NaydQ9HFvzLc1JB13jDWioFzRXB3VBtvJflaKMyypDWBcVq75dtl3IIwP
	 i06+o2oQFSbWBlJ96qsFu3p/WMjc+azHZhim8j5QZ0HGFeSsFxcTq7/HvKlgFCjy1vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=uXBhXBNY;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA7606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64AA7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=uXBhXBNY
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a32576da88so1356084f8f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 03:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795348250; x=1795953050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
        b=uXBhXBNY9Xn2ydWFyEGa3TBumTMuxRCXoFiTTRnvDrT8jaf7gt4y2/reeWqzgkS/0C
         HBOSmemNYjUih1+WM738x2N6K2/7M0+VHyhTWGZw2lcIrHrx/w8X7o2Ju2/wXfsrN1NZ
         JpYWVgWZuKaUjNW11odupvFI0XuAahBpla060=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348250; x=1795953050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
        b=sirVAe1TTyPDUkR/NqXnNgDMF2TwglvSR8h78N/wXG8hnGwfKKtFKVYZPpOt4/KCmE
         mIUzuiApESvI2p5Hdzzxm77OysyaADlfl/tJWcW0sBn6QZazzvBZ+dNTx3wfullp9mce
         3bP2yKtNegkwCP+VSv9G7flymkpij2IEpoYafEcZAOJfs23UYq2X34aIQzMZvypU/AWv
         HQ9f4/pROCmiH8l8yZwfyDB2MfW1G7G89f9IY9+2pDdDIoRSGkmtF0nQHmOmXN2phfI/
         qBMsJ3nS90v0NXWXVPl9DEV9hU5wN/6wTQ5baTt5Ut6N5A9cUwHfBkpk57Qk1EmT8MJE
         wdOQ==
X-Gm-Message-State: APuU4Z9Vk9Mm5yelXtXo7DvJ4sNLaocUXO4TWiDl+HjZ3/H9Dn7ErccX
	IlfqDuRX8aUDekY2yTUzNt+fYpsm/TsIKcdS5VrOIm1zBDN53BNG4W77FEbY9iAhevv4/nHuiFg
	1O6Qh
X-Gm-Gg: AZFdTZejj7R0orD5KB8knfdbUt76i0fyYYqZ7h+VoAooiocefhbHYzmGHPHGkjQjLej
	CSyM3Hko5B83jQMnam+4xAsx3DJbmy2pitiyIUOcDF0mUzlozoDN9IRQa7AcZdEcztHV1lG/+HY
	BbExoeiRDKH54Cd4YFO7yI1CGZgWFjFsVZ8gzaTeDWgoHCAg04lc8SW2plbiGUSF5BYzsWNu8ug
	6OtKlKh1YkbG5LcnApEvgFGWpFUu2d51im8zD1PQ+KUOenTHcTADeWSmFlLeJ50+teX6iw3FLRi
	B1kimj0pcyhZ1eT+PC1AOmviAp7HKX9/hGzYi16kGzm67IVBO+wAlfJR1rLatyHSVL0s3MzgQhh
	qkg3/AIUrT0Yh0Be6niDBL3UY3Y0aXily8BmXw1WfCYJnJ/0xGrqxE0/RUj9spsbRt2MLyGeh0G
	68aKklN+Ws/vq3S2yGH8H0zFFZb8EUi15RgnOjsw/2BIMaJLDdaQEaGoEQkVKHZWNEPRJOObvT6
	Xl1gc3/cbE4/7IWQ4oE3oid/c+X8L5ep5BnDAr6/ZaRGJHSIApNl2KVmxWBCDoaH49bWILBq4Bc
	l6drv/+zIg4QFnXhO26fy2s8VYe2oQWgn/jTq6lsho8cU7OHwg==
X-Received: by 2002:a05:6000:470b:b0:4a6:ac28:eb57 with SMTP id ffacd0b85a97d-4abb3678d7cmr17844025f8f.17.1795348249739;
        Sun, 22 Nov 2026 03:50:49 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c248b75sm16538513f8f.54.2026.11.22.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:50:49 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/4] unit/test-bap: Check that a broadcast sink PAC can be removed
Date: Sun, 22 Nov 2026 12:50:43 +0100
Message-ID: <20261122115045.1077168-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
References: <20261122115045.1077168-1-simon.mikuda@streamunlimited.com>
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

bt_bap_remove_pac() did not find a broadcast sink PAC, which left the
PAC of an unregistered endpoint in use. Check in the teardown of every
test that registers one that its removal succeeds.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index bfe98a885..9508c503e 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1307,7 +1307,10 @@ static void test_teardown(const void *user_data)
 	bt_bap_remove_pac(data->snk);
 	bt_bap_remove_pac(data->src);
 	bt_bap_remove_pac(data->bsrc);
-	bt_bap_remove_pac(data->bsnk);
+
+	if (data->bsnk)
+		g_assert(bt_bap_remove_pac(data->bsnk));
+
 	gatt_db_unref(data->db);
 	bt_gatt_server_unref(data->server);
 	data->server = NULL;
-- 
2.43.0


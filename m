Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189677;
	b=FmrchMr20m/qT3WL14hJkwrDmJ2kh8ZsO/RfyQDsaIQ7hlsic4YLMAwbDhKobmvC+L4W
	 fUcMMMDSkHf0eFIKnffFrDax3xhOlX483k6o2RSkmx8HAZT2FylWKE7NyoaZ2w4WZ3Kk8
	 60rp5ZD55JEHIM2OTPlLW7REXcOwgfNCcotzJM13xRWRb+bQg/72Lb79HNlG1jyVd2wMo
	 EpilGO3dBJsB+0rs8pXHcAfPEQ6QWAjVCU2s1bYDmf/jUKMrbU4VdlJ9E8677CfTVq+h3
	 O5YMwY57LQY6hetIvl0EJwD3SjjFkfKyMNE/Z8zXoua1MDVKbiBvjqZBzCVezcb5ECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=42NGEQHQkO+c2IVY/4yLvjO1Fjer9RIlL+E42bxJVxQ=;
	b=BtF2tTde4aNUqYaZ7lDtueO9KCxxYgDxJqOSuCLo9FDLIoiUPTtRDuqy1FMZITyF+Tkx
	 xNuiMRvdjEQXsZk2I1gD1B1eVMGq5wcLEc515+qqcywa3kLW7Ng3sY0GSyxBO8y440CZP
	 Iqjcmfj1MFaDQDGCsSZOs9Y9AF4DC91t6R7e31VzovNWnvQbzAo53EDRKW87MIaRw2Am5
	 0m4huoIEaUkNbkPs7cVlw6q48B0C5tAPQm81TYsQxL1weqq0XV5W04JkVYlVpmJ1pHNRz
	 XkpaWJiMsxyJ/+Q9GhKm3ynMFmtq4DHKtOl/GOuZ3TzcUI7GFc8nzImvLo7hVsDWmcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpderuxJ;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E560A2607
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 842E560A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpderuxJ
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2dbc0a8d4so352956137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189676; x=1795794476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=42NGEQHQkO+c2IVY/4yLvjO1Fjer9RIlL+E42bxJVxQ=;
        b=HpderuxJYttJzGIKEcWJKAVNBGv53WkR9j4mU3IJDjSp6x/7AWPijJJZ6B64c28mlf
         wpVFiFIsZb2OY/aTgEKJ5weSr9GiW4Pw8IwlhPgiYtjO55s4RHQ38eKTFtjT2jO4cIjF
         EtaOnIj+dAyZZ7xoezpigcPj9bjzQujX0knsc2NCmQarXsPzQnHjfnutLnf/fjEcoBT4
         AcFhn88pgR9EXoAfxoX2m+/BWg0ePvoF0V5AYLPafmDrDbA7FwBf7htq7KTT/4nTEjyH
         h/HMX5xtFcJBba6bv6m9UmcsaFbNhN3v0EH/YR5bQoiIgVLMNZypOQnMiBifUUsXhh9C
         lxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189676; x=1795794476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=42NGEQHQkO+c2IVY/4yLvjO1Fjer9RIlL+E42bxJVxQ=;
        b=fKEepejZJ431gmxHaAE39/1duaoVC1irfCdU+MmnQ/B2JF/NUmGCzVLD+pXYY03F+G
         XA4NdV9iz5Noe6ebQbm1BJE0tLj61HBJHoZsBaTOrJsHC0Sc78XgaDMAjCwZoouVa7Ng
         e4fAlEqr4a7/EKFaHwN6MhOoLGJ8dXIGT4zZkoXCC17RoBUhTbiGfokWSE1xFQtYeXvp
         1d+6X+F+KK1HsczRH7jF0niAU5Fs0DkxH+WK3EzRea3LsTerdwR5o5V21bJP4sXJnuxg
         UsSIjxOvEELoUtXytSnrfNBX1Tc2cotq4Kzo7ZqqXceMqijPX0q1kdb1cq6vVUVcRpra
         UodQ==
X-Gm-Message-State: APuU4Z8WQIL3snll8CqX2wK+Yeaj/cqLUWNTe0ZIw/JeoyJl+tShBRuS
	62qj6BmGw3dtE1cCWqIqg0qWe2h/Kl5p3UQMHGdN6yrFZaNwhxVlUXwpPoqvyAqe
X-Gm-Gg: AZFdTZcGMdtShtT8f3OJ/XvIFFAa0xasU6hIbbnFlwB5DpeJOqGH/wUXuJSqqxTkuqn
	PTHmN1uJtWk3a8VByiSspj65b2+JRNcGYOvXNathy7l90im153+l3EAxCz4gkQPKemJrVsDygxZ
	Gxy6Eq2oa7bgmsuRbPuWolqJzlUwo/fl3ki8VKDS3wz5ciC12m2IJoO9ZStWiOR/8Q4i7L111zm
	nHdUAaCg2Y7jGnEKOkksdRAQAy7ejGDlaggIZdbgWTkmhG4icnoJxoKrXtKzO86/0OEKmJBf12C
	bBzxzoWYpefv85aTlExwPRiGrQuIkuzU9UtdCy1Saf9x2mLr4h67W0ofLJW6dekAeIDxJiqr3BM
	Q8PTJ8Dz8ClXJ2pzzNZ4HXFb7h8m5FXuCUOO/YUcHBAD22lcQQtzq7JbSfeU0jGSfxRxCo3FDLX
	/fCQUgYCKD9lD0GoQkY+T1cKH6LvhY/MpArL7tK8QIQ1QxC+PPspbPrr9ze9WC/pYyTF4vnyHUb
	HEif9ovtXrxfOfkqJ/h/1EyKUnUY7EuXS/QeOTwODixkfxbJsI8qe9mx0S5jpcXtx05HxQsluAr
	su9OQUX5SIIrZOe5zu8lyLQjF5ixEhVlAeeyloUOagZUMk2ap3yn4Nsu0LzKyyFFoVsWp5Hbb3V
	Ltk8uYafDl5Fy/Mve833PZBlPLaJoS0i46x3HwIawpjLL9g5+DfkW5Fhu67GaElVbZe8P0vFQs1
	1mj9awM2/qCkwRBpJxlAFvKpSP
X-Received: by 2002:a05:6102:504b:b0:7ce:5952:125d with SMTP id ada2fe7eead31-7d7396cc165mr1294088137.36.1795189676423;
        Fri, 20 Nov 2026 07:47:56 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7b12eb7sm3358243137.0.2026.11.20.07.47.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:47:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] l2cap-tester: Set IO capability in Client SSP - Success 2
Date: Fri, 20 Nov 2026 10:47:50 -0500
Message-ID: <20261120154750.1745643-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120154750.1745643-1-luiz.dentz@gmail.com>
References: <20261120154750.1745643-1-luiz.dentz@gmail.com>
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

L2CAP BR/EDR Client SSP - Success 2 connects with BT_SECURITY_HIGH but
doesn't set the IO capability, which defaults to NoInputNoOutput, so
pairing results in an unauthenticated key and the test only passes
because the kernel lowers the security level of the channel to the one
of the link.

Set the IO capability to DisplayYesNo so pairing results in an
authenticated key and the security level requested is met.

Assisted-by: OpenCode:claude-fable-5.2
---
 tools/l2cap-tester.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 7004955a1af7..da10954075e9 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -98,6 +98,7 @@ struct l2cap_data {
 	const void *write_data;
 
 	bool enable_ssp;
+	uint8_t io_cap;
 	uint8_t client_io_cap;
 	int sec_level;
 	bool reject_ssp;
@@ -393,6 +394,7 @@ static const struct l2cap_data client_connect_ssp_success_test_2 = {
 	.server_psm = 0x1001,
 	.enable_ssp = true,
 	.sec_level  = BT_SECURITY_HIGH,
+	.io_cap = 0x01,
 	.client_io_cap = 0x04,
 };
 
@@ -2342,6 +2344,16 @@ static void setup_powered_common(void)
 				data->mgmt_index, pin_code_request_callback,
 				data, NULL);
 
+	if (test && test->io_cap) {
+		struct mgmt_cp_set_io_capability cp;
+
+		cp.io_capability = test->io_cap;
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_IO_CAPABILITY,
+				data->mgmt_index, sizeof(cp), &cp,
+				NULL, NULL, NULL);
+	}
+
 	if (test && test->client_io_cap)
 		bthost_set_io_capability(bthost, test->client_io_cap);
 
-- 
2.56.0


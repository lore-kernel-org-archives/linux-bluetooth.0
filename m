Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624114;
	b=WfcYHj7uQcSaK1zTv4Kqc/Zq9D9u7YQDwckNfDD0fCLa9Fxxbz6+7AqjjnPanX/lIOFg
	 AZnCoPk+jJ4yn30H92ANK/mPCMiaPoCf1dNOZs5Rbjx6P9FF0Tg+TUQmoIsEL+SQZ51ju
	 clxc0ul3H23Gzwv83bl/JPUeKbA1F+wqlQLyc1+9+7GD4xqGbvcu6VeOGr5ZpvPHoxF6M
	 IKx844FGaCelnqEi+ZN6ZLtR8GWZF4KoWhs55BBKauYyGDQX0eIO0539va2OL57M6Xv10
	 is2lX4LQL68NuOCafz6r12Fayk7kVfhEaZthWmm6HBnCUSpYPjB8GMKzVrVAJWgkg/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u5VkOR55IolBp1/dwpkjh6u81pw7UmMksFsCRL71JiQ=;
	b=cek9hFU3/j7Kh9dMfmq9H6Ie4szG1yZe9gS4Z7E96Y6OCApfB69I6YUmZBIF7j1Rxvif
	 +Im9BohCGui7XWu6uxuXbbXk7Yrl0Cfa9k7e+5iUKBsi5Qy6e81tOiAKRQmXkCMijVU0o
	 U3KHfzB8GSVIbNc8fGZh7kuWXBKkn/nF9z+BPG2iGGx/SurvQp4mrjrxqQfNB8CrrBXGT
	 fIEsaRcUSe6DqHU50pvIjQYHjWY55eXCokFQDbBW1szBvqzIpD3rr1XaPceSwSPlqStet
	 yCuJJheDtcxrqvTXgepyACeDKD2dnCVDYF3xIcVugUi69UXahQSNcz2NCrVD+5I+ajQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L4cRZvMn;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E8606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D27E8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L4cRZvMn
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eae12762c9so2426182e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624113; x=1796228913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u5VkOR55IolBp1/dwpkjh6u81pw7UmMksFsCRL71JiQ=;
        b=L4cRZvMnVRAQ+GK/tZAWt5JpQgsLVgabmebTUomUtRpgnSJmHC2B2kIi0wOJzFgFiv
         K2M8/ZCaNMzXegU2SjHEgnhwLyfBDOPMisLFOfWe+8Uq/EBfZ9OTxGPZj30AXm+EHgNf
         64MqtnXoM9U81fSVCNhltkZ67aEUP/oqUbrOAwfEM2Zh9FRVyzPrkyA0raVETeus9nO3
         ecFRsHvgeg4S6fcENUMsOhQpS/AfRyQoj5feMaVfOHrULIxTr1pBFq/ZTuT9CBbW/llR
         Equh9cdxgd1YQ3en61JdP2B9zzWLGJtXItQinpKLhv69bwFZUPZek0fu6pMNKz0AgRK1
         yWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624113; x=1796228913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u5VkOR55IolBp1/dwpkjh6u81pw7UmMksFsCRL71JiQ=;
        b=bv4uT2pRsycmwJtGt6wQIhAErGsbUEh2lKJMaL8pQOOlejbWYg+0Ergm8kM6KYgBZn
         pj+sJDYXiHcGmB3BlJzHSoXbfyyEd6QEA/CvQMLl5TYpdjn5ujjcwfRFTX6tABELL3Mr
         7wi0uoMCj8fPxgijXVXhsl5MxO+Q6S9hQkjtT4dEkvLO6IBN+b9Co2NeVcD7wPkQiA6b
         437zT5zSfBSdgV1l5KkroR8kYVJh4kjpuJiKlYINFinQqqLu3JsXospITiEvCWHi+TQx
         IZ/sbwFsQDyDSwndBroP4m7mUwmEwBZLHYBxhHlkCijgKTbc+OnL1vS4xN/kjHZonNC7
         hLYA==
X-Gm-Message-State: APuU4Z/rsTYSLoVrXwW56jy+md+mkjCkqwdaAHEvmZ4l/GzQLHz7WCMw
	2lKAgEKLyd1TPEw9C1HtfkG+z8cpHDfpsTnkHy69Tl5vqnR4YZsnu9etH+Pg1w==
X-Gm-Gg: AZFdTZc5tKfXH3nateo+rVOFST9lpheWjZBwpeMu0eFOn3SyikiTdlnaYq3c7qScz+T
	Kkj+PmbS6ZAhHqZdO0UiH+RkNiYHt6T5rnGJD3ZINVxm1MViBo/yZLQUNu49Xa3tAXpFb2T810C
	XjGAPv/IbazGhsxZlMEhUsshbyk9kv0OpdOzzsGIyVtBTzxfYVLLiYbdFuXQxid5Nlno69kDnHq
	s2L5+KvwaQOM+2t+ByHBICYNsYsY1bThq21wmzihnYHyCak+OEBO8nUu4Xo7p0ix64UwcvuBsha
	q2quMlQsj45C7wL9RQjQl4HWxAqYjn2aUgihxNfeh75vEQowR+UXVm5wwfG/ezzkNXsk3fOMpSV
	A8iABN08d046Wa1YuzmfJOv7lRYKlbBpau20GBQJeKfLyU8A0B0D8y8OUk1byzYh1D0Zb8C9EyP
	rGxmV2NBrm+B3tqLWqrmYK8ldow0bRfKGtU7+0yh/VQElIv3u9bi5oyqX9517BjEjM7yu6JbrXs
	OoOPf+9aBf42sk+X1tJkwl+C5zOlUSZ9CQWSpG30SFmCI/qYJ6ntu9qPeDev9bJI0mo30xXgR0U
	JfQUfhaTeQj1J869fjEB0tPyCrE5lSQF4uk5yZJ1R+7qUj67S8AtYwXmzBB1ujgt4x417wyF5At
	6aVytd6q29uFi92DTQ/VyYuMDHZghO7m4SUWYyw9zX7LBXobmOiEr9OsfNin2qDXK9eV5pJyxNj
	4xZds=
X-Received: by 2002:a05:6122:8117:b0:5ee:ae8f:5a16 with SMTP id 71dfb90a1353d-5eeae8f5a4bmr3930594e0c.18.1795624112625;
        Wed, 25 Nov 2026 08:28:32 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5cd7c8sm17985305e0c.11.2026.11.25.08.28.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/5] l2cap-tester: Set IO capability in Client SSP - Success 2
Date: Wed, 25 Nov 2026 11:28:25 -0500
Message-ID: <20261125162825.1409753-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125162825.1409753-1-luiz.dentz@gmail.com>
References: <20261125162825.1409753-1-luiz.dentz@gmail.com>
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
index 6ad8a7aae717..58fd77a3ec79 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -102,6 +102,7 @@ struct l2cap_data {
 	const void *write_data;
 
 	bool enable_ssp;
+	uint8_t io_cap;
 	uint8_t client_io_cap;
 	int sec_level;
 	bool reject_ssp;
@@ -397,6 +398,7 @@ static const struct l2cap_data client_connect_ssp_success_test_2 = {
 	.server_psm = 0x1001,
 	.enable_ssp = true,
 	.sec_level  = BT_SECURITY_HIGH,
+	.io_cap = 0x01,
 	.client_io_cap = 0x04,
 };
 
@@ -2343,6 +2345,16 @@ static void setup_powered_common(void)
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


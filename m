Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590627;
	b=2+6KpfmTTrGfqQ8NtLrRDQH3NtPhhE9db4yhsntVKR05afK9a7kDVn3qDXhjpgCKQm1G
	 MKzYvTyiTsy3pHuq2qiRBX3el8Dhp2AIZsfnmW+RHvI+ESJWnO3sG94Uig0cPa0j51bvN
	 mLer2cT1865JIjgTVa5OL0nqEYf0sfhmKXjw0oBtR01OEiSIy0EqblbAYNLNZbdvcPDgx
	 QKR1cZEkbfuR3/QpMWx4YSzRsPE+56pwa30Z++XO3c3o0FNozxuDjGo8EZucOc2ARlMGx
	 vbCZkyiBbu104IgIpfi3HySFKty+1Vwdx69oB1KG3lSZrrwM92dNeI6NbMg/4xZje+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6Y+odWRgHh4z07I4UYRqxV/HlFuN3r1WhkMbWBsNBrA=;
	b=TsRhRgnMS1qBehKpggFrYheCHVwCsPAHIty1LHD+GhXE07dcFlgoy8IAq0jN2bVJFCtE
	 eG4ozWVfA7oBlCNPp2ItXqltOszcSP+PSp8hArHeqK8PlzO2iu3M9VXrJL+RgLIzjRj98
	 e8kgdbOsn9rlyAxS1hkJzpqUzOlQ4nFzfpKTIsPCv0UeE+iThUtKIvrtWrN1eIjCWebyZ
	 rz9R3PgmtjKeKkWnepobhZ08dbaBGR3axalPUUbzHWBghw25l+p0Rezrqblf1FpVIT/0U
	 Zp7/Xn4wgLAB7Wy0DU425wIOi+Q1ONa8V6r9+LCork+dvGYz5u/IWor1sWos7OnhuQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=1C2HDArk;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3D6075E2B
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE3D6075E2B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=1C2HDArk
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3ada81853so1112916c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794590626; x=1795195426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Y+odWRgHh4z07I4UYRqxV/HlFuN3r1WhkMbWBsNBrA=;
        b=1C2HDArkCiLsobCHZPwDQ+1qhx4mKhEJm5ibJxUPRL0lzqnsYzqI18angimV/YqyyT
         i0a0vSw4153RHu4fQ15TQrpLxNAJFekSE8sk/hUuV2qVPEVRImzoQmx5tAfkNaYjp71X
         trVlp7PKGl0hdhi5hwmxyim6kpnO6pB6xnbmRqEVIqfFeHx1GwYOY3EWZEwEzpPRxeMU
         KPjiW0NxoADwXzrzwDKHEDzr3J5a4g0i/Mi4Y7m9pH3yuDnjY8PXXEaTvl3jKaQQO9Xf
         XMJbCQn4XN+gL/WYlaGA0nxW6FkUu/co1vvPgoyI+/OGHe+bXUjqiI6k6+9ltTd/3ctw
         wpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590626; x=1795195426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Y+odWRgHh4z07I4UYRqxV/HlFuN3r1WhkMbWBsNBrA=;
        b=BrCOkxRU1gBXU2oLbMkOr0ZdTDQOPw8OqIUnNVYuWBQnOHJdTMVE+u2zzvrIIcet01
         IOa30TkEyLIjeQb/7Ny7G2xB1oWEPOEAXhkpYT/fVx7y6VcmGyc+Tf+dIIVEdb8mFcjK
         CZtoK9dKkarF88RxHAm4b7bUyxxTm9UAMwgKQ+EY7xhZVAem2b4+hw/ZVXGgUr53Snmy
         Rg1d+N8IjokeMx4Hyyh9AAgYYkUHxeKRI/q2vCzSV8ezvUvHlAWodbmiu2+4bs/T7wLZ
         awkP+ymwZeGEW5ZGgOTo1WVGWS3A6ABPhU5M/NfeHYmSJGsX2d7ltl+telrV9yZ4KL/h
         CK+A==
X-Gm-Message-State: APuU4Z9qNKJSI5t9EZo5TAvZzWJ9sQ5iFtunXuuHHhr97xtAEg8P9WPk
	o6Ro/aDAcHAH+00UGLPXSh/N6tbBZhMrrxlS7G/EMNjrjmQmdEFKbFOF3KtlI5czAoKJeBnxs0+
	lgz5fUzN6vg==
X-Gm-Gg: AYBFou3vAt+ThifOwhOH//qiLoztkqbtqhmivXf82iKkurmcr7cEcmCy1EZuEnEBwyk
	v15QMbUHPqUoDEfPlkstDxVTtLeb1bphmKsr7kF1oq6Lp+wMAa4JqQBiocQz870KKLv0cujE3Xd
	xy60FV72kyzDNJjSDPxRdbfg0zJQCBKlUJ9TCiu/P+k53mmWh/OSmeDnjiCqnGWWjPhZF71kEA3
	IZ8hVMrTv8cWg4i48+ELeUUtV7MSiRlol+GuzLhFO7gNGDtf2Bo7rw9Qf4878NCO40A0KWGgb/m
	oVfXk2RD0todM/Jv+IjG/LxwB1Jz2UZQMW3nwwGskY+hCqb/kRS7LxB2SzlCtY+5fIh3RHZchUe
	bl1E5rkXRYXIWr7zZTNtnlx2WWjvDhmBR2PF1VuYv1Fj2npquKCTnZHGybSs3IFNyskC9lQCnC8
	sE2YrDKfdE4ymJBx9dIQGGXbTbI/fOiR1rPe4owfxm8PTC5NQQ4L1xBcdB3udc9GMT+TCiBhfVG
	vSusOO1bzx4wo9YjqTFh60SEdbccsDh7aYw4yRHscM4vckUV+MrLc0MgFfqaoeQ+q3yiIAPxepv
	NfTdiXCygzqCweiVJEeYE/FRDpWlE53Mc+Ghbb8daM1gdpwJIb5eVWSQhViYRihByccGlcaH/CA
	vj5QfqqHvCeWyzDAr8DGEQ84ag/vl2O33uEraeVOlow1Ng9tv5IDuCQ47R48Bg4KDgnHHGfU=
X-Received: by 2002:a05:7022:3a87:b0:1a0:b8f5:872d with SMTP id a92af1059eb24-1b5030683c8mr3131049c88.4.1794590625715;
        Fri, 13 Nov 2026 09:23:45 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm8151800c88.6.2026.11.13.09.23.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 09:23:45 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 2/4] adapter: Add btd_adapter_get_conn_info
Date: Fri, 13 Nov 2026 09:23:37 -0800
Message-ID: <20261113172339.54683-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113172339.54683-1-kevin@simpleble.org>
References: <20261113172339.54683-1-kevin@simpleble.org>
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
index ea438375c..fa55bd87c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -11628,3 +11628,25 @@ unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
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


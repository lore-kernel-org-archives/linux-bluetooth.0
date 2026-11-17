Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939721;
	b=YlAJhNrkoP3aGiJ5OVOMo2WlGjVWZbu5dBs6Fj+bc/qyT4JYs1D7hv2aKaQkVdJEVctm
	 G3WLJLnOVcjSqxXwiV4HA615Ep2rgWg1U9HApQr+ToP6jXSUiWF6rY2uvJgvQK3LROiZu
	 46nhFZayAudDXYoiNjEpyc2fZc4oE/VBgehPtqF04ozlqdmJ6OruSmRwXVzlDdKqndBDy
	 Xpg4aL8mbmdL0PnFkBXDYrTav1ky/qS1ZWKFnk3WQKoYhC9AvoExVAc1T3YE6cJCamvCM
	 BOvjcEgdVRNPBEDvvMzrNNXcIJ0Nk9plxySxu+UwB7boOjZrrqsbyccJKOJpaS5p5dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RgHXf3SuEX0LXwGHSVtCN8y3JpJukMNKGV4p9Ed/SF8=;
	b=wXVESSMIQ+YwHD+X3BaiNd3rR/qZVS9ZW05+RNNihg5UStxiALukpY3X9NELwzk/Fvtd
	 wniR+WGQzvuU0tkliUDFDhrljvmb9tp/ZtgqnyR0QHUXTorUYuJxwBQSO+kwRu9PbwC6G
	 QWzTycYvJga5pS7bMXmAnM1LGj/iAtWvALOxals6D+46fPna/An8GBdHL7jC29fm1OyF+
	 8/hmLqMfpIr3k2JOCNmJv9T1MXs7aCpGeqRgmDKeWejyCabl8rXjUie/AXEd6ymYU6lS0
	 5MATtpB7zpfgdDgC/U1TOutllDyciWzGNVOXiWRE8/LJztud+5Kek0172ZAnlAwa4CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=K+R27s6b;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A016606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A016606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=K+R27s6b
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36dbde64409so381695eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794939720; x=1795544520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RgHXf3SuEX0LXwGHSVtCN8y3JpJukMNKGV4p9Ed/SF8=;
        b=K+R27s6bWDRc1LPn3teMW8sBBZGN4IQuD9JimkjcMe1hJPX5cVbnO7yl65FtDqh/23
         GvqIu2tfaXJDwmtfU9O+0P7nkSVmwGSh5lkKAox7PrkvIXeqBdiuKUYV3aCJYNvNa9xk
         v0ZEMn6Qyfjs9huIlj56W/hlzwb5ISD8rnlpw8NdCsppJD+MDa/oP2gGW59tYFS0Nx5F
         JX7pHqosjz6ChCuUazI4SeNCOMyjNtmrZ1D6UAWcAkBicFKEof+tyQB5aadpjzxTfvJF
         095G+hA6FRayjeV6763hne13C7n9PXh5lUk+WGflMtTsn5MQbUCjshYGHr+6AxVtfKbZ
         OV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939720; x=1795544520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RgHXf3SuEX0LXwGHSVtCN8y3JpJukMNKGV4p9Ed/SF8=;
        b=SS7TLZqw6Cgb7iAvCPAu5CM12K61ijDEDm/4UolY94Po8arfa/TAasxqIznw8nAyDF
         k0j7ZBUVWj/XkREKV0GZIZnFYoyypRBvvS8ccTqpIbMB0/1EF14UnUxGeg7eMtRBNbBD
         ojdMSs7d1g2pjPfEUI3JzoZiBRe5y8FdLRGtZTwRMcUWy7AtCgnjTe55Af+Du8CFZ94L
         b9kCBSEpOMlleIXyO7Y0WEFnUURwBmvuvAYxwoTU8lrg9CiFiOj9u2lrv8T8LF1Txcll
         +w/UqVC4rBmAVtF/Dn//W95cvxIgGgIkxj9vLrYb73wGXaKQPOQx9csUKyxsMmspwTdb
         HaLQ==
X-Gm-Message-State: APuU4Z85B8pcRH1KKsdU5BDuRzrhKLcrpCI/41Nvv/EMOwie9TYsXa7e
	a5Hmy2k8WgZBnOXCykhd0Cyxza/09kJOEV3HoaNnVsgoaaIt+lB+f5aREbLg4zNwu9nxXw3QjxI
	RMVugZVM=
X-Gm-Gg: AZFdTZesSQiecdapWd1FThmNkrERHcae9zOmk1caIv356V87qtiSfPC5O7IqVPiFUME
	jn/OQcWCwvKjlouaaSVm4e6wPGJKNwlzgHT0iovWwmNK/ZW4lDTIYV0ok6/MvqZJamD905AzcoU
	Vu7OUvFuwx82DxvZyjvpqK7uTrOvq+zyEEJD+oMw1MOEOiIrPHssAhqFIBsMVypJonmg96IGb7G
	iqxgAQVmnmL14oYDppBOP8SvKaBBW6GaR610q8vbGaxBYI+8PVsK1EPmJxE/zqRl2ChTeBvpgYy
	S36AFWki3gYZ7IxY4ZvNdxCjITGXjst8fjjrVpR1d8JV/ArlM6OHOmpVuYreEpSzkso7pFkDc3c
	bVgjhr5ayWYSPQx1xgEYq8wUyB5yfU0c98acudwCUoATnUC+5SNk/96UwsAt8p1OwpAMsVDCIDd
	Zd72EcoK1wSDBR9kk7L3rx7EdyscOqlz2kMwoWzCR6B5xrqfTGB6FKNy0rONGuLEy97cwr9JxL0
	SzorjywTXQ+72kGdbNwRcjeOglKCvMtZJzA/mf8eD6aVHbkhA0/iX5zZ87o8gMlaBicif0fxCoF
	3bq1Aagg+fsgRLfy+MUuYvBrZIKTzY+9hy3eBLXStOv8DFDj+Xdd7wK4wkzwN1hacGptMUA6uDH
	nmfNVwtDSDG8jQ9i5ziLcym0ecgD1/JGxhN9Dw1yBuzcu9iVAvhxsrW6GePWNObPJju01ZA0=
X-Received: by 2002:a05:693c:880f:20b0:376:552d:402d with SMTP id 5a478bee46e88-3828121ab02mr197420eec.34.1794939719758;
        Tue, 17 Nov 2026 10:21:59 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380d5135221sm10503213eec.24.2026.11.17.10.21.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 10:21:58 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v5 2/4] adapter: Add btd_adapter_get_conn_info
Date: Tue, 17 Nov 2026 10:21:49 -0800
Message-ID: <20261117182151.73722-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117182151.73722-1-kevin@simpleble.org>
References: <20261117182151.73722-1-kevin@simpleble.org>
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

Add a function to send Get Connection Information for a connection.

Assisted-by: Claude:claude-opus-5.5
---
 src/adapter.c | 18 ++++++++++++++++++
 src/adapter.h |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index ea438375c..7c40a0460 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -11628,3 +11628,21 @@ unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
 				adapter->dev_id, sizeof(pkt.cp) + length,
 				&pkt, callback, user_data, destroy);
 }
+
+unsigned int btd_adapter_get_conn_info(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
+					btd_adapter_reply_event_t callback,
+					void *user_data,
+					btd_adapter_destroy_func_t destroy)
+{
+	struct mgmt_cp_get_conn_info cp;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, bdaddr);
+	cp.addr.type = bdaddr_type;
+
+	return mgmt_send(adapter->mgmt, MGMT_OP_GET_CONN_INFO,
+				adapter->dev_id, sizeof(cp), &cp,
+				callback, user_data, destroy);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 583168f4b..18e6eaa78 100644
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
+					void *user_data,
+					btd_adapter_destroy_func_t destroy);
-- 
2.54.0 (Apple Git-157)


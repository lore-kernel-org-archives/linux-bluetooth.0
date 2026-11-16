Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813390;
	b=SZKI60ezQtH/mueMD6X6O/8AZUQLBYZngsCfgrpPmn5gcSX3qvVFOTJNBjkuTkO0CS/3
	 V6JmXg3uwGmdZULdfm6UBFrMcVnoABNT6lkWDtoarHcSyCCa5Kx5VAvR3Qw21rLQieXMf
	 5qwNrjacjXKIXk/wQ3kkbp0+fvAJ4nu55eT+wbqyqXNdW2+Fihd1K4C3FLtiIHfmX328r
	 uhcp5wTvaD8hdiYIqky3/gjpUhS1OS68OptoDEiPc3ytkwcwhrnEM9bZ+ckaC7HyacSd/
	 65HrxYYX+apzaQsPglCDFKgtrULtamlN2SgOHEcE4kKVf1hr++hwbxwziG8vnjsO78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RgHXf3SuEX0LXwGHSVtCN8y3JpJukMNKGV4p9Ed/SF8=;
	b=c9lR2WbWSfJFIBu2Kx4V4gkh0Z+SyFDu1ZpA3bydJz97D6CXRMaY4Hlxt9AAl0VSLpwX
	 71nVazfu31cPUTmV7usRx1phBbgKZkM3ze8tonMrTIKt50MEzFtgcxQW4tJkGPVCXb1e3
	 lqD0TwYhoAHTProFT3LBHXVXWIDN2j/QL72L3Csy2ApmOL0fdaCdU7Cx5djSYr/30298Q
	 hJjxHnaSdkzfA/AHy7Fs5A1QopCnFIcdK9XYsxyOVaj/7SDoDX4SIZQi/Tc/ICdw/QOHT
	 5LHJ+PyaW/Ho7FIXwSRGSE6TSTOsGTjQ/+SpZFt8olgbKMFQUPLt16a0oB/7c9+c+lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=KbfXbkQB;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278B606A331
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 07:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9278B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=KbfXbkQB
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3b4944abeso606274c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 23:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794813389; x=1795418189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RgHXf3SuEX0LXwGHSVtCN8y3JpJukMNKGV4p9Ed/SF8=;
        b=KbfXbkQBPnPXXq4GaSmlJyOf/MUv9IKmK8+AfSzOzQTrNy+/ulMt1Wfjim8QjTRPj8
         JHsuOIi9qvmK5S8mCzDJO9OY8JHdCaqOSr7/9z3wgat+aOHDZeAMkaF/NORd02cZaCNX
         KKACsJhNvSvpA3M3PZMwOZNHap8ujXVEmYK9w+SSV4fm/9yUz5yA6qCZwQLyTqDogoMg
         Y9qF2BAZe+mMlTf1poJYffPXnqJgDncD8cbP5mUye9vEzU7NOS8hX0oVRdpN9WfzafUb
         A5CYlNkOvBieQGcX2gTXWNcSNE7ktfJvXvvRnmm7B81EAM39PjcEB2p2Up/Ht0h0J4kU
         p3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813389; x=1795418189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RgHXf3SuEX0LXwGHSVtCN8y3JpJukMNKGV4p9Ed/SF8=;
        b=0x0JnJULddXD29X8Ur1qUZaXuFsot999G1F6Wbf0az6iim4Z0WROpxWk4nkfpeR1C2
         Riy560wE6ZhevgmrJ+SooCkN09yEEWMMGCyJLYVvsB8e0Vnd408K/i0X8sS3Q9sw279l
         EF+j3HIaEZninelilMVaTRobQWLJs4Hov5pzWMQXvC1+3O7fGcZhR3tOU6OpyzrNdwWy
         V5JEyca/blnXBCvKkojrSxX7d3kIWiK035hZWdYhNeMX1+GhlQI5MQszqEXYUYKNkHdQ
         wZ3XiVLIgGsFhhCy/5VU2/PN/v2QbBju5OFXgi9NQ8l6d1xkv9SG6Dng/eIaSTxAr7i8
         q3Rg==
X-Gm-Message-State: APuU4Z8Z0KI2/47P8T+F8ICdJxg56O03UD8hBNJnme37gigStdV5r6l7
	Y/nrCBtveFbi1hd/Xa0AYYsegjuz/J5Ts/kLD2/wykXaUV1sa0iVyNalk7ZprJOWs4WBcUQOy5F
	StgbWcJg=
X-Gm-Gg: AYBFou1OBJUDqEzB7r9WTbUxDxEbt45UKZWeAlX+UTjI9flev87zPqqxEq+6zddYe7B
	NnimSZ4dhaJgVAXv1A1yf4f90r1utHxi6IayqU0NXcdVb2Ifsp8OGNYU4BnVhq8x8d0PBhFUaoL
	LtVe6+BtvLZhPQnkH9oae8AW/d2jKLOVuKClo703tQ7iozKw/v+8wwYYaZrdR3CslQwC5OqYF3O
	CAdvNdBghFFANC/LvoIg9+WZiikYDG0A8Mu0FJl7cTtU9yGYB3YO9DwI6+0Ha0pOwJfhVqrVyws
	/VmVxti8EuAEWnxmL6AUJnr2FpvS6WYixCVmk5A4euvj89P/xR08dm4dsTO+xlseNhZzLXr5n2W
	1eK5vlOiP6NtvEZMiuVPgl6eFCrYkbPGM91DMdY0085E7C8TJwTzO+dXpmdgxRK4sq/OQ4ARPTU
	2uehcYjDs6Lpd+6xWPn+bo4YBW/y1HGX5HNwb9xQefNzSsUqJ+kruPhsLdZwDl9HhMr1cGxQh2S
	ZTMceCsKQ3HfyX3SFzJvMAOSNOzo9DSZB5rnhQXpmhewo6rIWfv9eAScVy/CnngvF/t32D7JTZO
	CQ9CyUTZHX58nPSOMs6xPS1J898QwNCSuPh2hdDDB6FenLvXVC7m+y+BaFpZWYEd8+JcDykFiFv
	yB+wy4H4J3nwbP4gT35fUBkSKW+rW0lNrKgEMSkcmQsWWYJ3g9QcxuRgayC+I+vjFLo39O2Q=
X-Received: by 2002:a05:701b:4590:10b0:16c:ff3a:d72e with SMTP id a92af1059eb24-1b5030f5875mr9453042c88.20.1794813388553;
        Sun, 15 Nov 2026 23:16:28 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm40571430c88.9.2026.11.15.23.16.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:16:27 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v4 2/4] adapter: Add btd_adapter_get_conn_info
Date: Sun, 15 Nov 2026 23:16:19 -0800
Message-ID: <20261116071622.35355-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116071622.35355-1-kevin@simpleble.org>
References: <20261116071622.35355-1-kevin@simpleble.org>
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


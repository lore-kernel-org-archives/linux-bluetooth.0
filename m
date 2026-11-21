Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294745;
	b=X6CBRfERP9/dWtFqO1cThmbOIzKzpvLbP0jzow1v4wc/FVytNxF2Dmq87Vd5v+Pdp6ix
	 1aV9e/MP9QDJoOjZ5v1z7480VA78wEouIT6D/BpI6Ytd3V4ak/Y8p+BCWXHnKm18SmG6X
	 7ZQR/Nzq7bkp9rEuDpf6l/fovg/VzbLroBubcTiskb9tjsmHEc3PDg1ELzGJ4JwjgNogH
	 xhz4r6iz7lDRjv2yoFbBlahSErxkmsMlzrW9cOTcGC6iehrW7pRSl+ks1zC+0v7fxV0Ip
	 2CvFAR7zXLQyjf0eHBgJqG/vkzyJ7x909/L9Ob57qGmQLev/F1/R1mbdwSZ1k7+RC/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8EnvzJ5YZjtvRaJCKukaMvA/8E4qxQ4MuL3qpPCkI0E=;
	b=4dO6jNPmPcfbC3rntyAVi1aVEU83g8ml5q5isIeyjMOi0j6wCLNWJnhhB0OuBEm7MXQS
	 dx2COwkjmRN7PxjKWGHdlbipV/pKzWerYXEdIOK9HXSVN2LVw3Ly7fPfpyWFal4PP0LSK
	 oHZTGYMJDkGv+Cu96oUQ31hbOBZiqSkcRmd9CawQcN8x2S1KLEvx3KcT96lK2MnuLCNiz
	 XX17JX/VJbpJ9E0raJ1Lz91hDnTYNaO9bgFT5zSZ6+TBU8NGOteF75Oi3OFi5kYmkH2ic
	 /sVpGN2uYL/+DhcGIltaXJhF2EGXb8YLotOVIyoPBLYBHlmSS3Mix+RE4g7j6yyXF5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AaqDdfJc;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7FD606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 20:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7FD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AaqDdfJc
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1175531a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 12:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795294744; x=1795899544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8EnvzJ5YZjtvRaJCKukaMvA/8E4qxQ4MuL3qpPCkI0E=;
        b=AaqDdfJcO2RgLeC9wlVcPJL1V+TScg126VhozfHlbkcyPdAH51hChQKqB/Az38JqZg
         FUAZa9+/x6BALi2wxiNIUl6ge2QSN88HmkjDY5xhr/Kn54fj0Oj86+vNOOWceiakoLql
         o0d0n3/0ZIvIO3wAuiNoCd83BaoJP9dkyb/ixgyfo8wQV28G+fGK098epJQfaSihRbc/
         Z7yFqYuINxQUTqydgiRkxKLOW/jnAYc4NYH+DbTNwkobImuDcnIGAwYt1DoW4lcDhdH8
         G96uFuBSJ1XZpU393B6aLOsyLMicp7d25PPyry1je6mCnOlfTmCXHGubZ3Z/fz6O9saR
         tdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294744; x=1795899544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8EnvzJ5YZjtvRaJCKukaMvA/8E4qxQ4MuL3qpPCkI0E=;
        b=cxm0e6EsKi8CNR1MsWmctM+nDtb1y3lTFfkrlr/lYnNk6Jpdg5Mx6CbwYpjydQ8Q4j
         jSxb/4OQH4kxczGFlBfBIOG2bEG3lX2oYouaH0PD5YbpJK0Zep/BVPkbV7/a0Nb+mVR/
         fv6bidYU9s13z+7KHBeZaCA4xbgXVKAomvBvqIkiFHhy7z6H/ZWIyLhSlG924SfkTScY
         lYF2E137E9oaRRMJZjklNWd2k5vt/Ok0qfGYYg2VPrJxLZy1JlCv7dsEGMycjEYrgo1W
         nPCmUUo9Kvg6LF4Lr6pKDQwNCdaoBVL6Re6JTVpsxwulJ18/ERX0p7n3JrFPZCCzRKIq
         M+7w==
X-Gm-Message-State: APuU4Z9FRW23trJqXPsr3yzFxr+tTpG6PhjZnq9tXfpiPbSsexAN97my
	a21Li6EwMHSs0xhcIgnQIdnWGtUNW15ePoY6Lqr6dDzrEOFS8whOZ1/PhC5zug==
X-Gm-Gg: AZFdTZdIKmApqAWcO4c/inymz6qKs1ZeO9Crm+/FcJvT6+luYmxIAJOyQ5JVKEdgA6S
	DxYleir3wxHM38/KbJA74aHryxu8CXPnvBGnL1X8iRH7aGjzs3pMori3WcQz3F9tzNI5cFt0m+C
	AsYyKIQxDjRydjVfULlDfGF25mYg/GYSLgk09DRMPwVLJVsQ8q1qxRWU8aJ5GzSenn+PtjqTYiD
	mfXGe1Yj3e7nAEJ31z/lCJW0ZeOZzlGboJ2Dq9j2s+qJ0uoEgktMb0tMvCY+tuWdKqgtuiBm+1G
	dQo5cu7DWFvlXkud+5Wl/bKqowqm4zBoZKoO/2ODIOEY+i1KVtLilqoqj35Bi6qtrIbgH6wixUT
	s2LdKjp4xUZ2vV5HXXv/hbIgMBSGl/zuJ90NLtAcXHASpvkqZWrmfMjeJ+5xIa9n3cZGQZ8Ctmn
	dfUr/GrYjTbLD6f2HO3q7NYHAVt6EowxJKLTNUqA2P83DlxqK8Lp3TeLDzVb8h2WsBKyLNefTGv
	wt2HHQXIadjId0ZDJaFbEM/r3PMW1URXT82VPqjzcONAP2ocxzHT6Vuxuxkob0ml9c/EIZNrJkH
	/oRKq/QW9KvLcBz2qTPmz6Ty8UVSBQfQUbAuCCpOUpmNgkK7Q94=
X-Received: by 2002:a17:90b:1f91:b0:3b4:1cb1:e7ae with SMTP id 98e67ed59e1d1-3b41cb1e88bmr7560123a91.45.1795294744534;
        Sat, 21 Nov 2026 12:59:04 -0800 (PST)
Received: from fedora.tail791dd8.ts.net ([2601:1c0:4300:57a:5830:187:53e3:add2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm2751587a91.3.2026.11.21.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:59:04 -0800 (PST)
From: Dylan MacKenzie <ecstaticmorse@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dylan MacKenzie <ecstaticmorse@gmail.com>
Subject: [PATCH BlueZ 1/2] device: Add btd_device_get_disconnect_reason
Date: Sat, 21 Nov 2026 12:58:34 -0800
Message-ID: <20261121205835.381239-2-ecstaticmorse@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121205835.381239-1-ecstaticmorse@gmail.com>
References: <20261121205835.381239-1-ecstaticmorse@gmail.com>
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

Keep the reason of the last disconnection in the bearer state and add
btd_device_get_disconnect_reason so it can be queried per bearer. The
new field takes the place of padding so struct bearer_state does not
grow.

Assisted-by: Claude:claude-fable-5-2
---
 src/device.c | 7 +++++++
 src/device.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/src/device.c b/src/device.c
index 36a980d1e..720b4af69 100644
--- a/src/device.c
+++ b/src/device.c
@@ -155,6 +155,7 @@ struct bearer_state {
 	bool svc_resolved;
 	bool initiator;
 	bool connectable;
+	uint8_t disconn_reason;
 	time_t last_seen;
 	time_t last_used;
 };
@@ -3864,6 +3865,11 @@ bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type)
 	return dev->le_state.connected;
 }
 
+uint8_t btd_device_get_disconnect_reason(struct btd_device *dev, uint8_t type)
+{
+	return get_state(dev, type)->disconn_reason;
+}
+
 bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type)
 {
 	if (type == BDADDR_BREDR)
@@ -4071,6 +4077,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 
 	state->connected = false;
 	state->initiator = false;
+	state->disconn_reason = reason;
 	device->general_connect = FALSE;
 
 	device_set_svc_refreshed(device, false);
diff --git a/src/device.h b/src/device.h
index 047a894c3..4527c16d1 100644
--- a/src/device.h
+++ b/src/device.h
@@ -127,6 +127,7 @@ void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
 bool btd_device_bearer_is_connected(struct btd_device *dev);
 bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type);
+uint8_t btd_device_get_disconnect_reason(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_seen(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_initiator(struct btd_device *dev, uint8_t type);
-- 
2.56.0


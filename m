Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530971;
	b=hLtqrOCA2oObJAb3Dfg60uP7HME9sldcpCJuLOLJ7757ACbgt6pnf2APtB+NP+SBcVE7
	 g+vx2pS6iuZp2Yh9MjnDXRrweI8t2dQZmVn0Evzmob4wv4a/Dohq3H7ZqlOR8eE8jhEuv
	 hMxQRLziHF9bESPvWDU+pvcGtgi+71Pj/bYlClz0NPt9WaMjO5/B5aNgrRPvSkgnDesdK
	 /UQfOMzbpNVrXHvPx/8lJ8retOFNkA2FEdDR4mgLXOL3W0JITo6MF7/DqyBuEqtQNQIJU
	 aPI1YbbeNjyzilBLMFsnoslZy+uxdZOMcauFTEIeY2ohUpMtM3/atSLJF4HxEVReVxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=URzeZgeOfG4XSpkC4U3RADPq0CdA4uG4IJ6mQI+mVOU=;
	b=DPerKNbgbiUe8rn98td8XazJkFaSb+dpsRfK1UbgLIv7W7V4uRgD/n+MCw0Ue9SrM3J6
	 ehL9gHIoMcbZ1cK+XtW1pS7pXPMfc1C98RUnYjl6g4m7XqDLK6y5rqdeH29PUKz1V4/0R
	 aFZ9wxJhi5yJAYJKhEI4PXi7eA9OF7jbQcOCXCVIcDhgtaRB2UqdZLXKu1L54eLzB/Jc8
	 BZbyw6yQ6hlxmWM+97LvX8EVLf2KgrUqYsi/+BRP/fJlx+e3P2RbujWLgae3JAomDTLWY
	 c8H5d4ltpH9iYtQRFU8WwgnmqvNkH86OfTnz9HumySj4dstTymD3Jf7ci4LKeydXzxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=xM5JD4Kv;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32FC606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32FC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=xM5JD4Kv
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a42b34e930so4030799f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795530968; x=1796135768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=URzeZgeOfG4XSpkC4U3RADPq0CdA4uG4IJ6mQI+mVOU=;
        b=xM5JD4KvW/JTpJUGk7b1643GPYDAL6WTQgJfIFWv/aKqu0k0R1pPkjnp7OloliZBUZ
         v2c2Z6sFedoWqA/T+eotmshJoog8fGsl9wEs6/a9TLQfbxpT4yY1O20q0LhJh0Iad3g+
         Glcv1i7z+ITKdW8UJCsOGWi8+cwPGjuYQviLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530968; x=1796135768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URzeZgeOfG4XSpkC4U3RADPq0CdA4uG4IJ6mQI+mVOU=;
        b=Oj/8zl42k2vWnqJpzberdXvYQOHdKi32ccflMvr+1pLvRJlY9sfjYZkUBXFtpCe5+Y
         Cl7Y5R2+tZJeW2QodThMwvFW6EbjDNiyfD1eAJua6k7yEGPE2nRhKXLGLhMXbdKRcxXT
         8yt+YHmJWD3CKbSvfkOVeupgvjcdYDWgl7GkiWITLITnUiDw5hwZyJBqh0frCt8infLV
         Yaf4/y2xLduR6Yu7t891XsOIV7IXq1+L8kF+Bnz+C/u62Btx7SFHNLH18KLFisKdLA0x
         4OlFO680T4BMtV5TTHq4HE/ueaDdyyFVJKKtXqPcIsPLVmtOo1BivoLg+Ce3amU0iJJA
         JcmA==
X-Gm-Message-State: APuU4Z//gIwwop2K28mXT4ye7kAh6+udYKDsw3OeslSGQb5Mvg64TY9/
	A0AnYcFafaTDmTIFzoaGdCQF2VWiQZ11ncAdYpTdA8ioLdWgwu9anYUvxeYTCxHGVoispNdNv53
	9j5aE
X-Gm-Gg: AZFdTZeakq5f6SfElsWKgbGNRpyH7dI1gZfMgnFTHTbkKd/TxvIJi6I07a4J8rREtEA
	TNVSbbFay4YKtL2buxiSJjKVillte+fBR5C/fe/+UC84l9MysTrLa+VrqKQXqd68lZyHZsdYhwZ
	lPvpsgOB6amp694VN/cv+5IBQR/GPLBQu3XIJGpOpBzGVg6742Lx5Ulh/WdkqkPi29Um1z+H/5M
	pg+7MIwjqk/UFTjhs8YHHK0sMueAqmV1n1644wbH+iQtz9kQYTOGJCnV3b9UB42GRX8lnDv8uhw
	oL5gYAorkpaTDBY9K6FVmT3JrXWZ7TyhBzW6vN0Q5PzDmBzQyNAKM4890Pl8McpQN+uiRFtK6Zq
	R3noB8uMga45uSejm14M7YfsaZCaFOvGuxocDV7TSEo9PRzXdUXZEO95TYskOdAvQj6TXGAJMux
	z2MmtKHCudmq8cZ7OdjLz0FNl8P04VttxzOAG3zmmIdureu+6qVuKB3vI+HTbCVXktGkjbcWSJu
	YZQpexFjIkCj9JE1xkjReHutbZYL/RQIUokVjg+djoLGK+ClS5RZMl7JHwsVtc+WO5q9HWAKr5i
	idaIMgAdbEcE0GDhd5M8lIBGB0rUh9ok2v71ZvJVDaex9jT3ZQ==
X-Received: by 2002:a5d:5f85:0:b0:4a7:1613:7206 with SMTP id ffacd0b85a97d-4abb57f7b6fmr29554086f8f.47.1795530968067;
        Tue, 24 Nov 2026 06:36:08 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b33a596f9csm9019187f8f.12.2026.11.24.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:36:07 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/3] shared/vcp: Notify Volume State on Mute
Date: Tue, 24 Nov 2026 15:35:59 +0100
Message-ID: <20261124143601.245340-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

A Mute operation on the Volume Control Point sets Mute and increments
Change_Counter, but unlike every other operation it does not notify
Volume State. A client that keeps Change_Counter from the notifications
then writes its next operation with a stale value and gets Invalid
Change Counter.

Fixes: b8a113ecbabc ("shared/vcp: Add initial code for handling VCP")
Assisted-by: Claude:claude-opus-5-5
---
 src/shared/vcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index c7f74956e..d19bd9210 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -861,6 +861,9 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->mute = 0x01;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
+				 sizeof(struct vol_state),
+				 bt_vcp_get_att(vcp));
 	return 0;
 }
 

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0


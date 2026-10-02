Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3F3DDAE2
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919986; cv=none; b=THBKLHhP/TcFSpn54TugvR2Hk06bcFPlHSUJQAnfxIcRv/2sqLxpIxHSN76ALZZxfYxGFOsOuiX3tn3HCFbhOyiqms2GNZW78UwwFo9g7Jnsi/u1eoSfKGyL5maUS7FNjRzmuiyQA3ok5PgEfEmSJA+92PARVrRzXCcm20tgY8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919986; c=relaxed/simple;
	bh=pb3GJG/LMQ/1y3HqoY14g3mXP1VosRVKWMq+L0NMn1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNF2FtmLJF63E83Pl4xtp3n03x1lq2YhaB6DexLLmZ4z+ITdG/8ulWoVjgfywa7BSNucsTPD6SXRzHxm5Xvq8qwbxx55laXnKLXAYbutoruSHYVvW0UITfQXnd1KzolWYUNQlHYYF5wUWCtMcCNtV2lxIsV3BvWXy3M8+VbjTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=QXNeWSxG; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="QXNeWSxG"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34ea0b83f8fso748241eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790919984; x=1791524784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5BbI6WtyvWtQMf3zL7HGzZrizBia6n0Yj8lDtVXl+Sc=;
        b=QXNeWSxGfqVbASMoXsP3zxlXYS+svjxSEstg8qprZ3DnmxfdCVaK0dJA7qAS9Bskhr
         8XMcAPMKxht+3DLGNXkldvC0ksKc4r9cmU/n7DxHUlzGwMamPYHoN+ZR9IS7rfVlyL8a
         PKnoZQDcap9pfHBn94sd4pzhJNbFMv9DLxvWYuL28KS91/fKpaByrAo4bhfwis8EIt/l
         4QKaoIy/dSVGPpfzdmIS+8G9OF+fRCearMI1gjeaOpDmBYtKJYfsg/bxO1ipt43KCEeN
         i5TGUabzKLpTTW1QmLT/6yDerqxrDbypp6yxUzXZ/1LQAqiHYFcUduo6xOGCdY0BAA0V
         sEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919984; x=1791524784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5BbI6WtyvWtQMf3zL7HGzZrizBia6n0Yj8lDtVXl+Sc=;
        b=RnYcpCqYQN6tCZeinSzdyfOG7ixKUjF/PHzkohmte/3ECT4CYDZRCyG9sB/iM227Up
         j98BUcHfA3wYcCDiUIZj/Rt94NjOatE/8MQA9oKhDE5ozOqGaTJu+bPNH6gfEKcwyQyc
         /LtiQoOuX4TPoPRVOebyi5V/iujwzIP2DUG9mw8NT8zERVIj8CxWCOf95ILNwo0bcYUw
         NypWsJVA/zRxOhfy/zDN4iEwTynnP+at91DjQYhOIpkNCMfAKo4uI2Cxpxff13xMExtI
         RrdVqUt5i30/8kSaSYjvEFlf9D6Liyso5ntwcn4xn7GfRuUhtRo7Rb3qJU/XmvUMOZ0p
         E7Vw==
X-Gm-Message-State: AFq9FYJ6jEZNrKCTRG9YlbBg0C69Kswx2JfR7EO+1U1fuXK/vPVm5ofD
	kYGExeQiU3TGmtRBnteBSVVT5MWIG9dxEH5X1+iA1Dc9l2a0xg8qy74tSMIBT/VzDLtevxlhIMS
	mcZmDlqk=
X-Gm-Gg: AYBFou06xZOgqpbxyL+LR6NUwzFq+uueKYCtCMgphG4oADgTmxBlf1MuRo1XwGh23ut
	NTtgZVNmmF+XupaQolLwBqljDBq1xfg3qJ4QGWkRZVG9b5rofAKg993O2YQlLVjScFw02ghL3nU
	urF+deN2mTjpA5GAlr3rCmyJZOw4nzlFgF10UQV2FMb5cW4+WSAJeukD0gZ0EsSYDkNXDCGM8Ct
	Dj36Uk1kqFsbY6+rSI2PTIqQXvazy4pQWXY3IXrtMc5b9bOQlCjh7Xhe18BRZ7VQYv/+zOO8yPv
	kPFCkxJrft76/RIQhBiHJoKeIrJMjcNSn3mTwVUagtWtJ+gx8AJV2Pxyg9FG9UMM3UrzIgfZ7ka
	vb7aXH59ShVi6y7xdRB3YdBIK+zScIk0CNDPzL1JWL3w0PylITBIo6oFib9j2lQdsZIG86HKrmF
	8mt9f7w4nvB/VJB0iHLTePeQ0TTb5VHykoqhtJweDXpPc6m3tcaf+e96JbzOEh1vCG2nDf2wSPn
	Se2gJSYXl3YoTFfAoljAj1eOazCtGi4YYlbKXLHpd00LqVCSQBRUkZvZYYVI5Vtf88AvrF5BmB4
	l4ZgiwAIJy3xNpMCLBFhuFcLJyJmDAIqFSoEsOFr
X-Received: by 2002:a05:7301:1a02:b0:34c:ef16:c669 with SMTP id 5a478bee46e88-34f150d9629mr1790420eec.18.1790919983847;
        Thu, 01 Oct 2026 22:46:23 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm3064217eec.29.2026.10.01.22.46.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 22:46:23 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 1/6] org.bluez.Device: Add Connectable property
Date: Thu,  1 Oct 2026 22:46:12 -0700
Message-ID: <20261002054618.30994-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002054618.30994-1-kevin@simpleble.org>
References: <20261002054618.30994-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds Connectable property which indicates whether the remote
device accepts connections, as reported by its last advertising report
or inquiry result.

bluetoothd already tracks this per bearer from the Device Found event,
but it is not exposed over D-Bus, so applications cannot tell
connectable advertisers such as peripherals from non-connectable ones
such as beacons without attempting a connection.
---
 doc/org.bluez.Device.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 3e6a30a..3df75f0 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -395,6 +395,17 @@ int16 TxPower [readonly, optional]
 
 Advertised transmitted power level (inquiry or advertising).
 
+boolean Connectable [readonly, optional]
+````````````````````````````````````````
+
+Indicates whether the remote device accepts connections, based on the most
+recent advertising report or inquiry result. For LE this is false when the
+last advertising report was non-connectable, e.g. ADV_NONCONN_IND or
+ADV_SCAN_IND.
+
+BR/EDR devices are always considered connectable. LE devices only have this
+property once they have been discovered or connected.
+
 dict ManufacturerData [readonly, optional]
 ``````````````````````````````````````````
 
-- 
2.54.0 (Apple Git-157)


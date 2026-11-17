Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794887391;
	b=VTR0QW70nRopiz8caXjyUITsvZ65/rFrugnCL2Anb9SDFxqeV15Rt95yK6Mp92IAIdrg
	 DQY3+xE9WyZa5vHGXmEbCx6FX2lU+9woWsYYgAep04A7mEUQ157l8HyznT+tWKm7dxP3n
	 lPQrLA5qonot2genUEtu/Gtw65P0AVgAvaYwKi64DqAyb+rkLe5QxdVFVB+qxdRTj5xGn
	 u/ca1UG0OrbNt0IsUROV0RJR2cLuXIkSaXpwua/mV6K6MVfCV7wqwSFb6KakQxUPQDBlT
	 TdpNxdTP3BL+rzBfRBwyi5BHZH2yp7RT/tUdP8Ke8zVSyUl/6HAI9WYy1TjN8569QAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RRfNWo7QpY2x+rpM47udJSSCiW+Ce4+mjWwNqpYTpZQ=;
	b=uY0M2RsjhiS/zi9OFJ7FAKSk3X1eEjJXeu7G9pL3IFDSfUTE3gldIzNS0EzwtIuWOHnl
	 orBrYJijgP0TIuYMfPR0MhqPLBwHouXyW1kS8YOpW77nLpZfVwysueTSTpW/U/pvyDlxN
	 Oq+g6/1HvyfHT8zExLZe8eyYG4z5s6gob292PIijkH5LQAFVBVBvvNwngjT+yautJ39r/
	 9omP8xZrmqQAicwx+UOlOUGvKEOeC3Bo5I6aCwkORskrz3RlX+lyBky8QwSJuYbzNnodh
	 scs3v8C8JCvtx1Sto+lzR+n7Z0zcXkL0dwxHvlpU7yDuzD6VxxBvXIAGwfG/yjLmQrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=McDxFBhB;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC9606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 03:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BAC9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=McDxFBhB
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6798eb0d190so3070204d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 19:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794887389; x=1795492189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRfNWo7QpY2x+rpM47udJSSCiW+Ce4+mjWwNqpYTpZQ=;
        b=McDxFBhB6Log5D5VyjNDBUQFQ4SUCCG6L0Uc1yzkukzzhDtE3m9iEwIuh182cb8hKG
         p7ufeb57SrxlCttBBNFhkP3ia4e2o+rGrMNv8tsSJaD0X0RYUIKNjy/KtJVccbV1B2BT
         V2s728GkipBMEYF78J2/tsgxmbFx32stZUae6P5uxLNhZhlYudP0SgIo1ExyRpV3lAFu
         +YaVgkISbgQ+oyXdJTmd+XZ4NrKbv+NiwnBff9XUi11n6btgX0HDN6mLrVPGmnCm0tXp
         BKtAiFZYF+/zhBZebn5oYwDPW1EqKYhQuQg++Dl5dYItQtltmwEHoR+4SRy+m+e0i7SJ
         VvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794887389; x=1795492189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRfNWo7QpY2x+rpM47udJSSCiW+Ce4+mjWwNqpYTpZQ=;
        b=wAEpLTO21+HR1bNL+Y6xnPeXkcB+DaSsGXp6EHaQzASsM+xuYHXMyzrpJ8SVInFnJ/
         r+93HFqpk6H+LxY0UhV1gWkYhGAXfTGWjC2czk6OMnMVMDvKPOUhAipRzRvAZ0HTcP72
         UJTjBLiA0J4YnQ0TZ0frQwHRCh8rt1F+W1e56nsI6jmW+RYPd9XUVeL4xXY9bWeVoea3
         7Hu7acPKDUvTVA+qiGmMpRizAOW9SVAIfYkwryGAzQbo3jJWP5432ofqMB8o1etaNL1K
         5wQ+Pp6MVasbUrpdNCO7RSMzItY09rheauYSppSvAz4KROz63rYfHxkWXIbylk9eePmU
         O9tw==
X-Forwarded-Encrypted: i=1; AL+hErFyZdEZC2a/lWu+N7MfqXt7fgd1+8urZd1wxI0xCOao3IHwtmYPkXC6TmPsPUVQWz2V8mx5BDuu9aRd1SItQd4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BKoH2Jn54cXL2JSjQ6HLGkuUGHLIyrBJ5k2bmtqxjGyvYdljR
	ssYg+/l4WE8qBUZZ4QCjTJLuhhSG8GCpW0r2WfZ5VBpBapRWTjqbW1EaCxG9Nw==
X-Gm-Gg: AZFdTZemBmkQJs3iW2ObTgxCqhiZBwfeoUVTLODvm8GxhVtDIVPl+CbCFKS1S305Uum
	3DnnT44xvrmbMU94bGMosqHj6Hd37vqVttMsQ5RXjdnIbv2Rsc7EPlVRN5O1VwxCvlVkdc+X8d8
	oCvLqx2aqodb5WfdVZCsbY7W6LoIjotv4kieDYEEiXhHDPtryxnVIUKYGjjSgx3VOa70MnUAEhH
	4cWmQL6CycxrMt5ksY0RBw6Gv8INalJwu06wFSG7KQJvTZqKGvU+VXqZfbOYQ3Mjk38kpAuU6M0
	IsJXuds9sPzGhuEYvtOTmf4tvTb9Kd8oNO8Ymd7FP0FNZhJToRDqHR9q5T48TxXeo/ZtAhvuNut
	x8rB4pPY5buD88VBdcHowyBko5sPWTPJXDkubogkQ99F16x1P7HSyZW19Dj9Ou113BuMSh/TDC2
	qCYuchgK4HjF9k8ZClcVze1zwn9DhZd9tg1jltooxT8ukVsH9aIYMNtUzSQzdMJXF3kncPl8uGh
	3Cfnm1qh3efTTgv5wLla52le3qaNacKYEK8RkfBbTBLxfbsCRYb2VO76olLUd4fNqezTYIrQDDh
	2Nn5u6vlgPzAzrsfFNz+jLLwBLHKiP7sLWlG7SSJ7IdsD9gQZ6T3cv//95YlzrTK1xPB7uZONGi
	WaAIyHFRCIKdYHBVyFzQNiR0qtd/Si8jG8SXMlaxoSQzUUG7a0qhyxKl0unRR/K6pjVnApSIoiW
	M/2OR2FLFOaDBjf4D6j95E5yHjYgdZSxQ7w2I5f9FEJFy1wLMzA+eV2pq+jpn5+uTqh67m1Zqcu
	ZZSfFUYzDRiWh5dC+8=
X-Received: by 2002:a53:c0c6:0:b0:679:b50e:9a with SMTP id 956f58d0204a3-67d897d8ed6mr5566347d50.108.1794887389272;
        Mon, 16 Nov 2026 19:49:49 -0800 (PST)
Received: from localhost.localdomain (104-12-105-135.lightspeed.miamfl.sbcglobal.net. [104.12.105.135])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec306904sm15108597b3.43.2026.11.16.19.49.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 19:49:48 -0800 (PST)
From: Jason Perlow <jperlow@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jason Perlow <jperlow@gmail.com>
Subject: [PATCH RESEND] Bluetooth: btbcm: Add entries for BCM4364B3 UART Bluetooth
Date: Mon, 16 Nov 2026 22:49:47 -0500
Message-ID: <20261117034947.14803-1-jperlow@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The BCM4364B3 combo chip on Apple T2 Macs, e.g. the MacBookPro16,1, has a
UART Bluetooth controller that reports LMP subversion 0x3032 (001.016.050)
on some units and 0x305b (001.016.091) on others.  Neither has an entry in
bcm_uart_subver_table, so the controller is logged without a name:

  Bluetooth: hci0: BCM4364B3 Trinidad Olympic GEN (MFG)
  Bluetooth: hci0: BCM (001.016.091) build 0115

and the firmware lookup only tries the generic "brcm/BCM.hcd".

Add both subversions so the controller is named and its firmware is looked
up as "brcm/BCM4364B3.hcd" first.  Tested on two MacBookPro16,1 with a
v7.4-rc3 based kernel carrying an equivalent change, one reporting 0x3032
and one reporting 0x305b.  They now log:

  Bluetooth: hci0: BCM4364B3 (001.016.050) build 0082
  Bluetooth: hci0: BCM4364B3 (001.016.091) build 0115

Signed-off-by: Jason Perlow <jperlow@gmail.com>
---
Resend: the first copy was line-wrapped by my mail client and did not apply.
This one is sent with git send-email. No other changes.

 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 065536d4ec..92ba7aeac3 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -519,6 +519,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
 	{ 0x2128, "BCM4384A0"	},	/* 001.001.040 */
 	{ 0x4119, "BCM4384B0"	},	/* 002.001.025 */
+	{ 0x3032, "BCM4364B3"	},	/* 001.016.050 */
+	{ 0x305b, "BCM4364B3"	},	/* 001.016.091 */
 	{ }
 };
 
-- 
2.56.0


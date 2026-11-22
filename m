Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375155;
	b=HDIaq+RHTQr9j8CmIpWkLu7+GmZe0pCGAVBawYJu8UHoQqgmNjQrAzK86lIG4EppDrEh
	 TBYze7n/xsgxNO17bY7zwY8bSQIrDNFNPLLpTxraO+wk4F2IVCDqS9aNemDQf1BcqZ8fb
	 IJLKNX1u5RX4GPHzq8UcEsFAVSlmYiPsqk2kL3F2dDQbLvmet6juZgykRZRqnfudpFBza
	 5WUth4BjH7ucNbOrgZGVBNotq7kobOOvs2O2SreF3bdL4+HnXS8zRWegTIhP34yTwiygG
	 WJ87EjO0tGRZngkWr40MYoRJ540g+4x/IiATi6qhKgNSynR/7URmDJ24NJbER8VuAsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oTxl/2wdr9ban2f4H8kkyklf82cti8+hV2RwnX/JVlY=;
	b=HElcHp/0jfJsLSguLVKnEH5Leg0ROZdQFCjnhQnU0qN1+brpkzCduv5bHATM+VXxubQh
	 HUrTui167v3x0Vx2rZvj2Hd1ZDIJU32XpO/YI9cq2r2O/6NI3BRUcKx4ag6dKxHh+yWVD
	 ZTwpxyjTzfz+FsGzIu59nYu0SxiNsvLn0CnTzQ+gld86GqIq7B+v5nJc2ywS/5XClwqpV
	 rF+dMY0ZL92L00N6EMOHCu9v9ozcRNVoSehOBZ1YMhKrrQLO6toW0Loc0WVcv2zaXehSE
	 yNuMvGYY8gd7y4+JQ/cl2kjQerTpvBxFJT39msNGQoqmkPtc2dJ588RUPOwgXnLRRIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=eiTWEQ5L;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6964606A31E
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6964606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=eiTWEQ5L
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so19448865e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795375153; x=1795979953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTxl/2wdr9ban2f4H8kkyklf82cti8+hV2RwnX/JVlY=;
        b=eiTWEQ5L5fcz1aLxGQqGqX9RM9c9f98w0EqJacmmTzQAY9dq54HqA+Y/wF7gC6fd2P
         I79tCbN4HqluOjjShtvlBjeKVZL2qQ7/lPsmpUdcptYu8eQpO4c1CSYCERCW1sHmtyiD
         8gTtuvTRffQGeOE9Ci4XRhGOD2xq402ExiIZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375153; x=1795979953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTxl/2wdr9ban2f4H8kkyklf82cti8+hV2RwnX/JVlY=;
        b=UbrUMtdVAIM9zkruHTOul4hfCyKMb3rOtRPYu0ABalC0RXnSlk/5nlCi8e05VexWjh
         W8KIUxhkQv4zyBX0xL7a2c+rqzYptjyN75GvcXDi0vaSANFIfxbecaYeY+YF3BrET9dn
         tvtDLzEWeLp6MXgXmdbb/XiOtO+M3wJyeC6mh4LAIxxAlnnfIv2+E7q8NoH6DmQZpmYo
         jCcgqpGnA+ZCMBQCEWDqYDMz1SMCbjhI9uhY2rkgsLZTYK6aI3QAwPPgnTG2o0lIIvW4
         jVaHMiYkxelzIkQyBfvfgSG/BeJWB8z7Inrbuvhu4PzYicGoZ3CVaOLvDkE6nKQT2K8b
         QnZw==
X-Gm-Message-State: APuU4Z+5rD0zIqCfzZlqkow7pqgf+xu6Cr4AC12/SbqVKDY5YIMpTIiw
	nhmcuUB4IfdIsg0A2zVlMZJOdtm7+GUvXhIBx6pD13g9FYYIms+eCR5r8ZWQwMIxB4Dr6IqP2pg
	0Mppn
X-Gm-Gg: AZFdTZeRJ/9x05H3HCL8xx2ou931Mc+mF75BK0t4ifEEg/I9+nPQBb5NACDxb43wqTW
	lQHELw6vnYKr06/1bx200m80GfrzogstTZGfPInkLM93oxiFlfXX9QQmxQRUehlvXv0nyIlAnLv
	vbBZfUkoQcjKEsGkIf+0FctmfgodZG1aD9i9awqIY3r9owQRKh2KqQ0BIu6yjkwL+/kmcMmTzkT
	hZuEqGq2tVlLSgcoUmL1sDRC1J9WqS5Ms6sFnYR/fn/snDmKfGhM1RHA34encgVa+3WRoS8fxVd
	i/+oDOTfPHkdvq4gVhzf07MFGOvBZDcK8To6wRqV9vSzPaUM2MxPal9Lq2rHy+tyr/N/NWw8Gzp
	Xtkl68vuTSVnKypzi+VXOfc6rcnhkczvSlqEttg4n6qB44QG+X54N/KGRz4muUwiq7P1f0fefmt
	D2JH8s5TlVzzjQnMEuDgT5zvGO0pxmFzrt0xPHZ+o1n+wZ6kf/oTweAT3o89qrIfYVrsQ8tQxiH
	+gpzVDFGDausGQPYNd3SRtjxwnZNX1ZP2g6RwRjnAXKvZPeeGdVkwcXQUrrKNri+8N1PrQo3rkF
	k1SJCQ7fnEOBah9/j4Z2eR66WSPpZmIM8EKjEj/oHi0wbcUpug==
X-Received: by 2002:a05:600c:5249:b0:4bb:665c:a078 with SMTP id 5b1f17b1804b1-4bb8893a89bmr195073025e9.28.1795375153180;
        Sun, 22 Nov 2026 11:19:13 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9065744esm110235825e9.1.2026.11.22.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:19:12 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_sync: Don't enable instance 0 on Set Connectable
Date: Sun, 22 Nov 2026 20:19:04 +0100
Message-ID: <20261122191904.2261177-1-simon.mikuda@streamunlimited.com>
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

After the current advertising instance is removed, cur_adv_instance
is 0. On an extended advertising controller the next Set Connectable
then starts advertising instance 0, although the Advertising setting
is off.

Steps to reproduce, on a controller with extended advertising and
bluetoothd stopped:

  btmgmt advertising off
  btmgmt connectable off
  btmgmt add-adv -d 06097465737431 1
  btmgmt add-adv -d 06097465737432 2
  btmgmt rm-adv 2
  btmgmt connectable on

btmon shows LE Set Extended Advertising Enable for Handle 0x00.

Only update the advertising parameters when the Advertising setting is
on or there is a current instance.

Fixes: de181e887ac2 ("Bluetooth: Impmlement extended adv enable")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
Changes in v2:
previous patch was written for an older kernel

since 1bfecdbd0317 cur_adv_instance is set when an instance is enabled, so the
bug now only shows after the current instance is removed, and the reproducer
is updated to that case.

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 638589f77081..2ff2511d8c3d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6649,7 +6649,7 @@ int hci_update_connectable_sync(struct hci_dev *hdev)
 
 	/* Update the advertising parameters if necessary */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !list_empty(&hdev->adv_instances)) {
+	    hdev->cur_adv_instance) {
 		if (ext_adv_capable(hdev))
 			err = hci_start_ext_adv_sync(hdev,
 						     hdev->cur_adv_instance);

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0


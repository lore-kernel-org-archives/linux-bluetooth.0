Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946842;
	b=Iupl1Ai87ToH5IS6hHtW4maa30hTiAwfMf+c2toM5vZ3lfa7YkWWU+zU97bNpOO5BWMC
	 PieH7mL6F5dKRd45nwx3ErRTW6DZB67gQs6ujxXM9sQBL3DLkFcuA9k+by/PMxRAV+Z9j
	 N30vot4lQkX22jpQLAnB7dSp3MTU2HC1DXycWdATBSzcHjKaO19Ev7/AYYX6ympZv1Xl6
	 6ErmvpiEc4Y6xlLOerHf9JTaFzKGgAEOnFmKIuERU007OE+Qg0dm/vyqtOG/fL5nj9ON8
	 yPh3Nkc9rw2KHb7GPyK63mU/p5bzRO6N4tEYjQICXT1XIMGsY13MLdrseo26/vu/nkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
	b=1QhK6IXG4hrj5KVnLmH/keXWJc4nsFbnjXU3Caf+LQGMlFkMRHmo60fY8CpBpF2VR5Pl
	 cRT9NfVRVibRyjeuIBzj8fhlSUEhVc5w8hCVocSZWn3Iz79glch0FTbx6/qQYlwGnUNAG
	 W7BgR7KV3EC4JTNUCT4rJC0qlaseB1iKgjL1uUee4+PjV3nz9t16WsZ91UE0+Tr15FpNJ
	 Ll5aWJaHsb5V4N3rqvo1MYQe+wKTXR6EHkBL6ccr4jrvsF+vGMMmV4OZJXZ5KKKynhEJZ
	 XoeezwAMvh95j7bNp3Ya/NbV5OSrxlCZ6aoLhxHtYF3FXZyd1zAXU9GFigYKeJ59VGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xw0J6inM;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80040606A33B
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80040606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xw0J6inM
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso130189241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946841; x=1795551641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
        b=Xw0J6inM3PXH5c68cYzH+3ns9jNUymDS/LxLtu38KEjBo3UCyaxNH9kaZJgfAg9WBi
         MajVA/wz+J2Zk57z6Vl56pcEC2/T8/eod+fKjPPXtaBvkoV1z7f04qvabQqpG8P8OlyR
         m+pc0XacNjy9wqJ2IAxhY20ubJJ74gxFVk9RW2CJNqiG3cVJ/6HtowuM4Aei08YHF4za
         uqBlJxZ9o+8Y4exejAtYYlsImukqolo2BSFUk9WuJb1m3eHg/RuC+w02BgvqIjnOtm8m
         //MBr8eVEBVv5cAVf8EH5nJb2XHBn7k35r0sFQaUq/y5fKKnMOX/X5izHpM102g+cxEX
         lBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946841; x=1795551641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
        b=NUpVjLTG88UISTNHuH7pjAbbaREDzRb+AZf61z0+OJxOkrrVyhgvq9FhTNPG1JefvR
         GH01Jy5ldFnEGIi1plWb+jpycqe2P2YDGm5atLi8YRDeP2pYENqJqOT/h2zryabkzTcr
         L9z1C70ZE3N6lg+xULXi5bnyWkoLccHBsa1DU2iATDEmGsb5QivrMPiqeZBeB58wT//G
         nV6LiYy3Zz6SmvyCrdBdQk43+jMuG1E8S34G1J/xRN/eSBaLfvFbyj8+gVizCio/+tkp
         guJGZ9wd4bCwu1/QEL60p0v6+CgMnoJeV4jSpbqE5EZgqkBMsMXlS6q7gnXAPblcXsYZ
         nqmg==
X-Gm-Message-State: APuU4Z/tVxojY/r4M8UC7xyIz1feu1D5jKfbNj4gehJ+IAPyg4sh7GRr
	q7og1Hdr6psSzZm1SdRgoqI3a5kOFAUYwZEgIF58VnWc1+iBohwq5TpyXUHuyA==
X-Gm-Gg: AYBFou2WiVzRxifcouQOECApf9M33HXD68FYUeIez4K9HktQt2grXrYidlaZmU2PUjt
	GnFHl1E6icgcv3D7sKsIHsPmo7fDyC3ZcuRV8u38HUSHmdQ3GF4PV3Qh4hogoVhxpZQWGeTMn/A
	x6FCzMohyWhowy4bSbX8hyUpBG6Uzi5zTXVFa1/LUF6SuNf3e2yFi2pM9fFT/sz0TJlXv/9A0gy
	8V7L/An2DH4W3EU5x3ePikiXX6/L3xHnmRE6dGNaWOh3uVj/TAXAfqNOy2IO4jLHQ8P9rnJycRe
	0GCbulxRGA9+T3sbAG7acjXMEII7HPBNawK/OZJ/WBXFr2Yja0U2MyxiMxnaWBbkb7tbL8nDihH
	dJWSDZUls/ZiBj/eCXJjF+bKW8EXpwPAEYROvgAhtgb4le8LMtbNRBXDfGFjQ6RHmiHpgzp6hTM
	cLQ/dLnzA1lBJ+e4rVfvgg2ZkUYLehxghGoJ2mRlzDilT4FL9UhU2gToJWGisZzTaOSScfiCFty
	dQTF9uNybW1kNfVW0VUGUcFrKOEYwh2azxEuqKdusYQtsczUauAqRtVHAWaQZwmBl2IbiorPj9W
	zgZoLtsPLFPQoaeYfuZ7ENutVOJgZgebuc3Q9G+jIiMfLGF0M/n9ojAIn82UeL8zALYCr1u4nDz
	r+3dXZXJCceCIzAosB4rfLY2kzDol6x/KRFaRMSSjVBIyZ8R+LAl+H6jHi02CQlmVCg2PULYaP/
	7yhtc=
X-Received: by 2002:a05:6102:54a6:b0:7d6:6732:6cee with SMTP id ada2fe7eead31-7d6ba42be16mr49781137.20.1794946841308;
        Tue, 17 Nov 2026 12:20:41 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/17] Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
Date: Tue, 17 Nov 2026 15:20:22 -0500
Message-ID: <20261117202032.3848411-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

smp_force_bredr() created a BR/EDR SMP channel even when the controller
was powered off or not LE capable, leaving a stale channel that
smp_register() later warns about and leaks. Only create it when SMP is
registered and guard the removal; smp_register() creates it on power on
if the flag is set. Since smp_unregister() runs with hdev->lock take it
around smp_register() as well so they can't race with each other nor with
smp_force_bredr().

Reported-by: sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)
Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c |  2 ++
 net/bluetooth/smp.c      | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a1f272c14a1e..b1925153c2c7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3892,7 +3892,9 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	 * registration is required so that LE SMP can clearly decide if
 	 * the public address or static address is used.
 	 */
+	hci_dev_lock(hdev);
 	smp_register(hdev);
+	hci_dev_unlock(hdev);
 
 	err = hci_write_ssp_mode_sync(hdev, 0x01);
 	if (err)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7e0be869cc74..1c315c9ee7dd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3441,20 +3441,28 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 		return -EALREADY;
 
+	/* The channels are only registered while the controller is powered
+	 * and LE capable. Otherwise just record the flag, smp_register() will
+	 * create the BR/EDR channel on the next power on.
+	 */
 	if (enable) {
 		struct l2cap_chan *chan;
 
-		chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
-		if (IS_ERR(chan))
-			return PTR_ERR(chan);
+		if (hdev->smp_data && !hdev->smp_bredr_data) {
+			chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
+			if (IS_ERR(chan))
+				return PTR_ERR(chan);
 
-		hdev->smp_bredr_data = chan;
+			hdev->smp_bredr_data = chan;
+		}
 	} else {
 		struct l2cap_chan *chan;
 
 		chan = hdev->smp_bredr_data;
-		hdev->smp_bredr_data = NULL;
-		smp_del_chan(chan);
+		if (chan) {
+			hdev->smp_bredr_data = NULL;
+			smp_del_chan(chan);
+		}
 	}
 
 	hci_dev_change_flag(hdev, HCI_FORCE_BREDR_SMP);
-- 
2.56.0


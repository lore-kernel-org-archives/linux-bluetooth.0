Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A01314D13;
	Sun, 11 Oct 2026 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.76.27.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756634; cv=none; b=mYWZueXvCZAxlH2GaPkXAbu/y+myODnO6TS9XnPDfssJYjxh+6bl75n+Kh3JaTqYctDv9Cb61Gqy1iYOeef0omvzheUu6oNoXw2W0hE706Xkqg7MDOPbEqypjjTo9LyqSGOy6ImkQH/vGYK8LZ1AljhjJX/uLTbT3GYbmbUvndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756634; c=relaxed/simple;
	bh=4XH2KoT3HElEz+nZHzi3SwPQrJ4hVPiCerkjSK+aSJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTb+RPNs6LzHu2Z8WrJP6WCQuxaHytyZR/IoQfOef3NGBwmMvwDbUe3+YcxWvAAF3WX+MTaHcOSkLYDwZEfbaQFcDb+YH9zTKrnzmsZGLNPN3fJ7GJl1Qy4ptFLTMAPpOUjTvSIATtTrmjL8bnjf99kM3jLsmgXtS1+Ou47ZkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com; spf=pass smtp.mailfrom=andrei-z.com; dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b=CgC9baxy; arc=none smtp.client-ip=82.76.27.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b="CgC9baxy"
Received: from MAILGW-BIG.big.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id 1F8A38261;
	Mon, 12 Oct 2026 01:10:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=sig1; bh=7pziHWVRSHZW0Z/RoEvp
	QD35adRDOimGigQlE+5mloQ=; b=CgC9baxywxOJNRNL8t8xetGyp1REYTzYB8Qd
	UGBNa9RG3vitSC5gb+msP9qUk7vH8WxIM31CsrJILvi/G4X4k4XFFvfoXcHY+FTn
	Zj9DzB3ubtyeLSD6T6MFofO+o0ax1Uwx0D8c7M6O6p4PH6J9mZdUfbvoT+DFFsaI
	cgBO58yBTnbSbKY2C7XdaLMF7fWC+m8jvafluVZkA7Ojtu1VJF+mchhoQHHlRtlq
	pHruXoeE8x1Tb2Y31jl8TC8WBWx1v1N5MnHn04eHMMAr5+i96WiG0TWQWNs6tzSo
	+cSSxektlzZHf+K5kv5+I4HgTV6swp4fW8cHgk5glkDZNmrjsQ==
Received: from VTJ-MX.corp.irix.systems (unknown [10.57.36.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id A500F848D;
	Mon, 12 Oct 2026 01:10:29 +0300 (EEST)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:10:29 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>, George
 Moussalem <george.moussalem@outlook.com>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 1/3] Bluetooth: btqcomipc: keep the dot in split firmware segment names
Date: Mon, 12 Oct 2026 01:09:17 +0300
Message-ID: <20261011220919.1816407-2-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261011220919.1816407-1-me@andrei-z.com>
References: <20260709-ipq5018-bluetooth-v5-4-e476c41f03b8@outlook.com>
 <20261011220919.1816407-1-me@andrei-z.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)

The segment files of a split image are named <stem>.bNN, as
qcom_mdt_loader expects, but the stem excludes the dot, so the driver
asked for qca/bt_fw_patchb02 instead of qca/bt_fw_patch.b02 and failed
to load any firmware split across segment files.

Assisted-by: LLM
Signed-off-by: Andrei-Alexandru Bleortu <me@andrei-z.com>
---
 drivers/bluetooth/btqcomipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqcomipc.c b/drivers/bluetooth/btqcomipc.c
index 9e56d1c8e..21dd3e812 100644
--- a/drivers/bluetooth/btqcomipc.c
+++ b/drivers/bluetooth/btqcomipc.c
@@ -847,7 +847,7 @@ static int btcomqipc_firmware_load(struct qcom_btss *desc)
 		/* Check if firmware is split across multiple segment files */
 		if (phdr->p_offset > fw->size ||
 		    phdr->p_filesz > fw->size - phdr->p_offset) {
-			seg_name = kasprintf(GFP_KERNEL, "%.*sb%02d",
+			seg_name = kasprintf(GFP_KERNEL, "%.*s.b%02d",
 					     (int)stem_len, desc->firmware, i);
 			if (!seg_name) {
 				ret = -ENOMEM;


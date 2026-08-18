Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072C39A7EF;
	Tue, 18 Aug 2026 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047009; cv=none; b=XJHMprBCP4+DobJ7E271zKS8A4VQN3tEL11hxD/SOiZgkRengUOAA+sT5wH3A8gxa+UjJUSotMpJiHoMj9g45S74pwG+5ro+XR0WUSvD2z4MytPshmeGGYNBR6o/Wx86E8ilblqBSZQEhhi7kHgN2Bh+TAKLL7HmkD+VNzPh1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047009; c=relaxed/simple;
	bh=OpABj3+sont+lTlaUvAJDdQDP8dcU9QYNrimiXFBDhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKX08I1FqSKYKv4I17zeuCyyjuZHYHey591g1VptMqpFaK1ERFS/2N/EJT7SBdVRFoeg8pmo1oCPugvS4AzkYVP+/AljoNelUY3+eVtepS7aK8HH6yK2itDLWv5QgBJJgv7W8QLo+6fK8cTYGuXbv+9jn31Tni/bwBR8TtFKzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d36ba009aeb11f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:aadada70-85a5-4738-bb57-5d46c20dd131,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:0117d1633de0ca8be3aca8d3d8ee63d9,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|136|865|898,TC:nil,Content:0|15|50,ED
	M:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d36ba009aeb11f19a56ed5b684f684d-20260818
X-User: liujiajia@kylinos.cn
Received: from nature [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2004755932; Tue, 18 Aug 2026 17:56:42 +0800
Date: Tue, 18 Aug 2026 17:56:39 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ying Hsu <yinghsu@chromium.org>,
	Archie Pusaka <apusaka@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Fix leaked runtime PM reference in
 btusb_reset()
Message-ID: <aoQsV6O3jbZ1vy0j@nature>
References: <781dc2cd5ab0533fff9ee7fdcb92fff573431f18.1787039123.git.liujiajia@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781dc2cd5ab0533fff9ee7fdcb92fff573431f18.1787039123.git.liujiajia@kylinos.cn>

Drop this series. There is a potential race window found by sashiko,
usb_lock_device_for_reset may abort the usb reset if the usb device
enters suspended before it.

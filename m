Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA18239E70;
	Wed,  1 Oct 2025 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759298690; cv=none; b=oN7qtHWCBWBcQtlU8ktQRwevDCYNtiQqZ8Rnv9FQycN27l05qKuBkHTlxfZpEA6uO7ReNveNchNzRd4tEOJWIDdT6UXTkLdU9+c0rEi5fAVwvULEa52Oo7SvEl+KMMgoDHLpNDHXbQ85QCold/uHWTsbTqPWYwLm8HJZUcw4D6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759298690; c=relaxed/simple;
	bh=hNSz9gW/ii+2++SFfjkFQgoFOQmuMDgJIY1Y0EaD1Jc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UB7K3SX8pWNQW1HYpKH1Tgvsx8L96E1JkjSdAEfU2LqeMraOdH2f8ARlxHS1sbqMOGqTdfJ82mqxa/AciqKhwTVSrkYxZ6hS7Sy9tcaO9SW3KP5qo17DaNrgUgctc4GvwasM11TE8u9RqWb1/ynkzWXIzJm/7yMY+pma4g0WJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z2gIyHft; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z2gIyHft"
X-UUID: 84cb3f629e8c11f08d9e1119e76e3a28-20251001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ixDkZdmZjEhnbu/X1A3+4I5hcb/jbkxBCb7Z/1tYu+Y=;
	b=Z2gIyHftnqPe+bVu19RYmQEkxlNfOq6MuqKyFN36wPbEkTK0lk8Duivopxt3bion7YEt2UALxxeGk8iajBwpNI48bX11JjOXTuV3IcfRsbQobxbqHsLuaqbY0JWJdO1R1Rw3UyYyOxRX+A11pJfvGzY86GjwHuhp2oWZRjXOm1I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:56207e3f-02a1-46ef-9d38-9919eb13f1fd,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:5499dbe9-2ff9-4246-902c-2e3f7acb03c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 84cb3f629e8c11f08d9e1119e76e3a28-20251001
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1158140492; Wed, 01 Oct 2025 14:04:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Oct 2025 14:04:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 1 Oct 2025 14:04:39 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1 0/2] Add two new ID for MediaTek's Bluetooth
Date: Wed, 1 Oct 2025 14:04:35 +0800
Message-ID: <20251001060437.2298529-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In response to the customer's request, add the following two
VID/PID to the USB driver table so that btusb driver can support
the corresponding MT7920/MT7922 modules.

1. VID/PID 0489/e135 for MT7920
2. VID/PID 0489/e170 for MT7922

Chris Lu (2):
  Bluetooth: btusb: Add new VID/PID 0489/e135 for MT7920
  Bluetooth: btusb: Add new VID/PID 0489/e170 for MT7922

 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.45.2


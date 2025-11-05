Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361C27F732;
	Wed,  5 Nov 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762321834; cv=none; b=SjIgAXWeP6n02smfyYyiztiIz/NoHPPtSzLaCCIf2ldLkWrcECtEaePpg0AdP3/oek694i6GeJNtl545BN8Yne6QKtnvnd0yzWxGmqjETyGsQBCJkGyxJhtdHXL5P5uLHYKrsvGwsV9aBWqy18HSHMwCpwPvbY96FM4LvOIWMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762321834; c=relaxed/simple;
	bh=cH8C/V1KqHlv4hG1tIXG8KMKsFaQ/K5GoKb8Y/NSu4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NMK2YW9JozCbVdg1ZFB2ziv7FbHQ0c7WLUYk0uiQnOJG0+Nmmtl1ConHiw8D8mqBK+k/17vxOAElbva+hBphdRcvhy1A71t+CvrJdugLgEii9wQi5LRoFssq7S4g7iHNOLpnz+dFPe4UfyE04dFOOjxb9aj8QJ67n/QlrdAWcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FpVLnHkV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FpVLnHkV"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A55oLo15506869, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762321821; bh=JXuF9GAWIJ7qjp7g4zAP1U/n0HOtutxKOgYa7UAZ7sE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=FpVLnHkVWmsm9Kvm0TtaF1JuRcBUdCxNWcmV6fBTPe7udjN59Q2m1hP2NDpwZ4ckR
	 hRD5yBVKKw7soZVHjIb/Q91/pCzDPXglZhzTprk1qIeXSXB9vwOpKGBqTZHRnbXnWc
	 sdk71TA1dmY+KjhlVe4o2PKKOpIicn3QXomygI2SS9UZhosMBTisEk5E1ZMAzSFcHA
	 qoWnujL3kwEMRS4I46jzGvKup0MQ3FdBZq4fzGtr2huuISQkJKoWlLSg8Y/p2izwkS
	 uLt550kF6Ww8OWs4tId00O/RHUJBrXMO8DbkhhRaGtSWGxz4f8nFpdW9W3Qkn034t0
	 gtCULbeN0uUpA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A55oLo15506869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 13:50:21 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 13:50:21 +0800
Received: from rtkbt-D520MT-K.realtek.com.tw (172.24.54.67) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1544.27 via Frontend Transport; Wed, 5 Nov 2025 13:50:21 +0800
From: Max Chou <max.chou@realtek.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hilda Wu <hildawu@realtek.com>, alex_lu <alex_lu@realsil.com.cn>,
        <niall_ni@realsil.com.cn>, KidmanLee <kidman@realtek.com>,
        Max Chou
	<max.chou@realtek.com>
Subject: [PATCH 0/3] Bluetooth: btusb: Add new VID/PID for RTL8852BE-VT
Date: Wed, 5 Nov 2025 13:50:38 +0800
Message-ID: <20251105055041.456142-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds new VID/PID support for RTL8852BE-VT.

Max Chou (3):
  Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT
  Bluetooth: btusb: Add new VID/PID 0x13d3/0x3618 for RTL8852BE-VT
  Bluetooth: btusb: Add new VID/PID 0x13d3/0x3619 for RTL8852BE-VT

 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.18.0.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502808;
	b=LS46ufwkO0TtIbM9NKNq9sUHq0/iqWXNvV7wWfPb1UZNYXJ4nd9JYazxf7cpoUozmUYt
	 H/au31fgZgZd0Ruuy/6g3GqdT1NNeRLPFEFCWEXA+igZsoKZn0I71/GlPdDon7V+kXuJ5
	 oq4FpN08NpFrn4R3SEm0Q5OArjoaM0wevkVRVQBGwA25HbN6nO3++1BND41z952jR4rCl
	 hxO0GhslHS6QfhHq20uxYqcxWqYBCcBYrPS5AUeTlzpn9Es0vNB99X0Nlnrykc22Uxphk
	 YsleCr5Xpxz59GZL7n3bPBr2iZ2/2TOUvu2V1tvHXgooTZ31zM8c27XxZzVaoorpxBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502808;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Virus-Scanned:Received:X-Auth-Info:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jpWt/pMvPnNcWCjB76mm5IEbF3SFOZp71fCEp2it8SQ=;
	b=ho2z5P9TbKWZYNmBPZl3rzMHzNIXKRhHP07aMX16JMHDcCF+max17vVE2+QFSlMWUx3v
	 JsziYK/PEnqpy+YWwc+88xvF6Eph/eGThMPTUsg/330oY7yTKLVtXR+o3Fa3nZj7+DDcQ
	 9dka7iNbc/LWUy6gmWbsHaq2VuVlPqesH2nuTC/LuTZo1MjwDKJP77n1yBU2J2XM4rbDl
	 45n/9ZvrGbR6ralZwd9XmNT2GMh91eDGyFLuPcl8a+5ykOsg9SZi+DaekjRKt6aXaNHHm
	 hjPcNvjQ7UakJWLCl5KuHq2fm/snRFvdAX5ImwyKGsO174UY2XK9qJX1fQ2MWVmHsFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=muenchen-mail.de;
	spf=pass smtp.mailfrom=muenchen-mail.de;
	dkim=pass header.d=muenchen-mail.de header.i=@muenchen-mail.de header.a=rsa-sha256 header.s=r1 header.b=w3IUetQH;
	arc=none smtp.remote-ip=212.18.0.10
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D146606A31E;
	Tue, 20 Oct 2026 13:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D146606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=muenchen-mail.de header.i=@muenchen-mail.de header.a=rsa-sha256 header.s=r1 header.b=w3IUetQH
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j8Cqd5l97z1sRL3;
	Tue, 20 Oct 2026 15:26:37 +0200 (CEST)
DKIM-Signature: a=rsa-sha256; bh=jpWt/pMvPnNcWCjB76mm5IEbF3SFOZp71fCEp2it8SQ=;
        c=relaxed/relaxed; d=muenchen-mail.de;
        h=Date:From:To:Message-ID:Subject;
        s=r1; t=1792502797; v=1;
        b=w3IUetQHi9u+C73lf0vi3QevYSXepVNE+l2vs6fk34wTz7FR8+ui+616jsdmCSSe
         KUUHK2weVV3Tb/R7E5tw+JnwxOuT8SF6H88uCA68iSx8RMZkkSAYvmrays2XkTUd
         qinvm0VtgZ+lRuw3IjKUQX7SNxdX5wqlNAxzhEjah7dGN+HNGKTbc/CTgrWcyOro
         TAuv4HwGsZYDdJH5C/4n7WHnrqvLUUl9tH0zfVR6gntfpW3YVta8yzasSM2pgBwG
         Ql5bnUViZ2vryPqJVvwDMqfvc+ydGQDizIHrE0IVh2pHY3CUezOafy/ZE9fVraRO
         hrEhkKJqKjs4DYZNYzKCzA==
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j8Cqb009bz1sRL4;
	Tue, 20 Oct 2026 15:26:34 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4j8CqZ2tf9z1qqlS;
	Tue, 20 Oct 2026 15:26:34 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id sbgV7B6_Tp6a; Tue, 20 Oct 2026 15:26:32 +0200 (CEST)
X-Auth-Info: GSJntXyhLGrkHEzpWsj7VhWS4UOUak/bT46u6RSuBCo370N1q882lgF9DqVCziHl
Received: from wiesel.intern (aftr-62-216-206-189.dynamic.mnet-online.de [62.216.206.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 15:26:32 +0200 (CEST)
Received: from murmel.intern (unknown [IPv6:fdea:9b79:8984:1:7b8d:a039:76a5:1596])
	by wiesel.intern (Postfix) with ESMTP id 9EE5979A06C6;
	Tue, 20 Oct 2026 15:26:30 +0200 (CEST)
From: Thomas Gerner <thomas.gerner@muenchen-mail.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Thomas Gerner <thomas.gerner@muenchen-mail.de>
Subject: [PATCH v2 0/2] Enable bluetooth on BeagleV-Ahead
Date: Tue, 20 Oct 2026 15:26:02 +0200
Message-ID: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
X-Mailer: git-send-email 2.53.0
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

The single board system BeagleV-Ahead uses a Ampak AP6203BM chip for wifi
and bluetooth. Wifi is already enabled for this board. The bluetooth
module of the chip connects by UART and PCM to the TH1520 SOC. The PCM
interface is currently not used because of missing I2S drivers for the
SOC.

This patch set enables bluetooth.

Thomas Gerner (2):
  riscv: dts: thead: Enable bluetooth on BeagleV-Ahead
  Bluetooth: btbcm: disable read tx power for BeagleV-Ahead

 .../boot/dts/thead/th1520-beaglev-ahead.dts   | 85 +++++++++++++++++++
 drivers/bluetooth/btbcm.c                     | 19 ++++-
 2 files changed, 101 insertions(+), 3 deletions(-)

-- 
2.53.0


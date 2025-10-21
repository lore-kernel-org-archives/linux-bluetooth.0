Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01864414;
	Tue, 21 Oct 2025 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080018; cv=pass; b=W1GY6OqYZBukv+EtJqHUFmGaLKhV+t92ix4s9Cf60bmx3wxuei7v/cBRLXS+pTTtqPllwma6yN9BEJuXOKqL5K9qUfDJ9k8YcSFPckRikNPJEnXov82jc9dReuD6Q7V1nNvCHGqvAEu7ZVt0npJtrfcuV+fiw0fHq7ZPrtUoI50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080018; c=relaxed/simple;
	bh=4PU5mV895pNdIV2Sn7TJY2lTLez4n2dKmgx6ITLpx+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNER7lO/dtjpL4E1h1hzRYqYAqqo0Lgb4RSU8Q72Pze575ep8ACpp98zeGed6PhPY8zET10cavpjaOOG1pGh0RfII5nhePoRNcYcvXuZHvpmU50Bbzf45zCjIpFiOB1P1Tg8GVYx+lneqhsI6HJoMMEpFHNt2bKdk7NSaOwuSKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=bl3SOocf; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=K5h34oCB; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="bl3SOocf";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="K5h34oCB"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-txv0.prod.antispam.mailspamprotection.com; s=arckey; t=1761080013;
	 b=BJN0+a+w4rc0x8pe0LM/+J2gJ57LKDujQfG/8WGgUtT0QmwMEh9YgrB4UOAEn4nzYtnpMNoB2O
	  pJA+MBs8bDLYDvYzc3U/LsqWBna0fhWgYxXf9FtfaaGnc2kf9vGqap2n8sLURSX6mBuDXa1r9+
	  jW4Is95U2EZluVNPdcLpwfJA7S19dTQTM446JUT7G/Wf9ElQEGiq3BAuNyFynN7ROyk/qOmtao
	  nQ4gH1KEPYjwSlMSc23z33o7IJg0yaItMu+IK+TNCTZM6MvQaUYDoP/ElqqDXS7FfoZRyNHocT
	  2f4u2PXkJBgHyRlN4JYu+5U2H6SO6EIQHgZ+6WFXG2BONQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-txv0.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-txv0.prod.antispam.mailspamprotection.com; s=arckey; t=1761080013;
	bh=4PU5mV895pNdIV2Sn7TJY2lTLez4n2dKmgx6ITLpx+g=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	  Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=DCXVrHfAbYFHND6qaRJWIKhuWtc6q+2b2a9HPDOCjoHAUyNIy6Bs8pD5ybSYZ0yV7gb6Q+EoxX
	  XXMOUKkMvu+rMKFjf+ynnY8Ov0FI2+VzkRh/atVKGhjCTcTQlS0wy5as8WD0jkSG4vxazIJvk0
	  MGJAUoM4rLoT+9K1uX4a4/vGhm4LtX2VA5OHjnKc3p7FKDG5nQi4csjv2qrjP6A56sCll8NlMj
	  bGu5pGSFGaY86ENcWWtCLjLUzVx7Gm6Z1DQhzRgb67vLRoCAZgIHQQqN29hzBK6Bq3xz2Rp/x8
	  YGY6i0R1O2Vrz5suUwVGeKPXBx2xDHfX7Yj2hQVhbKolug==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=mdvj68vJAADYdOaJIVC1HFGHYHSapuI24Ot8joNe8mU=; b=bl3SOocf4ZEj3hJvUQjwe5a9lu
	5OhJPj9S4W++A0nbtO/PdfREAytbmgBIPw0abhTdlFTCwi01Ak05WfgJn1FkQ0ys+qiPH2Nu3zsn5
	hC/voSrK0fJhQ1LjZhHW4VcBua4wRsusvq0A1Gx7GOiok/9xYe5fjyU7IPvr8NYtjkFA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-txv0.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBJMG-00000001OOp-0QuD;
	Tue, 21 Oct 2025 20:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=mdvj68vJAADYdOaJIVC1HFGHYHSapuI24Ot8joNe8mU=; b=K5h34oCB5B3ChRxrAccEeGlGgi
	jpXypSdHvbCnoPY1iIItCUo+uqQggb+biHq4ei5mezF8kog73p93ALyDqpTufshqmAmqmOwuRV/Hi
	VAwhmfjvDHqZqggVypMiOs3GHgaLzW5x5pRjIAIXKC8ZqssYoKS2P3hvFGM14YhjZ44w=;
Received: from [95.239.58.48] (port=65022 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBJM0-000000006uc-3Qsx;
	Tue, 21 Oct 2025 20:53:12 +0000
From: Francesco Valla <francesco@valla.it>
To: Calvin Owens <calvin@wbinvd.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a possible solution
Date: Tue, 21 Oct 2025 22:53:12 +0200
Message-ID: <6837167.ZASKD2KPVS@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: e1c565c38749307d116ccccf7363c19c
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vBJMG-00000001OOp-0QuD-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-txv0.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello,

while testing Bluetooth on my NXP i.MX93 FRDM, which is equipped with an IW612
Bluetooth chipset from NXP, I encountered an erratic bug during initialization.

While the firmware download always completed without errors, subsequent HCI
communication would fail most of the time with:

    Frame reassembly failed (-84)

After some debug, I found the culprit to be this patch that was integrated as
part of the current (v6.18) cycle:

    93f06f8f0daf Bluetooth: remove duplicate h4_recv_buf() in header [1]

The reason is simple: the h4_recv_buf() function from hci_h4.c, which is now
used instead the "duplicated" one in the (now removed) h4_recv_buf.h, assumes
that the private drvdata for the input struct hci_dev is a pointer to a
struct hci_uart, but that's not the case for the btnxpuart driver. In this
case, the information about padding and alignment are pretty random and
depend on the content of the data that was incorrectly casted as a
struct hci_uart.

The bug should impact also the other platforms that were touched by the
same patch. 

For the time being, I'd then propose to revert the commit.

Thank you

Regards,
Francesco Valla

[1] https://lore.kernel.org/linux-bluetooth/be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org/



 




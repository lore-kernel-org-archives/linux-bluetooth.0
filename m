Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9A13BAC8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311387; cv=none; b=PIjRR9hRD5g0AQfcDA0liR9//1iUBLsl5PuJaYsfFfisMGUZVS1PE0Xo3/2/x1li6jUPRmc2SZuowpSrHgcQXgygQRiTrOCOX+8AXIxXEpxyZkz+A0ZkpIwh8ILxgoMM/THpyMnKU9nO9Mfa+FbHp7+uSmaSFL5q33w6B5WC9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311387; c=relaxed/simple;
	bh=P3E9viqimfxaTvLtWRQTpfuvWfLKLLLdRLX+IkpS6oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkIKzI4eRV+6PKPHOrPpWJjm+ndEFM5nGGeyOPgWSdCggyQ/7cfIFJppFzcff+yX8n9n8zGkeF48gt9T4GzGu7TJIEnGDgVR89oLkuWDIrUxDe3reMzqJLr/xhSBwrbVy9fNSHmFxzThLUwlBIhwORL4n3Jj5ALNpVo1giZkAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=DmuRKjTn; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="DmuRKjTn"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id CE8EE45034;
	Fri, 10 May 2024 03:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1715310817; bh=P3E9viqimfxaTvLtWRQTpfuvWfLKLLLdRLX+IkpS6oI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DmuRKjTn5gHrFu2h3Fa2qyNQEogt+Clc1H02kHBgpjOySzdPMrn4iCgohc20vEb08
	 Rvg/4w/3XrcjQIatkMHFbAwOpmealSN11d5vApHnJjfwN+63fHf3uhikVbQb/ksjU1
	 dAP11G8htk8FKqIgimiSJwZOIBR5tfTF1/wnbAZPXhjc8MDo1q7t6IiytKZpyOayEg
	 gSFsBFcbG/FqnpSeMzRsbD9nDYHH9LLQknqpYYDXEkzVLSm4uDo+p7Wa5b8BYKrWy7
	 Bj8C7X+4PtxLhX7ctY0WpUz2NFmRwCw8xTEtD3M0vdYpZ1thZwKk8lfVXySUozVOFD
	 9IU2VkrRoswZw==
Message-ID: <70078624-d766-4db6-8ddb-511251baf0f2@marcan.st>
Date: Fri, 10 May 2024 12:13:30 +0900
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on
 hci_le_ext_create_conn_sync
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Janne Grunau <j@jannau.net>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 asahi@lists.linux.dev
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
 <Zjz0atzRhFykROM9@robin>
 <CABBYNZLMODHp+jBu2oVDC5Pg6fyAKJugQF0N-XgarjWQJJPObg@mail.gmail.com>
 <Zj0tcmseJCjR4hK2@robin>
 <CABBYNZLnYz-vPrMbtsJTsLPsyo62j+cxctSkLjRom3bWEU9N3A@mail.gmail.com>
 <CABBYNZJ-6oyLnBov9H_jym9m-9qiUt1ELxYGuBOdZT29aj9MCA@mail.gmail.com>
Content-Language: en-US
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <CABBYNZJ-6oyLnBov9H_jym9m-9qiUt1ELxYGuBOdZT29aj9MCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024/05/10 7:41, Luiz Augusto von Dentz wrote:
<snip>

> If I print the actual value then we got:
> 
> Primary PHY: Reserved (0x81)
> 
> I guess one needs to disregard the reserved range, well until they are
> no longer reserved then it will no longer work. Perhaps we should talk
> to broadcom to know what is up with using reserved values and if that
> is an apple thing then perhaps we could ask them to provide firmware
> that acts according to the spec.

Apple and Broadcom do not support Linux on this platform. The kernel has
to work with the existing firmware (which is the firmware macOS uses),
we don't get to request changes. If the firmware has quirks the kernel
has to deal with it, that's how it goes. It would be great if we had
vendor support, but that is not something we can control. This is common
(Linux is full of quirks to support noncompliant hardware/firmware).

- Hector

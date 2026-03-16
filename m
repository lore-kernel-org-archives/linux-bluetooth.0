Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6D2264AB
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694046; cv=none; b=ixke9tEOXQQreDp+fKzXYvwSgcYf5AgB94bNBXmySI64coNMBDjFpf1ZhkGms1ASF6MvBzPJbOfiliyO2ZpgNWhqIW0p0hrGpGfSisRFdOrMMkRKx55YB7SbGQy+PQfJ/O+Vs9bLMDTMXWaPa74BiEIYs0a0B14jim+ZTJlH6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694046; c=relaxed/simple;
	bh=BumOUmNda6dhPMQxNn8CYZ0tWygFrxYf8zT1Onpnewg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JAl2AXvPjX567IMvU2DtMEiO4N6+ySj83MH2wvuvNQazE7M2g1AxUtIegfjHU+h+MqBXB5kfEGwvMHJZUBErPWaC6x1zLHi1dfWl46xajkCoYNPIxcYI/FGO0VSoCPyq4UXoUg8aH3oelvkpqD/Ho8BfUdp/C9YhEJeabOb1v8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlVND1CP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlVND1CP"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd8576a512so15529085a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773694044; x=1774298844; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BumOUmNda6dhPMQxNn8CYZ0tWygFrxYf8zT1Onpnewg=;
        b=SlVND1CPjM0roWgPsOLtxC3VB7pqnpWsKhe+Qd4rLDOApz9e1XfSg6LpLGHhYQOFdB
         B+z52E/FE+dNk8UjWtOuGduIqtrO8OXC6K2APX9BGhz3+67BXcJVb31b3zcgMja7quU2
         KCZnsqCln0Mun6oXbfDlDt/YnVR6n4h/lwqgWnFFHUl9hOnQA+ajTlJ78rSFufuPtK83
         XvvQfU09VYozy2tVjSU4+0ynwhDLYRF90n1COV4iuQAHLE0BCfGjtFfN1y4ZrRk1q7yp
         BHx0o2UBPjg0V9LwFF34VVj+gkSSHQikbqA3tr+Kn9WHJ3vsQ3MPqTxs7w0dvOHy5PKa
         DR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773694044; x=1774298844;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BumOUmNda6dhPMQxNn8CYZ0tWygFrxYf8zT1Onpnewg=;
        b=gGE2aCjtLxAuQxjJVmwvX5Mwg/Fjl/CY3yPzR8mL0rqxi8YKfJM+BW8y3BuyxGgXje
         0QiJBupJyqZKTMhWCf/h3yJDMlPqe1y4OTiN18+9ygW64MApQg5oV3FIG8tUTeurh/CW
         wNh8YtNmSt4BYHiGZsWHCw7XLpAFBZdrbpt1hd/IOeTmHp5QgOj++gtvDQr+KdDlwLNS
         g4HXJKfQH5a+Ny95cpcq6DbH9MMFgc9UmiW1elD3MaWUbkYKVPKZTymvCKwND8H/yO4X
         xPtj03oo1Rt9DX2ae4fUVkpQk8+KPLmBPVmoNdwpMS2OUDgxlHxWhHTTmsBnvgtsuI1p
         0KXw==
X-Gm-Message-State: AOJu0Yz0ilI+fQwV4ZP0Giyp81gvTX4Y9T3SpuRrEp683Q2Xi1ZcmtcW
	09gTEr1ewuN4//HPBsehaJTGGJYyTiKoP0CXHjOu8jCMVEDhl2Eyfhb4pmzXtw==
X-Gm-Gg: ATEYQzwve8UvCnM0hjYVqMODdBz/HA59M8esaJFqgPEJdlm2Rm5rQ3o0bFdBjMSXjpL
	SN6ki7efzPnhN1cUB8dSVd27crxXYdSccAfp+ylDwuIkF/HLTuODTF5oKA/1qarCNfRaoMjjoUt
	rvgebywwp9hBiFFMuDmqBUYwsm78zKLEfM0HaNxs6R77QWGBgxf9As93dqRaF0EyoMstT7rglvR
	9YKPxtoO+Kr6fWt38j0Ttgk456151HjI36Nbr/2MUASNyBILFBmhrS2UVzcZjFZ5/xL+lvMCxFe
	eS4l/iHD3ml37pQqvGMSGZeoWWEPpHomDNmUysRiuhYfePhBx0LVKGOcYZbzE7metpIhAwv3k3f
	OrFtY5jLcr698909Azcpj2Xo/WLzXTt9wn479BNKDUeEcUYUevmrcTCHFUTFvFdiO9xEHHPJhGG
	MWmvkeDsxAtROR40kNEyEa4roc5BA=
X-Received: by 2002:a05:620a:2947:b0:8cd:85a1:d136 with SMTP id af79cd13be357-8cde13138f0mr143737785a.4.1773694044293;
        Mon, 16 Mar 2026 13:47:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda719a513sm1281996985a.15.2026.03.16.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:47:23 -0700 (PDT)
Message-ID: <69b86c5b.050a0220.36baa.dac9@mx.google.com>
Date: Mon, 16 Mar 2026 13:47:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5389631877413431483=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Add support for handling PCIe M.2 Key E connectors in devicetree
In-Reply-To: <20260224-pci-m2-e-v5-1-dd9b9501d33c@oss.qualcomm.com>
References: <20260224-pci-m2-e-v5-1-dd9b9501d33c@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5389631877413431483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:2421
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5389631877413431483==--

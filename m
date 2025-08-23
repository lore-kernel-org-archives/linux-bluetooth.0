Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139911E7C08
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Aug 2025 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755983195; cv=none; b=W//R2khRJE4XRbzsm+QVZuYV1XHJntyl4d/7oisP+t0uoo9sZ9VuX7m80TG8IDcdZ1z3dBLVQaZzY79J5HaUE4EuUU1Rcvpc9RvrldW7rMBcjZxOvyL52xNNlDa3m2J0b0lmsZ9U9Ujpw5z7U3e5h51WHQEmBk4ZN+651/TkkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755983195; c=relaxed/simple;
	bh=w2Y8BhIqnFAcjJWZ/auiuC4b/Bhkbxw+gMln4m6xS/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOseJR/mCchxirQRPfOm+WX0H8tmLZc3pPJCkvRGyaRBxEnk7zILRB9J4XpuNFeBg0T68aDdCgApzKLXCEOE1d5NkcF4upeBY65j+2eq8PyO1fde7kh+lgnYlktX/83VNUl3yZwnr+57JWWY4pTClgK6oQeUegKJfuFTEimtLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=nSGaTYUB; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="nSGaTYUB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UsEx+wWbaYXxf1X4RrpL4XO4TRuu/zW9VtYBS7i83KY=; t=1755983194; x=1756847194; 
	b=nSGaTYUBjlJOiRXpuvNsvKvzQ4Iy9HitT9nqtXg6VxQ6S4vkm2F1zMrHXQw8kG7Wcs6v/gdQR3r
	9TNovLNZVpXlyw4g7Mt5R9HGpgKrVQ/08lZxZ/KR5hxo4yVuNATYXjQ1nFQdLRnmcy6HEuQyRIhkv
	ogicXmfLNtLpxv+Y+v/8mn86qaIhiTu/XBXzLTVjL7GN/74TCdseYup3Nt92DNe+dnEhMTzSvRWPy
	Aks/p+m8AxxvZfXKJrlx0yuuy/LGXqNPRUf1qaj2ij9EZ1DgMn0gJxgd46hMwsVZYREo8BFQE8TQY
	q6/vyIcLJbafCQbwJSCCFzd3rYtFqFQCtpbA==;
Received: from 135-180-5-199.fiber.dynamic.sonic.net ([135.180.5.199]:50426 helo=macbookair.lan)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jgnieto@cs.stanford.edu>)
	id 1upvRP-0001Sv-Se; Sat, 23 Aug 2025 14:06:24 -0700
Date: Sat, 23 Aug 2025 14:05:42 -0700
From: Javier Nieto <jgnieto@cs.stanford.edu>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_h5: avoid sending two SYNC messages
Message-ID: <aKotJuaUB2V6zdKc@macbookair.lan>
References: <20250822003912.41754-1-jgnieto@cs.stanford.edu>
 <06787d51-5d5e-4f74-bda6-b80cead5ed6d@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06787d51-5d5e-4f74-bda6-b80cead5ed6d@molgen.mpg.de>
X-Spam-Score: 0.8
X-Scan-Signature: 993826b9125cbf1b907f71dc54053338

Dear Paul,

> Great commit message, thank you. I´d appreciate it if you documented your
> test environment, and maybe paste the logs (for the timestamps) before and
> after, so others could easily reproduce the issue.

Appologies for that. My test environment is a MangoPi MQ-Pro board
(with a Realtek RTL8723DS Bluetooth chip) running the tip of
bluetooth-next, although I also observed this issue on 6.8 kernel.
Originally, I spotted it using a logic analyzer on the UART PCB traces.
I added a temporary log message to h5_link_control(), which prints the
first byte and the length of the packet being sent. Here is the relevant
part before the patch:

[   67.328445] Bluetooth: h5_link_control sending 1 with len 2
[   67.432393] Bluetooth: h5_link_control sending 1 with len 2
[   67.436424] Bluetooth: h5_link_control sending 3 with len 3
[   67.436592] Bluetooth: h5_link_control sending 2 with len 2
[   67.436693] Bluetooth: h5_link_control sending 3 with len 3
[   67.439510] Bluetooth: h5_link_control sending 2 with len 2
[   67.440004] Bluetooth: h5_link_control sending 4 with len 2
[   67.440030] Bluetooth: h5_link_control sending 3 with len 3

And here after the patch:

[   67.498228] Bluetooth: h5_link_control sending 1 with len 2
[   67.501444] Bluetooth: h5_link_control sending 3 with len 3
[   67.501615] Bluetooth: h5_link_control sending 2 with len 2
[   67.504976] Bluetooth: h5_link_control sending 2 with len 2
[   67.505141] Bluetooth: h5_link_control sending 4 with len 2
[   67.505168] Bluetooth: h5_link_control sending 3 with len 3

Notice that in the first case, two SYNC packets (type 1) are sent, one 100ms
after the other, while in the second case only one is sent. In both
cases, using bluetoothctl to connect to a device later on works fine.

Thanks for the feedback,

Javier

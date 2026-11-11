Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414545;
	b=kDh0Ai4tZEynBsDWdzuuITe1bXMTgiffYcIONJ3ebR6941s+lgadhAtMiDu467qzNZ5F
	 Xqe5jGy3aN9vUY245zkjtFTC5czSYA7b0v2QZc7SZsSF5KPZ9Xn48LbKpD1sk+qFo21hc
	 oBzgxTJu84RxawB8RaIEbevpfyToR+OgW7f+gPBG7b6R6Z9tQevCqpDbhB3b/HA+MhUQD
	 HyJquwTYn9S4Iqnitu4zRm+ivxama8ihSxVDyh8D1U1bYOuiqQ6uliugKnTkeFCmyVmRY
	 tUVkPCXLZa5GCcwPmZ3QmvDgmvvzUG9rSIbqvZ1LVACMq+FQyvvJhMhL0zc15SuZw6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414545;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GZm9YwB3NBsRU5kio5p9Zt6AIG4QFJ8V49dmNPDMGHk=;
	b=kc/lbByeIDPQyru+HgD444gTVotXH3qg0jCpuSz+px6mMfDVcJwL7YnOuhuAl+AUMfN5
	 yKIH3W5R9ml5bzeYfUpWcLb0rXwmj5tctcYzvSaDNCRjx7YflzvBl7R5Cd4SOKsMaHyk8
	 KPBDVpCcjrmzuFBsftMSvwXCGCliPvbu3K7BbauT5+rmkuwL2+sKxxg33m3tyxNB0Npzy
	 bXgjUSXYbtm2906Q4wGhvyAvBGANsL8BVtXehIY7nvzMoD0+kdNsYaDofW2d+875kwCCE
	 S6Yl2lsprPe6HFE5q7zESkOBHrln7nJIpQt9X4GxeEZC+aVAkIM6aEokzaBU6cZiQog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMK62Tbd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88842606A324;
	Wed, 11 Nov 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMK62Tbd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECE91F00A07;
	Wed, 11 Nov 2026 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414545;
	bh=GZm9YwB3NBsRU5kio5p9Zt6AIG4QFJ8V49dmNPDMGHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BMK62Tbd8iKyabZkiF4n7dnDawnlpOiocExyQO9nZhX3dI5nGtA9vBmJitaFUrbzS
	 Mj8YKGaF0LHpBzGZzGVCKlru2XxCGjxG12XmdGgUSgkMYc/xgH9udeHbMZnvnFen6U
	 3UkHw1cWV/wL06KsPt0mol1gZ73yUHvoiex55DxZCQG3apzPjaROJG5ugf+WHekG6V
	 ajuIS4bIsi0uwLLybLhhY4w9xoNjW+sFzQt1+ri5u7R/iIDILPMcGOMYcCHEzU3m3f
	 f06zwbP5Hj9pEh9ylzLhIAsWvs4DznMoufc7/PW+cimnq1P0JKmsUXzIeQbBFjbmbU
	 hl+M3PQewgezw==
Message-ID: <517d9d36-ab3f-4eb5-8908-f50aea59a3b0@kernel.org>
Date: Wed, 11 Nov 2026 17:29:01 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_bcm4377: treat only negative
 hci_register_dev() returns as errors
To: Andre Eikmeyer <dev@deq.rocks>
Cc: j@jannau.net, neal@gompa.dev, marcel@holtmann.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com
References: <20261111120248.21062-1-dev@deq.rocks>
 <20261111120248.21062-2-dev@deq.rocks>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20261111120248.21062-2-dev@deq.rocks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/26 13:02, Andre Eikmeyer wrote:
> If another controller already holds hci0, a USB Bluetooth dongle for
> example, the BCM4377 is registered as hci1 and probe returns 1. The PCI
> core takes that as success, but the devm action that unregisters the
> controller is never added, so it stays registered after unbind while
> its driver data is freed.
>
> hci_register_dev() returns the index of the new controller on success.
> Check for a negative return, as the other drivers do.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---

Please make sure to pick up tags from previous revisions or mention why 
you dropped them. I added Reviewed-by for v1.

Sven



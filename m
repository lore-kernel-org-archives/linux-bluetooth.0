Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977621;
	b=fBXlnsYxYx910jORjtMoCDZf5YUtk/N4xd0NXqDLKS2vOHPldqF9f01BIls9mSZG4t57
	 iQWjwtXQfv1I7sv91AhaupWq7YGrtvZ1IyiuBKK2Onn41jCvZpW9lWZ1N4CM3cgU5i2cE
	 Zc4EXzn4vylyCDgaLZaahf7z1GhSOvERJTYjZ/IV/ohEPeEtBYEGrMKy9oRRjfE/TNfiQ
	 ah2yZcP56nOdPo56P/aCkXpsB6Tz6YmsYcHHRgmKRPvqUaumr8HzKseDM+YHU7VOnQbuu
	 hYn/3srNOvJC9hwqX1aVVf1CBmme2On5DntPuDzZbjutiN7wpVr+HhpBcM3qDPWPccQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977621;
	h=DMARC-Filter:Date:X-Lima-ML-UUID:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=a24+d9xvaf+CDIz2+89Hx2fexrG15RfEetPbz91IQO8=;
	b=06vy9tzkwRRXudw7p42nYSB9KbAdvQSbwP7YIvas6WfLkBxkOe2fowCndtD3yhCmK/5L
	 2N7psNufVEnmkMyWLRshrds/QVM4zW0jP5EmRceXgW1z6X0OZ58W9hbS5+qx4aazSd2ul
	 KDBNnhfNv1d/foMgnYzbSs+mtcfTzztwtqJ1fXVF5G0hqJ+tjv70hy74IVe+2s6oZZ8lI
	 7EyLEow25FjNvqDzEzkguwg9ggJzXaFidpMAe6GfJsO1gQi1VjdEu33D2jQy/9jzZHze8
	 i5du+T0fDMC6/ybq1CJ4QuSzpwCXu4bdIyeKPF7nIDxBBPi/cnnUm5NtZmmh/lfiDXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9B606A33A;
	Fri,  6 Nov 2026 15:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46D9B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Date: Fri, 6 Nov 2026 16:06:48 +0100
X-Lima-ML-UUID: 59084f74-4df0-4d05-8f4d-796d5e595ebe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793977612;
	bh=a24+d9xvaf+CDIz2+89Hx2fexrG15RfEetPbz91IQO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DcQqrWYJrmn/TxAwJu3//ceI1EKsNKPNB8iDm6H18mLIZKbwXuz77tMxy2jzUuJoa
	 IUZ2hw0xefq1/6Im1d3mtxNqxYDmw4m+OcCHHZF/IdnqcQGJ+VoQQo43iHqRmXPaSk
	 YnXSFCJl1QLMYypmDUuFQDY3bNrV01msSjaXmFSzn1eBcW8DwKWqOo8os+EQ59X+qc
	 TYDxHRB/h5CdG+ccCtGn9shroQvEX84ZFLZ8Gy/DjoMyaOZcb4Qj0+O4Sv4xrQ0wNE
	 MnNR1H06/oBatRS969+5s12uKSIsXWFXz0Yq7UsN3m+Yqz/XpL9zxAsEktQl7+6PEi
	 wUY2Nb0VTg8cA==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Sasha Finkelstein <k@chaosmail.tech>
Cc: Myria Sarvay <myrialsarvay@gmail.com>, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, sven@kernel.org, j@jannau.net,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Yossef Osman
 <Yossef.Osman@proton.me>, Aditya Garg <aditya.garg@linux.dev>
Subject: Re: [PATCH v2 1/2] Bluetooth: btbcm: raise ACL priority on Apple
 Broadcom controllers
Message-ID: <20261106160648.05117894@kait2en-mbp15-1>
In-Reply-To: <5F81A6CC-46B6-4C45-BB05-8483057EEE7C@chaosmail.tech>
References: <20261105085750.120392-1-dev@deq.rocks>
	<20261105085750.120392-2-dev@deq.rocks>
	<au1uH6uxtsw2vHfP@macbookair>
	<20261106083339.677cc75d@kait2en-mbp15-1>
	<CB3B84A2-76AD-45F5-B2B9-39E5A9ED3BE7@chaosmail.tech>
	<20261106113946.60c6c5f6@kait2en-mbp15-1>
	<5F81A6CC-46B6-4C45-BB05-8483057EEE7C@chaosmail.tech>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 11:53:13 +0100
Sasha Finkelstein <k@chaosmail.tech> wrote:

Hi Sasha, coming back to this after testing

> >> You probably shouldn't, or at least base it on v2, not v3 (that one
> >> ended up being a bad idea and caused firmware timeouts, so Asahi
> >> downstream ships something more similar to v2).

Linux doesn't keep ACL link across sleep. The core disconnects all
links before suspend ("terminated by local host for suspend"). I saw
that with S3 on the BCM4364 and with s2idle/s3 on the BCM4377. After
resume my headphones reconnect and my patch sets the priority again.
On the T2 Macs the BCM4377 BT itself does not come back from
s2idle yet, even with patches 01, 04 and 05 from your 4388 series,
so I couldn't test there. Would need to investigate, tho s2idle is not
my priority right now.

Since connection time works on these chips, I'd keep 1/2 as it is while
being open for proposals.


Andre

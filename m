Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E133932D0;
	Mon, 18 May 2026 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136218; cv=none; b=WuzYDhSz9yybSDPOqbPjkBL62KU6VDsIsgTDgXHmMrbwGsKPBsmkWto39njS0xINcJxEhKcf3tY00JxWb5eOl2JJsQNZei2ShzrUKZ2BYxY3kMmCHnuy1x4V4ayzt7kC4gdMuevcF9QoUDMMylRoUlVd+AVBsa0VNgbmPmLsSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136218; c=relaxed/simple;
	bh=uGAMPfqvK17pfef97Tb7xZhjdoKTL8ybl7TaB+WbB0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ken+gezDx02w1FJYtEtjzb2HfQx067S9yG8WOIsgjrT7+BqYlLG0f+zR344TQAwMMajDCIbBzfquhEE5o8McoyfEYEekvMa6YvCiHkCUd+ESZCKxlnlDN4cnZO+4FISR4ZTP38WLrDnA0GpHHeOlSjAmYiSbSvnMyvgw286CEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af74d.dynamic.kabel-deutschland.de [95.90.247.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8B1AE4C1511A9C;
	Mon, 18 May 2026 22:30:01 +0200 (CEST)
Message-ID: <b0ca0897-6fcf-4bad-87da-9a1b0df1f083@molgen.mpg.de>
Date: Mon, 18 May 2026 22:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: SMP: add missing skb len check in
 smp_cmd_keypress_notify
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 stable@vger.kernel.org
References: <20260517145417.31910-1-meatuni001@gmail.com>
 <3a7eaf6e-6e4e-42b1-a136-3ed2befa90e2@molgen.mpg.de>
 <20260517180832.52329-1-meatuni001@gmail.com>
 <860987c6-5a8a-4409-8943-0cba9d3cc2e1@molgen.mpg.de>
 <20260517190312.56076-1-meatuni001@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260517190312.56076-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Muhammad,


Am 17.05.26 um 21:03 schrieb Muhammad Bilal:

> There is no safe way to access kp->value in the truncated case, since
> the payload is not guaranteed to be present when skb->len < sizeof(*kp).

Indeed, you are right.

> If diagnostic information is still useful, only metadata can be logged:
> 
> 	if (skb->len < sizeof(*kp)) {
> 		bt_dev_dbg(conn->hcon->hdev,
> 			   "truncated keypress notify, len=%u",
> 			   skb->len);
> 		return SMP_INVALID_PARAMS;
> 	}
> 
> This keeps visibility into malformed packets without touching unvalidated
> memory. Happy to send a v2 if that looks good to you.

It looks good to me. Hopefully the maintainers agree.


Kind regards,

Paul

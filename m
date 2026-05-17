Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D01F2B88;
	Sun, 17 May 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043282; cv=none; b=koPX/gZq+6+fT5JLC1BAquDAiBu/XR4WKYsTc8Fv13V0UdX/rWpKxr83an+yCUYA8ESee81EVzoK30ZhVmZ+tKGmYLZHY1IaUe3hFb0tLbPYVWXZUbEwjHE3d/jpRvYwsqhwDbUHx46EUvnxGWrppgLJC7dm2oMB7UQSzAkO2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043282; c=relaxed/simple;
	bh=grvCn41HS4CbRdKBeyRWgc8BiqTZFyKbzVv3KX/bKUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxqNYas3YfER7BcL24fmEYezWIt4QhrtxFlWZ5bnKxbFJo9TibWBU427jH1fX3GnaHYBlU43TAUWqvjJmZaHnLNqPseQnb6skW7FfbOYFoz8qzwsmjVq1d1sBDTtqJXqtYJtJpdSABH5I42OE0mKEJMBY1PLpYNeU8MmslnFRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.1.90.143] (unknown [45.156.240.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9EFF54C1A0B1B4;
	Sun, 17 May 2026 20:41:13 +0200 (CEST)
Message-ID: <860987c6-5a8a-4409-8943-0cba9d3cc2e1@molgen.mpg.de>
Date: Sun, 17 May 2026 20:41:11 +0200
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
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260517180832.52329-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Muhammad,


Am 17.05.26 um 20:08 schrieb Muhammad Bilal:

> Thanks for the review.

Thank you for your instant reply.

> Moving the check after bt_dev_dbg() would not be safe since the debug
> statement reads kp->value, which is exactly what the length check is guarding.
> 
> On a truncated SMP_CMD_KEYPRESS_NOTIFY packet, skb->len may be smaller
> than sizeof(*kp) when entering the handler, so evaluating kp->value in
> the debug log would already access out-of-bounds memory before the
> guard is reached.
> 
> Therefore the length check needs to remain before any access to
> kp->value.

Thank you for the explanation. Is there another to log the faulty value?


Kind regards,

Paul

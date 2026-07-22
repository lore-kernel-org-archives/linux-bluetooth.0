Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C53AFB0C;
	Wed, 22 Jul 2026 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744108; cv=none; b=QuaVGkUm4jPRoA8WMk1dX4FvN5PVoF/ieEEqZoPXs9rqvtf1B2Gu16KXFwBH9jyGkRz5Jz1RXO0S9Aniol8KZHpelvElNWLVMX4dv7Bx0HGZnN6nkbtraRAI/VQNDssJ3YnCswW8JuT5jaaRzstUWRgvFi9i50lendMEjKIwEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744108; c=relaxed/simple;
	bh=GN+utSwRlB5lYW9kIhcTxgBFbfVHimumowCYj8zmgtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NN8DPdG0kq4BoVfsaXEPwkSO4/mwaQesUVf5YFB7zBfcWn0iT3NCJ2NexOoOtYhduXbirGYIk1WQKppx88iSl7kfzmIvqCk0Syow+akHzrzopRSKcD96Jran/G/Fbhw1Z6n+VjAHKvhb3J/i0mA6C6xKktHVxMAugeI8YFTlYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mQvnNE92; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mQvnNE92"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4h52V24ym8z1XM6JH;
	Wed, 22 Jul 2026 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784744103; x=1787336104; bh=GN+utSwRlB5lYW9kIhcTxgBF
	bfVHimumowCYj8zmgtE=; b=mQvnNE92kjVVL+zCiAiLWhndH6UAisDT666jQfs+
	pDnkx7YwEU+zhj9BNO7r9NRlrNjK6fk2k+scL1IMxPxRSnEjHh854Cta7WE0Dc6k
	0Y/dPKI5a7mHIbHq+r+4G0fKCHAaeytoBXG9abBJ6G1HIjT/3S6dmOaB6RSOUPkw
	VGxgZznTD5KT9Wo4FJlyp1jrJ5rj2dZEeDtzDAPqI0o4WOniP2UNXSLjkMYfPtIJ
	OOIfc/ZjvDVstC/yc4fAO/c4Pk4GMPWBGfz1PqT4hhJ7YohAYSw9pV5FxpIBOpzC
	EzUnLfZZhBMfvQ0ot5YA+DrnsJGItJM+jS61TDl5TnNezQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fJL73B4XUTFB; Wed, 22 Jul 2026 18:15:03 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4h52Tx1RJxz1XM5kD;
	Wed, 22 Jul 2026 18:15:00 +0000 (UTC)
Message-ID: <ce5d8cef-5fa4-445d-88d7-6cdb2388d932@acm.org>
Date: Wed, 22 Jul 2026 11:14:59 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Bluetooth: L2CAP: avoid maybe-return-locked in
 l2cap_get_chan_by_scid/dcid
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, elver@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 1:40 AM, Pauli Virtanen wrote:
> Replace the maybe-return-locked pattern in l2cap_get_chan_by_scid/dcid()
> by doing locking in the caller after NULL check. This allows adding
> context analysis annotations for the locking.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389543546E4;
	Wed, 22 Jul 2026 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744168; cv=none; b=muntwT2y7dRFqppFxfNbq3Ga5S0pOUhAQPmyol7RpmJd73Z+uAJRH+f8eisveN3sdnDG4pnimLKYemLXwsYJQgNEKGJHbz1XmqtCEWcvpxPVe/vfmq+rTB4OyUK9YcvvwSRNG7fBwycsQtSgoa3GAbfhmH9ivelnNSsfo/ueD2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744168; c=relaxed/simple;
	bh=tiVaQ5PW5d0zMVe5DoZ78+9NAea0P1esL0670hNzj38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TG5sRiCePPjYqdmI6ys4x0H9JYk279IgH8va/N/+9WldM3wFbm/x9R8s3jX7Le7dfoZAM6ujxsOICnMe1yXxVJI2Pp7sApu54y0rwVK7Tv2EnT62cu0KPIDxJbaFjWANDsHmHuUCSThVpVfZ+DvB0qRvmN2cdIMlOZdTgiVlqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OSALRghS; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OSALRghS"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h52W83GfqzlfwgD;
	Wed, 22 Jul 2026 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784744161; x=1787336162; bh=tiVaQ5PW5d0zMVe5DoZ78+9N
	Aea0P1esL0670hNzj38=; b=OSALRghS5OGtje5zVykKXaRpM8i/Ffd1f0agBfkG
	uqRP66K7QQ6pXqqt+44ZPNBDFhdDlhRypuMT/am0lFMmHaMnH2ygYZpYwulyAWDf
	Cb9GQZ8DUwPcWrT1vc5sr0sgjsdMeahnx9o5HtIT/HwPJrwkbWrK4Uc1oULSBAnW
	8MLm0xHQqdVXkhu6FoVghn8UuW1kbqpg8g8JkWHU27ySRUYwTy4dhBEfQwJitugN
	l3I4l23/k/u7DIYtqZGWH3w7meMMhoHmGF44SDoIBuSsjLQXID9jcw/sO5wXiyBK
	QSuJTQorfHsIa6eyE19vWIr6Qdb8qMpncuiKNXL/NBVz/w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qWIeKpY6JNpt; Wed, 22 Jul 2026 18:16:01 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h52W360mlzlfwgC;
	Wed, 22 Jul 2026 18:15:59 +0000 (UTC)
Message-ID: <c51bc541-3f76-45e6-acd0-58be1083fa05@acm.org>
Date: Wed, 22 Jul 2026 11:15:58 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Bluetooth: enable context analysis for headers
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, elver@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
 <7f895d42129260d8074e461b3d529573c53b34d8.1784018377.git.pav@iki.fi>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7f895d42129260d8074e461b3d529573c53b34d8.1784018377.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 1:40 AM, Pauli Virtanen wrote:
> Remove context analysis suppression for include/net/bluetooth/*, now
> that previous commits have resolved the warnings.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

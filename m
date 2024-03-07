Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F711184
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794349; cv=none; b=YkvbhVuYl30naXg/tOnKJ7XAKPVxMo0XMPcxNQdlOBGb9B2f6yBNDsgltQc4TIz4QLPNvxlw6FP2o5uAE4VUgeBogD5oj+uu16feDDzL6j0dPy9/QlM5EI02VBqQ5gkFIYrWv82K4jMz9b7jlTK2SUwY+OMQwXj5j2AEEnqUvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794349; c=relaxed/simple;
	bh=IR8Tbl8AbRZNrSic2xl1YTnHsWYtoydH2mze7mpoKjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gvaLQkiGGyYJbtfxEq55zYHZ4Y93oXLBNWJkywzgwukcuHlJP3ZVlw2r6JkW3oaBZVPq3oHIVL6AoDp+CHZ3j+KN73NKVshk+qjkRI+B1NbGKYnJT+Qfvd/nO14w0JbwErBAyspq9Wn9qPCHdt1z/dJdUhlMLzhWeLWXYUzrEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeb84.dynamic.kabel-deutschland.de [95.90.235.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5B5E661E5FE04;
	Thu,  7 Mar 2024 07:52:14 +0100 (CET)
Message-ID: <660e13ab-0139-4acf-a4b5-8fd817eef213@molgen.mpg.de>
Date: Thu, 7 Mar 2024 07:52:09 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 1/2] shared/lc3: Add definitions for Audio
 Configurations
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20240306230440.3983598-1-luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240306230440.3983598-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Am 07.03.24 um 00:04 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This summary could be:

Define macros for Audio Configurations

> This adds defines for Audio Configurations so it can be used for
> upcoming tests.
> ---
>   src/shared/lc3.h | 482 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 401 insertions(+), 81 deletions(-)
> 
> diff --git a/src/shared/lc3.h b/src/shared/lc3.h
> index e0b2cdfc346d..41b29d4d1c8f 100644
> --- a/src/shared/lc3.h
> +++ b/src/shared/lc3.h
> @@ -88,77 +88,200 @@
>   			0x02, LC3_CONFIG_DURATION, _duration, \
>   			0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
>   
> +#define LC3_AC_BITS(_ac) (BIT(_ac) - 1)

I’d appreciate a comment, that AC means audio configuration.

[…]


Kind regards,

Paul

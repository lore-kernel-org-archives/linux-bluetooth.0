Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36E256D
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306080; cv=none; b=C0JcArPOZydD1NnqPUQxwa6wCThxYgeXToqmuAoABZnRQhcxcNBEEwK9Ta52ldUbK+dHDWAUBcA7jbY0oOzMF50DSLLaAc6cBTIexShCJvOG2OlKesy40m0wmS/MwCKw2qO/XSv8ior6kbaZVOEnfI4DnvJQR8EZSm6ptGjZRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306080; c=relaxed/simple;
	bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=ZagrUovuFPb8YLvvepORLSlGoOrI64euBWrNT/wmjG4XQkQZFUPoO/4gtGfp3uEyB2J/Pr5MaH2kKvrfbiCHGE3socK60RIj6xEIgopF9ylGsTpJFRMxktCLW5t7J0SS5xJFCR7LdA9YRxZ/Mrw8QWj9sAwBNlQI2ovl0YALkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geicp.com; spf=pass smtp.mailfrom=geicp.com; dkim=pass (1024-bit key) header.d=geicp.com header.i=@geicp.com header.b=E0fgp7Oq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geicp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geicp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=geicp.com header.i=@geicp.com header.b="E0fgp7Oq"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so2749069a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 16:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geicp.com; s=google; t=1741306076; x=1741910876; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=E0fgp7OqK+N6deZN1COmuO9NzOqdRbrsa2dkYalk6J55HMSwVAQzhh0+VhxFca9083
         Lh0rWwROqJV8hPfF69Hmn6XPHFTv+ygWwqmvwKfwrDWgBq0fPkrI7juxM+0T4MgwushS
         Pp3Quqq8yCFPkzN0tvlF/8I9hEDKC2EdBNk/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741306076; x=1741910876;
        h=content-transfer-encoding:from:content-language:to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=h7DpWNSzbdMTx2zl5PJprfrLcr7r0kuIydEmMG0IYuwTlLxev1oeoq7wJZ/xl/J7dh
         IHqRaGHaXxMrstJF+gzQzqFzBmI3rEvOYmrAdqDHPDX9N2yMMjGoV6QKfxIyQuUYVcyz
         B0IKmZXhbQO7LOAzdOSkn08d2sXRy8ysD1e9VZHCPgq49wpQ1T6llSUN9e8xWvt6YhiM
         zY7XtVRkCDkfGw+9i5rTy3b/c7t3XOi/yoDFmnH/+E9FHu06EXXUeZVWj5Qs/j0abhNT
         cAyXX8E2VG4ozTuIhcjyZFd1NBj+Poqkx7aodGC3FTL33LbHPCXL0uyIvU9byqFSFfy3
         brig==
X-Gm-Message-State: AOJu0YxmSrUxrQ1CTs/lDQKCQ69lU0Z49mvTn2T1QTliiKKATzRqmXqH
	jwlJWDfaeUPhWbPqoFsapmkFQtFubsmlUJs9VWC5kcFcygtx/oRaw3OZv25MFWm93/g2t0HcRAA
	N
X-Gm-Gg: ASbGncuHfTM8c5SUBe8mrxLdUD3/+4u7oAAXtlj78kbP/NjJclwKJCzg361x5cAj71B
	NfyCRZ3TPM1cAonvqUuO7JA+A6s1HJ3BUepwW5fbR3jtu1TY4pTl/m8uMrLRNlj6C0zSfwpj7+S
	HJtaNTZS43lGf5aoVE/o1dT6+sufnzGPkTWF/T0Yi0OuD2IFtMLRTolSHBLubUITv/vGNdBec0i
	4wKv7FlxwuO4BlLil9BHY8s0vUovhNniY6akoL6M5+GIEa4nmt5MAf5Wxyks9bpYPEEzOfWLXjz
	AxRvWlPGc88okvz4axWsPM0mVNS7RyN/m5YuxJ/c6tXh83F5a7nCm2/y9Q==
X-Google-Smtp-Source: AGHT+IEb3AAXx450CHT3X4sJHcYFuFRnrOa0Wtro2OVV7iZoGqDtgKKM45CVb4D9W9wgZ/MHOLVZvg==
X-Received: by 2002:a17:90b:3b48:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-2ff7ce7b5f5mr1842947a91.4.1741306076251;
        Thu, 06 Mar 2025 16:07:56 -0800 (PST)
Received: from [192.168.40.10] (mail.geicp.com. [110.174.97.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa828dsm18349095ad.231.2025.03.06.16.07.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:07:55 -0800 (PST)
Message-ID: <6e28b1b9-a08e-40a5-9fff-668321fb0eb8@geicp.com>
Date: Fri, 7 Mar 2025 11:07:53 +1100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Content-Language: en-US
From: Grahame Jordan <gjordan@geicp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

unsubscribe

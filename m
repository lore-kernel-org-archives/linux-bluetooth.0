Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533027D77D
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105135; cv=none; b=p8326bfAOrb+4i6V2NGkz4/jDRS0j803ABtCz6QMwR4ZG0FGTtIsfOhFbjOXwg8lOBF2eTx6WCRlfRGu+Ghu50+wkExvZmhUL4er6CvMRWvRz+oncdAL8vo0d/iWDVruSyIDe7Z1WU+i1wB9xAlDjmcQOJIiSoNISQspZXJ5tFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105135; c=relaxed/simple;
	bh=D7AdAk1ji8F6aA4zIawDrLB6y4A15KlC0yUcOvDH0a8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mFDYs4dFiEfW5YiMRnfI0GMtcd2vnYUZsoxBcJqKTSbCTCLnwDT+kf626LyF+f50TYLUjo77Xx1WuqCC0V0LxPzIibQn+jvZRnfrHxhRB5CB3D205D9E7MF+iiOScF5aao9nm2y9Kj8V1Xyom8Q1HncAusCsjq4Oj88q/fYz6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e6sQbFFP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e6sQbFFP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so1193655f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 23:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763105132; x=1763709932; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIjmDIwDl5gldZqV2orqiDkLfP17BrvhdqqdLw6RjY0=;
        b=e6sQbFFPDNif9lTJWfDjMKa6GMrKwV4EHld68stFxulyozVkCjHrQpV9z5HT+rU90Q
         oVrqeiYWt5aTvg1BEsjNfY43t/m4vQUkD3xodjR7tPRK1JOr3VbRwrA9NF6I3WowZ7LN
         xS/asKYPj6IALS3P2EYMNp8QZBOfY3Gi5Vm+PQkNmMPPkHvvXlvkSHgavL4z7Fi/04b3
         +0G3l1bWhhpMUZLPkujsGNE4DodbJQilaN38Ra6bLcU5BajW4lyntyyvbEFhW9UcpCor
         egd52fuZDhiupfjnVMJpPUwSdfgQ+coqmS1mM5tLnc5q8BiUKDXJmfVo/qVi0rzLsWK2
         UhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105132; x=1763709932;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIjmDIwDl5gldZqV2orqiDkLfP17BrvhdqqdLw6RjY0=;
        b=FMgNQdVDxHYC1g4rzzu/ZRhUf9Xthe2LEMnDvBPTpIREBqF89QvesSUjmIaJBQzGLR
         snegvivgvkvEf9D8ZeisvUdbD5F2b8nzQ5lKIFVLnQ1/CjvMmbXiY1WtdlZF7LBCA9dO
         pajKQBCj0SscCR0XtJ37+IAd1S/GiY2rvXDUSL6R3li0z9+3t9W9i62e8QCZC1CRR0sq
         gZgKDYj73tMGi2WHoTBowZgC7GZlPQ8HTmNIpyYUiHCRCjXQlCukFBJJixQGlwgA3HZc
         IzbXieGUw71Tjl+aGNzl6IzlsDsTuRF6rIKJtS3QAH4DhHgPH5uvZMi0brGjvRhSlDf4
         1lRw==
X-Forwarded-Encrypted: i=1; AJvYcCVtzDJ4b1IfqkZkZvhvONjaFLBTpsfb+3K+KHOVfqU3Y9juKzsxk9haZ9cPSo6yHPZDVxMiVMLLavxIREP0VDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRBSfw5vH3D6ig2+mlytKxX2EnWsdrPZiQ7L6aT0/2TeowMwX
	Ytrix/s03Ot4PUzaZiuy8aguClGV8GRf3Tfj0Cb7eCPEx5ugn47v9Y57neTvMuJqg4WvW7f3goN
	VBUmr
X-Gm-Gg: ASbGncv+hnFLvChiPOESVAYzxajqZOy/wPnvZM6YVGCZd5JCCT+0dDRIFOTYyQxMwjZ
	U4lEsMdKG4dQ8ReJvzWIDxa/ZjYnVDRqoIEeBO3j97mRLdeNYjlaD5Wsaz98JQC+Ddbc6/Ku63Z
	YQq9110VZe7Yl0lvxpJDEwy1Yt8myQn1mGXhTF99Q/K7ZQGi1H4pLran5oPBSJHpyXdbrKWWjy6
	OOOo57jnlRAeitE96S2N+VGLJceB6JJr733MUehHsbHNlciwIyL3v4KwFO6wRqcQyoqoF4yl6dk
	WVmNVSIKRSwTWfsnYHg+vibIqdsJf1IFUIi8PxqwzyDTU0txleKIulOeIss1BR3P7J+C/wMb3U7
	VV+JizGLb7i2EBCT9VS9mhXOl33HGFbsde5oMIsbvpP2twVt8y/dD5jX5K/T5Mrh9/nJK3WpLZA
	DN5Av96Wqeo9VMpYyLqK9N0oO3515jT3S9uSKUmMQYLl5ufWemLBnUc8VnXx8DHOdx
X-Google-Smtp-Source: AGHT+IEKNa6fLW0mCB4NHJ4UV59nmiqYkf+d49RDn0qmGNZHjVevsUvN29zzXJYhMCclKAqUgV9vsg==
X-Received: by 2002:a05:6000:26c2:b0:429:c711:229a with SMTP id ffacd0b85a97d-42b59589fb5mr1836628f8f.56.1763105131722;
        Thu, 13 Nov 2025 23:25:31 -0800 (PST)
Received: from ?IPV6:2001:a61:1342:f001:87fc:2caa:2b56:4d1c? ([2001:a61:1342:f001:87fc:2caa:2b56:4d1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8a0sm8368516f8f.25.2025.11.13.23.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 23:25:31 -0800 (PST)
Message-ID: <18fefbc6-4912-45b8-a07d-173f2434e971@suse.com>
Date: Fri, 14 Nov 2025 08:25:30 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: arkadiusz.bokowy@gmail.com
Cc: Marcel Holtmann <marcel@holtmann.org>, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org
From: Oliver Neukum <oneukum@suse.com>
Subject: needless flag BTUSB_BARROT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

going through the patches I looked at 7722d6fb54e4
It defines a new flag for btusb, but it does not use it.
Do we really want to do that? What is the use of that flag?

	Regards
		Oliver


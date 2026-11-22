Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341998;
	b=IkN81BqlAFsKig37aSn+7Ui7KUEE+rD0z1gAgg1TX6Kas0HTO4zOXk0c9v6UQqi0XOKb
	 6HmFt/5gG+jic4v9rw60QgmYCGcbyzfDEbFzenW+amDRRBS4rliPOrLRoF7pbsgNekYbF
	 IaxZgdCyHlOkg24b1mqNKHERMI5CivhRpTW0EpiTiYfEcjJdVYZHIdjg2Zx3qavDwKj+m
	 6VFVkHLnaFMgxsrUX6To9ye6ClvYrtnXhoR7PTk2tm4WxN47d2jfTm8SJ9ZWOqVEXGXhr
	 J6Q7EIYG3nuB22Ft7R1ky01xW06lP2Yw81dJtnaONeCasRbd7Vm67BoXl9UzVnBBZZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=5/P+8k2Z/9pdxAAQHRY5jv0iuk+Au5RMzSCINzUJdl4=;
	b=ybF7qtsRYaeeitwaedU+ZHWnNx7F93v2bB24hEXn6Bzumr9mO65j++7lg/d17U9AKS99
	 OU4nLHUe3oHKFAp+vPRMx0hCaDHRQztzp3MVAjnbNl57pu/sfzgAiGGiATEwOkUzdp/wF
	 mJ0qnwLY9VGoYiSwhByB+jnbV1h9LursdJXk3FjXbmGAxvnyprT/B1Fr4WOQFzICh+mrd
	 64GL1sKyJaFqmRrjm1bFGPyUQ7ySxv1snpRPAWZ5359f2z+3rjKDMZPxyZUkk9IakqfFB
	 XOzdVTGT48a7UcHqTLcwrgnRia4DVVx43n7ZEVQ0hG1Jp2KFd+bWi4blZpevDtugmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r/CqAvUK";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8E606A32C
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF8E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r/CqAvUK
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3869b68caecso2416077eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795341997; x=1795946797; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5/P+8k2Z/9pdxAAQHRY5jv0iuk+Au5RMzSCINzUJdl4=;
        b=r/CqAvUK1t4UkeI0YBdTh5BwAEyJ1Q/2clLkirADgX0eYUej84QA26rC/tOXDz22Ib
         ao4nV8FWb0R759BHN7bHQqpoINIv8QRunevKRvBFAp+50qHSRpZ8Sqv8TeLXfh6kdSR+
         CkpqwDnCreE1rI9Iyx9FtmAgYHtPL4RyB/+DMyaHkXU5jGk9rTFJ6wtD+cnRRaJcYYhv
         Ojm8E54hoC1e6XV6Y1M+bC3RxRovotSJvesYWD1aAJFFKSnd67cAyrbfK1+0keuqIiv1
         XZsw4pDkg8pRymq+GIOtf+5tYeXzT0/8rZM+7Li221MeXtxovVsnwUUuTOXb2ONWfaS0
         WWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341997; x=1795946797;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5/P+8k2Z/9pdxAAQHRY5jv0iuk+Au5RMzSCINzUJdl4=;
        b=SsctIAZm+hUMz8TjMfj5rxoHtA7SqAFHgvOuz0hcH8IkIkqZA03Q9oWvJmHWwUaohA
         xN9Nks1kg1dPrJ4Xzvnl1Ws8ow74aKj1+W6IelEU9zrD3uM/nZ5/VgU4NRny8qIB+rdH
         nNT7ZJ+q67vpvCeD3w8bw0tQRunrpK//GChdApZZOGnNulOHBRj+cjMILdoJyGmiNu5b
         jazIw5nKUEHcoQlIQjEr8SOa4bV/SD3PkWyG6BVffhEs1L5ekEvvAetxMHXxZvbiFxfv
         2w9JeML6AYe8GAcnzcMWsEelATsbjggZNbzCCBuNyTqabqpX9G1c17t66N3kFfUa76io
         0ITA==
X-Gm-Message-State: APuU4Z9PxszNbjTd5/iG8HW2dcYX+86EsLki1yK+dEkHtphKuJotvDZZ
	ue+GSHD5WvNlMCX1YYMD0exsglxDjkuBqwL2icA3Qd6hrvnQfhzhqv5tQ94yTw==
X-Gm-Gg: AZFdTZfiUAvgM1sEPBaEDFi2HlE+87F6gmR4MOh/fs/g+sJ1bqqk9T+iHBOroxBKpWp
	e5NuKU/mIo1mLnc1y4vzgrP82bIckd98sUnXiCe06UqgvqE5c8ecepwGui9QWHfoq8n+OoprFbg
	4Y0D3M296NFChlilWtdTfwdE4d7hiDywwVXs8NMLqFFBT+fvvHOoP6jiu3wQHk1eUxfAOg31IZ7
	dyUjUWD2ggICgsLMIULoiOU5C7+2OujcoATCTLAm0YYq33LHRSY4IXiFfQVbh6orgNBejE79iZ8
	l5E6vAncxeIIWfY8hyRbXGh4fcGP13l2r6MZ/ElhZITOeVLVZRonvFSfpc6pVdiG7twkGzQmxHW
	aPYD/6xPuWJlW8hg8hRp5UPkJCSL1NDcqKs701R/x9pF/fekF+/G4V8mppXz47PGtZOzxH1Rm+t
	x4AioIEshTFTWaijVNrGhJ1xr5SMlg6oqyeNxZlt88zSttAsP5ZdPOlSw7Seen0xia3Z9W5dHBS
	/0oVN/DBFL6BcRdcdWyzmMQPLd7HHpAwB2OA+zzbR+eR3n4imds1stocoXNCg==
X-Received: by 2002:a05:7300:e9ce:10b0:36e:e349:f2cb with SMTP id 5a478bee46e88-3856fb61551mr10001225eec.19.1795341997480;
        Sun, 22 Nov 2026 02:06:37 -0800 (PST)
Received: from [172.17.0.2] ([20.169.103.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm25925788eec.9.2026.11.22.02.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:06:36 -0800 (PST)
Message-ID: <6b02beac.afff5b00.15d929.3241@mx.google.com>
Date: Sun, 22 Nov 2026 02:06:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2436108142042674292=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v3] asha: Defer BR/EDR inquiry while streaming
In-Reply-To: <20261107024655.1481992-1-cochcoder@proton.me>
References: <20261107024655.1481992-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2436108142042674292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC,v3] asha: Defer BR/EDR inquiry while streaming
   Pull Request: https://github.com/bluez/bluez/pull/2778
   Created:      2026-11-07 07:54:54+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2436108142042674292==--

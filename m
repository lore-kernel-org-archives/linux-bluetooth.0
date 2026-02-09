Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8A338F4A
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623979; cv=none; b=lTMHMs+jryudwNc101HabRwbn2FICb/Egxj4+CpA/KiGgdiRDJftVyNpl0TBpSNQtKNbNnpDVFd8ZgMyt3jxcrYFsZT6gJ/ig0fzmrjirNBUvIdHAvAsdIhuExgX78ZKZBI22emb/w9ukWRdqDFKpfAe6/ksgf6ptkr9bSeGb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623979; c=relaxed/simple;
	bh=y+H9PU17RIdXtanF+bWj3MjE0FILcgkmVDbdbvO/leI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CKrjF9xePsJuv05PuTbN9KFqqvX1v6J+mQZJjAep1ErY+sYLguyKwSwUDTHsBYQn13nuEi5Kvim0ZXAoVAWmQD1l6VXLwrk7cGr8qb5onO3t116YshHAwVdhxPDf8Zpb18RnYKYd1GFfs74yLNhPyGJ+yF+bjEF09e8vdhKbR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm3xsIYo; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm3xsIYo"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-503bf474fdfso38554401cf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Feb 2026 23:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770623978; x=1771228778; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y+H9PU17RIdXtanF+bWj3MjE0FILcgkmVDbdbvO/leI=;
        b=dm3xsIYov3HcOcdxFpBxOE95tRDFUeMvQIdWtPqD0cQEflC89ELYqMNFyEIh/j/TwW
         HZj2wMu5HTTcQ/c7cCA4tzlQdJjQOErDsjUDlXjGLOYV4a2LZJnaKqjWB/qTzUja9S42
         7nDsfpiENZt6cJBNo+YMskcgs4aurbdH9b2IE9WrxBYHbDdNOWmYMXtBYhUlNcfz3mh1
         Q2LeN2a6lZPhplTN/YhQHLJWSPVMG/yGqp+FQJWyuAwHrBIUZD4tMqEsZ1g0WAgLlrsI
         HPg3kZQrxL734HHbFtbzRGZFVE3M+nHcMdL+mv4l+fV1aoJVvJiI/FEUTTe3StWFmPyS
         Qtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770623978; x=1771228778;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+H9PU17RIdXtanF+bWj3MjE0FILcgkmVDbdbvO/leI=;
        b=oG0QBlVjEyIBNGYErMYfGysYhaOwcp7JZQiKvnd34B9En5D2F2cDNrn4w+kDtidKe6
         NY9o20WwMkQPu0SYvfQpjBhF8r5FmlSKEviHIGjME4wZnd1ROa9jXmP9CqikmIrJTOjE
         M0e64hch2uBehI+vtO86bp1wXQqCiBMG8E+mV335mQMn2MJSt8gQpFwSqTdJZWdmqOIp
         9L9kIJgZeLDTm2TpvPTHoSj2ot55nLHDtPG/Vkq9voT2l1KHIbslheeP0t7MlXxDb8No
         XelEIm/yNYD5dpRDG8lLSdU3mpBN+f1RprcG7MTVwTr41jrwfEICtWUzkcxT67ghVHLV
         mctQ==
X-Gm-Message-State: AOJu0YznpQDhpF9Htz9ZwveWxqrzegB0ZpqTVbDN/gkQkxCTtTZFCix9
	5VS12RyugiSW29JIzmgg5xeWl3WOIBIGuh6V8JSFKPRmLNXYVli+R3hAd90kGkou
X-Gm-Gg: AZuq6aLevtFeH6NuoKZ3e5hCLZSlYP/vM42JOxIVBsSqVWQXoiL0BqV4Ej+ctHHmlwI
	1QkK2RhqCK7eP1I4VKCgPccn2Kzfq2OJ6cpIpaHCE8XEpucaZna8VpAIAmYbBT/W9b9nBwd7FWG
	Ku2x/E8Nyp6IaDHd+c247ejQg1gdukXBlU2bZqlCzcMiqfGLdYuNa986Pr5PQQUPtn6Y9Fw8JZV
	EzdV6WQGHHzlfcdDrnS+69tWCkV+4v1ZhrXoChm6N6U+PcRamJzCHbaPL+cwx7Wheo+B7daQO3d
	skMZmOwsqhgdSrJagmyMrmfSk+YgiDpZ344qIAYlxCwVkwWnMkQwMJHJjoUJLBAbUfgi0LyOtyV
	cRcpRAMLdvFvJM57D/8FfhBIT0moGL7ZaU3mxuHnnNm7QZ0ABT8xlV5PuQAhsdkqpwJpmNaHoPe
	zQtjMm8U6xmRG75FTf
X-Received: by 2002:ac8:7c50:0:b0:503:2c16:c205 with SMTP id d75a77b69052e-506399db6e3mr141951741cf.84.1770623977912;
        Sun, 08 Feb 2026 23:59:37 -0800 (PST)
Received: from [172.17.0.2] ([64.236.201.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50639e26b9fsm74102721cf.15.2026.02.08.23.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 23:59:37 -0800 (PST)
Message-ID: <698993e9.050a0220.36cefb.fce6@mx.google.com>
Date: Sun, 08 Feb 2026 23:59:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3371396961084859499=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vivek.sahu@oss.qualcomm.com
Subject: RE: [v2,1/2] dt-bindings: net: bluetooth: qualcomm: add bindings for QCC2072
In-Reply-To: <20260209070356.187301-1-vivek.sahu@oss.qualcomm.com>
References: <20260209070356.187301-1-vivek.sahu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3371396961084859499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3371396961084859499==--

Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D239DBF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462769; cv=none; b=aTeTGEN9yxpfD73YT/m58lY74DC5bcn/9NZP+dpF3nhQtokbtVIandZDDM/zDcT+KZ9crcfQXflG06twBHKOBN+ySwuqGx2EH+vMvP2CqoW+xU6s4btrZvYEA2/07OsltD1EJFKtG465ENkNp7s4NyY/Q4wiGuSiSQoHJkJITCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462769; c=relaxed/simple;
	bh=4wWCQCUYOkcygVda01bsR7iMATUmYjk0KUGvPUuLF+c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=suUHCpTkwGAe6ojm03tHYJrxtL9R7nqdLvVb+a4aNRXiT7yXoBOlWumd6gFX3xqMn40cTfq+CQUkhp5V5TLW+mtv6fhfpLMcqu0fNjBs42xicK5xC0kBT2JhGTj4mf6WQlqj9rsqrbpAMTCaZqHipb3i2Y58YTGEppM3p6YBF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHGRECm6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHGRECm6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc61541f8cso16605715ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462767; x=1784067567; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4wWCQCUYOkcygVda01bsR7iMATUmYjk0KUGvPUuLF+c=;
        b=hHGRECm6h8vCLhaGXhor4nBRPLFcYxAtd5heqH9+hVJt/BkapT0BP/x9f3LBI4KLW3
         vIanURPnYUOmiKn7MB69lz8ynEfEcXIbZ7H8eZxGfkazEIED+Y01vLqVdBxQjA41vW8h
         zd4pkKTJLoYkZEzw5XiiNQKqt66yxII2TB5rwMQjEKmq65gifHhMZzF/kh9T4YRmpVoj
         UWaILmyTSMdPlJhN/gKd2CiW78D4yFSAAG/dXo8BRwEI4+jxVpXdYxocEsblLm1wegW1
         KWy9S+tX91K6D68N2szvj5gIOXAVLGtIWbl/DTGGl79J2qY6+vO7bPWXkHR1NFRzH4zP
         bnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462767; x=1784067567;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4wWCQCUYOkcygVda01bsR7iMATUmYjk0KUGvPUuLF+c=;
        b=SdRZmHPVUHGhnyeMe2WkezGFWZgoz/Gyl2Rt3d+sttiSKGhe4Cv90YncgTZr0Pds0t
         9uK/u08yDGkNp13Cg3IugM4WTcTbgfODJ8DPxq23JgnqEStywH8MlujQUBgtZuil/XPt
         0VMNtsGyluBoMotyiioQy6TPQyq4KMBEVnX0jQPuhQx+aLVOhfHoYpAIP3uLU67LYCWO
         nW+XUdo0OFh4xAve8HgI5LevGNwoUSKTjoIzoBTMaTaN28xD9v/p2HsbGETaMSl8vGG/
         Jy9oqUGm+Z6bPW3wLTrXugXSxytag7r0NrlL4hxip0WMLdhkCmym08Tr4qyn4WZVViAe
         EvGA==
X-Gm-Message-State: AOJu0YxV9uTReqAb1n+2KRerE6jO1e5HZBBOkwTQyVsTC3pN5Y8CTZG9
	sPUg9fXSrtPYIsK5rkRDDX6b12zFodCh3TYaIEzn8h+TENIajHtPpMc0pnj75g==
X-Gm-Gg: AfdE7clM7ojrkTifeEUqKIKsbcnpYXSpKWCJfjNYS7iYy7Jag5PVAEXAry4eaW32Ect
	8C+f/c1vhDraYOJULFy4W9vAHSVgLR0FPjYYY8vHroWtYJiQJRpb2u7rYC7wd9tBNzTLh8GE+nZ
	UrnPBiQSPGdiW2T/qWiHB5w9Dnur3b3xgnKrhPJQULi9ZalrNiT4aN9mTHUdPAKkrZNgey6AL/f
	QjwAP2NhEYGtOPlIOBV/YbodYvA64aW5YOp9Q5PJstC79qLdDeb7aunEDmBGYSd7VZLLZii+uJC
	5n53rVLX8flGa8RcwKCUvx6ONJysWaZwbcBv7Zd5V/qPDBtDeS2cawRcTN96P6NCbOxyMzZFq6V
	eK/3oa2UUeJ+eo9XFrvY3M9bA+axlw3b6Rjqm2psv1JAp1mpm9euanxOAkhj8dOAcMV3i4gjTAY
	wIefeBAo1fEIqdtTJgEuBSSdotSIc4c234
X-Received: by 2002:a05:6a20:72a3:b0:3bf:79b5:ebdb with SMTP id adf61e73a8af0-3c09b2183a0mr5782082637.21.1783462767353;
        Tue, 07 Jul 2026 15:19:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.219.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm9200155eec.18.2026.07.07.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:19:26 -0700 (PDT)
Message-ID: <6a4d7b6e.eb165e5c.1817a5.5e61@mx.google.com>
Date: Tue, 07 Jul 2026 15:19:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8675044402377124886=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mendozayt13@gmail.com
Subject: RE: Bluetooth: ISO: backport missed OOB write fix to 6.6.y and 6.1.y
In-Reply-To: <20260707220526.271712-2-mendozayt13@gmail.com>
References: <20260707220526.271712-2-mendozayt13@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8675044402377124886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/iso.c:15
error: net/bluetooth/iso.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8675044402377124886==--

Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02657485
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729467434; cv=none; b=OLj/o/xyK/fvOBsaenvLkg0QROzifMZxM+EJoHZhcirH+dI7/JjENNspkr4A7kdv3VwM3fAV7HQOumYU9Ohxb7C1amVxh/N/66qMEpkeHRPS/W3Rv9NDM4DrUMJeIusAqI9vC7GF43JCSStuIa8KdNFOWeoLdKCCvOVuKLlEJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729467434; c=relaxed/simple;
	bh=2Uc27D4XztUP2QqccsqZhRmq2b+5QLyQtmWfrNreA6Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OISy/k3CFNX8/a/8cDs+Tp8UOd7iBdbmMCQa/b11YmsivmMiBRW5lmiljd6juHJnTXfvLIXyryaDhZheUjUwgSNiV7RaYhck2F1AZqFWQB0s8EL8/uY6yCJe/NG0Sr23SZC+kgltXSfwTBe43V7XNC2VeeuWa/HlflaNuQceLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUQCCN+Q; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUQCCN+Q"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b15d7b7a32so183779985a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729467431; x=1730072231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uc27D4XztUP2QqccsqZhRmq2b+5QLyQtmWfrNreA6Y=;
        b=BUQCCN+QcSQsZTyK1wZct38Izg64rdIQyirvfnNjqqi31f6PvtLKRm0YI/ZQbqz5XR
         l2LoeUnTSu9G7T7yaQpu5Fd5f+focjhESwjPWVDruGnquWwZ5zBov3Og+uklDU1dVolE
         Sz+yiq9XFVWam5pZewSQ+V18wqxmXUnmIBlguME5U/BfjBD0i7LCXoyX78Ly0hKwR9O7
         h31VFC+VKe91E2hd8SSQs7YfgJyf9IxzEO/bTu51JJ/dSSSEX5onryFq0ZL1zlXCQK8Q
         9n4x2WjDTv5RsssA1h0c7ayBBkaYMHnz4KDTzVJMnBZgTQFPUpsTq/FRVX3I3WPWOgYF
         Dskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729467431; x=1730072231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Uc27D4XztUP2QqccsqZhRmq2b+5QLyQtmWfrNreA6Y=;
        b=eDyJtsNm5G8Z+cLAu+Foeolc5qQlFz/tnXrqnuTN6t2N/H9ujZUrSED7ZMydqRrcg1
         BmqRcK5KMuJhqAZ+cuMfk+6to8sTRu4gH5SEUeBGdNYui5LwCAGW5vo39Ebx/lswgoQj
         iQwvkgvXH6FMFqB1NumoMfkYqStFoTMAKwjvZhl6xnHkDvV04prMaB/ZIMk2Ch2tkdfx
         +0Zw2PBJH/bs4QXFyI/1gMdIrxvVfImtsjcetd4Qi+3Ev2TYreve2oMKqR8PKztwKMzV
         loHgsX/E8sPrXJZOlkHsyTALfTpaht35YXj/3MJxWYadSu5ZwxGSOf5DV13F6L+0KOqw
         bZEg==
X-Gm-Message-State: AOJu0Yxh4nbmsHiKLlOzpzGImvW9m3oHEKrdRVMwd33VwD2QpJhIG/d5
	2nCmmaNvi1Vy+WK2bYBqUqVIjz+YN9JlzNptK9wbgDmD6ZomvCmNMvdqMw==
X-Google-Smtp-Source: AGHT+IHYfOcwYKHkAQJIxSlHbWgdKS6K1OdZZ3xcqH3UVsYehycfqDFoVSD1z9Pgt9E53ziQWs2JLA==
X-Received: by 2002:a05:620a:28d5:b0:7b1:4436:cf1d with SMTP id af79cd13be357-7b157b6ad45mr1282257285a.31.1729467431335;
        Sun, 20 Oct 2024 16:37:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.52.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a78cd9sm117350685a.111.2024.10.20.16.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 16:37:10 -0700 (PDT)
Message-ID: <67159426.050a0220.34a86c.27e8@mx.google.com>
Date: Sun, 20 Oct 2024 16:37:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6868361035929094415=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tot0roprog@gmail.com
Subject: RE: Test information on BlueZ mesh SAR segmentation
In-Reply-To: <67159293.630a0220.14043a.3c56@mx.google.com>
References: <67159293.630a0220.14043a.3c56@mx.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6868361035929094415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: mesh/net.c:2358
error: mesh/net.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6868361035929094415==--

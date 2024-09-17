Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30705291E
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573112; cv=none; b=Ti/8bHmppW9pVv+qLAHt+D2Tt0m6/wW6ir7ENHqm09TxgrjjxpjRTZLy5qNhoWNhULwKQKRoebqWitqyH3ojkieNZ/tP+Yo1TCkkIMiPI2k5ySpApUUptlXMgVLM/g5zIfSDL74Z9clYpjwr9/BOd8IBjK1vircUXrhphyjnal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573112; c=relaxed/simple;
	bh=yZD3jRDO+NYk9Yhj5COFk1TUxFJRw85DwfZoXwbrk10=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bALZD2j8NFK1JjpQvXWf7rSadbO9G2yONZr0UaKWgR6nUaP11+u4S0x+3uUzy/FAkOYE6fxIwlHa5nBGyq2qfzw5eJOkIk9ARMzv/4qHPMaGx8L6YLRowhRMRgVPBqPdOd/zifPlpiZVizNJghlLEX8BsQytt5x3idstS3LaB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNdrcNca; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNdrcNca"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2068bee21d8so54560835ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726573110; x=1727177910; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yZD3jRDO+NYk9Yhj5COFk1TUxFJRw85DwfZoXwbrk10=;
        b=iNdrcNcaNrcQWEeVxQhk1FMenipezuEZOaUWn664YyO472r0MFnfA/l8jJIpiO+pgg
         o5KXUDGsZo+8HXpd5X6mK/B4HcgRXxvNX5+fN467LdpZmVDOuccbKr9Jsb9tsW3ds4iI
         jlr/DSbVMODvU2DnjweCCRMBTRNTOaTbI6lLg0dI/cL1+WCtmUyKua8xVUj4EAGqn9Zc
         55/ZrBvy3I8SOQjy4mN2JIFnnyOiZ8QWe+MtHILnMtfnSo6KLEExdRd3hNsoIq0PRL2C
         J3/HujDiX3F9ArB688U56Hwzigq2thnHSqj2jQnWnfNOvHEzgzfR3edQpQ+018CiB8kr
         ImyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726573110; x=1727177910;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZD3jRDO+NYk9Yhj5COFk1TUxFJRw85DwfZoXwbrk10=;
        b=gSwx4oRdVdaBByI/etT4ihev6HPoqtKKYPJBsRTPyYCTDA53mVT/6YYvsGiT4uPbKv
         hkrLVQOmxmLaHaofKvL81pU7N4wUzQ2wbXmVTl/mSazyKZugltFGPfOno7jBq6QDAsDQ
         ozhoquJDa2QPyWYENMawvGnZoBqA41CyJa5WPpvRCvXdzpzHyHzL9MmrushzcsBOiTEW
         ILvnem/mhFmjGm1MzvPK9P50NvONFBiVTA26Mzpc6yCV1x3qiJAdtK5HREfH/OOAEdHi
         cVTtTxzxaz5h+2Xa0VVsc6WJN3xPeEiOrgH/AiBGHtL7Hv4chryO6pZMntrWlGTNmkEe
         VobQ==
X-Gm-Message-State: AOJu0YxH1kE7aNx3rXdPfNtQ2W0t7pXpyu91EqAgEbZXK9sL0UqHSTPR
	doI5GwHlkG/hvLTJNsYT2I1Gw9KByjOjHiGX9PYvU0pAGJHqzG7GLWj70A==
X-Google-Smtp-Source: AGHT+IHX0SmkTtP/PN97ymQZkBmOtPgDLZNMcEwhx10i5gZibtHjrR2Gx4aw5TZJE52F4SxuPPAZzw==
X-Received: by 2002:a17:902:d4d0:b0:207:232f:36dc with SMTP id d9443c01a7336-2076e43f722mr249523805ad.50.1726573109973;
        Tue, 17 Sep 2024 04:38:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.27.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da827sm49270705ad.7.2024.09.17.04.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 04:38:29 -0700 (PDT)
Message-ID: <66e96a35.170a0220.6ba32.f729@mx.google.com>
Date: Tue, 17 Sep 2024 04:38:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0802596696384234773=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, amishin@t-argos.ru
Subject: RE: [5.10/5.15/6.1] Bluetooth: btbcm: Handle memory allocation failure in btbcm_get_board_name()
In-Reply-To: <20240917111422.33375-1-amishin@t-argos.ru>
References: <20240917111422.33375-1-amishin@t-argos.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0802596696384234773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btbcm.c:551
error: drivers/bluetooth/btbcm.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0802596696384234773==--

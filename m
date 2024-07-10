Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760E848E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614226; cv=none; b=Sky3yIFyMDUL+1ydl6q38RaI+Lpbd2iEYjoQ+87d6mREh6Ckg2FkDjiW6DI+25rCxDFTV7jcloWvpp/RO+n/h0of7ccbHRjrECMBXlFDepoRyMTodJ1WT8LinSK9NgjUMu2JKISWXoJ0KvJcQf4gcC7JLOq9J+rSMQsOX5LiOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614226; c=relaxed/simple;
	bh=e6xbi+ToNVOX0OpnSNcGI41WULkSTx0aqsDnnvfA+/w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OMVsyLMzeU5NpYYKTqGxBNPYqzqcf6oA4PF+fJU4kt+AiEiGY76Cg3kjjqfxqshZp5EXN8e1mp1wYvpKfjoQ+n2VslXemRzScc4IvFGnvCV/bdcNkBtLtrWh0MvYLydJdo741cyCQxLYL3P5RnThlYffBHDaRkHLO7maiAbJsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCgQHUrX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCgQHUrX"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b3c0a00f2so1898307b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720614224; x=1721219024; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e6xbi+ToNVOX0OpnSNcGI41WULkSTx0aqsDnnvfA+/w=;
        b=FCgQHUrXOpHifyGJrj8A/O0wLKpz/WD5gylZAyuM/Wq588A2UT0Vqj4JO7ZRmFkjr0
         uqY8zJGcp/OIBzus0WIDkrGKiDvbtfANvdLCZ+ZzFeAznzBbCXiKsvE6cR5ziAGoZF50
         VYFr1rflcjbrwbjrM1sMxnu9embmSr4Ttlawj4wHkpqrUC2AfJZdgZCMSYe88wD1KoIp
         0VJ6oGJM7YUIJYssG6wyW7jViPnzEbLpOkTyxKpNQxdHM1o6VqdJuIu8OCQAVLb6Ff3F
         b8fj0hi+BK2MtZnAxlePxH9g2jYmmskUBixSU0sd8GBCEu5bugsyNu7viL+gohN0iQ3p
         qk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614224; x=1721219024;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6xbi+ToNVOX0OpnSNcGI41WULkSTx0aqsDnnvfA+/w=;
        b=lHkrsDx7AydxVdyZtAKY7sEeH0RMRhUONXt0RtsyhlV+36Z/pUgyelpqTrK0Mzv2/u
         JoEBBE+4X4QLfZ6HaupgUwiIGLsS8BxskDdNv3GOEqbYZmDTQpZsaUfTZLcDCRwwJdth
         F6lKXbXEG5Zz3AVDzX+q3pDQ3qsl2tTXe9AqGP5Qd4BDkKWztvQJqjHYZ3eo82HWgfa6
         flWYiDUfvl2fCwKtrHTxIMKgY5jK3Km9L+HlLMZ/gJpRD6w6PabqT5N8WtWUepfZZ7kL
         8o9gFHaNd7AB0FpcMGVXFtIV9UvHn5MIgWWW5qdSYogK6vnQvGUlpG/1z7AUFn18e31w
         3R/g==
X-Gm-Message-State: AOJu0Yxr6Fai0+RYCK481gnhKqQSyo8EWZ9ZGixV0ZO65QpPS+DPxI5Y
	HaZ4iiSYIR5jAWblt3rkEQHui6KK8jiUg01+IfJtZVaqElwaZ0fxeS7sFQ==
X-Google-Smtp-Source: AGHT+IEI3+KOb2cwOPH7qG8KPajROPjCTzqWl1vPOAwPbhgd82WLm031GjmmL3Ui5T8n5LiAn0vI6w==
X-Received: by 2002:a05:6a21:1690:b0:1c0:e322:e8c5 with SMTP id adf61e73a8af0-1c29821b544mr5319160637.26.1720614223988;
        Wed, 10 Jul 2024 05:23:43 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.240.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca352bfe4esm3635016a91.43.2024.07.10.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:23:43 -0700 (PDT)
Message-ID: <668e7d4f.170a0220.ee62a.0548@mx.google.com>
Date: Wed, 10 Jul 2024 05:23:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2103985407280751623=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Fix warnings for suspend and resume functions
In-Reply-To: <20240710121558.934069-1-neeraj.sanjaykale@nxp.com>
References: <20240710121558.934069-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2103985407280751623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btnxpuart.c:1515
error: drivers/bluetooth/btnxpuart.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2103985407280751623==--

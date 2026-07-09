Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6E3002DF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604680; cv=none; b=MR7D7ebca6w0mLMea3Xo/EL+TPL+tf0XfNMnQH+rZ7CQSEaC1u4+GgrOXbNorENIcR8NGupqYGCswfNPX9ftp7tWS+wkTnOCcQaTRyws755pzVE7ZY4Gms7rln+KX2k5/8Yb/74fgNtcjcckeHZZ5lWYS5wNsAnynJYrPqxZDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604680; c=relaxed/simple;
	bh=+e3rLnCPnclexU/TGq7To9ayodC+7dNeuVtCBIYlwpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNLagb9sjmsesxQFkureWpzlMEqoyAG6sPgE5QOW09TMM2ObtJojeFUBazQuMQVamUI9c6WmxP6L9g8eDtnSdKTkNNWOmatEMrUKeewCd17w8EsaDRrX4zR3YOd1+hIS55MmIem8gH2R9CvnLKmsRTqQYHpuwD0lyi5YHpTSFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPpD5sMT; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPpD5sMT"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-49ff971e903so685322b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783604678; x=1784209478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7dGLWuFqFGELNIvjyOuEZBSnAuzpWLyUsbUpEnwxx1M=;
        b=dPpD5sMT4Uhem8FljfUpzaVxwWwcyJx4IU2C0jYPgDcK0NUcmwvVC30xi7VQ/eBLzB
         +ijSx//CSzntCqJGmSON5MhvF1c7EipZsLfNKyCEBTir94UL1PS9cTlthw6wUE8VilqG
         Zo8jXjNDrRgFQcZV5CLZfVOHgpL0czm6iVChspTdlV2J3Toc/EK8LX446b3r+7uE00ed
         vcDEZ07bp+NHGUz9OjJqYJ/OUepiM8ygg0g25WnH/YA76ooWCvGseyEAlLW6ag5SZucQ
         usQHX1W0dIbUBceFeN+pqkYdPwnWMF7wME/IgNl8UXIBxzXB2gsc90DfU3KuyOlrY/ZL
         Z0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604678; x=1784209478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dGLWuFqFGELNIvjyOuEZBSnAuzpWLyUsbUpEnwxx1M=;
        b=qAo809DIIjABYZKb5qKVH6YmepCxUdCFMO03nHrNLPEPtl/GDsHDA6Gfv9pBEb/VW7
         Vg5Ik6qEsIu1pBVrDjeIjflbs4YB6J1RcHtMD/SG5MESl1dLCfdR3V2fETLoUY28qoSi
         LX8F0rHOhMY09LmqkcY+OJTBdS/uXCUJQhAO21Apax9GUnG4Z68IgeC4PEG1EHe0LkZF
         5eqYLGk/lT81bZEyl4XF8/vM+2DggC9EXkEqYdDHgLvC3746q9VW9LaX9KLQJrVKgfyE
         CwSfV56ey80MkDxeVihZWzXbGSoLx6TTTO1BfTPNBJfhMed1JRzlrE0xAcDQUHRnkQtC
         jaKg==
X-Forwarded-Encrypted: i=1; AFNElJ/scCwlKwoMF9SD14gsAjI33fV8nj5RsEfcum5CNu1OJ9eUhxsCHcWA9jG7qaQ4z2fS2CImGblpvP8P5ZTPBSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQo8+WxMrVI961tT87r5sOAnQ8+odWy9SbaK7m4R8vnbYy0XOm
	emk879+8WPU7y1r04t1UDvJPDxJ0BPF5ppGIN2L+KPPTYc6RfCMyhXGO
X-Gm-Gg: AfdE7ckP1mEPzxREt18onNOrn0DyBCqoQxZV4aofC54PHNGb7V7GNmq5KWrh+2GoQ13
	zUIMmbyiViZxebrtdbrxyI6hkaW32GnZMXvtIhco8YGvFWh0tXaHMPDT+57DxPUkGGFFF3o3OJM
	qQu+U/FoRzv8ORNnE4+PAGae39FKhaMgZUF2PhVDZjSvsgMsad5brLxvEBtnXIeQn+1zTK8CMMw
	+M/yVSjH6oKS8wfbevHEy2xlKbeB51zQXPePgMeEbnnKhzl2So9Ma05nHzDmy3MlPnfo08V42oN
	YFjSYYKOGLbkcvQL8S1uAM0R2aqN5mZf8lZ8sU6VK8bcX0zr2eSbZJ4LW3cc1fvoEjlhvOjxQ0m
	ertZk7JvIxNcxFl9LNs8SwR9tu9o0/NE0OO4UDlUBdIywNzU8TdteBaeE/FvS9H4I2p/krQ7W8A
	4a8/cJDjt879sCKeQ=
X-Received: by 2002:a05:6808:4f0e:b0:495:ca1b:7865 with SMTP id 5614622812f47-4a34d9c8f64mr3213817b6e.11.1783604678277;
        Thu, 09 Jul 2026 06:44:38 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1adca6bedsm3836998b6e.8.2026.07.09.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:44:37 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:44:31 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, yangyingliang@huawei.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <ak-lvwzHUfuFcRRa@stanley.mountain>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
 <ak-T4SMxr4rw10jP@stanley.mountain>
 <20260709083606-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709083606-mutt-send-email-mst@kernel.org>

On Thu, Jul 09, 2026 at 08:36:32AM -0400, Michael S. Tsirkin wrote:
> 
> why make changes at all if no one can test. in fact, why have a driver
> then.

It would be interesting to see what proportion of kernel patches are
actually tested...  Testing the code is often impossible because you
need the hardware.

In drivers/staging probably very few patches are tested.  Every couple
years I look at the data from where the problems come from and it's
normally from complicated changes from the driver maintainer.  The
number of bugs introduced by checkpatch and static checker fixes is
really tiny.

It's about risk vs reward.  Fixing a security issue is a huge reward.
Cleaning up the code.  Fixing obvious leaks and static checker issues.
Those things are all valuable because they raise the standards and
they prevent copy and paste bugs.

I consider a few things:

1. Is it a security fix?  I recently fixed some memory corruption and
   broke a driver.  I tried to be careful, I wrote a long commit message
   describing my thinking, but I still messed up.  And that's okay
   because fixing security bugs is important.
2. Is the code new?  If it is then there are probably very few users,
   and the original developer is still around so it's pretty safe to
   change.
3. Is it an error path?  Code on error paths is hard to test in the
   best of times.  The risk is very low.
4. Is the change small and obvious?

On the other hand, I often leave known bugs.  In this case, we're talking
about a use after free if the driver fails to probe.  That's not a
security thing.  It's unlikely to ever affect anyone in real life.  The
fix affects the success path so it could easily cause the driver to stop
working.

regards,
dan carpenter

Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B5374E4C
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156528; cv=none; b=XfUMYEtJ104onIRNh4lEKk2+d58pQveDFnPhKrETrSwBfo4BC0/dq148df8jbH27zvlX/E4Upe2PonF9cLEEvqKziJRrKDYdMTZBFH2WnL9s0MQIhizFRvQDcqq/Mh5m15piLQSM/6FRpr4bh9fy6hr8khMQq0DEFAcqKaCO7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156528; c=relaxed/simple;
	bh=QWepNxMosm8K+PEhFd+CXwNtdLqTGkOVfiJ4c1KwknI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfJ6XWXgKpeRhSBwhAX5tpQfbLfm2CnEa/bMmR1KsJTi8Nmt7Q1xx+ivrmqgESXeVGR5YzGKfbZPsqxWCvYpoCDaXF8qM1tKotV380EekDa0cfxbBXaHfc6dIwTzVYMZ2cJm7+i0TjZ2OkpNqtcMLMXClYOxxOHmx0eBWg9lMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrz1mGB8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrz1mGB8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so9677005e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775156525; x=1775761325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IY+l2Aibq910iYwrp0O9aG6WhF8bcuIuSpgPuu93FBs=;
        b=Lrz1mGB8CcOKCf5hNLpQmUHnqREDsuPIgAcw5PLcwJBzBMKCX6XKr3xnKkUUUqxIRa
         xZ9wkKMBe1LwnY+Jo4Ebow0NpijXUO8HujWC3TklnVKXXE7BBPbYIZZlL1LAuZ1ykL31
         2/Dioa/tBFtketg+PbwFbQQYTFESxDSj8q1FcXpghjvbolhIHq/JiTcCHwUNjhcekZtv
         +uN2qxnzlBc4AxJRlOqvKQwQqrJz9wCGW94HjfohIEueM64cSI+L7eKhDRMigskTwg3R
         RL8tPmOIsPc4b4b/XrdflcdiEiz/cEdmPX8QcujD4M10jE0bPZiHbLBjqmLhy0XsaKHa
         N6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775156525; x=1775761325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY+l2Aibq910iYwrp0O9aG6WhF8bcuIuSpgPuu93FBs=;
        b=MKSpsWYBGnFDiRFTIBucg3b9UOEjbbXuJitDj6R6ehWNUXQaVifkwja4wE3HiQ3LEf
         UroK13rh2W1nD4nySbFUKVe6o6TA7fLfkBHOprZw3Q8KK7aakNGNvR8T9OOSJMmt+Yh5
         qgYW+PJtN+wqM5o2aJdrAzoMah1hDqM8Mcj0mzkOTQl6MdCZaTNJopl0X87KH1x7Q4O6
         lpZZEoRGdnk7zTnsxVQ5e3HIEommDRTBBdDJgzeZ8gVNOeTK5c/AV2vPPLSVpdeebpFo
         MI8snX2EGz8/HCHKI7bip/694NYtGpVHBMNam2p2Z5V/n+92FM3gt9nttJPjDcpls67F
         WIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9JKH20wZFc2BhKvNmlfMfXDgwzrEaI4H/9IsbAZkIWq3CZlvIr0UtiVfMj43ahjNNxnQ9sfRGLfP1yfpQlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTBVTf4XPnDIFAjP6CR0VyViDefUyRPL6fCBcZDgpHeZnw97k
	xJQz177NFIvr2cuJlrAdb4axsNwDNBF0uHdVZdFUnUQR06pJ17d5Cof+
X-Gm-Gg: ATEYQzxGRPUeDFKBFEutruFw4OPT0g9EJOiVobslKDeRKMQXu0jGZ5rYto0/QWtFk0o
	tRY4J1ILYy/0UeWEC0a0Gwtdwb9Iv9SWMbpBrdjr7veVJevJR1WBR/v0THGDFExYK218gKaeVZn
	M4zE8ErFr/8sQvVw6/N/sWXjmwmJvIztIEYLyf6jXXQ28hE/Ya2+m4tz31UgPOIojexkZRHLqxP
	vIcq4sNIVgUCTzjQkrWuwhUB0hA9GB/IEGYt7zS2znPad+Dr9iHdqtboc2+v+fyAfg2itJ1QKIU
	O0oyK7Fds09baDboXJuVGb3R2NsTHg8kNNgYvwIbV9zh+cAbCjAHUamIjHqMFC8RVKCDuaFNtu5
	Fxx4g/rF6wS3uRaLsEGy9BUtxsUbMRzNcpm1kulxgOfVMVKMFBwpqsxAW+EwylCexg3i4lUBzS0
	SBOoCN2VVrougOeSvJ2WiFf6USBcDtdYhzAiObFPgnt2mpJ8uMuIbE7xzrvAb0ZWaQYE7N1EusS
	4GDo49iz3H5s6028o52mHPh/qkiHk5IjIviaX495HX+
X-Received: by 2002:a05:600c:a47:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48899781357mr2348545e9.19.1775156525083;
        Thu, 02 Apr 2026 12:02:05 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-144-20-233.cust.vodafonedsl.it. [93.144.20.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm273609865e9.3.2026.04.02.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:02:04 -0700 (PDT)
Date: Thu, 2 Apr 2026 21:02:02 +0200
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_ll: Enable
 BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
Message-ID: <ac69KsjKCnIHoUZ_@Lord-Beerus.station>
References: <cover.1771930508.git.stefano.r@variscite.com>
 <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
 <acp0-qWerjms3n5U@Lord-Beerus.station>
 <CABBYNZJFW8Y-HcvS_tVtfi6ySPmGjPP7EHutpr_p3DyCkfhYfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJFW8Y-HcvS_tVtfi6ySPmGjPP7EHutpr_p3DyCkfhYfQ@mail.gmail.com>

Hi Luiz,

On Thu, Apr 02, 2026 at 01:38:06PM -0400, Luiz Augusto von Dentz wrote:
> 
> Please resend.
> 

I've re-sent the patch.

Thank you,
Best Regards,
Stefano

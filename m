Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2939769D
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632740; cv=none; b=BXitHpqsEWJBgXRAcDkzzFBMK3ZOf8p7JoDWQoQIJbjoJlkPnxsKVMGHI0cKKkzEAMB3NkZ43Btl+HQULgojmBSDu3WJghHlcEd4Q9V1epRgOsmyZB7zZVq1xirexjJtowoddJ5St7EvxB4YP0FEHT+0LR0N+lZtZr6FWvvFJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632740; c=relaxed/simple;
	bh=gEHSEfZ9pYVGpFPKU7iZR9v9q9vaSR6bF8+wAvDNNLE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QdQqYWbva79Bsasph61lafmlhn4BOjmn5y+MM5iLNWk97RgGHOBe/aOyQZlGCPdOdzmxZaUyntaoJcekxxqkqdTXocH8dHId6nMES/zWxnzVJp5PHAWzOX9W/PZTqkEti4rX+tDG8tvlCG0pxd8atOj49/kWxVkJ8hkapYHr7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO20AKmz; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO20AKmz"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5d50b0dbso582083685a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632737; x=1785237537; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gEHSEfZ9pYVGpFPKU7iZR9v9q9vaSR6bF8+wAvDNNLE=;
        b=FO20AKmzkNpW8ddg59x/drGr5+l2vXBq6lPq3cgSjlVeCyvmNy0WcDJWP/WwTqGXjA
         y53osvASZskkJG/YUlkLoMCh/AClLsMH5Wu5YhtrPj5ydh/fZdZ8u5j5aH255VuGdFbb
         1Byzl6Wis3MOFiZnlG954AhaYA3Yp3lUJmmmU6HJDfB08dDrQ/fDBJ4B6JoK5WyJqaoN
         K4F4sapd92mCvVc4QSgPsOF2jaMjAIjv64+0oFEsralH2DHMV4prXEKmU5v9GfB23OCk
         uoCgjkpgkfC7gEHujAFs1KJq2LWxRlTem/RzBS+5EpPtoEx0A9IECATEkZ2DCNVcZWnM
         TdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632737; x=1785237537;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gEHSEfZ9pYVGpFPKU7iZR9v9q9vaSR6bF8+wAvDNNLE=;
        b=dFN+fwb9cSZQG+66xERvBEPWwzwbhbDy7qWuKmP99OpaaG5hmumzkdxZD2DUHviHe+
         eJzKNUUSLeKbV5VhrfoIMpAIqjaYoxYbwWxwpJYNCWye0P2DjeYCxNElSmfhEdv289CL
         EmKXYzlplN3guPD5kLKmTrn72/mLl8DG5XoG0BnpFmaZOMRaWSPjdCPui4ImE0KMa1VW
         Q0SgfsprYQlJGtyJwiR2Ds8POdZBxg6gJRWhSJM4f2968cZypQgNjs8txIR0XYsKGBT7
         s0nYaLOvdVHCLU2pjZ7NCdjVe49LGCZOXVaMSQfkEqGuxy62iBf4rjJ76jIYW/dU9mn2
         zUrA==
X-Gm-Message-State: AOJu0YxKya9kd7RydZf1e1KJcjeVLwRZ3/39Fq17QKtJfEMz5uwJ2W+5
	/egJ9BfrkrRU69nIed9OYF2vg2lrLTfmvC3ocv1T9WAGuzVknohSqmk27n2hjQ==
X-Gm-Gg: AfdE7cnyXspiwnl6+B8xP1PSlTLHgOHn5cBzCg4mURzVkzrzk6G6EPJY58vLXwFS6dj
	bvlH1i7xsUDNFs7WzXOMdNET2KGK5lTEc3Gsfpu8yIq3rEGf4hgbdB8CZPlwvyoGeNghZHDeB8/
	/CEBjp9Fdw3A3l33/hPuvz7P31aBk7PgV0jieQ5BmhPSCaPGE8+Mjs7cuZ0RMpUOS02ocwPDVfs
	Y3xUoqAvBcxdw8DkHjDVywkhrdZ8/37hV3R6Lcy8XgOYMrcOJ4BhL+GyQwNsgE9kAai7FlmfSwy
	zFzPOfg56Ray9Zhq0xxaYV/xpG51xgTQgX07NOAb31cCmqp1R/cfFPUwisn/+kyJ58nAxmbl4Dm
	37uIL9SjWOGYH7uUzwcB2y4HGNfxx/rzBOR7eOtgqVTy4xU7wtHjHK0HL3AGxCWkXyGDSSsWMTc
	YrJ64KA6qx+TNyhD79ne6BNw==
X-Received: by 2002:a05:620a:2a02:b0:92a:3679:7978 with SMTP id af79cd13be357-930b3e6fbb2mr1721264285a.18.1784632737313;
        Tue, 21 Jul 2026 04:18:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.212.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b547890fsm1074349085a.40.2026.07.21.04.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:18:56 -0700 (PDT)
Message-ID: <6a5f55a0.0ea1c686.18bf7d.3f4f@mx.google.com>
Date: Tue, 21 Jul 2026 04:18:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8986174522249588833=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] tools/iso-tester: add tests for socket shutdown with linger enabled
In-Reply-To: <f81384d367ad95cbe74338eba688daa46b379feb.1784624911.git.pav@iki.fi>
References: <f81384d367ad95cbe74338eba688daa46b379feb.1784624911.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8986174522249588833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: tools/iso-tester.c:717
error: tools/iso-tester.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8986174522249588833==--

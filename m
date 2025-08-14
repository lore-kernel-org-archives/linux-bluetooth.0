Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787464315F
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755147206; cv=none; b=Aa/QO4iBjBzV4JzKb3Jky9bBWt4zFiZiPMHxJYEFgVL1MjGG454Jp/ZnpycHGpnadysbsuawYO7Nmz3oZDIHDNsXPz3ReURHnXXjebv6+lAvpxSQ/xCeoThZVHGRfu+06h5wqR57iMHPGur1up5vDl2euhfRjaImWnxIP/yFIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755147206; c=relaxed/simple;
	bh=nWvIvaaLmTYUW/YXQyqyldp/InOdA+GJCGA9IuQhky4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BRpj5TFMKzZ1L6KnnVxd38tnrsGAMVVK0dupCjem0H1nCgiKWb6nZpDd4yFfJEZz2miJQ2gdqKdJS75WVJ3cdqPJUjp3OVpdYdsOL9cmJRKK0viY93ofMkt3hNM4jhiFVQPe0MAtOC949/Za/oeqzmbFqEWEKsC14V7t2LyF6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zgacx8TD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgacx8TD"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e5d244cso623813b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 21:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755147204; x=1755752004; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nWvIvaaLmTYUW/YXQyqyldp/InOdA+GJCGA9IuQhky4=;
        b=Zgacx8TDaChvjbq1FZqY+d6kQoYQeDvPZIT9CfV7PJdj5mmRvVkGxw6JIuUryFA+Kg
         4Hdsve0mpiQqsxHT0QGbwe7Titux995PbTnIH7SRAESVf644oWyZAYThZIbGkYlgtwUU
         Ep2w2G4AMbkET6GswWgSUhr4BfgN8m6bULcC0Wo6wB8XiZBkC2da+3ZGignw8iExy0YD
         xqYJVfIyfQ5kT8bwrWbqupD2D7fZmfLk13jKOEuxxqIUac/z2aj9GNRoUJZoaCBr8mIu
         My0KmBtLBb+joVeXbuNlYi3awKr2xNgJQi8ZXQK8i4Xt/zz7mEk1i0jYrTwfz6i87CxE
         Zyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755147204; x=1755752004;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWvIvaaLmTYUW/YXQyqyldp/InOdA+GJCGA9IuQhky4=;
        b=T9bTvYEEkhQS8kD4ucekTBC14UWAy15FLIJQruBOThoKPVhAqXCmTQWmXdyFSExCpp
         TVXlToCYTwQedYaj3uJR+nN3jpyS0BvzGGAmOcrvrU8PvbEqJtYlWl4c99JwtN+r9chv
         1WduNbvmS1utZDdoKOP1RuWWV45Go4oDsPmLOtJs4mmfCSvLBW4jzwBWUSonMsDVcJQj
         BwdMb3VhuGygfqlrjiuyfId4MRXJtj1jic5fJxv91Y+3/KP9EV+U2Ohl17Wl6LbIktQy
         r6Is6w+V9obtoH4lD6NiBnsJ1jw/xPkRi6Er1WsfnkQloC1pcpRUYMB3Q7klhjC5WAjP
         8bvw==
X-Gm-Message-State: AOJu0YzhNzYcJHflz0OmNBtgrVTHFN9uybMHgukGc2O/LqTsjvSau40T
	qzEJTEOYLH1QuNwwWR9FFaHNiSmofd/YOn6uU5RbRI/nyo208swPEwuLom8xtw==
X-Gm-Gg: ASbGnctTXSDk5+qkHXvPoNUp7qqGBZgchgkf3T0LXFrfj9o28yxu8X3FOE/lMH/XYZa
	98/5COGXjhF1QjMSmpEO/ZkQE0GwjGrEHmvhGccFuLaL0ehmtoLVuofXwN/yIdojNMaaW26sY/d
	ccb+5FDX4bxfpmlxOWtwJglG6dYu+5Whr9/YjL+JI65L7ye/biEloDvm+N8yvI+DhPGq/Th8SDZ
	qG+vhEji7A7MzGWWqMkMbiPygh7Up5h3FozZNJogb9/mWpjOLtq3ONO/bqjnKCbzd47n2XLLbD9
	8OEYdYDtRSQLUgw2y1n/ec39ZCg+xVrHUU+KYvxxs3/7V17pa/MBTFwwYGBy88qqHOayAFFuj8D
	aa7F2zkXXhnOU0jCqlkuDh4UKLLRmjw==
X-Google-Smtp-Source: AGHT+IEpc3lU35GQKj8DeFBVSn/9Tuv0NMBsUH2wuj3E5QkSOG4D9p7ZXtAGhdUi0d3qO650bZuQsg==
X-Received: by 2002:a05:6a00:3ccf:b0:76b:d8c8:2533 with SMTP id d2e1a72fcca58-76e2fdcf70bmr3004866b3a.24.1755147204359;
        Wed, 13 Aug 2025 21:53:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.196.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe74bfsm33479851b3a.121.2025.08.13.21.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:53:23 -0700 (PDT)
Message-ID: <689d6bc3.050a0220.1099dc.39dd@mx.google.com>
Date: Wed, 13 Aug 2025 21:53:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0972901479260903612=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chanho.min@lge.com
Subject: RE: Bluetooth: fix use-after-free in device_for_each_child()
In-Reply-To: <20250814043832.8767-1-chanho.min@lge.com>
References: <20250814043832.8767-1-chanho.min@lge.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0972901479260903612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sysfs.c:19
error: net/bluetooth/hci_sysfs.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0972901479260903612==--

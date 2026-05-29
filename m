Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB5246774
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043794; cv=none; b=LaHOr0rBlYNXHufIM537N9V7aDBsKCIz+1EXBuYEuYmx3Q55BmNM49LcW0oFVPwAHKCfV2MdF+on33sYAjqyifPCkS++gqf0ighi4wdeiszKHCbc1w5h2UoTpGmK+pERnhni8z35IQJPhwy2UGqLKzEH3YYNIKCSDqkQyEOh+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043794; c=relaxed/simple;
	bh=4wicoqvadV2/HNQm4wFw3ZNKX9pLOBD5nuu171A7xJE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OKPkxxyFgcSt6+XUsJHhu/X02Sk9VKUA/nR9xA57IAxnjt8vVCFQ8LVjxdJ00oZbUm8dGM6UUEdFIcplbdvPcAc0aeDdtRhTS8j50NcBOya+B18aFt03sh2jbfo+gIh/gAzizsiUbVuTA3dwoXevHUPtRVc+UErljkLuav5xkDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXfHXuAd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXfHXuAd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-90fe17c157aso1446085885a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780043792; x=1780648592; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4wicoqvadV2/HNQm4wFw3ZNKX9pLOBD5nuu171A7xJE=;
        b=kXfHXuAdf/jLPHwayeyGjTzvT5PZ3HQHA1bsduwLaDFr1OF1R1gG/mt3LPoV9nkG92
         7GxiNS70u9OYNFushFklRSVcRAWMDXcOLDVoljPmeUa8OzBlKBl0hB4OhoY2Hyp7d7S9
         QLHc/KlMGmzziFSBvMM9CJjkPU3ed3GGai21p07hbqEH5CENN7TY2k0OIAZxIr4ChhQp
         652mOlptMM1Sah+MLMrDtH/k08C1vkY2ufkkxTZnkQ0DHIPm9XG43iGfpJVW9vMY/uF1
         rQDj+iiA1BH1TMpqQ8GAGEe5OXvxzGhblX5Pk4WYbyBxnnhjk0+pmbAgp/hCEjhc86cO
         hkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043792; x=1780648592;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wicoqvadV2/HNQm4wFw3ZNKX9pLOBD5nuu171A7xJE=;
        b=HxHXUvOoyTfj1mlVGzmkSEfcOL64ZwvvbXDg289HPf0MITCBWR9WLqzC+eVx07tIkS
         IiDRww2OlZMZtkYM/crkQ+qAYX1hwHvnfrWaY+WsPGgWv1Opwr+gD+uHLgYgDJiL5zDb
         EwdQLNR++zCg04xcBDBihMpkglyQliqfS5JSIjiR109XK8SGNrEcff3myN/BMHBdAOlk
         nBO5ZI1yEVclSIheJIAabkT8PZ+klO0YAvbYYpWWw2OD9GSfqWXNWa2YYz46aP/6Zxwd
         r7J1eGpCMD1xQ0kzQ9OCfzeblxgxLAs2JlwEKnRjhaUgZVlzA2gs5A4fRJZ0QZw4xB0A
         jQ7Q==
X-Gm-Message-State: AOJu0YwbNKH+vhJlVOJrnBs2ksr/XbjUW/gAt0734zN0WjQ4ItuKacf7
	eP3zzUd/8pCT7xcIVe+76LzjBd49BTr+KCIe3GHYJOqul+ru9MvfGiVIlNA0xA==
X-Gm-Gg: Acq92OGaNuLjTDOTKJI0+xDU1k7+f06zqqwU0MSRmNvizpWDvH3BJiTYh1X+YK7Kx14
	m5flPsZV1/nn+a252RPn5iu/3/nc096i6OGU3L7YA47QL8AMhLCplm3G+LjHY6pitgCMZiISes+
	qDvz9lN5TAwm4R4VXItXs09FHKrArn9Qkli21riiDBogyvr5WcV+qgsGQBHWbcjbjwUi/p8oPQK
	JF29jSKmivkE1vp7uZ5OI0E73uhSKr3KS7jchD4CUViLh/wqXRcDQyLuass0cYI136kbtq5nIsB
	uNQ9Zl1cwqDnq4e8nrCiEg0OFlylWJYCtBmXWT8rv6LBGyU4QeI4DE77VFFeX20f7vfanI3ENBJ
	BGuPnJyhFKSeqz2NB1CoQtZfD/SYph0TNmK+J9nNcKvE2H5MoPf2xCanwHUxY5OOiA8pTyPgV0k
	SLGo2mqN2gWVdoHhDgGhoQjJ3fkJ9yJMCHp4aIQJCIKuY=
X-Received: by 2002:a05:620a:1996:b0:8cf:c0c9:bca with SMTP id af79cd13be357-9152fd1cdf4mr241750185a.17.1780043792019;
        Fri, 29 May 2026 01:36:32 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.208.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244c085sm124392685a.6.2026.05.29.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:36:31 -0700 (PDT)
Message-ID: <6a19500f.87f7828a.4df2a.7f05@mx.google.com>
Date: Fri, 29 May 2026 01:36:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4407033358839976784=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sanghyun.park.cnu@gmail.com
Subject: RE: Bluetooth: SCO: Fix use-after-free on listening socket in sco_conn_ready()
In-Reply-To: <CAOrxSK5OMUHuXzb5dsVMwy_N_6=BX69Cp98J8QVTKVFDGYY7tw@mail.gmail.com>
References: <CAOrxSK5OMUHuXzb5dsVMwy_N_6=BX69Cp98J8QVTKVFDGYY7tw@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4407033358839976784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/sco.c:1323
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4407033358839976784==--

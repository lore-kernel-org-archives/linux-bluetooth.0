Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4F34CFCD
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486377; cv=none; b=kYCvqBXCZkVmdsFgq2d4GEB4r/Anxm+ZwzFn/Q+cmry7wL30mRJBJZoS6CL5w/reNj3g30U3imFB8bIE4CN83JwnyLm6KqbY6VnS+p4Y2tNsHTTiDcw8VHnLgp59Eh1U4BubZRIOHGwPDRyAoqL+PLXjSekS49/mtvdXvQTiHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486377; c=relaxed/simple;
	bh=vS/afTcY8kfULwmx0PNGgokbDWDnVC7y4E1hfZM+/KI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zgh67X9w1H1lbp3l36nmM7gtMDPM+WpZxhTdxjPhilFEPPxYplSeuACjFUo4QTSbUhJW0cQo/S61zmJtUtq8fQbXKpHwTTnmXN80GoOsRZBj+CAMaUleemREiSDWYfL2h4HdBoV40+2oUS1a7ypAD9gTEYpUl5wkKQQnNppl39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s51+Bq/3; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s51+Bq/3"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so2024881a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778486367; x=1779091167; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vS/afTcY8kfULwmx0PNGgokbDWDnVC7y4E1hfZM+/KI=;
        b=s51+Bq/3azq6/6tJw9Co/uP7Z7f7YF+2R3basNJRvA6onL8LqcPpZ6S44Tj8fF0WRU
         j6dgLEoT37xDiqVKWs0achzSehX08F1bS5mqQw/P3p0IJIdTwZjkMg6DmC/mWMNrZgqd
         e4lyH70RIpWtwhPCHCkQtHw2hlEOr7ZmZ251Y23arGzsMVOYkVlz8BHlFkxURCjhjZ6j
         u4EMTTcDOVMrUZh1y/xO16o+kuB+iimJePz/CMVkwCx6LOr0QJ4C5SyaEFilJL3FcJR7
         mFNPVCfSIU+FQekBDYYRPwo58w9CtETY4an0Db8un3aT+61c6KMnfqD8BIPeoPuuXv5L
         oyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486367; x=1779091167;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS/afTcY8kfULwmx0PNGgokbDWDnVC7y4E1hfZM+/KI=;
        b=StdmnI2eWFLnVjwznDDtdv1DQTLCYs1dwlqlnVwlnGWrSeHHLZd1n5pdSlHVNbkelA
         0R51yls7u0Kw1ElTUOmv2+cGdfkMjBVgWQJ671u+d57fiteUYz9n23EfT3Fzbi1cpD/K
         EQZzm6+qzhelNPi5LDVr+aA6/q492KNyLOfysix+dHN/sF7+1m27DPmKGEF4cBL48q1M
         G8xtYbadmWVVvcrXUlRd84gGNTpPcD3tIWZbwgjJrsZ+7LDYNyqotNYcvsjXdjGKhhxv
         TOhKCt+jmdGytXblJHX+cnbn9nyEojCxF9l2BQ3uDUCjm6dsb+Vy8SsadQ8mwRBWQnvG
         XgdQ==
X-Gm-Message-State: AOJu0YwrmvOE7yC8eYFEN0S55NIQR1ExiKGNCtBrjijBd3vwuzzv2C1w
	jDpYtb36YcoZVrYZkK2gr7hi9oDt/PPqstJYuDVre/hInuDtjhX/aUJb8qpODg==
X-Gm-Gg: Acq92OGDlQjg0h9wS2u0UdeP/X4De/0X1sQVo1inZRHWH6F2Rq+q1hMPCMRYg0BL9Gc
	1G4tfsVaTnL84uiM6GBDiMe9ml/2F4AyEyX3/GpbH3oDp1QPo3f53XDPWTVEUmtp+pzfvbdGSqX
	Nm67XPlJDOj4P+pr2aYeU2LEumUEsoVJEOPm0nZD0tgqlapQvb8Q0/UKF1OJ8Ef7e1XE/6I5jLY
	1YOQcmB0iVTEcxn/DPRQK8CXIuMp3DGA8pspS11qhTC4MOCkE32KdV3TW6UmZ3LtwjNvoC1D8Y/
	r03Hx+sBeglc+K6atQDCkyesl0ZYL/sAMAxf7Vl0wAH6T1ZDiq1OxlL+CJP+Tl+8IPn9vNKCeDf
	xjFsBuP9zTGs0FtM4Ckz1ggKO0zMOc0DApM4SabcmnDCNeZYeM3ptsvkLgU4z6Qz7uJzIN0C0bW
	TVKrAJDvnrqRlSTxXPbiLmXQLfxQu0
X-Received: by 2002:a05:6830:82c6:b0:7de:44a5:51ea with SMTP id 46e09a7af769-7e1ded2e84bmr13092740a34.6.1778486367179;
        Mon, 11 May 2026 00:59:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.52.246])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d4fdf4sm6277491a34.14.2026.05.11.00.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:59:26 -0700 (PDT)
Message-ID: <6a018c5e.9d0a0220.84e25.f40f@mx.google.com>
Date: Mon, 11 May 2026 00:59:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7200605499803375345=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 32840572@qq.com
Subject: RE: [6.1.y,1/2] Bluetooth: hci_sync: Remove remaining dependencies of hci_request
In-Reply-To: <tencent_CA96C7486F1CF8F0C72A2274E56AD1766708@qq.com>
References: <tencent_CA96C7486F1CF8F0C72A2274E56AD1766708@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7200605499803375345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_sync.h:5
error: include/net/bluetooth/hci_sync.h: patch does not apply
error: net/bluetooth/hci_request.h: does not exist in index
error: patch failed: net/bluetooth/hci_sync.c:11
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7200605499803375345==--

Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985733224
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726546632; cv=none; b=YGQ7uSj+r0VyvBJAazmb9NR3B06y/tesOdZajtAxFKZuGdeAnSrRY9OphsR9FOneX6H8iiuA0rGgNaKfg5d16VHRNolDNrsq865al8Vmp1YGRupvSDLArAlCwa5RJcTnWqTMdR8JeeXxn3oLsTFEdNJ/n959hhoiXoqQsO2qEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726546632; c=relaxed/simple;
	bh=iMxUM0soUQdLi2f+AJl6o8sJCKl/X21xKJ7ZhtF8pQU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iHWpAYeTh31EWt367d0XoMSlUoW2Pbwd+LZKr1ZbeI+3sutM6t0Cj7qp2K9P8WZy2oraYw7gmsdq9ChRfmq7EX8RQAHkHpoeUHJRFq0IGjF8zkdcB+VPlfkng5YQ5roP5YB6g19MEU4Tuo7XlN632H7QI9B2bniMAhXNEhIxR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJAGNAVB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJAGNAVB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4582face04dso46169061cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 21:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726546629; x=1727151429; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iMxUM0soUQdLi2f+AJl6o8sJCKl/X21xKJ7ZhtF8pQU=;
        b=YJAGNAVB8xxiIKyGmOQhFmP+kHrGUHngMSHjmYHL3EAq9Iig5M0cGwoGvwJPdmMATe
         XOYJyCHsFkDLT2o4p7GurMbFlsUMM5xNhqIN/teiH0o6AsiLJKJ/GjcqkJPRVCUm2Edk
         tidr/EqOSYnAiWr2qiEOeW2fWAMOGaaifxBoILcv65he3cAwMjb/pAjgdrKFmaTXMpRy
         pk6LNQ9ha6vWj5QagxZqJuco+UhkfoDDheFNW/1SzpAQcslw5VKIHhg9Zctl3P0RpAfa
         XLPg7X0mPREPj0hnPK8CJFGYIiL9rKqM+QOXRTbvg0KiDO7uAQQ4T41iE3gD11TcRkpP
         sUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726546629; x=1727151429;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMxUM0soUQdLi2f+AJl6o8sJCKl/X21xKJ7ZhtF8pQU=;
        b=htb8h2BQ0oFY2Fwxn2OhWbfHWQyfJZxd1UuXcj/Gb50FqGudOCkMqpPc3R53rDLAGA
         ZM1BWR8rOSsqZiGOf2/oE7RtUP4fyeiOhQvmzr6ilZ/Ez/J3L1TV37C2QyifMYXZ1LWh
         bVljq/N3sO2nx4LJ8rcUHEWliuh36lf7937nbnzq2adY7P7bfriHv8EZzhYRUwrGD+FY
         HbIGu63qOxxKpe0WAaKARMeOCdMs8USLXCAyMXlvLVcZnxQ+TZAHX0hAum0nHmT5EOdA
         0xOJGYiBpRkyEv1N4ejrq1TGWbpebpozk7GpN4MfR6L+1oxzql1/oroEy2zKAWN7PoLF
         Bosg==
X-Gm-Message-State: AOJu0Yzk9VxjgNrWWmkYZZo/aXHOeRv2ux4m3nElpt5GYjRVVsnc4i6t
	c1p6UxfL4OXz6UDth6cMPQWu3qC67bnLI7syKKdEwyH5RBmDxHbgY3sxlA==
X-Google-Smtp-Source: AGHT+IFM1iR5eFwQ5QeQA7xRYJBfwwdIsJfr2BTDMz7/DQNZZ6G6030fz9XOiyI1740UeK3zGlslNg==
X-Received: by 2002:ac8:5ac7:0:b0:458:31dd:6aa5 with SMTP id d75a77b69052e-4583c7adbd7mr413034681cf.19.1726546628934;
        Mon, 16 Sep 2024 21:17:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.36.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac887e5sm34260611cf.35.2024.09.16.21.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 21:17:08 -0700 (PDT)
Message-ID: <66e902c4.050a0220.19df0.be0b@mx.google.com>
Date: Mon, 16 Sep 2024 21:17:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0435753510831274889=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: Bluetooth: btusb: Add MT7925 support for ID 0x13d3:0x3608
In-Reply-To: <C2837417C967D014+20240917035545.21209-1-wangyuli@uniontech.com>
References: <C2837417C967D014+20240917035545.21209-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0435753510831274889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:508
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0435753510831274889==--

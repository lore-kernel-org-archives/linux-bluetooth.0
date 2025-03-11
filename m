Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8711DE3B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660932; cv=none; b=LXbzmhbrDn4tj83caW9uOTZvfC+MLqrFmscxsdXA2lwsj6tPxJvj3UZ9jVXl8uK/iMj5FFpScBW8tdReqic/0WbvPCFuBfXKLbRfxKgf0buj+ylbfTeGU/zcZ7HKk5uHMinhdedNwL2xIctJnD3I0zD1kKKN43f7IPeQL6J3M+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660932; c=relaxed/simple;
	bh=chMechm55MPgHKKKxHJKX/NUJue0tOvLpUcYLQCOXro=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a8uIBEQVtmiMS7EOhHtViEhqBGdMGEA8FvVjp/bU6G7jBNXzYJxcXnHw6Zip+38Uy+0I/YpsM41bgh4/j+1Eg/ebxb8Mo/fO3h+RiffgI6htcX1xhksQXjheV9CfjH4HP9jw5EDfUBmMiiop630HTvChJIp3Mzf4sXP9w3G4EKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnfGveIO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnfGveIO"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e91d323346so13536666d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 19:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741660929; x=1742265729; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=chMechm55MPgHKKKxHJKX/NUJue0tOvLpUcYLQCOXro=;
        b=TnfGveIOvIgGsA6XV0fABk4GGNBbIS5jGoNMY41AuXr//wjnkkfBB71rcGcjvPt/nM
         G+4baxm31YUvuv6R2S9rPNfH7wux7oljykwnHgaB2fmDKLYrUV+XxyhPDiqzd+aEr1tv
         3QsusM2eG3ZwliS4H4HPg8225GbrSfGeSXKxouD+d3MK8MaCEKD/OPEHwN+fHW5biHrG
         NJluAA9hPTPSdcFeXhL6VsDP2YN2CCyo9A0NCEgGLFRo51+cjmp2wGTXV6v+2SRuF0DV
         u3P6WppHQhA0K1sPOHBu5UnvIWz3GEIkeLLTUSPFaoAisLu3cx0MeU5ivSa8Vivl9MEF
         FYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660929; x=1742265729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chMechm55MPgHKKKxHJKX/NUJue0tOvLpUcYLQCOXro=;
        b=QHXGDzRo5Twn/wTHva0WADNrOct1DCE8BCKKtycwyr7qLaWIrS1rvxisQ1KLjhMkPm
         cj+C+LWAcSKBLrp92L/6V3aMNHVQ4D51KkjweV9qgM46h8mNd0RPwiEJzlDA7aDmhWKN
         liED1vJQd3INUcaCINyV/oRJ2bjH1PVrH4b0lRBV+35ENrhaxjCMxj290jp8P7RYTz0Y
         iLTbMK3OQzEedkWcx8TrFzV5nFpX+D4UBQunCVY1YyE5B1xSkIfYAueb5uiTHx3x4dPP
         9IWNR8IfnyDaM/2Ra8TNjS/9OHOgYxtSnhk/IyFI3EcXlO1ToSQSI8jh4q6AIBRZV50Z
         gwaA==
X-Gm-Message-State: AOJu0YyxjVCUbEasWb2EknARYSTZmGVhE7fBBXPAOsLG+8yGyPaKnkmw
	dY/I5+NE2RRg/rEoAwiJqPQHE+30bRmigVOINquoenuwHlUTUtXXZq8sQw==
X-Gm-Gg: ASbGncuil1OCUgmvS6Kb6G+jZK52PHxKPWCYlVxBXPIuZ4g7KiRtq3H0DpWmFOTwm4X
	OxLHvQhucez7AXbHQUb/6zOKFJbBj6C6EmxMYZbqbtHMEkj19i1pZoXqqZN4tNwo0wq9Jq58uX5
	uMphpbn5zxJInTLQtTT0C16ngwCF4/5IN1Vm7Lc65avWi38Vxx9F0LJ6DGshVOBB24jmGomqjwt
	/cyycFlqFznI7tcfhTN1BOXDLCjmo9UZ36nygENCaeS6f9/uTQrQLdVIkf3COFaT1I2d4qDGtlM
	aCx0QO1WPmgzrs/iLvFmdzNRMnKoWdU9XbdR+hdqoZnt43T9xA==
X-Google-Smtp-Source: AGHT+IE0YTXJW0BlfcH7SwucWEgs1u/bZ5LFcPPsA3wSWWskgHc2o/45/pqvkgzsXeEzpbh84ZtrOA==
X-Received: by 2002:ad4:5d4d:0:b0:6e4:5a38:dd0f with SMTP id 6a1803df08f44-6ea51eac398mr28718876d6.4.1741660929126;
        Mon, 10 Mar 2025 19:42:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.78.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715baaasm65630226d6.85.2025.03.10.19.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 19:42:08 -0700 (PDT)
Message-ID: <67cfa300.0c0a0220.9c86c.5ae4@mx.google.com>
Date: Mon, 10 Mar 2025 19:42:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7630355004212652019=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael_kong@realsil.com.cn
Subject: RE: [BlueZ] Fix data type in bt_hci_send_data
In-Reply-To: <7dcaf905169d4c399d89eefbbdf0d3c3@realsil.com.cn>
References: <7dcaf905169d4c399d89eefbbdf0d3c3@realsil.com.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7630355004212652019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: cannot convert from eucgb2312_cn to UTF-8
fatal: could not parse patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7630355004212652019==--

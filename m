Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460B1B6D1B
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760239; cv=none; b=rgn3PfxbDAMdxiOZXlqFL4F5hgJYefxj3p3d9zSxKhgocGi3M5ODOgZZGXgEu07ggZhs4FdBwDQr9B23+0vRHNCXqo3ApQrle+0xm4Fj/uV1FqvDdQWfM4IEuLP+L9b7bOySoqygFrMt2NT/+DBY8esnqEezSDdnTB//Tn6ovtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760239; c=relaxed/simple;
	bh=5mWUZ1C2dcjwyosxK8dwCefEY6VkN48hl4SOpAztfMQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LP66GaLlwMNxBlurKgW4OOd8FdJgd6QDuySYbOdSwsN7l8HtFEatvVgybYEI8T4eRU105ZB1myhs8MJpPKsVqoM0NdLit6eFto35mhFkDlJM1YyX62VMNkNHPhNbZaLdaC+M01Glbsc1SODTcGmLMagO4X7ekr2O3heXcNJZNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSuccLx9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSuccLx9"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72097a5ca74so4550419b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 14:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730760237; x=1731365037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hWCBWfnYvdp0aXR4r7gkNHUpg3bLRVDyVyAL9qIBvtk=;
        b=hSuccLx9DwGowCYcYb6sQxNKCWZLeLAZtVKC+glvzk43TQ8TCdyumQIr+yf9l5M1Fr
         Do+HWd+ibpEROJStTSkmyiOpHMzzt3oOgdETbpOXoYPWYCyKlRZ150BCusxpo7yF/RC5
         Mt+6k/vYHFpn8tUyqXmqNLMHXynrzDE2EkrUsvy1iwcjoguq7zQLnbdlOUCi0OAndrjC
         PnyMpuTT1n/kRLc9sh0ybVhXTMjanxowV0JzterKJZ4lrC23RY6NaWKd0JiFsHpPbof1
         3RUd+Ugtq33u8SvkwhtqqA07ESw33C+gQ0LGOa7dEvQs7OFeLVFVurRXCgPHbSIn8PWd
         OczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730760237; x=1731365037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWCBWfnYvdp0aXR4r7gkNHUpg3bLRVDyVyAL9qIBvtk=;
        b=STzfj5DqdTLq6+wa9GBFEWQctr4gWnO1T9QZAR8g09kEMFLdEN5CU91HSARuY2I9vk
         2kE3DBBuVFrWvJWaiahLzfQDlzhjyzlT5E1uxbKEzEXpV8etnTjmR7HLdmXB5gLjXnmB
         jH7q1z+WHu8knkKHocyf6SFGrLkl85IcPxCmauzSS5XE6dazuvD4RkoVt386hxDiIi+T
         hy/QwTJzWJ+uFr6VTV6W01u9o1PTxx6zv/LsSgqOWqEKAgIHxR3QRcr3Fig78pv/z8I2
         i33Z3Lw6meuDNAf/RJM8CSEJvnv5VpYTy2LcwsqgjCsm560rGQXQLuAPWPbHrKw1gKnm
         f7AQ==
X-Gm-Message-State: AOJu0YzN4f8h/AyIh2pqTg2rvLQjOENjpDVyFlrEQvOAHjxi8d4EMCSn
	rb//7dWNP4aLksWizbTrH9vMbwe50pKDSNALc/ZT+7T8pIUtWCCJwvvK/g==
X-Google-Smtp-Source: AGHT+IEIu6a0mv8TWHuHvdW3V/s4FV9lwIDQ0h7+RnDROVSDAN9V0luM40WxkICvrgSJn/V5Rn47Mw==
X-Received: by 2002:a05:6a00:a2a:b0:71d:d2a9:6ebf with SMTP id d2e1a72fcca58-720c98a1c80mr18759523b3a.6.1730760237042;
        Mon, 04 Nov 2024 14:43:57 -0800 (PST)
Received: from [172.17.0.2] ([20.172.7.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb7a6sm8144733b3a.165.2024.11.04.14.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:43:56 -0800 (PST)
Message-ID: <67294e2c.050a0220.23a272.3d9d@mx.google.com>
Date: Mon, 04 Nov 2024 14:43:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8266074851053748299=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] adapter: Fix up address type for all keys
In-Reply-To: <20241104203549.772512-1-luiz.dentz@gmail.com>
References: <20241104203549.772512-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8266074851053748299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=906247

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.80 seconds
BluezMake                     PASS      1705.03 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      181.90 seconds
CheckValgrind                 PASS      256.08 seconds
CheckSmatch                   PASS      360.59 seconds
bluezmakeextell               PASS      121.93 seconds
IncrementalBuild              PASS      1602.75 seconds
ScanBuild                     PASS      1028.36 seconds



---
Regards,
Linux Bluetooth


--===============8266074851053748299==--

Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F0A537FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Madnk2ML"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bf27be6c4so1306998a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 12:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703535178; x=1704139978; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvuj14nj7DC1LuVQWk1CZPahpERwP2wc6z84szm3TCw=;
        b=Madnk2MLrBRrpzTSUULXwqLsnyHFKGdp3gFd8mjhWn98WoELEyrjWefPGZsahvhHkx
         CMjJgiHxMxV6Iyzn7CVIj0tJM+r3JxhhULUeKsfr9j9y4+/xzum+/qpmx3DLa26EnWzb
         wYZg0Lbs/yNWzz2xX8Eq870FDlM1dptXI8wMUrPH/CzPsArWfORpQfNwXNHIpH8jfruV
         5uYbKqJ/jS+0jno4ZGmo19pLd32MaDeNzaY2u7KsUTODsyuSVITptEl0Y6/BNk7HwM8a
         BT9XZc1FUHO5DUyCpuo/6zFhUBp3kNbpWckFQnA4N4XpvJL07MNRMSTovUxSUQEvXNmp
         Kc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703535178; x=1704139978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uvuj14nj7DC1LuVQWk1CZPahpERwP2wc6z84szm3TCw=;
        b=be4QHJkXrT9itUbQ5BryLlqgss99i2TwTz9km7UuPcZqML8CpBVWCsUqTb6F/dFUVe
         EIIoVGpI1tulrHGf3rdJq1Tk+eWbkaKth5WJr8/9s8aCSv8j6OIFgMBVh4uVYDNtm/K2
         ukqIsa//1x32VzyC+sT0RrOXxkuzX3o+AX4tXFDeuoUNe0TiEHAtG7N9XpnBQPunG7Wh
         /bRGU4o3NYgU5ZvSzD/zYuvWIURtaDATt9fnKT+lV6yNYfuGTKY8HcXLHX8F74hcxb+L
         p8TtGNACGbjLmkCPJWaMQx1BhffAQmB7WZcbUFdzNzLlaiC3pCr5hJ+Nadg6ATpOPwc5
         SYwQ==
X-Gm-Message-State: AOJu0YxNJlTfKf5mvKAuJys8XyjD8MnO1yvClXt0LdgoDIVOC5u5LukI
	LTH//mGyrQ72Gjm3bMTkJ1NDWzzRLE8=
X-Google-Smtp-Source: AGHT+IGJx17LqwE60DmBd3sAED7z3F6aymnIUMXh5J+bKuULm8s5SmYQE1VHX9ocooaKh9iVDAasBQ==
X-Received: by 2002:a17:90a:dc03:b0:28b:e576:3aae with SMTP id i3-20020a17090adc0300b0028be5763aaemr1801939pjv.45.1703535178460;
        Mon, 25 Dec 2023 12:12:58 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.195])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a1c00b0028b3539cd97sm12279671pjk.20.2023.12.25.12.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 12:12:58 -0800 (PST)
Message-ID: <6589e24a.170a0220.e9e91.1e58@mx.google.com>
Date: Mon, 25 Dec 2023 12:12:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8559601745295245564=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mrman@mrman314.tech
Subject: RE: [v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
In-Reply-To: <77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech>
References: <77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8559601745295245564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch fragment without header at line 10: @@ -2465,6 +2467,7 @@ static const struct bcm4377_hw
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8559601745295245564==--

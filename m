Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04D17745
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779771910; cv=none; b=Ye+GFNyAdXSPsH1+eBa9/fdn4QlszkLxaEx3jWC60RwbB0uMuwZxKfZh/1MwPZrK9mNqqbONbbnvYKNnvrar6QhkV0P7+q88f7ykKtMN9XAQ+IHYFgQJonKty5yhftyn/LoRuQQDb5RZSJk+w+2SSM5+Q+SifJ/hD8HGj3r/t0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779771910; c=relaxed/simple;
	bh=x0W/+uQI3H+96MzNCrinHbUdcetqZqucuMK0/bi1zXU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P7kHxG9HT7BVENHmYRjeq7TgMlA2AOA99McYSo4MAvZErQlyVf6Sc6w5XKwUB4Rqvxpu5T8cfQP7SqSp1r9XVW/RebUyCsdXVQY9vOfDFOvfMVlUTmSlDJkqdWm4fet3j9VKB9+OEgJZDhcuG3JZcf355NIEFV8qT6tBxDiOFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF8FPb1F; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF8FPb1F"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8c9166b26b4so121243576d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779771908; x=1780376708; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bawOsL7qyxrFwKpQq7FvQZ96H9Vb0/xDaInkAwhUxqg=;
        b=dF8FPb1F+ICiqZC7wQKDxul8rGofZ4X/Ld+zSq050vchtXwvDcYeVPAajOJkPZuwbs
         hXFdub+v6QaRbBginMSKAcKJttfCPvQGHZ1MiQWpEZOYoXHHAIBaMh5GJCwN+dgoQvKU
         SqU7VmsOPhT+VTj4FasSKWwgOluVo3s4h45fud981+8CqDL2ilIWvfJAwvZuHGDgDV8p
         TXtnGUCh8q9rjqzqN41O5W5g/2KqohshgYIfraxvHP/cxkNbS8nTHSgWOwzbdQljIHKS
         VKtcxU8HOxsxgJ1mHY51D5rW21WbZiO9oTjBNpJitRMHyLiv/OPqaflL3LD1LdOUD515
         azGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779771908; x=1780376708;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bawOsL7qyxrFwKpQq7FvQZ96H9Vb0/xDaInkAwhUxqg=;
        b=CTIrecvZ0jKf9jabozxwPLCTJRywumobrda9gEfRpipCtVsZ3vuyVsszuw4I6blCNb
         4786kZcNjazsP59aLRes8BqB5qtiY6FD7IPNhqptC0T1yqzuR9wb78P4ckWc2vUODIk3
         fJJ9D0XdRbTC24vkPiWQnxcFbeCX6ORNyRQe+Fn8efIOA/jwoliY6M9hRKtu8pQaZzmi
         JTPPcp/sfSeeMTQpYRILiTMBl4tpeCxSrKlblCBsXSCSpUuXGQFqEUZIyAZ3Tt4j5kEQ
         kc3RPsrDLDWFXFhJQaUIzG7HOJnE68cCBzCCkqU7ViL9H+0kfISXGm+u7Ih2f8BIttQ7
         AHOQ==
X-Gm-Message-State: AOJu0Ywr5QVuSEguttKVmYf0QAwuotQbd2QzuB2dCWDvAFpcAM0+z6gb
	CSVWwRKmGaDS5ScojfZ6EyE93CECk0whypDh+f9e5UebEsZ6i31WkQEJgLIMdQ==
X-Gm-Gg: Acq92OHt6w4GeSpwe3tHa2IoyXe/EzsaoWBERx8DHzyA9cF/9erMHO/Rkb+hFz2BHtS
	iuGfjLF4fssBNhZ7gxr/tuaJPhRPIVeQuy596QrBdtqLngS2e4Zo95GG4vcv6GJ8VaGHK9snjO2
	96XkecbMI65amSYeG1NthinVYe6pAvfPyzYYQxF5btBWTyNubo4FM6rmiiCFs/vSX+ktFitUPTf
	scp646K/TOKfYZVDq6i+WdMGtBdX4oHOKT1ESu6ZYLj1T78i0fJBtBh6ir/a/SArwjlS8PAWykm
	iNeVykNhkVAn76wGewGac8b6ymxpJL1y+mdxIIRGgQiAgFP9gLdmX3FD9rz32yJvlVIITCesqkT
	ukblxSufOV0p0cqsw4DZFUCmcl+FUIiNxS+BgiDfERHTyJE//3NXKkCW5WOeXC7v84ux6Snf3iK
	cTcBF/niST8wKaMa7klNThIXDjUZSTWMw=
X-Received: by 2002:a05:620a:6f01:b0:912:61f8:caaf with SMTP id af79cd13be357-914b48b4bcdmr2204881085a.9.1779771907998;
        Mon, 25 May 2026 22:05:07 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f880c1b1sm96521385a.40.2026.05.25.22.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 22:05:07 -0700 (PDT)
Message-ID: <6a152a03.06bdaac1.2192ee.569c@mx.google.com>
Date: Mon, 25 May 2026 22:05:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7965721202727144143=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: [v1,1/1] Bluetooth: L2CAP: fix heap over-read in l2cap_get_conf_opt
In-Reply-To: <20260526021747.31634-1-meatuni001@gmail.com>
References: <20260526021747.31634-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7965721202727144143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100657

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.93 seconds
CheckAllWarning               PASS      29.76 seconds
CheckSparse                   PASS      28.95 seconds
BuildKernel32                 PASS      26.00 seconds
TestRunnerSetup               PASS      572.85 seconds
TestRunner_l2cap-tester       PASS      59.10 seconds
IncrementalBuild              PASS      25.01 seconds



https://github.com/bluez/bluetooth-next/pull/240

---
Regards,
Linux Bluetooth


--===============7965721202727144143==--

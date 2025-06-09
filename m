Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAB2AE6D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749468785; cv=none; b=Lp11qSvI7VRZntdc978EBnLn0YsKa3j83wnavy7xwEiMMbiIe1aFHACLgOueJ48CGjvCV9aKbA2R/ZYIYO0JHGHnJfhsCHvPcK/syHNl3eiV1IYqwAN3g1N7d2+V6a2dRX/qccBSQZGlk+mODhd2z+RqZtUK0Pbsz5rzbuNXJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749468785; c=relaxed/simple;
	bh=klCo2mlUvYVyV1sf1JF+OXHuYVQW3zN9YYW2iaPcne0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VQkz9enfd1orF0XzbaAWZtLFAo5op6gh6EaUX+1hUlHpMDKMmwM9TzsrlZfYJ31udt4LryyhqHMhMgwD3FGOe1ycEPzthBi4CGg15kKemAws9LkdL6flpuspktx/d/N3mU+uNgzxieZteN6lwrltm6Zqo7WvqA2XKHFUiZhnetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Svef8XyP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svef8XyP"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fabb948e5aso45046696d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749468783; x=1750073583; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K1Dclu8k/a/Bs1+Ay4RGrbvjVGx8oM9J5I3jZ7k35D4=;
        b=Svef8XyPs6e+4ooUEhOpRXDry0GxicMv7qYzn8WVjvXn0Vycf0XmwnJndVO+ai4qxa
         afhIdWRrNzoWh5gsfdYyMrZtNQsz04/y/WYv1CLikll32n/aZ0OYufZNu0S48QKeptw8
         BdhTzOyGTnqcl7hE8xcp4XEsgyTQQ+guqc6n9RN4j5M9ehdkOVlhRMzSt0eUg/IxtoZ/
         hO+Cr/spWEej4wW5FPWlvNsNKmq1mIbXja14etQBSQH/kYF/ywZe3QuAEVPadMhIFw4T
         sYk5z6Bo6/DBlOxXF4olH9NUD+bu/ouKK2JI4KlJsTTbzc6f5IXlAd+BASRKOiAA+alY
         xGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749468783; x=1750073583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1Dclu8k/a/Bs1+Ay4RGrbvjVGx8oM9J5I3jZ7k35D4=;
        b=DA1xf77CDrK7vIAL59yUKRXuuP8VCMAIBiLw3JiAGHV6lJMyWdJ0YhV2ocF2LeEg6/
         WZGtm0lzFE0QFIigwtfO+9NGSEn0TvFwnELnquGsKhMHHs7Yo1yWctMVAJrAGSVvfyjs
         a5DJ3Fnq4WYOmV++22leeKjLBqGudYsK6pJOar0S+AXAg7laMs29Xn8UcMaVoc25RIro
         TovkJhYHN37qon1EZMlV5MB2u2pyHy00DqIE0rkQzPcFqHK72b6M8CYUK/b25hfLgrJa
         IOvgmCsBs1Qh8gnfdJnpGVs96JtjU/PykN1sU/a46WEW5DGYl8oaTgywofKDR7Iumz43
         L9tw==
X-Gm-Message-State: AOJu0YzSS0e+cMd/rg48S3/p+s1vD+SsZ+08enmkLoQp/57KS/HUpY44
	K+iWbZDa5YwBLepdpYLsQCSjrv/SvW4cU7u4/wfOnEw2EvV/sugstz99Bbm0rg==
X-Gm-Gg: ASbGncsWDjeSHAhAEH4FICmJY9jiUqNM4Vv9UvMwQsE6D5ybxF+1x4Otu6f5aGk/gin
	OjzlIy6CBvZVAo+7Hhcdlb+IsKe5j1UWAX62N9VlvDWCTUMCOfLvFlajrl0hKK7oWws5tGp3LXB
	NqR1piv/C0Dzb17RgP7T7Q8hFag7mLMTjtGJGldrNtx8q2NGLdPpwRF4OgdY7KNMbD86O+giKD+
	nMW1FKJyC+NcBiui6egfPJjrlFU8b6UT6RfCsv/ZyhEm+pHkJQ+1sNLoGUxoakmanR2MI/VNYRc
	TB7wTXdtWRkegnmwZjHW934n8exKNk28YLh0tZdPSYvVe7PhqFhpYNlTp9vkgOYeMKCVJfg=
X-Google-Smtp-Source: AGHT+IHLW/B19d11j9CPvgsQaeXt+58fUmuhfGzl51j/wwhwbTlxwuaF2TpGSZ/QV/r6zglr5c0GWw==
X-Received: by 2002:a05:6214:c6c:b0:6fa:c6e6:11f9 with SMTP id 6a1803df08f44-6fb08fdc77amr196944706d6.11.1749468782591;
        Mon, 09 Jun 2025 04:33:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d2669b4900sm534229085a.109.2025.06.09.04.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 04:33:02 -0700 (PDT)
Message-ID: <6846c66e.050a0220.11e94e.7ff2@mx.google.com>
Date: Mon, 09 Jun 2025 04:33:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1104525958616936503=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] driver: bluetooth: hci_qca:fix unable to load the BT driver
In-Reply-To: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
References: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1104525958616936503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969790

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.55 seconds
BuildKernel                   PASS      25.08 seconds
CheckAllWarning               PASS      27.60 seconds
CheckSparse                   PASS      31.08 seconds
BuildKernel32                 PASS      24.54 seconds
TestRunnerSetup               PASS      458.09 seconds
TestRunner_l2cap-tester       PASS      25.22 seconds
TestRunner_iso-tester         PASS      33.74 seconds
TestRunner_bnep-tester        PASS      5.86 seconds
TestRunner_mgmt-tester        PASS      133.61 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.68 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        PASS      7.25 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PENDING   0.92 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1104525958616936503==--

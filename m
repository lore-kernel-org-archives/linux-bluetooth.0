Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0642554C
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVEZHEzN"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dbb8698312so945169a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703264380; x=1703869180; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LxnsRlVx5ZEo+NLTkC87jccj2iSEirefRhvh779lwOc=;
        b=RVEZHEzNHFzokIlJ4iW61TqHDpiN64oeKkumOxYA7XYKJKYTbz7ZL+NT92/pqQW+Qx
         pfisW/yI7ldhr0w6oTjEmMjVAcl0DIbs4ulzLKseLx4wPdfDZfZH+uB4onrckqa9maZr
         OjsNlPSA03Ae2nd3ohFAwgejKIt9MdzKsXbxd0dpRw1NonZKhfhGa9GF9MK7K0lozeAS
         DCuMi5bF9/sHwHFRiSocUMWpWdSkXeROOWjnbrP8sw5Xo80ieFzUHzAmtV9WpBkFWS4G
         wrIo/HrQcyWaGibQH8IYxqQXdSxgZ1Y4SduJph3Wd2FqaI7ibgpvG+sPrnqcn9xFLKIj
         vDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264380; x=1703869180;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxnsRlVx5ZEo+NLTkC87jccj2iSEirefRhvh779lwOc=;
        b=hD7fK7nZqgt6PkkW/k3i+L5496rbFdaiieSHGNjUrhhydiqyuQxBDvTAubvSboIb8C
         NaH3mMlvDdozW0GexujnL32oMwV95vh+uESc1D7RzhDQH5BG8bA/kyev4hJJMvKC4HFa
         /eIcbPmkrItXaWmA0GxE3GNl9ny7O+fVLg64I2qRnvF1JJWAtq1xoVsOHMKSnZMHlOvQ
         m90EyWtct7zQSwIvlcjSf0H1lJkRVeo5ATdbsilyTGxgnl+G1tEcbp/OaWmeorWcHD6K
         eevqira3DYAq4WctOj8fvHnbqrEPrryGNLrSwUeotMDmCWnXj415BtvU+3ozca4gAa58
         ZEHw==
X-Gm-Message-State: AOJu0YzcAaYTzDA9f/X3f7rjv7lJ0y7pKwvgrV/EQ8qlhPzSLw9VUFCt
	r6maV4lSjAb20dKJRBf2phP93WBuZ4g=
X-Google-Smtp-Source: AGHT+IExylWE9fOew/jjNJDPnQserHWUFNvFfkZnOV8kCUAhRDaTjW65kAlj7HH1UXJpSIo/9CiLZw==
X-Received: by 2002:a9d:7a89:0:b0:6db:ab5f:ec53 with SMTP id l9-20020a9d7a89000000b006dbab5fec53mr1249568otn.29.1703264379915;
        Fri, 22 Dec 2023 08:59:39 -0800 (PST)
Received: from [172.17.0.2] ([20.109.39.176])
        by smtp.gmail.com with ESMTPSA id ca22-20020a05622a1f1600b004261cc033b1sm1992736qtb.45.2023.12.22.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:59:39 -0800 (PST)
Message-ID: <6585c07b.050a0220.b394e.b79c@mx.google.com>
Date: Fri, 22 Dec 2023 08:59:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6972097904214608480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2045gemini@gmail.com
Subject: RE: [v2] Bluetooth: Fix atomicity violation in conn_info_{min,max}_age_set
In-Reply-To: <20231222162310.6461-1-2045gemini@gmail.com>
References: <20231222162310.6461-1-2045gemini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6972097904214608480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812527

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.87 seconds
CheckAllWarning               PASS      30.86 seconds
CheckSparse                   PASS      35.69 seconds
CheckSmatch                   PASS      99.15 seconds
BuildKernel32                 PASS      27.53 seconds
TestRunnerSetup               PASS      433.36 seconds
TestRunner_l2cap-tester       PASS      22.99 seconds
TestRunner_iso-tester         PASS      44.97 seconds
TestRunner_bnep-tester        PASS      6.91 seconds
TestRunner_mgmt-tester        PASS      159.60 seconds
TestRunner_rfcomm-tester      PASS      11.20 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      12.12 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      9.84 seconds
TestRunner_userchan-tester    PASS      7.28 seconds
IncrementalBuild              PASS      26.10 seconds



---
Regards,
Linux Bluetooth


--===============6972097904214608480==--

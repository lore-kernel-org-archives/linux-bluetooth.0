Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28369151CD4
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898928; cv=none; b=lSneWZwmfCPjuScVMSJxKibHnhBR/tlmLikNPWJG0HRfICxFws+M77Tsp1jZTX9x06OXsK8pokS6tw41/sJ0cTZPQ8imOlSmCjuUzeLtE+QvWD3+0mSzT/z6A5yElTmQwuu/08c+2iKf+5c2kgFOfBdFUGbcfkXthpq9c4R0XlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898928; c=relaxed/simple;
	bh=BISo9dUHgKfPI9b1UOH+Ck5bBXcty+l5O4WJDKzS6iI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KgM74PKg8EqRrQMyFNxhIQKPsk8quwujMjoujsmb/xZU2Nu74J8X3q83c7OpgflszlstgJJcoA8fuN296KutFyBiLs4FZxcW1ZMDzSJrkaM5Onv2uR52p6y0n8nLvzUbsnGlA9UhPsZ2A/UEHMi9s/K7lqbmcAsTp7MFM5JIAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv+yOeEX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv+yOeEX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783fa618997so144730285a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 10:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706898926; x=1707503726; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/WUp72czla7q5XAdPCLHraBuu5Ga4gTpCC/SglUr9mg=;
        b=lv+yOeEXcdQxFaWeluWgsyQCnf5UzYUNplmvMC34zbHhe7hlemYZwL9Xlz8Qfc8unH
         ZiQ964CPIIdLkX3ippIScDnH3agKeIqCjfddSFIf+PFXwwZOck6cOhFFpFh6ka8ct1z8
         ShR2iieu2RcxPO/iDko21IC67h9OUlWJ5cTGa38Ffq/vvfntx3AGbSD7M7hvO6juuRWP
         BxayYUDotRxpY7SMksUJqX2DTg9aiwtNU/VVrjHk1p/+woZnUSFk9eFKpPz1yeq1fMqy
         rMOto2JIAi6LooaH1mhF57dvayZ3DnMr7SWTB3otza1qQOw814ZQZFl5kD3Qw+QllbNt
         EyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898926; x=1707503726;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WUp72czla7q5XAdPCLHraBuu5Ga4gTpCC/SglUr9mg=;
        b=LAgW6XfIcZVSXUhZE9VXTz/am877jzKck5r1niAcYTV0z2ZdGV6YZdgz8UjIVh+cP6
         DfAi/ncVUPxirIzdTvsicazjzkaPJnvNJNCYNFWY0GAEIVmRAcbxX7SdTgjjttTnXsLX
         dfZKYvk3qsfPYTRB+3dAXja4A4Xz+4bQb4eOcJRIrB2BfQu2fEcTUECuPYh9sjra3Mlx
         W0PA4cJNT+wCX9lgYMWF8+c0TWgRlP9Gr8HJE4azvQd5NpSRGRuQ2FfU/3Mtw4K5JgEj
         ZjFTVM1hx7Zw04KKoIN4nFioTBTx9cbubpSW1cSvYKji6qfuu0zL4tBDN4K1+vOleBp8
         VFmQ==
X-Gm-Message-State: AOJu0Yx4f4gKtTKX5moaKhcdsgzu0QDCOexJ675GIP/iH9GVhL2cmXFp
	4yi+y2Mh9rVW3ofRHo6We/VLGDXCqTTaEjrWoletEFJrYRel/3PniO+ic1dP
X-Google-Smtp-Source: AGHT+IFcZcAqgGa7PMSJOHvgq75bCwgiwdiBD1IwlA6dLWg470hEbKsgVDsdcO5zTtc5R/+UoknIZw==
X-Received: by 2002:a05:620a:948:b0:784:da2:5799 with SMTP id w8-20020a05620a094800b007840da25799mr6574337qkw.45.1706898925839;
        Fri, 02 Feb 2024 10:35:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWvPwV6izQwo62Aq5ka1IkLbw2iodk5OIQ8oEWWUGn45iAjm6IMFwvUArfsA7Q+zS012y4KfNugiEX071k7APkWC8k1qQ==
Received: from [172.17.0.2] ([172.183.77.201])
        by smtp.gmail.com with ESMTPSA id y13-20020a37e30d000000b0078437ff4870sm877415qki.31.2024.02.02.10.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:35:25 -0800 (PST)
Message-ID: <65bd35ed.370a0220.6c179.5b7c@mx.google.com>
Date: Fri, 02 Feb 2024 10:35:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8709005801918998943=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
In-Reply-To: <20240202180951.1605724-1-luiz.dentz@gmail.com>
References: <20240202180951.1605724-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8709005801918998943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822632

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.60 seconds
CheckAllWarning               PASS      30.51 seconds
CheckSparse                   WARNING   36.34 seconds
CheckSmatch                   WARNING   99.00 seconds
BuildKernel32                 PASS      27.20 seconds
TestRunnerSetup               PASS      432.46 seconds
TestRunner_l2cap-tester       PASS      22.92 seconds
TestRunner_iso-tester         PASS      42.30 seconds
TestRunner_bnep-tester        PASS      7.88 seconds
TestRunner_mgmt-tester        PASS      154.65 seconds
TestRunner_rfcomm-tester      PASS      10.85 seconds
TestRunner_sco-tester         PASS      14.33 seconds
TestRunner_ioctl-tester       PASS      12.37 seconds
TestRunner_mesh-tester        PASS      8.73 seconds
TestRunner_smp-tester         PASS      9.69 seconds
TestRunner_userchan-tester    PASS      7.15 seconds
IncrementalBuild              PASS      25.75 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============8709005801918998943==--

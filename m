Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B527146D60
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366880; cv=none; b=t1RIN5cFI+UhZ9WS6u8GtQ44TLvrPuKdNpQVsiokRuAOnnE2sCwAZ9RcV49fbmfipTaU1OVFYsdWcWRAqFCwGyXUr4gsccsbsQnweDAVhLDD4LEO0vNsTLuV4A/9VOkxYewwiorKKtxDMjkEMU3Zf9CBLWF8Z8QCZeSvD9Wt3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366880; c=relaxed/simple;
	bh=p6d8nk+5Dh1DyzNuZgJJe/0RbryA80Sh2ekYHiGRzts=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Iy/l+VN0g2nuTApCYj7yGMGa/0bEwbHrC5+a38XuQquQtFWCX8XeA1Tf5b8qw1KOv4Ai8iIN+aimz2NEnooQkWKzTmmMqbrCPHItW46M0eaPeFllcsTRBVyjUoVaZATIeMMZa5wzUiJC2aL3FTnrqLNYJslnz3+nuO79VgN0cys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzrwPAri; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzrwPAri"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eb848b5a2eso1759860a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713366878; x=1713971678; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p6d8nk+5Dh1DyzNuZgJJe/0RbryA80Sh2ekYHiGRzts=;
        b=dzrwPAriXG4wXY6FBUXsV7FpHEhWQ8tpz9goSiS/k7dykjDKc8udC3tQabGzeRPzXz
         XRZKtBG5/JXDE0jZD7dwuVBbw5HsD1GsoNGB73F24QLN+3KGcQjACZO8NINk6hQwj4m6
         uY3fIL0BUarfSQWwkQwFOwaJueYneFPXEJL+V7qSG/T2uz0/b2FHOubHF8bJvP0rEKhi
         dSitCSSM/RJUobf8t4ZasFCY2elAVw73b6biDDFJgyqk+VMu6+AseIHggqEQNCZNdpE8
         kC/Dhh9Sb8T1vGyonaB+3guINqk7bpVJHgMi/hcL6p5hH445EO3zMM+cKZSe/DPOUNqy
         wI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713366878; x=1713971678;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6d8nk+5Dh1DyzNuZgJJe/0RbryA80Sh2ekYHiGRzts=;
        b=bG+Fv+xslysK59xJQacBFTjGD4JUTibaBo4ZQANeOEPpzY5P21gBHAyTLQbuA8PhNL
         DYx8Khc/tH6up26cWzU2/g6H9Lt+aVbF4xTJ4kCG5ErwNJA2hfziSKRyFVLsR22ttCWx
         l4MgY4zohViEfUQE0M5e7gXIVZXgPBbRAEpvphw1dHZqaQFCIFCzY3H1QLdCgLLJjnwr
         mQojlUArb41t3yG5F7YUe6beh8kgYOZUx44T6ccsWI+yJXQUcL/ReG+3aqHLlzYH7loG
         J4C80swEtDVHV15jbuxTdXH0bvWv826v4y7soeEghUfkIYpizcPUKcW1wkqI5jkHN3je
         Sjrw==
X-Gm-Message-State: AOJu0YwMp8h3OiQ0ez5l/KZdolsm7+mEgjxAlz2jDDkp6YqJpMMQa50T
	HdkBOACTKaN+/sSkjXZklrs2JUSaNFWbpXtPJtOPTcVsUjfSYUuPxLFrOA==
X-Google-Smtp-Source: AGHT+IHsPs6dK3kW4mODj0Ut7rGTaD0TDAf1K4QAeRM6ocpmigPryBwW/Dn3ov8T7E3pKa2/UckT1w==
X-Received: by 2002:a05:6830:51:b0:6eb:8594:31a4 with SMTP id d17-20020a056830005100b006eb859431a4mr7423920otp.6.1713366878312;
        Wed, 17 Apr 2024 08:14:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.230])
        by smtp.gmail.com with ESMTPSA id o2-20020a0c8c42000000b006a0503a5217sm20421qvb.108.2024.04.17.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 08:14:38 -0700 (PDT)
Message-ID: <661fe75e.0c0a0220.7e1f2.024c@mx.google.com>
Date: Wed, 17 Apr 2024 08:14:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6229071936389500884=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v3] Bluetooth: qca: Fix QCA6390 enable failure after reboot or disable
In-Reply-To: <1713366251-22144-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713366251-22144-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6229071936389500884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:2362
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6229071936389500884==--

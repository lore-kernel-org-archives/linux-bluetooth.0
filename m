Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4E20C02B
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668736; cv=none; b=W0/KzjmKUWrrn5y3kjXAyvfZ90FwEehoWhuD+tTg9czJyXkSjbu9sEUihjNLXX07Fvb6dQxp7KfZOS8TZ3U6CguWKUofTCEO2msiMn2n3u97rwhuSAfK+KKACHgTb0h+rNNbBxJTW/nVRbU/c1RYhTvHElubiio6nnA8s5kBJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668736; c=relaxed/simple;
	bh=2nDPlO7s6ypG+0wTFUWMK3dhhsU4eN4pHqTsO1SBib8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JxbR8Ko/ShlEQj3X5tjOnnMBeoCRIIwGHHcwRWzbNDrBeHAurfGUMsIaW71vbwzvEjpiGAOE3UTpnb2jdhudv1RVs1xFfkHC9JKN7YKUuV98BiPYm4PF1QR4B6+4LHkXenO56u8JIuYfsv7zge80PS33sq27oHB2faS4LEyIewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re/o3lLn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re/o3lLn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso97158875ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 03:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738668734; x=1739273534; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wQyEyg53aV/sY6c30Od9fLxIcpxTjpwMFqV+Vk0J8s4=;
        b=Re/o3lLnCeUfoxSXhapV6BUtXuQGU1/bjG3OAUeXeyjB/OmGM6Ti2/EnTPhTR0CRP8
         WXvkqJ0M8e78bpBe64ogWHOAQH9rM0VjCl2L14dpzj2IhC44OKcYgJmnrbTI3LGDxGAy
         w8iJMkJcyrFvSKX3dWsvM9fwkeQ+WNZ4vpYb65fxEQ9racmMUYsn7VoU0ZtecmUJk/AF
         hIoy/IB15EYV+Pofkr46HktC6WznsKaWOn0XLyRMHpcmiPcFWWVQ6Mu1bK0mabHldb+B
         VdtXMbhxm+47he1BRZklzMm7SwZLTVpWhqSWZi9tZV2hRCymlIiw9HvGDtlDP07+Btl4
         2dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668734; x=1739273534;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQyEyg53aV/sY6c30Od9fLxIcpxTjpwMFqV+Vk0J8s4=;
        b=sRVL9Wy+9h9ckAFbvOLZtTU2ZoVVPEMQTOMwa5wIu1M+vBK0lDRBppNxtTz3lwVVOi
         U3N1Zxjt6l9pXpjLo8Gmo5ze3kuV0rmXpGlg5qJQpSHFLzo1S26If1jiiBEuJkU2qxEs
         1e0iZL5TEMtdojFd9h0rXLjvlu6pw3KI5KqQaGEqJFeDNTzIApBQCytOVWMvmiszbj1d
         1iZ9+Q16wt25ArJB5AWjO0bGeMMJjhet1qTV34Dv/zQAA9zU3HiXUSShAsdyWuU6sWYc
         k8T9ONvP+pZs8V4IUYBK/OAG+SVOsXyw5FMmAcuMODzPlbLC8T8OT5fglfT/ThUwGnd+
         dsEw==
X-Gm-Message-State: AOJu0YzOvcc2Z+L7bMLVh6pfqd7MynDsjSClwPXuU9amgZFrBZmCk2JZ
	bsmsFb7raOTMRG/qdnlYfqA356R0Ze7pam3kwNYWdDuHa+RAqa2SKgZeGw==
X-Gm-Gg: ASbGnctJswqA5R4CeelM7+PpnljeaeLhhxdTS0eWjkpfCT4ErfmRZhVVLNuVx+EqkR5
	UO7NlKlOV7mkWBrxRwcy5MRJZj17YdkoprbPlXzrjosYq+dLcRQ/qdEHEIYPRfXWhoZmYq+9Ah2
	9VkAvjhgmMFFYx2g1WxBAVDfA+j4wvSG0/IoakcviAtYk8O+aWafqMfq5YMsnM1BrtqKIuWd+bW
	YZ0vOm3bTjGV9xpwBmdA/kZRA5KLc5QC7ZZ/YgnvGNcsZKAvVm5WQ0U2jcll1gIRmVjjO/YO0WB
	pJtEdrz8XlMjmjvk/qT0
X-Google-Smtp-Source: AGHT+IGCMJOGZBrvtNo/zZydrvKbgoQ44mJ23bBNbMFDj41eMUbtHQ/lIVKTFAFk8pG08wu2Zutf0w==
X-Received: by 2002:a17:903:98e:b0:21f:db8:262d with SMTP id d9443c01a7336-21f0db827b5mr7211545ad.35.1738668733965;
        Tue, 04 Feb 2025 03:32:13 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de330386fsm93875745ad.192.2025.02.04.03.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:32:13 -0800 (PST)
Message-ID: <67a1fabd.170a0220.306b33.3f1c@mx.google.com>
Date: Tue, 04 Feb 2025 03:32:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4447182530270020565=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pmontes@shsconsultores.es
Subject: RE: Fix Ubuntu 24.04 build error
In-Reply-To: <20250204101612.66823-2-pmontes@shsconsultores.es>
References: <20250204101612.66823-2-pmontes@shsconsultores.es>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4447182530270020565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=930379

---Test result---

Test Summary:
CheckPatch                    PENDING   0.73 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      1422.28 seconds
MakeCheck                     PASS      19.13 seconds
MakeDistcheck                 PASS      156.15 seconds
CheckValgrind                 PASS      214.21 seconds
CheckSmatch                   PASS      267.65 seconds
bluezmakeextell               PASS      96.89 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      852.84 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4447182530270020565==--

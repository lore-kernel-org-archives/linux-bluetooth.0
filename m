Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601AE1CAA62
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748334978; cv=none; b=PO/e2PFR+J4t4pNy86IxHzPOcAy6TK2M92v+IofB64jKhSy3/MUYKXKX7sN2YDmc0OGGAN52oKdu3YDtvaUK0T4OXS3IAcV6XTmFk9L+jLqtk1S/xdXyumLh3iBYd0eem1qmic8AE1JAM55vIxzEJJbK/96GvVlkzgNQJdD5qAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748334978; c=relaxed/simple;
	bh=Q8hoTu8dnWNjChIV6REavb3vFpNYg0ZUy06gV9ZaqE8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nZjrBdWK9pfD/lE+VrIAIj09djibMkx+GFMymIrRo/amDqiHaBGRMeafChvkhUCYOoRMrOFBNZn2re974icNzSoODqSyqpTw9c8mBdEJggMeyDwm2Gyc2eo79h8gQIAZPMPvhxxt581O/6E9aSZP7GdS7NO7kkxur3uXKUq41Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/CzxlFg; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/CzxlFg"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-861d7a09c88so55566739f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748334975; x=1748939775; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+XlUwZDlzbG7DujFAHPt61g2rS72i69avswj/Hl7X+c=;
        b=B/CzxlFg06pBWejKOKRViudnBCNVFHXStIwsYd8Yv23omGnqfV6k3DX6TUsuTWPEBF
         3nneYpazSXvLj1LpLbkEb/d5VTI8mV7npTxsgz6sYI9/LUxdsuEmjzdvtme5galwD6IP
         EMf7zoQ7WMSIJRinbK4+U6SgIO3swZz5SDs1LN78+Fsinamx4uhmamVo3qmHIqJbEkcw
         04Oi29a/0KheeTti/dwey0UVIgjKiBQtZM5Q1OkCQaZeO/WdByX8qWL2Gw771wWnLtM9
         GkuIy+xy0Jb3hGsYLEr622RkO1JuBbLLu5kLn+7beq2XewlJRfwWHwwkRKoCCknYZo8T
         N3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748334975; x=1748939775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XlUwZDlzbG7DujFAHPt61g2rS72i69avswj/Hl7X+c=;
        b=t9NcT/Zq1Iw3FviPzQri7Dv9Ak8BBaivsaviCGy8SYAqoJO5X9jcy356RYizZzXe8v
         8f+nyFodecvX1pPvyKL8qxs1Z+Rn75XQxiQgXCwmIH2/7yHHfDVrk/DPB3r3jwL/H67j
         SETrVsHKcCdOqC0Hzf806MbEJbq1FoxC5Up0T2amhFe6As6xCsLkeVJujCI5xhk2AdUi
         6fTySL3+smFqSdznGAJZ96ARuPRJ+gJTt+nO4Wm3BdMRibmpSHIQxthcmvc3J9s9NZAQ
         xw1uBA0m9Yt+dx4E1jixzlv6pmQnq7knOsTVUmMtPRACk08bUH6MGckYS9GxcfG0AVsg
         f6og==
X-Gm-Message-State: AOJu0Yxa6UHwn9446Gg3zghvwMc/2tDPj1z41ZtmrIR6TL4KLNZWOiv5
	pEuxSUWpHBVxEOmsLpV2RaqljTvfMIR50CX/n8jDMunvwFnQe3r9mW8mJTBUYfcl
X-Gm-Gg: ASbGncv5684KP8V7RHgn3WzmwCXWK2y5p3/VYMoc6g3Dk0hEcEEVOfzVX9cd4Qw06tR
	Sc0ffqT+HluwKisBmchs3ndXPiA92cmo7mF1tQ3mMQSLtEztjPtlQUOVHpFhXM8JJI9tzwVTPlF
	RGDs98UarZuL97IfYzaVi6iVAZtfRKzfsVwmx7wjpCCTfoZ6C4tHap2+cWCCzGa/ZoJSDzZQ22T
	N6jLEaqt/b39c+y0mjqQ1b8vlquZOAKv9ihkGZR1fE+5IaTBkMtTyoMWald96PLaznfgGo2VF3Z
	4j0e0lVAyR5l2PxWQYh41brNEwrhsrEL+QWyLReaRxqMGIa+H34SQxRVklmEe+NWk0N2
X-Google-Smtp-Source: AGHT+IGYfvuQS19dhmlccBr+USQD1MHLKLtbsH8jI/XcqK/YkiB5VcBTL3KoPR2GVla/eOoIWup3TQ==
X-Received: by 2002:a05:6602:3684:b0:85e:a8db:fa10 with SMTP id ca18e2360f4ac-86cbb7b82bcmr1178902239f.1.1748334974904;
        Tue, 27 May 2025 01:36:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.185.48.233])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4afb28sm5062389173.116.2025.05.27.01.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 01:36:14 -0700 (PDT)
Message-ID: <6835797e.020a0220.ffd4c.8de5@mx.google.com>
Date: Tue, 27 May 2025 01:36:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8376535048339585120=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] obexd/transfer: Send Transferred property on transfer completion
In-Reply-To: <20250527071759.130143-1-frederic.danis@collabora.com>
References: <20250527071759.130143-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8376535048339585120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966569

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      2685.58 seconds
MakeCheck                     PASS      20.11 seconds
MakeDistcheck                 PASS      200.18 seconds
CheckValgrind                 PASS      277.46 seconds
CheckSmatch                   PASS      302.62 seconds
bluezmakeextell               PASS      129.06 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      923.81 seconds

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


--===============8376535048339585120==--

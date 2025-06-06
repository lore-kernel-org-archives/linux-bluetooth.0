Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CE27468
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202532; cv=none; b=FF4FTBQ0oLj1PknFiSz37+H9xbnxoIr9OiiscrEsHcKY6Zuzs1yRmxM+/oJ+86Thjpmw5/YoAk2rjEllGzl2Lrcsf54hVFESLEBu6Kt+PCv3HqGGLJfE3ZKNUvlvg6TwrkXUZz4n4E31uk10g1fTI0zDkcDyQPLodPCLKitMk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202532; c=relaxed/simple;
	bh=lqwPYDU6ypArepCFVqmD/3dOYF7GNb4P90olwWpiF7c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CX3Cohuo4onbZVLHBS394s9MSXeIQ0aYeltHULoRMGRRT1KN3GwmlaznJjL4FD92wujChrCmfP7OMDssfjQb7vGPFML4J1se9oNOIxLcycV0Bx9j8JZVwfcJDV68+vh3jKndEPDA6iX4LIA72nd/6SL7YuoGvIMDqx/Qry/lPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3k8yDz3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3k8yDz3"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fad3400ea3so18937796d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Jun 2025 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749202529; x=1749807329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6TTqXqpIQRuA+COzghXhFH2AX0SOmPNViIy1DTBcOLE=;
        b=d3k8yDz3B9J/pL7M329bCNIdVm/q0wsUrCXlq0tSRL6GbvAu18+QsxJbPofKlbm2K1
         8hUZ7gXLDebQwRIq6V0filSzYGhj8NXM8hOMGUSZsGjcBT2FC8ngYgbmFARSfQaBvjoM
         2859tcHHJZP/ixdA17m1XSIB/QaUZ+afzSJG4aM9j31KyP5EO80Kvl+z2PPu8Ur0C3vc
         bNcneIXIbWnuFdOLmaJeGEK6mucPWSGGodr7PhXxa/qwqMNJMvGMQ5Jo1oMqq42hgGoH
         KmmQNbyWuKLwEwvxR/Ml1VXvtGNlt9HrC+hf1ke5NWPjcEGkM9fKN78JZPAVre0Uw2nw
         r1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202529; x=1749807329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TTqXqpIQRuA+COzghXhFH2AX0SOmPNViIy1DTBcOLE=;
        b=Zzq7C008F+GS/DnVbXQBZSKBtRvLG8WCCXV2SgOc6n8eoRE62fFhZfKnmXYVqeXtyb
         dCm/x4SIhW6Y5wb/KtmYsDfKWhJVoYSo/gkleUEKy5Cw0h92s8qHC3R2L4tlT5x4xzhD
         JnHoRjbvVMIVBywP4i2DkVcIiXwt3SCD+f/XlAAcP3YAAlgwGv7HQL9l/WavMQrojoff
         E447LwFTCAgvZDm40akqWgFlrItRBFnL8oGPeFe8tnUF4P/MCkzENH6TahsmoSmcmps3
         cwhm/uEg2hIhZjV4HW2TaOyc6Go3vsS1tC/s0CYyDs6wvlVA9P6j+MucooNcWGehaj5B
         1QXA==
X-Gm-Message-State: AOJu0Yx7lnK3RgR+SsCXKs5+9ys5/UiH8RFM7CRj/ihqKUMwoPBXbiIz
	zj1G1egfOsSwuy7pZcqQ2k2+nfqbw+d/AlUI1iK427/kZ0RCzHsugp4j4NzG3w==
X-Gm-Gg: ASbGncv/IlJWsj2ODEl1umFW3i6Mk0+eVYZrAW/P77OFnhWPc1DQ1MxJ/GwSTB2Ls0F
	2s7fIlaFVRrBT+ZUy5Mk6Lxy44ogRB3VtazsVNZLwDof2Y1KW3yrSWCTjRoHcD6TU98pkzDCRzJ
	RHI1qOZzzvwMPEL8fwfCrj4mZYEpZ5zBN3JJZPLjsvp6yv3NDqLYgY7Dvx63XchfaSf4CXgJMm5
	2XryryKT/oGDsxeJ6++w89XBulL1Zh5REXMkvqLdlxeJdAuxEuL+0qbt1CqFylyA0SJMdHCNiwK
	dNYozWZtPh1w+e5eFkItYpIvFp6NHzDietZa4r4VxAcO/gBBJNAQQqKFFyAR7NdV+hKMjlQ=
X-Google-Smtp-Source: AGHT+IFdwkewPOx+AjoaUYBDnLYJXJu213ok/8AtEilRt3Umc0zK/1wPKmnOc+Bm+bkz/bf3k3R9Ew==
X-Received: by 2002:ad4:5dc8:0:b0:6fa:bb44:fddf with SMTP id 6a1803df08f44-6fb08f62c99mr44476456d6.16.1749202528899;
        Fri, 06 Jun 2025 02:35:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.175.198])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d2669b800csm105590985a.107.2025.06.06.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:35:28 -0700 (PDT)
Message-ID: <6842b660.e90a0220.320795.1667@mx.google.com>
Date: Fri, 06 Jun 2025 02:35:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3792432664186850020=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: Add support for RTK firmware version 3 and enhanced ACL-based download acceleration
In-Reply-To: <20250606090559.896242-2-hildawu@realtek.com>
References: <20250606090559.896242-2-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3792432664186850020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969182

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      24.86 seconds
CheckAllWarning               PASS      27.82 seconds
CheckSparse                   PASS      31.89 seconds
BuildKernel32                 PASS      24.75 seconds
TestRunnerSetup               PASS      467.42 seconds
TestRunner_l2cap-tester       PASS      25.36 seconds
TestRunner_iso-tester         PASS      42.36 seconds
TestRunner_bnep-tester        PASS      5.93 seconds
TestRunner_mgmt-tester        PASS      133.73 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         PASS      15.11 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        PASS      7.30 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.29 seconds
IncrementalBuild              PENDING   0.81 seconds

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


--===============3792432664186850020==--

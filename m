Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAACA8633A
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747295; cv=none; b=P8gX7sCg5G60eEJp7hRBUm2QLgEtcTiMF6QE9koFyON2IS//St1pAyyfEr+aTP8Hi2Ffilec7dBE4sx5WZwOcX2STDzgMNHIICIbXIJyi0N3gha1c7isZZ0KqLm/nvs8DAtOG7irse1yAMpjxYJ2ny8OTzqCu1+aonnyeuiOvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747295; c=relaxed/simple;
	bh=RqoEM0rM2XMb02hb5ncVSijgVGQEyO+Dl/lRYcX5SB4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YRJgkf2Zv/k15DlRHV6PRhaDeOy3ojE3D9ZEQ5AyOrgh1OlVtSGK2TjnASgq3R6IdZjUzOlhINl5Yv5iLaMshLUVOordZsKlhuEIYRFyyEVcZweE+zUtqaOHBKHx+mH8XInAcIEv/en8rUrLloLpx/HAeNWhX7pSzkG/quIrGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0/Vv3/i; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0/Vv3/i"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd1962a75bso39369136d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 19:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741747292; x=1742352092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QeRHu6ww3YMzN1YrRBOiiqrOCdrgfEAVE6mUYt5I6VI=;
        b=E0/Vv3/i9yZrBJb7PdS+S9ydUyA2ILL+kYd7f9fwNhJckLEDVjS2/4EygkzWNa++aE
         +9ZKPAjksnkAscogoFhCC0ee03Ep/EM6NDbUVwMlV+xF+ns4sVb4w/6ri/BgPeY8dqnC
         KcEzrda7jC9oPPxlFQpWaI1dVoMDOeAfGf5uiGf4wLJ5Q+bQcpF/nkNijikSftcLoSXX
         MJkFF/YH5QNZkxGncseU37OfOMaer4V6dznHHeEOz7A1l3kaqkeLyaZwhRpH+N2aPMAc
         HfydVPPKINwWAqZG7IJHHQ29c0264RaGbmap+H4x3HI/cM8fhoz83ymtDkBdAD99oYBx
         gn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741747292; x=1742352092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeRHu6ww3YMzN1YrRBOiiqrOCdrgfEAVE6mUYt5I6VI=;
        b=Xe0O97Qm7Bowd7z6+dLQnKIjjiK3ZHOIFjv59Vc0Dmyz61c7XH0+xOKDkiIbFns9e8
         2hLySlJqqW8hDezp2PXxWznx3aExDaxqqdklV8Fp5gQbyEsh2Yg7OGD241AGv+uIkaHU
         jfU8lH+3JQi3J6kxuERdBlrgRhb5GA02encjf05fVynGi6TC22l8AnMYScbwvNdedZVd
         iqAwct+8Nge4dM6Yj3T8ynbuRAwEnPaXBJvImYLGdKGndmtmn3T9WIeaxKVYHbbwXlqw
         LNdL1ur/aRHy4f8/cW1TGig+KakuVFLz5XL9CyvxS0wI1fv4z0ImgxRQlkhCiQxi9Kxm
         iDeA==
X-Gm-Message-State: AOJu0YxQ5CC/nhuMx60QSe2z1gRyYL7NbOyNrieM3icidac/ZDOm3EIE
	R1YrLEBuqtRNVZ/8OEWugAWMqWEBKAniKyNeOsTcOJs3tIiJXTK+wkkn9w==
X-Gm-Gg: ASbGnct2xnIb5SpKviCcHfByxchKIJqM8PimpmA4zOcLgpDsdXa32yTgzxe0ll2YyK9
	u0HRp9RvR+BlI/MeKe/K9cq+in/spRhRKZZw5HIOflZPbQSVNO5XlS0G7t4kNCkMGqNIidcQ0S0
	GkpZgw16jKSwIzdL+gIhT4gxyu7knbiLQLZKyQ95PXq2dhsdZo9M/24yXfXwKytKFymYBihYxKQ
	fyPph3zqAZpAwF+7vbR8uPLfcJXaDM16V+TRPl4SpZYdfhAzRTaPQlpCZoywe0Nhgj9WjoQ3Kt4
	RAOdHMNn/CHOCRhMoCo9K7yY54beCl3yAJ74L6Qab8c6Lzx4xxvFBDbkFAk03a8=
X-Google-Smtp-Source: AGHT+IEc4g2NpB/LTQzkMaB79rfp+xkspgH/qIsJQKSYg6Y0TN2L+MSL/QYIeN3IIbXukwqGXyzNBA==
X-Received: by 2002:a05:6214:258e:b0:6e6:646e:a0f0 with SMTP id 6a1803df08f44-6e9005db63cmr212151396d6.12.1741747292452;
        Tue, 11 Mar 2025 19:41:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c381sm78985966d6.9.2025.03.11.19.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 19:41:31 -0700 (PDT)
Message-ID: <67d0f45b.d40a0220.285ee.b81d@mx.google.com>
Date: Tue, 11 Mar 2025 19:41:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4103404424475251584=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler removal
In-Reply-To: <20250312012522.53604-1-sean.wang@kernel.org>
References: <20250312012522.53604-1-sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4103404424475251584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942910

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.48 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   PASS      31.00 seconds
BuildKernel32                 PASS      24.02 seconds
TestRunnerSetup               PASS      429.93 seconds
TestRunner_l2cap-tester       PASS      23.08 seconds
TestRunner_iso-tester         PASS      32.61 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      119.44 seconds
TestRunner_rfcomm-tester      PASS      7.98 seconds
TestRunner_sco-tester         PASS      16.30 seconds
TestRunner_ioctl-tester       PASS      8.46 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      7.28 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.175 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.150 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4103404424475251584==--

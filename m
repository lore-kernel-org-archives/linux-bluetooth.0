Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1893D25DC
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457505; cv=none; b=dsg8caeblyLv+6Ut+aQ/ISaNDOHrZnmWJVHUATQzF72BgmKyCjH5vjWJvTRauk2Ubgbqk2fdj2jmegc8a6SZYDsNb8FAjgA1ZrsSsTPzD4ulqF59qOH2zYUDtZaJAx040rEpntr3omuqODQxMQHmhNYBJzAYzSPwqPYYfwdw1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457505; c=relaxed/simple;
	bh=zTGRdm7ZUIkieENfA1lGGF8VcbzIvdDZVhXLVafsPzw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fGX9W+diEka0m8qOyzQkbdfjSriCviimg47PFHODKQ/s8HRi/nM7RXahIOD7OBApZXrVChAIh/3fbJeehHclRYsXWHy700C+F2QacpNU5XWmKzA0vzusyA/Gvrpg2/zNFDF0f+kIY4MDrXPqujRkIJFDRQnPQi8PgvQNI7wQADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmPli874; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmPli874"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9106ea78cd8so1160781885a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779457496; x=1780062296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L7fX10Jcd4jRU1jgImKn4FU4kY1o/sSZfH1ZNli1dEk=;
        b=dmPli87463iUBX9VsgWuUg7Nq3Qoe7iWSrCnE5upEfjZgB0eCcjzYdks9E3ZSol/tZ
         2egFUoUdH3EVj6vXV14gF4YKcAyUG0WVpf0QgSigqyQNo7NvkhSqpH8TeHhdAOEdWxKm
         Hk87QnXxK06YyAjeygOTMEr5JCf7GRgxUHXEacyesNwkGbML/7CWTaVpchEpmwWx7y2y
         kRzKqR/5wsIqA+Dgn/HPTqsCmL1gbVASfjjifODipOZQteH+a5UEGmXMQsWTzop0rYGr
         rXVQWceO3oV0r+pSEHhTUBvMeTwEYv8PWd+wNABsWW9XaI5VSrpJ1go4EBltHdJbgqqI
         8SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457496; x=1780062296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7fX10Jcd4jRU1jgImKn4FU4kY1o/sSZfH1ZNli1dEk=;
        b=rQVZzWCaMkuu0iCISJ8vdsc34NCcBmFtQiaYQXtafWsTliFazDQSRjox4voRfVGgO/
         /yzdulXL9BEDCR8itx/HXsMmUY4UslMK3IX2qiJ/UeiY/Is1Fiy/65/bVaArsGoUf0qq
         2BYDYMNvY7hBsTySdOmQ7+K3cckeeMrT1CvoCzh3Z1iPwaVO10T7qtlNq3oXlUDfMYBy
         ZbIQzi+u2Xj8jS1ZMx93ynqYcq2D9BIuHn7dSI2OCQMBk4pwXd40WmS0THnjJ2vyiYTP
         AcRWK5y2DbPjIdSLO85gJ89KiDKErXyH5Rb60kVeG5pMx8Px9NzazqWvBHsTu5lMbmqx
         CAlQ==
X-Gm-Message-State: AOJu0YzBkcspwsQjz+W9YMka2m4OJGMxK7v6yjaIFB3hKAztNyUhCsWH
	U/av1/RU8MC5bZPa3P8SOTCIVpVQU23LXMWFOi1ecMB2f6LPf0u8anJ6k6hJcA==
X-Gm-Gg: Acq92OGAH6Osv4UxaY9b3b03DO4zBvr5QQ5z4DUAA6hCYhF6o6Br810h6TId0vu0QwW
	czx7i8fE/PvsIssAmYDJ2d6DRH11kKLVWM7QwfcNwfT4L0GCeSOR21bQIcPQWzeROjbIRys5n5x
	pPs8eshDn/5CLFF8/+pmHNqHdvVZpGrNnoBykEcHO0yO8XUKLBZbi4Pvz3cQWuVqrgM2cjrc8rb
	890mPxKi5cHdRJNBYTmzKWOjePAV4xSecePUDZA9PWFCuLzEhl57EYUyKfPQT2SZGtdYHtM4kkr
	SHF74ct9dVWxeVs8UKSSd7552dny7c5u+QRhg+y8NhjfpJFE3ZsADCtjNTS34RQ3bH76La6iCf9
	gxaPG8oynWTOa90x87Ql/pDMbsRa0F3aB+Ss0qZqTa0kjZCuXBD/FBI2Voxoxr600t3diVeJ8P7
	HCU1FopIKKWud2c7ymeqrBPiYXHSvNxA==
X-Received: by 2002:a05:620a:6504:b0:914:acfb:117d with SMTP id af79cd13be357-914b48b4d2dmr515779785a.7.1779457495688;
        Fri, 22 May 2026 06:44:55 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.78.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9d657fsm121874985a.27.2026.05.22.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:44:55 -0700 (PDT)
Message-ID: <6a105dd7.d5dfaa90.2fc47a.de75@mx.google.com>
Date: Fri, 22 May 2026 06:44:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6968319260854345846=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: hci_qca: Increase SSR delay for rampatch and NVM loading
In-Reply-To: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6968319260854345846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1099303

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.24 seconds
CheckAllWarning               PASS      31.73 seconds
CheckSparse                   PASS      28.54 seconds
BuildKernel32                 PASS      26.68 seconds
TestRunnerSetup               PASS      535.95 seconds
IncrementalBuild              PASS      24.16 seconds



https://github.com/bluez/bluetooth-next/pull/233

---
Regards,
Linux Bluetooth


--===============6968319260854345846==--

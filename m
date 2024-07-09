Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87B3612D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720493948; cv=none; b=QydL5pvicgP1STYYYHjXV4gJjDX0AMqnVtwshfn+ffsg08lhC+11/pPKy/8LC/puqxdHQLS0COyFt+frSnjGebwdeLAtSEQnEEEeABCQ9S9S+9PlcuLMBGU14GarUbXFD0fMhBUCE/STzlKBoq6nHIa4iF5GOiAK3O7xRtrkHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720493948; c=relaxed/simple;
	bh=N7bcx3oZhi+hv65SUuBOGlZLaJroBucX98N2Kfe4FPA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pjocYB2ho3hEzB9afbyIPo9nxVTijuc6jxJ+Ga2WG33t7EA0g6qcttuoH0aj77H5/sNvQtmWo3Pit/cQIz2gpm3Frn4vSC17yYjqtRo2tyjMtmYr2tltbG2MabMMAltJGGCbKynkmtrk8vliZKtDHQ0Rn8Ddk0yr8QL4cppu7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnWfOExP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnWfOExP"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4464284029dso44159971cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 19:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720493946; x=1721098746; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kAmCWH7wsTbyT12sdTlysKP0Bk6RxABEzvCh9BadJ1g=;
        b=PnWfOExPpvLsDryyhUm3NWSGyvdEuugoGeSsswLFQI04VJC58+13L4hIDQ6SMRgS7p
         4pZKR9dQVQUlQNHbBKpTvMtb4+ECyL/F/c7U7UlQrTqNb2P+kZaTLPKXlVQWe4foxOlN
         zg3EBO0PUad7qWYRvN7ExqktU3+skQDt4V/yFAnXjg0MOVh2MpZTjyGigb7kYlPiN8Gu
         isC/Io0mIXCkSTesrc4T9MDAVKT2vgb5VKdn8GK54X4V0laiQgIKeQK8QKVGzs486pmM
         nAX4iwELsSM0ODMli/XOeKx2Pj31l6tlUqyht+3iG+WewGx2uEzP9Hsl/AeMDd0bum8R
         /FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720493946; x=1721098746;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAmCWH7wsTbyT12sdTlysKP0Bk6RxABEzvCh9BadJ1g=;
        b=X+tbVwk2HEBgrxjaJ3dgDa7AiuwNtMlc0pbXmobbSYS69dxDsv6eWJl3ZjmEU9mTwq
         TvKgwQcXrZld0SLlhVHr5gaml2smQjbmVrN0/ko2IkQAVDR21MmY4y7R/CXRzV4KyXrw
         TjnqSEaHYOfk4UHrlQ5Ix4OLy2uNXsS3yv8F1eRYi5w7030BDn4aNMZPX6zCIs+DT6yX
         K+PJHEE6L7mrPo8+oLeAKTPPnvy+XgJq+HCqcJBulK0HICZeJo5lJjq5zJIJ93U/GysZ
         sDECh9lU1cI4MlInndxN4lgYFQtO8y8gXaCOe4TymXgCUh4cHm5Wp7SRJQzBIgxWnH+K
         fLnA==
X-Gm-Message-State: AOJu0Yy/+FYtSdxFgIZjoN9ZlgXNXKfxirUyadI32N4BoRUcrCdgy+TM
	gQVnVkDgSkFdRtECRMa3NE9CowMc24QlkWW44xxP6RtImfiTfINTtrIhLgXq
X-Google-Smtp-Source: AGHT+IHa4TO4XzwG48CSXVvSgMekEX8qKebck2yuXUC73WQpJ2j87WfxfXS93mtkalyBL7w6TX+5kg==
X-Received: by 2002:a05:622a:c3:b0:446:59db:9184 with SMTP id d75a77b69052e-447fc3ef822mr15280441cf.22.1720493945973;
        Mon, 08 Jul 2024 19:59:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.210.215.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26ba2sm5856651cf.4.2024.07.08.19.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 19:59:05 -0700 (PDT)
Message-ID: <668ca779.050a0220.af924.258c@mx.google.com>
Date: Mon, 08 Jul 2024 19:59:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0337264898056526279=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v2] Bluetooth: btrtl: Fixup SCO header
In-Reply-To: <20240709020326.4131686-1-hildawu@realtek.com>
References: <20240709020326.4131686-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0337264898056526279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869470

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.03 seconds
CheckAllWarning               PASS      32.06 seconds
CheckSparse                   PASS      37.96 seconds
CheckSmatch                   PASS      101.48 seconds
BuildKernel32                 PASS      28.32 seconds
TestRunnerSetup               PASS      519.65 seconds
TestRunner_l2cap-tester       PASS      21.89 seconds
TestRunner_iso-tester         PASS      32.82 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        PASS      115.28 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        FAIL      6.17 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PASS      27.55 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.108 seconds


---
Regards,
Linux Bluetooth


--===============0337264898056526279==--

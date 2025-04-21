Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E604C8E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244119; cv=none; b=ZGTP65E5ILjYf/sdm5vqZq1Ly4VqlvWyQEMDxQZ2LQ1PajS6uQXSB0rocGZCMYMd69dquk7FLLVhgW8WV3/eMgC88p8c7TqMI9VNy5o1kLArwSca0es+ZxLci+jXLhUuyOZA20Ikt9LpR13HlS2vQTyNgtrQW7W2W3Bb4zj7+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244119; c=relaxed/simple;
	bh=FK/1O/VOqew6nyycLBA9gs9SzXS3rNJ/7ZjRJQ0Wxq4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jdbnq7r2bbfA1xQ4ctgCUiZ6cl5Yq1ypvecAD7BG0+y258wOZ6+q0+Fcpz+dyLKDTXG4ZHvy1hQLlFrFW0y7u7ogpnnhF6O9x4oZ0lUkaCt+lCEsawazT8kK0ETipOHvE24Xn6D1mfRlUTXHT+96o5PMmU+WZ10U2RNrXF43jLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta4bL2Mf; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta4bL2Mf"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d060c62b61so2460566fac.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745244117; x=1745848917; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji58U9jszpJIv2oyms8DPz5clzU2LsvVVe5TD7QBLh8=;
        b=Ta4bL2Mfrp2Op6ypBm3rnrCRKg4ohUJQrZy8tJXGhQ1G1/a+qECmcFZWEyHdRT5iD9
         k0SKIZAdYA/OXLar/0N6YfXALPc/jqfdvXnns1sdk8Hw7RXK/VHASvG4edIqsQLSVfA0
         MWqtdVf7cDtdX3KQhIyCI0t07WlpJ1gPVd6Vre/TdouiYDANI7zZH+JsakeyBdE84ueq
         y2+l/fUqU+pAFePvw7Gw5gsct8h5IR638LMWN6YtSkVPP6g79/InecH/phm5MSwDgI9d
         8mkfAkX4LkV6DwW/5A3Zzjsdlh/zFClw4dvHJG/q/yHu4kAh0CVT2MXRK100xlm3IRLk
         IYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244117; x=1745848917;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ji58U9jszpJIv2oyms8DPz5clzU2LsvVVe5TD7QBLh8=;
        b=jQtjpsFCeLuuXDv+XhAKg9opX9+ZFGbrQ7BS0H/ZpeyW2wtPJBnECrWnOrpfq9hgpf
         /Er250V7HIJ22xO3J8IoxLxeQYTEpaF741FCoPQG4XRdGwMD4K6w7enBqlosOjkuuDjg
         Q6v7qDHzlv7cWlAxrcmwky6+VYXpe64Sm6hqjPJrmqJM1xfeWbFyWVbQKYgAgBXBwa/u
         GRsMDWX694UdHfHBuZnIYkUH13MRqryIaxpFA1VjaiGyfkYijjEP5wDdyeUFXgD7BLvj
         ZJiG2mVl0cXE2FqPtNxJRChHmNXcyN9W5PdqKt/2Y45sqAJmbXgOF5xaq2uOLgo8HZ5k
         CHuQ==
X-Gm-Message-State: AOJu0YxnQi+ZLEYVC04zxXskCdOPHBtFcZkkHRhk5gZR4o1QVKkBG/mh
	/swIzKZ39zvT8DASGSmsYMz9S5GU4QZz/fc6GSS/y0znbuaABVrIqZa8ew==
X-Gm-Gg: ASbGncvOwTU6ipbR1KRqyJ0s5lAoD2WcXU5O/zVfZqReEHiZPf+VVpvZ6ewXP8Qf35N
	VRS06oUocJ1mUekCHN/kHIaMclT+KKvPuCs7+1Vo6O5Xfs4oExpFLYBz7jfwBH1dbMeiuSzCTtq
	zVIWVjYhNL9Fi2DTlynJF2qWX0vIhGwlJMBru7E6+Fa0lFGCre0wzVNOQKL04FSCodZjJ6qhMgE
	ymzJfYPSp3U1oxZwjV/lGOkQ1dVXsNl8icPr/1HOwyJ7X1cKcsN7t3G1b6CBey5zals3f1EUJym
	Xc4hR8nJqrGsXPCg+QHXvWZ4gfUYw0o/K2WiRO2xfZQ+ng==
X-Google-Smtp-Source: AGHT+IE2MlbJBjjYZhWeuqkKOydSKaOQsyOIAkwKyM4UjzR/SlThnMAsfzU15ltnH37aZ9sGoMdwpA==
X-Received: by 2002:a05:6871:d40c:b0:2d5:9873:6ff9 with SMTP id 586e51a60fabf-2d59873708bmr1856262fac.28.1745244116729;
        Mon, 21 Apr 2025 07:01:56 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.189.86])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730047af85bsm1469040a34.19.2025.04.21.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:01:56 -0700 (PDT)
Message-ID: <68064fd4.9d0a0220.2b8775.fe6a@mx.google.com>
Date: Mon, 21 Apr 2025 07:01:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1427791456453580875=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: btusb: fix NULL pointer dereference in QCA devcoredump handling
In-Reply-To: <20250421130038.34998-2-en-wei.wu@canonical.com>
References: <20250421130038.34998-2-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1427791456453580875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955286

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      24.43 seconds
CheckAllWarning               PASS      26.77 seconds
CheckSparse                   PASS      30.50 seconds
BuildKernel32                 PASS      24.04 seconds
TestRunnerSetup               PASS      457.88 seconds
TestRunner_l2cap-tester       PASS      21.04 seconds
TestRunner_iso-tester         PASS      35.13 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      122.35 seconds
TestRunner_rfcomm-tester      PASS      7.82 seconds
TestRunner_sco-tester         PASS      12.60 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.56 seconds

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


--===============1427791456453580875==--

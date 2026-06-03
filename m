Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94117396D29
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471841; cv=none; b=H12ast/YlPMQ6I/E4Dg2d8qhG9tFgXbqSbKbAk9Wflnh3mYHpI0sYXSixJ3ybFfMn7YqV0JGuuiP6PQJQBpwOlvaI1cYCrKH6Kc/3vMYmbGYJfiXNdkS0bjKyojrEYykcfXh487MIEIwnUCR9aS9LDeCB/aYupLfMMQznJN7s/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471841; c=relaxed/simple;
	bh=gf312bP/oial+NRyVyDW4B5IFUG0Upn/5Eg7AgsS8IY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UfWUZsXbiZ8T8cKogyjOLVKMuwr7wwcl/Xovm9BQszed5rYZ3kdfqTRBRr0TK8lgnxfXir8gkCgcI8babJWP/k/MdZT06ZpekPLo0uAJH9h6nnpR6I0bvDmY6ZZQVEBufa6ee3HZZHesAs68+jjsL0hBVp7I+MbhEKLX3FhjUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3F630w9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3F630w9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c2a68d01so21036805ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780471839; x=1781076639; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RYoUbvalHts+Hp+JIERtOZD/QNFvZ9174gO6qdNj2T0=;
        b=p3F630w9wb6aXyLyKhWbOaPTLv1xhp692iYZQZxg0XBGX/J/03mFR9rZLJoWNClN3x
         SYwc6iswH8vjU8Y8fOQgrk9dUiV0Gdi2SzOJAWYFaAsZ5rdvQ5Dt+MMDZqZS1bPR2e2j
         0Fs10mQDAHEsgXokalLkn5ymoyDWKqSnnbnh1a72vfr6JQ0eMg5vRtNsiV9Xu6+/net1
         KQUCx1XoJlpMPdnqCnLUi10aFiI/pxkdKw67Qoa9mTwcYlfweE9yPodVL5nJzGR2vS6w
         CXHTCLbg3+Q4mGj+kPH6z40vdxJVonHt5Tl52S1A8dug4vp0PZtEQhg3nbzMdHK+tAXx
         51vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780471839; x=1781076639;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYoUbvalHts+Hp+JIERtOZD/QNFvZ9174gO6qdNj2T0=;
        b=dXHWKsPWjnPP02ut9SMH0VQgEhahTB6ZKLey3yN8JUmeklGXnUJmMBx7Th3vD7/6q3
         fj6EY30/gOWrwQq7Ta4xaukccFLSO4vqRGtoJA1yhRKV+Lwlt8scstgEAhyfP41JgwZD
         Ewq5hIkZFXRsMn/SAuOL030Q6nGjPcVYJkpU59F9+Ou4AtJX6lmRPuJWGmhJRtQTBH1A
         /lNQT8XLDfpiRWPcKwYUGfle5D2Kj03YvS1l6sZ69jzd8FGFtEsPK7p3vjMYNyTnCfbI
         t9J8sscSI9pfMJlG3aeWUxWR7Yb38Ot0NL37H+TQnIYNkhLBgMTq2+MiRmm3ZcGKumNR
         2NyQ==
X-Gm-Message-State: AOJu0YyWp2TU5Mwqw9D1/K34PSrMg8Vb0JI+zaurhTUKpAXjucMvRTvp
	nspDcEUZeIMq6FnxIDq6fiDPOEBcb2WuBuingRVG/ODabtRQVJ0bRF+KW5fTWA==
X-Gm-Gg: Acq92OEA2EdCX5n3lIQ5kC1vXxONDN4TDuez31r2wIUtzjK0jNPICHjOnWV+5I2o83I
	fe6M+dUzOazP5g7xZ8C0MOUocuefSiM4jgch5iBC148bPDfLhJfQS3G+q15KijYWd+uGnn/M+aZ
	uIxIGR8J61XGpExiTFPg0FyS9sr69nXX0J0un+0pOPiLUuAr7J33SMLI8OtJDLqyKVsa+Gf0AAI
	jmHSJ6rDP5gLfjq2uf5CtGbzmWUhKZmJvxroztr/2HfPuUHYtsW+oxkjF/C/MQXjkl5MUIHJo+s
	zEjRomX34poJqnakTxKyDEb1OZlAyedo5dDlnw7DZ4HQkI0Qt1YmbYqGUMvjpx0e0i1lLmK8cIl
	w/EHMDjcbBAumxIoUUYCv1LpMFV7sv7xQJdJ2ant9cWkt/8wqgGIy0nCVYrHACpsRzgyU3gr4nW
	7cfZP7KAuDiZcKytzHefuD0c4p8ubKS0ZapVrnuLY=
X-Received: by 2002:a17:903:9ce:b0:2c0:bcff:e18c with SMTP id d9443c01a7336-2c1646ddce7mr23224625ad.37.1780471838582;
        Wed, 03 Jun 2026 00:30:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.183.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8792bsm15206495ad.23.2026.06.03.00.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:30:38 -0700 (PDT)
Message-ID: <6a1fd81e.451d195f.81c4c.159b@mx.google.com>
Date: Wed, 03 Jun 2026 00:30:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7800377708220202982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cxs1494089474@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add support for TP-Link TL-UB250
In-Reply-To: <20260603035818.926654-1-cxs1494089474@gmail.com>
References: <20260603035818.926654-1-cxs1494089474@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7800377708220202982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105002

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.83 seconds
CheckAllWarning               PASS      27.63 seconds
CheckSparse                   PASS      26.29 seconds
BuildKernel32                 PASS      24.07 seconds
TestRunnerSetup               PASS      530.02 seconds
IncrementalBuild              PASS      23.67 seconds



https://github.com/bluez/bluetooth-next/pull/279

---
Regards,
Linux Bluetooth


--===============7800377708220202982==--

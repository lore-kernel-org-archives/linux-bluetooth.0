Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C431E533
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239682; cv=none; b=kkDjFdM7uw77nbPCj5rFuiLnBo93HhkRqvpDzNXAtgLKPs66pSz+eEuUwCuX7duexDYkUTSibVS1PmW85NF8gfK+mREWe2q5NUUOYi4i/uhfcfCF/zesSneYnzNsICs1H9XDAoU2ljgouJub2YgOWdhyEAacX0E2B+/+VyLGYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239682; c=relaxed/simple;
	bh=CKQgYrEe1SSf9GSh55qF+2vRXRU4UxtpVipRCG5MUVg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WqfYsJIboMvi9fh89gXXWEmz+7hC2KsbI95F4bn1Js66rZLDvL8bKLUo83JMODEpSYJtIfln1DWgoVTrh5CUf8aUyYWlpO6OO/hE+0ESAMbGy9m1tV5zqmwx6KjtDL4DCBfjrRQ0hb9LdT58aYurl7ts6zAwz1M/HaJhpANCiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+vQT+sO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+vQT+sO"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-706680d3a25so1321110b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719239680; x=1719844480; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vPUpepf8j2OC/+pmxMNa4tBR/tOr2gX+x0dEkF32UMU=;
        b=S+vQT+sOKZ44bJzJeGcY6VyZachLybFivoqdk60s3MsPckpqN6RWhAlLUDryPvGhsm
         Tz7XPHN5Wv/bUVsZQCNC+xguK2fk+ysrt7N6pmDb3a4lBRvbJcnPYk1f91dbt36Yssx1
         vGUW+Q9Fy9brHSe6cBidwK+1q7Phy2h98Am5CvcuAUXb0vKsiei8AGPl8s0FBkHw3u+W
         ccvb2INN5T42mWhZYK5goLjCsznJBwPiokOajpzW2gC7zGR7mZxFg/iGuqffUZNy/T1X
         QXSgY3yRCiVkGysVISPfQxtJOH7Ya6Nyl5BaJQb5/ixrS1HR5fLyN719WhE1m710DOFc
         6M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719239680; x=1719844480;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPUpepf8j2OC/+pmxMNa4tBR/tOr2gX+x0dEkF32UMU=;
        b=e14RV1SgsAFMOA4MN3G/rApimCn62SMV/orYETjGMYuksSEZkbxgSWiCWi9jCn7svw
         WhTB+7oefBIBe65AKu9UryO1g8OjABAZDyUlzSb13YGOwTPhTeAv5Ic3BtkZM7vvk/Gy
         noJWHZMsrEUBb6V4drhNinWL9Os76Y+rgXgZaf+JKdY4DeDga3073iQr4kRPX3WtCr95
         w0ly7R0NpqbBMEs5V4uS7hLeo4K8gnNtIo0oDftID1T+4ZXpfJ9DRpLvBe1gayBeRnAv
         b6gFHcrLtbGlETOqjmKR/6va3F/AKXY22GAE+3E9IfI2+ExwcPbsAkvJOBDAeIdgP6Ot
         jszQ==
X-Gm-Message-State: AOJu0YzcJtanMBMEo9lbcjlKDcrCq7K6pWXD/xSI+FDjU+ILljGVyTSt
	VH6hw56RgeDi1QdxfeJnJtev6wVwMj2XfPBlFXzWI8fK1PTKSle9azpuSQ==
X-Google-Smtp-Source: AGHT+IHhsP7csFdO0HUOu5kUp6gUkOPKzf+Ky3w4A7y8v+8dJI7xMDV01jiHCNk4WPkrxBXzHjYWhQ==
X-Received: by 2002:a62:fb12:0:b0:705:a450:a9a2 with SMTP id d2e1a72fcca58-70670eb6d6cmr4708009b3a.13.1719239679823;
        Mon, 24 Jun 2024 07:34:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.70.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651085a5bsm6265424b3a.44.2024.06.24.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:34:39 -0700 (PDT)
Message-ID: <667983ff.050a0220.5ea4b.fb53@mx.google.com>
Date: Mon, 24 Jun 2024 07:34:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8783467965767289388=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix deadlock
In-Reply-To: <20240624134637.3790278-1-luiz.dentz@gmail.com>
References: <20240624134637.3790278-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8783467965767289388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=864924

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      30.23 seconds
CheckAllWarning               PASS      32.83 seconds
CheckSparse                   PASS      39.01 seconds
CheckSmatch                   PASS      104.85 seconds
BuildKernel32                 PASS      29.39 seconds
TestRunnerSetup               PASS      529.98 seconds
TestRunner_l2cap-tester       PASS      20.66 seconds
TestRunner_iso-tester         PASS      43.64 seconds
TestRunner_bnep-tester        PASS      5.10 seconds
TestRunner_mgmt-tester        PASS      114.35 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      15.29 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.05 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PASS      28.12 seconds



---
Regards,
Linux Bluetooth


--===============8783467965767289388==--

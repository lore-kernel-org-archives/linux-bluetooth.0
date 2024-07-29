Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E138B
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271079; cv=none; b=Qq8YqnVFQRXfk9vg2pW5idsIVRVDXQzPKdHm3YsPiMObk3h+nl7B12YQKKGAPHhrpHg9Y/MDO2uBwwPYa9yFZ1352San4GbDfPe2EppwivfPCGeQuiHwLjj8oBaVJVJ/1iCl3JpNYZWWWatlDT+jcJy3fAvCmCbgjy49OboiYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271079; c=relaxed/simple;
	bh=0JRGotoT8LT0WV6n+Zz4TmXbHNZDxMFRC/9vTSnRzcM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T6l126aRTieIqDPiY4SXrZsq1T1vbEGRZ5gjtzVZuotf3qYwu0hTVRNBdhvuEg6rF7y94g2PCPeEgFV43FL3IHgRu0PPStEwKaJW5aoBC8qdvvqH6ojYhhmcREWsbBmGTtfUzTaXnvYqFJw0Mv8w+ljiDYT5v2B4hD67xG3jaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3zyJV/H; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3zyJV/H"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fedc06c03so17928941cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722271076; x=1722875876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eicQCEQF8g97Oa5I7SKf2O0HaeVCviP2MJ9rMYlyOuI=;
        b=Z3zyJV/Hkmpht0bA/Otm/EhLUL5Cw7tfbYqQWoiIlgvuxQdQxBwaI4a9LU2rs5UrJN
         nI//nFz0SNtzXeH4BwR8nR+WO8KoSt0QCVOfsVA3a7dmUA2ayX6lpojCK4OKsVnyIVtg
         Y7qeWZOkSRoyMbNgFOcPEaBS+kIQ9rPeOzrZB2t210c27+4aiR2fZQfXpANVpFvloZLr
         mj+TCtuETP8W5bEWYXdkO4xncWuR3eRu/psZLbetb6LTpkcXcfYPqL6jQlt2KuqSQbU9
         To0tyEhEnxcFETZVyMa9yY7Nx+4v+N2fhULYkfBmmCfvrmjbu/bm5FjPtCL2Ip2eGZqI
         sVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271076; x=1722875876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eicQCEQF8g97Oa5I7SKf2O0HaeVCviP2MJ9rMYlyOuI=;
        b=nqi0cKIhv6+LIsEqqzzoSYRDYnmgQZLs9T8MtOh7025+6w0Ei2jqdwcohxg1hifcw8
         HyAi2i/nVGt8VEJmQWVp7sy9H8z+W+1/xadnpeWD7X7DL/rC5PhtaRsbWTWDZ34jFhRH
         W+N3CvnL8FI8OPlORORNDsGdCl/X0PIpAIdi2IZmyPw+ehOwoOm6XhEkqpYOPc8pxYeh
         Hg6n1dP3H4OHwXXB02WjiFbw9OrrQSLiS3LKMouP/C7z+3f39RGJob1ce487SeXLPFCA
         CKvsl/fqSvt+fuMbzlfaAQUzmumaD/o0eKFidv6ZfRV+iqmf+Vv8NwZWGwwgJJ18fGOO
         qsQg==
X-Gm-Message-State: AOJu0YyCCaHkdEYVYv/ETeB/xacHFhdN7+iYFtDyJ7zeVf8JdSW9fjlM
	kTGVhY4W3yFF+WCeLvQLXUJ/Ilc3X6ML+Bd86pEGwndYCPoJpklfzcYKUQ==
X-Google-Smtp-Source: AGHT+IFukKXLWoQH5qrXuIXiin2A/Q+X2QEx0BfIV2SyJs34sZb0/ugSlA5HUcoCDFqmCPUz9XxmMg==
X-Received: by 2002:a05:622a:112:b0:44f:e72a:1bb1 with SMTP id d75a77b69052e-45004dc0f68mr106322211cf.29.1722271076343;
        Mon, 29 Jul 2024 09:37:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe812392bsm43117031cf.10.2024.07.29.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:37:56 -0700 (PDT)
Message-ID: <66a7c564.c80a0220.3ba761.ca6e@mx.google.com>
Date: Mon, 29 Jul 2024 09:37:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2424110239083912044=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, anton@khirnov.net
Subject: RE: Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor
In-Reply-To: <20240729155546.20932-1-anton@khirnov.net>
References: <20240729155546.20932-1-anton@khirnov.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2424110239083912044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874636

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.39 seconds
CheckAllWarning               PASS      31.89 seconds
CheckSparse                   PASS      37.55 seconds
CheckSmatch                   PASS      101.62 seconds
BuildKernel32                 PASS      28.38 seconds
TestRunnerSetup               PASS      521.34 seconds
TestRunner_l2cap-tester       PASS      19.81 seconds
TestRunner_iso-tester         FAIL      37.01 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      115.55 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.84 seconds
TestRunner_mesh-tester        PASS      7.07 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      27.52 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.180 seconds


---
Regards,
Linux Bluetooth


--===============2424110239083912044==--

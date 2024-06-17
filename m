Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82061946C5
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616947; cv=none; b=aIftN72Zgb2I/AfBd+TNvygJ3oxWthescbMR8IJ8zWGVLP0obr2u53Ro5W0hPXlRh/6+HLx5wuYjmCKyh9+ulVz8gh7gek+b6Can1cdPD3AxvdHUqoU9acduoE7fBIkk6Miudn2oyBV9c2ReuqIee9cQ7GFruEuZWLfL4RgfUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616947; c=relaxed/simple;
	bh=iO4nNkRKoznN5w/HpXTCmIwPSypW4uVXsWeYenMbARk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lo0OPZCzFpy8Qi68UM5/2YwvEvd/FhKcTm+uJOABeUmi181wDobWMvPTpOcgcbbkkdB9+xqJdkLE7mC0iUV97Ejfr4J1eaqcJ1JbZTHLKhFy08oib58jX0cmMFnhtrI5z3nx+nFpORrRtYp+DFxMSBqxDbfD86Lz0lgbj3FcJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv5FOaYO; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv5FOaYO"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b2c6291038so11821936d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718616944; x=1719221744; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J9n17kj5n9yKQjY8oPIXchoxLxbYN8As1yDLUfPRetY=;
        b=Gv5FOaYOzJIxZFHcHClknAA0NiOdcUSmwPunHxJiEq29qAtWvG2OCQe6/El7YlJzzr
         TTk9h2waTVx6esbpVbxzOGnPm7KX0MohA74grHdymqoKnIwf3NDNhM2ay9BYsjB03PYg
         fYrnx8ByJ6e34sNFeB+1vogekhUdhw6ch9Jr1HKBgLWSxbMd5qnH0oWiK6GtdiBun/X7
         Lw5OoHvLFSbSMqQdiLhEntWz5PutNgdA7MBaHKeO3VhlttTEFd3opfiCoaTWKDKGg7JV
         u+Rm7o9k/eoKo1SOcJfgu02YtaVOnZ8QMeAV97/X3Al5YLxTy9Yzx86LnLbGfr2s3SLH
         PuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616944; x=1719221744;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9n17kj5n9yKQjY8oPIXchoxLxbYN8As1yDLUfPRetY=;
        b=LrqE3qtU59xKoqkAv2xu/Kz5+MYUj40a4fT2fM83IOGMsStlNLNKPD8tOhLrEAS3SH
         55FWtZN1KTg/NISs/wqET8uO/LP5iKtZVp2Crx2GveiDVrrZWGXuBAB8fL3A6UORQuUK
         9hn/qH4CZlcMvZzJnHwcwCANYY5f3hTpYaO5rCOhRzCP8iqRsf56lDWfyMfoDrz30FdI
         JpPoE3F+nBCMb8dhekViFEphJa7HtyIG9dg/EwfsGcCXoNw5RAcswUb5v0GLPElltsvr
         iukwWLsoGD1rPss3Th/eogQQSb5IaumET414zypXVrCVIhzg1YzaQzXnq7RyrnL8iypj
         JWZg==
X-Gm-Message-State: AOJu0YzoHvBvu+fIYRZVYgb7J9AsuyO/4ZFTMFiJNRhOMOKG/md8dOEU
	VdYsBObhe08gz/RmYqVjHYJY7suD73xxLXGaYSMW7PfjSN1zSMATVYtPxQ==
X-Google-Smtp-Source: AGHT+IF/yCB3+T6zQ+Lo1liADLwECnU4+ujWmiWCPeROI+lcu2d9Z+IZODK8FdWX/k3o9SJ68qieUQ==
X-Received: by 2002:a05:6214:e47:b0:6b0:8275:1bf3 with SMTP id 6a1803df08f44-6b2a33a9cd3mr247931696d6.6.1718616944493;
        Mon, 17 Jun 2024 02:35:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee01d9sm53066736d6.111.2024.06.17.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:35:44 -0700 (PDT)
Message-ID: <66700370.050a0220.1dc886.fd6c@mx.google.com>
Date: Mon, 17 Jun 2024 02:35:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5858254525554219853=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v2] Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables
In-Reply-To: <20240617090518.3237642-1-hildawu@realtek.com>
References: <20240617090518.3237642-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5858254525554219853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862524

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.09 seconds
CheckAllWarning               PASS      34.06 seconds
CheckSparse                   PASS      38.41 seconds
CheckSmatch                   PASS      104.50 seconds
BuildKernel32                 PASS      29.45 seconds
TestRunnerSetup               PASS      533.21 seconds
TestRunner_l2cap-tester       PASS      18.54 seconds
TestRunner_iso-tester         FAIL      36.97 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      109.15 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      15.16 seconds
TestRunner_ioctl-tester       PASS      7.95 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.14 seconds
IncrementalBuild              PASS      28.27 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.231 seconds


---
Regards,
Linux Bluetooth


--===============5858254525554219853==--

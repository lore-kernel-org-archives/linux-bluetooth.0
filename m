Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A875D91B
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199225; cv=none; b=He+jq2bR0YL5ZidSfa7FE7bEFB6KuqSMIUGQFJorSxkBV6TrVbSfli4+XmPTwWIgCQ62Kt8DGPqA8f7xbS9SgIhq6gvryP3Cg6ycsat/C2HJOnTJquFH4ydoSb/eh5tApbPw+bFTBO+APqUX9iBPnqvCKnZzKbFaObmeyqlhtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199225; c=relaxed/simple;
	bh=atF7Yzid6BWop89/Zxc+TPhf48cWY50fQBNJerc+C1U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M0Nyy4tTqn288pMvznxLPoU1x/gI4Qwz2q45odjho+m/a4e5yAQl2HLqvsa3mLjR9WDZVthGQyddRQRxSibm2HyIHCVKzADStFRqer82pkVIeoktd8MCLbNbcSu0G51+q601wXOmopmQi8AQvMfO5Ug3iKw7bbv/N/iISW7+1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPTGkTGS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPTGkTGS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93edfa76dso7013085ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709199223; x=1709804023; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w6oLGGAqlSorq+09qp4BqoCYKuMulCfx3dZOvD3GgW4=;
        b=hPTGkTGShjazTXUsM7xTwsSnOxEIOYuhyppgcuiL5+naKp2DB9jIlr5dChVWODX/oc
         KyqzZB7/INCwcgXLHyoGcH6KK+/4dxAxHGIt/mZXDA9fsCw/yP3GSx5Y3KTre1slT4mX
         qRMeoz76WqHOhHzBeF1MFLN/gC90UfOAqg10mJtm4prswX0bcJgAC6wTitZqagKj3yFD
         QlFZaYuXCVpA90hbcMLZz2XcOMucO7cLY5EF5wv0eVBKyPvohFXXfIPlEx3iHkseXetP
         f7N6EQtZ8P2YWMYC0oYv4JbTzqMazXD60avI8o4uumAC3pWO0NFTmQVR011wx8fQKOXz
         wugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199223; x=1709804023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6oLGGAqlSorq+09qp4BqoCYKuMulCfx3dZOvD3GgW4=;
        b=BuwuCaLk7utQ8jijMmtKqpiAqjfJ680xiaFsbwfLuXef3T0m6CXdkDgZxsrbvJvhki
         +yTF6f5XZMsUFU3a2KoZXS3yjVQ/u9xW5DivKgPk1yoVEd7ArmYsx2R/wayZzW0yG0FS
         FJ/+wjyu3q9wX4jSLG30cfbCCTwCDq58NdfYQQJgZESwlCBVIlZv6BR6Gqb2DCDgCWYu
         7Ya3b34defqOqPUKcsSPWTWuC7yY5ovEdG8NinfNFanSuRaUefyAMoK7gEcdqxlqd182
         tKZ0jiwpKTtsZji8Rpvrfm9q1mghQ/ccz7Fv/KtKaWwBq6bTdKEUgkrJvfl8pm9H6RaS
         VBrA==
X-Gm-Message-State: AOJu0YwJELDuUKXquzJdMVvtid6jXZZtujagfPbzT8+z4d/CAM0iFlaB
	GLm8InsXM4gR1jIBDueMWIpOjFUzz/EFcrzlhTQ9zUImEvGKESP37QMIANfr
X-Google-Smtp-Source: AGHT+IFt+v9CElhWEGxJRNdMj82pN8WEPZU/ncZqwfE9TNw0ZrWRN+1aNAicF3+pyNCjo96Mwr/VeQ==
X-Received: by 2002:a17:903:2405:b0:1dc:71b6:5727 with SMTP id e5-20020a170903240500b001dc71b65727mr1662633plo.50.1709199223300;
        Thu, 29 Feb 2024 01:33:43 -0800 (PST)
Received: from [172.17.0.2] ([13.83.123.115])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b001dc6f7e794dsm990300plh.16.2024.02.29.01.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:33:43 -0800 (PST)
Message-ID: <65e04f77.170a0220.8455e.2912@mx.google.com>
Date: Thu, 29 Feb 2024 01:33:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0558368282656761322=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: mgmt: Fix wrong param be used
In-Reply-To: <20240229084059.895730-1-clancy_shang@163.com>
References: <20240229084059.895730-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0558368282656761322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831013

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      28.00 seconds
CheckAllWarning               PASS      30.85 seconds
CheckSparse                   PASS      36.39 seconds
CheckSmatch                   PASS      99.08 seconds
BuildKernel32                 PASS      27.03 seconds
TestRunnerSetup               PASS      502.24 seconds
TestRunner_l2cap-tester       PASS      19.46 seconds
TestRunner_iso-tester         PASS      32.42 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      109.42 seconds
TestRunner_rfcomm-tester      PASS      8.42 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.88 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PASS      26.91 seconds



---
Regards,
Linux Bluetooth


--===============0558368282656761322==--

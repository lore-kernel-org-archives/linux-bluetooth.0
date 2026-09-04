Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B357414A2A
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500435; cv=none; b=bfh6817XYPjCKW1hYyvhBJfSItCXAJr4o8vw3egx1Jc5z7kho+Wx17WFBtACu0ROX/02ygDgOm29iWEngEpEeMBQDAq9GsoGZ8KAciokg/FQVj2l89b8r3iV706wpe3zyy9Wvb18hUvlgLwbQ2bycpH1Ctfd3Vofcbz9lBiPaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500435; c=relaxed/simple;
	bh=t22vXPtkntCAkI4a+o/XB9K3LXaBEzLcbA0hrYdHQfg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CnVCpYlgN8zf9pc27ZVy3W1u7O5QxI15hz2EeqRn+NWbkoxgs6RojfMAc7GQSvbtsI/OAN+U5O3LCSpnUvTud0GaTCRxj7oDZRiyZHgRQCMtEf4I5Vmy0Znf2DYbIo1BVV1uF7A0FrCy7ox8BDTa3Ic7Gu76H5meFgREGkJ0VQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUAhjU6a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUAhjU6a"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso567837b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 22:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788500434; x=1789105234; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ee0eYovDBbgth/+VRhtRsbYHp/7PaxH7C1sGGKwzoy4=;
        b=XUAhjU6aNoA5lqG8NLxnNM4ini28grGVuBC5y067mP18bdfxAcE3LLD5H0yC0Sl/G1
         Qtf8G8V4cj6na2Kb2aJ0zt4hdFOpFEMYt+0hLF956U45RDTU+2EwXJXYoPhg8TtDN9b7
         Trh1OYWMyeBNfcVzOUib9v/dWME4c2efujKrd8Cb75BCbeCv/46ogQn0A+tFQs8goG7x
         FwLt9FYI3hT7NaU/llDx6Lb6kU/mtf59z0BetrAUvZB6mtxcN/gnz2Q7Eizv5VkWUQOU
         gnZdmODPNBE4hu9TB/lrpP49q+FVzjnKF0+B8Riax/a63EAhkazTff5mQhJ7OLi2XNIG
         h5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788500434; x=1789105234;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ee0eYovDBbgth/+VRhtRsbYHp/7PaxH7C1sGGKwzoy4=;
        b=RUZADAP+99mO3VdnMrxaSkvCo7GtQrTtayw63axFDY38K4+TIH6bnp1plrid6MjbED
         2mKv5Lydb1fUIYJfa8a5vc2IAHpErk3G0oaewBKqCPdorYa5zEdYtJu/OipQ2k1jiz4f
         M9EL6pV5vuFD7tnu8l1X10ovN6CuYMfkKrR4Q9MfvLcjrFcJdoQ1NVs5AUHQZ+QQR1yu
         QqfOxjCP8ywwU63OV3dBN+Np6O7drDeV3/fq8vIbFUvedTolurD0IhfZ+U6WUPnv4ZOr
         o4UgHljG0uwJUCnNNSFgPm5EuSN3qfUQDCXVJARibWSS9b6C4WOf4JRVN7V66vcuU1Qo
         PRlg==
X-Gm-Message-State: AFuF++nElWQrzHxw2udhxEQGBuT2Edkbf1Z2yGPR7tdFkg6HR1r3Bm8z
	GAYjyfpLn/EPffhhJ8CGMWroKJTwA3+sNGCmfd2dRIkfYGoblPVbSjeP78IsMg==
X-Gm-Gg: AYBFou3AD0YLs37Q5ZVqn2gJ0c6KM7SI6DJbV/4bH/Z1Mc4p1r+tG7VfENgCrmQqPlx
	fTWtQ94qVWFcWmtvYAnGIDk/3PVlkVV494QHLrlbNP8anbcBPh7bFkeffFtAPm33V309voNVzCb
	iCflduSZdxkrSZ92bEUwB1yGR3qoe3v2eg31t6kySETY+ikzuLHrW7wzNdanN4GQwv7ny8fAZ4A
	Zd21w4sGou9IKBfhfE2cnOFx5POPPUtsUt37zyJ3KYyAY2bvKBdgmnV4EahpjPXe0Xucc3LX98h
	2ppfrkx4nH+3AHektE+mzBkc8LdUbNcW/QXWC+MEBiDbELe7YeI0n5bj1jzAAi49IEXRnHTzWia
	5MNkneOVTKavnuucYMP9qztPlc9dhXzZj9ifL6RS2GAuzBALlgVl9vYXX8tDKmc1W0seCblbwhf
	9RmA/LYbYyVlsjvyIB7Le+Gmpq/pji/tNnF6TKd5TbP6qAt4iOjXpY0H5q/qRm0iPoLUc=
X-Received: by 2002:a05:6a20:2448:b0:3d0:8abe:9e08 with SMTP id adf61e73a8af0-3da39b57e49mr5419741637.3.1788500433625;
        Thu, 03 Sep 2026 22:40:33 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.166.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm4064708eec.1.2026.09.03.22.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 22:40:33 -0700 (PDT)
Message-ID: <6a9a59d1.0137d0df.1c8f8f.ab77@mx.google.com>
Date: Thu, 03 Sep 2026 22:40:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0182897520974506254=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: defer security confirmation to krfcommd
In-Reply-To: <20260904012028.77590-1-mikhail.v.gavrilov@gmail.com>
References: <20260904012028.77590-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0182897520974506254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157499

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      28.08 seconds
CheckAllWarning               PASS      30.97 seconds
CheckSparse                   PASS      29.34 seconds
BuildKernel32                 PASS      27.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      511.60 seconds
TestRunner_rfcomm-tester      PASS      25.90 seconds
IncrementalBuild              PASS      26.11 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/702

---
Regards,
Linux Bluetooth


--===============0182897520974506254==--

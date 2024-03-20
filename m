Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2115E9C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914231; cv=none; b=QQfLPDwn+6/r05/Vt0AqeGPhBfodtanFqDOD+baNn8RUdHUDgDP4U6OtR4sTgcrw+qdbjOzEvDSOQjfbJSSsc4CPn3UhmGpBWU7E1uVeJcTvGsFuoZXvuD5UppTCIFhahUjG14M3tGcdnd+UiSNtBDFSyjFTkqmeBKkc5BsKLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914231; c=relaxed/simple;
	bh=xD5xU919UqsyTrNH5KWIMVwcGTZJ/pn608WNXGqvWjQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LFylRlcnVo3IqNeDaz/nhO4e7y/Eg2GjYwmITZqjU0BxUs6MvP7MvPL2IV/RfsIn5pX1vvoDs9znldLeLME+urnTydKI0ZDNUzuQmUurgD6led/AhzdAm9ZDmq0bvueIdXUP8/IBaojfY2oTCL3avwD18dqdSV9ohTKu2vHUoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzr4gYC7; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzr4gYC7"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b519e438so4329579a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710914229; x=1711519029; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fbdzYJvJdQ6jeoSXy6qTlbURmy3jMqT4ocrNMgofPPA=;
        b=kzr4gYC7hbYujv4oGDPkWixM38+G1mm9zv9WAUdeRHv2P1Ph6/t8M/AMjCr9+RiafN
         drybC0s1TO1z5IP8nHz6rLC33IUwKATnrZORghpX9hvtlKfoZPn+5XWuBHxp2hVjvEdm
         p2WKYNWrmv4d1Hcs2GPKxdSEj43RNKNq2Ii4v8nx6h9HnhO3PvpyxfkDxvv0P7NcMn9w
         hjnrj/0C/Bb5TnfIghwh4g9z1HZ+0ZQ350dQrj6NXVl97WE0b63gQ0Aks1MOtChWpPAD
         6s3lOiEWUrFH2TJo+CsZxUJix6p5nmTkRZQ976xP0VoVZSirdQUg5PcFWR9/vpQMJFmD
         66ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710914229; x=1711519029;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbdzYJvJdQ6jeoSXy6qTlbURmy3jMqT4ocrNMgofPPA=;
        b=uUfYHJ1BB5p64ypXxd5NuKKajCrEdid0k9IKx+3L/9KTneRiex4LyqGDtZhcKmooWV
         461mFmekTV7ogQHmnNjiFvPj30lVkDueWlpugZs3qOoIutIbScKjLZzRZ5haZCJXvAP0
         H4qzeN8Lq6GN0iBFDWtvT0/mUBONcDxeWElTa5M+kdmNuceDlhaqMU8JMN1Ocky/jTbs
         Ap2A0eU0ulHyJs2m2HhobwfbUhNE7g1AziBd76d8FJBRgP7TwlLAlWTqgMzM/EmI0pJD
         kvZ1taZ9tsg+n2yXNBeiIx2I07AuIBVeNix+Ryq1fG2GXSHAbqTc3UR0hnaR/Hgj7IrZ
         n8jA==
X-Gm-Message-State: AOJu0Yxeu4cNpvrJLWFsI6HHu74uNDF/3nK8H/V3UmhytsPl9/UR4rLL
	O7I/KDWVCMx8LUz4v2KPYtzIO7VntiJo337pjd6MsT3O+XD4SPaT4ZZc0xQ/
X-Google-Smtp-Source: AGHT+IH7pSc6gpqAKM1otNGbTGRvQecM5sHzLQx0fBzTmrKYpgghWOnIH5q0dG+swON6Rx3DTOQQRw==
X-Received: by 2002:a05:6a20:5483:b0:1a3:6c9e:1e31 with SMTP id i3-20020a056a20548300b001a36c9e1e31mr6076483pzk.19.1710914229234;
        Tue, 19 Mar 2024 22:57:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.29.194])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a348b00b0029baef194f7sm696323pjb.38.2024.03.19.22.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 22:57:09 -0700 (PDT)
Message-ID: <65fa7ab5.170a0220.27747.1dd7@mx.google.com>
Date: Tue, 19 Mar 2024 22:57:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2355707660064791843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v3] Bluetooth: qca: Fix crash when use tool btattach for QCA_ROME
In-Reply-To: <1710912504-25416-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710912504-25416-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2355707660064791843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836616

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      28.36 seconds
CheckAllWarning               PASS      31.58 seconds
CheckSparse                   PASS      36.95 seconds
CheckSmatch                   PASS      100.70 seconds
BuildKernel32                 PASS      28.57 seconds
TestRunnerSetup               PASS      527.24 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      32.89 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      117.13 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      27.03 seconds



---
Regards,
Linux Bluetooth


--===============2355707660064791843==--

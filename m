Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A891885A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124105; cv=none; b=Aa4KnmM6vF2faTNjxhVXVeixR7qIyJi1DktSqdTQ2/7E35hSbipcX+mLTxMIyQrRf6GXLw5hHd9TF5ycPcvzLBmt0eqFreJ8rAiTTqUwxNepUTaWHw6bnJmflfo9Ipfy0gWv0JCd2g/GXGiLsqxz3YsOnW6v/SrG+RUQg6I7Rfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124105; c=relaxed/simple;
	bh=X2pUxaTWbKe0RTQOb+L03cwC9yaK+0OkQyQ//2x5Jjg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U3EFtxxrQARYG5UkwhdGtT9icdtfSX2EldlVQ5puxmY0Xf/msrnFOiM2wHzNhTuIcsqFi3E4mJ/KPJrHcQur5pS63MmwLM3ApUIlRjinABaHt+U4/bbCUApPyzGl+y3lsvgH8/I/fLvBJAxq3TdZB59ivOiUlGAGIrXMOFTyFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4aOWHLx; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4aOWHLx"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5eb5be68c7dso2335460eaf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730124102; x=1730728902; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aImNohBUk2NW3GRq9ZLM5JEjXx1t4RkFnKqYF3Eer7U=;
        b=D4aOWHLxcAMqlQORpQXbqgmde7QQ7FBnW5tZ2LCFIaBaYDBT9B6n1D3vuIKiAl4ZZ2
         djpIjn6Vhnd43fPh1T3cQbaANiKy8gi1ibL2icd+E0OzDDXNtyyxjZeji9wUcgZ7IVJG
         9eE8/8QvCn9Fn/xGVEyJ1F762uLD+Cpinrcks9A7n0CQrCxS6mo92RUL029eHFYfd0yV
         gzWQFeM/4jcPewO9syX6cSjq66xJ/P/uf8YCmHNsxi0TVX3BkAK6AB5c7n35PbGJY6JL
         CQPOB1r0xCiRCvrtcJ/dBGI3eammKPvDfU9HyeobznfDG1eybzuVxD4YxavD65jaZyVD
         m0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124102; x=1730728902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aImNohBUk2NW3GRq9ZLM5JEjXx1t4RkFnKqYF3Eer7U=;
        b=S11I8JQJFRGitva+rwJsT6gzk4TLeadZlklMsPhXvnCcRmxQH+bRJkTaXnQOyBNSHW
         4V0w6ZwIfezbKwU/ZguwnKkOvQCVgA07sSRteTi3OTja1ybvgRQSmuCXAppmojjOAHSH
         pNymkmRgPsZSN0V85YrjJL323tZ0qE6CuzDlVH5Kp4vRcBUzbH3qmR7kGPmbRbM8qAwh
         /Cj9uosCikR9vQ/hDBN57+cdXxXNhJJMpU7RJxPP2l9L3s0karXJTCS1CaEqNapzOfzN
         sOiGRI7kZw5jS8maSu6J9zVrrrulZlFvXhzMnj4sqb8kMrJFGNWFXGauEy/jGC5MHuzV
         jUeQ==
X-Gm-Message-State: AOJu0YyPJ054E3RQt05L+ZV9Z60i3ZV4NjCom1Efkc5EWXmAwOTk5M6z
	SHejvITfEEh+ChjgI3WJqRFkdqt/GnjELEMcNH12XN1iXVMx4xdUDeigvA==
X-Google-Smtp-Source: AGHT+IHCgtjP26EFLxyGC+XRpxEFottRXfU5B3sIbsR/i4t4ykM1KP0fFYWUKCf1T5DbWxKF35hC/w==
X-Received: by 2002:a05:6358:63a9:b0:1c3:7bb0:15e3 with SMTP id e5c5f4694b2df-1c3f9f88d94mr168509755d.28.1730124101944;
        Mon, 28 Oct 2024 07:01:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.106.61])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132292c97sm34836011cf.49.2024.10.28.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:01:41 -0700 (PDT)
Message-ID: <671f9945.c80a0220.dc10d.afab@mx.google.com>
Date: Mon, 28 Oct 2024 07:01:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6019514765666445717=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v1] device: only use the address type selection algorithm when remote device is a dual-mode device when pair device
In-Reply-To: <20241028113643.1012491-1-quic_chejiang@quicinc.com>
References: <20241028113643.1012491-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6019514765666445717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=903776

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       FAIL      0.56 seconds
BuildEll                      PASS      24.45 seconds
BluezMake                     PASS      1660.51 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      178.89 seconds
CheckValgrind                 PASS      253.46 seconds
CheckSmatch                   PASS      358.61 seconds
bluezmakeextell               PASS      121.57 seconds
IncrementalBuild              PASS      1647.52 seconds
ScanBuild                     PASS      1031.62 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] device: only use the address type selection algorithm when remote device is a dual-mode device when pair device

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (116>80): "[v1] device: only use the address type selection algorithm when remote device is a dual-mode device when pair device"


---
Regards,
Linux Bluetooth


--===============6019514765666445717==--

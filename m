Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C941C6895
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592194; cv=none; b=GbXUGqAvY3mi8Hm/D9moHro4QK11n7HZopd+DR5S0hHGWhCc4h9cgxEVW6fMlQJjlktnVwPoZnRWt2VNPIisa7u1sjC0YGQBPqbFmGwYMQb6GnszWkC47NqRYE8ETlXBHPMAvvnUoPshUk1FsIqz0ioJ4MLKuHP+/7oo6Huy62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592194; c=relaxed/simple;
	bh=smPrvAm54ZSO4RtNTt/JY+oAPU9mCOkDe3gfYqfgkeM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SOj+LVpyBbC1I+Mtv3W7gCPNpnUPqg3m617uNsyBAkaCp6AQaIhWqGHYZ5dwBCISVfWERbOkG2HAzrqbhrq6Qeu44SgSdqViOhDUnzLHavRn8lnwO7eSCiJnG6C4faQUEbNriv3/HORYAM6JgmzemO+EweN3HPB1EozyJG4mDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOoHRnnD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOoHRnnD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44633a67e52so6339311cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719592192; x=1720196992; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgIK58wzl+yViY353R48ypEHp3O/UYv3GW7VtQEL0yo=;
        b=cOoHRnnDcWQHEFJBCF3XghGAcUU/Q2reOkNnDHv/X0F03pDK8X3fxHv9ydNDkvNvWE
         39VLqokkN0STazg+6GYu/0MJxccZ7oxzFjAf1OglPOIfokL9BfKTI2Wytntqt3upeDMn
         wp0nz/vT/Kaolo+xzRHe55ZYgpp1MIy3fN0gF/4TAlMJ/0NyibcwMYh+7F9mTHAZCnQz
         6PKVvINyNXpJ7Pul1vX9CIFakNzOK1Zl7llnDAjrJ2KdpDpSwhqOgUNpK6g0v7RlrEMM
         kSjdJR/QubC+ZLaPvelsh8O2pV4Vs/EiF+B+bcVVWERB3pHDiMJdzovldRy3c+b6z5nJ
         nJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592192; x=1720196992;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgIK58wzl+yViY353R48ypEHp3O/UYv3GW7VtQEL0yo=;
        b=Z6P0S/Xk4BHvq8uCaUT44l00wiSRUIoB18M2TkmiOIuGUOC3MU84Iw/VzTyWzxgFZW
         DCXkoQO2SNkykdBz0Pm5Y+dXuLQdvXmpmfU+YkMRvven3Q0NvFkoUh+VOFUfacWbDyCD
         6Xy+QXyKwb8sVa5mHnOrZnfLrHsoJcR29LR0rM8G4A5ySufbD6gBXa64nl0Q9xIG4CEb
         6Ky55MW+OeKIkDzyvIcCv+0dmxFRZG1CFQK7I3z9IGd34TYpvdKQXJPdvn4TWjXVk3Ng
         ucS7QQr+Xfsyq1+IrFh24f6dNNuZXj9HWbkYpb/u9adVx4srkgMC0fV3N7MbjkwV+m05
         gMHg==
X-Gm-Message-State: AOJu0Yxb+4yPLJgCgYIcDvRH8c0jykwgIx6odfUIqL+l3Cv+YnggQ32S
	JC4q7YEsp2aUGTgYkgLqK+IqmQPFwk+gFsSe+kKmwZ89PPLWlqT24Ql0oQ==
X-Google-Smtp-Source: AGHT+IHFPSLxe3XeDoocaYZ9171NFSfzhL3NMwHovZAFxKl3RzHUjrwiPox/6SQpu/48/c+6PPXT6A==
X-Received: by 2002:a05:622a:4cf:b0:441:592c:e77c with SMTP id d75a77b69052e-444d91ff810mr166801451cf.24.1719592191597;
        Fri, 28 Jun 2024 09:29:51 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.254.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446513d3601sm8426011cf.17.2024.06.28.09.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:29:51 -0700 (PDT)
Message-ID: <667ee4ff.c80a0220.859f9.4398@mx.google.com>
Date: Fri, 28 Jun 2024 09:29:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4053809562203562604=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable
In-Reply-To: <20240628142112.575748-1-luiz.dentz@gmail.com>
References: <20240628142112.575748-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4053809562203562604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866614

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       FAIL      0.82 seconds
BuildEll                      PASS      26.98 seconds
BluezMake                     PASS      1724.74 seconds
MakeCheck                     PASS      13.37 seconds
MakeDistcheck                 PASS      180.88 seconds
CheckValgrind                 PASS      251.31 seconds
CheckSmatch                   PASS      357.91 seconds
bluezmakeextell               PASS      121.22 seconds
IncrementalBuild              PASS      3065.36 seconds
ScanBuild                     PASS      997.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,v1,1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable"


---
Regards,
Linux Bluetooth


--===============4053809562203562604==--

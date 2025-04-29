Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609625F7B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956493; cv=none; b=GLn9NUCvOxWq5npCyG2M6JQZEE8T6d3/dF3S0hjC0Er3aeCTWtnXtzc0qnsRTMtmgJavvN51bto4S/GHaJJyXvd22IU7hhLZIqRb0wcR+Cx0H1926Yydy7q7gHE2lTFqzAxibpSQlzwxJAy0W/SLChD6DxOnDqGoOV2w31W2Qsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956493; c=relaxed/simple;
	bh=BXqW/1Q1X4LMNzDdM7KF7bVdxEG1qEsXrUbQPVW3LBU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mbptGnJDFwnbFSBYX3pMhoCQInU17bIXpvUIL6WyKRIuUL+roXwD5XC3l+AwIo2lutovV/kM5xw8Jm5DSfzPHBAzAnHWSG7sq079hr77OvWTbwUmc8P3416tN0fHe474TouAM0F90u+L+aHzdNgGXTNK/4znIymCumOApUqDX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RidxgCIP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RidxgCIP"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c560c55bc1so775956285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 12:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745956491; x=1746561291; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dsiEMMn+D8DEtVML3DQB6yeke8TS54o27yc7xOUMyIU=;
        b=RidxgCIPAoMbjTjViX84LKPxCg+fw7O8iYAoYrlK3/dBW300ZelHjQPAmElyzjuIrY
         N4nC3dlm/zd+DmBDbFcYF1WQ9BAe87g0bmfPCB6mzCWyZi16OrlKObtZgUHXA8oZNQCA
         O3qIVadaVTRhhVkEMVu0T/nQqINDnxLUSDpph1YXIu0S7hLqHcZCbt4pj8yllye9BGxY
         ibpw/+9smbFv4X4Uzn6XQ+bhE7AbeGTR8ilrj5gau5C/LhSDkZOIYZYCCIIURvyhyMB7
         1QiJlpo0z++tWtdpmue0PQzAT7oNop1e9jmT5bDqDda0KKAwrB+8OSds78xOTD/sNwX4
         eq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745956491; x=1746561291;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsiEMMn+D8DEtVML3DQB6yeke8TS54o27yc7xOUMyIU=;
        b=jIwEr2vNCTbLluXdx20Ovb9TVu3RBf5G2GDPT4ljg+YeJcXU0kHIPBhFyx00piUnHz
         Y61sDgqUlLGc6HtuRl04rRpgwTH7AThftsL8SHG1dQcTrbUoj4Xt8lci+1p+mMeLtP19
         /kxfWi1DL9F39YDoaJjnAK0O9biGWb4b4iIkl7zqWFQlx3e2Jix29yo5a/QqRBmE0btT
         wSP97kFyNpBabwdrxYtLXLSYs46O3QZ4mY8ANR3G8u02u501c3A5OQNmWiPuxiaPKq6T
         fMs5hO9DkCFcqbL9Q/nYSrVfpJvoiE4V4bO3jbBDhoA8R9oNB2bIxzAX8JoHAR4+wAtx
         kdCA==
X-Gm-Message-State: AOJu0Yw4pZrQbG4d6MZEH378Pnw2PVK7IZYA286MPyRfDga66SS228Zr
	iTS51TcrCQJI0yFXqdZJ/SamBrFyKzNzAS2ZzdylodKsLCztTiOtN1pwww==
X-Gm-Gg: ASbGncuvnPYo/8KFanVUiYHS26zDvl+QE/iOklM/IO822kAFDeO5Sxo+O+Tb6MaqraS
	L+h+YThHmEdjP38I04xrNIJlht5JgdpgfnsPMJfCL0UUZLV/oRmAhz21iNxhXU/GUSSounOhr2q
	eQAg6XrnbU6tfQSK8+DJCLQbufbO/rS0kqs3LFBUz/xjEYNTnAqZXjRxiE01UZ2WU60z/rA6kI0
	hJoVV0n/+MwhWOYpJVxPhrgx6ExBamZLFXG4zNwnGkrvfj4MXPt3tQOTK3mQWKKjjBml6Xao9jS
	bcMVS5/XRzrFsPBGvUuWq0+2MIiPa07LAFqgB2OVp3N64s7w
X-Google-Smtp-Source: AGHT+IE5zaY1Nrc2s34A3hyi3JH4gY89Z4e/Cznr2de6PnB3TqanSmkW+RBDE/nnBUo7veOaBOrjZg==
X-Received: by 2002:a05:6214:2248:b0:6d4:1425:6d2d with SMTP id 6a1803df08f44-6f4fcfb1887mr10106676d6.43.1745956490719;
        Tue, 29 Apr 2025 12:54:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.229.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4cbbb9de6sm61164506d6.3.2025.04.29.12.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 12:54:50 -0700 (PDT)
Message-ID: <68112e8a.0c0a0220.15ff28.ac2e@mx.google.com>
Date: Tue, 29 Apr 2025 12:54:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8239976244960109103=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags
In-Reply-To: <20250429191319.2234877-1-luiz.dentz@gmail.com>
References: <20250429191319.2234877-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8239976244960109103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958246

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.35 seconds
CheckAllWarning               PASS      26.97 seconds
CheckSparse                   PASS      30.79 seconds
BuildKernel32                 PASS      26.27 seconds
TestRunnerSetup               PASS      459.69 seconds
TestRunner_l2cap-tester       PASS      22.63 seconds
TestRunner_iso-tester         PASS      29.57 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      120.68 seconds
TestRunner_rfcomm-tester      PASS      7.87 seconds
TestRunner_sco-tester         PASS      13.15 seconds
TestRunner_ioctl-tester       PASS      8.41 seconds
TestRunner_mesh-tester        PASS      6.14 seconds
TestRunner_smp-tester         PASS      7.19 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.96 seconds

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


--===============8239976244960109103==--

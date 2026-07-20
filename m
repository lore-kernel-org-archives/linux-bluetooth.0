Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1622D4D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550796; cv=none; b=lcXvF0J8fKFGZFSp5MnGFQnq4npDighZsW18++SQ1X1C5vZZ0M/2Eh6oJ/T9O/YQlN9204KLSLnzjN0Bd8JuiOoJbwZ91PEEaTP5oFwQQo6UissfsLfxQ9W4pQep4w582PRaUwIl69mMnqrnP2LeE5XGY1IvHVhwaGPS3ybfYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550796; c=relaxed/simple;
	bh=KDZKARs9CfATCxFYQqj6q4LPYx7PDBq2etmLgLQQK/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZP0YmhqQD8AWF0G0AODTQ9lM8NaphMy6eOXGaXESvXSUT3xLwYDJ3VYjEoVHb+vd3M0KDBB+grnrqvd7H6XqsBG82GYBqP2eKeYJaNj+YQ2vqllo2EdxalihqhTwFOrcghnHQxTXW2aUjFYMju04pFrjbXWRF1mRVowUzKpwTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpFbyXXm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpFbyXXm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c04bf4711so108908551cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784550793; x=1785155593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=313c8C3i7wUEHJCWhL3vGxDQl7LEtcH9zp3cJoV64AE=;
        b=WpFbyXXmL0HBL5e5r59ECU8OsPibhpwcuuC81Y43axcR+imPgHEnRGs+A4k/LdS93C
         zcP8FJY4d2LnbiqMASTfpfuyqNfkcTDxPbgMBf3ixSmMumJ8QSM4i2d+IeCVZGiuSx5Y
         L0/QlNJrbi5qe0M/+xXCzgR2tZmtdiNBOUXDDJtyBA79LPQMPPzAouN5lreP5SoZvHN6
         ui+WHjAv2xsLXmVyZfVNkBQagxW1vBDZ41hyL2Tux371YBFOD8tP3dW7vyKo9G5uQn15
         zxVRvSbknr6GiHeBRdJPYCVy7go339FIkAqQeBG0n8PI5C5pdMC0Uqj1L+LiziHr5IiT
         mEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784550793; x=1785155593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=313c8C3i7wUEHJCWhL3vGxDQl7LEtcH9zp3cJoV64AE=;
        b=oWPrT0de2NQ3TfgGkftSasng4Ayzmr6zk2QXwPB5MKMvsdzKvEOxfV2DvwGcLiI2Vh
         8BiQD6E8R3WszVFYBEjkoILF7QFmoTgJzHGbuQl+8lwgqR79zTyTfAIYvjTXv1cDEqqM
         vSj+6hmFm+BCTj6mVzttjN8/Y5dwOKZqfTpGKgSEzZF1bLZYXXLhOdnnCWbg6sAaThlB
         +Zi+w/LPixRyPmkwMMIcN84hqpDuVz5HDO2UQy+f5ihAF3X2+b0BITVGefuU1OjfC5v2
         +PBqDccXR9lvg1ROy5y2ViBvWfBddzRc4SLFqgV4nZyvSy2avsKARGbDlIixpWdv/znS
         T69w==
X-Gm-Message-State: AOJu0YxAsMTCCG1vmTz/PKlJ+8q5Nd9MDNFozu3YjAlgUrO10Vvue+TA
	aWtKzwRN9jrktphZLLpLutpUma+jr162yUCsjeK6PBEvnOHRFHmnbK5s1hCUyA==
X-Gm-Gg: AfdE7cnuGCDSoZpg617v2kABXbgG5WO/ecYpns+UwGlQtYh/+6RI9JnL8XAv4mkkZ10
	RyQeVFIjNgsDsannJVvglqBkuKwzwKSxk4NW2RkcsQM9F/9Rjb1mgoY4JFMAXOVA89rwBxAoj+E
	ZZkrVMOJXS+35GOHb/2n/xazTr4a2RtLNk1fF7nwf9wAd6DmLs4EX73JEPf+Vz9/A9Z/o58YMC/
	k3XbJMLSLnRX2yMoqk8jLfYEaVedt+FPfhDMcB1hSrdA3V+znh03sqLAhXxupC74nqiLbaw81Bz
	LNHc1Q5sHc3babcZ9Ce07I1nLW3MoMs7o3SR04UgfEYuJYPEPboum9oMrbDIBm6R+qT0pspyS8y
	/SSlEKgpVSQAQz4ZPu/9tmey6opu/FbM92c4ElJGdAFw+a39PPB+gvAxOZcYE8WzPSM5YrE5uxj
	MovrFzJRaZag==
X-Received: by 2002:ac8:7dc1:0:b0:51c:849b:86b with SMTP id d75a77b69052e-5213c7e5e5emr135931891cf.43.1784550792903;
        Mon, 20 Jul 2026 05:33:12 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.160.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm89566586d6.30.2026.07.20.05.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:33:12 -0700 (PDT)
Message-ID: <6a5e1588.a374d419.a2d87.9f7a@mx.google.com>
Date: Mon, 20 Jul 2026 05:33:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5154429388129529866=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: [v2] Bluetooth: btusb: validate Realtek vendor event length
In-Reply-To: <20260720114717.60749-1-pengpeng@iscas.ac.cn>
References: <20260720114717.60749-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5154429388129529866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130844

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.03 seconds
CheckAllWarning               PASS      29.79 seconds
CheckSparse                   PASS      27.74 seconds
BuildKernel32                 PASS      24.87 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      469.33 seconds
IncrementalBuild              PASS      29.93 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/461

---
Regards,
Linux Bluetooth


--===============5154429388129529866==--

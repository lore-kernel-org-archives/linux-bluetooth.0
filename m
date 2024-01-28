Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0B1F60B
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706441396; cv=none; b=Ijlx/dzdQdmJ5pQ+kd9r3eHWBfEhcQCgOTAUYEnZmLKGRXrvL23Bok30YHYdAn4cGRUeO0MimQT2KLlL9ZMkwlaD7SdtnOESUJvSU4gnjrcrKwIa04u4M+7KXRjuR3BHAix9tX/zW0EP3Q7yctJ3mlXaUlJjy45nWfu6DvB1D4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706441396; c=relaxed/simple;
	bh=Mn7erc1MSet5xM0AcyyQq7hiZMY933c21G1jcTkeqvQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WC4UVN3QKAZST1VBBJcWRgoj+NkPKEw1THnj8BhAbDCv3tPNTRPc44c9qxKGq8plD2erWL5qCH6ShBEkuQPaPXk0C8/+Ek26cZRYobq6ai3ee7Ub1e5qe2Nevm4Sl9cBXhnL2sjxrtpJI3q83yeHyDQP+dzfgb5gGtoY+LJAPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMNuRrhz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMNuRrhz"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a8af3c10cso12928141cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706441394; x=1707046194; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vEV5rR2Mry2Kq5staWRCCsJQ5RN3cUs21bTQpEbCPDo=;
        b=ZMNuRrhzAbGf8sNEvazJMAG3ws+qSVFUjnELe6rz770TdHglQZie8iz/eGnCbVfjca
         sRZlczckB3WPpBjplKRkYMh67SMig26EJsF8H7ESLrGF2nqxaHseTUkau3fHbXycjMnD
         tcHUu8VWm7FnxB06269fdjb1+CvS8mwQ2p9I31WsiCCIWvivV/wC+yg/CkJs74cmW1Da
         p9zR9pwQ2rrgYcwzFTowCSNqr9mSo0nM7h938V9DWHhiBeR/JUggW/YKRJqjmZ7sLXhJ
         eTDDwmcPQIvtyMTu+VXPVziATkd8b27Dm0fTqwh2n5k/vpi49JG9h2KgDc2VLrpiZ1kY
         C9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706441394; x=1707046194;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEV5rR2Mry2Kq5staWRCCsJQ5RN3cUs21bTQpEbCPDo=;
        b=IoUKloqFzaeGy0WAA2GKkwILw/6N07zzg+ty1SxX5qNlyLM7h4r+S9dhLz/srBuNDv
         Bg5KwtaFAHZRBXChIfBDqsz5381XOTye/XjMVitkCVSiGmAs7AuBJm2ePBxFK0KZhT7T
         lOoSAkBTiftpj/iRmWW2Ya58D8HxZqWFycsrvlg5FrNCfkJHFprPAdebkkXavgpF4ToI
         R883ceOnKPVGUIfqNSVW08RWscL9GAC8/ehsXvpx/czihbrisoZF5SeUx1rmYVJWMdHG
         uEhJWdmHJQJ2w0v2I4gBuQpZwLQstLuT0JYsYeDz/d81XWMZh4njmBtc6u1QgNW6czP8
         Vb6Q==
X-Gm-Message-State: AOJu0YwJMBWzRYpLPKrbkqVQbGHqoSU1LFTN5cyqgbNtKycDAY1kQ0sF
	RXnhZx24QmnXd3atZpN8zf+TslqHhTYIEfzZYDO7TlXtd2dgI6ygnDcK1DIW
X-Google-Smtp-Source: AGHT+IHWcwdbqNDydwx0OFGbqKUVFnCAAM+WOK9XbgRxkzUDrJex4JvfiBC6pCq57rDdF0ag3DSIJQ==
X-Received: by 2002:ac8:5c48:0:b0:42a:8aa0:b5b6 with SMTP id j8-20020ac85c48000000b0042a8aa0b5b6mr3671233qtj.94.1706441393669;
        Sun, 28 Jan 2024 03:29:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0N1HbTqP+A9Wvj9+YTPD+A0b9GpIvuJSlN0ctd6bWKMCYfnMz8yHtZKrtz5+gwVLRqkLwP4bYWrqaVP09iOoMXw==
Received: from [172.17.0.2] ([13.91.68.82])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902f20a00b001d8aa88f59esm2771951plc.110.2024.01.28.03.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 03:29:53 -0800 (PST)
Message-ID: <65b63ab1.170a0220.1d6e8.81fa@mx.google.com>
Date: Sun, 28 Jan 2024 03:29:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1019198368630704446=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kuniyu@amazon.com
Subject: RE: [v1,net-next] af_bluetooth: Don't hold sk_peer_lock in bt_sock_alloc().
In-Reply-To: <20240128104027.18868-1-kuniyu@amazon.com>
References: <20240128104027.18868-1-kuniyu@amazon.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1019198368630704446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=820613

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      27.60 seconds
CheckAllWarning               PASS      30.33 seconds
CheckSparse                   WARNING   35.86 seconds
CheckSmatch                   PASS      98.25 seconds
BuildKernel32                 PASS      26.91 seconds
TestRunnerSetup               PASS      431.49 seconds
TestRunner_l2cap-tester       PASS      23.33 seconds
TestRunner_iso-tester         PASS      51.28 seconds
TestRunner_bnep-tester        PASS      6.88 seconds
TestRunner_mgmt-tester        PASS      159.22 seconds
TestRunner_rfcomm-tester      PASS      11.06 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      12.40 seconds
TestRunner_mesh-tester        PASS      8.80 seconds
TestRunner_smp-tester         PASS      9.87 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PASS      26.72 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,net-next] af_bluetooth: Don't hold sk_peer_lock in bt_sock_alloc().

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[v1,net-next] af_bluetooth: Don't hold sk_peer_lock in bt_sock_alloc()."
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:221:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block


---
Regards,
Linux Bluetooth


--===============1019198368630704446==--

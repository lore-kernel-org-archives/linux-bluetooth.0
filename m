Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589385;
	b=OzNEEhkU2/DFBWWrGiop9hX3pBWWm17qf9itXr69KdXyeAZiizpimfAa8WVEmqbeInjI
	 knaiKRgtYUAI+In0qjXPFociBPG9bpvDupRJFu6RB9rO5Mvki8pQi/7DsvfdCunFEnQfv
	 Q6tNjiwUjCVPD4dAGI/4CrJcWzk8odCTwGutEY92Hu6tFbOl08VhW6mdGDmfRs6Tpu/pN
	 xuA3CIDvtxU4BK7egtR8PbpYNtl2+3oPsH3Pric/ktLN9Q4XoEOLhAD/j49SNp/8pHVXB
	 1/0SIxxvyV4KDAs+i5M1QX2yZYTzGa+DxWzYnpI5Ds/f3LtVg0peBtnpbhYGhs7VRCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=d+Rd8hRH3guAjyHS6XQlYTo/YrVg0H/7fJBlSrwILlQ=;
	b=f6Wxp1rDtJxU0cHT33tl+kWBHITicA6CFhVsAUFiPaQvHtw31pfbvFhLalyJWejwkXyt
	 XgAxYyiboIIIUz6GSR2yFWJbaX4xt54Xg9UQ4KX8GYWFeevPeT7VEqraStrxcWDne9uka
	 gdeTtqBcnwO//UBRNloqrX9aSfFhEeLoEgCRrP1kTxaxOzfdzqjlP0Q46gtGovkZwKXnh
	 8V8s0I5zTQbJVXG64CjAG2MM/Lb8dEaLOxb3E0WsZnP0PqONjNzHD7NId1T6d7wLx404G
	 vlcVtNXr4O3YYVA6Rc2M7G6doBDB2Hf67wIX2a9UbQC451sf+HxNcntl7GInQ+mB/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MNTLtXx6;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7183606B556
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7183606B556
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MNTLtXx6
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89d6bd67045so636794b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589384; x=1795194184; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d+Rd8hRH3guAjyHS6XQlYTo/YrVg0H/7fJBlSrwILlQ=;
        b=MNTLtXx6jCKBuitIsF7XTgC4KcGrouPKT7bcjqYm55XZwIGWo4TTph8NgV/daB0LYW
         /L7LWbg+WI25XY0rNURLZXxhSIIbbz5FSr4Mupw75BxtVIxUfdwLn3cOBTUtv/P4lr5E
         rRYjPL3etdapLyFDpIO4JCeJmfCQ6uqBGGq8tR9rYy1depyi3meq5bjtqkrV4N9kmwgp
         ZTzE85gBZDxxvi7kFP558rxHg+m2SA8ZcbXrbJ8ggzSxDsnhLRNUx90OK0sHdhM1cmJh
         qYuCOc7SsvOpjUtE/rtcjo14W/0it0vIIf+MTamsHfu7HSSg/pz0NHQ0YhNv60C1fzSa
         RkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589384; x=1795194184;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d+Rd8hRH3guAjyHS6XQlYTo/YrVg0H/7fJBlSrwILlQ=;
        b=aXutnWK8kMecB2yCDPWbpdVD4V7FCBJysatft3X0yRH6xXfQew0FOtmeFuTLDhAnUx
         NG+pETzKtj6iP6Ehl11XS9Z5hvyJkwuV5pMyViUMDF6Sx7+zRdV8YeNAvJREZ1xuH0Uo
         AvmFm1Q02TjNi/49xkfvxNILjYR+gkCsDcZtt7UdNr5Nw5wNwR+cPj8MokgsWTeHSo4b
         6rnyLTZ2x54zntAsgCigu/8LgXQphhCIm7Nam1zICpOIojCwimnBbsPPxhuWR4GQizUU
         9tz4BnFezh6g6BXbGXI4d3ZSbhXEo1RO7gZBzgZ6Y1kxRcjVP2bpES9b1LUYdYl9KqWs
         S5NA==
X-Gm-Message-State: APuU4Z+v+8BAfwg+cqGYafOi+MF1662RFFx2Ln6vW7vOSJUh154hEbY2
	OpeZt5o+cLepgibKOOOk+1K8e3fGoRHPMOQ4ewERIKhbjDCRLuuOIi3T4TWkEQ==
X-Gm-Gg: AYBFou0HLMJ6IHeCxX5UYHnKJIQphnO4eYQQhOXkwVUl8i/So5z6sl06DlVNkLy0OJ6
	MuU63/sCvoOMc1W6oswBnwOYjsmHnxTvnqIPZusB9U9UmrM46pL7tdRrcawirp4aMrjLl4vrZOG
	c2IyLHXgEV1X6HlPS1k14/eL/VhNcT4f72nHybpFuWKcMUT/NlxBrYjmIJupsh/yZjhdADCEuQt
	26wC1jEqnQOxymTInc/K3CW/2lT3F3Sdssj47sNBNyIt+S5nDRJqgZWS6jhyTCdPli+JVc+K+s+
	0wZqBogIAiOE3VDJudxyzCKdzu0NqBcW+1yWENWH9Cx8FR+ay3guxTBoSZ+BT/EEwCr6Ow3VS7x
	uc+VmXf6+hvKTenFZx6dctQ8BqhHXalnYQuMkp+E/+kQrmiMk7OEZDnrKfWx9ZD3G/NzcuwmZsP
	YrrJMK/F4U47T+PlUsoy8veztZmkS2DBr+5HZojz9p3IvU3peing9CE8KmtEgatuBf4U74O0lUH
	JrdcitscresOr7xZZHTPI0BO2j+PuYPUpvRfFLs+nOli3HCbq88cSEE8QoyPLlSaTjVgQ/Pt/4+
	94DUweQqk5ILz/Vm/WeI6PVYhyA2Nvx3B/JRWQgg
X-Received: by 2002:a05:6a00:94e3:b0:8a0:76ea:36d5 with SMTP id d2e1a72fcca58-8beaedbfbc1mr2348400b3a.0.1794589384051;
        Fri, 13 Nov 2026 09:03:04 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-109.us-west-2.compute.amazonaws.com. [3.42.157.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8becbad7de3sm1405136b3a.0.2026.11.13.09.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:03:02 -0800 (PST)
Message-ID: <6af742c6.39a14ff5.20387.9118@mx.google.com>
Date: Fri, 13 Nov 2026 09:03:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8081399754213868716=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: 6lowpan: Always consume the skb in chan_recv_cb
In-Reply-To: <20261113161952.926201-1-luiz.dentz@gmail.com>
References: <20261113161952.926201-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8081399754213868716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210747/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.40 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.16 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      20.24 seconds
CheckAllWarning               PASS      23.06 seconds
CheckSparse                   PASS      24.22 seconds
BuildKernel32                 PASS      20.21 seconds
CheckKernelLLVM               PASS      21.68 seconds
TestRunnerSetup               PASS      474.74 seconds
TestRunner_6lowpan-tester     PASS      5.06 seconds
IncrementalBuild              PASS      18.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: 6lowpan: Always consume the skb in chan_recv_cb
WARNING: Non-standard signature: Assisted-by:
#130: 
Assisted-by: OpenCode:claude-sonnet-5.5

ERROR: Unrecognized email address: 'OpenCode:claude-sonnet-5.5'
#130: 
Assisted-by: OpenCode:claude-sonnet-5.5

total: 1 errors, 1 warnings, 0 checks, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14980523.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1131

---
Regards,
Linux Bluetooth


--===============8081399754213868716==--

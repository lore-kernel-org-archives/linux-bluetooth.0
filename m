Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319296;
	b=nGB0N3zt8xkFW8DpW5Ynxyg0Kl+FlKBCWJtnJ7Y2Tmk+OFsfAM3/vO86ZnqCv2OUlH6I
	 +zlGvMwvCWUWLgBK6nQFmH4GUzarYziO/GFATkDjZgA1fR5wFwMHu4BAeH5ZqLpvkVSPd
	 bmawBe30Ug+v67BiB9Nj1IKuBtmdS5fJvPtqEXbBQxTwZaISZC4UJ5MgEKGJbnXhSZsWQ
	 XiJA3Mc1fU1aw24lapkx+0M7o+cUnT0FbUulUEhOiwKPtUWwyI6VXXxbXrI5QaMmreEl+
	 Ki798WuVqg9XwsQQwqeH9iaxUI+njba2SzZKjAsIYhaviQfeRtt5RK8zUMIkneBp/OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=qdAODWEtgHXWiFjNHEQPkcB8QlRvGZfa2y88y0NBnVU=;
	b=vAPQGn+Eiqygfcyu52LGhQZihxxuOtVIG3VPT8xOtdE9ZIy4QQPdtFpfpc5NPeJiW1K5
	 6VIWXwKe1BpQc6gZzwckGcNOf3rIjM4Lj/oS8/ZnyC0wRbUIxDbJaOpzIN8MaqXGZ1x63
	 W051RNnQlrtABsPSUmA0XxNe0cMegnv0frmT/Vm5oN/idclB28oqvF6mgkKYLZntTprq0
	 Zys9XbWo+47HPgSOGek2JB1zzVtcR4fT4L+/s/QN5fM+R+kISdOYeQsBYTvsB+T43+FsT
	 qfqfiDKOOYi4ZB4CGdDnDsE/RGqPhJXeayWv6SY76pAyPESEliUogc/jE6AyMOjuhPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sv6y0Gfs;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F7606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 00:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA2F7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sv6y0Gfs
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-5058b105df7so55732b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 17:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793319295; x=1793924095; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qdAODWEtgHXWiFjNHEQPkcB8QlRvGZfa2y88y0NBnVU=;
        b=sv6y0GfscL7QF6Nu4k9UIK+uY41rBLvzcrjKzgBSkkBs2ZbHgnBnB2uY6lJxLDwaBT
         fffCqS9N13wCHc3K919vGeBuigWMh+3UXhjbKD9MwJN7Q2qjZnqUQ4gwzgRyqGNy7fop
         RO34lRgOa0KDaECI08AreFsaiMi9cVndhA3FWt5XUi9Xwu83558+PL8pL/X2iVhTJh5c
         36uNFV/c60Px+TqwXZQCYbtFenE6sdvYcORX/LU6oSmEH4aMF3qudrqwTWDwhzpS7tAN
         00wv5D/tl0fchz6p6Xics2m960cfQbQWFPOPCiPMSxxmiRMTUo+rAhgZaX8bMdm0bC6U
         f6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319295; x=1793924095;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qdAODWEtgHXWiFjNHEQPkcB8QlRvGZfa2y88y0NBnVU=;
        b=qGI7WCFC2WYaEAXGfI70NWjeB2H8up4/+MxTmd45p3VSJWngFmO8PP9n1ZFenVQ1pA
         d8R+qsyLVT70I86fpWbNWVqlk0+9Y4xowBkdXL7qwCrWgFyvzeOpF7qzt1pMQCvZivvc
         pSa9AvxUV3xJLBnprBQnRk8K3sHKZBPxTlWV7gLAoz2E6Ke9HgtfHX8WfSAgl5zsHLJR
         kEyLES/G7wNewkqk9VqkWmBQuOu/bRN+d7G8GmSvpizh64nXWUt0oxwjznsH4xaMKq3E
         k3JUT7bd3dBttXCX0laflpNKp/OH8p8p63DnQPVOGkct1F0xibNfom1lrcB5LopFPtCC
         T8dg==
X-Gm-Message-State: AFq9FYKnbLqKX00fgnit2zvhShd3LV7pHLxGR8jquhimo0nBLILjO2yZ
	quSx808NnkFsmJlK3s+EBX9hUVeqVPW3LyY2w90bzvQkyhqm2XcOdMe8LxzOLg==
X-Gm-Gg: AYBFou1nX99v590JoiHRItY4eZP6ucV26ZsX6JOFU+SCZSfbnU3oGE6dI3MSLThNmof
	YOQVLo4Ep/lVvJhvspv69FcBxKTo0c2v1wBfKiL6BT6Ad+FhHFc9ZeH780fFj6MprjQgb6chDM7
	DQahhsYuwS9om3ul+O+d98oN1TgrSMx7WmX8KmvQriJGVpPfNcMk8G4o0ZRWDuFn/6caeKF+F48
	tyrVqGHjwBahwmSHRZM9dIeldEd/rI+9wvr5KcxC9IKMKF3V4IOOHfkjKY+AyXWvNihFIQG5qVq
	/O0MGpsXT/gUGKmJHM8jJNTPa5/4whRvEBN069m/tz3Ac2yfCg0Z3l5XaE1zmcvFOS73pg28sZ5
	fa6MyiDx4ZlolVex/q9d3aXE041KCZ5nxX7rGsNl7GeakFCdmwNDoqF1lYBlj3wchC2yqdYVJSt
	AerYgNVQ+TJaH4n9B6Mj2iXX2GPRnbRor3kz9XQKaGKEaorP5eZjzrUSr1G8LHh8P8mIUbojvLp
	UNr8pCt8bsHfI54IFTTRv+CBPBi2/MG4OPRLGskReT9R4jYzDsi+XBHU9j4HylM
X-Received: by 2002:a05:6808:4fce:b0:54c:7ce7:33ba with SMTP id 5614622812f47-5640dc9006emr684558b6e.28.1793319294813;
        Thu, 29 Oct 2026 17:14:54 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.23.215])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fdd2fb7sm381865b6e.10.2026.10.29.17.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:14:54 -0700 (PDT)
Message-ID: <6ae3e17e.4b7b8f83.169c4a.64f1@mx.google.com>
Date: Thu, 29 Oct 2026 17:14:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8931841930289261877=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v5,1/1] Bluetooth: btusb: support larger LE packets on TP-Link UB500
In-Reply-To: <5a7311d6f4cc94931fd753e5fe0d54a2a65f631a.1793315289.git.cochcoder@proton.me>
References: <5a7311d6f4cc94931fd753e5fe0d54a2a65f631a.1793315289.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8931841930289261877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196690/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.91 seconds
CheckAllWarning               PASS      27.28 seconds
CheckSparse                   PASS      29.31 seconds
BuildKernel32                 PASS      23.99 seconds
CheckKernelLLVM               PASS      24.86 seconds
TestRunnerSetup               PASS      549.02 seconds
IncrementalBuild              PASS      22.79 seconds



https://github.com/bluez/bluetooth-next/pull/1027

---
Regards,
Linux Bluetooth


--===============8931841930289261877==--

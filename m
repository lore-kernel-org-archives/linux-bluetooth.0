Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E63126AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457334; cv=none; b=j4CQe0ACGd5X1vGzlgmZs4YtTUHjO8Llm9kOYLqg62Xgm4quHnzk7wM8FasUlRpxf2ySQQwbdYUCxj+W0dXtLpDENryXI1QXEQ1w3EytXHkkot51c368BrCrP+UBB4ZAxE1fBiaBmhn905phAOujXaC+7G6F4D7h1cgbdPtavkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457334; c=relaxed/simple;
	bh=rOSc3inpOlgh8Nz6JZMdOF7+g/7LjtUtaJuY86BakcM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t0ZFKQPZQJIoIuUzsTGyio/SLUx/98+pW1lvNs12fwLnYQ57A45njg4Orqk88ho/0Mp9DivSsHTI/ntcRTnU39p+a40ove/JWYHUbKalr3Oc3Uvrl9d2de7hl1MijDEQw0EC1IS3fBOIoCfjB9V78I0Wbl1SKk9n+n7RFIxVlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCoHkk9/; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCoHkk9/"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c66ba0b762so548079b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789457332; x=1790062132; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zLbD8mZuB2Eh9OC7b26nje/ikBN1uQlj1rTGbTQqaFU=;
        b=eCoHkk9/mN5GJxr+1qfu4wTjbhLUxFdSTZa5Ob89g1/E7vRH28nxAUykeAY7/Kr2Ak
         1pcFW8kTSQ0nt9xWIRh4xJMRBmlJPhObKp7JQkBk//9tR8n9Y5E7aJbySTZPbeZanOWx
         3PlRcBksV4OQuylYq/3Zo8c9QIW+PV4D5899ZGUXsXHXR+MoXLSC928hJmvvPp7gQx8N
         2BxLsYgvZtV+zOeyqTMm1bIjs7n+cYNAMKb7Ja7h3mTHupFg56RzkmB9Zy3XVh9uA9nD
         sZBBizXg4T5ZKd7aJiKsvEkfoY3aCbcML5D0n2APpXtHSw31b0gA5jbG+7aP2XvV678q
         m9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789457332; x=1790062132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zLbD8mZuB2Eh9OC7b26nje/ikBN1uQlj1rTGbTQqaFU=;
        b=MnlI/HmbtqUFnJ6FcQqg2UkR6b04/51esJ9H0irfdDW9qOPPXTcmsVoDLtGZw/z0m8
         9HVyO3KNpzcQU532HBAqhU008r4At26ZYrC2M9piXCF2oDTnQnF9cBeM6D1uh0e22/dq
         gjyRyGZUfExDK7i6PZldhjfFXkNRDaNtivxMqbSK1gN6cVdAQsSFbDXliLlWIkTJ8SUV
         ISytLDhvnxGr4qY9vDzud9oV6v2tAZbTaSgc9xRld3hwoZLI3t0zpcwuQThPqai8jNLy
         As+SXS+LpVncELPXvQfYRA5TZBjkOD40Mbnb5iaZ0Fzz7+8hamtUNsTJa4p0Oidbo0il
         CStg==
X-Gm-Message-State: AFuF++nEKVo4MiUGWEAvTkL3OIEagJxZseq6FaOhyyzOnGOXRUGOSqub
	i0e1sZjKdwmMGt/fciwwCDCGLJwWS3U6ljnq3FvIP0p6nB0beW4hrMZWi+l3sg==
X-Gm-Gg: AYBFou3Pp4bZutyXVu9KQKNYsskiMA0EFEqYYiktwvo7cgunHtBgY/w8fFuHgfgBRM7
	SqaN+OCXJ8kAiRH+yCjEDp6cqcdWbLKPCE25JFGN8LvAeGJAsQfsLOKCCINcbKHLBCoPvGtYJdG
	O+EVCqX4+ltceF/+937pahsdLp/ny+B5IAPS5QqrxVRbfclzSgot/CzSwpJxVIzr0j/S19LwFHA
	FW/QG6dWdPvUmOQh+qOqQ6ahKpgAAPYjOTOjNVP4CEjh/QlL3bGMQK2Q/UixqyISMliaDONPIdW
	UBLdkbDWih0VrLUqBDtewBrg/ec2AWNOBiroZCO3pAiFYXNP5+OEj7QnOngvIy+BNG24REm1A6y
	EoPImjcSCWLFFimWxXyAfpz+d+e5gI0Q0fB86wX6AlKZ02Qyeskqy4l5rWy/uvPJ7MT1Kdyp/jF
	SiACLvhaXteAlY7rOlwNiJUs0ZJzUmxkiGWWH2WGMfCUOwZvQIp7v9oqbj31IQ+2lZX+eRVirq6
	9I2Pj8VQZWoFmb6LLk=
X-Received: by 2002:a05:6808:1707:b0:4b3:3e1:499b with SMTP id 5614622812f47-4c89f79ce4dmr1359510b6e.6.1789457331840;
        Tue, 15 Sep 2026 00:28:51 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.215])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c4dac87084sm9563649b6e.4.2026.09.15.00.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:28:51 -0700 (PDT)
Message-ID: <6aa8f3b3.2b6cc8da.3238c7.bdb8@mx.google.com>
Date: Tue, 15 Sep 2026 00:28:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7220388050277029873=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: [1/4] Bluetooth: btmtksdio: Fix runtime PM leak in btmtksdio_reset()
In-Reply-To: <20260915035145.1724096-1-vulab@iscas.ac.cn>
References: <20260915035145.1724096-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7220388050277029873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165045/

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.17 seconds
GitLint                       PASS      0.60 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      28.31 seconds
CheckAllWarning               PASS      32.38 seconds
CheckSparse                   PASS      35.52 seconds
BuildKernel32                 PASS      29.13 seconds
CheckKernelLLVM               PASS      33.74 seconds
TestRunnerSetup               PASS      730.24 seconds
IncrementalBuild              PASS      28.47 seconds



https://github.com/bluez/bluetooth-next/pull/768

---
Regards,
Linux Bluetooth


--===============7220388050277029873==--

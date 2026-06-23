Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B815391842
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237515; cv=none; b=m5pBqdE8w9D6jONfGquFX+Xd3cCbIXIE5CplRxOIdAnfWihK3lTKG/4x6Dy0ZPfbVDOoPddlbDGGmlSi7ois8yRq8KsLdEwZEdSMKmb8nIBW31uUneZ6naMAa7oFROLMjl8Vca1UTSkKHv+JMvZwOIOel93/lWgAkirKUmPQgZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237515; c=relaxed/simple;
	bh=gyoD8WZepilJzip2E7SZpdX9rcqHseSYYRO+vKpfs18=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VYChFVQmrFdfmtDJahB/7ebA7yIwOCDDY72ED7041IsHFWCoRm9phMo2i6S4tPbhRMeYutvr3QoWqNchGxq+BEatp5lMoCIW4EyxaCMNIVkk9Zb779DZHbRCbk7rnrRPxg2Qxik/7X6XclioeViRbwNWAUh5I8TGRtIlKiO7wcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sU9NJi8g; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sU9NJi8g"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-922ade88d0aso5556585a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237514; x=1782842314; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hsAs3QnNmwV7iDRsWGsMDwN0PsPfGo15F3zaNm1BEnU=;
        b=sU9NJi8gjsBxfbnd19r0H7IyMRPQEIXJaKWrRlzRNe36RVbjJlv4eTRoqs4v1oinRi
         4Vx8UChaJXzlt3BL5pRqhb9WudjSOnXFwpdgeneY/1AJTcurI3LKvUGHGVWdhEgc38Tu
         e+/i+efX+SPFwZNEE0UdJsl4KNh0Der7la/bF7zHpwZaiGiLjlWy7kZOE8NICxN2n2Xu
         y3GAekp0G92bn+fX8fl6H+PoyLX0GwGixm3QfEdVUGja1Q7CfaOUEgiNP3QgqiRgZCL2
         xO6oS/mavCJVDFlUZv1lQ7rPVX2PKl+AnPov3R+XLr3jOAsf4+WqczmUSnn2ULh0bAwy
         39Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237514; x=1782842314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsAs3QnNmwV7iDRsWGsMDwN0PsPfGo15F3zaNm1BEnU=;
        b=BuYVhUG9C99MRCoj3uv+u2vzk1I9Yy3zROwd2ovxH+CSNKAtYweWVvSMfr5WqeQaAr
         Ig/sQ0gtWh/+TITLTp27OhHXH47SzNpjnDOTQQNAxuNDubqXzI3L1sP5WWVffH/3gTc7
         0e62p68rqPDEXIuwJpXevxgWZMZi2VR4nfEgX6x1Jd7Ibh6HdOJPoRgUjoxOODkiueGY
         nSIygcATS4R8nsDFP22lXIFVfjLOzoTp1KUQrm7TmE+aqYaPdMzEUbvwQP8LUiT1bBRE
         DomEH2v1MGF9m96WB0WS6HbsGEAVpx2FdThrTIlwkYbhhq+e76uyHlEhT+0x/XLjk+cO
         WX6w==
X-Gm-Message-State: AOJu0YyIgrEMRqBBgv2XyBiHsWRhj8B6zGv78QeNCq1hLwYB4Mwmb/1b
	cQReKj3WzTogAszNLa0hB9oZxrRrYThWlELZ5k+3BZwKcn2xC3rF7fxPlK1JiQ==
X-Gm-Gg: AfdE7cmcd5lQeWMtO3gHKZaHvCG/QqWWesWiG8D9sKptd+LtmSvMeO1s0eYW2lk5i1g
	fVnY9IjR4JNILvdO9iYvQytA0MF8Pe+AqCllZF63GiiV3vsRA3VXbFS6bXAPwg/yr0MxhJ9cuaJ
	EzeXmrBna7snZEespGNyODd3BnxRObKoLzQd469xj6C6aQG8rLTR4H5eY1mcV2shdDpV8Po0Mu4
	RFkViz3buvqj+tXKdp+rCUX/cs1l5RciylYdOFMus5/38Jr3Vypuy67nTVxUiZCdye6yxMKS9/D
	5rnadd7045qehDXX2PkU20OG6NZ1P6cVZdZQCfWCg0NVfkOCTIkRTvtKQqVvcasxOzoU/1RB7pJ
	zYs2nJ0lEmYn3XnZhWtRfp02ln7JYlpDNdpNVBIgD92i7su0Sn68AW40sgh60GMVOU7DsiFQ7iC
	2FjkEA/hFJJc1GdOjHgqA0NsZY2EQ=
X-Received: by 2002:a05:620a:f05:b0:915:5379:b511 with SMTP id af79cd13be357-9277f006540mr21114185a.43.1782237513531;
        Tue, 23 Jun 2026 10:58:33 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.151.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm330875185a.6.2026.06.23.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:58:32 -0700 (PDT)
Message-ID: <6a3ac948.87f7828a.1cf5fe.7d21@mx.google.com>
Date: Tue, 23 Jun 2026 10:58:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9096991177872772274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
In-Reply-To: <20260623161259.2175870-1-zzzccc427@gmail.com>
References: <20260623161259.2175870-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9096991177872772274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115490

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
VerifyFixes                   PASS      0.23 seconds
VerifySignedoff               PASS      0.24 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      27.06 seconds
CheckAllWarning               PASS      30.15 seconds
CheckSparse                   PASS      28.73 seconds
BuildKernel32                 PASS      26.22 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      578.67 seconds
TestRunner_l2cap-tester       FAIL      59.26 seconds
TestRunner_6lowpan-tester     PASS      22.98 seconds
IncrementalBuild              PASS      26.09 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.253 seconds


https://github.com/bluez/bluetooth-next/pull/341

---
Regards,
Linux Bluetooth


--===============9096991177872772274==--

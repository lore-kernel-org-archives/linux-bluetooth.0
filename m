Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D603BF694
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714548; cv=none; b=ZNrS2oz5eSUAuY0kqddVBttXFKZqlNc3YouvvMWgLoXtOttUHdMsXvZyOjgceqSrIDcoBf+MPrzyZ9Dn8xtPmdU6MKCt12X9tJT580tgCpi/eTX7saJc4FYMf5nwpn/K04gQl2lEs3rT5YNfw/pTfO+OOaEkKk+AWptuV6tSjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714548; c=relaxed/simple;
	bh=hTJTd/jsFtm3AolQsl7yRWueFSxXch6E5M7gZTEV6fQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jHll6CNtmyFqviyRf6Nmxmbkpj/BhSjFiB36jsyeIv1hC6Ty74L6mUMjzUp7EsELIv26u6/6L/dE0w1sLwbDaXaQBIVIGk2weWqL2dciV5E30wiooGho1l0O2zr2hohhulf48DjwssRJaOMEagxDYbxYGTHdW3LTSCPYCHF/oto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbGqdCmH; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbGqdCmH"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66825847b2cso5444458d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784714546; x=1785319346; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9c2VxlWPnl//z6UjJghniUerUVNESk3YXvf/4IRlEPE=;
        b=mbGqdCmHu3ZIHCxlSmNb14qdHAUGkvaa0rJglKRsUGRI+MMeWR1L/0HHDS/Veh1ihW
         QFqkrx1VWiP66lDXzU03qC+FcU17Y2iCSz/KcAT1Ui8RxjeljspuSsDRFMk06ewTAR7j
         xGxfwvfHyxhPeRA58R05h6q4+c28tzmOewx6MrHKcfKGGgz+KWUD4Z0lrkPl+9m6e5aM
         Bl2uMcElVzmMLzuacf2mE1grgXNoKwyphTidE0DN7C+1WDpnF68ITSDLi8yl9U2dbVVd
         45R/WAp7LAF0wwLPYDXUcQeyj1ZzwU5xz5BuAyft6N6WF+ODp1yoEDBywUDq7Hp3nnkj
         cb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714546; x=1785319346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9c2VxlWPnl//z6UjJghniUerUVNESk3YXvf/4IRlEPE=;
        b=Ats1yHCQz9Pb5thpH+fG1tBVcZD2AE5Cknx7BeFKxh5rJv/lTZvAl0U3+n9S3fshA8
         vD97ZUcL0lgkgGu9TgpPGgPv3+yFGQxQ+Lr+L9vGZ2eoeBVSSNUhlmzqjru9jZVHEBSg
         iVKA6LEh/y6XlXilbzpF0n/wFJ/fK/FVyNNJWXfC1gpMHWu/dPzu6tkp5VuCEozMwY4h
         6nv/8SarBVZBLNl/8li/xUA73OGPjWaoHhlC8U6KmT6crE6fo+kmVMtWd8FVQ1n+BZr0
         6of8qrY59qeqnBHAdM0+R+aGr5nn6OZoUhEsvflyKZcBXbihyAbN7VHqWqhFD0uMpqT4
         TDhQ==
X-Gm-Message-State: AOJu0Yy7+qaE3ZEI7mcpAwxdRX0XYcT5vMDmIo6kaV6Vqejo+a+Kyf2T
	03FUoz50s8NTJML30wpR1ShQ7F444HfJshc29KHTU191m+eGRbWBP8/TS3abIg==
X-Gm-Gg: AR+sD10U2VCgzCbvHGiKKzs/Kr/jV87BK6WzvFGPK47MRVf2EO67bWQiXJfPNWD9RPm
	9OFp82N1nYRZeeoVceZG8csij+Nec91Vx3Jbffnk4FJA3NibGdkOu43NVLOp0gNsQpKAn/ngKX2
	f/03pQQJ+GGyaKj/NoYw4Z/Ana2QfCg0OrDhTfmrY2gRsiKmbMoKMS4pNNEq7z32to7OBpoQFW5
	yTJMT9jKiiBfzSXKPJDct8G/wvv9/wEYx/xeLMrDSFkrZ+pU/nzciRtznBOW5t56aYemFDByG04
	OZRlP2VjN+7vVa8Nlh5Q95hMnkhqQRlBWA8IJ30zpJtTW6OC/SCrLCJ/UWYs1sJDGY7X1PZKLxw
	kHkRfWrl+lL78MrOoXN5txrXrKiG4qjbgHWBtbNU5dOa8GjRB4brbP/n3zthbopkwUAYAg+oMZF
	pNFUY5H21nqMWjSE3MEg==
X-Received: by 2002:a53:be4b:0:b0:668:ba3:fc02 with SMTP id 956f58d0204a3-6683bcbbaf0mr4726513d50.79.1784714545709;
        Wed, 22 Jul 2026 03:02:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.30.55])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba9e13e0sm17594796d6.31.2026.07.22.03.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:02:24 -0700 (PDT)
Message-ID: <6a609530.af524659.268d06.99cb@mx.google.com>
Date: Wed, 22 Jul 2026 03:02:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2082163891930446199=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame
In-Reply-To: <20260722092616.1122797-1-yaojiale02@163.com>
References: <20260722092616.1122797-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2082163891930446199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132292

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.39 seconds
CheckAllWarning               PASS      27.95 seconds
CheckSparse                   PASS      26.58 seconds
BuildKernel32                 PASS      24.89 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      460.25 seconds
TestRunner_rfcomm-tester      PASS      25.82 seconds
IncrementalBuild              PASS      23.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame
WARNING: The commit message has 'BUG: KMSAN: ', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14702860.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/475

---
Regards,
Linux Bluetooth


--===============2082163891930446199==--

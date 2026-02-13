Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C43273F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005033; cv=none; b=Qd5I0Yz2w7NFfyGreNTIYvqTUsewmVq7OG3WTTTrwwrdBhc64hVlNeu/tUlyAK78YV9EgUHIzEsswqnEp7Ef5Rx9kAMgoVkYne6xCdOAcebsY5xGOn+R9ntPQonjWDCjkfxk3AOpu7AWuI3FWJesRnEzPEKR1f8vAYe7g+6h5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005033; c=relaxed/simple;
	bh=nzLw08SzXDqFC3BZ+Su9aH6THwOKzo/XyYS2166Vj6A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C1PVT9Py33VoGGO1TGvDtgN6So7muJQXTgZKWmQKsdLXYAP7AtPtC1qoVVpt8qheAvEJDbOLNpYwIi9EgXXMQgXZqJXF+yvxwgjXYb2U+ZL4drkvzQE9eq55UFoZcR7cde3ADBVPoizKHEhewNDZoG5SApYfVY7q65Tx6jN+9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyjDq00h; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyjDq00h"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8cb3a8494c5so123721085a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 09:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771005031; x=1771609831; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kGiKwZr/nTNLGxN452gD5f0Y1NmprCKywS9cM/ZP1v8=;
        b=hyjDq00hLHYYz6cE/A7wqCyxchtIinwlH1Q71YevNGwScfXQmEc+un5uu7r1SbzkFM
         suciqakeyLXe1TDUQxJxu3i0sNQZ8awrjJVpJFnqXy18AD0Yva46dgkeR5NZPiNdvvyR
         MTEpp6SnliVTO5pDKdO3e5mmKJwJeJNP9BgQZgYRznpf2w2/+P74MAh/5Dn5C9wfsHoE
         Au7tgLfwPD4bv4aBFoBqSJeYr4+E6FTtPbgqQZvLyOuNUeY4unGxMCu09O6AjLVfOg9M
         nMMsku9yZ8tSqHbFEytt5VOTIVV22EAHSzavHLAUOEkofY7OCH38GGDmolJ2jatlZZBE
         w3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771005031; x=1771609831;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGiKwZr/nTNLGxN452gD5f0Y1NmprCKywS9cM/ZP1v8=;
        b=qkjPPJm5XT+AgBz7t4kbq+kfHrr5MjIigJOJVnWOG1Ut3+atKc7pii9szOj6rTiYIb
         wj90MvlZFTUFXKPOFlzXo1YiOk8I1RI7l8oXqw0TG5lD5TK2t+NYP+1c9gNI1YqKIXF0
         jQOconHH2Gar4pNQeLkQcA7Mb1IQCvYUgi82/W9V3LN5vHoAuFFJ3Z+OW7hbbpZDUAvC
         GL5vpssjDRtU0BFvH/vvmHOpeBftoeHySu9RTPdJ25frSfD9rG9fSftx3XeKvl+fxob0
         m5gzlJFesJCCu/ak3xuPErpk2Pu2ZW2Gsx9wKc9y15X5hTb246WUb5j995pVY05K3TxJ
         zB+w==
X-Gm-Message-State: AOJu0YyCs2i6OIbxP2F+48Fmam0eFspclWk4A/bnNcrylLJdCelKdU1j
	+8Bq35RwMTekUXb0JdJEDWqee0AEGACGiQRoWHTQhBP1bzGX7xt1QIiGJcONV849
X-Gm-Gg: AZuq6aKH0+FtxbIhz0SNvzHLqSvrN5of9SDIDsDowSkTLebSp1XYNg5EsfHDDNL2YvC
	9/vXspu+xxOT5u2nHhkO8bl2ewIdo2o/59FZzzrQGp9pgMQaDgRgCnnQCAmJ7o25RmyKc057He9
	DRldgpvpvJ2O2e2SH7PPj9oiX29mPo6anRsqPKKb37uwZ9w1MMEIWuQZri3mCQiQ22ilQ6QqLCS
	IF2+oKXIxVac9YKGfKXlFcPLSd5k88VM54F1RG8Yx+HeP40nOR6kVxTZpHLWV5GLHNIlXG60uDj
	Dkmaelx4pPXVhC11aV1FO0mH20vLndSx5US02lTa/14NHyiDHLagh0UEUR3dlz2Fw5DDcXBNp/c
	QLkHJ/kEumRZUQGXWQjO7USaRdp9hXbAdv1Fhia4zfswbkqKPsVsXaNrYpDGwRCVRFOxorgfdN6
	ziVnuwnWpPSClzDI9fyP8HUw/ECS+kL2FR42HPPbigFA==
X-Received: by 2002:a05:620a:45a5:b0:8c8:82a1:11bf with SMTP id af79cd13be357-8cb4224b73emr325923385a.2.1771005031297;
        Fri, 13 Feb 2026 09:50:31 -0800 (PST)
Received: from [172.17.0.2] ([145.132.102.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc959e0sm68796746d6.16.2026.02.13.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 09:50:30 -0800 (PST)
Message-ID: <698f6466.050a0220.22d1df.4c0b@mx.google.com>
Date: Fri, 13 Feb 2026 09:50:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3985027875339039519=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: Fix use-after-free in BAP broadcast cleanup
In-Reply-To: <20260213164120.502-2-sarveshwar.bajaj@nxp.com>
References: <20260213164120.502-2-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3985027875339039519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053982

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.44 seconds
BuildEll                      PASS      21.03 seconds
BluezMake                     PASS      657.97 seconds
MakeCheck                     PASS      18.76 seconds
MakeDistcheck                 PASS      246.97 seconds
CheckValgrind                 PASS      298.14 seconds
CheckSmatch                   PASS      363.40 seconds
bluezmakeextell               PASS      184.16 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1035.30 seconds

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


--===============3985027875339039519==--

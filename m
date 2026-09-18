Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341FD423E9C
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742184; cv=none; b=F7sNeYCzzY21r6ofWE0nfcG09/YORCT3rsibQDPIdMRFI5ZU3EsTMAJkroSjODPqAnapPfSwCXlfDYbH6VMMQbEvQYR7kq0r57EOawfzCGwCeyJ5RAteS2EW9dbMIbyn89H9w62tW9BuJ3xw2zciatcDzebOhj9J2a5oov2aAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742184; c=relaxed/simple;
	bh=4QmG3dYlB2oQ5b4rIp7g9ciBTKXz0xZ7DnJcRkrBLtU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oZgYEe18OQ6hZr05tF2eZFVDNKggVmpuWUFwt8FKY+fI1dvviUg901vLtxfu//LfkA452SQMx5XKE7Nwf7Keq6yQFnlfvcXGPJ6wbDI50FAYeZYGNntwmNFQm/fSFgwnkOBN8DtXYtn4dg23HQ9IbEUI2Uv9gXcLc2yglG0c8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+Wi4bm2; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+Wi4bm2"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so740796a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742182; x=1790346982; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=59m0xXGSWpSdsPfpKtO5X4CZ5KGZEmgSQuyG6UFk7fQ=;
        b=X+Wi4bm2ymP7R76be/2DEUmyAlkGTjLw7lOzjJWNGJHZ/kLHEspVg4plqTy/0Ivc/9
         nTFT0DdxNDtisEhhFZSPXnWWLHbCcl9Mj3IMplX0otLi+twXDxqUehCH0G1kebGvXyVM
         havmJYwMJfxrJICbUIhgcH9zQ//CprtRUxZ3DovwYjtxiQ3zbWXiOmAmSbz5tU7rMYRf
         ce786zGwDtJfCVArcLU4Ha8PuTMGb5UYBHdnVLZJTXRGokUnmfmsvEJNrvC6CIxmXRmf
         NskfiqrX44Wgp8F6FA+bJRPel0Ug//u1rSdBbCshYvmuXiz/dtoT3mwRtfjWB9LWBf7Z
         t33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742182; x=1790346982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=59m0xXGSWpSdsPfpKtO5X4CZ5KGZEmgSQuyG6UFk7fQ=;
        b=Oy4ITGWAfIKYL1Tf6tVqvDvDWhGGSb4m1mlLbhTo4XLa9BQtnfPzw1sm/r2ZrMsJPj
         AnOTBXzzO6TePA5Q6WW4wIWylYShYVtd/ZD+GkrY4mBF/Zpl6wRBYLaAP2cyOZOLprIM
         niWldBm8cXLzv6eWqRwwpIZ/ClBLjf+08zZDXycn5IY85Uw6/C77mTcIWKzZXFqL6U6G
         FxhVso54NB8NKA8f1UFbilvGtCguMxmfDHHWQaBvgIzio8yQ5KQISqCrQuRMXxs8hb1g
         2WEWv2KEOC3F8GrRmtn6rD+jlVhDvYF+Itn63g8QltRgmZvn9LpXPj5oqETlKK9kSdTg
         BUsw==
X-Gm-Message-State: AFuF++m1hspMJ3BZ/NDwNLPMHbAz5bdvycrG0ya4Z1EvYGGGeH7KtMUG
	hcP2fViqwHjF/iLi6OC7dud3f/N1KZiVGYiU+V2b4oOZvPen/1Cmb8W6X7B7I/1P
X-Gm-Gg: AYBFou3P7RiBBvpYHrAuJ5lV6y6G5YsdmCNZoMI6AHVZTVRFcL6vAphPLGVkcMXlSs1
	SzifqntGNtzA0kgoQq1Thgix8fTycH7TTNxWVMsVPPpW2BvahTQ3ngRkbZizgOqckIu8pSkyOW+
	H3ZNXGdXPKKyN0x+6LbsBCK3kyyMwTVQmE4TxEBO5JPzZAfjglLduu9DlM8xThUCyj/nyzrdgnx
	kbLSI3fGwwySagj5nZUSWihnGG8nLoo9Xa24RKGSYt95BHriLzTOp2J0kRGVSTib3GT03ot13BG
	KirOdYKiZEaw6GUeYn432XqHH0xA351rcFjGdWpkGXBNAr9Ivm+SRFCvWNbOFFZLA2VQI9I6cQB
	+PNfNunV/UndrL5wsvz7R4uuHjZi+ehabiwn7kjUyDLfLyQscefgs3muMFcObUxjBxn9jy5GWEH
	Ms/jHqHezY+WXJAfXP/VJkoQUArPyRi8n0Rv11ZeImDfEHfq3uQ1pErxGQQXDR
X-Received: by 2002:a17:90a:ac1:b0:39e:6a80:b79c with SMTP id 98e67ed59e1d1-39e6a80b8bcmr152349a91.44.1789742182422;
        Fri, 18 Sep 2026 07:36:22 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.197.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce05964bsm4605543c88.13.2026.09.18.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:36:21 -0700 (PDT)
Message-ID: <6aad4c65.b153898d.34df89.8b07@mx.google.com>
Date: Fri, 18 Sep 2026 07:36:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8337572645544865811=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel_pcie: Add CNVi ID for Titan Lake (Scorpius Peak2 C0)
In-Reply-To: <20260918134919.39137-1-catherine.l@intel.com>
References: <20260918134919.39137-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8337572645544865811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168712/

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      19.51 seconds
CheckAllWarning               PASS      21.89 seconds
CheckSparse                   PASS      22.44 seconds
BuildKernel32                 PASS      19.16 seconds
CheckKernelLLVM               PASS      19.82 seconds
TestRunnerSetup               PASS      456.59 seconds
IncrementalBuild              PASS      21.54 seconds



https://github.com/bluez/bluetooth-next/pull/793

---
Regards,
Linux Bluetooth


--===============8337572645544865811==--

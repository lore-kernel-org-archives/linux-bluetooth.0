Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589498;
	b=A6IsMdNFcJ38IVl04FCiJQFHGz/rMESTIbpeqxoylcHrCpMbFw+QSMB7M/0liD0owIGj
	 c2Z+qcev+SrhGgHsdrdv6zhbrYLSdQlX9zbrksqRR2WBWgFieh9YCqtxjzvgPLHG70ZMI
	 DIG0OgOjf1/ZU9Qg39P5haIDp2m2vbyu+sKBnDI1WxqsSsLWkyQAWMlcaviKnfjLYEUzu
	 i93ZyqVBkzJ3XjhWCYvJx6/ajV5/1oiqPk2wVssgN+ACUI5jOKFkhqvEpWnS6oGb2PMp6
	 tG5zgE4s2rBUdaI31YFWCWecgWUVV5+dU8lcX2Msy0LTX9tbq3lFQWGH715WA91lgFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=365+vH5jzaoV03AVAIK1FfeBLxZ5qDOccRvc4GPrEGw=;
	b=r1kYnUIxWtA0ts1fwvbBml7po5thwlv6qIOnN//1XiM8MZ94zQO9T23V10nUwVn60AsU
	 UpcWL+o6MKXrnAnxY8hysjqVrYXHb1Z7Z0v00fRfp7/64J3ISjbEiP33uedh3p0jdQSDO
	 1+LlUI+b3EA8PW1d4RbaCxHxAIN/ZOJ5s8sdrVUC8AaKERm+LmxsTwdjVx0sbsO8lR5qh
	 VKVedm5no1OBRvCaohbWo6vqOtLtnAJdxkg2t/cwmcBuH0FpsUsFpJwTkIF7Ptpj1EZGT
	 f13SZFPmjsZVAePwtstaTGOrGUHo/flKtcU+hJ1E/Zafc1vc2JcRhxNkR2QykWUx11g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGZ25M7o;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA25606A889
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA25606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGZ25M7o
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53664b4860bso20737501cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589497; x=1795194297; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=365+vH5jzaoV03AVAIK1FfeBLxZ5qDOccRvc4GPrEGw=;
        b=LGZ25M7o18bGZS+ixAZ0pW8E19LOt3Ym/UTbfrBa68RVjCzOZ+Z7A65V9gEgMyHt0Y
         4GyEpsdyqWCMz124hV2bqJE3Gol7OxCQWaTzLwr/gN9CjrUEIfhWwFSXOheXw2PRzSj0
         ogu83fqgJmHBzwjwIBZXp42GHF2gh6ZHTN36ym4vTUOreP6xtIw1WHZIgE4wJZFBXXrx
         q63nw1gIOXTip1h2snhv9f4RuNY+d60V1D80+lLqa+kiGikzvzOBrgOn84uPyDUKeJxZ
         03hxNx+0hYLHLI+UYBel7kdsaS45TF9q9xN+QUO7/sUEvvw6amALPA1pj8/TgbD2WJoB
         3q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589497; x=1795194297;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=365+vH5jzaoV03AVAIK1FfeBLxZ5qDOccRvc4GPrEGw=;
        b=dZ0ieCfLNC4oe0Xp1JBqc9RFp+LNZ0uYqzgpchc6Y1FkhnJ8tzxXNhFaJSWvzE4ShA
         0iAY8gWSfPXgSvWPCqQcvVbtml1HXorDebiLvfQkpPEnak/qlZjnbwSRDm5GC0K2PHfv
         yG6cFcpS9NTD4I7elR7d0lA7RbtcqUUhv9lZs5Gf0SrKdvdgGuVqxlFC6utIeayAvF3v
         6U9Z2jl1SiHvLF7a1/HEzbtLlpURtiOdPmoaacaR232BNFumYCcx8H/x4L2G0WzqQKOX
         YPqDC3Kyox5sMo063MldwVK8gp7cyYzSRqRNbcSDcud6HH3rnh31jD6GuidmyQ4yyIxF
         Nq1g==
X-Gm-Message-State: APuU4Z+2Yzl7tFM+ehqu6t5wLTE40Z7crPpGa0NeUSigLe3nsAHfkVxM
	lC9z1c9tg9FpMkXfClaZpgeXPneua6PYS9krtXvGASXKSAaly+eO1e4herAH0g==
X-Gm-Gg: AYBFou29DEejdn9Xk5O9uArOnpxlT1CveprYT5BBizz/WcxKA+XaMgEjysVHH+8X1X5
	9ml4kXP+uqknJe6n9VZpYfaZ5nxPRIFwt/dIVg39IhdyfdhYiUYNE/blrysaqJk39927yHCEzRp
	l4vQZolzDLWSm8CJHIlYyvZeJzwzeRWiipD+RD8yt/hUMR1UVaOKG3hhRUDAI2vzrpvymuTKl3x
	mSGVBDz9MDWdO+pxMNM01CAVKkJWHedaZLDq7g3acBBvMeLukP66dwDJ5zI9aEeq4hxzfVk0QB9
	TPJNt0jyrq3WWUGGgseCsP6vxDpaXzxeYZ1ByYHgLCYZEtJEo3Sbpe6dagz7bswsukHuqEuA8+X
	YxmQoEGn1xq3dvu29iNP8Y2YrxGnYkgukKK1SQkxVOlasjLdz9PQvD0Fe+NysWhxBaz7RAKiN89
	r3YkwmUrF2k5YBgFr5vUvq5CTSjmbwLFkC88slke6BxpuFzxursRn2/+PBdGrPDHQmvUg0pnHyQ
	eqEQ79Pw7GWmyd/XEKGNHJ7EhACaCKb45DjUxyX2ASzRp/P3jfcxFkYY1IA0rT7nwy6gu9kvMYe
	hGG8FCMYDCAik4ac5O4EAU7jBpC4yR80Mo5nXUkRA/+DmPjWCRTS
X-Received: by 2002:a05:622a:2447:b0:530:fbd1:6094 with SMTP id d75a77b69052e-55ac837da03mr46204921cf.53.1794589496777;
        Fri, 13 Nov 2026 09:04:56 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-120.compute-1.amazonaws.com. [3.41.210.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a2028dsm21859271cf.11.2026.11.13.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:04:55 -0800 (PST)
Message-ID: <6af74337.0ee05534.1a96ce.17a2@mx.google.com>
Date: Fri, 13 Nov 2026 09:04:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6342637518722085568=="
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
To: linux-bluetooth@vger.kernel.org, bence.csokas@arm.com
Subject: RE: Add struct_offsetofend() for pointer arithmetic
In-Reply-To: <20261113-offsetof-v3-1-714df7053893@arm.com>
References: <20261113-offsetof-v3-1-714df7053893@arm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6342637518722085568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210733/

---Test result---

Test Summary:
CheckPatch                    FAIL      5.48 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 FAIL      0.21 seconds
BuildKernel                   PASS      20.32 seconds
CheckAllWarning               PASS      23.04 seconds
CheckSparse                   PASS      24.39 seconds
BuildKernel32                 PASS      20.17 seconds
CheckKernelLLVM               PASS      20.32 seconds
TestRunnerSetup               PASS      478.36 seconds
TestRunner_l2cap-tester       PASS      13.63 seconds
TestRunner_iso-tester         PASS      11.71 seconds
TestRunner_bnep-tester        PASS      3.19 seconds
TestRunner_mgmt-tester        PASS      83.75 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      5.45 seconds
TestRunner_ioctl-tester       PASS      4.53 seconds
TestRunner_mesh-tester        PASS      5.48 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.24 seconds
TestRunner_6lowpan-tester     PASS      4.41 seconds
IncrementalBuild              PASS      20.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/2] overflow: Add offsetofend() variant of struct_offset()
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#293: 
new file mode 100644

total: 0 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14980452.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/2] treewide: Use struct_offset()
WARNING: line length of 111 exceeds 100 columns
#421: FILE: drivers/gpu/drm/drm_edid.c:3254:
+	BUILD_BUG_ON(struct_offset(descriptor, data.other_data.data.range.formula.gtf2.hfreq_start_khz) != 12);

total: 0 errors, 1 warnings, 437 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14980453.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1130

---
Regards,
Linux Bluetooth


--===============6342637518722085568==--

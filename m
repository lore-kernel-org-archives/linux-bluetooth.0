Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586A380FC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344892; cv=none; b=r63Pk0L7RtNqehtplo7gIkOW5wJb/xeOn6P5curujzbYd+EnE9/K5BluU1lusWhnjAY7NundXVXwxoG7CfZjaZiGaRY+fvQjJ60d7G99P460HCQoATWbcOrU1NYjVfhq586SVscpz1OE5CBSl2mEyp+6vyM55dFNZsvbHfi7fdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344892; c=relaxed/simple;
	bh=CHse619ElJRfJ0oWzA9dQcAyufU0H8dfrluIlDm7GL0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LBjNlpYtX0HEsEdeo+cMUjmuPiTz06caoIHpew2MUWoqRLBWPJRwXL0V/KpOj+nD91OIPjfwg7FF7bNhS+XTELap3r7aJAkg85O5FRq2NSEJ7A+qw9xrVPHXDRsEsPZ1TX2CjmHIsymjh/w/z/bVIzt9n1Cv8RVIi7914wIWX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmK434Wl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmK434Wl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5218927884fso14056071cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787344890; x=1787949690; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xabY0sT+VYcEp5S+hCTVoDv6MfON9RI8SG8fo/qM5WI=;
        b=DmK434Wl7rQ6MrvYNnuW1+uncdvz3In+ijid2wVGBqY2uGz1QAv99Qet+Uug5O125P
         dHsJIJJyJ/BXPKOYOEoWcmQ4wC3zlglornd8VMwX6MGmF5M5CHpNpxGf+BVzUi9ASHjG
         OiPPlFvw1022gIY1GlRf3RPU5RmcHiXteHb9dqfD7yh8QLwFayjmxO5hO+HR6uzAmfIs
         49Riy5zH2n33WWUnS+naJQqjXCDU2POP84+YTyZbbb8QW303i2D9uCYKuLQDmKhQPpLz
         xoeL3jNfoleLLPGX4UF2/EApgk43mMt2AobgJKFK4B8KEO35pDHlqwsl83X2KdWAsSrD
         cUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787344890; x=1787949690;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xabY0sT+VYcEp5S+hCTVoDv6MfON9RI8SG8fo/qM5WI=;
        b=SQyD3zAqHM8V++iavsYBuWD2/k/q17SXRYjaYj85iPkcUUd0eFZCnxNrIXnx8JsvvY
         6v7yY/rRlKUh/pdizIpTo4zR6OwXAKm35uAqLk6fpCRAYaCSZcui7/kR2nt8qebDsna9
         GenOx1QlOgrmSVks7qV6mu71p6AEtrXQY0KSmt20yXE7H7B5t7zmEBvrkpewsL/9CWmN
         ziQaMv3EFpXaKb7oqWpJNlwX1gIYWShwZY6VVC4sJk6OSCCipGcPdOpUFSwSJDpWcsds
         ho3MFAXvetzDlogZCMYGexAmp52p8/GEm1bIG0GpcWGYxe+1oKkurkFm+rRRKWF3pkOd
         luhg==
X-Gm-Message-State: AFuF++kNtSontgConD2Z/T+5NuILF8BE5LDWrx6yob+Nbleiv1aqoy87
	EYwR3JwDbmGyd4kUSLrAmrCaqfwmwO5VTAlj4v/zfFyTYLqYWqWKn6i0rc5zRUTu
X-Gm-Gg: AR+sD119vtzf1KRm8VYQJHrzZolKYxr9Dd23B6w4QyDO55x4J6XvQM7Y7FVdKAwMGIk
	setX84Gut09v68HSs0bwwnmJYVY9zo4CWReXDMJR0i2QPp6tL4PKoyotT2tOqMTEW2lW2/21bom
	NDNBFHsBj7htoHEtkIkTvSJgejSnKko0lXOccoE6gqqioUMuWrQRvTwFbVpXWLH3RKjixggkEDr
	tsjmbnD3YgcqH3A5hPCG/LIFa99l165kEiOYeITjm0IqssONyLAQmkHb1OT8vcON577bSK22de3
	0HAoZWdXpi6/QHxJLZ2WwK11zxi/OX9MQK1+0Y1agS9EQ8aHbUJ6fa4vlfZwXTknnVk3tYRwLti
	Vv1qlhltMDS/HbadrjnC62pLrDSFTcESnfo0GkQd2bqSHCpeJRvXgN8yNTdHt+8DIz78U7Kt4gp
	i32bGKauKD02QhU0DohqhXywoeG5AooliRDchetO65eOVXp5RGvTlQPH2/lOIzCi6i
X-Received: by 2002:a05:622a:c0a:b0:527:6d0b:b399 with SMTP id d75a77b69052e-52e09d0e42cmr9355641cf.39.1787344890170;
        Fri, 21 Aug 2026 13:41:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.34.38])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09ae65c8sm2533681cf.24.2026.08.21.13.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:41:29 -0700 (PDT)
Message-ID: <6a88b7f9.043ad0dd.bfc0a.85d7@mx.google.com>
Date: Fri, 21 Aug 2026 13:41:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9181881989727587823=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.kiagiadakis@collabora.com
Subject: RE: [BlueZ] build: Ignore the test-sdp-xml binary
In-Reply-To: <20260821193120.1335629-1-george.kiagiadakis@collabora.com>
References: <20260821193120.1335629-1-george.kiagiadakis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9181881989727587823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149989

---Test result---

Test Summary:
CheckPatch                    FAIL      0.43 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      617.03 seconds
MakeCheck                     PASS      18.91 seconds
MakeDistcheck                 PASS      157.88 seconds
CheckValgrind                 PASS      229.65 seconds
CheckSmatch                   PASS      313.67 seconds
bluezmakeextell               PASS      102.13 seconds
IncrementalBuild              PASS      598.52 seconds
ScanBuild                     PASS      978.37 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] build: Ignore the test-sdp-xml binary
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#72: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#72: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14762402.patch total: 1 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762402.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2429

---
Regards,
Linux Bluetooth


--===============9181881989727587823==--

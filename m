Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AC2D94BA
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754793; cv=none; b=H/eKX/flXXKJn8NKyJ0R5Wsf6yK6j5gcnStJ6d88+3Xd3Bv7jLhMlisaaGvdeaQGXEM6FlVM1N26kJN1pwkE7npd1fwtjQiYW3bsvtejlenGahstJsaZvArNilRreSCf0IUcm7dqANJRbevUY26H+6xHn+svC7S2g9cWx2Ah9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754793; c=relaxed/simple;
	bh=Ft16hSIzhxIZiJ4CVGT+vKod9mZLQYkG1yW6UAznXks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TiIgMNPWiMwBV3b04yiaG/+L55vFQwI/O9sBQP0bwws/FyWtyFmaEIKdl9owqElOmLsungV20lN37YR2M91GUJxbguDKeCK0agVrAnMLFmgEKZWVIrZUllDh/KC0IRiuich6l/QBzC55j1v4unHLxtVWfMcO8LOjZgT/zL2HUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz0nJC6C; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz0nJC6C"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f18c0e03e3so765865a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787754791; x=1788359591; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BrN3X6QRu+bPBXEuG7RBEJJI2dQ3V/1SPi63Bh9oa+E=;
        b=Lz0nJC6Ce1g24qmCzucss6xGNo5RS/UGerXapn1tnCJO8unRFBqEAp66GEbbZBepxr
         K9yJiw6F6bIqpmwTDCCynuQ6lpme7UYFsk10aEcT6FkpCs+rEDKo511pLMg1uZI6242V
         gNK8F4yB/ONZX4fah/sYgDSVhUhpy/4BDkqR9srGmiotRpPwSCBMQFWYzA3A2vxk7Gp5
         z2lGWxVavJNfwRLNgRmfcL56I3bz/v9JjsmgnQ4bVCvN38456bSukAeWejyfsp19tj5j
         4KuYsoLK7rfqNc7lOYY1hmJFbl6oOlGwvfdhbqLtk7kfNj6+1/b5pMwXmlX/LkQjzF4t
         V9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754791; x=1788359591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BrN3X6QRu+bPBXEuG7RBEJJI2dQ3V/1SPi63Bh9oa+E=;
        b=s8ekXIAHmWxqAtzcl5sffyu4y2kD6/0MSZvE0s6nvSlxD4ORU0GzdVjAkSVMa/2Igl
         ZrfIVO5qGbH0eBoEF79prnDPn5/uET34zco2WVE4SILCn+0cIXiHtZ+DEjiIfxpoPYh1
         kJDwjUvAG/7Bqcp9H5p4Cf2aKYcKMsf1qjQazBcRZXJXaBYbEgDDrbY+rTKSxUOf7kZY
         W6JjoUWSFSAr96QCKcZZkmQgq1K9F6uH9VdLHO8tjALvcu9gi8uHBN/6Xt6DSTxwvEcy
         zhMrMhIUXvYRsLPPvTEKV2eK9eiqXn7V/eLFaJ+H54cMxAKoazb8LXYMa4xf+g3uPwRK
         L16Q==
X-Gm-Message-State: AFuF++lsFJNM848g5S1q6PT8DDNOVtyhBBsGVjp+faVEC1AzJQeNpTO0
	He+CTIQ8qnHm4wil8WzbCMGj+WTWpY1UdBBGY0Gcy06uMwLoFRj6/GB4Mpqt+Q==
X-Gm-Gg: AR+sD11znMKNCEv03aKr6B8brmUoTZSyMkGJgwWTS7i6QGFHNAKmoT4sM5fAHSlh6jK
	+Zpcm0JA3N/CeAf8FvDnf0eWMwRTS75xpEOIeL3/73cDXxvC97DVv8rkmTM9yTjhtICWl+guqRw
	Vko1a2OhGK4Sd/J2qPC0YdHUDVK4flyxHMC5f6w8X+K4bjTIEwS3klP+2PawFAfSUEwyQRMASR+
	aqMh9PmdklV+cZonPZ0XqtMhhyiYb7ZbZlmHDK5RxD/5vhuVbiL8RGir9BKY6EE2fsRb/yf0hZ4
	nWbXC1OaEMekRq5EACW6t6mF94FnWp8Pu87Z1GR9kKjQlZl5+VD3jSB6n1beKoUKDMx2m+ATQJW
	vdfh30y8ClEbdQy7KE284FY2vdwbRHuoAI+wwfpu1MUAtmXiD7vQFTCMjaV4giFLHfq6POxRYrB
	KxDGJWDtcq9NOeB7RIi5KdNWVzJ4vpfhkaxOnfzcYgWBhkh1Y9ZugIAzcbc0YogPsHjAhGEsxMW
	dFQOlU=
X-Received: by 2002:a05:6830:3444:b0:7f4:d68b:dff6 with SMTP id 46e09a7af769-7f4d68befd3mr240870a34.7.1787754790744;
        Wed, 26 Aug 2026 07:33:10 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.192])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c81d7c76sm1719025a34.4.2026.08.26.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:33:10 -0700 (PDT)
Message-ID: <6a8ef926.7a66ee31.25c7ad.1162@mx.google.com>
Date: Wed, 26 Aug 2026 07:33:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5573821501127567731=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: SECURITY: Add top-level security doc
In-Reply-To: <20260826132610.1021538-2-hadess@hadess.net>
References: <20260826132610.1021538-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5573821501127567731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152091

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.59 seconds
BuildEll                      PASS      20.92 seconds
BluezMake                     PASS      614.40 seconds
MakeCheck                     PASS      18.81 seconds
MakeDistcheck                 PASS      161.68 seconds
CheckValgrind                 PASS      236.79 seconds
CheckSmatch                   PASS      316.47 seconds
bluezmakeextell               PASS      103.26 seconds
IncrementalBuild              PASS      611.30 seconds
ScanBuild                     PASS      990.31 seconds



https://github.com/bluez/bluez/pull/2437

---
Regards,
Linux Bluetooth


--===============5573821501127567731==--

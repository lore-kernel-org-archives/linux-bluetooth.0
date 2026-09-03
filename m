Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA03F9F3A
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436403; cv=none; b=UWC8QI4G8xwvu2Qi5U+Yz2JeXkFnlk7FeXxmDePSptPzpnw3jYFXGw3OQSMSAVgvAA7Jpt7up94rhpQ09fL+Ipfrx7Z7okO6EiKMzYYXkMDCoSUbscZ5RrXJnzK5OH5N3/YOxG3Y2LhPccoeWFko/3DTcOurHWPy0fnBJtlJyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436403; c=relaxed/simple;
	bh=NzCJnyaeoaIHlln2i4iqy5wYD35YE5h1AMZQm9Pewg8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KDebfV9aFqNrX59VKDhHtUdh1I1prNOLtklvTD063Bntb6Pjt94swv+RUJ9xzCv+jaJaeehf4B3UnuZlmMpK76juUt4laWDrb3EBYZKjyH5iWsZ1FptRWGuzJoB2wGbXW8rPyvUkNtqkk8FuaHVHidvzvTyB/t6lkd9Srqd2v0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f196FFc/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f196FFc/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso2614886a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 04:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436397; x=1789041197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uNM4pYuSL9ThjFMOUK6YxrNSSseEzvL/udCpaYkn0Dc=;
        b=f196FFc/OxzaNrFfMV3apdyIre6mL5yO2W1qTBp+lm/9eCtJRuAa4H4iTpFNDIvWcA
         HRDZSiRKzUoydW8QNuth8uQrTLPwEjo5KfBVFg1ZehKqJX+Z+gbbOTnaIZwEAp2gNjIS
         OoBZH6NQa9Mu3OWYamc3lvuTszxJbCLt/xui2AhD4lD0Rrtzwp/1503riLgOs3YvNxag
         G3mpI6TUp9B29orKWNMNluJcptZDeb6oI2KnjdCqgkmZQ2Z4kaTuLDnUlRCrFHkD+DMP
         B+gc80YEXepZKKDOEYj3yKdAKw5c9OA7+WTqhRjISqwtsd6toeW8aZVP2eEsLWiYfNSB
         PhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436397; x=1789041197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uNM4pYuSL9ThjFMOUK6YxrNSSseEzvL/udCpaYkn0Dc=;
        b=G97WwmjKPAyBxlTTdVvbnFWO1AlQC/PMyX1TttjMBAmq5x6kqXrGUQbo/bAK1kFKmy
         mQvfVvYk3sIRiqvE9t6+Fhe9n+AfCcOEl3urknzaRGq6hVDT4WJ3C+KF8yICtcmzIRi0
         ijkI32BKQSoIPKSts+9RkjddIcDEF6HLfv3O4QwSI2PhKxAphdagpcE8Nd5RcNmoBDch
         S/y67FKBXhzE153T9zW6KHIpOHNyDfU+hK6g4cgB2STGv8dvsA84kfW0zKh61+QBONyj
         vNpwl9k4kcweWWuxhsJ2GdzNp2hJZ1PORj5u00ibqURY2IJ6tmC9ih73n5qxg+UnWPrR
         3Dkw==
X-Gm-Message-State: AFuF++nr/IapK3wV6SK/GMaXDClhtjf1FD6BVn6bs69voY08Qfe6c0Mn
	XwcWxOLjUSPN9lPJi8qt5M9z0QQyZUPHMgEB+En52MssqICPX6nxps4BBk4sqA==
X-Gm-Gg: AYBFou2YqkhSOf6q+ZxLgVDjiKPZRP4MFZYfeKk6A/TvIJaqna5A3v3i2zuNcH8XX+Y
	EZWGGXPpwoltaNsIwujvWfXHQG3coJfGZzExk5oEzsPe0xlEWcR+tm4S61UlEu32Psjp4RgUgL3
	aCtQWZ7Fl1aSC5ijT6RmRHlVpB0IAwW/+0steK5FgKiIbmQdA/n1yRDNtSDDiW/fIolCb8V0h4h
	dLVtuHbmhO0HD/jZBBeqAidyzcur1JVX5sTPlMm09A6JxDykr9bc2OWkojgHnGZyQ6HQp0L907A
	wx1bs1jEuMnLOujO9qKA5xYc8YO//lUQapdBjr63OyOubg8QRgDhwQnSZ73qFr4lhHgqVUB/MVc
	IWoXweGUgz60jJozhI0JZxT2uer8+K2LTStCGuq//F8xe3uJXNibpFs6vQRhlPVtifiRPpXMtU6
	D80XiscCqo/tB39r/qmIpwxlIC2fY1ou5dcdkXoprB/iZXZjDHHzhShbOoH4fiVoPifA==
X-Received: by 2002:a17:90b:1dc1:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39aee13c22dmr18635123a91.17.1788436397014;
        Thu, 03 Sep 2026 04:53:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.23.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33253672b6asm6027102eec.1.2026.09.03.04.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:53:16 -0700 (PDT)
Message-ID: <6a995fac.0137d0df.1c089.b9f5@mx.google.com>
Date: Thu, 03 Sep 2026 04:53:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1332554931343518223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/3] doc/qualification: Add PICS and howto for the BAP qualification
In-Reply-To: <20260903085716.741578-1-frederic.danis@collabora.com>
References: <20260903085716.741578-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1332554931343518223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156893

---Test result---

Test Summary:
CheckPatch                    PASS      2.60 seconds
GitLint                       PASS      0.99 seconds
BuildEll                      PASS      16.13 seconds
BluezMake                     PASS      478.39 seconds
MakeCheck                     PASS      18.45 seconds
MakeDistcheck                 PASS      124.30 seconds
CheckValgrind                 PASS      177.65 seconds
CheckSmatch                   PASS      232.70 seconds
bluezmakeextell               PASS      74.94 seconds
IncrementalBuild              PASS      505.42 seconds
ScanBuild                     PASS      703.59 seconds



https://github.com/bluez/bluez/pull/2477

---
Regards,
Linux Bluetooth


--===============1332554931343518223==--

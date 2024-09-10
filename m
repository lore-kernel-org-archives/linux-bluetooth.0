Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DFD18FC99
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965185; cv=none; b=i4unLLOh2jbgqoAm9Qz5uydUlVwod3LDinx3VjmqGtjJstiWpCbgNunr8E/rJboofULZW4Q8hDZQaPjlr69SjfezT+hpYvSCQhbKGaSTqHE9XfmPSBU/f5bScK+g3g0LwnXpsdphO3YG/Ag8cEFl2omBf8RjuL6DRsij+aOYzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965185; c=relaxed/simple;
	bh=pJ9Co8RakW3ew/RnByXju2/oZJ4BYofZuC1qiEYeIL8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k9Fgh6Ge/6NghJaJbGCsB3mPtP9bO+DEb/ZRk3ccC0/hoeMvaE9oXwNElB8/w+C+N2PIlKginEM7Tdkz+c0WXF/sLv2kpCkqzQcQ3NTktixB9hddISSRFjqMCapLARemwq56DzfuejFQw/ZBL6ksWBskLY6MHyhlb5P7sIDYeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPXWJGNa; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPXWJGNa"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c548eb3354so15160446d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725965182; x=1726569982; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XiByhbJVOFOGdp32+RjbyziMkVxiBsgIZblhnL0MVYA=;
        b=RPXWJGNaG5w6RneKX7osm6McBNkMDGQNDQM1WOv4SaltIgRPyWCnWMTOuORjPLWH47
         MEFjkODMhVoClvN0p5AW0zdm6HIA6NqxteuPZM9eXW00oF1jSTz3ufefeqbIBdi0BchK
         Q629M5Yd6Whrq0vpEJcWSjVZd1zsW1fV92Ut9GZeCm3eP2W2PCOO2oKW16RjiJ5adiAO
         tCpNrMpwzO6Owcd6wbWRAZkN54E+SABGPEVFtvTMjJXh7qFfJmqjgdr8pkOg3UuqsIs3
         Y9UHA9ZLQYqMkjmshNSiO8PPfFLdCfuKLa4Jv5m3VbLnc4vLbzqrw3RLshsrMG8hsWvY
         6nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725965182; x=1726569982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiByhbJVOFOGdp32+RjbyziMkVxiBsgIZblhnL0MVYA=;
        b=IAIpfjEewFSmXc6EvsG3hjylv2YOLI+cV1OVFxvLwqnc1K1286oEo3yYSv+8dmaCVt
         iwAUrqfWg2qbdNGM+S0kVR4wTBVKdYR/QX3Mf0+vSMxHKxfp6Qf83ZhIWgUbHjczvZCm
         g+xMVPyXjAXnFOja+9gRtVCAMPRsUBni6oDBPbowT3RyjyiZK5d8ebPCSWlziNMd9lX/
         tWPPrkPE1Lx1ffftVR9PEeHpHBwbZYsPA6bD1gRVNXpGPgEwWzCLEGZDuHfk33O5v2Bb
         E1ZaGWYuXZ0uEhSxrwTdiPlyP7v28wPntyfJelvb7IJ3zaxQhr4xPaufheyal1m5XS9h
         h+Ag==
X-Gm-Message-State: AOJu0YwMWI908tcnTn7zEMTDz9YZh7r43+SN5gET0PUdRqzEJZu+u03m
	fCtP4LFehoqhQSzhlLh1SY2Li7oBJVuIzahuEOQ4x/BjX7yIFY1cl0L42Q==
X-Google-Smtp-Source: AGHT+IGl6wfsH7dQpzIMTBckYSmEEUec2DvLsSC3bKQnYDjNEDo1txZSNiNgDkHngNIzkCSjpOJEoA==
X-Received: by 2002:a05:6214:3a09:b0:6c1:6aa0:c21 with SMTP id 6a1803df08f44-6c5282fe5aemr231722966d6.3.1725965182156;
        Tue, 10 Sep 2024 03:46:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.154.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433c3bfsm29016196d6.36.2024.09.10.03.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:46:21 -0700 (PDT)
Message-ID: <66e0237d.050a0220.1c9cad.9004@mx.google.com>
Date: Tue, 10 Sep 2024 03:46:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0311916587536735933=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v3] gobex: Replace g_convert by utf16_to_utf8
In-Reply-To: <20240910090201.115557-1-frederic.danis@collabora.com>
References: <20240910090201.115557-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0311916587536735933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=888782

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      25.24 seconds
BluezMake                     PASS      1670.15 seconds
MakeCheck                     FAIL      10.99 seconds
MakeDistcheck                 PASS      177.86 seconds
CheckValgrind                 PASS      253.85 seconds
CheckSmatch                   PASS      359.61 seconds
bluezmakeextell               PASS      120.52 seconds
IncrementalBuild              PASS      1623.29 seconds
ScanBuild                     WARNING   1051.26 seconds

Details
##############################
Test: MakeCheck - FAIL
Desc: Run Bluez Make Check
Output:

make[3]: *** [Makefile:11773: test-suite.log] Error 1
make[2]: *** [Makefile:11881: check-TESTS] Error 2
make[1]: *** [Makefile:12310: check-am] Error 2
make: *** [Makefile:12312: check] Error 2
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
gobex/gobex-header.c:95:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(to, from, count);
        ^~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============0311916587536735933==--

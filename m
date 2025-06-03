Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDB1C8FB5
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946805; cv=none; b=STsjSXyAWh+9+j6V9KSHgGOqbkhMGr8KELHwndDSH15/WJ12clfgAobthi8L/+2wJPTDvSMj4FU6cvVv8erFZFrk9khyIsKSMcJvMc/v0L/0l3h6F/D1FIOyvf1XyhBZoteCdaY5o6mH4LlIdZ8noMG9Snn3s6QnpQMAr2v8Xsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946805; c=relaxed/simple;
	bh=Pi4rditpZgn8s7gY9jCAjC9v9ECLAjIdqV0SJwiDfuQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c/jawVSYZE8VzZygGyGIRayZnpRn/q/Un7Az2b+hZBAipcGki79aQNeiF5DQtCI29rrsJiWRjSnaIBrp4Kic4tzThCkRralyNsarVu36FvguIc8qy52aWf7EAIMDtO6nV8ONiZolscGNLkEc8cEXidHDyCBxhmnVM2d53Lg70rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1lr8bPQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1lr8bPQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d09d45366dso500740285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748946803; x=1749551603; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dqLkl3itcTCF7GS7HP63scRtolK27e47CAFI9quu3I0=;
        b=A1lr8bPQcRgVZqicNpOaJzVHzsiDdmsATAUSiVDKxoLEaAVMEqwa2kmq8RWOdXvU2d
         YY61RZzXtf3EAeI1tRFRKct149e3cJ2SXydvtRwY1Dn3YpdJyC5/fnnYg291/WlNDRAa
         nVCapvaaCrT+1L2o+6YOntIZIHibt6HCths5sfLSgOAtCVL8g7GX9KXXNGQ6ht1tmCAX
         kwHdT0Cbx9RQ7eojNCZ9wgVC2Pog4s5P+FomSrC6mgBST0sekwWL15zxssb6F2wtEM/d
         IIlPr3YADe1i63Ek7X9djAKFuJlNHx5vWU2nVkPlF90JPL1ORABKYzFgA08Ll84nZyOs
         b1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748946803; x=1749551603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqLkl3itcTCF7GS7HP63scRtolK27e47CAFI9quu3I0=;
        b=pbsxDiMnPG6UccWYX46yQY5Qj/SJPfhjhN2yY5Yit0V0EKAPwyRF+34iV9rZuxiybR
         KlDbdoDy9ozPkG6C0WYcgfiGW1QZHdVP1B6FiwQv14j62jbH3z4qV+cCCw7XHwfkGpXM
         gTeZUrSwg9oJJ+ztMRiJtNYX2r4yN1nMNikrNa0UkkwA4uWAQvFQLscyi62vt/2t4AgJ
         cALuK/+cNwdIq8KzOl1t/KEMvwQyh/BOqOBYIkifzCdCdTLDde00j5MBgNase8QqBszN
         00mb+vtZpi0i59bPQ9LHCAgyHbqBwOpELULyeCabS34Soh1onm9VbfwxdeaPxe1+NDU7
         v+9Q==
X-Gm-Message-State: AOJu0Yx4G5Yowqr4nJa8F5UFdUOE2JYIdHK+n5310tFPdzhPoKnrrNph
	tLMlY8p0YljADc+GFJvHwoeOkcvoTzBcm3IoF9RWqZFDailDkHcu1De1SSV06Q==
X-Gm-Gg: ASbGncvI0Uyg6ozR6X9dkQGe1ynX1IcXyD7MFIx8h6HE6bbgRaawbsfm7CDW4ZOHhOX
	aBSWE8Gnim7qUrdVf1swf++FI8IDDxDQvPNpdo+09Kg6QSgRbX3n32vZ7x3X76PW5FjYbHXgVF8
	/h9Qox6MbvAMMRu4spbHW7UgqgEeoIK/LrfwncrQQf9eLuMtiZcG78H6Ua+CnOWUPb9o7bvzdt2
	SrqVsE0HZfgLmU3SVcyiBx0rEdqi1/fBg9nldYy1wu0lgiYS/eXRS6famHVu9O20IawFRsu3Adv
	+RnZKO0K+2GqGmhXaRSqNwvrb/AH7ErF88MzRP6nZkvJhW9ULsMYcUQgHA==
X-Google-Smtp-Source: AGHT+IFuFJrsGo2nj2IhqjWCggWy9KQ74dY2jGTtOCZQA2lxSD2Kp1SRGVx9U6FaDL8uGvP2h0hNmQ==
X-Received: by 2002:a05:620a:2a05:b0:7c5:50dd:5071 with SMTP id af79cd13be357-7d0a4af063emr2417686585a.22.1748946802700;
        Tue, 03 Jun 2025 03:33:22 -0700 (PDT)
Received: from [172.17.0.2] ([23.96.205.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a115aabsm816139585a.60.2025.06.03.03.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:33:22 -0700 (PDT)
Message-ID: <683ecf72.050a0220.1ad9fc.997b@mx.google.com>
Date: Tue, 03 Jun 2025 03:33:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5028196891757165859=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, magdalena.kasenberg@codecoup.pl
Subject: RE: monitor: Fix bit for HCI_LE_Read_ISO_Link_QUALITY
In-Reply-To: <20250603085352.1297099-2-magdalena.kasenberg@codecoup.pl>
References: <20250603085352.1297099-2-magdalena.kasenberg@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5028196891757165859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968220

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      2829.36 seconds
MakeCheck                     PASS      20.00 seconds
MakeDistcheck                 PASS      205.88 seconds
CheckValgrind                 PASS      277.35 seconds
CheckSmatch                   PASS      299.53 seconds
bluezmakeextell               PASS      127.70 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      907.79 seconds

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


--===============5028196891757165859==--

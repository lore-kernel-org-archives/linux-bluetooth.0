Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C273A1E69
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211486; cv=none; b=pp4+b66G3WVpg1QkDebvKWJUKzY03NHrjbAir7CMClPWzxb17zv8PQFYiWq38FB+yKzQugvRrxZ511EackoP0stTWlalMmOOO+csC6ZQ02Gi9ZwJ4CChu3rCkuiQTwnveAyxo6wcMZvU1uRVX5U+I7PTFNHmAWfHjvgpb/2LKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211486; c=relaxed/simple;
	bh=bEmFyupx7Dvi68h4fRKylDnZB8w9RCLpUJxIRKGurbg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YCVFqbCsx7b1UFCjBeATUF2g/meJbfWzQ+ft5htGzGybbAqFs4b4B1iAwgZi6POFnzIBJklaUpmdwYD+VHVesMQei0yapxuiOLYcHbGfEoGK9ENx0Z1Hu8HZRHVZV2jiDM/JCJTzSGEDy3oTCVr72xSAud7MpLCwNmx9DWI0UMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW//Qeal; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW//Qeal"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6249bb99so7553721cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775211482; x=1775816282; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BxUHdJjGWLiFDyHL5LSf7RRLQLVyuOQuuiY+/ZP7y78=;
        b=YW//Qeal2yJbUSpSbQKhdo6XyT6cvime5UlBhwcawiIrJbmd+Up+BVCsvFksD4TARr
         s1Pz4WmgB4hbq2e+tdAdN86q+X49/FIbgMX8149ckPRLKcmbD64LyPeLdbCZejEqQAti
         b5IFIu129t0FhzEnJaMsUsLrnlYvR78irhZ3gm91+gSw0/61E4T6Tq8ylUIEVRe1TSvb
         LX9ZapucNMGKHTs70jfWfjxQK6dyOIthMGRwrQflnL7e0iFH8b4MH3bToU0IRTRAJiUM
         SbiWQjT6I8xXy7Xy3y8tRyy1iSox5bx+CKClyNSMK219/kWgUirxP5n466gfKAx838uB
         xSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775211482; x=1775816282;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxUHdJjGWLiFDyHL5LSf7RRLQLVyuOQuuiY+/ZP7y78=;
        b=REofvnr3sY3hjvw+JGSVVRtQeAPUR3VA/lAAHXTZxeDZqE2d1YgbI2ivqopD85sdhH
         BU604Ave52m+LxBBin8hO8sAtea7j67Z0w+0Sg4ubRvLYMO031GhXkMkTVLcaA/Iewny
         AJ2JvjUgwufkPOhXvoKsfdau9Dftu/O4sEUgBhb0+gOWU4tSSollCgsHYYugHMJ93O6X
         02CBA92gq7KMFJ+aQC2zjJzqMM/fC2DHp9JF6lbtuB/CK2zgGxxIZ7TEPdeSI+AI+O/n
         racryvU6/qCw7RrvgclRKZjYCrHFZEQ6Li1CHp9TE2LOfnM4lTg7DKitz1NNVnGalDAb
         8bWw==
X-Gm-Message-State: AOJu0Yy5gdIAflq1TUtghtzMuA/AvP0Bv1VRdBJhy2+P0FSLO49Bky2h
	y9JJ6xEP5ZprSU+Kz1bIDH5ci62AkLlHl+Oygjcdi1GzkmU2Z5lpp3zxIGZttQ==
X-Gm-Gg: ATEYQzzQIztmcPCUEFtmGVgLbnYiedVDv0mrjsD5UamxfhLPniH67RoyWjL1Wj9Xnat
	/gQRuxvG6eEWWD6Io6xzzCCMzBjUMLjw4lmalngmu56CSdnQz6LBDpYNpsSOXQrJdUWrnGcCSfs
	t6Xqaj5qeBHZ6Ok0/QpSccwrOKflAcJVmvCMuDe22kk1RHiUSfe38ZiTW9+zhZ/JyYZTJladV4U
	CTpa38sjatvbsZJv57meKBwFFppgiLaqNU6y0Jwd3BzWyYSdJMIKsMj7XVaW9/MlhlXbQa/djEl
	u9nkl+ts6OffjViJoQUJVgLWWonQxd8KK4Jzz9iPRjbc9zIgxhqFQVbRqhwGNPKoRaWkjV7Apd3
	/z9dWYFx0Meps4igNtv7Ay5vbyw/fd/fYYlTk87WBC/v9GLFnz671OThc4Lyi7pTbBrVWNhLbpt
	4sZ0tjMM0aNedJHiuFVsNJbnGTZIzW4SA=
X-Received: by 2002:a05:622a:316:b0:50b:5491:ddd8 with SMTP id d75a77b69052e-50d62d55623mr32374011cf.58.1775211481815;
        Fri, 03 Apr 2026 03:18:01 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.55.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d502df89dsm33670341cf.12.2026.04.03.03.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:18:01 -0700 (PDT)
Message-ID: <69cf93d9.050a0220.21b04.28e2@mx.google.com>
Date: Fri, 03 Apr 2026 03:18:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1926069513043932370=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, martinbts@gmx.net
Subject: RE: BLE-HID/Nintendo Switch 2 support
In-Reply-To: <20260403085555.23871-2-martinbts@gmx.net>
References: <20260403085555.23871-2-martinbts@gmx.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1926069513043932370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076884

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      629.92 seconds
MakeCheck                     PASS      18.20 seconds
MakeDistcheck                 PASS      243.57 seconds
CheckValgrind                 PASS      290.67 seconds
CheckSmatch                   PASS      346.87 seconds
bluezmakeextell               PASS      180.53 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      1013.72 seconds

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



https://github.com/bluez/bluez/pull/2009/checks

---
Regards,
Linux Bluetooth


--===============1926069513043932370==--

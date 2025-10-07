Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159F1B87F2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831717; cv=none; b=OmAZushwYbwAXTT686NjY9FACqkRCaZutzLUJS6UT5KRLVnlT9VWA/PHvlBrh4Yx8SObYg0WWO1DUlZHT8ahJXDLck8l0LWASePPozqzsJafzBiZ3wHDliJh7jnTjcaUAGA8oULz8/aY3Sa9syX2Iv1apP7evufuYW6F59Azkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831717; c=relaxed/simple;
	bh=BRuf7aftXwxTwl9quL3kCRnNYtE6jOOmdwPfYq7nuBg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ud/3w5mwXPkfro+QthqjPfCLOMgkJE4Oj88Oyvgqy3ufhwEbd5OuUhEtmHG9vuV8gDaiutGS367sMWP4YGAMOMSTOKN33pHR7b5AwcsnbCbYJ5eGmQsH5BJpeVLWJlOZrNojqpe5272xEk0SkqEKTA5gdIhdP1z9FeKDgWh1DPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Myou1kOP; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myou1kOP"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-938c85ccabcso254552739f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759831715; x=1760436515; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/rJ8MuaTb4mMwkhU5NbQJpajwFzW3KWNyFudkBMn1XY=;
        b=Myou1kOPMINptTKGU9PNqnNyXf0c7vdfqNgIxJkI6n5ujpAOSntVnnmGwVRESq3Kp7
         hoXjOwuGoyY42iK3DUylOxhDd6742/NemTqKkf66RHiXkfjnlhOjGSFc37daaC+uT5st
         UHEHfVRjbFQOuqEc6xc5UNXqs6QnYbMp5Lo4dGmYbEdzHg6aL7eh9SRnbqs2j8pH0B+0
         puAWLW6RaJOqc1I5mGuPn4Wmzwi5RHbTNiVySEYXvE52vhMV9re0oxd6jyYWbiNuUT+Z
         3GV9rRQYmVBUVV+F4isb/oi/e8JCiW5rrYlHTsu8hJWhd4KqmSmAZLIDZrblkHoonCN0
         dD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831715; x=1760436515;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rJ8MuaTb4mMwkhU5NbQJpajwFzW3KWNyFudkBMn1XY=;
        b=QpspLl56LFmfF8Kr4bZgHTuZDWYGkuv8QPf+0pO/YJvBFN8jZQT40St0KYaod1JuJa
         p5p8dm/GCBpUvmxRWXkuZQjCcrJcN08BiZL10tXffbZMOp9qzEPSGNjSkve8SKBqQhh2
         44bwUQnDFRMnJeRtJ3WsxCw4lWFWgyBqzActVWr+CWZ45bAguWceXldCNtZL4OEwnr2/
         OvyoY0IOEC9qCi7S8Nk9MDsnOgzb9mDWLdtjh2dysHeMmH0j/PmsiABg/vAH0JI3iWe+
         uZ3LxNsPKw3iLblMIl5QBcZd5WWiCK+ORl/Up8BowqzlAw7+cOZU1Q08rOE/mv07SKLp
         o+Ew==
X-Gm-Message-State: AOJu0YwPEj6oUC60+krYR7YbCgJWmEDTmjNveXsz/GWiAovTLsOyWbZi
	U7RiomFEN57EUGhHd11BfXruJrIQFdH3xKOhLIYOygz4NhU5z7G57KoA4s9LqQ==
X-Gm-Gg: ASbGncveDuP2yKSTGHAq9raoVYRWd/XQu32LT3wmdEziWosG1FPnMsDFpCVpgkz8lme
	op1KDpuwmiwSijWYfHr6F5FVmaVpWkVznRMYniRitSySO1juPSaNBzSr35W5K29U473/Q7jcOED
	UYIbznmS0tU0FSm7Ixm0cZMW+pUeHLRFX8QVEg3eMemQhr8As2U0vFhhJ/nqJ8X9BzDFAiBWC8G
	f+9uJwlV6z5IZ3FVYzS0TcTF669uaMRbKfCQCTacOtKW62B28fpj/Sj2eHc++SXnBTcclquFzex
	CJGVFmWqzEPcEJ5I9ZkcjADuYzsVlwvk7/HXBkSVz1p8nxdJrHVlq+KAmtC1HaUP6n60AX9JoSC
	dPGINOSIQ3u2Z87h6HS/bE5yk/q5a7OHzBNx39tXMjFDpuec+K/zo
X-Google-Smtp-Source: AGHT+IH1k8y+tLK2N3hbhGMJF8W9OJxdpoL5LQVvCoEipEMT9iAVFF3EDiBbQ+foZPPHnh0tRclnxw==
X-Received: by 2002:a05:6602:a107:b0:918:46b7:4d35 with SMTP id ca18e2360f4ac-93bc412cf0fmr288559339f.6.1759831714957;
        Tue, 07 Oct 2025 03:08:34 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.201.52])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7e3a3ae8sm577223239f.7.2025.10.07.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:08:34 -0700 (PDT)
Message-ID: <68e4e6a2.050a0220.17eb28.9abd@mx.google.com>
Date: Tue, 07 Oct 2025 03:08:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5919168658780475437=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] hostname: Remove unneeded include
In-Reply-To: <20251007083626.1956499-1-hadess@hadess.net>
References: <20251007083626.1956499-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5919168658780475437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1008955

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      2707.29 seconds
MakeCheck                     PASS      20.49 seconds
MakeDistcheck                 PASS      184.52 seconds
CheckValgrind                 PASS      235.88 seconds
CheckSmatch                   PASS      308.43 seconds
bluezmakeextell               PASS      128.44 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      916.52 seconds

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


--===============5919168658780475437==--

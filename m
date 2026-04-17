Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13B3314B7
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440471; cv=none; b=i3RKe51gVgfoluKVurYsW0yxyjaMySRsaENTPTsdNj8WmCk6R3LCux9UftiulZQ4Chiu1An0LnsnP00carMaygGb+zOFZUPZ/4e2q7UdiYqYjY69P652+kFawjJL19x75rwM88dq9Ima1opZE0Ys3pDKOH+rP8oaU1sUbaz0xPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440471; c=relaxed/simple;
	bh=6xQDjMjB3wCLP4rbErSNrGBr7Lk4+oEo5fgu4BEshzs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cy9Tht05WK+63ERWADrBZXJW3fWE7wPA9TNYpXbtYpEuu8HV70MLcB2yJnAZZG/qMACLI1X/S1aUKl3F6yBP/aPC3oYZuUc1zYEHOOEzAw9Zg2ct5vkn7XDSy5JCVk7w9Jwa/byvW4k2Nm9uy9+85xph0vcOwsJp0teNXihPMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfhQp2tY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfhQp2tY"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso7902656d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776440469; x=1777045269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JhR05BqhUKJdGkUkrlDG8zPEcC8uNmyMWani2W6yJ/U=;
        b=ZfhQp2tYA87sZa7E2LPybbQGrC9DYX4VNBCPH+3gzGzw8bh52L4J1BCYCvRvzGhJca
         OGqfuFnA3Ox+opFX74aiQ2WNbnC4FWycuCEzvBWdK1GYuD9dEFWnyyXmsmrbKirgPh/F
         9zUsvwBxvVuIPdRQoYrOWIl1iR4jxERZ0VEgreDfoRlo19rnS4DhdqM+59AwkCsuIAoJ
         My+xw0HNu7FJdhQqdi54/PtupR9YOGYIrL2H0D96oJsA9zHYMbVL2rnYG8SoVc9tm4Z/
         pmlFQpFobsvM89U6VNKPF6nMVS7ZNwDF2usMVZ7cBoUPvgTV8kMOwjXHtBOc7NgyK9Eg
         EyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440469; x=1777045269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhR05BqhUKJdGkUkrlDG8zPEcC8uNmyMWani2W6yJ/U=;
        b=HCCPgRnEoob0OGlvrgCcEF3GGfXC6JSPgo/IgpqO0FsGeKv7DV/ks1LDZMHdggTIIo
         SvJ16/LIMsawnN/4TrtDttc3/wDgCfdV/NHb23tbUdaNHd7Sl82S15wXdfELz6I4BxdK
         qzljL8gZzc4TYlFI+yn749ZyyBmfXkXdc31a18FwCLC44I3Mln8HbdV+Oa9hKI+pFbXH
         cLjLy92XEKFYQX+Hkxp/HHW4zr8BpLX7rDFkZo6WnLDr1ZgXa7HWUcgDqi9hx+5jhC4H
         IdD1Km/MKKZMjQnaLzoyXn/8S9oqZ+DmKoj6qDiD/6mzIC2tZszkQUuNRQoYQpP+Hd4k
         QuIA==
X-Gm-Message-State: AOJu0Yy+6zGCamY4mEmXJ5HMMSaVhtXqJ3nW5RkYoAZ2CNBIyCEo108O
	P1gfccRe1B/xD0wyXxMXJG4ZS0l2Gx6K1ekqiFnxKKCWOXfaxCQE3FtUO5dVhyW6
X-Gm-Gg: AeBDiev1R953PHPimkBfcv1xQnbEKBp27jJnDmPwIHY2lKDmvoeYkHPK3LCAaksr5Wk
	bw2x6BExv8Ial9L28c2dE7Mj+N2w/KgFmRzOfPdAStBjQ/JwxefdpjS1KqnxvIG8hnbw1niqDNM
	K2KJMM2aHRTGS54DMX6fjJDfMg2nkxzVD9GcBQfcZekI/mZBlk+94puMj6rWwWUnKu6iiB/JzCD
	RnK6CfL6MysT2xgqVmlcNaV9M7aq2EL8OzGHQegMT1a2L7Ft+LGRbdazX4LHrjKfCJbk3amhKc4
	w2uRzYxF86FP4Zsv+jOmJ5c05bzDdXJUPSgQNpkRoy3WTFjMRJL/dpT9N8jshAJPKaqpsqL/1dA
	WQgzyAbx00hB4fq3qrWfej5bUXmEXCBoJbq2KuVEq46IBHjNN+QFGGsZA91W4GnT7LdByD+Q5TM
	+xXnqie1kPC9zNzl18fqg5LCptHoZPYtMGItoKnKLg3cY7D8SAEAPEbg==
X-Received: by 2002:a0c:e001:0:b0:8ae:60c4:857 with SMTP id 6a1803df08f44-8b02810c571mr41678616d6.18.1776440468723;
        Fri, 17 Apr 2026 08:41:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.188.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aeb04e0sm12907516d6.46.2026.04.17.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:41:08 -0700 (PDT)
Message-ID: <69e25494.0c0a0220.3663ac.9cc4@mx.google.com>
Date: Fri, 17 Apr 2026 08:41:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7539307486431047544=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add initial Channel Sounding support for
In-Reply-To: <20260417135604.3044630-2-naga.akella@oss.qualcomm.com>
References: <20260417135604.3044630-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7539307486431047544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082537

---Test result---

Test Summary:
CheckPatch                    PASS      2.53 seconds
GitLint                       FAIL      1.02 seconds
BuildEll                      PASS      20.24 seconds
BluezMake                     PASS      599.95 seconds
MakeCheck                     PASS      18.93 seconds
MakeDistcheck                 PASS      234.82 seconds
CheckValgrind                 PASS      275.82 seconds
CheckSmatch                   WARNING   321.10 seconds
bluezmakeextell               PASS      166.53 seconds
IncrementalBuild              PASS      637.08 seconds
ScanBuild                     PASS      926.72 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v10,1/3] shared: rap: Introduce Channel Sounding HCI raw interface support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v10,1/3] shared: rap: Introduce Channel Sounding HCI raw interface support"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2053

---
Regards,
Linux Bluetooth


--===============7539307486431047544==--

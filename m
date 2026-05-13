Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C25CDF1
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647233; cv=none; b=hAVygWoPL8Bx6JxumClDg2Msnkj0kfBo2a/smvneXTrSpUlSJOhMuJxTUl3wbIn8vyBoA++MQ8qfKBes/LRpZGeeu5y7sw4kyU1AjZwgc0UWvMfql/nYtcSjQJ6eNlfMp8J+0wPNmnv3pS83xn5JcxGmLsf78F4AZq/4xSvf9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647233; c=relaxed/simple;
	bh=M0oHtpS9kZdizn9VU383HBZZAQjwCq+M5ZI8rXhaXCM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lCO7oX8nLi1C+Y/Tz/DTY5Mlb4AF1tWtTFevICTXiWePZsHAY2OiiKnMQLd+vefWpjF6R8QbX0vhurI0fpmne8shsn9k4p7O3c+3+xRkY3g9SxONX737TETBacMUQNW/Ize9pJOtXfVapEzIDrmPIPXV6NKLaPzIjbv6f+nc0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqNUSZKj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqNUSZKj"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso58293646d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 21:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778647231; x=1779252031; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ywAxQU1RZtQ3teQ7X/SwGdF7n+L0+eGyFgjlfvtm8oc=;
        b=YqNUSZKjFx1fk6ftt6QudmxoaIYVab5PI4BEurNCY5EG2t6+RSit7rrmFBaxwZsYpS
         hhCZhFfpjEgdTZXbL4J5B70oCbUPPQIlXXti001c8VRRyMOoWVm3k5CAu5Ze9//2kmBm
         C9JKl5mI9vdZ5p8c5vsWri9Kh2D9VhGBIfUURyWoJnz7GVvdy0Gt2ykkGIfPbNYIUkpt
         ch5/Qfp5JGfR/H2frZ0NfiDzPPgA4IoLe7WsybPP3OU01cXRsobOi/J0+7IlU79NgXNg
         k3gXt6/rU6PrPo+Au8mJTIoCp8THi87wpS1UV5QDCM9ukfbnHYK1Au6kJ4KLf+TMUVF2
         aPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647231; x=1779252031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywAxQU1RZtQ3teQ7X/SwGdF7n+L0+eGyFgjlfvtm8oc=;
        b=UvrmUyJYdKSAlPw8tNIvUVmXknI31KbNb5+on0CGoNerminSSsXdhcgURmvWoWw2L7
         04TM8VUvrEwTKYOf2XY1yJX4J4y8KpEB/35QLHvuBaLKFDVw59l+EBSf5FrANndcZ5a1
         0D2USacGFDbQeQWPBKNaVSyahyC/RMg1sr50LrGG4vDOc5ftMd1OxIDHOjQppn4Xz0+K
         jWJl660I3fCmOwKnUHOSS1gEUNrf7pgtfBHqKlID047CATQpHQJKt6CQNlcwOHdI71UZ
         JvphawPzsf424/7S1PYRehto3ylcTLa+YNGHbWrKb5qlQnqFksXPesT7INOOhdFp3xVp
         m1/Q==
X-Gm-Message-State: AOJu0YyPQUc6lF41ugg49qKl44U+jw5E61bRgJ7A5sqQxdx/egQzjsaI
	XK9PyrKJXX466a4JA/cId/w7LSXM3+pzhKP7cgnlLiHYaWG3meqvNQUMbopGVQ==
X-Gm-Gg: Acq92OHEd4q978ds4qdA6t53cffuYJQEmLTv9emZ9Uy7Etfb0qrhjyWqqbUEJO0frfR
	d1WzQINERtOH5ySJDqtGF0IW0wUMLrV4lGsZvNqrl5hXnFr+uumXLCABOkAFdjHjuTtks3rtR5l
	wD5Ik2POZEQkb3i3D2Eqwm8Aq/Yef4DwMRsjdxpdLED4I9Sm+NrpofLWErN1zBaF3BbO98kt25o
	FRWM81BF2rlse5/zT8mBwA+kBlzsRsz52wrc1JYEBw92Gf942Zd1gXN9Fkt6gkXljw3eqsHmEam
	/hxOMBw99rwSc/SAgZhEVisS2TgeuCS3bB++IANsH3xET2PRMLl/BIyAueWPs2dRTsigGIRno+8
	NYU2+NSDkutTV0oLTB6FZAJDCekvgJlDoP5WybR8NhaBScWtbAP+tP6jBSeV8QXWgGfOjoJ5+At
	fu8ZYkCeFmu17v1QVDqz6sNeNOgEWfWmU=
X-Received: by 2002:ad4:5ded:0:b0:8c6:7e96:55ef with SMTP id 6a1803df08f44-8c7dd4e9864mr21934926d6.12.1778647231397;
        Tue, 12 May 2026 21:40:31 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.236.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a33f723sm142533846d6.24.2026.05.12.21.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:40:31 -0700 (PDT)
Message-ID: <6a0400bf.0c0a0220.340460.a21a@mx.google.com>
Date: Tue, 12 May 2026 21:40:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0877684119782273788=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: [v4] Bluetooth: Add Synaptics 4384 Chip Support
In-Reply-To: <20260513022008.3238060-1-kaihsin.chung@synaptics.com>
References: <20260513022008.3238060-1-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0877684119782273788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093859

---Test result---

Test Summary:
CheckPatch                    FAIL      1.05 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      25.97 seconds
CheckAllWarning               PASS      29.42 seconds
CheckSparse                   PASS      27.85 seconds
BuildKernel32                 PASS      25.96 seconds
TestRunnerSetup               PASS      537.07 seconds
IncrementalBuild              PASS      25.45 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: Add Synaptics 4384 Chip Support
WARNING: DT compatible string "brcm,bcm4384-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#160: FILE: drivers/bluetooth/hci_bcm.c:1612:
+	{ .compatible = "brcm,bcm4384-bt" },

WARNING: From:/Signed-off-by: email name mismatch: 'From: Kaihsin Chung <kaihsin.chung@synaptics.com>' != 'Signed-off-by: kaihsin Chung <kaihsin.chung@synaptics.com>'

total: 0 errors, 2 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14570021.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/180

---
Regards,
Linux Bluetooth


--===============0877684119782273788==--

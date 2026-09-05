Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D336F42D
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Sep 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615025; cv=none; b=T09BeE10rznVYyzIpyizJcKa6M1LxuOeQJHDfXwY069HFcOlc7Vhy+L3cOUV4I+NHe06txL8t9+D55ASDZHbMQ0uQfrEOD2aypEsBvOgHSScMavIrol/zhxrtTGbIaDcLI530eLsK5hHT/ycgaYQxGWJISxX0N1lEBk6N5A+lHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615025; c=relaxed/simple;
	bh=7cEp0uMVEdqkEQZnc/7kZUIDN3UxMPTkDeG22YHWPd4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XfxFpxAHG8sKWV3OrUHj7DJALIR96Im2h3iJzICPP0+89d1iGsVs1XMSMjSIEB0s8zm98iF5SO2gf/x7mCVKS8wizE8bfrOWQANN/ZQqmtTqWk/UfUPDGfaYpetgGt6XXEb4F12QOjG6JmQGcWPTL3X3knXjoad9kiPVXAZyfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwiCW57w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwiCW57w"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d5cad1a6baso18134035ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2026 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788615017; x=1789219817; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zFj5LiBng6NudOmHVa2J2/iUPR7lg23dpPXHe6TGeRs=;
        b=HwiCW57wc3ou3x61WkM71umVAJQn3kLQIg59FO0BLEBm+GNIyrwUhTHM/TrgqUX4Qc
         JD99rxu3lY37uOZdYxfQ0PQtm+Z08p1A2E9Xl8MTZhVFzwZA7eNEshb4LxQRKs3fMrQL
         9uGStpuZRW/gGWBiXrc1H9ozvBn9Moq2tY7ub3SMsmK3Iy+ZajvhI7HoxEDQhFHni/J6
         F0NulspJ4GAZc7d4GTUw/MhQ2KY1HxRIwQIcJBO8XTTjj+UmdSjWiFkUyBoVTwhUEA12
         9kU35Fu25ImwJz0/GicZnAVBipdX+UIfbgxI4+tVtBmz9zbazuPrph5tj7SJEbHEOcSa
         fPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788615017; x=1789219817;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zFj5LiBng6NudOmHVa2J2/iUPR7lg23dpPXHe6TGeRs=;
        b=ivlMWvotg1KyZaFywKzMshrRKqxOHqVFndwXC96LHWF8qBfdj61NsilmwLE7bs5sDM
         +TGISE2TS+aS4ZDhd7RBkLn14B4N2n/ZSQcbTT1BvhenJjUVB1HbvLGYE7RhtqgaF52p
         KRKJNX3QLptN4qj7YS7oa5L/H1YUZ0A3sf0fpEjhUnG/mLY9Dn9TOTAnqEOEwWxPPsWE
         EVopCF5XbPuIM+gMI3LPffANw6sA85TJXWAM2XPSyxoitHk08y4SzwZHbdFBfTkg6w00
         MbFZxjLV5G1DXoT5GlyMNmKI32KqGO6F181eEVlZ49t3Bp+ipk4F2jMfeWV9dAA3kPa2
         6taA==
X-Gm-Message-State: AFuF++lK58rruAcvY7xiBz85La9Hsgh4p3XdKIou9nuVdd5NWj2iqNgi
	STlVvapJZJbHhLB3uFms+M3nIHDgm4FbFLC87+4VWoo5ENMaxSk+A6DJMzHeXw==
X-Gm-Gg: AYBFou1NUpXK7MS7FVK2K1xBZClpUET6Wcvobh3nnQswu5Sphn3Rmo/fMgt2gKuXmst
	EdG+uWyVtntL6//xYob+MNLP5++gWzg/xNy0AdzY80goqsnm1bwPoFxegFDoXQOT2pP8U7nwxut
	AhYoevk2XWVd5f8QX+ihW3PSNlKZMeCclrauxIR1e3byYnc7PyW3M1JWb0DgUzp/4mFwnx///u9
	W3UQm4lhzDs6KV45OEbm8v2YMxgIdGLlJVW1nINbE88A7oMvy8ltTjdxVGoebDxBpDk5MtCujSZ
	qdB2utAriUUqcX/VLmD3XbfsYXM+0JH3+9/gXon2vZbgFpBXEA/K960nBNI0sQlKvXQdmFJmlI4
	QSSkqV1mhiuEj9+Wkvy8OrHId0S+EUubE5J53425GyhqzrjeOiSj4Dow6VOBeu80iT6RTA78e6b
	Om2CW7VivM0GfA0P0qhhGGsasfpKzIQ/jMtmViBwsa6Op0jKnr9aZM5G4xoVr5s3hMkA==
X-Received: by 2002:a17:90b:4b0c:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39b26121f6cmr19018108a91.2.1788615017406;
        Sat, 05 Sep 2026 06:30:17 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.217.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432441f5f2sm15771908c88.15.2026.09.05.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:30:16 -0700 (PDT)
Message-ID: <6a9c1968.7d702ed2.4490f.6da0@mx.google.com>
Date: Sat, 05 Sep 2026 06:30:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2187530179048072032=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nbn@sj.dk
Subject: RE: Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)
In-Reply-To: <20260905-startech-av53c1-v1-1-3385f9bb220c@sj.dk>
References: <20260905-startech-av53c1-v1-1-3385f9bb220c@sj.dk>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2187530179048072032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1158610

---Test result---

Test Summary:
CheckPatch                    FAIL      0.57 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.62 seconds
CheckAllWarning               PASS      31.60 seconds
CheckSparse                   PASS      30.19 seconds
BuildKernel32                 PASS      28.04 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      517.14 seconds
IncrementalBuild              PASS      27.27 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14793004.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/708

---
Regards,
Linux Bluetooth


--===============2187530179048072032==--

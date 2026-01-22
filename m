Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF793559D5
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076440; cv=none; b=DHCld1o4EtKwxxyrmaCCXIBzHtIUDm306OqEaBY0sPUcj1socwBfu8zWmcJP2syLU1pdd0VhsiukQnuxkoHG6o2e+Fe2GwxkJvzVHfm3g2QRgi2YEy/UX7HGTD5hOhSdmv7mpbdulqb9tbcR9LMJTIbW+C+zulPYyj252KHXUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076440; c=relaxed/simple;
	bh=EGBNgW5MyeX5DKdu83+XZC430qHxasDxWHk1FQNcs4k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OvNICUtLC8m3D/r2bwH7Ri8XXuOFtrkhXemLGKIeQs2YFKjsxowRp8dKYiPBwRM6ewbgMa2quVEAYCloWqq4ZIvlwxveAJzgBOHxK5eyt2EN3F0aKXdT9rHnOQ2nFu55ax7BqXmDoBBi8xRmmNh51nMKmFAS54Nr7VBid8OEkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0gsSZpo; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0gsSZpo"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1233702afd3so1237019c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 02:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769076438; x=1769681238; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eTPcw1WPkPDoISL6FHWpMWHTyBK3gcxiHb4vMqfAP0c=;
        b=Y0gsSZpoKHWbh9/yQdk2aweKhvtES5KVO6q5dtHwRsWQ7aZpG3JSfS/O5XtG+dBucF
         OHcn1efq9wqA1TV6nho8Y4z4yMCkAAcFWO7HTAVArdZ7+meWPPSqGmhIU/usHeKisAQ7
         7OER4S6guxv/N2Ifoe707IKgUWbZOioZxb4+JxjdX8JbYmZjDWtjrJOKd2QvaNoRgBbq
         XnZw/W6Kt8Tf2m5WVUNpBUwWqNIIZKoJ+ZSqdZL4rTb2SvWrRWQCS7agRSDOK/ZmMev2
         qLCZICaxOpPDdiviCCyeQzHuwhJv1HPOBuAw6upGxOhV+lCBZLJCByYenpaIsOc6YhQ8
         ypbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076438; x=1769681238;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTPcw1WPkPDoISL6FHWpMWHTyBK3gcxiHb4vMqfAP0c=;
        b=GbPJw56/R5SbUQfYrqY+aPg8wHpv4NKQ5AhLeishHq4VR0AGjF/IQtdwyp/E5bD1Mp
         AB6I3PXn4sbuW/3jH3BciWXQKr8kfd+OBYJVfbTcwywKri9RZkUb5nF9f8t/d14WQKbJ
         UJPojD+MZxDjQMtcUU3e9Ld4I0CqZ9vXI4xkRjpM3U0PNNto5epTMVhcMry0uPtEor7+
         ZpeXpaHXpdlX77wbn+Hqfpt7TjOi5SeVOollrwLBJ8UR/O4PlunQMVgxza8x9dOHYAul
         Cgu8RySifTX3D+aR2ZX9eYuheC35xUpfRhK4OPg2WLOR8RVtcPkV3lVp6ZneLGq8ise4
         mPvw==
X-Gm-Message-State: AOJu0YzylBtI5pIfZj3L4VTTZQ28L6OxnFNmcT2/1GV1M3RkoPIDPi44
	xUTuGZ9Z2HpOOMMy8WoqUsx5aRdD4cAaJg4ZirTdZqbGe3wDGAOUfxbs0DjLtTsJ
X-Gm-Gg: AZuq6aIAHPY1wqzV9JpITeZs05EGV0eQ/tiicbHJe0cLRe8BthKMxxpZnOwZJFBpolk
	xjFJNr5wmbwR2dMK4ONQ5/cJ9dQtsc3u/ttfjAxVJS70sJ0u+j8z+wNRFWr0jOEGbJAqdlh/v8P
	xktFPV6uMVRQZXT/oni+0PXZGkiqQfuYqc5rpGY7FW4DaxVQp46eY4WUR9XijQMffZvJbLJhxZ2
	rOTpRuyNgWWE0RqHjqxd54jYQNonC63nDrO+9RG5X4dPj2M+HARcPzZJVmjc9mVB9Bhmu+ackuI
	apl+xEqI1gx+x8bVDiNrzI+sLLGz8jCCpOQIdXZt+MG0D5743dCd5bAAwzTO0Sl/lHRaujOuMnc
	n02ehGSqrGmW76EBpzI0OccLdyTu3q7I8COR4e9nE7U40m0Ed6R87+tgatSOBTInSxqWX+AKTOv
	Mt0sYo76WxjiPAQIsMXBM=
X-Received: by 2002:a05:693c:60cf:b0:2b7:2ae8:9af5 with SMTP id 5a478bee46e88-2b72ae8a64emr560396eec.21.1769076437783;
        Thu, 22 Jan 2026 02:07:17 -0800 (PST)
Received: from [172.17.0.2] ([172.182.200.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b71ccf2c95sm4532301eec.35.2026.01.22.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:07:17 -0800 (PST)
Message-ID: <6971f6d5.050a0220.6771.af19@mx.google.com>
Date: Thu, 22 Jan 2026 02:07:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7090741786777288786=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Port text docs to RST and move man pages
In-Reply-To: <20260122091003.398400-2-hadess@hadess.net>
References: <20260122091003.398400-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7090741786777288786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1045561

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      645.56 seconds
MakeCheck                     PASS      18.65 seconds
MakeDistcheck                 PASS      242.83 seconds
CheckValgrind                 PASS      292.26 seconds
CheckSmatch                   PASS      352.60 seconds
bluezmakeextell               PASS      185.14 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1028.74 seconds

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


--===============7090741786777288786==--

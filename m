Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19206405F7
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713008294; cv=none; b=j1IvnTs1lNKqUUbIxBvgWfmEsWubzAZ5eocJ6D2ZsZwz/Ca/jd4pzOOu5AVK3Q7+mPhnkyM4xHBHUZ3weW7W5JGHnxEqz0VzsdoxYQAaoy9GDrykjM+mAnLOGnmH/WGFHnlGGtCwS/ZY+/oUJP7mAcjC2TO4Gdn8xXx9khUBhr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713008294; c=relaxed/simple;
	bh=Z0IFpFa6v3w4WJ92aEfXSV+h74l5jFMAJwyOGk5vuxo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SorBk8+l4ezGPRAdlMu5k3NX2bpihg53SZD6A7hJ4EhiWIb5jP3L3Pm8dy6taNDl8nOZTYT12Wfj1xqekz22lmHJjqrCsJpr07XGXMrfsilklr42/TioPi1D0qLFfVWDdOP1ZRXh2QVcVrcptvZv2wEZ6gyhYHq89TXm9/crH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuAsEjdm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuAsEjdm"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61587aa9f4cso16963837b3.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2024 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713008291; x=1713613091; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YJFRldS/jPMOPeffOP7QWZa/tDZKCq/mFGUp07mKHCM=;
        b=UuAsEjdmFi3xB0iYEFU7hZ/wowZWtJo9ZZfRtp9D5vgB7/xsL5YTNlA0LsoaOa6M14
         DIPehe1Tyda87ep1UGzK+X6pGsW4mbwaBS/D+mCMr7jrONk/yQFzc9Y+7C8ZjB7GZhsR
         21Odg2xhBIcnBNS2JddalP8hkF9ZJCFa3cvV2hQuNGShYsKQ2n5ftJzJHHomaUBbmMX2
         OLUgbWsPjanBAOJiML6UuFnpSjGkajOekkZ4GT/GnwqOnQgTJdM3hWP8wK1xyV86kUMI
         sgcvx+9uyvja8srnJR4ULapoVyH2hMxh6XC2i3tTZQfL/qrR/XQLFZDRPS7ub/jbzYrY
         50rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713008291; x=1713613091;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJFRldS/jPMOPeffOP7QWZa/tDZKCq/mFGUp07mKHCM=;
        b=STfPsYNBGwPONNwYxInvDRCZS2bjSdY/9yw9vlbj4vVf7stEyiT6KmEA0iotVazF6X
         0EtPDAm+P6PQCrI+kS74awzA5OzG4uZWR8ltPTP/EyE9bf2VU8DVS7nWlY6NzjrCBO1j
         aZnFE2LJeU/2ebDTm7i8BNDVb228T9c98XaDzqKihScF9ByjhBoe3BJLjcu8xjz5eyQa
         PKna44xwl1QoNvdUT1p7+Gb2C2Mq/+AguY7cKmPznF2fzfjL5oS98DDpnRwYp0gQhtVC
         vvjCJIyLJk21bYIaqkq5Qy+ZR2mt13M8aFNOXoAFcM90divk5u7NOPUyEDnt1dl6L77b
         J3Dw==
X-Gm-Message-State: AOJu0YziSiLK8/qR6lE18jIzrs4L92VUysam4Te3RQ7JoWRDl2X1LtAf
	Lhwc63aTc+FIkb4KNyDDWC4vpm068hsnryxqejpF6WWG3PlAcuOJy0o/dQ==
X-Google-Smtp-Source: AGHT+IHmaINHUHpBN+m5ca1q3ZSDwdcNtT+xdCF05eXyxlkE5w8PMBtLg3i7+CX0U4saOBpNWtfstg==
X-Received: by 2002:a81:b106:0:b0:618:8bd6:abc5 with SMTP id p6-20020a81b106000000b006188bd6abc5mr3123026ywh.34.1713008290818;
        Sat, 13 Apr 2024 04:38:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.174])
        by smtp.gmail.com with ESMTPSA id d14-20020a056214184e00b006993ddfcfc0sm1803548qvy.38.2024.04.13.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 04:38:10 -0700 (PDT)
Message-ID: <661a6ea2.050a0220.348c0.482c@mx.google.com>
Date: Sat, 13 Apr 2024 04:38:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5265347364742300245=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] set: don't modify input sirk key in btd_set_add_device()
In-Reply-To: <b468e20424d271295c84c72059952acaf65968a5.1713002640.git.pav@iki.fi>
References: <b468e20424d271295c84c72059952acaf65968a5.1713002640.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5265347364742300245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844243

---Test result---

Test Summary:
CheckPatch                    FAIL      0.62 seconds
GitLint                       FAIL      0.47 seconds
BuildEll                      PASS      24.57 seconds
BluezMake                     PASS      1686.19 seconds
MakeCheck                     PASS      13.47 seconds
MakeDistcheck                 PASS      177.72 seconds
CheckValgrind                 PASS      247.89 seconds
CheckSmatch                   PASS      352.18 seconds
bluezmakeextell               PASS      119.70 seconds
IncrementalBuild              PASS      1507.66 seconds
ScanBuild                     PASS      1014.47 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] set: don't modify input sirk key in btd_set_add_device()
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#103: 
0x60600001c068 is located 40 bytes inside of 56-byte region [0x60600001c040,0x60600001c078)

/github/workspace/src/src/13628665.patch total: 0 errors, 1 warnings, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13628665.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] set: don't modify input sirk key in btd_set_add_device()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (91>80): "0x60600001c068 is located 40 bytes inside of 56-byte region [0x60600001c040,0x60600001c078)"


---
Regards,
Linux Bluetooth


--===============5265347364742300245==--

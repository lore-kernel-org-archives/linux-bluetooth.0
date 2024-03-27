Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781765695
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711514306; cv=none; b=Vt8npofEdLLQ6bu16rEL15zV4jdb69+0BCm2jfP2gI1s2DLr6PdjYmJiDIcu1XIw4WUPMK1dzBkYT1aQWPmy4raU1c2NOL+/3kpMdGYJ2GAbZefz//C3o8HjOrkRLKlAwhsEimzzfkk7B9Apb9Ulb2atHwyY0a6GOpcErcihClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711514306; c=relaxed/simple;
	bh=7K7HXdU/bPYISsBmbdS3shRRxavcXXzEH4W0vcZfriY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LTBw6tgYBcVM0JcgV7KrFr7XozOQkk9VbJd1Hfj+O8vZJ2SKJHMSGlMH/om1tgVmH7b+QJ7JX4yleewRy7qt56u4G0hgIVYsH3dnaWTOceqJXumWy2wydJnwe2z4HOcU1ql3ptod95XiRq3saN+Ura6OzN9lgwnTd6+s+kSfRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k94cMSJN; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k94cMSJN"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69185f093f5so43656716d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 21:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711514304; x=1712119104; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kwN6srxeVTrtFSa6V54H2P8eQusoEi4GuPBaZF8wa54=;
        b=k94cMSJNaPDBbmqGxvS9wvoiZmRsQfYhu4FRUgxItbZG3MGLJwI5Z+2KevkuJIFJc+
         DQhctMqiEYvFVSGVWdBsZnHIt+OKGo986G+Rep8E5/aS93L+EBP3dHkxVHg7YEUhVa2y
         al0wztpHfNjkaDamECrow6WdjzzlOr8Tb9EQKanXSlxsbvqWsNBO51R7W8I7SvsWQG2b
         YTymBdrTfK+1dWENEgFj7uoUU/Js1ex67EF6XUkDMGhxWqfUdU3MumSNdKnhqTcBD3t7
         xDq+i4aBJBsWZvrku8AZ6yAFX6eJy1Q/E9El1Dq6bnTL/NzUsTJtsaPOa4Tc0QTPe7ZX
         nIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711514304; x=1712119104;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwN6srxeVTrtFSa6V54H2P8eQusoEi4GuPBaZF8wa54=;
        b=lU3T7lS7Fs49Fw/pJyYmIgG2qUT0jPoxcFEvRdFAY/5tCvCpJdtvAhpP6iW2Sylbdk
         4vCxLNjSfZpQzleTjmiXIaT+vNZLO8OE7bdLwPhv+lFo48qpWuyJHA0vtXzwijV72UUZ
         cl3hf8n5S3cfIsACDFjodSLGUZxrKX69ETKFeB1qefnOYwJ3++Zc44U15/q4YNKAVj61
         rkqYj3FwuACQzm2dBiUh19Bm2Z981m/5rav/3OG+dxEgPoqQDUdIe3T1WCiDz2PJ+a/D
         Um+VU3n/laMbaduim+pXO0tIhWpbH3SxHagJd8K4EYdjVmVPh4iAgSo/RqDbDooFwUrO
         4wGw==
X-Gm-Message-State: AOJu0YwqL8/ugsT6z5Q/nBHOvmu87O41kViMPG8ofGWUnFnPyDaAdC5v
	pMV9DnMnlaautM/rkW3txqMGQXV15pbHnHZ4gA8S5BQDPIK7GL0nCQoJg1Jd
X-Google-Smtp-Source: AGHT+IFAhR3g6dnXXfjHrkC6ouOPVfnE9i+othCg7SnIMLcaqtPkBTjnYTcp3qFvGIfgGW88u3HUaA==
X-Received: by 2002:a05:6214:2682:b0:696:95f9:b15e with SMTP id gm2-20020a056214268200b0069695f9b15emr1575432qvb.2.1711514304162;
        Tue, 26 Mar 2024 21:38:24 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.196.146])
        by smtp.gmail.com with ESMTPSA id u11-20020ad45aab000000b00690fc99a836sm5851564qvg.105.2024.03.26.21.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:38:23 -0700 (PDT)
Message-ID: <6603a2bf.d40a0220.e7205.f856@mx.google.com>
Date: Tue, 26 Mar 2024 21:38:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1432543029563326692=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [BlueZ] obexd: Fix "Size" use g_dbus_emit_property_changed_full() to emit
In-Reply-To: <20240327024306.575116-1-youwan@nfschina.com>
References: <20240327024306.575116-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1432543029563326692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838667

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      23.81 seconds
BluezMake                     PASS      1610.98 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      173.19 seconds
CheckValgrind                 PASS      243.10 seconds
CheckSmatch                   PASS      343.73 seconds
bluezmakeextell               PASS      122.38 seconds
IncrementalBuild              PASS      1481.71 seconds
ScanBuild                     PASS      960.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] obexd: Fix "Size" use g_dbus_emit_property_changed_full() to emit
WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#224: FILE: obexd/src/manager.c:534:
+						G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);

/github/workspace/src/src/13605502.patch total: 0 errors, 1 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13605502.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1432543029563326692==--

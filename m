Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57E331EB2
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786831500; cv=none; b=CCVpfmN20OpSj0PUJk93mv6P8X3eG5adPFDtTHIYmsan5qxhgpRyIuBJb3KfobYt3TlzlfDDgc0daGlhxhxROwVMpMMfaeGpE0yxp6gkK7SnbxTRLDKaC6IRhU/1v3AS6hEwwTicjhTsWn+iTyvcwgFdKmuGmMVCFHFzCmG+zE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786831500; c=relaxed/simple;
	bh=kyxW1zmz7vVYRETCOiFnTiHslufQEer/ajDHnN59jN8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b6u6S+Mb9pHqH/KaozqgrU0AQxKhF9EnFON+AfxlFZfY3nrnjKGGpN17aJSB/Gr8sJkO9LGFsm+QLwvz0DPDAfxBq03rxvCOVgeXEKyGRMp6RCrEAbhUw7xbquQugHkqlw/8iOhU2WORKPn7YzdAcbBS37HMCBnmHFZw42HWypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGXZWwiO; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGXZWwiO"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso2209486a34.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786831498; x=1787436298; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JM7bKfzB2aWJss+d+qRhxTLDY5GYrmJrdsQjdhlhzI0=;
        b=BGXZWwiOkrc7p27MGLF4Nod/t1QU49tDXCk8Wnds2+nus1Wj7Rao5ub8p0q9uQeVrA
         +EXB09Odww2PtkCHZad+XYE8su0UqfLXM8C7hPUNgBGcJMSKMaPWM7nIZyH0VrKicnlc
         lg1behX/pX7N6TvcyrS90IxSISH6zPISinpSdWL6vLXgVRpHjrVrmb8T0HnGoXGdwzVV
         +ewrkxDQmf+NxH+fTFPqiSf/Rp7H/uI7kuW6yFJeCQ7Yj7XdKY4zlv7rRp3OfK667lad
         tHddhzCvaJpqM4Sj10aJ76K4HPwK7+rKuEGCVrCfHpJw2ZJSZKlUerNlQiS+LPxW+sp9
         +J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786831498; x=1787436298;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JM7bKfzB2aWJss+d+qRhxTLDY5GYrmJrdsQjdhlhzI0=;
        b=pOky6AyTM094072CbdIlsquyUaZ+Azt5ut73o2ZZw+vRUn+QmNRZt76pFmQbd4qezc
         EhQmNkUwkTEfmXKzC45+FMjicftCfYYRFxjP7PIuEbBvxKdgGKBoLj2MvxAKPDMLOVWI
         FERQcqUBLolVBlLZjYlUKFQvLu5FOD7XdUS2DD9aKtH99NX4t7+o5ctE87vTctgY/wa6
         AGAUNniwE96Yw9EkZFy5qTP+skTGDHnY8pL+ZTX7DNwEdAC5UNluL305Og5v8DCBKTfG
         /82AQHNpFzPY4/1OV9WgTOQcak6DDjU8Gl22jTDhcBfFj88TDZqWeRTr9/3WA3ajqg4P
         Y9xg==
X-Gm-Message-State: AOJu0YyrwywG7nvtWqRDarmgsI4zTjbAQ8zMvmHs9/uwnRyNgSdhM0DB
	OtumDRTgOSj5jOGcLLL+ziymc9VBAVC6ikbigxyyOT19BR3uVtp4Mw66XSF26AkZ
X-Gm-Gg: AR+sD10jcYiD18IfVFvZ+repLoO2SXA2urF88BlyvI19lHOtipwhQ1Os19RWe/Tjg+b
	1W2h9H9DL38zQ8bOt7iLwn2iLZeNYfw0Y01Wyxh+r8An3L1hOsGQuOkZ+kkmaoZ0ZHB0Xbbf4UK
	LE5mPXCVzmqvGARn4nc1ALKe/kcawx1TI2/yMMLn7ZXRVQajFLY7wOsuU5B+nEfn2w/g1tt4jmf
	1dIPbUw/7xFfVBLTKlo5g3yx33q6CpAfmoZAhIMNnWHP4HhvkpRMA4zyDExtkCN18NJMAJh1LPS
	y85M0/yMThjVxpDeyYSOLVUY1AkjRzfWj9rAnvBbHZxRNCJa3lGCXyI8yw28sfo4Xg+L80GY11o
	1VoIx+RMKGWMiXkBomv42lic9WPUXKZcFoIXYXBPuST63E37rN59fAJArTIXfwkQz5qH5NraBBr
	j4aUBUgYIG5w/+M5ys0xr1YNfPTg5OojHqzPQzfx2IgdbeGnhDM+yos6HdYCfC5KHZqo+C
X-Received: by 2002:a05:6830:3813:b0:7e9:ea28:4c1f with SMTP id 46e09a7af769-7f3de65e70dmr15431361a34.8.1786831497891;
        Sat, 15 Aug 2026 15:04:57 -0700 (PDT)
Received: from [172.17.0.2] ([128.203.190.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3f97ea94dsm2217245a34.6.2026.08.15.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 15:04:57 -0700 (PDT)
Message-ID: <6a80e289.60a87ef9.1a73e8.db0e@mx.google.com>
Date: Sat, 15 Aug 2026 15:04:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6447164399216808097=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] media: fix wrong argument to lp_get_uid() in avrcp-player
In-Reply-To: <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
References: <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6447164399216808097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146603

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.47 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      575.14 seconds
MakeCheck                     PASS      3.80 seconds
MakeDistcheck                 PASS      157.59 seconds
CheckValgrind                 PASS      154.82 seconds
CheckSmatch                   PASS      307.51 seconds
bluezmakeextell               PASS      97.74 seconds
IncrementalBuild              PASS      586.80 seconds
ScanBuild                     PASS      894.53 seconds



https://github.com/bluez/bluez/pull/2405

---
Regards,
Linux Bluetooth


--===============6447164399216808097==--

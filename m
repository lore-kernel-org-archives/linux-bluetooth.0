Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7C82876
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702238; cv=none; b=SbIK+3pCncW2oZDWBDXO/Tg/lY1ZOIwlBsIL441b/Z0wt/L0MkbXBSoNM78jtJWijKmI/YeqbeHZ14agcK7J/pS2C2u9q3PKOUzuAdFNwOTByc2mbEfGc150pdPYojSPFIkflFjg53cNlReeqrzS9+CrGqciJ2zxh6syk93i8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702238; c=relaxed/simple;
	bh=sDjUcLRo3HJyQoeqPid1xoLuNZgnuJII9SkM3W0y/9o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pO1SrCUcLdx12vf5+xfQNCkN5N4EXpORtmwJAXM3gINx88xlW5v/48eULnjPXm9gaR4FPgI3dKcidehOJ/SasVsOEg1rmS0FYLGwHIx9Pou7BMyDe/LVqGvYl6HHt86eb08LFjcntruVMokSyRkzLCMCXbisxxsqDIl0ORM9lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy2ti2Ge; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy2ti2Ge"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787b5c68253so36347685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 07:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708702236; x=1709307036; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5iY0RQJjv8m71H4MIgpiCi2i/xUEo04jWpyiFqfv3S4=;
        b=Gy2ti2GeJB/+4kczRwc0NW8ssje5JDgIfHqXtdiMATzmAkf0LZp0IfwhFbF6d4W099
         nFVJGP+UTmmSpzaw8/Fp9tThnWV3uGYTRSa7OyzCAr+/RypHxSQ+CQvemooLbh1HznDs
         nGbCgXtdrsE5tj3mRiQaduAhbgbJ0YtSv6AzsJrcOqOHeRu4dznCUQNB2FZXywYl0gct
         6b5OHtP0Q/GjKVXGp92ISHF/ZSS176DkETMkNBBBbwief3w3TshzDxxhWsDyEg30VpxK
         wcGpgFZfApMuWbdRTYi0ZozZ5AHLFWCgNyHA9ML1aS51+luDL0+J0lzKm5sG5BN1KI8r
         ePyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708702236; x=1709307036;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iY0RQJjv8m71H4MIgpiCi2i/xUEo04jWpyiFqfv3S4=;
        b=Tl6jU1iKg93ItA3uwTz/ajzr8/BqpG737t0vnEPSRIUVfNLyhcBh0vGYsjSj/S4jOT
         wvCrYFdwfvA6F7OLLo83IeG8Q3lb5Gjybm+ylBbbb5atsaBYS3NW7WYwvyqi+OnBz75w
         P2E5iDd/LhdUQiFCzGK/jXgknxTnzBCRN4/5eSUmGa/uyEEzwiVZG02XzSccBN+GXAIF
         o4KNfraqIA00NfpxqPL6hBwJaP5msZ3St/JTGQ3nqdF8jMvtQKd4UZEs13G1jD0+Mo5E
         3Ao+HT4czcstMW03GPu1KykwmeOV8ts//IdFxfL8b5TUjJ7LLpW04L0kDnto/wDy71Ed
         mp3Q==
X-Gm-Message-State: AOJu0Ywf8HtqnGrwBE8HQ5nE07qIyFI+2HcNUPmZS5x5ZWHopag8Z07i
	XTcKuMeIlKRH5g9yZrXjJnbSCNn03XRryVheEppyXzOaOqC1YYSSJh/Bm0pZ
X-Google-Smtp-Source: AGHT+IFX5cwh0K1/s1Psu1A6z41YCblkQ/ggUWzF0hrd2GsUosiKaxSqyUxNHvJ8zx84IM66huWbXg==
X-Received: by 2002:a05:620a:5658:b0:787:bb73:b637 with SMTP id vw24-20020a05620a565800b00787bb73b637mr138327qkn.44.1708702236051;
        Fri, 23 Feb 2024 07:30:36 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.97])
        by smtp.gmail.com with ESMTPSA id os22-20020a05620a811600b007871bac855fsm6526953qkn.47.2024.02.23.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:30:35 -0800 (PST)
Message-ID: <65d8ba1b.050a0220.f26f3.069c@mx.google.com>
Date: Fri, 23 Feb 2024 07:30:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3002062129169561218=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Fix crash when unregistering bcast source endpoint
In-Reply-To: <20240223141609.27181-2-silviu.barbulescu@nxp.com>
References: <20240223141609.27181-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3002062129169561218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=829116

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      23.94 seconds
BluezMake                     PASS      720.27 seconds
MakeCheck                     PASS      12.00 seconds
MakeDistcheck                 PASS      163.14 seconds
CheckValgrind                 PASS      225.71 seconds
CheckSmatch                   PASS      330.14 seconds
bluezmakeextell               PASS      109.14 seconds
IncrementalBuild              PASS      681.46 seconds
ScanBuild                     WARNING   956.79 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1145:2: warning: Use of memory after it is freed
        DBG(stream->bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1698:3: warning: Use of memory after it is freed
                stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============3002062129169561218==--

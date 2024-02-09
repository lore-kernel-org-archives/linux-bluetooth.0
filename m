Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D52E632
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510405; cv=none; b=q9JBs39iX93QIGzvHMsiGS5x+I7NpLcr50uYjG66E4SEUQuZgkydkq3OPt2pB1aAGlOP2a923Sq+7N3BFzEkWk8Xrq34YUiZiIWEcnUk/uAM2JK7t74MoVfh3KOdw2e2zGbBHleK1Qz4O2TBAcv/if7gucytcd3qqphQJNgIiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510405; c=relaxed/simple;
	bh=dCSgZqYn2ZT1tyQmbMxxrWLlrts+X+PkeKwxjaBljlM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HhU6kavq56fwWmXUTu5L8K6VR9xOeJGIV9H9ta2Q8dpBhrLDg62GENsW4jzITdMTjISCvJ3zHdTR4nmQ4BsMpWUnjIii7/7IzN/pz1OwcGs+Xwm2fQlXs1/NT7oUtzjtU7kri5zayk3bbQKkRKjdkPgFDN0MIeze9Z+qZbm/ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVnACEaL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVnACEaL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso16424845ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707510403; x=1708115203; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Et98YxYSTsWB4zI017qvOz/fF8wWjkLxNjfqAIIc8j0=;
        b=MVnACEaLe9VHZGAkVNGkLepJMVitd91Brzj/FjbvJ2bJwfusCrsg9A3dx0mv/dIwWc
         kJ7w18C+/dWz9r65IMAPfpHNSEqqVCuM38jPbmlOHq6kWwoRo5bu7q3bI+lnreBBkh3y
         4HRTk+wdSHAReGWb2BejCp7atBgz27lFJbuw9B/Wv2zd2t914n5uWv6qHM2ce7IXqEiZ
         yTc059fedpYtA68CWXDI5ScbNAHD/cXTVZB8EzUMonVIR8iEmLqF+D+NDXmyPjUEVVBi
         4oIKmgvOGNCyRLttd2mKNwLwZGtplEIlKSR2mE6FzLN50ucOctmuG4w6919Bc9ypXPiS
         JnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510403; x=1708115203;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Et98YxYSTsWB4zI017qvOz/fF8wWjkLxNjfqAIIc8j0=;
        b=vXRLycVFxxXkZbrdW0O1BZ28lsoO1PTtDPhMJRMG6Way3sH6uyBNjCqMKwp6GmzBgQ
         LY0gOB1oVj/lhbo5RZWfTkvv9kRm41EsQtiD+BtIvlXfY93d4LkoC5/2ktJGwRQf8qoT
         ocFjzIJb5KewCCyg7Fyclg/J3ls/666fUUm+vvEv2SJevsY5DYqxtRdMlFKMoBrsupTG
         U2MpB86sM2L6yzKSi2fKH+6Pw3PTkrx8Mqi6VFwie0gqctpOSYdw+KwPGhg7FcS0SKDQ
         UwXlHZ3H7XwLvAod5CK1FPUXE5uI8q2L5d8PLRdhBHRRIyOAKzvCgmhV2/Si9zpOjK1y
         4X0A==
X-Gm-Message-State: AOJu0YwRpUSVvfRdyKbI3c2VRDjd7POzhvObQfAYkZUGYY/3/QakkKIn
	HH46S1wVGxDOaYVC1trQ2C0AAF/hOcS8jCcywjTk3w2SDCzeO97wQGShSWEN
X-Google-Smtp-Source: AGHT+IGkq7ZrKaLuEwp69ovkgaPdBk7nFQe02PpnsbLmaFI94V/kNEwBbZUcxEUOxrk+OohonSyl5Q==
X-Received: by 2002:a17:902:ea06:b0:1d9:a0f2:bc90 with SMTP id s6-20020a170902ea0600b001d9a0f2bc90mr3287663plg.17.1707510403084;
        Fri, 09 Feb 2024 12:26:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAIymjQWSTpls8oTMXPnvbnGTvSdzETIczPQBc8oPqpmdrEv9VFLxgjb53N/khrWxWMuVSIOr6Jq2wmqlcW90kcrVDnQ==
Received: from [172.17.0.2] ([20.172.28.128])
        by smtp.gmail.com with ESMTPSA id mi3-20020a170902fcc300b001d944bf2d83sm1907366plb.7.2024.02.09.12.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 12:26:42 -0800 (PST)
Message-ID: <65c68a82.170a0220.8a52f.6ea2@mx.google.com>
Date: Fri, 09 Feb 2024 12:26:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2469958494273858167=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] hog-lib: Don't destroy UHID device on detach
In-Reply-To: <20240209185237.3611995-1-luiz.dentz@gmail.com>
References: <20240209185237.3611995-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2469958494273858167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824770

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
GitLint                       PASS      0.73 seconds
BuildEll                      PASS      23.77 seconds
BluezMake                     PASS      697.84 seconds
MakeCheck                     PASS      11.40 seconds
MakeDistcheck                 PASS      158.14 seconds
CheckValgrind                 PASS      217.52 seconds
CheckSmatch                   PASS      319.69 seconds
bluezmakeextell               PASS      103.81 seconds
IncrementalBuild              PASS      1995.02 seconds
ScanBuild                     PASS      912.29 seconds



---
Regards,
Linux Bluetooth


--===============2469958494273858167==--

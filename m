Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D4128370
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942498; cv=none; b=SFb4WDxWFaVx9zyT5HR9K/NBSje7fFObBnRiaOEbCHZ2pxuaJbP4prJ85mplx2oC/PPbv5fH2aOzCCoZ8b1TvmjQRoJaGwY4VC1+6u3OL9hPK25eY6mzK5dFjWryYh7nm6buwSrr+siuFXdFnBsOOxilJ+sCDXCSiCpVSEtxmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942498; c=relaxed/simple;
	bh=T74gFO2mlRG8sR9TTIH+ZX2hYzKXoAt/rvx4XsFe7Kg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QFBhBJuaUBznE0kl61S5ztCkueVfMcrU/Jw3r+9YK0xn9NZNEM87zCGurcsMKHd+f4wXr5w2kp8+dYrviaoODCUSlPVubtry/2EsD+rtMZT5L9S1L6DHhvdpCVaSbQplI5MoSKjH744uxZehKamcgTuMq1DcBl6DppZGuIUUL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPCy7am5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPCy7am5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7838af983c1so11873685a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707942495; x=1708547295; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=58pZ8wYD/cJhX02WMVOJkEBaHt52wP/qFn702WBhxOM=;
        b=mPCy7am5Ym90d3N7kJDi6l3htIB7AWO+f/ndmjjn700qBAyvHIfAl7NhLvDmz9QmgW
         MRe/1dPj3SDb0n+SdwQiuPhpiwYuOFyzwMeBq05Z6evqXIEhqEGd7Hkf0ai2PuWjf5iE
         u4Togyy6yOCAcqpl22aCfOGXGL9EaJdMJbIObps2PbLh0Onsr3ztHWqPFHO+ivKFBUHQ
         xBanBeaednAXqQ3QhkVYcwDfwp4ZN0b3YUa8vvgbBm0hZHrvTzGZnmwgyifeu2mSGigr
         NdBYexk8K6o0XruwGMkxz8H31aNo9pTdji9iTm7xeenkTS5RV3BsPfjzev1EjyvWLJev
         1tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707942495; x=1708547295;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58pZ8wYD/cJhX02WMVOJkEBaHt52wP/qFn702WBhxOM=;
        b=rbYksWo6w6Q3g7pnERbiHDykxgCHl/RxT40SvNn3frkB5y0tDrDf0Pwa0do0Wbjdup
         +++Xz+SZDh428uRcNls3v3khgiukFOfDfX5+K4RQUtCDYciozVVOkErneBLXg/Wui6W8
         uX0LitSQSHiyvgL7o+OjEP+jLEiKM5nJ6ZABgiROg9SGzJspd0RvvRyNJzRCc6eAl7TD
         /0GnETAAsikkWWhT6F+RRFhXZYhFteunwXvzHn4rd1Y497SVkdHY3yq+M7iEPsPy7Hhz
         MEAu0ni6RGazqmkHf0Q/NPRE0o9qHqlhO/FW3jlLMJg+63aaKAqDkFnog5xuu1NfwxWE
         XnZQ==
X-Gm-Message-State: AOJu0YzAwwzIZxoHy19fNpUeckrH+/+JSWV0rBll9LuB8yTCfGhzWbvo
	mDonBlknVvMXn7cxEbRYHgHLByYywMBchKz8w2hWgPyRqvpg0aTNt3LPbTjF
X-Google-Smtp-Source: AGHT+IEc63e3XrB2tAl5p4v0sb/Zjy1EO98eK2eMwGVYNm1J6Sn+7qd3b/oA3sSY2agJbL18b2jHyw==
X-Received: by 2002:a05:620a:4406:b0:787:2acd:c391 with SMTP id v6-20020a05620a440600b007872acdc391mr4074703qkp.36.1707942495411;
        Wed, 14 Feb 2024 12:28:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkZEc7DmagsDVx6h1NsEwpz45lEeaiKNB2LZZyrh7x9D1daLtvGWJc0lcV3FSxrWZVo2/q9kHSHAhV+u0cF//JMwReAg==
Received: from [172.17.0.2] ([20.25.201.96])
        by smtp.gmail.com with ESMTPSA id p20-20020a05620a22b400b00783b6da58a9sm878872qkh.39.2024.02.14.12.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:28:15 -0800 (PST)
Message-ID: <65cd225f.050a0220.19f90.4d00@mx.google.com>
Date: Wed, 14 Feb 2024 12:28:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0444605406193422626=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v5,1/3] hog-lib: Don't destroy UHID device on detach
In-Reply-To: <20240214185718.536748-1-luiz.dentz@gmail.com>
References: <20240214185718.536748-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0444605406193422626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826115

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
GitLint                       PASS      0.90 seconds
BuildEll                      PASS      24.20 seconds
BluezMake                     PASS      716.57 seconds
MakeCheck                     PASS      11.67 seconds
MakeDistcheck                 PASS      164.95 seconds
CheckValgrind                 PASS      228.39 seconds
CheckSmatch                   PASS      331.35 seconds
bluezmakeextell               PASS      108.34 seconds
IncrementalBuild              PASS      2053.08 seconds
ScanBuild                     PASS      960.58 seconds



---
Regards,
Linux Bluetooth


--===============0444605406193422626==--

Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A8469D
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731916; cv=none; b=nOcn0WSJl6sBhIJJFH2MQCV526a4w6T/glzln+Z+C0t8mMhLDdI78+xKuXOlGK0AL9v6ItB7ygNxcxxvIoty6YHWNDyqDNvmhFXzgyUJ6jmXZcQuXNhcpF1Lz75zfzwsNYX3WxEl2V9NKb5qNik4B+j9HkWSAhDljHgI7n6fW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731916; c=relaxed/simple;
	bh=O2ieQHZzE+gR8D4EGMN4YSQaFrBGDCfMm/6e4bOgvsI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kz+Pfmy8lniycw6QrZy2oOAYD/2KzN188hodzkk60BgoAeT0NWJJQ6wl9LPjVmlJKlAK18DWrCq0zpupiRzn7LGVRycQp+1VTKgVEmydFiI4JL/G7XTVWz5hhIyWr5EA9mz7gjZgbDQnMxyHEDEyc1yTQ2nT9oW9hZj6peKwOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv+lvNPh; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv+lvNPh"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e601b6a33aso2367710b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 06:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730731914; x=1731336714; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e0hUY3njOYd0o7h5PbdhRUA66PYtepghzRiQHUrtmWg=;
        b=Wv+lvNPhj0UrYUd09U2lsDOmLirTJwSJNKOPFx4e4185xu5I223pQfjW//t+iA71xK
         ETNfSz4PH7utK4PASEqF07RTVCi53pmTy5DrjctViKyPPt9QxpbebNzS8sLjIvYclcot
         MAduO8bZs55SwcJb2DuSRSIwIYbeI1I3PeU0gaFzuSb8/vn5eAuDWma+kAHwM/QkfCgk
         xMka79j2pZX0BKmWzw91u49saeU+aaHB1dW3i3BysPGhWI31eW+jvWM75tEtKR/6TtBb
         NPY3BbdXlAWXauQDOTvzAI7Z9+F83/5vTT12uTltVUe5XIpbD8OZ4CwtSDb9f//k9wj1
         Qafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730731914; x=1731336714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0hUY3njOYd0o7h5PbdhRUA66PYtepghzRiQHUrtmWg=;
        b=v51G2VXvGtNEqzXqUubduHX6ctxLJjIp8nWyEPnrcTV543rVKIndfl9Rd7+KfZvvqG
         p/pZWfHQ16qMYy5MRoAZ6lMv9kQfmm3IVb+W56Ip3ilaKoCqi1IQtS65ucNpwrcCzJY/
         FWb5u+CPKHT0q7mMY1jP26BOzUXyopDnZXRvdDD6CSPoYwRvjUQWADdUpenvUr2/2Wig
         E6GaLJLi9U/dgob6s8wsYUtwj2UDgIJSsaYxTrnrtt0FeWYK0s+z84ivNb8ZVHRjQbhq
         kt7oHlT0/gjG5cLJnmOlSqNl7MSFD9tawXO+Wk18MDNQ2kDkkuugGNI/lh1hswKz0q2q
         Dk1g==
X-Gm-Message-State: AOJu0YxmGGAtrPAcD/+qq2J1j5GQlpZflyllSsTVF9iYBsnrHpegxqxD
	/LqL7zjOPu0eLWHv1sl0u0X/vyZwkMdG4mNawEfiTxFBif5uNXz2A3HbWg==
X-Google-Smtp-Source: AGHT+IFaiZIu1n9++wf4t4p9t9qyab8QJN8tEUxq4n6dP5VBI15/oNJ9HnvvdfN4DKbK0XRmRNXNxw==
X-Received: by 2002:a05:6808:14d6:b0:3e6:5522:b333 with SMTP id 5614622812f47-3e6608d3252mr11323006b6e.22.1730731913961;
        Mon, 04 Nov 2024 06:51:53 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d367e69bc8sm25972826d6.71.2024.11.04.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:51:53 -0800 (PST)
Message-ID: <6728df89.0c0a0220.192da7.7d4a@mx.google.com>
Date: Mon, 04 Nov 2024 06:51:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4911044520201471999=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v3] obexd: Add system bus support for obexd
In-Reply-To: <20241104124517.4112676-1-quic_dgangire@quicinc.com>
References: <20241104124517.4112676-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4911044520201471999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=906048

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       FAIL      0.51 seconds
BuildEll                      PASS      24.76 seconds
BluezMake                     PASS      1718.51 seconds
MakeCheck                     PASS      13.67 seconds
MakeDistcheck                 PASS      181.53 seconds
CheckValgrind                 PASS      256.28 seconds
CheckSmatch                   PASS      359.14 seconds
bluezmakeextell               PASS      121.55 seconds
IncrementalBuild              PASS      1448.49 seconds
ScanBuild                     WARNING   1020.13 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3] obexd: Add system bus support for obexd

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B3 Line contains hard tab characters (\t): "				"Use System bus "},"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
obexd/src/main.c:286:6: warning: Array access (from variable 'option_root') results in a null pointer dereference
        if (option_root[0] != '/') {
            ^~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4911044520201471999==--

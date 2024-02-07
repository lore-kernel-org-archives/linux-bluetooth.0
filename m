Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADC446C8
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327118; cv=none; b=NLRGRgxtQDOykjVeVOqiQAcRlHAFXHZx9jJOwef1n9OnI9cK/xF2OaDblJyY+BmUio38B4ruhCkCarmkgyRiBKa26LH2khgJ8uu3Cz9m4z/R8FeHcqoBrhl71JExsQv7ZRZw42qhtmIg4M6v4gdIeW5OW2Tu4vXgRav72GDirhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327118; c=relaxed/simple;
	bh=uL/i3eD/qS2JBPNz/yU1K5Zkgj7CCctZTMdyyomwg98=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nYu+S8DaOFHv+xLSf6e4L/neHZp1YOlzVml8XfuMl4F1BGpJfFq4ePCpeSGUUa04GFJDSNhAzsz/GKVSs+HFdXATNlEDk/VypN/+HYR42OXR/hc2RfNU1dQQxYRjrMSdwBDveMmKkquuzrMnUgJMb4bVv2eCcv0OxMOAbIyngko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTIzQDj8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTIzQDj8"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818aa07d81so5898576d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Feb 2024 09:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707327115; x=1707931915; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J4PrpkrwebAoW1i21pnAV9yg9fzRy2WEzNopWsXvKQE=;
        b=UTIzQDj8avGyiHzojQyAZzK5agNqZDZjUkWhNHDjEteBDwXjvF00gA1g2V54ETjXRB
         LPhqQifHJZhGgTGeHSJ4w5/h8EOYlKjH90W0vdotC1tnDSB2Kl7GQtRLIaTy7HU3ZZwQ
         HS6iih8ZwYOzTv45PvA4zXjXcrCDtGDVXYlnmHWs1HIH7areTRoCri9LkLIFeIG//4GS
         UtgoAZ/AME8/SvEiZYZD9N/Z5OCE+aswmI8rYKyDhWBATebQZklxzcGQ6rhGLo5L/iT9
         JA4yofHcdHEKtQhOmm1ndPA9o5gYXOiox+kgkUb8cSmjsXkDWfnsCly/y6MgY34KjG9h
         fauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327115; x=1707931915;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4PrpkrwebAoW1i21pnAV9yg9fzRy2WEzNopWsXvKQE=;
        b=lAlm5LWbolbjBZpyO5DgJTzp8JcLGvHGvH3fStdQgTIlMNrohCSIFO98WiGPJ8kume
         gsPvAMkDbFGPRPIfyoVpULySotBst4ypOm3jy7mTk2X/r2vJmGiNdVsnnoegBPhXFjq0
         HgZXY9w6hUO2AeJ1+0ULenxvA/HWY1JQiKMb9GWBv3wMj0xnBhhW/ZDIW04eLy1mICty
         NLAQWMH8AzmsA5eEn+V/mFEOJDc9A40jWYmRRliyeFdjhq+84JYxHj4rknyFa1DWnGcv
         5xXuIifAiaJCL60AI05kjyp+/0khQVGZ6Z8gbfxXYU0XBKmmqzHJQElefR/eBSyWzuMP
         UTbQ==
X-Gm-Message-State: AOJu0YxpO/RcKlIGhr60gsZqapInspZt+vfDCiPv9SplYIkIJK4eBMcB
	VT3YbhAHySaTTou/RWz3xjnkPxx5TvQ+QVIzQSrtG3ywWlDS5QvmjlCHqwpH
X-Google-Smtp-Source: AGHT+IFRtnD5h2Fn1keufsFfddzSCuIsyvwRRC0rExHw0LosG4ZqWvVAJ1I/wWDoE1OO5ZU7q+c8vg==
X-Received: by 2002:a05:6214:528a:b0:68c:a5fc:e02f with SMTP id kj10-20020a056214528a00b0068ca5fce02fmr6862315qvb.21.1707327115297;
        Wed, 07 Feb 2024 09:31:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqsK5uopJvfkuxhALE6EzoKchZk2jXVWHZ7D0xEoh0JNNXNDQxxfofC3SsV0vRzUku04kFtJbFiQifecfcSNh9gNe6iw==
Received: from [172.17.0.2] ([20.109.39.151])
        by smtp.gmail.com with ESMTPSA id nh10-20020a056214390a00b0068c4d8a9dcasm762776qvb.140.2024.02.07.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:31:55 -0800 (PST)
Message-ID: <65c3be8b.050a0220.6b96b.5ad2@mx.google.com>
Date: Wed, 07 Feb 2024 09:31:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1856157082464605824=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] mgmt-tester: Remove High Speed test cases
In-Reply-To: <20240207161724.2906072-1-luiz.dentz@gmail.com>
References: <20240207161724.2906072-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1856157082464605824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824008

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      26.09 seconds
BluezMake                     PASS      713.17 seconds
MakeCheck                     PASS      12.14 seconds
MakeDistcheck                 PASS      161.76 seconds
CheckValgrind                 PASS      225.61 seconds
CheckSmatch                   PASS      327.28 seconds
bluezmakeextell               PASS      107.16 seconds
IncrementalBuild              PASS      658.91 seconds
ScanBuild                     PASS      930.78 seconds



---
Regards,
Linux Bluetooth


--===============1856157082464605824==--

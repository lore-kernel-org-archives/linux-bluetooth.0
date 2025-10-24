Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68373345759
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328357; cv=none; b=M7V0fanLL6iWt07aSW/25omyosat77spE1C6DE4hpIqpeN/rdEqTR0bcySMvM+7BAiy6L7PWdGI7BKeuC4zpl28wqogAuFhiD+PCohh0hg2Zxs2X1voQgPmmJILbNGXFDD4FNFY8zTMjGbEuAK1L5feaCVC0iRzrPAgxatWYGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328357; c=relaxed/simple;
	bh=rKnSbGzEzgW6NBvMz+JE2CWkjStDDB9llgVS4YlQQjM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O6l3sq9+lkK/ulWxstmVOwkPCIsynjdOk0IDB5N+NfR3sx4jiHCM8dPnS+TgjkB9PPE8krVFzS3ckWFEy+x31ikEUci4NhRqEZijRAOjWU4wU+NFOSo5xuBWJBqiW1hGTL4IX6OiKCivNWVZRoebcfYsQ9R/B7IYQOZ6sIvHO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EICYUiyw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EICYUiyw"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eb7f0b9041so17495921cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761328355; x=1761933155; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iTCLwKO3nHD2GXEgR8CfbZuKduZqjbjiIWv92dB/dRE=;
        b=EICYUiywJkh2TsPbUdQkCMJb66QKOihrG/Wlb8gKS2qXN55VOkV8YHNu4geDL67fOl
         Tfd47aAAyvOebAHo0X+zeTmaeXx61QZcmCl5pGwzj0jk9J5D61mTySmZVKOBbv+052tE
         aZq3FgLhNl1f2HMQjprL058oS2ILPNF8BxmTgWXHeClFgWFQ1WlfBQ/U4bsnGoIWjkkS
         pdQIaK5JDByIEPKpuyt118h4yQmJcgOqS4ICYZaifnreyiqyqv65b6rHedElD+jC45EW
         JDjQRW38ON8qYTocgYzEHLwFxburN0yHLS6GwOLE3IlWMuba5I1nTqkIcHj6xGTMvz9k
         qQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328355; x=1761933155;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTCLwKO3nHD2GXEgR8CfbZuKduZqjbjiIWv92dB/dRE=;
        b=RVRDomaDaK4iLDFRu2O0kyqYJ4aIUbHQMEzKA0Oj7wT+Wvygxh5GncRiERWfN0qr2q
         Y1FsRcXEc8k0jUcTu59HhqQ1mFMpC8idusF6EOl2lzC4o1ypIMOMVe1gCuToBkQb3xxI
         Mswcv4kFFBmUS2pgXz3LVFvTXz4yR9/CFNf9N3OpqgcmWWpe/NYK8uHKLRDPrBmSKDyd
         GK9UoRJohNVYchdyV7cNQySLyZ2ZlFzf2WliUPGlVtgyTcsG54cIYPMaJ+H6ksAKTJXW
         P66uRe+DQUDuqMMR3+3VnpoQVzVqBWWE8FWpRCvg6cO4lPLZ0Fk6sWhEQLqzD0Wp5Uwz
         VgiA==
X-Gm-Message-State: AOJu0Yx4ZG6nQxs8ixi7CGwWKMyfvLki8EwdnTiPRbRblhZgTY+jLYbn
	a9dJotAmjvIFzeqCt5LY3m7VkRfyNbGiOzgLexPaKr6D2xb1JZNZNVX+s643+w==
X-Gm-Gg: ASbGncuSaK00lFfG4jfOoKJF+DULAuU6nZbbtQ1fMFqpZhOYuFoGVHnMUyITZvAQF4M
	RXwFfbqM0t3r314ntlilV13eb2bMPN57546vBfc6j5bJ0J2WCzb1ygeXm8jlgHSMyNWAZN3fRGD
	JoRQWg/m8Pic4/VAfAQFQNpTlVzTHggOb0ZkTLn2CXbxnTCh/N1br+a16lnnY0iF5KZx8mWAIUk
	NhhQc0lbIFIw/5GgoyJ6xdxUDBKpue/Ys4/WrVqRoSeMXNu8E8ZO9XgIOlWDcKP2H1melel9GlR
	nzpcqXpexmTrbfgDqLKSGg1Xq4K8NuU6Szs+ohXWkjPpmlfzHt02uWo+twW1pYbGr/HOODu9WhG
	/dC92qnm+2a5tcJhU2bR4hDRbJ7NGIw8RyxO/CkWfmq4YHcS1lGWv4arq6xRd0Lfr6Wi2dAI4jS
	Z5Py33vA0RKryG5vEr9ApBO0ksFw==
X-Google-Smtp-Source: AGHT+IGKkjNSXLVmBqOUHdrttWgvZYtShQDPf9XUSQqf2wxWzCDTG2UBQPPwkSAIdsk7CXHoKuM5sA==
X-Received: by 2002:a05:622a:14cb:b0:4eb:90c0:5e10 with SMTP id d75a77b69052e-4eb90c06e55mr58931231cf.2.1761328355039;
        Fri, 24 Oct 2025 10:52:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.183.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eb83339d67sm35545631cf.20.2025.10.24.10.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:52:34 -0700 (PDT)
Message-ID: <68fbbce2.050a0220.3d9e3f.b387@mx.google.com>
Date: Fri, 24 Oct 2025 10:52:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4874181238339308785=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bass: Fix handling of BT_BASS_MOD_SRC
In-Reply-To: <20251024162553.469037-1-luiz.dentz@gmail.com>
References: <20251024162553.469037-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4874181238339308785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1015549

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      2650.83 seconds
MakeCheck                     PASS      20.68 seconds
MakeDistcheck                 PASS      184.05 seconds
CheckValgrind                 PASS      235.84 seconds
CheckSmatch                   PASS      309.91 seconds
bluezmakeextell               PASS      128.68 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      918.28 seconds

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


--===============4874181238339308785==--

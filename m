Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B431A0726
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332370; cv=none; b=YB5pHY3r0EbhR+U8JrSbRYx9a1UH2XnLYhuoTNsloOErqk4jXpVwVq0X+7/bUhHUopveSQzs4ZXuyLgbKFFebgg9/qQUTHlIlpKD7xK511TfEAHqboxy49fjqTPqOht0WkDtkfseSEi36uUct8oXSAm2LIITpguuvYUFEgipSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332370; c=relaxed/simple;
	bh=DHIUGTm21FXxnseBCEZtIIYntPWO/LB9lhcTpS7aPsk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WRMnb1CbCanPFIEUovQonAznpUx6NERSw0faNEevSkugZ/3K9aotA/c+YMZf8qwrkJpgBqDUZxoThP2OB5580VtuHB4VCYi21/smpaQDcj2LBVGVsWXzNHo0AbEbVxV8dtxKeJ3kFc7GNX7u9A1agl3CmouEsjkYQWaVRNqp1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEWca5zL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEWca5zL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216401de828so231836945ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 02:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736332368; x=1736937168; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lO0jdbwUUkZoC3oV9lerw4/pXF9KffY8XWPqxvmLD3w=;
        b=aEWca5zLwC85ShIf2DsjsgFSQ/rZbSfMeKN/E06nJwyJsqxl8ih5WIB9+RWO/FgHC1
         7MXHvfx/jy5HHnW4dbL6MZ99trIIuc91tzC3fxZJVAwfwscbjRJ7sLmY3RvHtHy/GXFt
         9rQ+RDn026FZQTqVEfQuwEj+mdAIo58sA2lwnq424jjnsfeyKIGoqfGQE1DBlv4M+KK4
         sqqojQgNpMkQuoHW4q/JWdIu/iQAneyoftO9+qH6CveK/GAxcFeg2j/fv2X6KaXRjpEd
         bz5erQe4GTIKCzQICCxi4hiQYbBNKjVISmp4NI4vJHz7eouSmOCcYOxhUPIdzN2AJPfv
         0wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736332368; x=1736937168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO0jdbwUUkZoC3oV9lerw4/pXF9KffY8XWPqxvmLD3w=;
        b=QE+/oYNyvvaLRoibABsAGwIk6O+wEKKHodK2Knjzxm5s72U5qB7940dGnaVsbFnc5G
         mxnuiDDqi1aBK+Wed3OBH/80aZpSrpEgii8Vj/HEzXkPeZ+W0tlmHrxCmBJuUmT8tKNj
         ZGBWzQX/GyzQPkifcNe6ocpr9Xi6+AoqQ8VuFsCu4+WhzkK94wOlkSvSdBQDZ+4jfemD
         l4mLvvZXsXmumLAzkC0pDcL/kgIWvuC5+EKQEg1i9rW0pKj6pAl2bQo80/eK5ES5uu3P
         K8RMoHHSA5DMEmPYYlI6vfkoIyYmD4MCLV0TuqlpqwCiFFrvT07lNlHpyvJbY8CwkNTl
         pCHg==
X-Gm-Message-State: AOJu0YwntwvvLojLHWRee5LRe1WRMeVvPQLjmZpG5LP7WYxbrrmH8jPI
	3LgAKknQIFakWcbIbLvYS7SUuy+oSei1+zH5smsG6hFJ+XuyQlmtEtsvTA==
X-Gm-Gg: ASbGncuS/51g3ySXbjMdJf7kPAEhrLSHlY+vMLEnDPieZ6cfmHbFNXDVwnP+cC7oGw6
	XW8GqoeRDprAAMCQLA4eRfWtHy4RSs8uM4TVVRg+wl4ecVsWizm7XQKDvW+7m2BVw2mihO84Bgq
	flRMXeXqOKHX9UB01ZMMcIp3sIFdb+dQvO9BhvXVy4Bab8ReJ5qmtfgQAk4nTGC/Tid91kGZntq
	tSeMbDveCNxYZ0PpLdcNwdL6tyIMYvVPCCku3X1ATP9Wf3KW4lXZQXtRAZsfteZ
X-Google-Smtp-Source: AGHT+IEyglsHDTbB/uFo2PmgQm35Lb3GNlm4wutkaCJ9/LIbi3Grfz0DdR7uPylXR7HCdUMzppZAcw==
X-Received: by 2002:a17:902:f54e:b0:216:5448:22a4 with SMTP id d9443c01a7336-21a83f36ec3mr31588325ad.10.1736332367585;
        Wed, 08 Jan 2025 02:32:47 -0800 (PST)
Received: from [172.17.0.2] ([52.159.142.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d5fsm324535725ad.38.2025.01.08.02.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 02:32:47 -0800 (PST)
Message-ID: <677e544f.170a0220.3bfddf.4a05@mx.google.com>
Date: Wed, 08 Jan 2025 02:32:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4481121542275570490=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btmtk: Fix failed to send func ctrl for MediaTek devices.
In-Reply-To: <20250108095028.2299510-1-chris.lu@mediatek.com>
References: <20250108095028.2299510-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4481121542275570490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923305

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.54 seconds
CheckAllWarning               PASS      27.30 seconds
CheckSparse                   PASS      30.50 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      438.58 seconds
TestRunner_l2cap-tester       PASS      20.68 seconds
TestRunner_iso-tester         PASS      29.61 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        PASS      123.57 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      9.32 seconds
TestRunner_ioctl-tester       PASS      10.93 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.78 seconds

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


--===============4481121542275570490==--

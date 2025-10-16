Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212E2E1F01
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653722; cv=none; b=OMSkbt3AzPzstGcMRjyQTH66CbOtH2t6ET5hBh6kpw7sRfX3tOaOwOP2OBT91NrFVl7u43CMw3HAbKI6fB3qzw58vIhh9DjeIronv3udts+bWKpDYRDEaNW5BYhj4tsuvksWtT+Ltj/ZnipvcA6PuOkmHwRuMfMb38oXbqIFlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653722; c=relaxed/simple;
	bh=2t8Fu/yw8BT7owFY/vquR2a1rR7CwRodEFvO4XYZcww=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GSf0ztwCJG2lU6nA+ZqsjBHoYr2By2cQNNTeiat+0wOjJCPhpFp0iCKF57394QxtyBDsRdb8vQtHwx0lpA/quTyP8Kw4I1JKiqqMPM39AlEIKQYZMPZdsYFr4dqsK76/lTeMCvWjx9EOrHVwDsrun2fX/o4A+x0Gtq+rL+FRt3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zom6e0dn; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zom6e0dn"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87c0ea50881so25292596d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760653719; x=1761258519; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TQusK19Usa8GW0ZWSS/pJA2ElnvM8VKiRP+8hp2VW+A=;
        b=Zom6e0dnCesjy+9K0bR1M/3jyip2WrLe9R4LBEhQL5q0P5xWu/gVsvFXdJO6VY2uWs
         6cXMLZw1fQzFfG4AaRAl7na5ZXwp6T8VAXYuPcYO1OA9EKRXaiko26Y8sBNTc+IvkRQa
         k6we1CeER8yhqyi4g49Zro3/9XrIBO9tLBNTt+YhT/siHZp3wF37pZzJLLD0gWMzBQ1T
         Cq7DmvqqYlg1dA/VilQmjdntu/5ZJzTBF4iVE7QM/8c0SWWDyeDM4l8+HQWEDrHZ0F6w
         oA9f6igdjnT+Pwnz6tdYpPkdNuBkwAekNbaXJCUAkgwHGWvkhILAcuvlcmIyMw47mUyY
         Ws1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653719; x=1761258519;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQusK19Usa8GW0ZWSS/pJA2ElnvM8VKiRP+8hp2VW+A=;
        b=Wehawcl1Ti2WuNm92M/MyV2tjK8PuikDZPnjYQRTiwbmYg/HWvdNEfWVypONP5pGUe
         j379CYXFYuxISVILxVNMYk8MxJA7OcRtih+EUi/sXEwvvwLOqoTpzkIFPAXURuHDW2Ng
         tGIKMUPH51nEFccAW4uLbVGtYVNIXhoAEuKLD3lYa7IkyMaSUXXGDQrPM9cVW4i77rTU
         DzqHFejX0Jz/VE+7kCNeij+AqCMp+s4DheoI3H5d7ItKCojAKxLf8YwagEVPzeOQA85o
         BP3aHbrEGPMCfwRFvbGowPeqUPfvg44DlDhrIQ1uyiZ3szNRjuOQ6ZPJ6LrOvfadu7yl
         t5Ng==
X-Gm-Message-State: AOJu0Yw/LS4uJCgth/rb6Y5qrI+L74KkqEu+Zh1j2OkVv7Fxpbx8tVsE
	VRG5jzfRWvBcpZvLrzoKPCiPlEyxrwOHLsgJ+uhVlF7kTjSjEUw3qW6s9N5dKw==
X-Gm-Gg: ASbGncuGtg8dt7P18aK52E4AaqWWtsldUFChNrpjCWb85VLJzjhmhwPO/R7ZyxNp6/M
	e+o0qpHTxE15lHQHKvJsYW3yRv0fsBI8TU1Lnto5cIyZb9igv8e30Qa+aPdoY59vEIBVpldXLCt
	MLUQJ47SkDV2AHLyJk7LS8ylOhiJc39Lqy6NRBgdK8VgpkJcOgw/1FlvtGZkp1OvgSFrpaElRY8
	KskxT/t5LjqWuqamIPIkycCbQ1r3U0HqWOySoPncUTXm7sSIwNORAlLI7ju0Aq2CC2QDTBrprzz
	P+GqaiYln2BbDATuHjdJZym1SdYxbDpvhFT/wieGM5+s6Q3LgLqtvms8bLMX+pvV5Za0doxkJgc
	zjx0DOnnPEFnxBU1Uqbf2Ee/Sx0oqBuWYrFhqkuvsp0EVyqajQAh30nAOMLnIk1wFvzeG3cq4e/
	ucXZMg+CD49uyFjv+l
X-Google-Smtp-Source: AGHT+IEM7kpm+m9KSx2kjAc6pq0AlqjTDrQKW3dREE337UFNhnhS7YwRaVUISEc11rSlD4JG+Qmp9Q==
X-Received: by 2002:ac8:5a11:0:b0:4de:e0:de7d with SMTP id d75a77b69052e-4e89d3fc786mr21234041cf.79.1760653718861;
        Thu, 16 Oct 2025 15:28:38 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.54.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b5d5csm48270526d6.62.2025.10.16.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 15:28:37 -0700 (PDT)
Message-ID: <68f17195.0c0a0220.151b56.ecc5@mx.google.com>
Date: Thu, 16 Oct 2025 15:28:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2995490014082890851=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,01/13] bass: Only attach client if initiator
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2995490014082890851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1012546

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      2700.81 seconds
MakeCheck                     PASS      21.09 seconds
MakeDistcheck                 PASS      189.20 seconds
CheckValgrind                 PASS      237.29 seconds
CheckSmatch                   WARNING   313.82 seconds
bluezmakeextell               PASS      128.70 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      932.41 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2995490014082890851==--

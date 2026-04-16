Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813723C51D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371720; cv=none; b=VzicVEtf6EkL+xf2nGNCV8UhznTg2nPV6PpyRSG+SKlf3/9dFuztn6yaWmXWnR1LXY+dO2Hx6BMCDw0Eq72oqewWll2vAjGbYB48/FNEmALttG2dVGmdttX5XgiurUFExCdcEnQZmM9TMBuL6W0CM0YPvg/XZe0Z1NGT5PYW4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371720; c=relaxed/simple;
	bh=R+j6yDN5PnaldPd9Kwv5dP996U5Qaqfw9Z4/nYK8+Z8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hkRNBGsruoIUSchsq+BschcswYL/EKR6UfbraB5EDGmTg/8zCyzikBuqfp1l9roxF6yce9zPAokkPRtpPzX8Ieu6wVsIsOcsgbOcir/vp0w0bVk9P0uCe3LIx+XMIhp/69Hdm+qFG4GtyPbQ9HcBsW1ivtjZ+gKhPcD/VzixvdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igc6zRl3; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igc6zRl3"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2de831d2b20so4656602eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776371719; x=1776976519; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+jqRnGkrpwOcopUCUSIeRdQ6GLcAomS82RBHiuh/Tw=;
        b=igc6zRl36FVnHbTnqT19wuxiujcQwqTVOP9xHDxwF732EMfP3yUgRSE3b1wW9pmRiT
         NyG1phiUAhA5PB4qNqs3/Ni0zaXFJp5uPz1quieQX3fpCskBWb8m3m7VF2+SsJgnMyx3
         Cdop92GlSzJUIKG3M34dAm03Urmo+m8eJprmmVHyKI/zaSTvERJW2bF2lA7euZFp5392
         z4g7mbsd1kdhxqFaGBhuVrYULCTkT3YotHL5iLgEgLuBUG76QcRkqN6SFInodVk5A3bB
         bFMxzSUxQJm6ll8j3wu5rNvxG8uivdPaZ30xQLhv3Td6/UJ/F1ottQusumqjGy9C2TuN
         FEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776371719; x=1776976519;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+jqRnGkrpwOcopUCUSIeRdQ6GLcAomS82RBHiuh/Tw=;
        b=FrxHsK7cHWey7qmJvvfCh/OVCFI2uNdWv4Cqf8MbTsPLd52aXDAISxZCPUML+mmz6G
         77K2ZzmXzDa9ie/t1fR69n7aTHqgQK6g9zuvz38JxLi39Ius4aOZbxZAckEJ51l1VXYD
         afm+jni3bfeQmLCrmKFcV5VCuJ3Dn/IQmNHixVlGOp4r2f8CRFswkxddu3MExl5o/Lqs
         P431M/O7NSr2Bsv7zObUC5fI35XuiGP5x3Jyp1HZSkqraCJha2ZVbxtMlQbH8Rtlmiv3
         oQZPqJqMDGuygD30TugU+MEF4cKp9U9RvzQOhzhHSZ0bUU0wnsEt5vksUbzfuaDp3D8n
         A8Eg==
X-Gm-Message-State: AOJu0YyaLz8A8rLuVQ9bTeqSyxtd1qbe9iRmbnSDbCxxnvx3FJvOB1ga
	oc0BMJBJVLNcat9xtlgmT8PcQDGKRCiLTr4veWOwEgQ3e9tEh/pfafsNZCUCUOyZ
X-Gm-Gg: AeBDieukVpXWBPMLdttGvs5iQlTo9sU4gv6x4yGU2M2IekQigytQ87TwqFZDVuyDQju
	5oUj57dWige7NauT3MXSczjWViz1yhynWFl1xsYI6die3bHrcZrwSHKKjYXeOmKeYBoW4sYIcG4
	4751mMbidMEcxNSUVzyCFDd+P+3y1E9VXfSaBoH4xMYYKrSdKO8AMC/CWSYEesWHbamSwKFJcFU
	eYJoEtgFlH2cN1tJB8A/P83dNId9w8S0TCiRv5z+1C/mN/p6DpVqeLEOVHGpclGV4Isht2wMtd4
	+YS5349PuEL1vp2CzRl8Ip1lSFiKyOw57wJUPwOOl6eXKIZ8SuenK6sISOC5iwwWKE7+Q5CT0Px
	iEli+jfTwvuPB9n8pwxQEeLhm/qW19cOBIGHl9nVTy1HkIeixwgq2jBiZjjRifWpnAvU/hijjLy
	Ydxyu6CcgP5X9YZCG0cjY213RPvNBIX7pv2pEBLyDq5PjVRHx81Qo=
X-Received: by 2002:a05:7300:7314:b0:2d8:c484:6b6e with SMTP id 5a478bee46e88-2e2e5ff0d29mr496810eec.26.1776371718551;
        Thu, 16 Apr 2026 13:35:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.83.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f6615d5sm11137148eec.24.2026.04.16.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:35:18 -0700 (PDT)
Message-ID: <69e14806.050a0220.46960.6606@mx.google.com>
Date: Thu, 16 Apr 2026 13:35:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0955775814449055906=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] client/btpclient: Add GATT discovery supports
In-Reply-To: <20260416184929.145224-1-frederic.danis@collabora.com>
References: <20260416184929.145224-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0955775814449055906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082170

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      647.97 seconds
MakeCheck                     PASS      18.52 seconds
MakeDistcheck                 PASS      250.35 seconds
CheckValgrind                 PASS      296.19 seconds
CheckSmatch                   WARNING   348.39 seconds
bluezmakeextell               PASS      186.62 seconds
IncrementalBuild              PASS      650.75 seconds
ScanBuild                     PASS      1027.70 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
client/btpclient/gatt.c: note: in included file:./src/shared/btp.h:327:41: warning: array of flexible structures./src/shared/btp.h:332:55: warning: array of flexible structures./src/shared/btp.h:355:47: warning: array of flexible structures./src/shared/btp.h:384:42: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2050

---
Regards,
Linux Bluetooth


--===============0955775814449055906==--

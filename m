Received: from mail-dy2-f37.google.com (mail-dy2-f37.google.com [74.125.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE1499F31
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332865; cv=none; b=WcLR7uNhT4cdiIqOSOG0UqQR8vs05oMK0FgQ6Jxv1CXxnr/zp1LGg860P4EEJI1QZah7x3BJ735t7lpT50WZtKVFegmTLFA0bLdzG1ogUGS5NUPy4RJfOs0z/eSS6yEtPj4QGqECUEPAyJYRlhagKlipbnysLIziiHHf8xHRvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332865; c=relaxed/simple;
	bh=7xJHCQKV21kilEPg0F+BSjndoOfavggH7xlwxvFZcpw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=utiktv8ZThIVDRsmNSSMwK+FdUEq2bJNdj6pSSCgiiEf+xyZdJwCG93iGKAG0XhEBYR6ahtDy6fnSJTbsO3Bkw9hh4bbAinbQ2OuZk+KYxv/oGeRQN96lNvBc3pGfRIb4HpgWCUL9xdV2C+YTDxbysCl8oqQK30eEvVo1t/qAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltPbDrg3; arc=none smtp.client-ip=74.125.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltPbDrg3"
Received: by mail-dy2-f37.google.com with SMTP id 5a478bee46e88-328664b752eso456246eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790332861; x=1790937661; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Un4T+fjPmlfsZ10Drzda3eMjOflUpRzSms/xC3m8Cbk=;
        b=ltPbDrg3kOESFse/D7vxlpnuKSztpkA748uim/xRCrKDSBBYkKksyqyBFeftIVwuDz
         MVY74sUQ1MEiI5VUBia4ZM/fkpSgv7FyS1XE+iElviw/dAXYHDE3c66ecyPxsO0LUi8Q
         GBUukedQNiVBGt0Wg0pFO9+shVQnRj1RsTqCjm81fLBAyCz8o6GPcQil04zcrUpVqOAB
         U3u/LLQaYZlbpNWSPBLyC7Ez1X2JzvPsU9QIELLYSTANa2YgLLgjX0pQG40Mj1/LX6CM
         XqTb6oE32EWxabiFmKliWgKxVh6R2E2JLmNAx6I+iVuybw4pYG9gTPDcfW6ogacUyOZ/
         peKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790332861; x=1790937661;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Un4T+fjPmlfsZ10Drzda3eMjOflUpRzSms/xC3m8Cbk=;
        b=d8Xw4M20gfwmYt7HC8S+R9wyu9exzxfeFQSZvAaIq29XXDu9bFB1iKqp04o+wlsM09
         KPbynZz9ID++8D4+uc+AWVocpoxHoZRAw9zQ+c00AMbXN+EMQvyNdKthg0y/szfzV4qR
         rSa7H8+zOVb8OoIejNntnNqdbmRk+C2v+xYEYoWqtpjNwZVf0PMWYJSSemIdxShepwSz
         3MiSxMjkVvTe0w9izOG2M2QvBofZen5EVqaT7xTywShf8Ze/RtL5uOrilSZX0PCZahcZ
         Q8xapucrggH8sHLCek9QYFEqg/B8MJJnUTcUZydjWFML8g5voaLlYOccKH0mhIJo1RIW
         fi7A==
X-Gm-Message-State: AFuF++m1aR6S4Elkras+DvTVelYn6TgOAaDnk7zdzxdwuMjtu5Hf0185
	Ez6SdhVKg57cfSQKEH6iM5pri5PHjsqvLSQpbK+qDPTphU01dwBRuYpfsI7ShBk8
X-Gm-Gg: AYBFou3gI+dr12j7dIL74V+ANVwXpMLS8162u0vhYw4GaFEiPc+nEM+lqXS8Bwtyfku
	92HbqKYpe5uz0YAzcvouncd1gNt0imPR8+6/3MW3gAHIYQ+ROFZyTQwJhriquRq500zjjh8zYMj
	Dzc2GubtUe2QzlelDrdoV74iviJnCelqSmUMwYn9rhHuS5Qx732rjo+/jGZuJ2TBRS9K4Dp4iGk
	FAbkmsOXaYYDQB+Ybdv94G322MeRYOa4skeXkFPNXOugrEjIDkVxrBkKTFBymglDJRsAeyMgw3k
	yg20UAT794ADfaxeuQEpF3k5racyRVceeZJiyOvianIzmjV0U6bgBsC2ycaE8TjP7K++j4uEUnf
	dAMGQPbFGLni6wpJBcHFVQ1c9uy+7vOntBOzgFMv50lbC3kyaYHs2A1JijOx2a96X2eh0QuFTFV
	EkJF0Ao3GctL8IwIzgI9F3zInBKvQF5qdKtSS9btnxkIDrcff3G4+JKlUiPePEcLi1ruZgfxJ6m
	zBGksc=
X-Received: by 2002:a05:701b:205c:20b0:145:15d:5313 with SMTP id a92af1059eb24-145f026e0fcmr1478853c88.25.1790332858712;
        Fri, 25 Sep 2026 03:40:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.47.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c0ccsm5279965c88.4.2026.09.25.03.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:40:58 -0700 (PDT)
Message-ID: <6ab64fba.acba1091.2f156f.6d4f@mx.google.com>
Date: Fri, 25 Sep 2026 03:40:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7320429805546684544=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, webgeek1234@gmail.com
Subject: RE: [v2] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
In-Reply-To: <20260925-bcm4356a3-bt-v2-1-42098aca235b@gmail.com>
References: <20260925-bcm4356a3-bt-v2-1-42098aca235b@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7320429805546684544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173569/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.46 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.86 seconds
CheckAllWarning               PASS      34.23 seconds
CheckSparse                   PASS      37.97 seconds
BuildKernel32                 PASS      31.37 seconds
CheckKernelLLVM               PASS      34.87 seconds
TestRunnerSetup               PASS      811.59 seconds
IncrementalBuild              PASS      27.17 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#88: 
  Bluetooth: hci0: BCM4356A3 'brcm/BCM4356A3.nvidia,p2894-2551-b00.hcd' Patch

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14846577.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/819

---
Regards,
Linux Bluetooth


--===============7320429805546684544==--

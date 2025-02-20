Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAF1A7264
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040158; cv=none; b=Slz5n2jgpAsUkoIDpCPw3kHcS1GTl/dTsAgbEBBC8mHuonAdVxSz5DMiDgvFD2xqTkTllMMG33g4fPdEWtbTzPxxG82qQ5StC+mJ37vWIAQErjC3gOpYDrA1V0oOBa1NipT/ZnfCk3UpP45m+ZbEWslYePjifRwUmJ+s/TK38Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040158; c=relaxed/simple;
	bh=XK6dc2/Y52lWEs0EfZ9kCy6edVEMppSDLeA2/JMA26A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZcWqGX/Tr398p/uVyVphOwQMGHZkC58NLWjEJ2Ss6BfSuHJbV3Ver1/cmfPTO21P86r4nf1DjziNDjkkHZpOzoj4avX3cXkYYc4eYa3WAZBU1OZC9oRZ0Zfy+77QU3rDN8hmVTRVRrUuIx6lVreN360TAWkOBIa/qU4FfXYv9Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmxrnTr3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmxrnTr3"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0b9f35dc7so91333085a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 00:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040155; x=1740644955; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YzFuIrpjN7LKnQAGLy2ZdVpvKQonLw/SH3aSUqj84mI=;
        b=OmxrnTr3L2NKdW3cd8XmpTNxsnw0vxDP2UewkGV0hUF1G9hl4z5FeJxyOog1Vh9tGF
         knZs8vxwnxM/dx+mBY7OwEm6WLjnsaYAahfK5vMAsC85SDoMwItI5vzhMFGOalTyUsmk
         Rgr4W3TyaMRW8aaJz+L7huL1G7VAIX2Ud7pRJY+gftA1TpF6aDuytpBBsiFHs0LPFLUP
         xYV9QLa89kWbm8wYqPsu3r83QqpyDEqQdpgwd6HD4BGxV2fmraHfzUDJKs6J3KgvCLaJ
         TqR2faWuhEQnEcLBSLiQIQ2TIpcdDccMjlfj45z2lZwNuc5orkEOW/NqHDzylTr8n8Td
         fL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040155; x=1740644955;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzFuIrpjN7LKnQAGLy2ZdVpvKQonLw/SH3aSUqj84mI=;
        b=kGbicLcjIoKGjamEJdjh2iEpMvbqTygnLH+z+wMdJgKmR9NEt94//837xFAma7aAUG
         rA+pd/cWmIVFSeVo0a1zyJP5wby5til/LKvWOdqo892N6A8eHJyDjUI3XG4yCc8M6nIr
         IrAGYHQtRvmqhxz2HdLjQWjFnigs7/QsQkg1TvT30eDxjklefn/7ofYjfSzosaMrWGCs
         5Wi5voV6TBiN0f0IeRgrY3vCu1r3u8lATcaRcGc5TMtXgUSNlfwixyEeg1i1JrHtQcsK
         lHiRl6e8az54Q9bbJBEWvv9BbV1ZxRaLIQS+epXmMjhhvtahXGWWqVZr2Qk/2GmVe4qp
         UsVQ==
X-Gm-Message-State: AOJu0YyPFps3eMHy87dsH4VDoW6kUdMPFwd7tFljne0XMJfaX/Qz5s23
	2vWa8UGFS9KFEDLI7otWIIGMHNWs8VDjx3h13+wxCkicNB98gR5EiWO0OeL4
X-Gm-Gg: ASbGnctjxO9MdeEC4Au1uyoPa/GuoT0uSboY+48sTfUZOxAJOV+tSJDVaH4RBmH9biV
	lIyKja4WXlklbtpF/GvTzx3iGXDZnlHd8AKf7GkOIpLc/kISNxVnPhryCJqPBrEHjITCIHZvlHt
	Rr34MyHC75cPnyhX+ycw0jBMlMbJdf3Z92dPQGIH9Vq/C27pejyFk+LAghJzMNEFm/N3MRSMGTg
	gUFx9Z897de6vy/rDphUF0KPEEbEDKgh3AI86X9W8VBLFWYIGsOt+uG6h+Es5AxPB/NScW5FVmY
	KL2NkGbqQ0jZhDqAdPSnHA==
X-Google-Smtp-Source: AGHT+IHUOrq54mH6Vc2NITbS/kcSmHF0r6JSPIwprFJUEKFbkTuF03I3ZegihJa8JYAe4ZE3LMRe7w==
X-Received: by 2002:a05:620a:45a8:b0:7b6:7850:21d4 with SMTP id af79cd13be357-7c0b5331dfdmr1002139685a.52.1740040155519;
        Thu, 20 Feb 2025 00:29:15 -0800 (PST)
Received: from [172.17.0.2] ([172.183.46.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09b2ece04sm472360485a.50.2025.02.20.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:29:14 -0800 (PST)
Message-ID: <67b6e7da.050a0220.2fdd70.4e70@mx.google.com>
Date: Thu, 20 Feb 2025 00:29:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5212232062059446135=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] obexd/client/map: Add SupportedTypes property to MessageAccess1
In-Reply-To: <20250220072446.190256-1-frederic.danis@collabora.com>
References: <20250220072446.190256-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5212232062059446135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935872

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      1469.28 seconds
MakeCheck                     PASS      22.35 seconds
MakeDistcheck                 PASS      155.80 seconds
CheckValgrind                 PASS      212.05 seconds
CheckSmatch                   PASS      281.72 seconds
bluezmakeextell               PASS      97.19 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      848.62 seconds

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


--===============5212232062059446135==--

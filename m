Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E4483816
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298237; cv=none; b=DP2Y8eFD7PpsAYZLzSSAVN6TMePpaJVFi6j4U0xpR3fe/kO7AuY7Py76eOc8D2pnBWHxh68dt1uYtnY9gMESeMvsMZFoH+nXtGAf0isvRGJ8X7oM/vv91CtSNCDc0ztPktpPzO3sseEGsOMk32QgSu0h4G/UGUshOYvfGpwidg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298237; c=relaxed/simple;
	bh=0gooRL3DyBnXqgIXDn6Yu+/LXVifxJP4dLoJQkbxm+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Mxv0V1rKLMTcHBbknBKwz8DO1/dTN4pjxr3bePh19Yig8fa2y8znYLy8DNlTu9fqSVIvyqGT/B2C1i4icRlcONnlVPG3muEs/PAyRLZD2/ZSd8TtPYUxTbbWHH3SH9Tq3MbOONkT2f8lQT9wOagBKH1G8H8sgBLTtGSvRF2h3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4T/U0V/; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4T/U0V/"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-81c5aac8478so414591a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791298226; x=1791903026; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0gooRL3DyBnXqgIXDn6Yu+/LXVifxJP4dLoJQkbxm+4=;
        b=N4T/U0V/okz2+G922syfJ0CxiHGHiPaudiM7kQbHi10/ibSCI4O3x4eTsf99t5rVuv
         m2wOq3q0V8sAqgegpGck1OTGzxnHCsVHkKQZ6MMMiNapOJSCu2rR5NLGiBJLsmg3drOU
         ud87G4/WRCoVKIdgEus9N37VQh4bGqZswk2jdwGrkvExB0w+0MHAW9sBX0K+RvVDiwQv
         dvvx4W/Rs31rJdfX5Kb9KeeF4Rppib6EYVqWDFzD0nnglKM7VkyWMTTG+4PtWfaAxn0P
         9DU5BThFk4TZPudrFJUaU1QIHnHE0fZax5Jbvhpub+ye7OsHAC8h3lh7Xnc7n/KoP7gr
         J7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791298226; x=1791903026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0gooRL3DyBnXqgIXDn6Yu+/LXVifxJP4dLoJQkbxm+4=;
        b=HXk/Y4XArnZT/lyk/VyqmhRVE4qsgoon5nEMHXXlgaYLQkxmMA0jGPzctyYCZb2nvi
         bwaWUuO1ZkS/LtS17tuP6lx9Q3zZajC4rXR2bAm79P8MyJmINqrpvcfzxr2TgvqN0OlW
         BETSLhtit3kF0fasOCb2/cWGFNNEqYEgz5GTBFbFmZjnL+cuSdPRrq2pNt2dJ5kdQQAL
         YaHi+Qpc/pXgvkctP0vwwALUQqt0XkUWuEbZGi2PxDscutVnx92dTgYCE6P7Nsk9YVy8
         CqT0SqHYr+lSBreGUA2Cg3RrWkCUebRtpitL5voasdwwMTx24x966k1wTDCVBbdiXB/I
         kLNg==
X-Gm-Message-State: AFuF++mqcuCF9YM8eYdzngoKwQk0Q+18cUZXR/3Uap0QkKJ5e3hTAmwo
	X7hEkQingGGY9tgI9wVVIFU2ndV2EQf+yjmo3yyCA4f6jzDVyBiT1Rx/LsniwAyX
X-Gm-Gg: AYBFou02/fac/Tb3w5EQSdIXzYhEoVnt1aUcLYsIKQQbyJbThXjVASKNZOjfv/zz8S4
	mkFwLhAMvM5qSf0rcbKfZANmAmhiVE5Or9JePInMuFsSs/fVgvM4I6+HArt9jNMbWVpuWI1jdCy
	5FRjKm9geuO1yCqQkIhCxFPnOUqi4xRVpoM8kOe+O3VrnCK/1kvG/l2A7Zo7HZp1bUv7wfvfKdc
	s3DuzSB1yczPrh5IfH8ALW8ulXrC8xK4/j3d+1bU6jQ7d5dudgRB2/CP2otikmmjl6DanhVp6IR
	U0y1M6oURM7dme5mjBQq6wj0aKLXcenJNQY6D1A+MDzEHRqbSHbSuTIvlTpIgDnP0ijEGOkCsNf
	mdDmctbit+ZhRCepnlcmHwvIA2wTbsrmzVJahnt1EnRlLez8dojLDQOWa5cURQBWL0vnGqINlP/
	NA3BU609sCkNO1rOAmGI/hyE578JFlzVdU50xwBQaOYf1RwhLhKlMftcM8LsBK56qTpX3bB32Eb
	vaN30o=
X-Received: by 2002:a9d:4791:0:b0:829:8a9b:de79 with SMTP id 46e09a7af769-8298a9be4edmr837259a34.4.1791298226172;
        Tue, 06 Oct 2026 07:50:26 -0700 (PDT)
Received: from [172.17.0.2] ([128.203.198.69])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-828203b7966sm2796091a34.15.2026.10.06.07.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:50:25 -0700 (PDT)
Message-ID: <6ac50ab1.515a8f88.16541b.8ec1@mx.google.com>
Date: Tue, 06 Oct 2026 07:50:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3523461337586104463=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, runyu.xiao@seu.edu.cn
Subject: RE: [v2] Bluetooth: btintel_pcie: use managed IRQ teardown
In-Reply-To: <20261006095628.384343-1-runyu.xiao@seu.edu.cn>
References: <20261006095628.384343-1-runyu.xiao@seu.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3523461337586104463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:1750
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3523461337586104463==--

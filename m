Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AACC2F6596
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484353; cv=none; b=kn44UHIhcH16yfUdzJN634FXOYUjmCduM0OZdC85+pxslvYG2GNFEZ5IgwMSqb6zfuz+gCh+5MosOWbDnYFIc75l4lWPOuOCx+9dDKNcv1EI0lwBiZH8kOpIQregR78HUXnHhJ4xwEXaHsLJ+lEOhLzIFGjjfKmbOq3Zh72RBfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484353; c=relaxed/simple;
	bh=XNyxG1b+TAC8c/0hmcgAc+3sgMQQEsEybCw3ZNhhdlI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LoU3rGLtUjKET8tJ4riQ3f/qNpSKCZaBoNZq5jj2j5DksmomoGwRR7TcXHnDiLHqd71w0Cly0wHOac9mI7tNp/digG9pP+ajPSLDjY1mIjBWYaQGUhp/iE0LiPchlWHMBPBlUGJz0TaHmzBQz0gWO513lcrwN0pvCQ3WL1k1ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL7ZvmUg; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL7ZvmUg"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f3faf2b081so2544034a34.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787484351; x=1788089151; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0sKxSMkyABu9mKsSwq+YSv15Pi1Th1mhnJBn3eXL0Xc=;
        b=kL7ZvmUgHZRsdCRuguEfYqUqajylXUWiw7899wKnCdfUsnlOTtpDoC3ohklbJgyta/
         Qdj6C3HSe7qzWJq5bSJ7DxZTUb1kVKHTmhXvtAaxIlCsKKpcygFGrdO6U8hGNO2K6quE
         HKUlvNhIET+dVx6fgKflXC/EpsCCqk2lEBHRYN9wk5WClOAUdf5szQekEhVfI+4I50Ww
         xVQEKWSfwVVV6wI8lYZxSPrigj+JxEROZ9g0QY0zeEnyI4WQH8mZjAsXIZKuBR5HlHGH
         0WRfm2v5SEFmOkxErk+ohXKrRUuZQLUMuqz7cqsJ5ryR9HXD/J2KIv3+SVNiUBxicSZ5
         VDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787484351; x=1788089151;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0sKxSMkyABu9mKsSwq+YSv15Pi1Th1mhnJBn3eXL0Xc=;
        b=fobjgCKtVYom5HNCjSP352OmaNaXNEap+5BcMs90D6ohxTwsNd0DIOb+IqjMQeCyOa
         bcVRhpgSECYklHoYK81jzjcHI05AWxzCy3JfgE16OiFqaUPOpeGgeTEWIRpdOYkmP6VO
         f8EjRG5vV63b+vHlTHNqDs2dkLb/F8oBpbFX4TQAbSOCy5WgM1evukQVpmjo+PJFiKWM
         FHoNoZ+M4Ynfd4RkWEig1+sPnK1FqhdYzXrYpr2Aw6toTMFBvXk94h1zCAvxt3fZ0x2+
         dujVaU90TQz4Y2kmQwKkh2t6wFPEKkCAhLIeYg9naKyLxbEwKJCM8kkITcUXKe3PV79L
         PfYQ==
X-Gm-Message-State: AFuF++lWJt523NWNfF6vmb+nezDQHOkkCzptETJ7MKqaqqpAoq28UY0R
	MmQK7dR3JApu6Fbr5YKYaL6+N4XcqnjvDjzu57GQmafXmx0K61r0dKkOmnip+Q==
X-Gm-Gg: AR+sD12QFSzoJQU114DxyNOE3K3lfw7MkkHneAenW7efTLKwgs5T4MdVfnnap83N0oI
	jTW6dt2z9GRRwqYOgwW2iWEzqGOrB9oX/fX/NQnn8ghZ8V4O2Rhd16S0Q81SEA3lTzDJ4SMf4iW
	RtrXdgQoN+R5hoR1BxthXTEx6LxCfkwNxP+ELLODiKyPyavf9OBP9ba92B1GJpLW3+UCoxK0WfQ
	qgDG4LAvdYeru58Hkntjy6NarYJ9iGssij05ZUNiinT6NzTaZXIDuCBUJSMTAGjve+NogvB1y1G
	xC95k1BRdPUi+JTx/SaphAvf7sFz1mPALndeEcKqR5x3cmbdE5b19/Eed/pI3EFszLTF/9X4G07
	2c4PoImAxoopyUIp8zsvgU3fO0DWnJJ1glwPUEvLPB3bs7fuJtxK2boEt04nm3WjIhCZTXbGM+q
	cQTQZscL/miHE0wT1SkrKK4zgzkGuajinNZC1wPh5fjXlvFmgQRlKED5nB66eoC2wDjzaX
X-Received: by 2002:a05:6830:412a:b0:7eb:d848:c867 with SMTP id 46e09a7af769-7f46172e13fmr22211163a34.6.1787484351007;
        Sun, 23 Aug 2026 04:25:51 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.73.180])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fae8df0sm1465014a34.5.2026.08.23.04.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 04:25:50 -0700 (PDT)
Message-ID: <6a8ad8be.830abdfb.1d980d.135b@mx.google.com>
Date: Sun, 23 Aug 2026 04:25:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8687996147606798916=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kserwus@gmail.com
Subject: RE: Revert "Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan"
In-Reply-To: <20260823102959.100368-1-kserwus@gmail.com>
References: <20260823102959.100368-1-kserwus@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8687996147606798916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150368

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.85 seconds
CheckAllWarning               PASS      28.19 seconds
CheckSparse                   PASS      27.06 seconds
BuildKernel32                 PASS      24.87 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.79 seconds
IncrementalBuild              PASS      24.58 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/637

---
Regards,
Linux Bluetooth


--===============8687996147606798916==--

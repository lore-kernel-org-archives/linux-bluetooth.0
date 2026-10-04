Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C545400974
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2026 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791140076; cv=none; b=eMaog3azkFhNx9lteWGrmR2JqUXG7yW359RmgDjFjTyRg2uvX8WJZjgCazhxpZ4CzHzU2PbgGtvOi9pwWzyDTbC2pse+H/2NSiV6gTohV4zEK+g2W6Uboc15Jbr6eIU9uCrsFevx1hMyJKkyN8A7n1sEotjcPzc9gw/ml/l92Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791140076; c=relaxed/simple;
	bh=e4kmvDOCsSCk/RPxLPB6DvutcyT4UvGu7H1J4n/UjxE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ISam50fLh+RuIMQreIXg+cPy+kR8QKRV9b9YekM64eMs0d4aO/Lt7lGtf3dyJHcATfprIn5LOrMyJS7xwGrjepp6+F3RmrGb1V2pkNHYxc9nOywCrpN3ktEMUiIOf48IhEHzqDcCOlBXqMUmQdatp/ZzU48Cgt1J/RMr73l47CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzT1anrN; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzT1anrN"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso1571111eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Oct 2026 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791140074; x=1791744874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+3yULhkYSB3iBKZa9DoSkWbOJn4z19fRO7J+vsvirbg=;
        b=jzT1anrNHpIr6E55XF8HpMLUrJ5Zllqarye40EM9jzlCUQ4HRuA+q6hXFmShhA8c7L
         aPxZMFfPi9sQ3KGmhSmcHQhdblc0r6QoXPUuM/NItCaV03JrsPYwYuCBsWeXBj/ixFxm
         98lMxekjQrg+t3PJ1VAGhPuvOzSa9xcYA42po3DSNj1AGjNncGDEC1nVqFyt21/XCpiW
         /2RzSB1sbqyQc7U4dRxQLd2syNkN46ZWAS2i/QPjIC+Uggifd6/MjiJV2ahZkljCttKW
         P6cb4nNsus6rKHskuKgWOkbuEvQTdXYKwQO9U1F/TTHTidt+m8Q/nsN8VNJNPF6rieiK
         fDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791140074; x=1791744874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+3yULhkYSB3iBKZa9DoSkWbOJn4z19fRO7J+vsvirbg=;
        b=gFxQp+qO11/otJYzUtIfrKIkMflIbxtT/H8lE0+bfMzVaQaFi4PhEV2xU6i0/d8rwz
         ZCdhxWZapf99KxIQQIngWxUKvM0/PXkg4QsxRtsko9upH11pNZrKZ5YSZ7DBUvXZwnXw
         whj0t5MtGJRRCBl1JQ0eW8QGzv0H2nMRxmOlREOLoRI5S6G1nFZiungAqiTsI3GxFB1Y
         Hc+/qmfPHIKMq9nTC4pC++QoRqrtv+H9C/eAoJ/MlGaEqsH0NNNbEO9yQGR5a66G2T7+
         6zUbRgo1MSHXj6c36TWng71bq2cKsog6kuhwAvubojUvnoKBU1b2PU+gijLLIscN+fSz
         BmKA==
X-Gm-Message-State: AFuF++nKT23TH+JSraEnrYWO630qjQVmkfUj36XTOXcbmKlxOzlCbf8l
	XEFBrg2cpSGsyX8rIotp43E8bU+hGT9xNIeiqWqGJenU6My+jtmBUtnF50in3g==
X-Gm-Gg: AYBFou3L84utSH9+Jl2Wg+SnFqAqvUWB+5kfBk6pvYgyEHct04CCfq5KfCK31BuXuZr
	s89B0fNtKcY1/mr5+2N5qEAqiHzxlESclHb6wMvIV4WJf9xFUL045f+bmAReL+5EbLIg7k75CRt
	BF9KJAH1WytAXKcxoTCILbdUf5hWv52CIl4XfD2Z+5E0cuks/vJNDeRkZVnXG6kLfr7G9CanNbI
	Cw7zotX02dKaIsBf70jdpJumLf+aHvuGnoYuovni8B1ST7XxULL5rIsODwX0rW4DF4tUaOyb12A
	QCnAItehHvfOJ06VcYMgJ7HTmThpYKWYOKM492ZOGM0Q4Y7+T9dInasUj2i3oSAMbdUPmCkSdt9
	iVbrNPLha3anBRz8Qyu3JRm3jNrhAzwJ+mRciWZg9jNiMhPJFBZNNF9mJsLMp9AomP3ohkjsBRN
	Hr9f30IxdBx8dGMvZxd4DFJm4UoUlp0yBsb0L4bROlcuRYSQQEIw3B+Cnerqa9pw7AItLZdFCgC
	N3PcgL5OnwoZg6p
X-Received: by 2002:a05:7301:9a90:b0:34b:d400:e999 with SMTP id 5a478bee46e88-34f14f0b486mr10796997eec.5.1791140074139;
        Sun, 04 Oct 2026 11:54:34 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.163.69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127138638sm8452957eec.8.2026.10.04.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:54:33 -0700 (PDT)
Message-ID: <6ac2a0e9.1619dd05.1691b5.2a23@mx.google.com>
Date: Sun, 04 Oct 2026 11:54:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3174082848888636735=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: ISO: Reject concurrent BIS listener setup
In-Reply-To: <20261004162548.3968712-1-nicoyip.dev@gmail.com>
References: <20261004162548.3968712-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3174082848888636735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179170/

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
VerifyFixes                   PASS      0.15 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.08 seconds
CheckAllWarning               PASS      30.87 seconds
CheckSparse                   PASS      32.82 seconds
BuildKernel32                 PASS      27.21 seconds
CheckKernelLLVM               PASS      28.44 seconds
TestRunnerSetup               PASS      671.77 seconds
TestRunner_iso-tester         PASS      16.13 seconds
IncrementalBuild              PASS      30.35 seconds



https://github.com/bluez/bluetooth-next/pull/857

---
Regards,
Linux Bluetooth


--===============3174082848888636735==--

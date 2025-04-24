Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9912820AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514140; cv=none; b=Q0DYbXkj79jETz0otBHV/2NvTkoA1lMLAWRpQdJXA6XSvtYzwT1s+6poL5a89Sqz0QzqQLH+0aZTQrBHOKJ9qRX99Wzhu3xUSOlgb70iZSUlyj95B2zMD7h9uvNdtEIwuV72WWni4P/lkNL1SuoeQAgeL+rfx4xmolMpq3TZoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514140; c=relaxed/simple;
	bh=oZI/jFBGyOuRkzvW40pWRQrrUN6yPvLhxJCd1lO0dNU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nSolJjS/LMdhQ32XLz25aVzsFCanl7DtQWPfIvbbuEsdhJpUvPVRS25x8ZHMJ1XBZEjT2Sl7dJb31TS94lfpP3PXXz8KX/U8wzq0Kfgx3otclH8q4jhBNuzygNAI3zN9GKtstwR/sT3SBLQyQJUM9uTJx6mzRQ5LBLZHYlZ1gzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dniCCz97; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dniCCz97"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f2b05f87bcso13185296d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514136; x=1746118936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OBjz2sgpvajHoCILtmzWK7XbVRPlZ7NVFDfp2/QXvJw=;
        b=dniCCz97xiUQWYI5NvES/0o2XT4L1HfFO4g5VP15qT1xD402kYRqDFq71k0pkyonGs
         SideuXWFsTQXsVFH6k+gsPbKiLQffEATruli31AzRGuEj6I8gXdY3AqBxcX/Cj4NOr6M
         pn4OBLAAWYHRApcqAIPA1tj8eGPZRDX3AHsg32RWqSoNp9L5t7hO5Sjyf3FWSQ5YJBz4
         zIzxTIrznaOHXFOhKSA2px5XKms8k7Vgu5uDusT+W9pLqnDw9Aw3HflqzE5CopwSTrbJ
         MKkSpChWyljEKvy5Ci4TU8jevrqH+RUi8fz29h1JJ+yLv4vBXECEDrisCR0VYRyG0Hgy
         aH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514136; x=1746118936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBjz2sgpvajHoCILtmzWK7XbVRPlZ7NVFDfp2/QXvJw=;
        b=KWMWTJpk3Wnm6wDBPmm4LUvhkz6wj1c6KXLNw2EbC8TKeToSV7VuX8bcEMUodr/cZd
         X5ESmS75FTL2yNJ3hsBrqrgJ6he9pNtBJzgtig1qTVxPijC706/HIhipb4c+WSbQyizX
         bjxOD1MKAxGGViIyfXIB5qYhoQ8VDlmKRDTz8wyDyMaBOEEGmPK2OfFgZktKwKHhPgbb
         mMekYY/a8vR0haWmDu/NFmr9uEtupKHleZLLL94wav7S2/A4gO2TsN2jjbKmLRMwFy2J
         mu/BKgmlCtmOSDj4DHxviuzuVuC0zW5cF4Q8UiFnCKqTQxJITqHhRLOtou1ukwOzPUsB
         caLQ==
X-Gm-Message-State: AOJu0Yzhg6MIG6I6xQKy9lPe0ADy55Jfof2wQAf2aduV1Qgh6VAEr9tG
	U0839LyzocYTMWdrOrgJScf+wBDjC3IHdx76U0UOJsjzjoJoKT0kgV3cDg==
X-Gm-Gg: ASbGncuaPNcNmXzp61u8D1QmS9A24AhGUVOFyZVoYxTvzJqpyoSmBxNLwHhgL4JvUzF
	06BprUzhPY3YH/+uHRuDIUBPyOZO8uc/zLFNmFTxANY9HvnH7Mb3YdV1+YPCeJeVjlV4oXRGR0f
	B1NuDa5bmCH8ID7AAm3V31qaZ4kh+ovkDaAEtWic9dSQRJJKqMhnmTeBAKJm608grYCNO/c2pnG
	wk6n5cmtiZXqr50WyYRjT0T5awaYZvNsLJcbCnNGbcrA6Cp4ZOZVRq+OOaISpWfvrTxvFG69Niy
	t5Pcr8anNEzXpdDVUMUzs7A8VhurHs1Yu3dRXJ2Pvn2bXA==
X-Google-Smtp-Source: AGHT+IGhHbB8oqsjECEjTDtf6g0OUSPI7jqCoZ1iBgyS0NVRWhdY4Oin4PmfOTlYFftUPpa6oq7gow==
X-Received: by 2002:ad4:5ca3:0:b0:6e8:efd0:2dad with SMTP id 6a1803df08f44-6f4c94c07b8mr5475306d6.12.1745514135785;
        Thu, 24 Apr 2025 10:02:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.86.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c08ef572sm11508776d6.23.2025.04.24.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:02:15 -0700 (PDT)
Message-ID: <680a6e97.0c0a0220.20c3ba.6409@mx.google.com>
Date: Thu, 24 Apr 2025 10:02:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2940649665889084944=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [RESEND,v2] obex: Send response to client for Abort request
In-Reply-To: <20250421055814.96955-1-quic_amisjain@quicinc.com>
References: <20250421055814.96955-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2940649665889084944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955281

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      2733.05 seconds
MakeCheck                     PASS      20.54 seconds
MakeDistcheck                 PASS      198.91 seconds
CheckValgrind                 PASS      279.91 seconds
CheckSmatch                   PASS      305.41 seconds
bluezmakeextell               PASS      127.93 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      901.69 seconds

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


--===============2940649665889084944==--

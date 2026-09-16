Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674B472F84
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595470; cv=none; b=SWV6FgnnevPQJm765gLVBYPRdOAdmKwMIR0ERfY6tYm5+OfUY5SY/Z3Vu5S1CvWpdtV3aKRB9XOyaU9a1n5bwCP7AoEjVzd/6TxPOn2+BEIgWvoxrPKlbFLacNIz958Jafq2s65mlZw2EzKs8W8cTxdXWte8f2jgn/eHLq2yQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595470; c=relaxed/simple;
	bh=GbTx2TY7MpNZc1VqtsNK5mu1aXzmtT2klByL3A2u/Bw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xym1xQiQezvukRQplSXps2Kh57ARbjKGjX+02Fzs6n+zZ+6kB43q8ZgQq8vpzPke33B/T88ukpMTHIbQiwcCvgkxNE1Gl1iSCVYfJUKh+Q0TDG0z+EcXSMfuSCPO6zign0svPLN2Y+eIXioUzeGGQVxWEFTEE23AT1/az2FRfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNRenN7e; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNRenN7e"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6b1ae72186eso83265eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 14:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789595459; x=1790200259; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GbTx2TY7MpNZc1VqtsNK5mu1aXzmtT2klByL3A2u/Bw=;
        b=YNRenN7ePva66IvIcajzFeVITSlzUGQ9BIxQmCLpqx9vRxkMirevxO/6qhQHB5pFbT
         3IGqBa5Ip441NKedQSfpdfWadRfQLfITGILHxk6tuBueEghZ1/QOQACEmoqpc7PctmFu
         5SyELvNezO1VHYfZtGK0WRItigfwfYbh34k3RdB/MilR8RRL+IC2TBrbN4zYmuvqPyxO
         kRUMcyxnAiFKzG2ocwhmZ+Jl9mjnrzeLtd3Nxg9SCEnZXxhMOINWdPA4wTGclDHPbGy+
         Y3kkJLm282HKiNAM498yUXmR5C/JDG/PbQJlrVRKJTW/HOUd18ZzD/AnytLhalrb/+dB
         8SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595459; x=1790200259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GbTx2TY7MpNZc1VqtsNK5mu1aXzmtT2klByL3A2u/Bw=;
        b=TaKgzt2OqfIuNRkjUKWGEABpi5yjjLRDBIWisCrPSxsllUV6orloKIuq+XXoP2WInG
         Wk4ISoeIm04ilnr6VisZ0tmS2VkybwP0PvOcI4W9pHYkRKjQkgD72a3PFqrUba5MF+N9
         NPh7ES91iU7EMYAyc5zkb8Yqaytic7Xf1wo9ScuOxb5NsL2xa8plSfkQjJBCcpIPE7As
         Nb0VQp7NEBDZ4L+VbJb2YYYRlXq8VPz0Qs9GKe4vzDT7D5boxosXLgLajwXu+d/0hcLd
         e2WoD18cUoXQrDOywZCMO85C81lV/lVQPBcbNmyJTtntPr+lzxyOl19TxRTL/9s8/3K9
         jncQ==
X-Gm-Message-State: AFuF++lx/F/FQw8+yCsFGvp8ywhooykbJCOSpdYCTmSZQCxNoFZgVfnW
	0cY/mENswg37NILlW/tEzBmkBHqnxMqeG57X4kaYmghCYf0qu2aZ4QG/NBeC6w==
X-Gm-Gg: AYBFou012YcsBR14DlYb9DOUpBtTA0VhiJDr+xIyAXXABjBywaJTBaTCWeWkyMYM9d7
	a/gBw8MRSPKPS409Tsx6DffO/2jEeiIEDznIS+WoxRNgTehNGHHbqTKuL9i9A6V4DC1ba68lS6o
	rOv9iMv1D72QmWJYiLUvPUfAjHosr3lQhQm/vFgwBqqwOK2RCvTE4zBdcIqMr/9XtJk8nIXv2I5
	ug+g5SW7lIkwyGWg6QJadSdmuAvOhwmrbYT2qhJXnNlnx917LeAEB5zAm2f2vnfkcvHuX1idau6
	Od+6iC2ucmiDKQuFnh4Zog18gNVL7eByzMLLfvwY5Wh8PWPc1x+3CgjYyQZaIxA+eccNrCDzxeu
	jnRrlQqNvDxqU+QnCkaPAoyPdbuBb1ja2ex5oOgMI4dEkDGqltxsXXuOCQIdD7hP/V1NgQmzuUH
	whI5Ua+JG+D/t3JYBzW3roSpYUIjHSIJ4UcxZ22un6D1fouYhFdxxOEwXEltwURVefqtYvUOYdd
	GVZAqw=
X-Received: by 2002:a05:6820:8582:10b0:6be:731b:5544 with SMTP id 006d021491bc7-6c7d3502d58mr3052135eaf.37.1789595459422;
        Wed, 16 Sep 2026 14:50:59 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.27])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f79b6369sm1153052eaf.14.2026.09.16.14.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:50:58 -0700 (PDT)
Message-ID: <6aab0f42.2feceb42.57fac.5a68@mx.google.com>
Date: Wed, 16 Sep 2026 14:50:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2990267561521815233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kmehltretter@gmail.com
Subject: RE: [5.10.y] Bluetooth: L2CAP: Fix deadlock
In-Reply-To: <20260916193454.9996-1-kmehltretter@gmail.com>
References: <20260916193454.9996-1-kmehltretter@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2990267561521815233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:8044
error: net/bluetooth/l2cap_core.c: patch does not apply
error: patch failed: net/bluetooth/l2cap_sock.c:1548
error: net/bluetooth/l2cap_sock.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2990267561521815233==--

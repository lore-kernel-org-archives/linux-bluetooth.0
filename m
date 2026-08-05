Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA433D6472
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966766; cv=none; b=rLGRQtF180drYP/iBtYdL75nJhoIM/IEnLRUfdCWXtZkXDGwwdv8koX60wFtXozeIQlPNVTZaNgCmPmvmhxqeZqU3oz3plm9qFROdu8N0cHlsuEkn347IOtzrQEIS6T/m1Qv33gbd7dkJMYJP0zhCN2zoId08Y4F1dYnuXRgUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966766; c=relaxed/simple;
	bh=twMbHbNluWyXrZ9mKRyWJgP+aAyejVCzG6rbe6UOWdM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rIQ5TMAp94SLKOqbbdPV4akKc5WkOE/AZUCX5u61Ts30JymsHJKfAwmuWtxokeGXUUCYw+HYCNsPwdWHJQP+RtV5RrSbk6Nylrs7WDiKCziFONURyxkSnZWjxw9LOsrQmehjFiorjRyuIM8uIdJih/JbdvSboOQXsFbIaah3fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrBos8u3; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrBos8u3"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-45691990234so976773fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785966764; x=1786571564; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=twMbHbNluWyXrZ9mKRyWJgP+aAyejVCzG6rbe6UOWdM=;
        b=HrBos8u3ATRT0FBczo1QEYW7Suerz6HpLQimBH8ALRlaGaH8bl9MpADr63dIizTXak
         YyWHMiUfCpbSM4Pyuy0vANRk8DzZrrb7m1hykIR67s1HyHcMb+40XFZmev2p8AxOEWRe
         9phawsmZQiA1Oxhods85ojQErBcF/dh7L3MYdaRIGOwGoiS3D6R1ISdxWVASnkdp5ypx
         ujFT40xceuCDj4X63BTCeiPQnvjYlhdZftTIGzxoMHDVWS9RXEKaGcnAYCDGKsGPyprk
         I1opIJn5RAdcLexGSIVbtCOc1Q6cvGqUJ8ySHlqjqaYInyCEMhObOJYQ8vXtSkFI4pRG
         YuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785966764; x=1786571564;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=twMbHbNluWyXrZ9mKRyWJgP+aAyejVCzG6rbe6UOWdM=;
        b=IRLEt7OTWFQT8f4zE2/O9Gr78rjv64VmP4UNlLIinqKLGfmqiRa/HEmPm8n44n9RmI
         05oTL8SJNYMumZIywJxzEcBzVavSKcYsf5RQ0Nq4u+xF51L76kYss1+0nNdjXsU1ow/F
         Fh+n2quDxzSofO4IESysxXF3jSgXEgOntA0t7ySPSlyQPInS43gTouwoiq9XuBU74Pos
         NwIixs4YkxHMfm2o0KsOrIxZxwn8m6cnDAxS8fa1jgUJY5c/6CJTAqUiliMXWgwec9Wq
         NYjrr74CoRxahwc+PSjQ1fAzDsgqq3AoCJBzxeF963LcKLo85NzPpUpl4c5NH2JZdQPz
         OJoA==
X-Gm-Message-State: AOJu0YykVtviPaV25uXBcH5jma9O7X7DHI3JhZliNwXJpsQ5hZ2Ui9c1
	lk03Ew0yb0GVUxBI4ncT7CjBg28//Pndp+u/1LSxwNdATxoVNLtWPKoZWCZNhA==
X-Gm-Gg: AR+sD135Tycz3iZJcwNPnmzudMPX5lyqathaL9OMHVAsIy0phiyXtXU3gjEHa1BPTS5
	P11DbGF2t/rTr/0ZdyxvVYPp8vopj7ylrz6kczrofHZEY9xUfpTY3fvWFJmsmyKWS1DBaAYVKxG
	evultxMspRmG1vk1tbuwjfRe/J9GpVpWv7OTivLrrSmglDoAIXMaSWl7gq4imLHcRNtSWrJNJtW
	8CsHdu/Ff8p7sp7wxUwHjBLK+/oozykG3Vp2XGudcOi4ZNe7OWb3hA+bI0kX+07Sv7bMNDt9ttq
	Jqmx70kfIWlgan8jXky79wOHM78KlWcUNMK2b5oNYuGSYeyvjTWRhIdRa2DlFFxQt7iFhreNQEl
	ODHx9m8vP5UI0n+8xCGS6MbOZM765eTZt4mU/C9i4/cP+tsA+cPpr732uJB4upoei991BYF3SM+
	8djZH5u3Rp2DCHKcE736QIn0K2Sb4GhPsKhdCO3jUqFa9fnHPrf4B6oeKyXzAsRMR0wJzYYA==
X-Received: by 2002:a05:6870:2305:b0:448:a3d6:c2d2 with SMTP id 586e51a60fabf-4599eecd5a1mr5249465fac.10.1785966764414;
        Wed, 05 Aug 2026 14:52:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.172.241])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e63d64asm3562678fac.13.2026.08.05.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:52:43 -0700 (PDT)
Message-ID: <6a73b0ab.e0660744.1a430a.88d1@mx.google.com>
Date: Wed, 05 Aug 2026 14:52:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5170585292960892573=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tkjos@google.com
Subject: RE: [v2,1/2,5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
In-Reply-To: <20260805212435.48618-1-tkjos@google.com>
References: <20260805212435.48618-1-tkjos@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5170585292960892573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/bluetooth.h:317
error: include/net/bluetooth/bluetooth.h: patch does not apply
error: patch failed: net/bluetooth/af_bluetooth.c:184
error: net/bluetooth/af_bluetooth.c: patch does not apply
error: patch failed: net/bluetooth/sco.c:76
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5170585292960892573==--

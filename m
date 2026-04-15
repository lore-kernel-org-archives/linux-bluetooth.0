Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2362192F9
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292260; cv=none; b=Vv8JiQxo8hdQA9OBwp/l56p4/PjrWdqFYT14dMfGBO/5gRJ7dvrx2Ywna/aIH+iPC1Rzqinwp/We8I0NvOBHJ2grY+Wo1E9Bgk3vVKYEYaYajG69UMqYTzSnPTEwyUsAjR1Wx0k/r+eNqUAyim7TrMlVFI50DD42DCqg6HSW9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292260; c=relaxed/simple;
	bh=tbS5fKXSDhyD80xAc91aG1+Yd0ol85MhRUgUM1j2QCE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MjdKh7fME+WddFqd/XH6ImqFvKl+ubi898TeSCukle0y6lU4bSuVFqQVFMtiC371u7OfcW4wR6kjZ/D8FfUphDqTP8BCeQ2FbtQ4PTEzVPlGiVeD97bOGhbiZw3oxsSPc9JpjEKC9sHhLuly38RTuP5CQROPXt6Z6SP8CM5m9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCVmQj4G; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCVmQj4G"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50babbce85fso76158101cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776292258; x=1776897058; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tbS5fKXSDhyD80xAc91aG1+Yd0ol85MhRUgUM1j2QCE=;
        b=pCVmQj4GGnI5vh2jCZ7KDpoSR+J4K7mWgAmkI6LE6dvfJFvmHYCdfooIqtro10ffZn
         PGeTwfuNi/jlSq4DWd42lRx6TBDczjd+ddvpbLnk5CTMuEqI7YfOdyl+Sf5YMq0SEPpe
         XCOvgSXyYXvFDn96W86rCZLfM9BKqnpXNFq4/JPOmqc5ip861jIlB4bs3h/SdJnA5XU1
         8qZ+rRzfHcUTtwbEUhtdpg1EZH5IBdPk/Q+j7gSJbReynqlBDAcM9z5/tRe8f30QGlvV
         8RmhgGz3EI8IOJbeO/LUYiesFAPIJELRgYdsSJhK4zYa2JUeZtmqv4ixnN7+GoxOKG+9
         94Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292258; x=1776897058;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbS5fKXSDhyD80xAc91aG1+Yd0ol85MhRUgUM1j2QCE=;
        b=T4qxeDMNYwKIAF2okdCRYqKpN32wl8tpkvVDg5InxVJG+8yNM3GVR1jFshXw/BdOAi
         MJsdBR0yYKdak84dbXCbdYPvNDQ8VhUMtb+MPTHy7ZskTXvyb/RS/4czOShiKLdOMVjU
         4SPIWdSAkdBsuTv0uC0K/8GIx5+uO7AYGpOrR7tVWH4nEQ5P8LPsIoS99eJlGi6jUFZO
         zZcSFt8YuiyEyRk34ASnic9GqL3Zgw2Kgb62ldCHG+ERa+zlHeWRgorDA3/FJNkQBtBG
         g6ePtfS5gUl7P1HAIKa6Y9eJsUlKPv6jZ5dECvomEwLj01mse0pdnBXgK/HHqBGucMRG
         UGGg==
X-Gm-Message-State: AOJu0YzfUNrkcUv/Y9E2h5abzYWkSK/Mmn7Nh1dp7CFAE1nEhAb0EEEw
	Z5K8qUnW0UmjCEYjyVt/X2Hb1JwrjirDzb/6Ql9b2DDo6GJpXzm3zoLqn7nJ1g==
X-Gm-Gg: AeBDieuU5SafciCj5UXykysubrUSzzUznDUCbsajnnmuQvOh6uLB+ubERCj52WES+Pb
	g+vox/A8xskz8HCSL59QrErKJdh+rzkLUGf9CUdPUf2a9b/XDPj8hoLVKgeWhkp/yACXvseJdt5
	JnRCaLy7qhK2GkVWQkp52MRY3G5+WdZmUa3m9P24NKxyWu6ecAIQ94dDCm3Qv6FDS3OY2pMW4+x
	20pu4F+qzIqNaXLJdIh+9XM9cQr1dy9Jom6NtHjtNAEWCeekppnNwbiZgk1ZTjgpjGH1Njt67Mb
	YycYwgTFwaiQAsIzcdfCX0gXRvTogq1yXhi8CU1s3YtDnf/CE8fNKpmmBc/1KCpKlrQso7/+1HF
	Ivb6LdnduJCrZ+APSu9KQTioDn9kTN/piAlAtSJT4qypR5Li2oWOiHBdQkKsdAVS9MYTzluHiS5
	SvEQ1gSM99yccsbGNt38K6amd3/L0v4e5oPZ90rg==
X-Received: by 2002:a05:622a:488b:b0:509:14e2:89fb with SMTP id d75a77b69052e-50dd5b15ddemr340070851cf.7.1776292257984;
        Wed, 15 Apr 2026 15:30:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1ad9663bsm28026441cf.4.2026.04.15.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:30:57 -0700 (PDT)
Message-ID: <69e011a1.c80a0220.1a97ee.b20b@mx.google.com>
Date: Wed, 15 Apr 2026 15:30:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3367422848549252253=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: [v2] Bluetooth: hci_bcm4377: fix OOB read from firmware event length in completion ring
In-Reply-To: <20260415222454.1547214-1-tristmd@gmail.com>
References: <20260415222454.1547214-1-tristmd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3367422848549252253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_bcm4377.c:754
error: drivers/bluetooth/hci_bcm4377.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3367422848549252253==--

Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4E3A4521
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103830; cv=none; b=NQyoH360ufAViJVv6fL404C3/92VYiCEcnCM/oewZzMCBT9w9ksClPvBh3zQjRBIaqqm3hcqu1rOdS3Su5CrxA/2gaWJfRyHhcywBPKgCPvh+KanJDakiCBVxCAVWzjVEoZ3LXpAHnSmJ7gf/CCr3X4AiGJFWzDoai6J5o+0D38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103830; c=relaxed/simple;
	bh=gpcQNlvqERhgI3qIbAvEuHIBLIl5lGW8RSLNrqWl098=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P8LozgrXhsClQCsjQg2hEdx7GqTtTvi6X4vhhmDkbKmZ7DMK9gqujYu3bx1ui8iY4O7IvOG3vJItbEuBKeDN7sA+KlsUPWiK6o2ZoZeFKe3o9x/B3Oqb3hXdc1DLF0opShFxKXVZSYSR9mYv6n/hqdNYTn6rWkbp1+gxauGvU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji13f7Gm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji13f7Gm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso498790a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 22:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103825; x=1789708625; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gpcQNlvqERhgI3qIbAvEuHIBLIl5lGW8RSLNrqWl098=;
        b=Ji13f7GmhddfYEQxoHIvsWGdW9oG9J5zC01OzU1c/bsbVPavaIx8y/OBaZnJaNyqwG
         mXAQFCiWZrlrgFVareDKaRPVeti9RF6kYOrJquro9N4WUwWho8WsNjxowrutUgrD7QyF
         8ckUaz/4myO2OF+U2OwyiFQ6/ZjSAG9MlLe3Rb1onianMHCU4pfNFBintEIdBoiasF3A
         QyDU6AnFGhg0SZ7yge9nvwMRJ6htVR4gnQ41p9jfhvNOaNXYikCKaduQJdfAGIkW0/oy
         /sQ2CVxITc6S076RjNxseByEdusGlTcd28veVbN25GWa34jCjFHZODu+PAlm8zuiP3ad
         j7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103825; x=1789708625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gpcQNlvqERhgI3qIbAvEuHIBLIl5lGW8RSLNrqWl098=;
        b=j8wkn6b9+q7+WrJE1SoLYp+S7WdHGbk03q80RI5RxjLCQeTCoR6YtRDdLMUjlE1gfn
         JAkwH05BuMMiiQu29wNkOti4uPdx8kYkDjpT1WiORow2uSrv1N+9Vb/IP+wmyqIdUdGW
         y6dthGpzbfo7K5TftS+N0nJzk0ftcGY57Xr/XPZEMSCscYi3JQUc3tvGEsnnUO8U1d/J
         P10jMfDH98Mr1mP7KCmVzptekMUv64jmCDsfq2oK6ZKjx4Nw9EYE7pnljwvJB8ybKeur
         fI6IPME62KpoLPcZMobLIjHEWHFt2DRFkMcDKDahYC9uy6ZndSQ0rr7rxKjcKIc3qkcs
         /eJg==
X-Gm-Message-State: AFuF++nNknCer4HU9DUIJkGIBLVOeONhLNvh1j5uLsGGiFhJL1T6uY/3
	/U/av4yQ5yAyJBkkfU47hYehMD9GU06lLCjdIeIZUrCIMdMA0bofyzWg+S6d+A==
X-Gm-Gg: AYBFou2Ur5nSnWgkok8v4Rz/aFay/WKGttPmTPdBOau/xf3BF2T5Q6kOsQNCc6/X9HM
	zvhGK1iNN83nHAfo3AUIipI4+r1kh2oyEc4ttoSw0iyuxV1TojVGX6oYfTtAWodAyR9Cz0sciOD
	lOG3X4z/WZgJOhurTDn0CEvwNPcURLYbSiNzkODNrHO2ctjLPQV8xw1YoGWp4vTwLcWCwotNRJn
	yB1Z7hW7noKXxImAFt/bnjmn6D7WvRPUba+L9cM5GzWc5A4rejws+/8Tm0RbMMb1BCN/vBlbg+P
	+OzM974R2P+6RhpJKwDdR3YaTGWnq1b88kmTps99AQ04CA+0YXe+T2Znhs0y/D31AwOgAJfHFr4
	FoR+gKv1clNZcsKmuUKVErEJSq3Lg/zFOME+fN/tgN9Fl3p4kOowytw5k9ZrC/RkfVJOwbaChen
	xwCGRKzfjFeKmFbQP8qFRGamenqVadM9uYzXQznTTuwHxMm/VNC/qfHZ888zxBN/jZKLJHTIXUV
	gjVMQ==
X-Received: by 2002:a17:90b:4b0c:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39d9c1bf05fmr3704710a91.14.1789103825363;
        Thu, 10 Sep 2026 22:17:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.229.73])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f0feaasm3055406eec.21.2026.09.10.22.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:17:04 -0700 (PDT)
Message-ID: <6aa38ed0.ac292227.3c5dd4.6988@mx.google.com>
Date: Thu, 10 Sep 2026 22:17:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8330904393816978243=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss.patchbox@gmail.com
Subject: RE: [v1] Bluetooth: virtio_bt: Fix probe error cleanup
In-Reply-To: <20260911024124.1527637-1-oss.patchbox@gmail.com>
References: <20260911024124.1527637-1-oss.patchbox@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8330904393816978243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/virtio_bt.c:315
error: drivers/bluetooth/virtio_bt.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8330904393816978243==--

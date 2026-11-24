Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544543;
	b=vy0DN8QZMFu9qsHjImuEwV7Pm5PrbKjI/2ERNQ2dcDQIgD6S6E3v83gpk3v3v6tas01o
	 hPGZ4P/Trld2hPQdjje9B3OkqIfAdAmbbUemgQ7x8CkueJFxDwumnfqFOi14jsPcgf3pM
	 wlntUfz/nrvwIRZx3/RRpR5QKtubGB1Pii600xzPWX6pKLLvxx4jVJSzJtIEVSj2EP3BQ
	 FmoX7lUEqPEwSPczQO4yVFmkOiIPWke0uoFyTO5cG91EFrFsUIvNiiVlIXtzYqaXWQLSF
	 HkuBWTb8KeUYST2TEcrLKuFQJEf8zt7FOYpkEqMgkxFC+TODbOvMGO2WkqS+QaPhSBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yYhdhCp0t4milWsUfN1Akf1uP+67Q1QdnHarVQ4Xjtg=;
	b=NuYTWxrB4mjowUwGoS2BhUgKY0KAyQooS/plEkTiCxqlDDXXH+/GpN/VTEA4WPZf1VMw
	 BKHmWxj7Rk0MeqsqT6Z8ASWcpLHQ5xLCk9t1sZLtRxjIqNZLH/k7sFDBlr9vagcwHZ5TI
	 IkPHSaryc6fD1QaXqTYH3bXCrTlVn+/uK2liPmacfzNTdmC8R3x09Hb8iUWFUIRs4dgvE
	 jEmO3kSeB3SKcGvIloP6vjH3dNkjXV3w2XKNKSiCJUde6DVkk9QDygQyoD5bKCvoNEJB8
	 ye7YX3+xODIrjShbtBVfuIWkktq9i3yEwdU+dmKbqeyi6FMWpOpKE8lr3wm2TEp6iTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9sl2rDp;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769C606A33A
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C769C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9sl2rDp
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-537548b811aso40538871cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795544542; x=1796149342; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yYhdhCp0t4milWsUfN1Akf1uP+67Q1QdnHarVQ4Xjtg=;
        b=F9sl2rDphZxqOzaN+URPbCpTgl2hXv2riFrH99yAgJCuJA4UAsdwqRug3eV2yryxl9
         Bcx+UNP8KCFnKyGWaKc1Ke184MGQSyJj8Zq/XC52/X+cx9nsj1IkbRE5c72nj1ij5PwJ
         eaI5l/ZOsi8g5NjSl3P1OJg/l4fpGqXddZP8Sj+FV2BK9+iYfHzQSz691IH+v64VJnow
         4XVbLvu9H0u6fG1m9pr4MisvVk1+6yr7Dbi88O7rSknvQnsdxZDHhUqZB6hyWjoXES/H
         Xo0v1SsDBqeUxvGG/3AXeo7KSfdOIjL5jOK57nNgl5JNp6o1DLA3hFqjkdOm+k25V2j2
         4R7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544542; x=1796149342;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yYhdhCp0t4milWsUfN1Akf1uP+67Q1QdnHarVQ4Xjtg=;
        b=stiTON03PYkujVMlvA5RWK35MKYPRXe+aCa3BA2WQe9Kpqs4kTPsMgh76cLECkF3UO
         BLCsRXiDpvKQCv2foMswwaJPlP1P+NDaA8Cqn5qW9E2hB0pSDdLSq9WIB485WcpHg3At
         DkcAZrJEw56FoTtW1Hl8Z5JSxLILiIprxsDbpen9xknXiFYDc4N3iGYzrALck/Fd2HFe
         zLAMcP7vCCzQoYKS75EU77vGTF/CdXeElR9SUF6xWy48qzMg9QJAj1N++A2axdpjotzL
         kKX117ioxY4rf2aMXo4f3n8zN6j1SQmLPTfysSjh7TU6tPxJ4YxVl8Gs4Nu3qCX3/QlV
         R/WA==
X-Gm-Message-State: APuU4Z9aXqnZfkRnM329dRpV5AtRIRfsfUX+lFIltwG5Jl4NgiF1J2Kw
	g/NP3Kn1WOq8Pxw17IIDYtfZ/wE9a6rKWSxWSdrkPPnZgGYR2GJ1pH8ykCCWvQ==
X-Gm-Gg: AZFdTZfMK+k1N56YalueEGmx3cXeTL2g0k3LI8FWOPOCELv/mNgrHypH1S2Jg4O8xmR
	KnWj5CI7WOcj9jlJBk/+lCZ+x39bxeH99s/a9RSJB0O7KnWmS4i68z34D+ZBuBDH53Km+jqzc6J
	hsGFpihxCto6PLb3uzAKtm+50TJ9pmKNudIj/Y0NBsW+GFvhXV/brOtjf/FSSWfnt0mdWqrA6Pn
	uoKEOWh/1gQFY9w5o4MbZzhRreuZIfuQ46aIMVc63bH+GzuZ1jsH9nvxvbxqOmJKHmW88lVgJ8m
	6oan1QJM6oFCqcABUSh+HHiPaUZQIsUMwKbgLBDUrfP1NJ3zNVVa3q2lohgB/8By7ad8QNZ1r+P
	IIyjhvWGEg7hkr+6J5zxfUw9wDu9jz7tWINW1CE0qn9fLM/PWXGoMSDWdmLYQckIvG6b1TUlN/w
	J2q73spytlXidfDKIzhDfmpkTgexrrWV5ictQAdwdIyViuBymmjuOqGZXYzSxd7QXEUIDQY6WVe
	T6LXOODCVobI3azxqKejBbKm0MCk+ecEQYOeLfP3I+ZsRs5ERxmr5yr3VwRzHPWF8I=
X-Received: by 2002:ac8:5f89:0:b0:536:119e:1767 with SMTP id d75a77b69052e-55d76a5b233mr294306061cf.65.1795544541626;
        Tue, 24 Nov 2026 10:22:21 -0800 (PST)
Received: from [172.17.0.2] ([172.174.199.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55db5ac09ffsm5830321cf.7.2026.11.24.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:22:21 -0800 (PST)
Message-ID: <6b05d5dd.fcb1dc2c.10468b.dbc8@mx.google.com>
Date: Tue, 24 Nov 2026 10:22:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5984361716822278549=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, leon@kernel.org
Subject: RE: driver core: Authorize device trust before driver binding
In-Reply-To: <20261124-device-trust-core-v4-1-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-1-037eb0d17b1f@nvidia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5984361716822278549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/linux/pci.h:616
error: include/linux/pci.h: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5984361716822278549==--

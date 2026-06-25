Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7791684B0
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408412; cv=none; b=F7OhdiP2MpuP1dwCY2z2Ygb4MLMJkf4wmAJaxDl2VC2ZRw3gfaLb90y1bpWfvYKBfC1NdcX0nrtruocT7LgmzxYJ1gx61EXOUgYIhHUq4Je1zaDSSvrtHOBWQVXB8zCrK3xqBmtUEbTryrd1+8S6mW01jPFreZujVBNL9lZVjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408412; c=relaxed/simple;
	bh=1Wnh+Zpl4IKF9RpGFJUDVJouoRlsRUfkxAw5L4TVJ0Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WaXadi2vn06+vQh+UECc/5R2g12sGQ/V8q1x+XGQ974ZtVrq8NtISYgRYvvO6BQ8u9QPpIXpsXYDfT4QuocxcNuB02xlN1xzAeomt4ZuhrNKHOKu0QlupF/p5Ym1b44r3n4HIRsyFm4LiYHf9d4MY/C5Dh2fLrlq6bzJEJ6UtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6WNLeBw; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6WNLeBw"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-139986373b8so187531c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782408410; x=1783013210; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Wnh+Zpl4IKF9RpGFJUDVJouoRlsRUfkxAw5L4TVJ0Y=;
        b=U6WNLeBwoSX1rbbMVKcXi9l4rEUQ24D32+v2BY6QYH4vfj5da65MH+d9qs0xRckrcF
         U2RK3gHcR0tbJSoZt1MuwEIkYoE1UIvMh4U+f3uWVdgEa8SfMPMmhtcQtmysUizK3fzd
         NHt24iW5mA5JyeBcgbnKok9rax1pllTKhYpmbLx+qZYMpfGCBx4BMkAQ0mLH4iRmBGUh
         bExiC/0koD2XloY8m8533koDKkS8zmxqGEQneUA2/6A6dpnfO7IgThkbQtqskJ1dr879
         uCYx3AJE6RNPhBiq1V4atGIyjQ7Fhp/tsF3Yz0mfoDuXc3f9cnh9yAKupSxFMWov6/wM
         S/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782408410; x=1783013210;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wnh+Zpl4IKF9RpGFJUDVJouoRlsRUfkxAw5L4TVJ0Y=;
        b=SyhrC2DEey5ZJ53i9wFQAsH1xL0XEpzDKB05CW0xLkydte6rkSlciUmt72ZO1hc/aD
         dlPZ3vNuLaUusv2X1HL6mnsIsQ9l8aYZZraW6i/aBen9jDShrN4OjVBg0u+TujFzFKPE
         1qCihNOxtOJmp6pa4TKZ4atuHOCkNG5fhhwYbgnybKpfn0Wukj2JUCTo+L3UouVKlnyO
         R9nOI5nP9nc3+f6OUk7z2YeAWAP/TEsMGKI3OChNiGETdRkFJ9YjQOpIG5TWnTTQmbHs
         CmNY64OrzXrtXKanR/Vr8b1MCdTYd/cR9Dm6JrBDvkqpfcbbqP84UuyaaLZEUcXR82kb
         7vqA==
X-Gm-Message-State: AOJu0YzzFtOr3c2fvnmsYKOYErHm6f48QnhsNp3hiJ7UMpnD3CZx3UF6
	H/vGmsdrV3FoV1S53UEQwQFKHC1wlfQOCgdjbciRQ+CLpcl7zRuuhqWwpN3x9Q==
X-Gm-Gg: AfdE7cksphGiMLrpyL1nxgEvlKiryfCSWiD6rEsEkz0bT//vAUzSa7tAx+5gfXTT+7S
	etgw3NOuJUYt5DjgMaIez6R6LlIW+LCavmUz6Gu25oSBI8wmhbYR7mNAiyFtdTIqFrYX2067yoZ
	GZyrsRmxwWj2mKkZ83ry/snuk1byAGQrRUEzPo7CGVXgyv9fMDW0kovqWLly08uh7MMlpnzHa0q
	52f3H8g9iupciGjagC+m1r0+Is4f6+JMB8IrNFFislCAU1h7QEi+gvWWr6kdQKDla+mcgTdHeEi
	n4PHuD2yy5/MGcnbaxwz9zl4fKAfi2f03mV/QiIu2pj9LtNL8mFsMe/vzrxhHwxwSxT7LYoYJ7X
	utoP+yxYJ2ceJ6n+kF970+PbpO4E7JKvtBfKMNu9RxiR/xvANyyAJS+3OwpF3vqCwiFBWeBm8zM
	dqO9r7HRKyNejGyTKkXGW+
X-Received: by 2002:a05:7022:62a7:b0:128:cf80:deea with SMTP id a92af1059eb24-139dbb1847amr2951097c88.1.1782408409863;
        Thu, 25 Jun 2026 10:26:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.178.104])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f55b04sm10205713c88.4.2026.06.25.10.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:26:49 -0700 (PDT)
Message-ID: <6a3d64d9.e1ebb1b2.8c9ac.b337@mx.google.com>
Date: Thu, 25 Jun 2026 10:26:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5288354127271637833=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: btintel_pcie: Clear hdev pointer in error path of btintel_pcie_setup_hdev
In-Reply-To: <20260625155149.79838-1-vulab@iscas.ac.cn>
References: <20260625155149.79838-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5288354127271637833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2478
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5288354127271637833==--

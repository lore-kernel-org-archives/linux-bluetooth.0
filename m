Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729104;
	b=FdHYlh7KQZHlIghkBZzvwChZPI4YZZVFj0bMElfcfrXVgRJwLwMKqcnz2n5J0MkaybnS
	 +v4LZwL3coiuD9/BTClA4289fFs50WPJEOrW5PYEgDYYfpEuOH7MLQGKKCkRn52/S+6g7
	 GZfiMgAp6tbd6rDXnOJheV6cUBPNfd3nuw9uUdu5ChbAxnRlBgTgphKlGpk6FjRgH2rzt
	 i9tEW3Noct8OhfCJTTAJChSGlwo98vsskaZuL/htAoiFrjg7JUR73QiRQ3yTkWIdwv2vf
	 VozKRMrpevV8l2pE5CQQT/tQPV6E7BgPa0n7jpT/Wtau1e+IsfSKQvloLl6V2NAY/0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=gpL1zyjzi0VMevCFm69Nucud5j0Ze374w2cQK8IsPDA=;
	b=e321exyHWDP+ONgifBT8Rhrm3CPxzjw0v4jPfYxPyljWqFM6UID5cyweq4viJJU+QrL6
	 JNdsnCze7xktdzgq/4q5mSe8imay3eaVTgCpGQ3ieRdhBVsm8xJE5M1iZTZfsXmWI/gOu
	 +6AYPP3i4F4iNOemcr0eANFBjDshixndsXHcS1luyF6xSE7+FRHdXvK9Uj0N+Rif+QUi6
	 TgRY28PONpREaSrPijmyWvYQnGxQBa/x99vSOdRTui26aamHGd9H9rkF3FEc4RxEQL/Kj
	 zCALdsyzY5mR9Xe+iP0n3lpKdhG+vYH9ooSt7tx00VEi01ja/1OwXFoUnrSxzh0eEbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YofwG7/4";
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7930606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 21:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7930606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YofwG7/4
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-483a66818edso3853129fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 13:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729103; x=1796333903; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gpL1zyjzi0VMevCFm69Nucud5j0Ze374w2cQK8IsPDA=;
        b=YofwG7/4yLTm1N88L00jMljuouph4oKiv3BmW5YCnFSCjHDe1aRr2Qs8DQzgeXwWlI
         4VRFNCPBVSa+msA9kYC1iqpDk0+a+JurAzQCHB0XPYelFo3ENIqy+pfC3XWFPCjF1hlh
         zpaQ11NibrqyEi3dZynd/JqW4tEeRBtV/mZjwIa6+vGRB5VOCfpUSgoPwiBlzmh5b73p
         YfiAogKSKfYAtqWrcy0zFo8MkT9oDTSAzGAWfxEhuMMLOBWgGmHMQ0ecTiDS3PBecN+J
         iLOhhbpAaVhVPN3BXJaCNa/RPFjV3f5PhQu+IYXWDY/NXBjrsHGn4OEZy5VWaudqazZ2
         5E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729103; x=1796333903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gpL1zyjzi0VMevCFm69Nucud5j0Ze374w2cQK8IsPDA=;
        b=nQD4/PYm2ZYv+Erivpp+QV4B0HVUB6ltAdHkPSZvAh5b/tI2OkwIfsYnFgsfvSibsI
         wl8dLTSgIyO04ykEe5Z21f7HbSasoqGtG/dOQ45CTUZvMABpi22qmDWz66rqlv7FHVo1
         dL7GAB3qUBZcj88kCF3oMYznH4w48e4n530mQwKqHq0sGCk+ApPHST7Al1mXofxb4rHN
         oTS3a6Xta83t4p7harmKtSMUSoegHCCeqS6PhRsKmrPd3rmkuxDlGrQPTdz1vOe6xEx9
         P/Sm202CRG+qI6fQc9x+PE0KCX2x+GvsC44RmB5nrQg1r7LD+dIfwDFeWK7X+aoRzQv0
         L1dw==
X-Gm-Message-State: APuU4Z9w4WcO99HmfBCTC/O1tYySDTZw4/a0U6P+X+6PI6msyrYEAg+s
	khNE9KLpB33gM+PzM1Rcj/Y1RqHpsSnoJfM+Fm4UJF85tP2bz9aUJc/vsTJqvA==
X-Gm-Gg: AZFdTZeFx7fNhsU2H4miiNEaoz4e3rlsVohcZPrxDYJ9NC0xAktdb04QR8RyASLtw+F
	LCqgDU+zvtkxjKL1NwncLuz254W6W2UE6a7gjz4WqqMOd+hMn2li4kUoKpSRkREQoEaKvcZVp9l
	JGC8az4sWp3UGD3rc+a1uC7dK8keH4/OhTyU4a3DPn/cfykDuMccp2lG9MkaHiBUIf46dq61/yW
	wjAj1tNBYwQFeyU9OM3bEOF8Nd5GSpgiZcuVtEi3L8FbsGXmAVxgUecAlXmROl3BMDG7JYT7MOB
	aJ7Re3SFuS/ugTcCqOuB+XQVCdr720Aobbe/MSNASRU/zL/oh0mXURvw7zNdYfcSH2n3qetgoob
	RcD8ytgf2iOPbOxLlvCg0QS11k4mVE7UxhKfwh4nb3JMiEXXHOfPvi3W3MzMln/bXQ7x2ACszdp
	kc18/WXuQ6C9FNYoHcOhpaWV0z0uaDMEO0odmRpAW67kEZDl4NsRqFUtAdXOpG0ztYYw80X/tuG
	f2XgqfexZGSL+4yWO58hbD3zZuW12C0tEumDzBGpsdhsoi1sH7yf21yw0RnwOc4
X-Received: by 2002:a05:6871:cc:b0:4a7:4324:1807 with SMTP id 586e51a60fabf-4bc819a3790mr21449057fac.12.1795729102725;
        Thu, 26 Nov 2026 13:38:22 -0800 (PST)
Received: from [172.17.0.2] ([52.242.219.121])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdc0bbsm18922712fac.6.2026.11.26.13.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:38:22 -0800 (PST)
Message-ID: <6b08a6ce.4076b79b.ab1e9.2bdc@mx.google.com>
Date: Thu, 26 Nov 2026 13:38:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7645790952452603490=="
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
To: linux-bluetooth@vger.kernel.org, dickson.wu@certik.com
Subject: RE: [5.15.y] Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()
In-Reply-To: <20261126-so1b-bt-515-v1-1-e657824c0e45@certik.com>
References: <20261126-so1b-bt-515-v1-1-e657824c0e45@certik.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7645790952452603490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sysfs.c:11
error: net/bluetooth/hci_sysfs.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7645790952452603490==--

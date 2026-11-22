Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368156;
	b=qyy80ZKlc0u+duuWcuUEnHtPOcp76jnKHQDvzDQEa11AqYLumcoRw7x4dWBUGY90g/Rj
	 IdrDXU1QXmKN15kswtJOE0XGNr4OncQSGhcsNcCMu0mCyBvGNBkmMrmINQg+4H+/WsG3I
	 qcyq/0PcAwK6Ggzy/xjwqTmouNjR0me28+DTKUWBWoGmAdVsKYrbRoVk933I4CeKQPPEW
	 nX3j/6KjLQr5enhftoFsFex67AQfx7DCm3PM+I7ixHPmAPDZseKLhnrYmwo2mK5DmxaQo
	 77XKjyk/UVVxKaixFTLGt15bSDhAxO8UrYgAiK5fhWyRGFvjuvfeWXjy+b5GiJNfd6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=foTn+R8VIU6taHQ+jJeLL+Ol1l3KtmxqWqjwWx6+Nw8=;
	b=5jmw33n6fcqHJbZ0Vs3WlkGL3GsqWfSSQX66YvI26tMy1WuI9TwdY59kRHJB4XNARJ75
	 Rhvcjucx7ZU3Oq76+Wu4/AidCtJkmb8dliK6sAoOcQu28XcFpfqyRpOEzubmNRTq5MeFt
	 s9oC6564BwwS0kexa3/vavka0x74iDK6bEJ9h2cAgjrw+9vcjX+LO6NRlFrWscxkPyPAW
	 dSX43ycUyrT0GUnONdpLsM9h3YUk06FQi/5lnFzQgfwHxeArUwcfu4oS7qcJrg16uHDVy
	 HJkwUGjz0OiwInbbcnadjD6CGFCHdmkX4Kx8acavrtMdzhYQcHOc9Ea6KkPqWW0mRNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mPHCo7lK;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF8606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BACF8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mPHCo7lK
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f048476ab9so17153995ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368155; x=1795972955; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=foTn+R8VIU6taHQ+jJeLL+Ol1l3KtmxqWqjwWx6+Nw8=;
        b=mPHCo7lKUGH1hkA4GsVcb/BBxx/PsxZR5G74T4cI8D+GZI5gl22JLvnftYVlTuHIqp
         0bd0DlxjjtpOaUYQfPAtfjm+EvuZUdZE2qJOc5++syVVlxAC0ouTMN1ALXTkF6rYAhSR
         WUX1HmvGXvo6eBstE0ylWBFXdpg+E18yzXmmIo7Cx+xuxBFVgOaWn2StTy8MlcY5XKx1
         fPdh2ivJnSyHUV+HI4oJsuLBNIJGN1Prwyfq7/4M2oSzDyQrcKXW56iFzy4kd9CJ5541
         cTNVtwTIPLa85dRlbfbfo5YrZF0sk/VWVrFNCSYl9X1HSoqmUeQti/0A/TLiS5B0hmOe
         CUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368155; x=1795972955;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=foTn+R8VIU6taHQ+jJeLL+Ol1l3KtmxqWqjwWx6+Nw8=;
        b=Iyed/ehOlkxqNgswZPbZJGm2dVKp+LOhNNLBEprn02JgC5pXf/bimD+XiOomBXQinf
         cA0TywFPhA1PcyRTvndj08X8Z8Q7ATCU70ZYi0rXsNyQQIWicbtXxWLqQbTMe997BCIl
         4IG/fhjNkdIJwy/QrDAm+h149/afWZUXQ1KChE1FrdAw4v7MrDoTZy1pKgzgsF0McgHY
         XbaEM+YBPbVMwCUKQePCo5XIoLeId9XyRN3XRT7sNi2amN5mDmXKSPCuHoFEInBUPwL0
         8ZM/5auro3eRnAGhz7wWshgo/k2Pm8hAFE2gGXWYRO2F4tyS3JtYLr9jw9TczOEcsuev
         3lQQ==
X-Gm-Message-State: APuU4Z9yQN9FyYCRrzYABBWdgEGa+xVZ26b6RO+NcDxzYQmMSglnzDO/
	zNV0WvUimpezTAb+gc2x/H8xEllvJIFDOuh3QthKFzSoZ742MOvsvzaOLkASkw==
X-Gm-Gg: AZFdTZew1w+vFCV/h5xU3neffityrSb4pkDlGrm4Nds6GDXhOi+vaMOk2adbVVZArpT
	JLpznOTGiROTy3ENlHl2/WrtTaoSdyW90Wy7mJrZC0L6v4Jxl7zrUBOfzpfiOSn6Qy8CrVCg+Mf
	BXDnmS0wijl47x1XzS9o6A+5vDcdKtIdwoI83TB3PwoPkq6K1FhJFfAbVe8WR6qFsFP5/k1cCQT
	2XGiJi+cL3HwwPCz6hqtysCXA4rG3L7IDWm1emdVcosrN41hExLKppZIxUJwmZ6nBSKU+aiQPld
	iHi6A/nHDha30eXXGXpOw3Gj9sMkrEVjG/cY8YzTzXKdcTNU6kzGq3Zl2GHPKs+ZiJx8rDJ/xMi
	17k68OozVXXNe0RWNeFgW/4HJQDxuGKVsjygKpRSTNQBgpLM5G3d5wZPIwezBPwYCo7PerEfjWx
	TdXgEUfkTU1Ur3Tx7vCrjALYRqw08cwsJvFJv1av4DpZEi3J9SuX7tN7DH5sEbKRt3ns7IK28tb
	VdsPju0u92pn+y+RxC1+2hdCSo32+5SPmB/VRIhthmz5KGVApqJR8Un9yuQrHoWqRyVIJScjO/E
	+qOZAnObtbSUHFetYjQIOB5K4ClnxcNkQfANfGu8
X-Received: by 2002:a17:903:b0e:b0:2eb:3599:aa2a with SMTP id d9443c01a7336-2f03f18520amr94503455ad.56.1795368154939;
        Sun, 22 Nov 2026 09:22:34 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-111.us-west-2.compute.amazonaws.com. [3.42.157.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1215d7sm38699655ad.65.2026.11.22.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:22:34 -0800 (PST)
Message-ID: <6b0324da.e6d8240f.64c7e.9b24@mx.google.com>
Date: Sun, 22 Nov 2026 09:22:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0216706037545583532=="
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
To: linux-bluetooth@vger.kernel.org, 26031212468@stu.xidian.edu.cn
Subject: RE: Bluetooth: RFCOMM: hold port reference during TTY registration
In-Reply-To: <20261122131850.44042-1-26031212468@stu.xidian.edu.cn>
References: <20261122131850.44042-1-26031212468@stu.xidian.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0216706037545583532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218628/

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.16 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      19.75 seconds
CheckAllWarning               PASS      23.05 seconds
CheckSparse                   PASS      24.02 seconds
BuildKernel32                 PASS      19.95 seconds
CheckKernelLLVM               PASS      21.65 seconds
TestRunnerSetup               PASS      472.42 seconds
TestRunner_rfcomm-tester      PASS      5.66 seconds
IncrementalBuild              PASS      18.41 seconds



https://github.com/bluez/bluetooth-next/pull/1180

---
Regards,
Linux Bluetooth


--===============0216706037545583532==--

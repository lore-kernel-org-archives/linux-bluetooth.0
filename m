Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815478;
	b=oNLxc8ImJpaxonSHKchmU48L3US4pS0s+Yc/Vk2Dr0eah8JD2KwSF4RBNZeKmEZo2PwL
	 cVKdVmaKxXCPRnu0qk1EPw5KsiKCdYf4zdlAbxyhy9ey9iGzte7IkKdV73GRpS2Hyz5j3
	 IMIHrDGsFwVK0KRsPS0S4PZyFcfGB1aMJZnNESo9NPiYcbTsCOrGrJd7fInIAwCXmJ9mp
	 Ftq5x5RVBt1dRAPV4Om9qwSvXR0+Dkft7i7MDv9ehDwSvuWc+6WbuVewDyegC8mL+Kjwr
	 Ak4eQ1ezW21Rf1JCVmciztvDtNW6V/mwE1nZuMh9i3drinOtAxyCvgnVHjJIGRZ9x0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0xqFQ8EFSLScO4Q176xI4tc11w0iLqrVbV3gNNkVC8k=;
	b=KrT4ue4GH7YI3icpFOxSZTCSX5e0C3vDdhWACuCQFV9/pMeU+uWpnABvw1qu5QhXL7sg
	 xaHeHMbSmc5yENk72KOdmgnRa60fhX2y2w6pJ7MpQ/ZbDEcf+vQ4mdQu4QAiGOTZF/861
	 GYWH95px5+A/fw75gwkU/Qr+EAevr1Gj6R1aD+DnSHCUiu/cdr33YiNZElRkevNfRtDKS
	 ddT+3YZns1K/XhU8jzBbVqHQ/hkZtAf4HdLN/l6O0B29ZNtCrHYNGAjR2dkg0TTxYMOnP
	 BERvQCA6fSfkUcuR900o0bRbJH5NE0zGrJKjmpytojKCIOQ6mdtMSDwJ/6ij8qLIO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VSmv2pLl;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA0606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 21:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20BA0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VSmv2pLl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48df4f7ccf4so617182f8f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815476; x=1796420276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0xqFQ8EFSLScO4Q176xI4tc11w0iLqrVbV3gNNkVC8k=;
        b=VSmv2pLlssZF0txMVM89g4x/WaZRJIz9Yv+tATs4yuax6U2Lalw58UQCj4xUOEU4Ws
         cm7qYtThJVFGlldkET72ndzUbCMD8fnebT4s4yvR79Q0cfj9jmZsbmNLcbuU9n+CMXf2
         3z2C7C9VwRp2G5gJG6newoC2q1on5TznUdqYkfM/WW8Vbm+TRPRvmpdPWz4hd0oTEGQR
         wV/oiqzR3956CfjHhPbuIhGriO0MKH5hY8nPD/1XwEh8ulhl9dpwnHwXsMGADszOkgbs
         cEJ1kSIKj+DCw4AMTSF/I8oq1q+qHuS8p09Rvp15Cy2Hv1/LcGanr9aNJ5G/B992voZN
         G8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815476; x=1796420276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0xqFQ8EFSLScO4Q176xI4tc11w0iLqrVbV3gNNkVC8k=;
        b=aUwR9Fa+1r/zOf0CQ59JQKH1nTIV+xvjsK+GvMYK8LkcuePpjT0gZY1MjWMsNDOASE
         PeIY3D9povCkuMrszCeX4kgVHYCi5217w3U8t15DcGPdzqC6laiNYLmU4qpMq+sfZzdd
         eX2TbBZetWM/WZAfiEYhVoAkGQLAcfs5CwYtlzJYdVHctlcYgSAhi+XtGtVrUBzds0dH
         CyM02vqlNL/TKw/6j7vxYbKBvvLaUkz62SwLUGzDa/H4gxXuCGYCwwVSJumSvrHwNFwn
         0EiHnJW/K+K0Z5ei1iocx1yG+4TypiQV1K6tcMpJaZ+gr5x3k9aDubJ0eJ5PJuJGzypa
         YZXw==
X-Gm-Message-State: APuU4Z+E+BXT5ebupJ7x5fOJJbYX1wYzQ6L5NtShH1UaCW40LjLG3zyh
	EKqaZ4v5D4GfSqxoKQ/7dK3W9z75uuGfz/7WrMrh4Xmh0Dbj7Y7NgUaFlUG/qg==
X-Gm-Gg: AZFdTZes5JPX6Kf4dwpHr3+eO3B76LjTy9HPMuUQtk6EZU+73cmLRqB8zI1QBKPFJqV
	TQhnHaf0LJP7lcyffzUnbSstEDo/aqkAWMR0B0OiBY5Y2VvlKItvi20/71dfbGqLweVR4tVqaBg
	1Xq/yXwgoOzcLkTri0OXdOUwrxJw4XwkecrHbaqXLaEUFeOziAxev3IYlpN2msA/LiabYndVJRW
	tYhKLHsXC2YXRnkFIlUHnrCvGG2gsZLrlD5/KyxBiJlqmDBwPhiX2kQg8/Ljdmky00oov1gXjDC
	1Nkrvh3boG5kOZoHoQ2Yytb7sd+NgJu0H/PYh/jrUelWNWF03l8Kr0ABeeI/StNZr0N1MweSAMJ
	m0Sm1oxMoBYgR061EhChucRFqUU5tPv4KbyU6yH5MoO6SCh1wEGRvSv8d9lIg5ZB7tXFjJdB5+9
	HKLykbwkftgtejBo1jH7t7Oycnz2/VA5fRp6pMPkocWZFyXHIkJVo1zQSki2nWK2yEn957zeZdS
	KmskGdhIoqSs6cp/zoHcgtVMi4JAPQy2UMmasDpA9Wp4wWEi9y9+pFMxKg2Ko4KjPgmcLRoBC9U
	ECBH9Q2RQCyXw2/uFA4ZM1rVcWX703dXZJud0ISTvCCL6tm9lg==
X-Received: by 2002:a5d:5888:0:b0:4a6:d298:832b with SMTP id ffacd0b85a97d-4abb6095e39mr49850827f8f.6.1795815476249;
        Fri, 27 Nov 2026 13:37:56 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b3a5:d700:4efd:de8c:f09c:9d10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm51490111f8f.11.2026.11.27.13.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:37:55 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Subject: Re: [RFC BlueZ 0/9] Periodic advertising and PAwR over MGMT
Date: Fri, 27 Nov 2026 22:37:36 +0100
Message-ID: <20261127213736.121774-1-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

a note on the CI result, as the TestFunctional failure comes from this
series and is not a flaky test:

  FAIL functional.test_bap::test_bap_broadcast_earbuds_transport_created:
  AssertionError: Failed to acquire: org.bluez.Error.Failed

Patch 7/9 makes the emulator answer LE Remove Advertising Set and LE
Clear Advertising Sets with Command Disallowed while periodic advertising
is enabled, as the specification asks for. The kernel sends LE Clear
Advertising Sets on power off without disabling periodic advertising
first, so with a BIG running the power off fails:

  Bluetooth: hci0: Opcode 0x203d failed: -16
  Set Powered for hci0 failed with status 0x0a (Busy)

test-functional power cycles the controller between two cases, the
broadcast source keeps its state and the next case cannot acquire its
transport.

The kernel side of this is patch 2/5 of the kernel RFC. As it fixes the
power off of a broadcast source on its own, I sent it separately:

  Bluetooth: hci_sync: Disable PA before removing an advertising set

With that patch alone on bluetooth-next and this series, the broadcast
cases of test_bap pass here again, and so does iso-tester. Patch 7/9
must not be applied before it. The cover letter said that the new
mgmt-tester cases need the kernel series; that an existing test depends
on it too I had missed.

The failed acquire also shows a use after free in bluetoothd, in
transport_bap_resume() (profiles/audio/transport.c:2221, read of
transport->state after bt_bap_stream_enable()). That is not in code this
series touches; I have not looked into it further.

The two GitLint findings are subjects which get too long with the
prefix. I will shorten them in v2.

Regards,
Roland

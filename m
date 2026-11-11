Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366340;
	b=jCN+iyZxY0VrtM/zEalodUK9zadRTDIg7WpJKoHor3Td+GEx7QFmcFyAMunEt9wD0FiJ
	 MLvBoBlXgVXpszooggunqev0r8ZMbIV3Dylnz7rGpF0MwxcALlRJuVkpu8oU8grmEzzO4
	 BVVh59HAsvSxdcETUF/QPNQTtcsnaul6kuL1phrAN8A0ILroiEM9qFXoZLiwMTsDzm6zK
	 esDmjyflZWUoSleNoC82QRwqSpbSZH7afF/apEhW941ZceW5ygb1C76E2TpIVR7LdJrMt
	 yizE544YHagAlx3zdQR6oZnEaozY9o5HGnVztIjJz1vxjP11b4TKmoFVOeu+xN41HnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=mEV352mSTYdgXMCue5v5D90X5G8N2Bjap5I2z4DoTDg=;
	b=wyFR/sL7koiAfLF+mbGNVLbVQ8CpfIdkGFRNUQo3KuiV1eiF2fLcoyXKRrev5TG/87zq
	 elbRLRnHTJTcB4aY0DOpuNI9LaxEr6yPQ3U0SWMj9xK1RUjVYPjHibys6Pw88j3vrn/yD
	 GQmw7nXTVTh3gHC4PcTyKyl+7urRP5FJNBTHTS49OV7PAwWifK7xmQkpc8hLWUZ908YRp
	 0G9T2Ue+ndXOqk+QZznjBZJm0vodLfwtxAVmM5vK5ZuNgaEpjmOuNj8zkYiBVlAF2KOAK
	 854F2SF3zgRlxKH1xV8M+d/YRqAfyZZVcBsEmnNNDLZtGSAUBPHNzISgjWrqamotp6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3dn7JGr;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70272606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 03:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70272606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3dn7JGr
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15dd124bbe7so3824026c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 19:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366340; x=1794971140; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mEV352mSTYdgXMCue5v5D90X5G8N2Bjap5I2z4DoTDg=;
        b=I3dn7JGr/RlOTCuMtKGJ9wIlPzzzKQ0AsgocE9UM2QAhmjFBHP12fm6Su8xnBCnkS0
         cg5I37FJxOrgpkwtswbgxgFDerhMwTf6+Y9EL97Ni/akRdK/trXVrpzpC6FBQZnb3k/+
         aWmmF4X2QITF7J+Q8xEO3JV9CWoclOPxWYNqRVlzImYdwHwwiAfuE/Vpgz3NDk+gujsQ
         BhPPVVyFvXmw/p1YxejmAOfpesywNTQ9/BlgF3oxMKOzi0MgQrbC9qGbXOSryi2Ju9gS
         hNAweJdghcwVj3KAXnSQtZbGyqJ0NJmlXiSYiIeLzsOIaEOgWnXIlfbFagD3eMcIeuFf
         Z6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366340; x=1794971140;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mEV352mSTYdgXMCue5v5D90X5G8N2Bjap5I2z4DoTDg=;
        b=xMEpMADnMTZVy63H3PHMX7a8XxZYBkRK9DRWX2aGBEyR96kWPjitN+uuLVA4YqIbFq
         eB9oOzyRJtpXcYGYb6dmMgzyngqvTVUsR4TpwOaP04ed9IUVtoIZIN5wQwBVqTM9adTy
         O8WQAM0bPfaF0aJ1qqjsB/yDR5C+hMUvoPfgxPlpHjab3bqwxlj/g2tCv4PkYVA5rD7f
         rqzJxowE2p62uXFTPggCsccNF+I5AGBq2B1lpWen2fEKb4Hvpbj0IK33Cfs61FPfjWdX
         cG82Pa3s5fxLp3c0wcqJpk5QUP148sgYMfZL4eMJ5aCYu+JoMpoc4rXb1dF3vofam9NM
         jzmQ==
X-Gm-Message-State: APuU4Z+Kc0brcYE8IQq3JzxNQlHIDf1YwgRCs+fD4sIjgsnkHAvqTSTR
	3kbeGy8Q3qhwDexH/DuR3cy3m4f+XA12V5CO6cq7wouGn/oBbff3clRXM3EK6w==
X-Gm-Gg: AYBFou0psjBz+O+86vAfQc0bMambW6UEJLS3GlGIMpCDYf/4oggSFaSX88a9fIm0DFL
	9ZXMao01RpRJygGxjYhDOFlBGw/u2FPNj6d/ERJ9qGvyT3rwPbsmQxsy8E36PtfCY2XzKsJRN/D
	6XyX+yKAQ/y+8tFh0VPqUC6Db4KHB+CsLciPPpo8NnHe4yY7Gq9Grl1G0CUvrkBy537PbO+nNuG
	ir8Wh536+6E4/1nmk8OcpHtanR8pAG3retbOpuc+lJtBJlnW5mp7DdQUhvFiMT0AnRDUs1yhnqP
	xrBSfZAy4I6Nts1asIjopEeS50N5PQ5cIugCH0CqavtOnNq5ahga8rip2LoeSl0sLfxlg1jwY36
	+lD7KtS3vNFe+1/AbIeNohneJlVpw9Hvw6SbWENKXUu1xWi1/xxlb1knLQHzOBVelIzYDCYNvP1
	mEAAXDEVrJoTWIw3Ts/R3WWpeHeE4amYpg9BDyexNW6GP6Jww0WQRVHPk+lNi83gl9C7lCkV3iN
	2n35qKBfycjFeSLiJr5TEB2VcQwYMBiz9gWV1B7eNPD16JpjB+RU9ri1sx4rTA=
X-Received: by 2002:a05:7023:d0d:b0:199:7dff:f9cc with SMTP id a92af1059eb24-1b3c034acd9mr1159132c88.42.1794366339516;
        Tue, 10 Nov 2026 19:05:39 -0800 (PST)
Received: from [172.17.0.2] ([52.190.140.96])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm10134896c88.8.2026.11.10.19.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:05:37 -0800 (PST)
Message-ID: <6af3db81.45417901.18b13c.f5be@mx.google.com>
Date: Tue, 10 Nov 2026 19:05:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9211321930184437946=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,4/8] transport: Don't hand the owner over while releasing
In-Reply-To: <08b31b48642208e419dc10f83f6fad0712ad0579.1794349049.git.luiz.von.dentz@intel.com>
References: <08b31b48642208e419dc10f83f6fad0712ad0579.1794349049.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9211321930184437946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/transport.c:2457
error: profiles/audio/transport.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9211321930184437946==--

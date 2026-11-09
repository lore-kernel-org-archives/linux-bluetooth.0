Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218775;
	b=fSedbbIFvGWHBQzSjP/3KbKlIIOeOMUtpSnf4xBPTTmhry5OAqzI99HuXsom4+yfA2JP
	 NzjRhUApSK4THBEyPxwI0QLdxMYGb2Qh2LjxCuTfXw//5VoxyLHDPv9fciiWSHZTX4xpA
	 fIA8UHT7rjKMklCpcZM+W3UPscqEklKXknqdZdga7p9i+30h0U/bGPxdtAmjjX7OuUQ9h
	 A2Tt74uyiho6DnREHsemZohAuWeNXxEu9opUn5aRJWoBkbgdEPpkQi3oqsYGCoVbB57uC
	 kmEC0Mit+PjDMSEdCTxyD/2+I99KTJS1os8IQqR+jORvyAHqk1Vk0qun2z6yDXnrrQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ZQGBbyfLQ+CxZYbajjZBgawM4pTv1/kElhg5k6ZiJb4=;
	b=ArnpP78nEWg9bi7lBkUiBmuo7M8jTzZaHPFH71OLumA8ZmXc9T7dmHmup/59WWZVkurz
	 hQN9qS7tcWiY9jJ9YOXLH4YWWo373RvgZff716B8Y/eahhIIIJRF+LyQmUVhF2giN2l0a
	 jkOlivNPHHzPObu1T3sgWQ4vfHrc/gzvizTzNsOTK1D79xIGRJ1Nqznpvu1bIWw2GHtkh
	 xZVVU0IbcJaORpr16EcPaTGkCxh831ocdenHNZhc/vkcJ1E9IPjc3CZahPDX4NnISuLyd
	 T6sSoQ1txideHVVxDs8JOKi3YtW98gQXD8C6R2FeQPl3b+5oUIS5rrRMLX3dtmpRbhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TyvNyEM+;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6A606A321
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 10:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D6A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TyvNyEM+
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5365f9a04c5so9217611cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 02:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218774; x=1794823574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZQGBbyfLQ+CxZYbajjZBgawM4pTv1/kElhg5k6ZiJb4=;
        b=TyvNyEM+eUlYdXtgxRfd69O5dvDXAcacJu+fxwAaKZVvYzjfTspPIXR/+mlCWB+FW/
         tUPFT9HairLdyetXUfWzQxwZxpqfqXDf4H/85ZFYgBXBSNs+GKoKslEj3XvFvDMKLxF7
         T0gyMY0mOqmOlt1xtxAwuo8uz9COgestAgBIx1v8wrS8oxNPircx3Hb1S7aScGyIf1Q0
         kLsSmaXOSZfhLf/WnfCARgjHZ2MdPU3aK027zNGoA++3x14idairWd15tH/R7U0WSs1d
         yyuPoaf+NBSIC9pA8s7q+S5Lo0IQcIsvg5/tFL00ft35UG8xP+VlBKtSonI4hZIvUySN
         8dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218774; x=1794823574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZQGBbyfLQ+CxZYbajjZBgawM4pTv1/kElhg5k6ZiJb4=;
        b=MzbMj+kGOkqWcbIR3R9CHd5+1AYVLjMC6Iu51v+Hhbk6sStnh8lZ9MxuIUQlHuiblO
         3ZL2P5feSljATNZYY6maGZ8z4d9z8iBlt0IgZXuJjzzx2n/PuEdNQBJbF2tkJZROSsyr
         731uw4mVl7sxFLNcxHWPZI2zFwDoPxNeGS9hnQFpWzTOol+m1zTiF3snlejcrMym2fX3
         OmY69w/1813gVyRCUGK1vPGM3ZJHLrUjmV6yq5NHBpX3ZDok4+12NFSayR4nCi2LZn5G
         LLznR/fgYTPnYHFdfgzKJ1u/VY03+hg/OMhYuRiqGi48LABH9lMUQolHr1GF0HXZrkdD
         F/HA==
X-Gm-Message-State: APuU4Z8knHonhDF+0/byyhGeWUu4MuIe67YtcinRMAZErZCbT+POHwBF
	eMUx3w+SZxqu/t8QmvNcgRMnooTgJftmjDw2ImMZEUxmmq44txSyxjMs1g3d+A==
X-Gm-Gg: AYBFou3bm9yc8+jtZZZrgCf+oQeoU+hBwfiTTKzSW1u0D8IaCy/51Y+lu8Q378uSlbd
	cyozw7VbfMy85CQiEWIamRSSiJFnKQMKi3dmiwuH7mBqmGOdocba64CcHHDQE1Rp/lQTrKPHumY
	R28X/vxtnJKP819zg3wNuDj61z7dlCHDNSk0pUbAtQdOcv3Idphtne3HctqznmLe4a4T/sfv1If
	7VZUkkLVLzv4fDtYElUBGRKGld8zVp38+u2sdyIcDDxKEH0dGUHmNIn8C80CVvuVDaEO8QfTYY1
	+9B5WO1uaqnFhkcLuCjangBTB/IJ5ysvvr3F9AdSWWWn90gKzvFG1A1WlCNCNEEnfRr3b0ueiXp
	/Z7nZIQcPmLmZdzlCBFe4qQv18essmmHMgk5ieegk0M5ZxNG+6kAePU9npPx4kYLyx0CS4/LgUZ
	1DY0izoRRRN2uyqFDjjNJp5Z2qI9lORgDiJUimd97qmQeSiz6EhZ/xB5BCf4IeN5rGt95IiXEYg
	AztUwaMZ3wZkFUaxuC7vMx29bh1chJPqAuY0hn/qYhja3oL4yUNI5525YqgPrk=
X-Received: by 2002:a05:622a:429a:b0:536:699d:9a22 with SMTP id d75a77b69052e-552a6050ee2mr50599701cf.57.1794218773706;
        Mon, 09 Nov 2026 02:06:13 -0800 (PST)
Received: from [172.17.0.2] ([172.208.23.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-552638912a0sm36865641cf.9.2026.11.09.02.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:06:13 -0800 (PST)
Message-ID: <6af19b15.e5d8ea26.35d26e.e389@mx.google.com>
Date: Mon, 09 Nov 2026 02:06:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9125411096837048413=="
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
In-Reply-To: <20261109-device-trust-core-v2-1-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-1-3b12d9a9f861@nvidia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9125411096837048413==
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


--===============9125411096837048413==--

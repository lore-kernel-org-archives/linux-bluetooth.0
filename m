Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605965;
	b=i43tfUexk/Xy1w2edUlOIVNn/gQU47d1VRQey1VNCYWl+oP1cQtJr0xYdY0FOsJGpnMB
	 qVzZBLzSOeFWlj/g8Tudz57aKNSWsaXPwCgjNh/5S0SLZ7/hWiJZ560tzZ/H+WU13tmU1
	 6eJT4vvmxsTZLjT509PR7VnUtFSnXnh3kAln7PTPq1ahqz1V+GkM7f7Uq+INQejrCB9Mm
	 OCKRCBIwp8vv0bdkoyUrXFeKSH1Fg5YHQ0ukPdgITRHeoXyfO1DqFRC5OSVbk+1WezPHQ
	 3L/9zRIE3vPe+zLUSO70HLdfP2L0UNcrt2cvdn9oJAIOrMoprCdOPf75AHdDU0gtzeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=p1IGmMdvwbr5jBgIWv6KUWDPkiwS+l6lEgl2D+t3Uf0=;
	b=qeFUtH5oSM/Nr0jQnZuLnnGpn4h1FTOP2BPmoaAvWb1UVCjOyzBYenDYQo4e+kY1sZgT
	 qFKiyCBh4GPZPVZQeD2udNZy85ltOy6CIpx9MUA4LvifeB143bTcFvDGvs4ECXWXccA+i
	 ngr0KeaFo2CvJTJQA7s4T3qqOTXc0UOHwtpS7hN4Ba/N+Pwl8IPoFAZ2Pl8ZFMKLIWTen
	 V3yASpobeFfgembU3DLQsdggx/b9earD07CHuEOkcVzAMBhmCwFFxhGmD1IBsuva+lG48
	 lKkbUKlmAZlaulaFcQwh1w/ROt1zVEwV9u6sK6U7c7YB7nOWXA8gkL1uXZ3mU7Vs2BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s86BZXCR;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA94606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 11:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA94606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s86BZXCR
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-86288992de5so4231333a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 03:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605964; x=1796210764; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p1IGmMdvwbr5jBgIWv6KUWDPkiwS+l6lEgl2D+t3Uf0=;
        b=s86BZXCRgrVgYXbfvi91EIiqFr52yYexo9uilAavIee4hPdCkBYYGhIX7bxqJY/LTu
         t285NN0X/aX50v1332eLGeQshDj6Jl/RM02Pxizl4QX1F7gULfPHm0i2cj/SNB7ZMefR
         t8cdj6mHmMWIB5wjiOoN5SIdzHQS1s+NUgph85xHa7Haj8LV5PBB92DCDxZRI4tdSqda
         FXRIDIMnXW6yil1gc/zbeR1tsq9XPKPWlQ243W3rVlOTWg2e2aDNb/G1un4WccrwVyI/
         qX+ItM08KaLZNwXh9Ykdp/ae0pLqA5GTgem71S33ysvj7wBhhor0GDsfqlbAl24GwstJ
         rGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605964; x=1796210764;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p1IGmMdvwbr5jBgIWv6KUWDPkiwS+l6lEgl2D+t3Uf0=;
        b=r8gORXhiq4tkEDwirsH0iqXpDATFCs+/IjVcUeZktEt+Ei8L02s3D/peJutIWzLSfa
         jzlENS2uM4QFHmDKG7hfvQSxy3wRkLpFoZBIdS4Cj+I/X2S/NbeeSq0+XvA467Rd2VzZ
         4h9z9MMUS60OREEL+y/G8jMA9Eq6yEJJeWCmayP4kmOO2kuGBTh1PHgmJwpFDTVpMmZ0
         gyNbDHb0gMRSCFYMTd4wSK7TeAt5Su2saWQSsQbXJWdzpRrWa/ULYQFyNoMGMBVq/MZE
         XqzpMxGPCNKovXHGNZuY6OHAt83InrdJkZpi8QJ7DZALCxRkpK4N1LsO72t5+B7sVxWz
         YJag==
X-Gm-Message-State: APuU4Z+7iFFrRROQzHdB1fw8ajWLrAcB8VICTwrLVAJtPw3dDr82/Nju
	Qg3xpOTgtwbTVo/uUSHwSgFRA7uHK25wcq5T1NoGopMamvfIn6rq4RS87Er4DB9v
X-Gm-Gg: AZFdTZdoHvwJjygvStqLnKE2eXVEiPP92dlqctq6vk3DB8kkUmruUX8KToRUqU7XK3g
	9+bBT6Tj9912AZ4RJWWAwgAIhKkMGasUIY3v4NHJagWXd/BZbrVzmmBwsIlL5ws/vmxxFw9qn6t
	U+WLsSaJ2OnnUNXIltRZWjC3MpFrktiFA0KqgUCkQxPaMKyE3j6r0SSJp00A5cg/3U6iR83akbV
	vwA7IvS8Yb7LMNsHiuJ5HY7BfSqFpoKDBfjJnNamd1tDTUKyjI+V0aR5DYtEctCIanWhAQXaljA
	40NxsqZDIbNYx3To5u9Ork3f7prsILj4CAlM2tSb/JtNRnMPH0oE3MDg+9q4yCq7Ks5zEU1QMQy
	DSFm+iF3V5wZG4bhNLNCtCMEaBdSpYZ/80uZBJENsMaJdoNkOd9kibZvdzA10M1yEjqQl7OB9P5
	XQFiys0gayz0ShSOj2OTJDDgyQmnI6DNEB8EvJhXXU3u5natfLTn8dXOF9IcUk8OQqR2nDzJWiD
	qnQpf6fotUT/ZHbqmJ3G+ZzPflaU+q+FHbIjKkJVm2shjzpnROMOll4QlLE
X-Received: by 2002:a05:6830:4107:b0:862:a205:e1cb with SMTP id 46e09a7af769-8630920a762mr16101683a34.17.1795605963994;
        Wed, 25 Nov 2026 03:26:03 -0800 (PST)
Received: from [172.17.0.2] ([20.80.77.31])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86316910337sm12366499a34.23.2026.11.25.03.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:03 -0800 (PST)
Message-ID: <6b06c5cb.98a28ad6.96404.38a6@mx.google.com>
Date: Wed, 25 Nov 2026 03:26:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2245546257353978664=="
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
To: linux-bluetooth@vger.kernel.org, petrvaganoff@gmail.com
Subject: RE: [6.12] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
In-Reply-To: <20261125093035.224140-1-petrvaganoff@gmail.com>
References: <20261125093035.224140-1-petrvaganoff@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2245546257353978664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:3905
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2245546257353978664==--

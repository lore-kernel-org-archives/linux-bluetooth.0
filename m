Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605970;
	b=0caueeQo+3CcmAAXMKcqsb6jkTy/s3bixB95/VJnWWPZYuivHQItR3LzU0DgkCGeha+3
	 NlNO8w2IJPUWDXTzkEBhp045OjDgweWbvvZzwhpsDcpwAnUO8tiPcUrEVaK8X4mHG5w2r
	 BWiJvquqrjaF/b2NSKWSO3KOS4VEZL7RD3TDnPIOyg0Vhrds/+mxozttoHtBd16jYNJVg
	 2gfKahIZI5lbShI+sSH77LVFEY452/RKnKSsDD8bVMIczjeE0261iyKSs4uPDPBErl/B/
	 aL3joJ1ajqAJI6eDF8JlSGB3v63sFI2axe1PGFTEuNTneTcKuZOvFRPqDy4YIxTfF2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=kgO8Tv2AZtnhtGw+dRdSJ4iwITEEnXIlZGACARXeVQU=;
	b=QKCsFiE3qInt4395VcOlP8P33hjpYf0rD9Lk0pzHza2RWHDqqMXqVCCU6swkht+66sqO
	 dM0j3lo4wK3pzg9/Dc8LRD8HwuXdiLW9ejXwLPAJzXVlM3FPBR0lk+1woVLSgABg65O18
	 LHwyoNmssLJ/k989Xwxx8Cp5MKYXg50sa+g79zP2mA3l8teEdXTb+0/nWf0vExTRd1ByT
	 SCz132Auno9igODR7wPhfpFtZj8jm0BiSWGWxL6ejIRW6Zw9m8181FiuWsT5Xz6TRSM2/
	 5nnKXRuO9UzF6MDJJpvpF4DA1OLtS/eCrT5fFNsjgsM+aaHGRslQQ3Eerm6XYhXaLqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H393TgMk;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC5606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 11:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABC5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H393TgMk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-57e47de950fso1079158b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 03:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605969; x=1796210769; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kgO8Tv2AZtnhtGw+dRdSJ4iwITEEnXIlZGACARXeVQU=;
        b=H393TgMkuTdx/DGO+En9CByGzpB+eMdJjealJuG2dLQ6n1rzyhyRsoSzvUOX0MeZy4
         4KPhPiU5TXY76Cgx8/zsFlAEsdYxbxwWTpU+OfbYXwKog1PHRRR4hkYIrVlYGygnKBaR
         2ecI8/Y3fa0xK81gRr0Ia2SoBhTPp7DXGJroteyeWdSAJgaMH9vBB97XqVKxi53Wb2TC
         X4lpeVPBsoTO7rRpe8SvgxVubJKOOb+U4anw5VeATifvu54qP1fms/70Ofs9je+tl3Lk
         cjysjc8saPNWoWPam/iNH7lyatZ4e3JAYpB1ZOaUfxi9vwlv7Iy6GtsyMGSBJuthE6Bu
         VgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605969; x=1796210769;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kgO8Tv2AZtnhtGw+dRdSJ4iwITEEnXIlZGACARXeVQU=;
        b=NjZe+woH/i5TT+T6hFFa/vdJnkqTeJrHyA70EWuDNwevmM5VCI8+/t2Lfy1NlKyBXZ
         W+KfVScWtnjyetUGdJSRDIy1seyBeeoUJYF3EmaHN5lAvgd/SrIzxKDRbNxOfU+PUMwC
         yFCMYNEp/ApZclFgf7f5NdgzdfoD6BfNkW0pfGF9ZDIYpxscArOJHt65I3aJWkrnz3f7
         oda6yETH1TriwheMkrli38uBLRVL+Ku7zV+s/GE+wu/itseTen8l3E00yLkODBNTp4ud
         uysdovvaRn/Nbkz02CWJrbCwlIdTnz88ZVB/IuMdtcHHn+WkJYldBFXkackDUI93Vr1p
         ClXw==
X-Gm-Message-State: APuU4Z+NRetGW2w0jjvAqRYVg+AmCrlxc01yFZ3xAQhexSUF+4JBn341
	Svh2Mv7OFyiejimwjDEISqXr+wK6xH2EsHMv9CCGnEvW4BHBamV5ycvmSSBPbJsL
X-Gm-Gg: AZFdTZfCB5REwe/0fWa7B4Y5WrUT6JFP8z4TwPZNjn+/QsTP3Kw+MT5qG94rGtpSweG
	4K7Qz1HFc6dcXyCVitMiyYhDVGRfNXs9KLy6oDXfNe8xh386/aZ8vQPTwR/ODKutSZKLn+zn4WG
	y7vStUWLUVrAeKzwjqAgDP4gASrISjRIW81OnwQIB0N8eMCLW1Zx2gHgR+MMLU7BmzqyFEPwUGm
	ypwEWCoREx6FE5QVG0GPyHzu71JV5oF8QF/sJptg7NmENOHrdHsvYWrpPxDLsPcbGgJ7vY0Hwwb
	7sEzDiiiNu8TI8doM8sl0eqwWY79GJdw2Nk0l2lbm17Zg5kcxzbR7lmVcGLBk5zsqwhu2b+AxbU
	HRnO2rCr64L5uu7aJRiG3VtmtA2xY2GchLyCewf0eC1r6jj72tsDlGDnPcpLp+gOfp84Yw2ykzZ
	486r/ykhRY4Kgpbn2YW/+wecxd/htdbmjkT6OAuigSgP4+RLzCV12yfOr27FGSpxvcQwiOcjw4N
	mP9wmSRl7DJ6PpQvocG2uFdXwpzm+ZKi2ITWq9usVKkypovg6Ly7t+glOgY
X-Received: by 2002:a05:6808:179f:b0:4d6:90f3:74a2 with SMTP id 5614622812f47-57a0c09bea9mr19166866b6e.45.1795605969382;
        Wed, 25 Nov 2026 03:26:09 -0800 (PST)
Received: from [172.17.0.2] ([20.80.77.31])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60497300sm16911080fac.11.2026.11.25.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:08 -0800 (PST)
Message-ID: <6b06c5d0.d0a16cdd.35d7fa.e72f@mx.google.com>
Date: Wed, 25 Nov 2026 03:26:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4924558873729018623=="
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
Subject: RE: [5.10] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
In-Reply-To: <20261125093302.225552-1-petrvaganoff@gmail.com>
References: <20261125093302.225552-1-petrvaganoff@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4924558873729018623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:4819
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


--===============4924558873729018623==--

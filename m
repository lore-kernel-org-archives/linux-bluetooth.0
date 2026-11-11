Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420913;
	b=b6gr+qu7D40IaMMunte3azLwSVVxjZ2KzOTD5Blsxvis3sh1tyLaLfgsvgtJ3nx0RxKf
	 3Go3dozvnq2CT0VoVuSQT7WwLNqQZ9QNI2FzCUWMDiCcCKKMFXVzmeMn0p8ajwerz+Rsc
	 F82hdtuQEuE8tAbIGY53n6Y8/ujU5adwI+gw4FDLX3f8eF38Uc+AhriMv2Vo1kO+UZnOB
	 SkkdpSE8bjer1+Tu6LcfvEjdx8BlSseN61li7DTI449ATLHsd+UQO2Kq6zNp5eyhjF2ff
	 j1AQ/pUyrFMumByTGKJQXTX+HgmNbJB0lqQVQ0ilNEYrMme5ACoHgVtK0JBiw0bZtoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=xtBytKaAxlTHL2cxHwI639FVd6DZosFRD/ibdIHh+H0=;
	b=IoCugBw3PwIPbi4LbBpQBGo3mB6ydvA8LNXoNjAdVZX3JdaCubFnDqWIYFPcZA0RiG6A
	 BD6s51QYwYUZPDz2qJFG2xZXeZTHFww0yk5QRHnjf8fmHLsei9/kz3IOoOuzCGH3QMP2W
	 TiA8mpk3ZQXa75EglkOAM5Br+OWSUxYMxtMBehoaiVB3QEyvOr+waDxgfw0ggdbzw1I88
	 k9Ycm25R9McHq6j5ioW0b0BtLC4g1AndsiwxOxpTTIqKg1fzCYSmsN3zQRPPAwDY23Iw+
	 cx2xOYb5R4zyAFvZowFii62XCj8uPlMn8f4O6VKR8rddaOS94X3G5tI0s3HcG4uikZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2uDQQYN;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891C606A338
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3891C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2uDQQYN
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43bf9548df4so3353286fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794420912; x=1795025712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xtBytKaAxlTHL2cxHwI639FVd6DZosFRD/ibdIHh+H0=;
        b=m2uDQQYNz0vNhOMMC4LKpBGstw8EpF4difLGJqXwl7Sjqu4cZwnvoarZ2kV677tV9+
         3Xpcf8mHO4Acvdv+I+/AoTU5BlkZ3LL9slfeWHn1alBbno3fAgURXAqiqvI5uuwbmnrN
         Nk58Xr1YU96ig9HOpfrGOOmzSEBDKzMGmo4GmwGKbEAXHBLOAOi2PBq3QdERsIcj1xVt
         UmveFlwTJjoX8ezdLeP+YEzw4FRjeovkP1RAfkJUFwBHYCfgQJ/YbCk4PPl1RVIaai9s
         fwhGgOWII1WEkO5oZcF6OzrHfByH2le0VAtavVEYUF/xmDuaZ9m5WhrulKw4YD+c+GzN
         Bqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794420912; x=1795025712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xtBytKaAxlTHL2cxHwI639FVd6DZosFRD/ibdIHh+H0=;
        b=q5ghpD66vKcu3eUMEPZWdqDsJNWE+43/ukLjgDNPMRGybQ9WzVnRAYYT7IMCt/y2gC
         THitZ9vOYwz4xJAAf0uXPBG0PVBx+ezdQHMTkGm8Faf0e1vpWDBn4CVXCY4NvyLtyCeX
         nfRv0UBVL49Eqhxw1f5jPvIB/0DJTnJCdBUSmnH/RnHXoV6an33b5OPubKZVLMqe5Ido
         QYXL6iqZr95iEsBxGZ1inun+SpZ2JpX2PnpfEn1WEwu6k3aHvV6DctP8Sz5LjZL+n2TA
         xyOP1hTsE1sOaP+NakKISHpQEtm8pAA1QlzzTHMlBohS2t+XTnSYGttKVgRtvSE75/eg
         nv7w==
X-Gm-Message-State: APuU4Z/n8py2p0q712bC116i9zL1qZGrs9UXH6W+AQDBJBcVrwYqZf64
	vf965UNifhu7PPSSe5uFkAYQB3o34/mcBGdz3U2DnrFbzbXUjZsU3NwWliR9nQ==
X-Gm-Gg: AYBFou3NM2UhwGzo2LbxHMHqlwK4MeUVHqUdaGiNiZtvk5jSfuUMEVAYZNq/iqqKv+N
	lS91XNoWc+4e0I7dB0yUHGsvlkdtwALUnqfYtt2Ye+UR3AyffBdjYdq3+B541lF4w0kmPlcjPho
	eBlHyvIQ1I8k+2WfA05gnnUa9ZXiM0Y4+kw4xLzdKlu7z0x2tswzUuTMetoEIq/NP//fGrekyVr
	6XfGWO0gOi5TYeZG+fd3+/KNVMH83GAIEZ3eNFLLFjr7Migz+WBzlNx13OQtEfI56ofJuDWpLzO
	P2roHWKRGjly2CwYUk55pKn8ZwR+Bb3we7iwkXSp0wjGC85VFWE8GyB26XkE1yWt/3Zd2xjW6D1
	aS4GktGZTl5zpwi3Viex0VehgAB3sgm6ROJs2TlzOT3sdskZNwjGF0JVLbuMRF9jU6WhQy6m6/F
	1nP/jIFFIE6rTTJRyjHpzmnIFMI4M077BexVnoAUchzeslcqJX8tHddF4oj62zfwUiEpxJTsQzd
	EHy9+mf4Vdz+9X1d8aCf/swhnlPN4m8hlZOwZwzGQRCGPC19gIH9T3x3gZhnrE=
X-Received: by 2002:a05:6808:c2b9:b0:53b:87e5:8c95 with SMTP id 5614622812f47-56b9761299amr2645809b6e.37.1794420911425;
        Wed, 11 Nov 2026 10:15:11 -0800 (PST)
Received: from [172.17.0.2] ([52.154.133.195])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5427062b6e.1.2026.11.11.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:15:10 -0800 (PST)
Message-ID: <6af4b0ae.7439f5ce.174d0e.b4cd@mx.google.com>
Date: Wed, 11 Nov 2026 10:15:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0934030102552714565=="
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
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [v3,1/3] Bluetooth: btintel_pcie: Add yoyo support for config set TLV
In-Reply-To: <20261111165332.8478-1-ajay.k.v@intel.com>
References: <20261111165332.8478-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0934030102552714565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208571/

---Test result---

Test Summary:
CheckPatch                    PASS      3.07 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.81 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      22.43 seconds
CheckAllWarning               PASS      27.62 seconds
CheckSparse                   PASS      29.24 seconds
BuildKernel32                 PASS      22.08 seconds
CheckKernelLLVM               PASS      23.51 seconds
TestRunnerSetup               PASS      477.08 seconds
IncrementalBuild              PASS      21.04 seconds



https://github.com/bluez/bluetooth-next/pull/1114

---
Regards,
Linux Bluetooth


--===============0934030102552714565==--

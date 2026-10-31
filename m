Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487401;
	b=CoEVtZxTwktvAJ4NVgTnadh4+DXA1KlSA6F6btnoW3JhvCxTV7DQtjs75REjtGindeYs
	 nlDIxTZ1+amS/RF1v+URObGWycx3pqaLH57JzW6KS/OZhfwKqfB15emCMV+c17NtWsvGM
	 P2fo5Uc17Wh7euND6FT8yn6xfRG1qBSWfUtD5YPI5egSKLw34V9dTFjYpzZVA7xcFAEur
	 /Nj9tPxWy1XGHPvSe5S6FDqWTUk9li3MSo9V0OQ4ixHF8JdtNhBEi4D371JtrLK7O+EFO
	 sORKr4ULDT6nEUQUNPTiHSCdj8KD7F1JhRF6z6VqffbGxorFtlbHSzpKkYPlh+4nTtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4C7G7QGH/XKjbhkFUTEs3HwUXG60737mXF6PM+GuCE0=;
	b=QRb4XBMuc9ZxkbdpCGvj/3zEIHfw5ON2lsyCTz/NbrTS2ykiJASqWicsQIKOGeWBISP+
	 hOBafUmH4kWOZvS9mr7ht12fj+CjK0WMtQMThSIJ9ZxYvvVqDv84N7+OgyWS7lKaNpGAm
	 AXgKI4xC9VzLnM5bKAhjH0o2/o+RpByRXeKSZfBeXP0yCe5s5y0YqLkYaFRtXNOQ5l+P8
	 6vNrWNK8ThEXKo9bxxLXTKMEagg1IPgFJjfE68TbopLNrjBO5F/QcwojeSYBeAoDjFLq9
	 4YD5pTsEO/nSSYIf7fFwQZc199xIDYfgMKSfxK9/rd0NPH+nd2GS67YoqWowQ6kq3Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0cCBDrV;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE55606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 22:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE55606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0cCBDrV
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5361e313e63so20955161cf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793487400; x=1794092200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4C7G7QGH/XKjbhkFUTEs3HwUXG60737mXF6PM+GuCE0=;
        b=B0cCBDrVcnGqTmbikLC7vaomHo1/knVjvAGUgye5KY5sV+xtQ3DXPQ28+yybRamsIP
         vHThybXnu1bYjxB34H6nLJI4k2eO4loeNcglbnHuJdavh9L7xlZGsukCHc5JbPe2JtlN
         jSAwouzw8Vt+aVvsS6IwwJnRoQwpY9QH1IiBWVPYmBjmSO3vGUqzPsL2sqjkKwHL6gAg
         gmboCGSIuadFx/iFI6rmbxublAuOeN0MkC61sjdk+K9l5lq2spWycI759ZZ/wKBpINlk
         4Lczlah/eoG2Qbml0lVNfbVwwUV/Ew5MgxRtebtJnE78AyHez3KTSyD95/H/V6p4o2MD
         ie9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793487400; x=1794092200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4C7G7QGH/XKjbhkFUTEs3HwUXG60737mXF6PM+GuCE0=;
        b=u+HeQx/NJQ/IBBjy4X2T7ny2GTANo1nP7q55O7QoSMK4oz9Fzd+TpDI9oX7GPHcCa5
         zX0gTR8tpVQOY/uLh3fx1U6oQrFosfPWelNTitvdazq5yJ+BROwTTIv+x+LKVbh9hyuP
         QN8D2pvaqv/BoMAH6UFPR3uCumomaMfpjetHJUVKolVujR/kF+5yzRENCx/q091TI4gt
         8HIXhrA8+F/skqjj3FCUeLnxp2VmOF1bY8ce4CRPdwlkkW+84F03mcYqy5pb34mGay9W
         FDaQBw/VUfieoDeC0BMvMKR6Xoe4+aNDSUz0uYMpaIopawgiVABL+BiC7EIzLHRECfyC
         Yo3g==
X-Gm-Message-State: AFq9FYIF8X8koFz1lW8Q5arEApy4hzhArDvZQQab+Xtpx/icldDEy6To
	2V2/UbxDPfW8a3XevotLUt91/pqckblYnpvFqW4DUON68qaNjaOC/+KhVSKirg==
X-Gm-Gg: AYBFou1WPYJrW6yDdu5vcMpTdHHx7yT07OTLmh0Dm/CuiqbuOvm/YVplxBTlXQMkzvS
	38HxsqahhQuIaLnzD/7o8/MweCL8/e/wuJMJHiuCoCERyqh/uMTiJP1JJCFrpx5w3YyZkFQ/sxJ
	2o+OWnHxg1cTHkRi0cBcG0OduEHbTd0F94HMYXkLi2zdt4GbVXKmM0KSa7t6TW0dMp0adnLfmkp
	1kfqpZkEdVkf1L1Gb8WUDIJRQjPktyCkuSU9l5leWx6TUQnOR+TzbZZjXUERzZrFNMQiUJtlkwM
	shA9TrdZfWY4RwZF0p1jKV+8I8SIczV9GY7IR/7EfHTpGBjIQ4OHj1BVRPP4Dm0uTdvIj5La5i4
	2J6ZRD5iK/JZ10Xn5qVSm2z33PSQB0/7MPWhDuK5dzIMnjyTfutR4hLq+DTsUhQj2+6L0Xt4ovO
	aDPOvW4OXOD+q08zqNvrY3iC/3YnqrhjKuisc/P1H8BSnRNX8G/EOoA14nGjDJzwgYr0bKvqE4j
	OMevhCxlsc8pPfLRfniMPSdWJnAbLfL1SZEuUm7XoIihtLsoQR4J8JfPCOTPbc=
X-Received: by 2002:a05:622a:98b:b0:535:be07:f31c with SMTP id d75a77b69052e-542b83f684dmr98045811cf.74.1793487399846;
        Sat, 31 Oct 2026 15:56:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.191.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91cb4478981sm21408396d6.35.2026.10.31.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:56:39 -0700 (PDT)
Message-ID: <6ae67227.738847b4.12b70a.eb6a@mx.google.com>
Date: Sat, 31 Oct 2026 15:56:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2911441169461739825=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v2] l2cap-tester: Check compatible interval preferences
In-Reply-To: <20261031193734.189558-1-cochcoder@proton.me>
References: <20261031193734.189558-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2911441169461739825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197875/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      304.90 seconds
CheckSmatch                   PASS      311.65 seconds
bluezmakeextell               PASS      100.94 seconds
TestFunctional                PASS      1168.27 seconds
IncrementalBuild              PASS      305.30 seconds
ScanBuild                     PASS      1156.20 seconds



https://github.com/bluez/bluez/pull/2744

---
Regards,
Linux Bluetooth


--===============2911441169461739825==--

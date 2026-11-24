Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552712;
	b=gJ2WZ8g2DbbF2ZWbBxjhWtRx4mq1mdxgV52UX6Yfhq7/QkzPfY00mNizA46Nu//jQ1nb
	 fo/8vUCvZkFQ2zAnKUGNrUPJXdkjZyUb5HlU9hOiQH9aTsVqjngfHEn7mj6w8meQLbV/g
	 gEM/HFWdfBT1wVqvDepNEEfQ+aj8O243irXorOForNyO5mdDLiEN7fHdi+ldqnGxSQcHG
	 zyfawMnewM2GxAmVRmbWhWQ7fPDOQIJxQvNmKuJxjQR/b0OA8x8M90Aema7DzeaQ4pXT5
	 dpYSmQfD78rwG0mCzCyv6NYrlpoPbVAhBH8W4Wy+iPX93YlB7LIW0LcgF455KQBXMRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=F1OH5/PWTsCpp/F+NlND3gz5C4Jwjq9RH7427Jz/xuY=;
	b=Lhf2xxUnkdBH6V7onp4G0EuV4uQUCAeE65lNvJUJKUNai7vGyNnmysTQ7eaJL5ayjn6/
	 SrVJe0Hdyvwz0/b3eHWMi1U/ZkghLSUsEC7uB/iQ5ghUyK2edjJmE6h7DplK4EK2HOBik
	 p1b2NaUpWcTyh7Hzp37/C7p9/QPwftTk+Xh1Q8986UR2lJRTWLP6hYlAn7sGAvS1O+Lq3
	 uw07CHWMosloWaxED6/misFe+mgGBncoSmFU/+GOdxo/khjclI88ZO813fU+9ks83HIki
	 C3JIKKNHlbide5I/BK9PiELI2+JHCfQ6r87SB9aLpgbEC1kogNyE4VcKCtOV7Gco4DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gg/k7DmV";
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80F606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B80F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gg/k7DmV
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6aa9606ddadso3298139eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552711; x=1796157511; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F1OH5/PWTsCpp/F+NlND3gz5C4Jwjq9RH7427Jz/xuY=;
        b=Gg/k7DmVy1LyW+ooojXZsSLTbxEI2H/cUsYMGUd177kR0h6M38Wux+/ST+JI+Ziezl
         X9qQ7lPILDmRm7N5sazBX5SFc3G8C5jElq/tRodJOSSfP0K0ITubkFtE89qFGAVTVRiG
         nNNMCiuY0q8A7X/3M0tF8Da3Lxq8dOpUJGZlckldgsuYE8rNEy2ZfhuCasrMCCBCHK4w
         b5ZL0x51jYmBYfItlGn9c5qs9os+TEvW4WLqG+Qvg0g/FT7p0Wm0/9DXYs3UIzu2ciqU
         RUDvdcpQRjE0MYVqe0Ic8eh2qODq2DMtvkEBfdG5uFUexGznuR+anAJD1CeWy9pGARUp
         Ma5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552711; x=1796157511;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F1OH5/PWTsCpp/F+NlND3gz5C4Jwjq9RH7427Jz/xuY=;
        b=xbRrTTrBjJt+bnjZUlBVKbRghDbi4U+J1dyHylS3ojc7muM/hD6GxedjEtDPLrPMGu
         G24Z2q5K8DzCGhmtulXpAg6ZVut4ofZu8jvoUuIFbCbHeigpPmJimL9eqFeErPF6gcSU
         W71JEkaKEicWfqvOjqe6ltupkbZ9B0kuzlZ+TzhGmJGYtAlPKkGBraHX4qSo687Sw+4t
         tgUKEs14nN8cD1Gb+sTmnGEPFBoRc5z5ZwlLRoJQVx0KFcp8t6Ny3i4nZTRv8jhX6x2w
         UZGXo88aXuXjTLTfQyVb8TMn2kxR3aZM5Lf1s12hx8fPQn6r4X0C3/0NtapzRojsIEOg
         qX2A==
X-Gm-Message-State: APuU4Z88FoZQJ8B8bEFUWaFxYAvQ3t+Wwn/0cbbun4+7oUWaPp8IZMNp
	R9Z1kOwA+7R/jc081/m6K9FaI4bpZ70OGCA+7olClaaS6m5NifRq6J9/F7uojJeG
X-Gm-Gg: AZFdTZeFbzh1d1JnBp59ShcrAoLthJw5TIg/xLNZN6mkRV29+RsKvwHDVMUzUC5lpH0
	YmmAlZNym3Pgiywqcz09BYkuMJZd+YirTRS9bxvlRH07B38hyO+/fjKnNfE9mL1HzfBHfMr6deh
	FDZsXnrgj8gns9j/JavV7src9Bn2FdQ+EMY1vuef6ua51IQ/JWx4aKSU1g322bzDmEgS/+UI5cK
	aDkGWFLiyRaSxW8C+lFXQrUp4JEWJLcYfiLyuKctPUfbFHj1TEOp4AluhisR91cBP6GEQzILmrq
	EIVtF8yVJTBJptiQpHDYxcNTE4vAId6QVkCJ/kuEwHw0bfJNtjVKmR9vy77t/0EdzqPFyoCPsc0
	xpJBul3ov8wqshsZ5CYYlqSw2jQk5PMwwMDJUpu6IHf1jvDDvCcn8uKk/fpXrKun4FCohY0cZvE
	Ag0FSV+taf+NA00F/k0bFw2ExhHDBQrSkRk1vL1unQfy1i9WIqoCXMkc9lmoH1ppPazr/3Dsrin
	4pIqLPyAiX9g1l+5IEA6+0IdFOtoaSSt4Hb9j902MUy8et6UEkUNG3L8HiVYg==
X-Received: by 2002:a05:6820:f034:b0:71b:3fec:38a6 with SMTP id 006d021491bc7-71b3fec4b36mr11624903eaf.12.1795552711211;
        Tue, 24 Nov 2026 12:38:31 -0800 (PST)
Received: from [172.17.0.2] ([40.119.37.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631690f53dsm10636666a34.19.2026.11.24.12.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:38:30 -0800 (PST)
Message-ID: <6b05f5c6.ed0b4dca.1747f.a9a8@mx.google.com>
Date: Tue, 24 Nov 2026 12:38:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9131713626788899754=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,1/2] shared/bap: Don't fail an ASE CP write with an unknown opcode
In-Reply-To: <20261124133112.3956249-1-simon.mikuda@streamunlimited.com>
References: <20261124133112.3956249-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9131713626788899754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220883/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.52 seconds
BuildEll                      PASS      14.84 seconds
BluezMake                     PASS      195.72 seconds
MakeCheck                     PASS      12.99 seconds
MakeDistcheck                 PASS      102.22 seconds
CheckValgrind                 PASS      230.92 seconds
CheckSmatch                   WARNING   179.28 seconds
bluezmakeextell               PASS      61.28 seconds
TestFunctional                PASS      911.65 seconds
IncrementalBuild              PASS      208.51 seconds
ScanBuild                     PASS      601.64 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2902

---
Regards,
Linux Bluetooth


--===============9131713626788899754==--

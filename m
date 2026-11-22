Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795390566;
	b=012aJtXFqK8CcklJT/QIOM8mx5ud35MOm9lOyJEzahKzkl05lgsbdK1RC8z+LWdd2Gon
	 o8ic0vXSjTnntzUydy4QJMrkn61qzCT+040iumlDG+ROiZDr13PBPne0Y3+w1qGvI3I8W
	 8kY2sIDX58p2TCWL0mgCciBHc/YX8Jfs/ooUTPsFFQ4skcBkux2NCkI2HB1isP3O3O7O5
	 X8JnBZDPF/k+7TlvRVdB1iQbNUGOYRaNuH79TaFHjmlcA7HB6nFOe3xryHP7CeyaKLvU8
	 0L+3ny4KeY15zSpsD1D8RMGsxnJnJmOsU2Z0cWkGBrJewsmJU1lajrBUjrdLQaJ7bZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795390566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=/kgEyodtPTYlaMX8gAbEwSS3gnzxT6wzbLb6G4XY6GI=;
	b=3mcwfS0Drzksq8VKaOEIbEdlxENSKhyBEqRv29ndlLHngcDknCKhxZPz9PEqR4iRKSrI
	 p0VWm+KXk5V9hyi5ki4XibxnKGFoWagr12cdvfDZRZg7C9Y8eASaM29A8Nso8dxYWoV3T
	 iIDUsdqa+3o2QnEEKEjhgJ+BfUCBRWBDp/7Bm/zMsXxdwPXMG+kKXO9HP437B0p2vNvpO
	 sBl2vjdR770k1oriRwWZfoodWtaDGhAvHCplNpmfdy7Kl8VERdmwPl5eHC8RYpXCFlf1i
	 Gif8+3FmtM9Yz+g4csvw+hbJk36UWvMy5MvkbCoR/DacOW6uTLqDeMvHTl2lCwTVTIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="k//8TxG1";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF602606A327
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 23:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF602606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k//8TxG1
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso1042487a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795390565; x=1795995365; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/kgEyodtPTYlaMX8gAbEwSS3gnzxT6wzbLb6G4XY6GI=;
        b=k//8TxG1d21CVcerATRzvUH+7qzmVWFIV4N3XcTMXu2gmF2JYw9JJfVyw5W1PWZY7l
         dgjWIU2J7qeJwB3u1j61yuaP6CkC+2nj35NEMrGoB4LaQ/YWhaiIVm28djWvakleKJnC
         cMHsWHgXBWwnyLUmOJODTIGecSqwC/wWiBoNsYon1aMQIY3rfNB67/cpNiaH7Nsh9Dww
         9/C/ePhNzq/PRckjK18lqU/jVcnmcnZscZz02+s8Ohy7nDW6OOS1BwAKzZnqQOKqYuMl
         6xIholBNRgqZNTunFUNw2Q99mZo1zeL3ZzoBB1ZAzPOLbaADwldpDNxXoFCy+KixaHCc
         9kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795390565; x=1795995365;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/kgEyodtPTYlaMX8gAbEwSS3gnzxT6wzbLb6G4XY6GI=;
        b=Y8JdljpDHwzYWPbETq9t/gfp9bdC9hP4REXuynHcwgKY8T6W6FbrXSj3n0Tm5O4oQC
         5h990NEneAr1WwH3ewY2Voa1+HLov8PCTtgEzhKrQBPL5e/FutY6fJYS6QAcejzMuR/U
         dV2T5y7rVyUjJPyUaVs/olRob3OJUszROFv7emnKfguV1M10hDBvEOgTiLrp9zn0jLSk
         AJKa1pGXkNGs4Jni12hRcTUtqx5YaWIG75U9tkfPK3bxDMcj2q709xBAcL2GvPS99Yjm
         Axhczw3n/db4MOzEL2i/fjSh8+YUlRr4V1nSfg6LscJl5albV6o/MuLxHCGZtDlfH8WG
         BZyQ==
X-Gm-Message-State: APuU4Z+wiKpItGLygK0yFlCDeNK5d57fWqvTn4QlcMiU2oh6Oe9hUMOw
	4co8QbJfEYsQFtAyKoF/31PGs8h9dtKqCMh8xARbNurtqcUOujOfmhefDPTIwtF/
X-Gm-Gg: AZFdTZcJI0S5ErEja8tLNzp8PFmGttEx5AS1pxieNJ6x+apvej/12FkCOUx6XJ8NNDM
	Z3JTdZBVFy1Q9wxSuSHSBquETyeAHsvEnFxBP/5T0RnOquVEFfxBYZajM/uBlxIKnsyJx8ZM7eF
	enQ8JO1yFK/vB8yZr9+AxHH3wtSDIN0hs1aNP/36IlP54Rp875kpGgiZOTErHrTsDtgWbxETEoR
	q4PB4OLTnF1jglfN5c5SLHt5RtW12109hurWqC/3R0C1AIqHUvqU467ilDqlw/BGQxWOtyjcM/3
	251E1lwKgw0VXIqFkzIfHVORL8fUNubM3HJejbS/GhtN4BszsHuZtJn45vGvrNym7WCq8HcVaaB
	eohlCT1Axw3qsqnbxOaidhJMPmJgUijB5LtS9nyvMvhj2x6g1VoiQK4edN/RC0g/AZTXHHA/OyP
	6uSgromnCTpQwz1Jf+Uf4zLApjFIJOUuYHjJTzZjWolXzP2AO9m4c23v/N7aUoZqjGQoLkxLOeQ
	EZoliTqys3FoYRP0E5k8mEn7gMoy10P/sGFVFiTK47O3BFHWuv8XwbQUIydpU1lJwExqLvWc9Xl
	pQHgtqb06bEuI2zZVkc2MywDcw358CIJLpZG0XNH
X-Received: by 2002:a17:90b:2cce:b0:3b0:aaed:48d0 with SMTP id 98e67ed59e1d1-3b41c94ff49mr9421464a91.37.1795390565040;
        Sun, 22 Nov 2026 15:36:05 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-110.us-west-2.compute.amazonaws.com. [3.42.157.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm16047533a91.5.2026.11.22.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 15:36:04 -0800 (PST)
Message-ID: <6b037c64.408d4ce3.21a899.015e@mx.google.com>
Date: Sun, 22 Nov 2026 15:36:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3119884471264921832=="
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
Subject: RE: [BlueZ,v2] shared/att: Confirm indications without a registered handler
In-Reply-To: <20261122192740.2323438-1-simon.mikuda@streamunlimited.com>
References: <20261122192740.2323438-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3119884471264921832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218925/

---Test result---

Test Summary:
CheckPatch                    PASS      0.23 seconds
GitLint                       PASS      0.16 seconds
BuildEll                      PASS      13.15 seconds
BluezMake                     PASS      201.14 seconds
MakeCheck                     PASS      0.66 seconds
MakeDistcheck                 PASS      105.12 seconds
CheckValgrind                 PASS      110.99 seconds
CheckSmatch                   PASS      184.07 seconds
bluezmakeextell               PASS      66.28 seconds
TestFunctional                PASS      922.66 seconds
IncrementalBuild              PASS      206.79 seconds
ScanBuild                     PASS      710.38 seconds



https://github.com/bluez/bluez/pull/2876

---
Regards,
Linux Bluetooth


--===============3119884471264921832==--

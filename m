Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260329;
	b=lZA6k9PKq7sksTDEIqBzadWF6LwZ01MAptYVkT2/V9DVvjHpvbGpHLuev+qcyX3JfU2n
	 9/OBOw9a95MQdSgmabgXUcZFM/8x856GPpcwbp9B/QtUu3X7u2iJpa1bkXCs7ouuyKtp5
	 FzplhhwvRv4O5Or8zFwP9kSWMO+rk4loh0BYWCEUudmpZy2qWBgvN79dAXbqjvH+4PbGd
	 9kCiHSm8yyLWEqumRt1am+Zo0XDXroxoqOWYOH+RPGmR/2a9NyTQ1WDH9D+cKzC+KDxcp
	 UU45xE+JuoVOYgWdFwAL6cePdOpjsxZw+PfD+vTMHJigE6t7z0OOuGOZH25wbD6WSdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=kZ/h9TGg2egXyMT2gSyFxEjX//2ytWgXJJQ1LwbBwBU=;
	b=Wbi1yJY2rVaBti/Ued4WI8JnVQRRU+ecGvmLKKSq1+U0MSZkoB4pbKLO1iaE6PP/aOfa
	 avJj4Bwf1j3FTxlWqbk5+sGmAyWyyKOh9a/D0OMekaclfKJI8EH3W8C3esRx1D5NHrEc/
	 kbfMdUGCBKa5reyb4303yPpTM4rgsmTzdfu87N/q+044DQBCVJlj5/pgOS2gRD50yLzEL
	 AQnZULThAacVA+fgeK9CUm4Z1kC2U94mHBt7DNk9j4ytdtdEIXPPfLCqJZrwNcqOUluEP
	 YBViMfGBLiavI+tISj7D10cjZ8i2wRFinz4ppX9inJxjplO0tStFivbKf2eJDfOtPLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGC4CtIE;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C351606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 11:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C351606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGC4CtIE
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f04ad2c46dso7960615ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 03:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260328; x=1795865128; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kZ/h9TGg2egXyMT2gSyFxEjX//2ytWgXJJQ1LwbBwBU=;
        b=uGC4CtIE9KcFHEOEpwbj1mgrXHB0PUoLUXUSL/tF/V3FAcP1LbkRJ3ggLf8Cn0aPf8
         3Gc95NegZvhyMXJJioRm77sIhK5fQipjxaTbvq0x+Lzu+JXaHYeqlsI6XtqS9cD0Uq6S
         MHkoBshIPctEZfjDZQb4o8lMEiz4iNcZh7rW38KFjMyUodyVwUFh+Xqxu6N1T+y1aGjv
         SQ7HAP+kvF7VCOXUd15LcZJEujLbtT591hND5ey7rlxbJ+dBnkdXfsoeEtqAJoT9gytl
         0ogUnw6aHUFDrfQPGZGfHMYsFxcyw+srJrVxCCg1aDhsjA+72aa8mcQzFN2uHJY/66Uw
         JVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260328; x=1795865128;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kZ/h9TGg2egXyMT2gSyFxEjX//2ytWgXJJQ1LwbBwBU=;
        b=zIlhf8GbJwlF3Dll1YO6LY9hGsv39mHdOkGf8vJ9H3V/hkp8n5hsVLJ6Z2TJRGA9rx
         VnnJ1S/o86AuRFkb1XHpShfuufseQmBFQS76b+KfofPUoCOaTtnsdBo+TAuao7bdh/dL
         PHEtxoNhlTuaeLLJxgoqf5sxBwWUwbtmRAaqEd2vbDZmcJM12cHyodGQqbW302xtY7Es
         F1tL0Bhts2vK0a9475JZsG4w79HG8PjAOmQCfukzVv64cd+46TDWY/PvXhmxO0CHroQD
         XWNFR42bIZjFxt/fJQvEj4Fby6WBUiOc/WK78oAcxqhEtgIZoanV7NXx5BAWXpg0SEj/
         zBSg==
X-Gm-Message-State: APuU4Z/yN6cLwnIakCiWAwm7vri8eI1DzgRrzBFPyMM2kY1Ed196jpIR
	tmEeJTO3NkL4q0YUub5JipBI4uqHAEoWA8p54SdylOvxXwyMsUPcRYyyjC1LxQ==
X-Gm-Gg: AZFdTZfinos6nWTv+Iv2tU2LPRlb+ufcNISCOzfNHJPgd9hV5QM96N2ZyLqVUsNgKNU
	bC+NUY9fgS8ezxD2wQllhtqcx5lVfwAXuHrYC/Lhhj0jLU6LopI2yOd6YRo/9uRYXQ7bqdPL1OO
	jzKszzCh7110bu6Zwhd3+5WSXm+P1TflSUd8PM3wXNq4cGMm/2zFN6QEc4LBX913wELToZIZ9s4
	/L4fpCRcaUbh/bumc0YLXW897F4CD8Q+clvFV8sV8CbV4NydcWdn3objUEXtc3267Pa/VfhlXNE
	kL/f1G4jKQN6muOYCUmTPrjtg4Ci9dynkqNs2QvPli02JRQbY4vrpUvqL18OBLv3WWUJVio1Pg5
	sVHH4skOfUQMZ+9xpA72fvjTWh8kYt7NQXHvdfN1SQuL7RG4mA15e7WCgTYh5wS0Ef6Zo2Kln64
	LpJMBB+s8ReClMlvSF31wnSkxMDefPr4JYntm+D/939XIdYtrR+51f/ovakXD8EzjqeVdLA0Oxl
	/RvIi5B8HnQjnjZGBqrNyQIwxRgkdOKIxwgK1V2ZaxUupXz5nnUlLwn1bSXJMbo
X-Received: by 2002:a17:90b:4a48:b0:3b3:c675:d923 with SMTP id 98e67ed59e1d1-3b41c908109mr5479120a91.28.1795260328435;
        Sat, 21 Nov 2026 03:25:28 -0800 (PST)
Received: from [172.17.0.2] ([52.250.69.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d97356sm11062491a91.13.2026.11.21.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:25:27 -0800 (PST)
Message-ID: <6b017fa7.6cdb42f5.208192.5185@mx.google.com>
Date: Sat, 21 Nov 2026 03:25:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3057756030978785667=="
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
To: linux-bluetooth@vger.kernel.org, muxianli5401@gmail.com
Subject: RE: [BlueZ,v2,1/2] device: Fix SDP records without a record handle
In-Reply-To: <20261121055157.131496-1-muxianli5401@gmail.com>
References: <20261121055157.131496-1-muxianli5401@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3057756030978785667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217926/

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.41 seconds
BuildEll                      PASS      16.97 seconds
BluezMake                     PASS      238.83 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      124.53 seconds
CheckValgrind                 PASS      304.48 seconds
CheckSmatch                   PASS      241.26 seconds
bluezmakeextell               PASS      79.30 seconds
TestFunctional                PASS      1644.53 seconds
IncrementalBuild              PASS      251.98 seconds
ScanBuild                     PASS      896.41 seconds



https://github.com/bluez/bluez/pull/2863

---
Regards,
Linux Bluetooth


--===============3057756030978785667==--

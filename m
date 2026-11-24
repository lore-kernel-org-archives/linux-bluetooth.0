Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485937;
	b=D2WV63TjlDgv3tQGZJ+U/W+mVlqhAYDxJ+cyJUeRdDOWM2dXNbSs0yB6i/gcLzLr9tgk
	 pbLmmlDqAzhykcTvUSNOgFm0pyv8+qEQrb08qlmVTt6muOxnI+JK2AurUmMCz6eygrlzG
	 Z+c1K1RDw3zMpvBraezk3hIh/wi48eAncSz8wi3JFBaNhP6DWZ4yR+mfYshuj+YvHuYcQ
	 xHaP4nzi+HJYOxiNK4jezTgy/D+Ld51f1ZM1wmawE5AtVwurPDLp0x+UjQYRYVdfaYAsF
	 Su7pPXwUtYFfB4KaGeqHl8x3wTHQaaPIk2LAANhvc0wpIASQH6LRKiEv8Lnk0vNqqGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=2L5IvHfdb8igylvwlxQg4ve+wv6gA71Wsji27FaLAW4=;
	b=y4ggPelNfJAIl1oGytEByMTLNXZ3rE9OtHUEl7SycD/UPt8MdE4QyUS2xPqkWzVMBunD
	 t+Ive5a+xCDNIJ1ggMiT6D/KcaXKSbo6tw3fsHipshOrvQnAHm77wAPgp3x+NrzstWc8w
	 A/92KReOeTvJk+l+440LNCzr4EZwyXtsbfCQSDMjLmRywcQPq2grcNEGLl+zlSmpsnji5
	 89/3TRk/7G/RViyoIkeFEIDvAnMqqW3ZYecuZatWOfNkkpFjFZ4eRQzAMuW4BGk/JIHSN
	 MHByCl7S5EvCwSMBHHbQdJnHGdZO+zYhcf8P6qq6ywJmQ62s66Sl6iKh2RDawrn3Sog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQ6dllk6;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F51606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 02:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F51606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQ6dllk6
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so3470914c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795485936; x=1796090736; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2L5IvHfdb8igylvwlxQg4ve+wv6gA71Wsji27FaLAW4=;
        b=SQ6dllk6zEcnm1fBbXCDXglHZekKjJjUjl1U1pH5uBAG8ZEQDEngPuihT020CqmkeT
         8nlOkpj/DjYTLadyeE4EzyozyX4kuYINMO+CWoSVz2CnuND8ZWnbQomZybqFLUNMyNtA
         809nz8lOY1SpKNb/gFHx81jAwTP6C9NddKUqs0WV1W6pgESAs6u1BW3MrYzoXea08yzS
         lppu8mL3nRhAasS4F1Rai+35cgD7xbKPgcCQ4DhJ2Hc+aXKJJZ8ShwDN7hFNcmzYPeIa
         otrD54tYy5mOdVdRDC2RQEJ5vXeeLVvbYnOR3t3X/c1hOBMZuy7WfLnz2U6pKwTY5T6A
         n88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485936; x=1796090736;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2L5IvHfdb8igylvwlxQg4ve+wv6gA71Wsji27FaLAW4=;
        b=er0DsmYZE4WXp2oJNgpnEBhc+alPI7wwc5UwhJ3Lnm9UL0MP9XAnFQZD+xQJoHBawU
         aKtAbaQdZ+M2E57wVK04I/ly4nQ8J79+u0b+vZdmYhxr/uZO1JCQ9SH8ilE9DWo9uq9W
         V8h7ZG0mpDBNkTiKaRIQPHomcznSRNpTGiWw+1lXzo/DRZfTpd5UMR/eJyCLxnPJ8mhY
         dBGDyHpMjsLElTizgFUS9EktbWbsY79os+/wvDiwTor79PCE1STfgtIp9KbB1pv2pv5d
         5t+NXgOYaRD+6QVQZUfgTDGuesvsyHq4eTL/y1SPy01kKVDf/1YPX4r/zTynVjjNmW31
         J+qQ==
X-Gm-Message-State: APuU4Z+RpMDnz/Zwv9KqS5f+ugT1Z459vJCX5RyhAO35IBOJ8QeZiLyv
	0EtHXaUR33DIKrA3I5UZOUJJUfNAWzlGLixNZJoZClEiaP6KCJQO0OSJDAlFhw==
X-Gm-Gg: AZFdTZcxqLEDHzGacgPBHSdW7iFGvE2lDLkr4lAo2IHifJW/hQe16v36prOuuY63hFR
	va1NWySdQgLg4T/e/UkJUQWIkZ3MpryvVwgC1LANjFnxPDKgdhvXF4YZKmIkdQbMllrOqJcD/qG
	RcLHWN5A95V9DMqAI25/pA3Vbe+7pkuXImrsz8Ush6LghnJQn7Wzg3MMFTiBR9GLaPUIs0K/Byw
	UTdDLTzIv8Up7WYP/LexgG57s1bbUvm0upFSgnXDla6t0UKL3SDQfgyTQD3kb33sFwvDi4t6uWn
	IAdAMjDGSzHh0hsU4XQJou9lNHWo9sT/8kMOB86i/elr+s2BNX9K8e/n6DEf75Ag/QjEac+TFQV
	vweCuZmwbR56dYB960yepnGtiNBmVftZg5Hs/sNqqZKzR/DipJgJ5IEd+n0JAud8vmB36KKLDXK
	qU3eaJaWwHfoh9sn3nd+tr5Ee8qmy3NCsFzYgio0C9T6DtAdV00IjYRc8rW/fC73qhw0IfzpMmy
	rnP1DGq6Pdp1d0Ok2i/Z8rfig2dtmIx50iOvGuFAidXq41btkCUiHyqT2M3O6o=
X-Received: by 2002:a05:7022:b0c8:b0:1b2:6855:998a with SMTP id a92af1059eb24-1b556911007mr11885731c88.34.1795485935684;
        Mon, 23 Nov 2026 18:05:35 -0800 (PST)
Received: from [172.17.0.2] ([52.234.45.181])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm30513890c88.3.2026.11.23.18.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:05:35 -0800 (PST)
Message-ID: <6b04f0ef.0a7c1997.164086.c08c@mx.google.com>
Date: Mon, 23 Nov 2026 18:05:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1125510979783167444=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: monitor: Add an OBEX protocol decoder to btmon
In-Reply-To: <20261123143054.116007-2-frederic.danis@collabora.com>
References: <20261123143054.116007-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1125510979783167444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219707/

---Test result---

Test Summary:
CheckPatch                    PASS      2.47 seconds
GitLint                       FAIL      0.87 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      307.02 seconds
MakeCheck                     PASS      14.52 seconds
MakeDistcheck                 PASS      149.60 seconds
CheckValgrind                 PASS      361.24 seconds
CheckSmatch                   WARNING   314.95 seconds
bluezmakeextell               PASS      100.31 seconds
TestFunctional                PASS      1227.48 seconds
IncrementalBuild              PASS      355.51 seconds
ScanBuild                     PASS      1207.15 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,4/4] monitor: Reassemble L2CAP ERTM/Streaming fragments before dissecting

1: T1 Title exceeds max length (83>80): "[BlueZ,v2,4/4] monitor: Reassemble L2CAP ERTM/Streaming fragments before dissecting"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2293:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2883

---
Regards,
Linux Bluetooth


--===============1125510979783167444==--

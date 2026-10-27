Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136496;
	b=sp7Sm/Uq19ACqDrX2Mlq66CGu+9nGP9TLdYia2ioiZRgNZQq+Q7miRxPwQRpSbqjWssS
	 bzoqvzpneIChC2j6rObVCn4JltG7sP8zGZY7ZIZKvSl1e9QlIwnMtpoTw81MPc3Lo5OYO
	 cFQT8A1EUClH2GVkddlp+cbT8fYHBBtqqu1deI1mD89gLrDksSICGrjaH1Os6xX5hmcFY
	 QfH224XL5wOsKNL+zDNjbYWW+6nR/Z5qCa5oVvemJOZo15N6hYQ50lm6Xgbuvo1IjXppa
	 K6QDKBhpb/HO/hhP9jptYolHC54w1pj+i4qnM8cX38GUpg9EVtOFB8UAEBEETOF+ayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=BG2OfRMy1R6/IiLycPcCE21xewYvrgc0XSd5IY2Lt68=;
	b=q4/QOQQbmWSGU1UI2vtqQppVPMEs1kuLSqLUJmj7YMksAoluQnJb1QqwyGChE/wpsqKD
	 6bfNYfAsZiTYszwab6DUsXC55a3nY8pDpY9poFm8CQpOH7HHFyJXct79rBVJovaxMcCeM
	 Am2zqpf2wrcDF0kW2UeE9djvyYKPCuy9AqXU+2zRQTNtVv0IzgURLVfB8V4IfAkUZ7rcO
	 HMwdAEDFTdT7LeQ2/IJ2pTD7YHaz2wqPp0cqeiJkhw6qFqNXusJPFOi6+Zr2Lxvq4/wKW
	 tAJkYqJFZZYOdklLz8JN8kBd4ktS+gFea77DR84zY5NUbGBDQ2Mjdiu8tFbJoGU34jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QH02D9NL;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D13606A31D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 21:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55D13606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QH02D9NL
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-156cbe59622so319091c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136495; x=1793741295; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BG2OfRMy1R6/IiLycPcCE21xewYvrgc0XSd5IY2Lt68=;
        b=QH02D9NL7T7oT1c8RLWUdOA0A7+4+5c23PI6qP1mNOMultEfYEUDmZlOuN201Q+1fe
         TzbDnvby1g5+cRL+BoePUd/qlumaUzUapgA6S4CfHlU2PoD03Eq/pWGC6ox2TXq+2i8H
         gpf5qnEvkUX6voNPU7uebwNBd+tv2FMlcsoPdp3AFa3TbU60QCEFX3NJORhneEHb1gx/
         XQsK7Ec36KgWhohvb1Ji0I/8xG7kC+/BpeYSEAnLLlcjhzvZkyxY6biLjaUNxqieCg1I
         IWVgJH43i+HlWtrDOC6olC6voxvJ04on+8sg3h9wN1n763eFeZ9WgZ25uSxmpaTwGtpS
         KJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136495; x=1793741295;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BG2OfRMy1R6/IiLycPcCE21xewYvrgc0XSd5IY2Lt68=;
        b=DRzcBJE8gsXxuEBI6k5N1vuGYe0QukYVe5J0i7gfIGOWJC0MwAutJ/ofa8XjqcWxdL
         OLRfLe8fGFufbf2U2YhdzXH3AuExecCahlgHeL4iDnFeQmj1pYhuDAtOeumJSPpBUzBG
         /Z8ayYHhHb7XkQh+B7VXC64PIES8pUs7FqdALMVchA/n92mtzg3uA7yEixpB86bkvPcv
         UdjNqYCpR5EzjH9oySngyisDch+k2vXUBzWIPPiTOjHrW854rlafXmzBU25Qf69BEZ2J
         OdvpSBhg+uKFb46cHwQYvgtPlKACXmVV1ESN3rkMQ4poO8T9JcY5ZQLvtExW+COQYy6K
         ANkA==
X-Gm-Message-State: AFq9FYIQthbgcIcULJWyKx1+s1SCIImZDW/KE0b/a1zHSthND6xTOqRx
	wYATkTtn5dZivZYFS+n4sXjJTqvaU9kJmiHvu6vxlTVfHz9QZ1Oi/6sRUiN9lA==
X-Gm-Gg: AYBFou2swgVOEKcM+thZxEzYUjXcZi+nc0+iV/4t9XZXTD+bFTlp1oMp8/SuTPkb5yW
	RsY2vdMrKl2Vzn2khTKUsLZuJlilnN45EkkfiM3Kl0+bHWv7PBJMRCbRO8YIQrTxj15BqBCrJwg
	8FAD7mU8LKpVEw68QjO3w0/wrfg8ZO3GIxXi701Mgkl7d9dp6gNU5oZXPPQnz4dVmKeZu7HVTwg
	0y7nG6c7RaRjjfrvYS/sQ09hULgbtHD1LIn4PmMmDNpPWgvbEtEVmbp8euQ1JztCjY5oPLYHn10
	JFASGN2HRydC/A8vNCdAI6Ka+lwcoEaESmirIp8IPwSvLgFTMjhCLMrVDcbS89HQu6JwZA8SA3Y
	l/Wz6PzvslV+0YWjalpoR2b8py9DjOzFScXmIhK2sK1zA3Rv/ScfDGw8Pv7UlfZgTIPwsEzl7fc
	K/okTRXhmcHt6FEmXF+1PM87pZwhd1vtoV/YwOdJ9MEKUNKHcZb/QWt+d7aywiIxXiXKTlxT49y
	FT5im5rWneA8gzQ13e0cxK6z1NnZxy8yz+83ylg7eJcrTHlxSHTpJAumo/C2xAt
X-Received: by 2002:a05:701b:291b:b0:149:1feb:6da4 with SMTP id a92af1059eb24-1a6d0d53192mr505614c88.32.1793136495222;
        Tue, 27 Oct 2026 14:28:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.217.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6cdc492casm991297c88.0.2026.10.27.14.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:28:14 -0700 (PDT)
Message-ID: <6ae1176e.492e23e4.2fc872.8b52@mx.google.com>
Date: Tue, 27 Oct 2026 14:28:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2237735672813947416=="
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
To: linux-bluetooth@vger.kernel.org, valorcool@gmail.com
Subject: RE: Bluetooth: hci_qca: Fix WCN3950 missing regulator release
In-Reply-To: <20261027193615.1930624-1-valorcool@gmail.com>
References: <20261027193615.1930624-1-valorcool@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2237735672813947416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194889/

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.86 seconds
CheckAllWarning               PASS      31.78 seconds
CheckSparse                   PASS      34.58 seconds
BuildKernel32                 PASS      28.11 seconds
CheckKernelLLVM               PASS      39.30 seconds
TestRunnerSetup               PASS      655.40 seconds
IncrementalBuild              PASS      26.65 seconds



https://github.com/bluez/bluetooth-next/pull/1011

---
Regards,
Linux Bluetooth


--===============2237735672813947416==--

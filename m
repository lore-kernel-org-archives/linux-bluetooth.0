Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671670;
	b=BVvtrHdx3Nk43n+E3S3a7mVT78lfdMnd6GQnmgW/v2hClyDUdeBcf/Zu0ZxpL8wRIOaC
	 CpMdTKvIaCmpZDlXcOZShR95YuM4EvkYE6n/t+T5fsGxy6LTjyWPNHe4o5EYPu4AV2j6H
	 107CmydfrjmSn9Vi/QCe+HXf/wLuW8d0VrSdwLJKk4otxjfFxotLf80IBPbd34nGF98NL
	 5NCA7CncXvJx67w5p3/MNjSa276nAMXbTTZYYElSF6+vGTtwYNdEL5PK8vRm2alZt2ITb
	 0TePNoed5mp1gLrGHmHV0dn64CiCeeJ+6De0hskmnaYQLU9Vyh1DXMT5U+uPclwGrBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=He3x3tlyZ2Wuq92dVczJLhqRD8TkXBPQ7vwCP5F734M=;
	b=Oi9oGqFEMASBmGswjuMkHsddbQ50NIlmd5FtX2vxE0Vn9rxx/fcZtsUP2ThUooRbn55x
	 489ijavDwAKypGYIElbnYaT9I4Gf50nRtj4zmpVtWwQpKm9hYHtQPCVubDjI9sLBmGzMv
	 DKQ6uHLsDl/lWlYvHP3yzl6pVGlBbK2avnkDUcYKkYIggrOPxaDcax1P2Ek17XrpPFSH/
	 uQgwebBtTZjX6Z4vLfTWoAXITUck1tYwu5MGHe4ZpvXQTr+TS7WI1pjDgkKSXxCCcvWW+
	 /j58k7jG3S6G3krhmDcIjJ5pwgEvNn9/hlQejxbOqOdqivhuDoQGA4m/lsS0J8bvz9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPSg973L;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C95606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 05:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPSg973L
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f01f296937so50974835ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671670; x=1796276470; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=He3x3tlyZ2Wuq92dVczJLhqRD8TkXBPQ7vwCP5F734M=;
        b=RPSg973LmH8XpXjZtNaNK+qSCO+VHdUzhgZExF+GPtR+ryx2Tg/Pip6rhug+k9ZuBS
         GCSReOshyXoJIZ6CjJt6USh0YEcVBD2cRRd1uzySX8itB8iViR1nTgnP3u5CvMetqxUW
         gAQZpyPh3pkc+nknoZg45O3oVOsuXkdNsnNc0dGZv2WxTE2olgfID7BUE99oyxeaKnmr
         S10oLRn/Q4lxC63bEiZf/Lem/9klA5BbR8RRNwLaDwvDt1sKQn/TgaDWb7npzfIypsYq
         FuV18m9ZDn2XlPmFxbN8SB0EjPRNeW9Xu+MNDue0v6bqyeEi3pNDwNtc6iEJOQaP6IDY
         bnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671670; x=1796276470;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=He3x3tlyZ2Wuq92dVczJLhqRD8TkXBPQ7vwCP5F734M=;
        b=MNJjeTIFdT69uu1vpbuJsXAGtIJ9EJDAMd54TkfNy081USHtpcPWlvLlX8rEHLcLly
         kCkEtHKWla+f9fvuhlPtlCGz05okEfd4BXu1k8uaZrmbKEjWrTDTLbIcztFqfdR/Scoa
         hmU3a0cZw0N0cX/PYBYh4iA57T0nXics62UOFnlULcXou27VN/qaYlXjY9MR0FbKO45B
         NoLOXZRPjnrT25Fm8HHVeiooAxiHlIUUCUFhEq/CG5zmi+x8TsaOkl7Sp7HnMLHYvfUg
         uxPiGgf4KBQc5sBYkYuCrT2FlKcpUewnVFCEMUuGCnWqpbNFanXkn6zCV/6jMtQxtTtH
         2Gjg==
X-Gm-Message-State: APuU4Z+LcEC5o9ImSxnkAWUKBXx+Nz4dPY1jtmiD1qvOSnDNmAK0jk8y
	SK98dYIMCDlT8cfCWD7/+Ip4QAeqlhG320Wme5bT2pnMmspR6M6sWdYl2Of9vA==
X-Gm-Gg: AZFdTZdLl5+Dccu4COvNM6+j1VU5SN66zTsJ7mEIvdedik2n+8ZpEH1SlnRIB3r2PIU
	Fuk0UywjYaRFmB5fgeqVRwbxf+apgDtkE9ElGZlpvVs8Y0z6RRfIiTJrez1ZYD9xDEmZNI9whJM
	X7+1Ax/9vzB/2vtdXcQX7aui+9i5ApYuyUTBwqUEHqoXw3a9XvgOwuyNh1I3OYazarvtt06k3tP
	e9sn+fUOJLvG5zuG7V1tirFnFY3J9UmsdKl2rP/eBZrbGSadG5CxOtuiOSZmf7m2FT0xaT6YKm9
	WhpPmFt3BfrQBWuSYOhDnMmY0sKjBjep9ygm8v/Fc9utcnDELyF27YY695lkjw8QGydxTLAPSZ9
	XXxzSbFhCwRBqQtk/0mt0UtubmcxkUrivH7/XdNxnuhG1C7Xn/sZepM2cX30I/bqwQorTej4tHM
	zOb/ULvdGmEtEXM5y+rHTRNO9QrxpXgFjRDWszUjE0RKHl/hMVZXLkf4zciVkBgq1dbwNiTxnrX
	LYoMgCjGJFVnhPMBupkh3RqjMhUFOdEpzKn4jlMgkgXrzU4LX+Uhj9OC0pmqe0uKfyU1OEIxezg
	vrnJ5gLa
X-Received: by 2002:a17:903:230a:b0:2ef:e755:bba2 with SMTP id d9443c01a7336-2f03f2b6004mr204556085ad.62.1795671669790;
        Wed, 25 Nov 2026 21:41:09 -0800 (PST)
Received: from [172.17.0.2] ([20.99.244.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84294sm95945125ad.9.2026.11.25.21.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:41:09 -0800 (PST)
Message-ID: <6b07c675.a5baad57.172287.9965@mx.google.com>
Date: Wed, 25 Nov 2026 21:41:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9155656419979360640=="
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
Subject: RE: asha: Notify connection interval changes
In-Reply-To: <feae2742434bfca2ba04cc882c84bad4cc823c5d.1795648818.git.cochcoder@proton.me>
References: <feae2742434bfca2ba04cc882c84bad4cc823c5d.1795648818.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9155656419979360640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222688/

---Test result---

Test Summary:
CheckPatch                    PASS      2.32 seconds
GitLint                       PASS      0.82 seconds
BuildEll                      PASS      21.12 seconds
BluezMake                     PASS      314.14 seconds
MakeCheck                     PASS      14.75 seconds
MakeDistcheck                 PASS      147.66 seconds
CheckValgrind                 PASS      351.06 seconds
CheckSmatch                   PASS      318.43 seconds
bluezmakeextell               PASS      101.07 seconds
TestFunctional                PASS      1253.58 seconds
IncrementalBuild              PASS      350.47 seconds
ScanBuild                     PASS      1212.25 seconds



https://github.com/bluez/bluez/pull/2929

---
Regards,
Linux Bluetooth


--===============9155656419979360640==--

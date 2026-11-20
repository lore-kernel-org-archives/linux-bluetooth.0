Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181419;
	b=H7thg3+yGC5LnVwuUx9+5MQpDcaJI+eyzraPF2xUuqG898cfd7whf5RqALDib45YXukj
	 D4zfxCa/pvT36gnaF6ES3VQluwav10nzI4HASCjsEz7utx/6cqjSbl/uwNdgFZPD6C1nT
	 Dfwr04DNp5uTCHoawRci/WDot8BbLI7apB2nT9Xl1JGYWpOr7ZEBjvxAy6SA2EAuwyzm7
	 nu78TUQ6BoehBpY2Q1K0pA9AF31j4hKuSMlAq//7IfegptfZiKplqTudfVS13XFmjJ5gN
	 X+Sghl8iPHqEgcnMyvnJNVQxrPOX2M0U9HMDKRJXTJhGCqbD5kXyl8Ajl6k4pqHZLXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=jYWFZos99SyILK+AdodvAHPrLUO65B2qxQRBti+1eeo=;
	b=bjqPPJeglfNGjNdHCHoWVxWOz6FtYX0UL98W4QImZlAqGDMZhNcPiXubZ0KbBymzfBAb
	 A9Iekqua5ricX7UsrkTi/dFJXR16Ioj/HuIneLDJ5lJcWOIWnU+4NneOgB3cfdDKD7WDa
	 VzCh/65/726vUxcrb7RQ2ft+1EvEkyYWI95wpLdEC9YWsn9nHSS6Xc78NzC68bZWvx0oT
	 x3mGeSdWa0nVZ/CWU9x+X3xiaQoXD+BTwXkd/3KqYecMJ83XWL1p+LDjRCvO9bzGn2GLv
	 cA83jlpOZcLKBUyJX6k/PNL1/sDItRo7nljYSqLYGXB3+V8UVMic9NV/lSDFBsiooVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJXyxOjV;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F3606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B3F3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJXyxOjV
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-702fd86d674so626310eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795181418; x=1795786218; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jYWFZos99SyILK+AdodvAHPrLUO65B2qxQRBti+1eeo=;
        b=mJXyxOjVMeFmkDy4DSXfdK+fplQlE7tSYHWu6FkZu6HyvT5+9g2HW3Z3jYQea1xHXr
         JLE8sK8x0ZLX5nyBF6ZmAjcr5JzPmaZ1Ixp0QOaWl74tZbjDJX+lPpziupXKbjXTi30r
         0OsZmY0liBavkeblgEreggvxnUfhfoVb+A7aYt84QtPac6v2FGBa0+A5xWyf3qsQ4gh2
         6DYizTePSkMY8t38mf2Q2JV1P+lBkivffiowPkUZgZ3INfynkKarY8ECuWJRkJegYTzK
         k9JVXNK6PMWcE9Ui2DlLfISckMUj2kBRII+3t0GzZe1GROshFE9ATRXPEZyBP0MeW0BK
         gpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181418; x=1795786218;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jYWFZos99SyILK+AdodvAHPrLUO65B2qxQRBti+1eeo=;
        b=gXEUEphdq23+ccSFBuk+pXfzTvdDLhV1jNJS7tZ76VbeYwVc6YLBkBDVJ+NFDCYY1W
         GvltBpmPb91XhzzUZkJ+6Tcoli5/bKQbNmrBqZbUOcCYNrCmqTmGeKI+kvwNP2ikhgwU
         XDIHOPNuqrmfVDKHUCAUmOtfRt/JAc2HmPOAnge/W3Pg/iMxIHczWdzJ243HRsjNYEtT
         w3U0S6XU4tauSeoxhvAr6FAry0VSAPbozackHM2SOFf3cF22a0Du8wzCHyk0guR9p4ZN
         4XbugXwUREH8erEeBiK03TDRu61rpEYuj7qyWzTG5v2QRbvWBfZTBaWlWvzchChLWr1k
         C7YA==
X-Gm-Message-State: APuU4Z9cAtWfHnERxq1L6FxCdoFYtWYZAVZNT+aA9Ykx97cA1Mr9bg1D
	oTbJcDM22+k4UOmQhlA5NOpdck6Sa9297VUc648QCOLBojCaFFO2qEPgT6M6MA==
X-Gm-Gg: AYBFou2Huf6xuKoxs/miHtK1td5sru07cM+MfKALzA0YrqgLHJC31V93G8uxf0gBiBm
	u0S7L2KQvlMJrKAqwiJnDkVZf+hZ2Aigy2e09V8qDiLdlt5IO4GrZ5Mr3TPMXexlX9EL4Gj3dMN
	g4HBFBzlC/TIkjHU7USiw057n8WN/ekcLyc94UX1jYN550UBObKWgBPTCg9K6vUgfGivwdv8Bbm
	cP4xzzgSHKJxXaEFlAq6qAChr/hPfMtnrtGmFnndYPtatJ73mrH5bAFw7FCrzJSY6LjEOeHeTaf
	wgut/gaH+ybhhKnXICPgcRDBwziMBfGEF3lwS4OemfLq2u7OcuZTS6G9uOZ+cDM+Jc1u9GgvGG6
	KyvFzK/Dllmn9RvqwDsB8vA1XXYtBJLUmW704kV3Nb2ipQ9Y2MYXv9bZ5xuf+x3oI7w8cKKwqRA
	3ZBfPWod0mUYQB5oiK/VI5DGVGjepYy98TsVLMUvLGZ5zvHb2Mar3gNpJoQg3Ly+zRKjDWcbW8A
	XPi9DMMLWZF7HNQxVpn6D4DYbNhW1jzTi2UBuZQrEDtM/ZcWxJsDPMqtpawxbc=
X-Received: by 2002:a05:6820:a703:10b0:71a:e9b1:65e3 with SMTP id 006d021491bc7-71b39631876mr1653971eaf.81.1795181417807;
        Fri, 20 Nov 2026 05:30:17 -0800 (PST)
Received: from [172.17.0.2] ([20.12.244.201])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b3806ef20sm1917353eaf.7.2026.11.20.05.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:30:17 -0800 (PST)
Message-ID: <6b004b69.9e649e5a.193e9.5638@mx.google.com>
Date: Fri, 20 Nov 2026 05:30:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0371806579660223175=="
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
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] Bluetooth: btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
In-Reply-To: <20261120094249.2419421-1-kiran.k@intel.com>
References: <20261120094249.2419421-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0371806579660223175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217120/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.31 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.59 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      28.62 seconds
CheckAllWarning               PASS      32.32 seconds
CheckSparse                   PASS      34.57 seconds
BuildKernel32                 PASS      28.85 seconds
CheckKernelLLVM               PASS      28.62 seconds
TestRunnerSetup               PASS      669.51 seconds
IncrementalBuild              PASS      27.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/2] Bluetooth: btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
WARNING: Non-standard signature: Assisted-by:
#109: 
Assisted-by: Copilot:Gemini 4 Argon

ERROR: Unrecognized email address: 'Copilot:Gemini 4 Argon'
#109: 
Assisted-by: Copilot:Gemini 4 Argon

total: 1 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15004865.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()
WARNING: Non-standard signature: Assisted-by:
#117: 
Assisted-by: Copilot:Gemini 4 Argon

ERROR: Unrecognized email address: 'Copilot:Gemini 4 Argon'
#117: 
Assisted-by: Copilot:Gemini 4 Argon

total: 1 errors, 1 warnings, 58 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15004866.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()

1: T1 Title exceeds max length (82>80): "[v3,2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()"


https://github.com/bluez/bluetooth-next/pull/1167

---
Regards,
Linux Bluetooth


--===============0371806579660223175==--

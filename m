Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBC3932DA
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865222; cv=none; b=jGsVfTUfJYw48Q7do9ym9sM409rU2RlNPlrMuwT41oHgakvCw6ABpdknNmpb3jENBizspO/qrU8H/rBqfrkKBrdd4o5TKAp1+Q7GPOQ25fAuHfheVRwAdm883uEg6yfAFWjY7ghf13+qCUzVlTWA82Bk8Cw6sdiRFxDUXXD1gRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865222; c=relaxed/simple;
	bh=V3eHw/tebC0Xb2LJ1UC866WhqlMX6osZ0nCVWAwqU70=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t7tOq0UWkikNrtR3kuQDOSjSGDzeItDz1V90xkRh9K6S5s9eaWWjdQJAsUShubR5Fwuk8x9boob9LVRwmZbik4ZBeOLpmAtzIKBa8L37Mlx4J0T9dFbmPGLhO+vrhsBYJmcxipDXGZV7cmHE5mbaYDD231CfhufUbQJQiTgA/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK78ps1d; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK78ps1d"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-353804b591eso4306915eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865220; x=1792470020; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oJ6/Po1MjF2J1pbSjY2m35aJzkXPnAJZ5xM8MpMEKWs=;
        b=kK78ps1dVdJJYtKNGjuqHD9Q2jQLAEuXOptLb/cAC3r59KjAQ56LGmiehBnmMo1ioF
         YFqWMzBNYcOpnvifSXSucC5YKOk0PcxFeOirSnDBNKsqxc1woNZhjeDiFJXv5o4FQgTP
         5WI51V5YynAZPHTZBKzLJagoGcQTUikzeIUjFDCX6BvOGu4yw2mB/u+bHeeRO4vj+KjJ
         CLbxBGMw6gfWclf+sdB+vqV5c/v6foF+uncnizqFpsw2wrn4vAW7JmIUBvnl0iMduJ2j
         zCQfcPMHd1brtONuwBO5PuRUqtEScwoZH2qI3T3Ln4lzSs1rxnBVkNkxJXEUn4e8G8DM
         UyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865220; x=1792470020;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oJ6/Po1MjF2J1pbSjY2m35aJzkXPnAJZ5xM8MpMEKWs=;
        b=QiaT7XGCKAU2Gs2IdNhHSUG2+t7hYi15nwsj+4DAJC8eP35hlOp2eL0no+HpgB++5c
         uSkVqt+RzJWbOl06uEDviWdgmE359kjzJV/0EnWsgLMySE8nDnpMcQm2fKvV964G+Nkk
         Vz3bssjlg7UXDgm2ltxfuuZtrxMGr3rVZQMbGjTZjNRgiJulCS+c533hJpC5QDt3+kXf
         QnKcDBIckF9UZjKzxRHWn16wCjDS/PnezdA15CyWVrOPQG8nYKLzsF7XAvy9WdKopHwt
         Ac/qayXu/5w1B9GFfRo7voa0JeVth/fQFowbPXbfYidFpb8B0yV/DWpi5vZV/AY4LkJl
         wO0Q==
X-Gm-Message-State: AFq9FYK85hyAbeFZz9vubzXbYRuMGOSmoU4IYJY7q53EzKhRU83gBO7L
	Vo1O/M9cw9qKKwEPLLWYulXAJfc6IrRJzO7UiDECN4xmjPUU6aGEbcnp3U65Iw==
X-Gm-Gg: AYBFou2H+uPtCi+MSrJaK3AlqNP0e1GaO1mbwnRY2rc+ZtRVB5v1Ed3ZfD+F/ilIgzi
	Z5c6QSSsmzKq1uoJK7cbVMlH9FraYrNKia82ySqXJYA3VljjImrBKzWdLAXqhQgsN4LSa150RpW
	ySzWX60ymD4rJA3SsVdxOI8LSs6FjRvM/CNepHm7iNksMrQYMZalFVaah+OGp0axRDHepBRLh9d
	VOSKnT0yW/ioAGiXob0bg5uahezZfQzsl2Lje8fj1VuQz6XxRGewyMekZ9VarkdkuLEy6BSWLgU
	b0LgA0xPhkNBZwbPPn/0XuFMB9dKQEICGYdz54rJRpH4KAB2dYrc9lvI639OAxuG1dWXfWf+E/K
	2oivYWUBKWRLV07tkO/VcUBpn4A9oEJbzDB8+zNYiKStI3s4OcnLfgXueaz12WZk/jxQ73pc2IU
	h52uqhl//hdjY+5uswUdOviBKAl9gEcZWxr6z569w9mKPZ/OJAN2C8vA4vJ39kWDBeAL5zC2Bt3
	UgW
X-Received: by 2002:a05:701b:280a:b0:14d:c7ae:85df with SMTP id a92af1059eb24-16a5adfc08emr17463602c88.12.1791865220196;
        Mon, 12 Oct 2026 21:20:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.37.198])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm36227645c88.14.2026.10.12.21.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:20:19 -0700 (PDT)
Message-ID: <6acdb183.018c0331.3393de.ec4d@mx.google.com>
Date: Mon, 12 Oct 2026 21:20:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2181251187474012944=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
In-Reply-To: <20261013031943.489829-1-cochcoder@proton.me>
References: <20261013031943.489829-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2181251187474012944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184328/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      21.37 seconds
CheckAllWarning               PASS      25.54 seconds
CheckSparse                   PASS      27.19 seconds
BuildKernel32                 PASS      22.33 seconds
CheckKernelLLVM               PASS      24.27 seconds
TestRunnerSetup               PASS      508.85 seconds
TestRunner_l2cap-tester       PASS      13.31 seconds
IncrementalBuild              PASS      20.81 seconds



https://github.com/bluez/bluetooth-next/pull/907

---
Regards,
Linux Bluetooth


--===============2181251187474012944==--

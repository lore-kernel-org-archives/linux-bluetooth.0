Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517037F735
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424343; cv=none; b=degfGQ4o0m9pyLM1POqpHEsr9atAftAhSwOfL0WWYfIXBRK3FvEFReTipNNfUlEG4Gpy5tmikSxou/TRrMzb1jI/R05ZIfaGmenTr24uV2Lj1UVYTsC3s8IbPK1alIDRWKJ5RPt2SprgrRNbPFit/2Yx2tguqof3MEFkI7RDjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424343; c=relaxed/simple;
	bh=XFDQn+DrZ96t/NnqrzOlcmVeDt7YGhY+vf8MlNGVjdU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tf+bTQ/eEWGCZ6joHxg8c1rMalNUIcoD7pSJBfC3zvX1AsPOGd1VOV+i3UByOhyEsdYesht86PZoWob/q81/xkMkVon8+kQ2SCpOJM5hnfClHYgi64fKtEixkfTBgp1DVM0CwKnd958gGi81TMWPhORcg+CfSeKwEZKBLcfKxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkFsW1EM; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkFsW1EM"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c63e942f3so1591077c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776424341; x=1777029141; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N5MBOSsPJAfiZzRKkl/XnFhnU1q9OkXzpYRSwwqDO1M=;
        b=LkFsW1EMA0yDOQ1XMCeRE945bQ0S5DHCvLG3ItbEuHV70FCCxL/wEIvXuwJcu2wECG
         kxGgkTRqaLXc2E7TYK8IU2gUARCkjxo7wSDuTPndzzIMsPXmkfHrClPW06U4WIltcHEu
         kslXWrxXwROgICK/Q7ChnzWgBx7Av1O7wewpRYWbdZfeSTpnW8OSA+0HBG/jY1PQ2TGb
         gfVfcA79A06GCDDmXkBCXU9v9DtzZ3BgrNtMggOtw8EkK2j/Qo0gRKPIO9Rh5XN5RHPA
         bEs2xWjpAFquEBiAh2zmLUld8fN/8yamfUjigPkUxGb0JAsVrR+9QKiJEkCKtQsnsdpx
         1Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776424341; x=1777029141;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5MBOSsPJAfiZzRKkl/XnFhnU1q9OkXzpYRSwwqDO1M=;
        b=KE0X7gLIlgOLXgcJU6Eunk4e5QvFFC2xcpfDZS0oOBLKTgTTOIzikTWqJ3X3nl9pIK
         vcVi1Q9cQssV/8F8E8NA2NesQCYiWr2un7b2cTj7q/QSsbTODQ13/XylkZER2Ot5FsaN
         l6VFC6Xs+JyRRfPYdFB8XAZwFFQHQjiNOkp7+xjIfbsrA2Hhfmy14uhDgyWowom10bnH
         MYxQ6s2XXn601FshO2FMdPLLIvaQfNBNYbkyD0NTypOSSD2H+zKXn3kCrsHCfivbclZE
         lqSM4MTUztE24WEaE3OYlFVUilutz21w1R8f17FwnAS1TJE/RJzlkIR2EjMEhaRAzB1Q
         BE8w==
X-Gm-Message-State: AOJu0YznXRghaQZwJ7DmA6dpq7jnxQdPWvvXOm7FAD1ovW32fhV+5QYR
	EnkpHqbBrLHOYwoOPPWS2aZcYEQ8CWrDvRvxA9Nb8G+Jfg0PfKGDSe9sam0VJQ==
X-Gm-Gg: AeBDieu5jiKu33Cs7VNQICfIROaowQbSXOT/Lzw85afKcrBPuRp1w5e7cRWAPzQJqFn
	OWdGzIiZEdnQORq+TMYqKXzgxAjYiGbAr9V9nAk3hy70NYQh0OIJzVoOZv7AvRycEbPiuGh1y2U
	t4xOwfTfRtGkpdBbfMWBDPLbxVsgdh60ZNpkwlS4HhP+t56B6Ia2LEbBkCt3BL3qN+I7aVXJnX0
	fkxDohWL6YpqKTFXHQ9oZEkFyK2PdE6AtCs0dqX+w+JMx2mgjTvTw/xHqE9cvpjkefwPtY3BMQw
	8SKps1wlnU/gTb45pGg67+bspZwD2sD9hISjvH8V5vg/u1k5b8vp+BlbiNy8aH5x5nwIO/P9u1o
	jjAbobEC0g3b3Kw7cG/c6IfnTP5G1Qle77crt/YpMgAfJlO6rpWgGaJ+u1irQIAr4n4Q83BWmV3
	V+2t+KAK5LZiOGzsPp52M8EpTqlmDPRLEV0LM89c8wfQ==
X-Received: by 2002:a05:7300:d517:b0:2e0:4edd:64e8 with SMTP id 5a478bee46e88-2e47a2faf4amr1141634eec.24.1776424341412;
        Fri, 17 Apr 2026 04:12:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e536e54562sm1649503eec.0.2026.04.17.04.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:12:20 -0700 (PDT)
Message-ID: <69e21594.050a0220.3adf79.2771@mx.google.com>
Date: Fri, 17 Apr 2026 04:12:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8355444245145787121=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: [v3] Bluetooth: btmtk: validate WMT event SKB length before struct access
In-Reply-To: <20260417102919.2549352-1-tristmd@gmail.com>
References: <20260417102919.2549352-1-tristmd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8355444245145787121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082459

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.96 seconds
CheckAllWarning               PASS      28.76 seconds
CheckSparse                   PASS      27.37 seconds
BuildKernel32                 PASS      25.48 seconds
TestRunnerSetup               PASS      564.82 seconds
IncrementalBuild              PASS      24.17 seconds



https://github.com/bluez/bluetooth-next/pull/98

---
Regards,
Linux Bluetooth


--===============8355444245145787121==--

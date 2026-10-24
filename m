Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792865815;
	b=1WFk1nxFoXwxeQtG4Sbd69G41kW0kT2ZovUFNMfbmV2QpCyS1oRq6DsW0+P6OOWBB+N4
	 xr9pADU5FthBw/b0jDRpDbDVdmsda2HUkhVyjn63rIaEz8YFtRWsaZlW+HnF6Dspp6tqX
	 SdXXc7wBAX6W8+bZPPIWi/5PJZW8/RmGeRktM8866x3Y6G6LgMF09aJxTxiEY0Qr6VL4j
	 4B9BoyjzWUsX2/NQLEYiuvSGTClM6tFgL0DIOT9TvTpURwDPiSma+M0tgblv1KVPWLnEm
	 TGbZSX9kgNYIev1xojtVq2yA/k76fqtll4cFIdle8Mr/W1bf2wsuHg09gMU4kHkogYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792865815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=XBfZPbfrv562dyTOOgUG8sst/CG/pJbiko2ije/H+oE=;
	b=iY0Uxn1FyC/HAmfTEmCuM7Lk/k9c7g8b70WUHuYWF+C2PqHnKz7HEPKmJoUc6oRI2hKE
	 M+BqUw9cRYIDTBzE3tDH28dtInxts9WiFyE6UpsNaLG5P+9VXhzUGmuaXNc0pAAiz2rCn
	 llIJqjA7JRQrt8bsHAv1bbkBbVSYTHp3Ylpw4wP71p6YZggwi6wcUHDMJ16XWor1gAmlp
	 zXWn7YODu+QoH2ONTiB2JbU8qH1mzaJrfEtnb26QsL4BLtMpnTnqH/b0DOXSAxeG8PoUa
	 +NR3e8l/6b+OmEzqjZ89o6lk6neH69qrRRuhBM3LETqQNfeAvikbPRUejL5EoGBXwwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=idGMoinZ;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FA606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 18:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 467FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=idGMoinZ
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1319648a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792865814; x=1793470614; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XBfZPbfrv562dyTOOgUG8sst/CG/pJbiko2ije/H+oE=;
        b=idGMoinZ0LFV8oF7DpB9umv+QPRYvp9fUXvyMB5JbbDHbH+GHj9nYU0V1R3EYG4ZQf
         UP3ADmyNuDZtEwfgnuzi3f7kKoOB0T03eqp2foGHDr/zdnA6Ao/suW9ytM5eDmFm6lSJ
         7bwEU3dJbGMZBm2p0q4zeXMiF+X4PesMN+rGcX7CIOzSTfrxRk2wJebkQFs0wPQ7TDa/
         qicZ+vizANy+HWm3JMImPYjVBmQNva65HLhC0JTqF6QZtcgXp5P05PlbTuOFLMx9NaEs
         qGD9sEuJhQzHi9kkigyytMyHPqV7qmuyIUJpM/WKH5aX84/sfS+XUdbvwbcq0oJOfLDf
         efmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792865814; x=1793470614;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XBfZPbfrv562dyTOOgUG8sst/CG/pJbiko2ije/H+oE=;
        b=SD9Gq8Fj+lH6w+fSdLnWQ2oK0cQY575bAi/d1q+DFtpK+jk8p+Qo2jfmJXnRpVTZNb
         xCrz+H94ItR1zYgMKWGOyZCijf/Yh5Q6Tr+NrOASckv4Gyglv9tm1UgXvWFo+GV+Ge4z
         NSRxSqcaIQqzVNDkhUZ27DAhSo8lJ5yXSZMaVDFmbp9DnhXpmLOrtJaPI0Y9lqNDb/Oi
         NibVquyos1TMPB/PB5ZDU8+SF2KkeRnQOTl0ivhjj5OLdOVenMgUdnZBFiLLzWTkAq5s
         EcR89+24bfea80/akl6LezRW+idnUSKY/6R8NHrnLh4+2RTIDOogmwiKhP2UoKFQmTFC
         Ns7w==
X-Gm-Message-State: AFq9FYIDdb9Oa+YH+XQC69M5ZEKE8jGdIvV29IB7Wo1HSasdSzryrELf
	f9m9o+LPjT44C+Cz/UJADoGkVs9JrRH6rTkYvtlQp3IWOznGJuGcEeX55T/MPg==
X-Gm-Gg: AYBFou3AePplbHQT2S9u+UsolqwKTr5vq6axCYqUVnK137Bq66/Zz2uDTevy5PKX02C
	4InO9XopAXBNTQrQzktJ9tvOmMCgNsTSG5/KX+QsXRrPadB+YD6acWrkgfYfUPkS5IJLIrGk23Q
	aFi/nrHic2NOu3MdU32e4uGeaPWLJsL5tgnJ4/JG066yX+WI4H/vu0frXTllp6FOcXUYqQbJLbN
	7MoZsDrpVGdTJGbZQufGwAA3UALCtx8JjxLU0Om/8ebnKP3rFD28FTMByzn/ICRnS21u8mxK8nt
	2feaZ3TcI2Yt8vSp+UFmfaKs+aGa2qOivL1lyEI9jKWyB+HAKZrZYYE4mivRKI848nMW+qishu+
	K5nRk25sv7D9Ph1Pz5dV3xyi4/w94iMZPTmCsiXqW81TtV33l02ERl9h70ynEKrLJE3yXkpQP19
	YYG7S9orlhVfK3Drmpg3mkbnx186VRaV5nGeQ2M88GYa0+Ge6aGObnKvltu/CXX/+DVdd75lJaH
	FxWwdNTuR5+rJEheL5iQL+fMYESv0mYLnPTq8+9cibA7UnmEKkWl7vQaSmpJNk=
X-Received: by 2002:a17:90a:4485:b0:3ac:97e3:7389 with SMTP id 98e67ed59e1d1-3adeafd6493mr1740084a91.44.1792865814478;
        Sat, 24 Oct 2026 11:16:54 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.135.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb06c57sm2120648a91.3.2026.10.24.11.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:16:53 -0700 (PDT)
Message-ID: <6adcf615.cd90718a.327a82.c6be@mx.google.com>
Date: Sat, 24 Oct 2026 11:16:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3766503513651045067=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: vhci: Serialize packet reception with device creation
In-Reply-To: <pm-bluetooth-objects-candidate-0253-v6-ffe55995e8c517fb1d86@gmail.com>
References: <pm-bluetooth-objects-candidate-0253-v6-ffe55995e8c517fb1d86@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3766503513651045067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192697/

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.17 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      17.03 seconds
CheckAllWarning               PASS      19.85 seconds
CheckSparse                   PASS      21.79 seconds
BuildKernel32                 PASS      17.60 seconds
CheckKernelLLVM               PASS      19.00 seconds
TestRunnerSetup               PASS      396.32 seconds
TestRunner_l2cap-tester       PASS      12.86 seconds
TestRunner_iso-tester         PASS      8.78 seconds
TestRunner_bnep-tester        PASS      2.86 seconds
TestRunner_mgmt-tester        PASS      80.49 seconds
TestRunner_rfcomm-tester      PASS      3.90 seconds
TestRunner_sco-tester         PASS      5.57 seconds
TestRunner_ioctl-tester       PASS      4.01 seconds
TestRunner_mesh-tester        PASS      13.82 seconds
TestRunner_smp-tester         PASS      3.83 seconds
TestRunner_userchan-tester    PASS      2.72 seconds
TestRunner_6lowpan-tester     PASS      3.87 seconds
IncrementalBuild              PASS      16.96 seconds



https://github.com/bluez/bluetooth-next/pull/998

---
Regards,
Linux Bluetooth


--===============3766503513651045067==--

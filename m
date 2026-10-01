Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB9524AF1
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867906; cv=none; b=DhZuhDWS+h4tmJWT64yhq3UfE5HqsLVEGDCwf43W4BlNbUcdKiZ3tXjOQgywIfXf1qdMnFb1PPr411OJw6rCnJyyh6ZNN7+pS95Fi09+FQENG419uHlWqADgzspfvHgq2nckx+U95hPhE7HFH5D7jtHxXEqeP9Ly6sYQo6n5HAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867906; c=relaxed/simple;
	bh=oWp7g4uXO56K2o1WVAO6Vc2GRpPhRJfrutlrkY/iy5Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AdsJpz5T4mTHk3scO/kg4HWwfrOjlkMxo8lfmZLaEhPJb9KU0ThXogwhItVAc1IDY6cqZFJem8KEeyxicAnJg3xx4L1Xd7Z2jE1xn6qSGFlJU9gkrHD3c52WhGNDTt/+eoJEDqDIZebd0qWjjSirf1T1z/lskWyGELEnoOLMckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBQzgaxo; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBQzgaxo"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so4327154a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790867905; x=1791472705; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DXRO3divaFKAUjFi7F/ZlwWq6Q6enXgfWytTB6MaBRE=;
        b=hBQzgaxoSNyHNmr8yTzXpYE3K+QCAR5RESghoy8alKLeomak3gyVBaYNr5JMA8a/cE
         hQrR6ybT0XBWHDTxzKCy3rePoFT9j5DH+GO9MSn1e9wghgIGX3+TEDnAUoFGvdJ4CAtW
         uxpnW2eu7B8819GR131nXUdOTm0PfbrJB8IZI1dmJF7XAomPP8HbWZWhKlG6odQ2Sf8f
         gXxcihPcn7U4rytAixujYHNlxIm431aTvi303ydX9g8GP/jncPbJF8FYBIA7tk6M+9Bg
         k7ryTtEyLCcEAwLuMLxsd+bgQC02YrINuJc0d56hmdG6W6cKaeFHDUc9D/IZaJTWrlHX
         fryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867905; x=1791472705;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DXRO3divaFKAUjFi7F/ZlwWq6Q6enXgfWytTB6MaBRE=;
        b=nLWLp8GHxdeGOGqJon0yUN8F5l6XCqrE4xgEfye99/QiZa89Ac85s4CVkTGZPnONfX
         f59PPGSVFP+bdNGtVrDEEKcVwInxbMhCD0xS/I1clSaeiOUZjw9LPD89QPGJoH72n92i
         mdWCpbeVSMphNr+lw3PIHl71/9qu+S3+qKPx6r5Anot8xNxrJPCDFCUneTpDaw17+E7L
         /ETNNN6bijTlE7BLAQumFptiIanhU3K1PVqgQ51wGOWUgbn8sY4kew9wdiAWdrtGP4yk
         zCr8UrI4YgPe4M7k9UjuCVRPIztlyYt4GtzfLrOwj0AtpP8oa8apg9lgbtqfbCCqeoN6
         RsNA==
X-Gm-Message-State: AFq9FYKg8MxKlo4qq722Yd6IdWvG1C0aXZ+EbJtM6rwAvdXD/j2ogAYp
	bMcgZHkW/CBLOFAFzWxD9rNf9ucVdmFplKG4S5DHYC03lPisye7Hi+tS/aQbxQ==
X-Gm-Gg: AYBFou2X374ScLsWKjA0f0ahy+NN/dD5OFAiDizneYoEr+zcK/8OhaB6ZFJHp8Tc8Fu
	vJUdcfaCnt2LSM5UK6Mp1GXnCkXk7cnnZuR6+LrweLpIiOD3lbSXcGssoTZ7do4jUehonoLnmcj
	yma1/fG+hH3Y1QKFCHE/A50CVim7wM/0aM+8ghwRYTYIVgSVYUq2qgdABqq/qem6WzQs1yxEV5H
	RUTWtO3e22lh0+92xf+qYAVkVXEqCI08TLfeWeOQKL7Fxsnt1nG44xIRVsXuKOXMfA8t1jmIUu/
	lj3N86yeuYB9xwbB9FZHhlle+H09AFvWPengyC8WZL/0R7CpFwyO5kGR+sAhjkHAvt4EtiHpQ+q
	mPWxntVJB0D6fxl+EGeRKV8odz+OORVM0o9lWAKdayhKbOYSFZzNXKrOr+0wDmSFUjY+IyEW0R/
	npiuUMBmEtiz3o0fSqpnQ9UaoeILlxbIE/mwqa1u8WhU6ZYAsVcxJSpEi8Elo9UyhAOk+5Q+2if
	71C
X-Received: by 2002:a17:90a:c88d:b0:3a0:b223:6830 with SMTP id 98e67ed59e1d1-3a4d11dcc13mr3445589a91.7.1790867904771;
        Thu, 01 Oct 2026 08:18:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.189.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd44c2b2sm53093a91.5.2026.10.01.08.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:18:24 -0700 (PDT)
Message-ID: <6abe79c0.4320b83a.163a7e.be58@mx.google.com>
Date: Thu, 01 Oct 2026 08:18:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7054355436336000833=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwertyuiopyyy@gmail.com
Subject: RE: [v3] Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks
In-Reply-To: <20261001113513.1612-1-qwertyuiopyyy@gmail.com>
References: <20261001113513.1612-1-qwertyuiopyyy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7054355436336000833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1177604/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.72 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      17.52 seconds
CheckAllWarning               PASS      19.85 seconds
CheckSparse                   PASS      21.63 seconds
BuildKernel32                 PASS      17.41 seconds
CheckKernelLLVM               PASS      20.29 seconds
TestRunnerSetup               PASS      417.15 seconds
IncrementalBuild              PASS      16.30 seconds



https://github.com/bluez/bluetooth-next/pull/847

---
Regards,
Linux Bluetooth


--===============7054355436336000833==--

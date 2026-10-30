Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393248;
	b=teyhL2KmKayyV4klnTZ1zxeCCcVhTNKu8ZWtNSdtMmcQWtq2afq+xtsAHqzlEseWH7v3
	 V65kETbQNqgPFbmH2BxzklxgtbMA3ksnOhkCdtoA6y70VT4YwPWviQKQ8asOT0CHQSabX
	 Xc4Dl7/h6G5Bg468Lllro60+qn8OaMw4sOMd96VYqQlGo3e4JQtKqJ0plnxzAuid9OjJl
	 IIPDCbJO23cxA9QKzhoFjxd0dVtF02QzoHswxEkNCI13kpYN3fGdOkGuvnebVTiziLvR+
	 2t47aHwRPVlpYWezK8WC5p6s//6Y70YB5tkZpDc0O1HUnMC/uplKdhL5q84R/V8B02g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=sZ31TMlSzM0pO3gXdZBp2KnGxhrfaavTOhm11+MNQiY=;
	b=2INxyqFnTYxcLYi2zUMFBfA3hpsoe4hKdUsEK0tt855P2HV0hYM4TT73qF4pMFdZF+A0
	 GxrHMIDzHivYTChgWPZpSVEU87Fl3PFL1JvdZHPGlQjCaz334v8u2zAddpGKQTrNlVBIS
	 q/H7Gbw0f0YpRQJswDWKPKrHaP+hH7ozEZVWLz90xl6LYH9ULuK6zWM9bOYZfD0QOVE2o
	 j1Wp0KkAGhM5DhFw+7ZXwhaFSoipptOG+B0FOWhFbKNbvZ3IPDg35Q8TuS+dCYGg4UodO
	 KNdLWRBgTmqBmGAiK/CzzvYoT3PplJ25Bxl10x4+3PGjGDJu7FCLuJbq78iSfVD5z3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdTZdIOq;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96D606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 20:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D96D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdTZdIOq
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-535179e995bso12291871cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793393247; x=1793998047; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sZ31TMlSzM0pO3gXdZBp2KnGxhrfaavTOhm11+MNQiY=;
        b=xdTZdIOqt2aApXA5JxffVRpAXRUjEZHeAYA/bOZjwVJASrxQ5c0+nSAaY9wz9HFREy
         l7Ihx4BeUH2cSfqSAjpY5bjZCenPq4fnKUYH7fS6XF3HjCOyzwo72Dzieb7Gg9b4nQTR
         +fPg/fNRjKf3sUnwdJWn5SCzQ6BW6rVBYRmzJRRvxAjgPnjvZtKdzBRcBXn0K/nn0sSL
         FsxkyxjI4wp4R9LyzBQacEcrpR1eyB2ksOIi2JoHtB1+tx1BD63RrpmVRz/FTiczPgMO
         5DDNkg2kPl1JZtooiSLw0XSQQ6rJR+Q/A54fRnplIB+jy4STxaKFbcNwGJ8tUw7JyVTx
         IIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793393247; x=1793998047;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sZ31TMlSzM0pO3gXdZBp2KnGxhrfaavTOhm11+MNQiY=;
        b=msuBMw/DJEJO7TuVnPWbyzLjp6TAc/C2sqCqhPDWEIHcXTOZFw87WHP3f+rU7yMHEO
         Id0nrE1NdKhRlQ/TFk6H6yBNiwQa8ma6Q6I0MD6C2iskFyKoxXZi8JfMTLZdHLA1U2Z3
         frM00ipCmsF8GEGdSORTGtcQzVdfZRFuCniOgzqTeVypyxpAh4YuAI0YfsIWC65jxMA2
         zhzq2rOXPsEeM9nW76jzcGGOtPaxBUGUAvQgI8Ju91dZk05S7TJpRi+Gm6E4yJCvelpw
         +axz8D8z09O/nvyGwwlQuKwUEf+BqLs7L5cUYkQAt9MD7kIoZLslwNNwc88pQX3iNnRo
         rzFA==
X-Gm-Message-State: AFq9FYJqK+Q/r5wzSkg1DOM6qsaEOcKrL2zLo7/Z6mJb15EsZgCOAo+q
	M+Km165NgMeTGmZOp5huSQiMIugtbjz6Z4rVNqSM6jf7S1ZiNJ4HnpepQ++UtQ==
X-Gm-Gg: AYBFou2WPoLB7VOrLliILp9jvGMM5yO97cjCpx3RO4gpJjm4PXSGuKlWux107uNMZc1
	rlv90PoOQTloPSYNLgQEbtO3P5VTq6bp3+anpmQ4I6+Vui7P1Z3rDe+EJIP6R9d/NKMDPCnfC1H
	Cb51xCAXaBHI3c4/+zW2lHlpf1e3c7alVLUSThOOnD7lm4hP6OvdeIboqCC1Xg1Kijm2LF6btAH
	9nXvU+S79PJlvDtezmZsdHuxk0nrGibQH4IZut/CvPab7KaV8b9X4c9LDNsuA5nFNrIsol8d8O+
	utIovQ57mUM25YGC1fY8zu+dIhiyS6f1rkltlpFbTgAhOqkjqxYxSimDd9L4vytm7Ai1/1wldoV
	lk8HP7UCI1cTxTxQSchwVU3AEHe7oVg3WZIu/nE0pT0vlCHsppXsbv8aojeACJg31TULap6pkF/
	U0uYZBUUjvL/f25t20hlhSdMZDDwJiBAmadQAeWyBSy/T+191t0eJU2bOx5eXWB6MJnmFoyihqe
	FxsFCpyaJGvMVqDlukLo8ycWESVuDPD3iLGh0jNL5K3M7estds5WYlo2aNghyG7alkxxYeUK+EE
	RvfK2Y/h
X-Received: by 2002:a05:622a:261b:b0:536:3d09:99a7 with SMTP id d75a77b69052e-542b7d069e7mr54591331cf.64.1793393247140;
        Fri, 30 Oct 2026 13:47:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.85.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5431246c7basm22393351cf.18.2026.10.30.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:47:26 -0700 (PDT)
Message-ID: <6ae5025e.24304cfb.14dc3f.cba0@mx.google.com>
Date: Fri, 30 Oct 2026 13:47:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7453128391323446364=="
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
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RESEND,BlueZ] test: functional: retry pairable when Busy
In-Reply-To: <45f6af417f7b09d62d76bf128c1d6d22189bb2f7.1793381304.git.pav@iki.fi>
References: <45f6af417f7b09d62d76bf128c1d6d22189bb2f7.1793381304.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7453128391323446364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197366/

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       FAIL      0.35 seconds
BuildEll                      PASS      21.55 seconds
BluezMake                     PASS      311.62 seconds
MakeCheck                     PASS      14.66 seconds
MakeDistcheck                 PASS      150.19 seconds
CheckValgrind                 PASS      250.31 seconds
CheckSmatch                   PASS      307.78 seconds
bluezmakeextell               PASS      102.69 seconds
TestFunctional                PASS      1190.80 seconds
IncrementalBuild              PASS      319.20 seconds
ScanBuild                     PASS      1193.34 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND,BlueZ] test: functional: retry pairable when Busy

22: B3 Line contains hard tab characters (\t): "[bluetoothctl]> 	SupportedUUIDs: 0000110a-0000-1000-8000-00805f9b34fb"
23: B3 Line contains hard tab characters (\t): "[bluetoothctl]> 	SupportedUUIDs: 0000110b-0000-1000-8000-00805f9b34fb"


https://github.com/bluez/bluez/pull/2739

---
Regards,
Linux Bluetooth


--===============7453128391323446364==--

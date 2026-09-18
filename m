Received: from mail-pz2-f28.google.com (mail-pz2-f28.google.com [74.125.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E493AE706
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755410; cv=none; b=Ez2NVCy+UXcrwLBvvcpnV90iI9AsWRvHZLVrVpJJj1S9SstmWEVHVhKqvBnuqSQ7coRL/Lp7hn6eX3PCWUZHVcfOolFTAU4PG5PAt7fGX1IsInVejZb6LTF5SMCgHU054v0sPcZcTezGy8jP02SF2biqz3J49WNoDlvHFAJpQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755410; c=relaxed/simple;
	bh=wjkIS0d9IKnFhpl7gw9ZuIZ8bAPBdf7dTz2PeYTlPnE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N5gBhTpXQOtC/AGolJknXJ1uWiXj3wtZbw9Mh2HgrWSzlrNAJiAhU8PDbKYiCgcDL9EMDZE9R2JhUBdhoEX3RkV208Y8weh7Nr9m+KFAtRhHVkSmrV7n1rFc2wchVLUwOl9kJXDxpCd0rjpPoiHsasrjizvcZ5gZjGhniIYTf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSjLErjZ; arc=none smtp.client-ip=74.125.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSjLErjZ"
Received: by mail-pz2-f28.google.com with SMTP id 41be03b00d2f7-cc4ab4fe290so294212a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755408; x=1790360208; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zGsdezQ/wTRelXa7BnlKr64A2tBFMB+t31WWRP7pqtA=;
        b=XSjLErjZr6LR8//v2pSUELDIW/WO1C+qaf8zVkvVM+lcMdxW0RbnLZMnviUkdcPYGl
         OW1ijlhIR0Yj+iTbINHHdgQ/LyL+1ujHEJTX15cPg/tyVMhCnq2qYg63/H6yiGnHMQjP
         xRG849BCr4cEpEkP1GV3g9I1eGWP8C6B8OnOp1EL6aTQdNn1z2bv37bH8+cgPDzEjFR/
         DDjK68oCPNyPTO6xJb7Zhs1ClQ+uVKE5+yCJvQlLY3VVXtyz51t0Lr0IlPYGh7mwBLUZ
         ejFscr8FbIG2LhtYh7QRiq/kZfo6XN0pAkK4t3sz9VmHFuTOQ8xh1ADNzPRQ7w3XnWpL
         CvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755408; x=1790360208;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zGsdezQ/wTRelXa7BnlKr64A2tBFMB+t31WWRP7pqtA=;
        b=VaSRAUCdQOx/f4R9iLLRQnPimRbXIRJZ1GBA9TS9XAOIE5BsN5c3kR/P9kpjt4p1Bo
         sQMku6G9lno0S9zrtRfNKP8w6U930AJuvNGMrQRMW4wacYFNHM8UewhjmB6xrq/myp40
         uJsocoGkIOxp1CA9+qxabCpVYP0XNYkmvy2vOd1rYjVggxjimxatPrxeXgoPw5k4Tzfe
         hyz1PEnISbe2ZYIb6wCIgBVDf8CFxUa3qIojRFzx0FPM5yF/EbFCistsTr+3O0johhhY
         YZPAE7vZlkitbuNbmJV3KIKiYPVfp0icCyUQhSOelGAgRMns9zWbtPnj67+V5lSYsb+g
         UJUA==
X-Gm-Message-State: AFuF++nEG/x59GQ1BThN8fNETzrvmCZ8rvoAKYbIVRy51u4s0SBjbe7K
	G0cGnHFXNTOygf1fz9GsIPa5JzqE70Zk0HWptB/dpxjWPc/sisi6jFzY2u2ofw==
X-Gm-Gg: AYBFou2ANuByHxyTrzDNAlSBbvs4St5MXrLKyP2tSJY6G+RJtMEe/DRqnr5pKm1pHbb
	AGXuss+LzlTikUVbI32h8Eyvffvipmd2X3sPeLrOIasuK8lD8xKk6S0EYpLfpX2HCyYNB4DBjIx
	Y94zLlVYIUf6VBvvbjPv2vNFCe/hz6qR5IOtMtiv40M9/WgZ9zXw/w+8bMz3fIP3j3p8TtFIMFB
	Tquxq0qYQsMSLgbLx475rf6ZSlsMHK78GErSAQDWSUxQre5THv3PxwD+NoxuzZJmrG96YcfQIoa
	Af3kQE3D7KSWJPiXkhTVTBLM9562ljscWe5Adc8iDHCuaRBr1yKugYr6QUygM/wbhs0vpcu+dQ/
	7s1eQBMASD5K5RP0l/SDmC31K5Q6I35S+ttk5jSIjyubWNOjeQTJ8yPE4oq1bjRiPXm2+ZTj6o+
	1SjSgnPLd1q1M/eLqdXCdd7y3eEvp4ubPMBgroDeFfJfvC8rl/ISd5gt8dPTV4eWUOhHif4nYvb
	0Ca/kILJrD31A==
X-Received: by 2002:a17:90b:2b8e:b0:39e:4c7e:bc5 with SMTP id 98e67ed59e1d1-39e5572d5a2mr4002544a91.19.1789755408203;
        Fri, 18 Sep 2026 11:16:48 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.99.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm195424a91.6.2026.09.18.11.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:16:47 -0700 (PDT)
Message-ID: <6aad800f.a234186f.20ed2b.b2ff@mx.google.com>
Date: Fri, 18 Sep 2026 11:16:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2689680096049785416=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [v1] Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID
In-Reply-To: <20260918140921.39908-1-catherine.l@intel.com>
References: <20260918140921.39908-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2689680096049785416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168730/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.20 seconds
CheckAllWarning               PASS      33.38 seconds
CheckSparse                   PASS      35.94 seconds
BuildKernel32                 PASS      28.99 seconds
CheckKernelLLVM               PASS      43.92 seconds
TestRunnerSetup               PASS      788.23 seconds
IncrementalBuild              PASS      27.30 seconds



https://github.com/bluez/bluetooth-next/pull/794

---
Regards,
Linux Bluetooth


--===============2689680096049785416==--

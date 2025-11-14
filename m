Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41ECA4E
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080092; cv=none; b=EsjxVqnTKNklpgTVFE+nNrBU7jeyhoIIdA2ZH/r0dXFGSOPJpT8sMKh/VbejBoGlvkD9GzIykxurWw/XMDgLXoaNFVY05ZDzaghb+iyIaH8WZhxr0qipMqXi+vCSPIZQKTJjug7Vi14iXrblNmN/CEbnQsy3I7AqpjI/qZc2wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080092; c=relaxed/simple;
	bh=8sSpnuJKlfMZE42YQNmdhPujFE2xLjUzHHsKW+cM9gA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AOOpPi1UDltXoE8AAE8TAVpKNIMbLxU7MUO6V7JOk41jR1eBXoawW9OP0j4YYh1N1nRGyDn6COG5OPMGoXR3YfcAv/X3AblmHpK7HtVUM3DXMSFfiWFXiO1UCvUiiz7dD88W6rF4XJrRnk3oA7QaEeuQ4J9nfJafTuD3ysMovEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZBVM+ko; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZBVM+ko"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b28f983333so151103785a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763080090; x=1763684890; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pagupT3lWiMuAs+HDtGsKaTugiM5RI4tlciuAa1wkBI=;
        b=NZBVM+ko4/5FpRB5ahVWxP34bsTwCmQetfzpOWL69S0K1X6w6pd3NDwtrJzyUon5xp
         saIxBs2fyeGBTpL13sTBE3wXcytLAJCVPSOWCo+lTPzuwshx2ld5U93JCoZkwaG/gDRS
         VXZWEbgzB2Dem+B6UTDA45cPGMa9y+6UBxdNwdUk9rrGY7G+flm1DxzWju4E42GGi7Iy
         mHRCJ1NkdCGaUfrsSKMgW7N8fX2HIGpob2EtkywcrXcNYnxt431+a6+h0b6HWbDsQMUn
         hAi6RKCSSFtcbdLOsio1aZlc+sc/DIRzbDUed7c83oRLm5i25cXCwXsFVwq4LEQnK/Zk
         2ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763080090; x=1763684890;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pagupT3lWiMuAs+HDtGsKaTugiM5RI4tlciuAa1wkBI=;
        b=rhT/DKMFpVGbRc/puKNrcvm/0ofOzU6VCdnaubwpgMO5NTMAwxsnARYp6QjWf2Vbi+
         zNzaVtNS8WI7F7dcsPhEkfjK3eIE7GyYz6fmrO2fGm4YxbJF9fA3OlZ7fJs+R8HjGRI6
         +YkVZhnpSiX13wueyTfVMys9OC4axY7QFb1rYlydS5L9J7JQ2ka4xd5cYc1UjJz8TNdY
         r3SslYU661LgjKhBEWfTgs4sWP3orz+LFRAHtt6+qiMVsbW1B6eOUjrGRuhii2wbmJoG
         WqiQ9zQ2cne3TzXSVRlAL1j4YDAKrDzo3aut9hNIjxjaBUWu1+udbcTJ2ByNfwa6qCc4
         xBpQ==
X-Gm-Message-State: AOJu0YzCnad0A4iTdC6LDg4LBErwr+U+C5+xJW/8Ct0twZ9NFd5awfno
	K5/5A3ZnYs2OyKs1M+ybmz4I9u2IwuR+UA9r2qj1omn3my2D97x2+paVImnMcQ==
X-Gm-Gg: ASbGncsr7XyQ7VlZ2JlKSMQY3anZFZUd6Bmi2usyF277WfyrJJsN/idtUnITpianaWb
	uXglz3hyGzGz8ZxNgNkVNeD2NKGxmrCdMPEwknPfYJYpEzEbYkLxopj7xfcHiJSsB4+B4l69dI2
	mSAbFDBv1tIoXIAdLCBQeksy3XZaqOiXW/U5brR4bXBDeca+n0J5WhiFsVE8QQa0WxStKAUOcNL
	psbenSrP8JRq8+W9SNCYtkjzU3RPN5D6dK9yxIbC1K/fNaNFc+ImU1TqcFcrD7lTb7ASQb/X69A
	9pPZ73mrjF4eZHFBATJ1gskDQLaFY2qj83RP2dWMvIcNoECBljpEkuBPKwVUEf5M0rMydPsf9D1
	EFgu7GZuFkSbdqQXwwBuKPQMJ4DGCFp234xx7Oec/OowqCdY7Ee+pg6xK5fsiagscazGE1a6HW7
	vZMYFlwCwHMPbJmiQL67I=
X-Google-Smtp-Source: AGHT+IHqfmMhUxKTrRju0NJbUs9Tmfh8Ec5g12WV5o/QAxObVXnsNBOkby5TXGzjCuKVlt2egBFXPw==
X-Received: by 2002:a05:620a:c51:b0:8a6:b335:b881 with SMTP id af79cd13be357-8b2c31a11efmr178091785a.45.1763080089882;
        Thu, 13 Nov 2025 16:28:09 -0800 (PST)
Received: from [172.17.0.2] ([172.177.209.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9ed4bsm233253285a.10.2025.11.13.16.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 16:28:09 -0800 (PST)
Message-ID: <69167799.050a0220.8b25a.6d9e@mx.google.com>
Date: Thu, 13 Nov 2025 16:28:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4607549676321266961=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, danielzgtg.opensource@gmail.com
Subject: RE: [BlueZ] mpris-proxy: Only be started by pipewire.service
In-Reply-To: <2488030.6sBWrkQq0l@daniel-desktop3>
References: <2488030.6sBWrkQq0l@daniel-desktop3>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4607549676321266961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023205

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      2517.27 seconds
MakeCheck                     PASS      20.67 seconds
MakeDistcheck                 PASS      185.03 seconds
CheckValgrind                 PASS      236.63 seconds
CheckSmatch                   PASS      308.75 seconds
bluezmakeextell               PASS      129.01 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      911.25 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4607549676321266961==--

Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6241A559
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363863; cv=none; b=Tb05xMtYGTDEgwpORUITBsGFA9Sdvmobnuu9MZoWsiX/6sHE2CazqQAh1jLYgh7W2gs001Axvsy5pnzVevGImD6J0ZoHl7CfaC/OXaPFqPXrOV7HVLznvRET9UQodpXDS8b2LJhXm+qiGizI7biXoSxVswKiVIHT4mdpFgxteD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363863; c=relaxed/simple;
	bh=JECB+uXY/9rPfr4YbSF8zgcAheC3ngNbb4blJASJatY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FgDQUdltY1uISF+jDFmzbjgGMRQdO1VAs5US21ufb5iFE/IokvwyqJqZ3LwbKJ2pCbukBKJAcoBrZTv1qjyVJaQL1I4yk565cgRo37AaKQSB/blHKmQZjVmg1qbMjkogHcGLv6MK3n1jNF18ZpvyCUvzq7Dpbh/4sEdV/ULlmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otHiO0YU; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otHiO0YU"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b1b1d128a0so3975eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363860; x=1788968660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gHfckSx3dpCZTxjDvxwdODYrywLzJU1sC9GK2awK9UA=;
        b=otHiO0YUSsBR9D4X0ZAgYmBKycQLxff7fZOWvwab29q97rnCCxG911ho4skZA+lDsp
         o81ZFRtVVIMMDXTE1bHNcN/eAG9uafTO+JEqVh2MS3tZ2A+3uf0wHpZlOJcUFtSiFRwg
         maWnZK6yjl9jX7/2A+qSWQ+pF4SzAkuf7cKZ7OKHMUeY+w2IuMgMD3vsNGGT4qrBn0WZ
         eUlXaTsAKw/DWAxId0yEweymJQsFii/fSD/5CzlLmm0FJgZLqDBPP+tuewlJNcDH8unF
         5Kgl0KqAK+Ingdw+kD7AIKoeJrRf+SjvvaHplvIlB30qzptIUuh1l2bkhywqjfLj653G
         ioPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363860; x=1788968660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gHfckSx3dpCZTxjDvxwdODYrywLzJU1sC9GK2awK9UA=;
        b=cq4U3TeMhp5v+6K/kjPg7it0hNjCif1D2LZpeRXG59UFFoZ50GkgLEaVd/3dkN32qV
         6LDkmMC1fpiqsdsxBEag4lTiBua7kkD04HIMWj01mFdkK/qcKB7pCBm5oXkouoET1OY8
         I9S1qOGrO8q/NGYkH/7+n3gW2+H8+y3uMnvRvKnueIZ/GGW6FeTMRSRm0IpucdCgR9SP
         DcrvcJpRCGUYo5IozB7wVeo7tzeyV0HmKIW3kCAYWG+a+EsOlleSb2HpWWWL+1fXlHyK
         R6u5vIJUAU7VOBxrUyf/1XNCWwYQRyYQf8dny82qQ/snX3nbTsOZdbBfylqqIH25bFdA
         +9fw==
X-Gm-Message-State: AFuF++lamRUozp5G/9IkXKBpx7HUmPLbFtyjXLQS8HTrjUaQ1HsE+mFR
	uN5YKXF+Kmc1dQGMjmMmqiXpnd1E5R+Gh8JnhZr7fAjkQm4UGk93or+Nrf78dA==
X-Gm-Gg: AR+sD10M+ttQVJe4y7aKsYfmJRUJk3g2Ta55hLl+JkK3PAiw2WRlBGY3PBI3M+sNVIq
	Xittsccs+zIATiyMclV1+nRVrLS83uik1s8cZpiIjjgx5gPOgTKEvM313rr6sxjXY68K++6CPnd
	oFlozoAlyPWtf2g+RJjQIMHKLJ97b/Kj0ao4Ocq/nq9L8eFmGbiZkyvJvZ/MNDhGIvgkMcxuluz
	/uk+N9rpOzjjDW2wjFrnQJBezRfGRuc0eLacEdYfmaBdq0stPasxdeJ/dytbnGWSFXBokjZLg4f
	69GBV32mIoANgQvJ1J9dsfxk95QmKdf2GXm7B3hVWVM8u1aW2kHkydic556kJPqzMRo4ChHkSnn
	Cgl5QyHI1aS19OqEqcWmSUKAuAMv//JLBAWrj5RyRRV2kUVw/9yMdkXIWiC59AZloDaYQKX+Obg
	M9po/TATbQeOdxW768NyK9JEJXL8fOX2YZai05vDdJdNGWccqofmq/G0aufnbVb61dtMwPytTMG
	q8BLQ==
X-Received: by 2002:a05:6820:217:b0:6b4:67b4:34ec with SMTP id 006d021491bc7-6b583de4ff2mr73656eaf.8.1788363859711;
        Wed, 02 Sep 2026 08:44:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.222.104])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ed2509asm2886383eaf.10.2026.09.02.08.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:44:19 -0700 (PDT)
Message-ID: <6a984453.60fb82a7.43ed2.9a89@mx.google.com>
Date: Wed, 02 Sep 2026 08:44:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8953209370953161526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [v2] Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)
In-Reply-To: <20260902190037.259487-1-catherine.l@intel.com>
References: <20260902190037.259487-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8953209370953161526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156197

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      20.50 seconds
CheckAllWarning               PASS      22.49 seconds
CheckSparse                   PASS      21.56 seconds
BuildKernel32                 PASS      19.65 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      361.39 seconds
IncrementalBuild              PASS      19.46 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/688

---
Regards,
Linux Bluetooth


--===============8953209370953161526==--

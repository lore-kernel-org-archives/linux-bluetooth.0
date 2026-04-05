Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16840DFAD
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775399090; cv=none; b=bdhAFyn0BlWcAu4qX3mO1P4GNmNHPHw6v6YSEhVhBvGNWH1gEV0axgIMvoc4bp1CWhQv0lFhpFHUsYT9wQwTvrA8g7CVVx9BN9cTyWVMxIPYrpHQigKyKyC0vuqtuMbtsAstPscBExdjTToENc0gD9P00RCryYSsMzjTsN/RGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775399090; c=relaxed/simple;
	bh=jcnPnHc8r6gsYn9SPmQFaQ7tGmqdv51eUd262CFJc3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OlsVQVDGaV9N9291RAT0Xv/VDipGNABKuL4J6kGH0jN6yqC34LZyBTk53uQVLmUPOyzOqyQWYRYOoOm9pEs5o/V8i/m0NsobBnBt8WtNdaM/NU0UWV3I/d8BoejWBenoTpvb7EKI371G6/7AdvrzLd8VCra0saCkdApAAHQ6b+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzwjNw4h; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzwjNw4h"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a049a767c3so47067606d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Apr 2026 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775399088; x=1776003888; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j7vYjCTVzhjEA2NKEyzbbyy1jJty7hcTJXKHEAOL27g=;
        b=qzwjNw4hJjPOkUBjR+taDDG75x2PO2elBjxtnoNqquwLtFrHyrGF/Ren1HdlTcAB2+
         aioYpXo4YyglLIFS2eGZjsxqzK8UCjN5sXS3n/Hn/L5J6O+3003KQ3b7NdyUWab1t1lm
         wiQjFmEsgyf3NUQDxOW1rEfz1apB+aAlpUKbP3Q5S2kTwFZT6hGr+ei1mizO0b+gKgif
         mRztGqppgj/SEE8GVISVQiIPtr/E1shxMl53mLYILHjkBwUZR2xw6t19R4VUoxhZ72LF
         zCx9GzD3VxOsj8PZa5f/85QhfiJpW+cGiAQT/4NS+a2kBMc1iH/dc78YCfx9qCEw6ps3
         P8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775399088; x=1776003888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7vYjCTVzhjEA2NKEyzbbyy1jJty7hcTJXKHEAOL27g=;
        b=MWxJ2VkUx0mkH5eyPJZ35uuU7tqp1nl7K6gO7/PyPVW6LkvlClkZ3gfbaEtksWQCws
         spkuH3h4ENW82umyRTtYA0EagLblCNcA9iYB2BIDNO3B2Xn9BEH7ow4WvYa2CldbWxmR
         M73lhnG21FLPPGDHwibN3PvXVZcjNlr49wHDK8qXToCHpmbF7TiPhkCkdjxz3UUfyqkB
         okpmfCO4FVar4USWWxCpd7zvorhaxCo8CZ3SMWglju9OL73rQ0O7Xz17sivxLRm14xPE
         3JEasKRlIbYrSSqSEow7HkAJIWYCt6XR+AJdj9cHAZHjynd41W1wXLAHQXn4zQUTM5HG
         OGjQ==
X-Gm-Message-State: AOJu0Yx9f6cRfknwyZ4RDyruOqFCdKW1Xao1Ob6Yvon1dYC5cwr8ztPT
	DBaz0INKqKlYgN+ReVP7GWdddc1JSt33NMx8hU1q3xlhm9B1KhdEiPwZtOJHGA==
X-Gm-Gg: AeBDietPwfEfgKi7eUU3uaSr/4a4vC3e+jYt0GambR9hQtWXBYaSD/fCQLppz4MHx8C
	oCrTX7k/i0lUjAquGZCnxVoA3+AZNn7YMt1qvV8Uw2Sc2BvJpe7AB5T/cHFaLD68wlXvFMniNdA
	xycyX9feWkFKk0gqBYtxViPbs4FOOViVqTk3KHJVUHPqjbd2mSKT0g2NbgXru3B8Ehz4879lhav
	uqqX2wAUDY8bDoX83Im8EqM2/E8fVCeAgK5HG9CuPYj2zzsJMb+TtlPIvNVYrivbFMGMuBJL5G6
	rAIHQ/phbRw48gIVfMQlBjKIY22IN87Dvkh9sVtflfeKkILvp6z597um7kF5z/GQCiNwvo4v1Yg
	kc2a3ufRTYq4frtTaxVdT9rZuwPP4db+RdwrwwdcQat3m7iuP72dgiiRKYFINkEa4VMTojP9V8G
	yneP40a3KTSwO83lpXrqJBehAjW6Xzr+M=
X-Received: by 2002:a05:6214:4883:b0:89f:65be:998a with SMTP id 6a1803df08f44-8a5e6ccdf6emr204042686d6.0.1775399088127;
        Sun, 05 Apr 2026 07:24:48 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5977e00b4sm95373146d6.47.2026.04.05.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 07:24:47 -0700 (PDT)
Message-ID: <69d270af.0c0a0220.298925.eb24@mx.google.com>
Date: Sun, 05 Apr 2026 07:24:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8205780122528461506=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Functional/integration testing
In-Reply-To: <8b539120d408fbc137ded20cea06e179c1928430.1775392680.git.pav@iki.fi>
References: <8b539120d408fbc137ded20cea06e179c1928430.1775392680.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8205780122528461506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077422

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      645.77 seconds
MakeCheck                     PASS      18.81 seconds
MakeDistcheck                 PASS      250.22 seconds
CheckValgrind                 PASS      295.75 seconds
CheckSmatch                   WARNING   352.15 seconds
bluezmakeextell               PASS      183.02 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1017.51 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:478:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2016/checks

---
Regards,
Linux Bluetooth


--===============8205780122528461506==--

Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF783D6CB2
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367951; cv=none; b=HewOvvRLDRakM7Thho6sSbbsLy6k4XNrPQu/aFoDHaTaCbiqIRBiiBhJeD29OOF8MRvoN8i0DCChTnE5sEjGvmBTnjz4iX3v7NToKtvox72QLrImod0Ni21RABKwotQqSgrl0gkFOwNun1+UFkTyZuu+Wnyec8mnwDzYrZmr+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367951; c=relaxed/simple;
	bh=y5bhk2SUfklkJ8I5ZB24EvdjGPDeRCz1bYOmxRGyeYE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lKY0wzu8bWyFITEVTOjPMYOIal7cDGizeiTfGL6+mbX6E52hpBtvQhnMYo7VJCu7yjm0m/K2llCTLfhNkOaXAtq34Ice380YY8MZmXbGroUFWxoheQVMMbYeMF5w5y4H9IecMBVrCRF+nAI6gZIniHui+/ZPmMK/yNoy1L/iwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHen0SOc; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHen0SOc"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3025d725a05so14928522eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367950; x=1779972750; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aPofgrR0G7UcuV+ZB47+5nRJXJNNgoO0Oi5KaXuSql8=;
        b=sHen0SOc60Rrh5YcN4EH4ZCWItpz+WX4VdKFkNiH/s+i342JQWajVNjb2dg7RPHdNw
         wS3HfUf72HqFfBYCONjsEK354XpgMWqAjeDtVwtpB56lmrKyqpbgco3OKP/0TmFPCeND
         zzbR+q9u0g8MGna5EUPxTwNZoRmq6AZrrkyn23e3bcOIZYmxzeQF3nE/rWsWg7r/AzMf
         zRJ+1x30ebLhtr5PLyPBJ8ukN28cXG9jp/Ryyfkr/VRpHMNxKYT4jpPksMojXxXSz0IG
         IZ5JYf0MXAmbQAzkyT32ZFN95l4CvOwZa6NGqp3o8T4tC1rD0ez6WgE0D17njdKoiLm8
         /Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367950; x=1779972750;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPofgrR0G7UcuV+ZB47+5nRJXJNNgoO0Oi5KaXuSql8=;
        b=eyvtcDwopD2e1ZnY7x/IoKNDHERJDt2cD9FWXr/A7iA+utIDzRFH3TGDVE2EoWF50T
         GI6Rpp51NaEG3IBB0EI6QM+TV3W2DTs7pn+eUvLysNQjbSqb0ZbC37a86XGUe2p8MIyf
         ROz+XOK8Ir2fBqj8gHf58n49xfcbHOKupKZ4549OrOQzSSV3bvcdklgsn7K83f8alUG4
         6ujOtaEKIZJStuWNlqe9ypvIdtkKRWGRAr9mm8BM6IQeHiWqwuco+kya0YESIL5SENTw
         2DDtjXiOdjRRZcEADkVDjrJmMvs+Ezmo0UA02Q0R3cRLR6Y6IS93uChDVKWzChkgs1k9
         /AFQ==
X-Gm-Message-State: AOJu0YzwIAU4vXIp/L40FMKobwdINPVVLNvZ+2fdX2/xFzIVWi1Eku8e
	LzF2N66aGnte7+AMW9cFkp/AnaVWjfUHWiOIwRJg2jIIRPE2yU0MhgCVwbn8ZQ==
X-Gm-Gg: Acq92OHLiKrlogXQyMaxOfzxW82byyRH89zjlwa09T003Ay0/1eapQYcIVhkSc3e18O
	CtTyV9/uuoR/DfrN6fFztzO4UH0fQk/KWTI/n7+Sea5wR6aSTGTUOCtUXxadWXAA94Nxcgiyf98
	pGzl2ScsIDSHfebAQ5G71T4XFj7xFksy3WimEduE4Oju34Z2VBzhHJ32wPSJA2xuzYTUWuatLCm
	iVdUdo5UvGl7DsZSxykdledp+g7pyKcssvAfLkwBJgZ1e5JBPEmWUNctlb2jKKu3gKD20hZagVu
	vEyqtexb7Yemd8eCQnsEKnBXINyckcWXN80vv+Uz75dcogYhCdEUf9K5EiOKwp7F7gRJUd+PCRz
	TAzNsiIJZv+iGZ5soWGILPZcE1OV8guJinmzI1OKKaGWIhHC7C2wDDndkcAu/RH4OJb9+vC0ckO
	PfXtF+q5IaFwojS4RFeC26xie/hyVk0A==
X-Received: by 2002:a05:7300:a145:b0:2ee:ade0:e0bf with SMTP id 5a478bee46e88-3042f992944mr1650471eec.30.1779367949806;
        Thu, 21 May 2026 05:52:29 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30442e55881sm505265eec.0.2026.05.21.05.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:52:29 -0700 (PDT)
Message-ID: <6a0f000d.ceb20410.370c8.35b2@mx.google.com>
Date: Thu, 21 May 2026 05:52:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0838381516188529115=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v4] shared/rap: Add client ranging registration and notification parsing
In-Reply-To: <20260521111550.2508891-1-prathm@qti.qualcomm.com>
References: <20260521111550.2508891-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0838381516188529115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098678

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      20.27 seconds
BluezMake                     PASS      660.63 seconds
MakeCheck                     PASS      0.93 seconds
MakeDistcheck                 FAIL      235.21 seconds
CheckValgrind                 PASS      221.51 seconds
CheckSmatch                   PASS      347.96 seconds
bluezmakeextell               PASS      181.11 seconds
IncrementalBuild              PASS      650.01 seconds
ScanBuild                     PASS      1020.17 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[4]: *** [Makefile:10239: test-suite.log] Error 1
make[3]: *** [Makefile:10347: check-TESTS] Error 2
make[2]: *** [Makefile:10818: check-am] Error 2
make[1]: *** [Makefile:10820: check] Error 2
make: *** [Makefile:10741: distcheck] Error 1


https://github.com/bluez/bluez/pull/2143

---
Regards,
Linux Bluetooth


--===============0838381516188529115==--

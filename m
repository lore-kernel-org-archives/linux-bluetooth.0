Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C136BCF2
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318069; cv=none; b=sah7uONaX1Wkiql/1JOD/DoGE5+g56rOXNAXCi0qXQecLNA+A3oReRsvDKgvoMM5si+CY/GNvSehWRwHDiOltMIVUe00uuf8/t9t1Ri/AYF/KyVWX18sNwKl2QEZ00kK145dU1DTFeoHtGrcidCis0XwHb87qQ2Am7y9Li0deAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318069; c=relaxed/simple;
	bh=pcNii0RxU0o2kxOk7zclHUfMUpxGiX/xquNmW9dBTSM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RA9wsCFHj+fRuAYK10w3XRSdW2UCqsdXqNafPNYP84HSOmuxW4rJyhWp54sdn6WsgGeoN+h4dpO3dPDv5cLkDTLoc/i3I5CXwVmQrhBBtPV1MY2beo6Tii8zy9m6rgrqYDKEpztD1mT5KfZEbtnCGqKDo3DJrJ9sTTtRnYp41rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUGpB+DV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUGpB+DV"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8cce87d7995so39493686d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780318067; x=1780922867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F5ruUh45pUsIj68G2S2jyvjHr6MvlDHrlxFPzdWlD3s=;
        b=VUGpB+DVlJC2u5XRvT4t18jme/ZTytuQk+zX1ZfWYh7by44vkjMqoziuxCI1Rze3n0
         RJO6yNHtMryx509hDpjMhMiSBv/3fTccH+9k2tgfcpbtYM7OexL/Hm6SheeK6eapYo3N
         wcVwMKWB3LCrehro4Q/WseeqXVh/361oJssx9iVnv4I1HuWdeAnwVxBu2hsPGjDKE8uU
         aArUYS32WdkHKlGrisVtmw9ELDQEG/vfqaNkVkRgh4SrgOz92XoydDMA9jUwCobxqIxY
         VX5TsS6sUqGHU5j6MhPgbGO0DJlguT3NgjVb2EBLt78irnLOyVJ4WQX4xHcv0sjKO180
         V3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318067; x=1780922867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5ruUh45pUsIj68G2S2jyvjHr6MvlDHrlxFPzdWlD3s=;
        b=sOluaJ+4G4s7DKO37eElI2yuNTg3CKVZqTBrpXLkW7g+hcOYrHRJlaYm2uJMgPOtsx
         HxEGEgCVguTYUOKYSNAou1f3keoSEPACXWG31dcbAoRoeetsPdryNa7hoK5SZPfvQn1w
         EIVSCjhwhtX+TEk2AWVazLXMoOJffYppOEW+4XQpdzsY762jV24aaHEioOBtK3qc0gJJ
         xYOVj8d0YvERnKTMUQZ7GPeuTic5h7R3qwjwu7rh9IIQOJwkFX3Dv1aWcsmLGJa+uXve
         rSzotlE230oUuw6HIhjWl6C8tLMZuwYPYFgK6JamX2LGKXxul2/4e0CEb1t9yF2/5LU6
         zt6A==
X-Gm-Message-State: AOJu0Yz8arixzWUY58y1pHVoZ3x4rmnITfXpicjoXQBffCwUbiHq8yBt
	AIF7GwVGk4DE+AbUIddLlhUBg0LPRdstBMlDvjuv7p8OkWo6MmE1ovS05mNS9A==
X-Gm-Gg: Acq92OFUnnbSoT2ZH6t2d5qgBCkM4+ojz8tKhxf2Q6bnsYdKxVeflGtJx6tG5rj1dSr
	MlJYyHk/RBF3STe2yvUch3fX7AFRVreGMjbYKGMUEPFumzPpdxYXoTatncCdFM4l++YSO0LX0D6
	WO+Gf7aThIt4GUd5qDEcEnUB8bmdVwIo453ebUnps+epUopi9oZRHUS0HcyhLB/WeMLGfmbcIiE
	Ld7kf+WCmsammBdyScxkzjTjzzsaui80Vsu699QVScw+WRWZ2KaRA+nmSR88CT/bq6jXcMOgwUX
	Snoqio95uqvwQhGZuvb4alV0/7C9aXYEFC8+fxYHTjE0bUSXcEVHk6YPl4x6JwM5lhjXEeJYddy
	3O3DbzQGS1oWhe7JkWDar6nzlQlQe3Y5rbTflpksZghZnpiBnPAQwolPQ0ycM698TRHunuUwUMv
	7968qDP6dnzVWRbYRjYPbm9hz+YBgij1dUIjvKOPo/u6wW+ZvpSHB4
X-Received: by 2002:ad4:5b87:0:b0:8cc:3546:262b with SMTP id 6a1803df08f44-8ccefd84a0emr188024796d6.24.1780318067438;
        Mon, 01 Jun 2026 05:47:47 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.105])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0635b1sm93342156d6.11.2026.06.01.05.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:47:47 -0700 (PDT)
Message-ID: <6a1d7f73.e5732488.2e9adc.66ea@mx.google.com>
Date: Mon, 01 Jun 2026 05:47:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6871107723186783749=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Fix null pointer dereference in remove
In-Reply-To: <20260601102612.2164388-1-chandrashekar.devegowda@intel.com>
References: <20260601102612.2164388-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6871107723186783749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103946

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.41 seconds
CheckAllWarning               PASS      28.96 seconds
CheckSparse                   PASS      27.71 seconds
BuildKernel32                 PASS      25.65 seconds
TestRunnerSetup               PASS      568.66 seconds
IncrementalBuild              PASS      24.69 seconds



https://github.com/bluez/bluetooth-next/pull/264

---
Regards,
Linux Bluetooth


--===============6871107723186783749==--

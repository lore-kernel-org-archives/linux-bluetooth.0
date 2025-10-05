Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD6136E37
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Oct 2025 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759707739; cv=none; b=EoCqq/mgJbk58DH86Uz4wZz3eVFeSwRWgLHUXKI5fwXlwNCztbkqmbjVfYrOiM3aagz16VuvJgdsdsl5jtgXTiV3ek1sVLvnzDrmajpvjqV2JBk5M0/WioQwnLvXD+Rk+VHrJkqFfdTEgJFL+7ZFsuMVq7JEi7VXbJSC4fXSe/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759707739; c=relaxed/simple;
	bh=doO36rJEjJABqCORGy969ruwlkQKo+DTO5+Vr4T/D8E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LHIITTJl+v0x9bJvCVypw0aOQKpjTIIXVdefOGukyrCQ3/4XUy7CU3+cmPjBk7Igwjr/u33jB7Yf0ojOWQYbOhMKJLJxjSe6AfRfYTTHyGxd7nsYeVAJbe0RXGtd3LC9Za+i/W91gC+ZkphuPato+WkcYuOnCKodVZopS1CKO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N806aeV6; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N806aeV6"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9399ddb3ffeso318081239f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Oct 2025 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759707737; x=1760312537; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VJfNaeQs+FUd86E+45X0HA8+sETTwrvF0iM7POi64m0=;
        b=N806aeV64QeLQh8hnae6s8ezIH7J10/riAdVnz5nWUrbyUylnaRFklTglSnINq6zJx
         SgIbS5SOiyMtW935UuylN3V/N38Wx09fyx6mZXBgC3a2PSBcsOptwVUbGsX47kf3y4s6
         XhRcePJZ7jMpR7D5BoBxssdvCybr6Hl6HhK/itIGFhvfVW4XTOnGzKF/ToS3ZujHc1PY
         gSjKloOvzIv04RGPMIPVYps5ufFH3w21QmQJnqIATUs14duQD5bpCfuF4uQ/wu8fw5yM
         sWTp61AAR8aV0Q59jw+RclHKdYrfXXuJyoqA+k5VB+MD/OTTbGG7K8nwBNz/OefnqGip
         DVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759707737; x=1760312537;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJfNaeQs+FUd86E+45X0HA8+sETTwrvF0iM7POi64m0=;
        b=b1883w/bIMkh0eS024FhvvRKAXLUxS2V1OwFHTf9jtt5C/52uBEpZKCk0e2ZSmVTeY
         Ll84TAzKKmWEm3KEjEcSnuAoDh2sd6ui4yFXdcmFqQA6iJgsqQDt0S6uXIGmbITOl9yE
         E908tQheBryJBBDnsoYeMPMgVtKlEOobgoV2R+p16mltcLnG4Gh3C2wv4NmsbXvwQrzA
         UNgUPl5Bh3CXzY35TqvJFseiIkCgK9cHhR6+CwC+AU9f7EME4xo87CLMYmdZsHWpcdV/
         1pL2RbVBKBzK38Q686FyIQKVcUszIkyOGq09pHGzhGXm8ZkPOi1anhBGejx1myf5N1KH
         Y2mg==
X-Gm-Message-State: AOJu0Yw7DOqD+p3pfj9AVKfcVwL/1BtssO0CDKCapwivpqRutsrubpSI
	3RTgnn0XH4CaMsDVB9okWXPwamLEKFOzNgD9HqYg3HqAmxvLccJwE3coSD1r9g==
X-Gm-Gg: ASbGncsGjLST7EHzY57d6/ihDPuB0XfDJyGSWbeANXs80AYzSRvVaRxPyi5VLKAE4r0
	zbtYFTC20vihDSe4i7toESzUCEUS6pH4Eev+pSne1jO3Lc4y7pDNeW3tqYv+zHeoIjre3FUwyOk
	YQlEMQUetE84DLa4luPPAuEvgVLuJsVR+Mug4AiwKPRiBV0UHsWHmz51UedF4coG51JOxbF1yON
	bZGsLfCnfxfmPV/76VxJBj4EXVN5U8/qxSaWitR4rd40a2qt/xhedrGYGKxWVV2WT/FFw2HPQgj
	88EC/+8q7VIO5sKQzKwNVWtdLOD5DphT1lgVMCUjlcs3+mCaYe1vao++bcrY9upvJUsiztBSLzW
	/T19vE4BIAPwiDThs+HOkfNxs9E58+KKxdFPaFirW2zuMw/xbZ8aPeQ==
X-Google-Smtp-Source: AGHT+IFI5i1BQlFBysYkJgOlpFoICHPug1NVbczv8/7a6/ZZND/nUgzC1POiZyt24VBXXYKQAgVjRw==
X-Received: by 2002:a05:6602:7418:b0:904:48f6:9d3a with SMTP id ca18e2360f4ac-93b96a736c6mr1363558139f.15.1759707736991;
        Sun, 05 Oct 2025 16:42:16 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7e3a6ab7sm414900239f.12.2025.10.05.16.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 16:42:16 -0700 (PDT)
Message-ID: <68e30258.6b0a0220.947d0.6ae5@mx.google.com>
Date: Sun, 05 Oct 2025 16:42:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0143814482708799657=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Add 6lowpan-tester
In-Reply-To: <8c38a793c1016bbf49d90b89cf4df2fc8b6419a8.1759702519.git.pav@iki.fi>
References: <8c38a793c1016bbf49d90b89cf4df2fc8b6419a8.1759702519.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0143814482708799657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1008564

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      2682.42 seconds
MakeCheck                     PASS      20.07 seconds
MakeDistcheck                 PASS      185.23 seconds
CheckValgrind                 PASS      237.40 seconds
CheckSmatch                   WARNING   308.46 seconds
bluezmakeextell               PASS      128.98 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      921.00 seconds

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
emulator/bthost.c:699:28: warning: Variable length array is used.emulator/bthost.c:700:32: warning: Variable length array is used.emulator/bthost.c:917:28: warning: Variable length array is used.emulator/bthost.c:951:28: warning: Variable length array is used.emulator/bthost.c:952:32: warning: Variable length array is used.emulator/bthost.c:699:28: warning: Variable length array is used.emulator/bthost.c:700:32: warning: Variable length array is used.emulator/bthost.c:917:28: warning: Variable length array is used.emulator/bthost.c:951:28: warning: Variable length array is used.emulator/bthost.c:952:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0143814482708799657==--

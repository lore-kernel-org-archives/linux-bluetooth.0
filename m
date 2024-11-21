Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2BC1BC068
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205598; cv=none; b=j37Zj7uqCawKoP4EUGf3X4Fps4FK+Tp8wlB1MEd5WWx8lab3M9pDEW6SA6ZIHOV8UMo/+4+gAFFa52XCObi8UthdBQNkYR9z7JW+2gkRmBXRvtN1z/a071eIGMARB7TYf0HcJVCub+0GOpJACfEMnhzz2o4Dc6D3MKOD3X3ch3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205598; c=relaxed/simple;
	bh=L9SSDtavmaLdg5ylkDQQPre8Jq5BIRrUFyQClkL0Y8s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xm+ArWXWyk16HQs6tmQo60aY2EXAWf5jwUwDXcW/rRDnPh+JnuGwajaxH3ysRSY70HLYZeIWOG6cRTI6jVWFM8EaB6aNlDEyoyGzPa4TTQBp+EhxU6eysWyuDwv4Shy1anTKJ1P3IXbJiRQk80UOdg5zJcPzrLRBzreTavSy8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNuL0Olh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNuL0Olh"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4609b968452so6844261cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732205595; x=1732810395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9PiU2KNTLsdNoEFz7L/elNDQR9XfsUggHjArrhc1lGU=;
        b=GNuL0OlhjhDGpgJC1BhvJOv5qW4IfPTvYudSvT+YMySLT55HuW/9NDVZUxgX0mCaG4
         s1WW0wpbzwbDvpO27uiF5YSUCHG9bqGnK/aWiUd+cP/OR8M52aF3JYivDXaZumWmex/o
         otw1tOPJ7XJnTbADvhnjG0kxE6TjqhkKNz4Rz/ZvUN6GrkpDqTS0bMnMF/Rv5PqKC1R4
         ShqajDmGUeOVcilxJBiyypJTh1B/xPSDX2rBdp/4E1//CQTSG+GsLsaWOa3fFPDOh7YK
         9y9gbZdHroZZQoefp/nuvd0Ln5bDgUVFxCsLbhiz456gjRFvh/GVhUUvxDNfKNJwPXgu
         cHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732205595; x=1732810395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PiU2KNTLsdNoEFz7L/elNDQR9XfsUggHjArrhc1lGU=;
        b=NpYl4DcCFCh+HZfauAsYdbZnNpWFIi1HVgcQs3u3v6sUPV3W6iJNXS8ED38RZEJR+N
         R2EzriH/5GqR4vnzwPT2VdDGxwQ+9YOCOBLHhPYqeN0tTx6tudtNxXcjqgiBbfJCExax
         Hjoaoc0QrHVo7bLFa7vqF8YER5cYKgxENKGRLej1pHLTRdcVuYonYMj9RFYGt93HDy7K
         VW0EhXheYRYqvOmJY59hLtNCoUw+TB1Dg9dG01kZNhkq/j6XW6LOH741Bs6njfGBZ5xV
         iVmNlOdHZdBpT3Y9Y4u2IvSIVmz4lTNwOFrytZnZX8PrPCgwOBsIgw73TeXo9zysUHjU
         kJLA==
X-Gm-Message-State: AOJu0YzPPQSpTD/EVcJgZ/2IdUUeZ6mg51hCGuBX7hzcJt5uc12vyLdK
	LDWrV0C/+iVfniKZ/QQKuXzV+LR3OX87Ymf9f4l7q+eRtsRXujvtHfCdcg==
X-Gm-Gg: ASbGncs5EIqVQRhoNeKNwERJxvzMaE6yq80MlnXnXc8bqD5aCp0ncb03YMcNr8Hvhus
	MZ25Fau5s5npQ34Xg/thiaHHxpZ7vfeQmszkh5jQvuxkJmk0+lHcNl2aj5Rp2FEjCVwGenjnA62
	uoGeMRWHrwjgGSjtN1PxBwkeJGZBhYBsDTHX+O55soeOQHV+vkfgYDKE9unpL1KC2miDhbmBmzN
	0P3sngINV3D5w+Na5DaZT/ATQ0wpcxgcDKq6yqiyVp7ZUTWt6/GBHw1ng==
X-Google-Smtp-Source: AGHT+IERh8EsKLoMFSNU3Pb/bUxG/j8ATrZpPj4IdzhKKmL9Jrn5O3c7gvXUSi/MwfkJNRJndTARJA==
X-Received: by 2002:a05:622a:2292:b0:462:afbd:673a with SMTP id d75a77b69052e-4647a8df19amr78332621cf.45.1732205595273;
        Thu, 21 Nov 2024 08:13:15 -0800 (PST)
Received: from [172.17.0.2] ([172.183.51.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3ee14dsm158061cf.24.2024.11.21.08.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:13:14 -0800 (PST)
Message-ID: <673f5c1a.050a0220.a17f3.0210@mx.google.com>
Date: Thu, 21 Nov 2024 08:13:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7106637913411566434=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: client/player: Rework transport select for encrypted streams
In-Reply-To: <20241121144708.79707-2-iulia.tanasescu@nxp.com>
References: <20241121144708.79707-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7106637913411566434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911536

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      1610.31 seconds
MakeCheck                     PASS      13.33 seconds
MakeDistcheck                 PASS      161.53 seconds
CheckValgrind                 PASS      217.17 seconds
CheckSmatch                   PASS      275.64 seconds
bluezmakeextell               PASS      100.14 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      855.57 seconds

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


--===============7106637913411566434==--

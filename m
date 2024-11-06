Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF820896C
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918742; cv=none; b=mcyDFTc5LT4BYM8iVorPw54flpXR2F/SYzRHqFSVatdHKOvoLIi/ANC9GNTRZBkE2UhVipMv/my7qiEv5+npzlYHuUzX4yjYY46J13IBdB2fv+drOXufTp9/shwutUZ4OB13Xwi2xdLnQ7opT3kUKBPKiMjGIXewbt0OgOiuN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918742; c=relaxed/simple;
	bh=Gh0VKkwnjMd8tlBba97Z+81nBIOTlPzQZDD7l3vsGL8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PkTS64UBAQu8ghcnMbuotfDR9wlTFwCMDN+18AYHNTjn6vOAEqzg0IaTiEWI22Yym6ufTzLQlVzefnuSObFrWdDVx8NsfTfq1FGVWX4lkD7Nq3NiVJYrI5jXwLUAqK6mnOTbnCUcZbWQytzxq3SN9EdJBdyiZ9qz21gz9CKaekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2pg8zP5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2pg8zP5"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460c0f9c13eso1805581cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2024 10:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918739; x=1731523539; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vcI2XFtbQomUGd5nd7uzK20uPsGyF5sMLByNtEQ3wTA=;
        b=X2pg8zP56UNDkBqKrBRljljnEV46EjCSSBJV1+qfF+cOMfDHjdifYeZfsp43zyU0fZ
         AJ+r8NBdzrKzfXmcX6qdzBs88zqes/OabQUH65IPuxTutMMBGfIj57DCPBPyZMjLQwmq
         NSL0LW0xvoIH/1fJqOBM+4bqq1nHXM1xpVwbAJOIl66hs/8oHl/LOtXiRzFBCgvdi4FS
         dkpIFDdUnHrv4vkxLCc6ylZhALG7vYw47EDBgopGq02HeWFIaUu8rxuowT9CM4C6OwT5
         oQ5E7gJfTdH6RTVcm3tcNLoiRY+a8SD/qq0gpDLliUtbJOCYXz2/F8fLI3vykB6Ddrjy
         dKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918739; x=1731523539;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcI2XFtbQomUGd5nd7uzK20uPsGyF5sMLByNtEQ3wTA=;
        b=PcwFA8um2Mc3Hb4Apx62eD47Fc331bxwNDpVLyNiw0JQmqodkYPruvRIiehFE427vy
         0zJfPOBHcNuJJlY04xCtslxfihiCBexP1+nVOnxc9uB9qPZbb2+woBJjomOlyVkjw8j9
         zTBoDFmJmIVC68TKUWPCG4lB5F+VKk/FsbSoXsWkH9fMdnan6oU+5jzXvjyaWjTUdU5U
         7wzYgpMMjQVXLImk9q+dkygU/LRIsjovbw9uxEGDcj/cLGoNpS+9quy2Vvsr60OfbEjp
         iUWjseeZeZFLnHOuvaeCOmqrZSnCFmuaMRBX8iiG0TuZ2ZsKYHPp67omv1Vy8ELwibL/
         atdw==
X-Gm-Message-State: AOJu0YzpCfHNYHKG7tlJ86LC+AfrU28tESt/jmUdFEZ16Qg3DhYL1beN
	cUdiMsqnIKtGZeQsHaH9jvHE2vEjs03iBjMDSWfR8FdftnXBi940jUpwpg==
X-Google-Smtp-Source: AGHT+IFsSrryPuhpRJ1DgutKXppdu+ZphYjbVs/rLFN8Jec+jM3sIKCdxC3PHWh4/10yq7Rt+BleSg==
X-Received: by 2002:a05:622a:13ca:b0:460:8993:cab4 with SMTP id d75a77b69052e-462fbad1a57mr4071851cf.23.1730918739444;
        Wed, 06 Nov 2024 10:45:39 -0800 (PST)
Received: from [172.17.0.2] ([20.55.14.255])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad19ae20sm75356621cf.79.2024.11.06.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:45:39 -0800 (PST)
Message-ID: <672bb953.c80a0220.311b59.b2ab@mx.google.com>
Date: Wed, 06 Nov 2024 10:45:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5975361849469414069=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] sink: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle
In-Reply-To: <20241106154917.64459-1-luiz.dentz@gmail.com>
References: <20241106154917.64459-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5975361849469414069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=907010

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       FAIL      1.21 seconds
BuildEll                      PASS      25.68 seconds
BluezMake                     PASS      1790.46 seconds
MakeCheck                     PASS      13.28 seconds
MakeDistcheck                 PASS      186.93 seconds
CheckValgrind                 PASS      258.13 seconds
CheckSmatch                   PASS      368.44 seconds
bluezmakeextell               PASS      123.71 seconds
IncrementalBuild              PASS      4795.54 seconds
ScanBuild                     WARNING   1057.78 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/3] source: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[BlueZ,v1,2/3] source: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/a2dp.c:371:8: warning: Use of memory after it is freed
                if (!cb->resume_cb)
                     ^~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5975361849469414069==--

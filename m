Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AD762EB
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081623; cv=none; b=ARU/JimItJW4J4z+C+CvPsEn/LC104BDFGAvGPTUzxvbiyX+icJl5m/hO1+iebMeACxzMqN46685vHkMpqikH/SrBVFd1llbYzjL9TULSQuRcJyX1y1gb4m7z+21n0r0XdqHTPa6iuWKWYP5mmqwtWZv+SxJS3UhAksZgFY8LAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081623; c=relaxed/simple;
	bh=OPafyjCGcgzvBd9iiUol4GP3iWId9qZn0XL+aHmxLEs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WAZ9q3WoGJfkc/8Xjb0r9/fpFDRHodYbJT+FSH3pJL6Cm8ZZapyc8nYwEGCTdLuX03vetG5TWIHuZc4MhFC7nSCugFLT5ZNernLBZFaltAvWJbzdwhzHC011OOe4WBS3HF44EDRWvaVWoJIBc5eq0G2vy440BhS5uKLDIUNTK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8ODS4Hc; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8ODS4Hc"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e1b50fea4bso103107eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726081621; x=1726686421; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TuNvsORTsSTGOqfUPzpMAguc6k9AKwVq+okLO2bumKk=;
        b=j8ODS4Hc5dzLov+XEexqEkyKQ5XfsxQT7sE4fMscTX5+wgKzIK7i1R4hYfYm6RNZBH
         imw1a4h2e89aGmcV70MHY9f+CvJRKG3lPyx3aWQXI2rTOFp4Kx3EBgtM1xqGj53yoh/H
         2/cmTu4Am2pmNQ/wAAzdCSv4Mjm/Q68E4y/ln925EPx7d1fzOwXL1IFrDg9b5/qouOEQ
         lSJtdc5hLa6RfV3IZtlbSY6sd5/kQ8STfJxpX9qwKEjM3KTF9MRFkUz6k3zzVD9LzGPv
         wzAgMOpONnR72lXZI69jSCoWXX7uBmmP5qlWDvkIO0Bthpn14twedjSMsirVXwQ1wKuf
         DFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726081621; x=1726686421;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuNvsORTsSTGOqfUPzpMAguc6k9AKwVq+okLO2bumKk=;
        b=krMT9u4v2iMZUYzWMjQ0e61/pofXWWZhfEl9iSbhxm3COqjXFGxBb0Tk2fMG7mfqzM
         TUXif/x66/d+jq55eughkzGl0ngtKOu6hvzFjCjc/2ep2q+dzui+EYQRVYRY0KSPQ9PW
         /l2vhaCGGVrMEGBL8HzC/ftAlQzl105l3UpXP8ZXfE0fUnQTFInn4DO8Fo/RWxeLPAkI
         ZYtJdLYJyFaRgKny9cDgWj+Nh4Z5kS+hFziQLlXcUJx198CYZUbVV5kj0A26Iq/f74Wy
         hgSbvSw4hf7ijtUKOKQtnRd68stSkMbE6+sKAfMZsLPMSS6CbIfevUqPu4hIIcPlfjqe
         55Jg==
X-Gm-Message-State: AOJu0YyGf1zYqGjipPR3g8Wgg6D30D8w9QLJgFDwl1dpp/i9tdBSshO4
	SIVkKRPSFgx+5iq2Cxu8qBRLqIEA1jnEbpOLCG7f849uMUttm6/IMJBBnQ==
X-Google-Smtp-Source: AGHT+IGj3+YiAGCKpDIdN2a9mf+pGlU1jIvp7yhZ/yRsPYyx2YA2Rb3GZMO+W8dP2RpZG/lpWWTVDQ==
X-Received: by 2002:a05:6870:5e13:b0:277:fb54:5a5 with SMTP id 586e51a60fabf-27c3f646ae3mr269501fac.38.1726081620698;
        Wed, 11 Sep 2024 12:07:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.55.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a0465csm452929785a.89.2024.09.11.12.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:07:00 -0700 (PDT)
Message-ID: <66e1ea54.050a0220.81df0.217e@mx.google.com>
Date: Wed, 11 Sep 2024 12:07:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6132254992155012114=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] build: Fix distcheck
In-Reply-To: <20240911172055.2862355-1-luiz.dentz@gmail.com>
References: <20240911172055.2862355-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6132254992155012114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=889450

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       FAIL      0.49 seconds
BuildEll                      PASS      24.73 seconds
BluezMake                     PASS      1771.21 seconds
MakeCheck                     PASS      13.48 seconds
MakeDistcheck                 PASS      184.43 seconds
CheckValgrind                 PASS      258.38 seconds
CheckSmatch                   PASS      362.58 seconds
bluezmakeextell               PASS      122.63 seconds
IncrementalBuild              PASS      1493.59 seconds
ScanBuild                     PASS      1050.31 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] build: Fix distcheck

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (91>80): "../../mesh/mesh-config-json.c:31:10: fatal error: mesh/missing.h: No such file or directory"


---
Regards,
Linux Bluetooth


--===============6132254992155012114==--

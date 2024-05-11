Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382F2581
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715449421; cv=none; b=Lnx3Rb9npSf9ssfNtmSquI+21t4DsOnAAzXCGN4+/rtrTjVy3dI40mCRXQAvzt+ilKjcnDOalYdbOQNbpsNQZwkS11WhQBoclJY09ToJQTjgEec8XEinAY73KJu89Ki3RH4buqs3m+jmGFXI9YQa9KizdJ2keeO/Dzb466pc/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715449421; c=relaxed/simple;
	bh=Euon2MUlNPgXj1c+xPW4dy5FO+fYgPOTvSH0ONro57c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mLFiqD48JdXvneL13IltiPYcewxiHZ/84wDiKc/zhVDCUvlvCHNUyydjUofo0UQ43LQP1Ix32hNcD8EbtVdaLLLeDJekKpb3BOJDJQRvnYbZFs9ZeIu5sg4hoCh38uecuxZAMKiwBUdYQC4HWLqcItsvmKdsgXaWZy4/WoRh0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx4TbmEv; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx4TbmEv"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso36255336d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715449419; x=1716054219; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvd8OMy3RX9HBu7dXHoeyFFyUcngyK6Z3zaxdpBSHnQ=;
        b=dx4TbmEvHWo7rOsNUbZ1uXe6phGbxwzJMmMoNE2mx7LqnR4u1hU0aJJpMCELBDoAjM
         YsODH6CltZAG/Mi7th6zplBJ+2c4p66lkxwMiWwnUFj4RoRNuWDCBzINHzm/eLXGT+sr
         +e36m81dvnSQdV7BWpJs71UmC8UcfKjPIz+LHINem35yQDoSQk9xM7/Ba6ArsqpW23HS
         U+ONEnYP0AjkDSZTeoF8aUmeuHPGdmcEn/OXVp43Vh7VIVSo0okBlvFjrGgjlMCQOVms
         uGLkLNg4TZ1I4LUJ5Nx7ZCbKUyGuMmpEE3WQXExl6UM+2aZIic+vM8+/DqKGTE8uFo+3
         5ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715449419; x=1716054219;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dvd8OMy3RX9HBu7dXHoeyFFyUcngyK6Z3zaxdpBSHnQ=;
        b=rMtKpWdCf7vbGUhN/OAIDuGa8RoaI6A7DQ/czbmAz3Cbvraj/eweuSRbvEE6kzMIJA
         Uy++b9gpQ4+LiOBsiEIpsyn3DeRByI9KPPdGNav9V8UFhpy6/uI23L9S2e0XBc0h8PJ1
         EjCsDmnK1zQkaODmzo/+jZr/4SFGkzoUpYJOMNnESo38V6iFZhpRnChJblZjqKJJygVi
         u8NtqEfwhBBWycEBFiLdktx9uR14kfbeoJQf//4qLbKB/o0itLmrmMzAzn9wD4XxuG9U
         LD21VHLBPDhbAuWPgP9+6spJvx29AWYNnhlfTicaRQ72YM+/8OzbQ/TZPlOiN1VjPcSn
         Xwpw==
X-Gm-Message-State: AOJu0YzzKg5zwfUYmbIxadezuaGRC2fbOj+8REjgUsQTyOU2qXSowtr5
	vtPVx06rdoHwoOHc/u7FpKvuKlOyl16ml4v3jU2WBiiPc3O/uHa86BoRfQ==
X-Google-Smtp-Source: AGHT+IGeyFBwvVjov8Uxu+M8+XTO5JFSsZTHtwT1PbndDa6E2xt3TuML3JydbLZIleBw7SkR5tFxTQ==
X-Received: by 2002:a05:6214:718:b0:6a0:bc4c:d8e2 with SMTP id 6a1803df08f44-6a15cb92009mr148849856d6.5.1715449419123;
        Sat, 11 May 2024 10:43:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194c93sm28030226d6.63.2024.05.11.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 10:43:38 -0700 (PDT)
Message-ID: <663fae4a.d40a0220.5e590.96ac@mx.google.com>
Date: Sat, 11 May 2024 10:43:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0302067029186182591=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] client: fix ISO send data rate
In-Reply-To: <30fd803be62f762706486698821e9e5fff2d0b63.1715442270.git.pav@iki.fi>
References: <30fd803be62f762706486698821e9e5fff2d0b63.1715442270.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0302067029186182591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852558

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       FAIL      0.48 seconds
BuildEll                      PASS      24.55 seconds
BluezMake                     PASS      1719.88 seconds
MakeCheck                     PASS      13.12 seconds
MakeDistcheck                 PASS      176.82 seconds
CheckValgrind                 PASS      251.27 seconds
CheckSmatch                   PASS      353.65 seconds
bluezmakeextell               PASS      120.99 seconds
IncrementalBuild              PASS      1503.96 seconds
ScanBuild                     PASS      1033.85 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] client: fix ISO send data rate

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
22: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============0302067029186182591==--

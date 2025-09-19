Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8446242D9B
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276181; cv=none; b=fVfdMEVlQ9i7C0to8RR0c/DKkTkmn2na2KzbtLf0ZmZYemwKSB3sQ8LyTLiB2f1saupe67pTn1WbQLeucnpidw3X93EJdxq5ww4hBN9Av3H4hrvzwysg7f97+44jpoEcGF1QtPUJk0AUyMyQWcZs629NXPEefsok/2x+ZMxfkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276181; c=relaxed/simple;
	bh=Hy5dQ42Q3JdAKeZt2E00RADrx9oFPAAZByPJ/UKaeA4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BLXMMBAsvIXAq8j++XDOk81YNhcWc6P+ybF3E0VKPAhxJgk++QixhwjwhOIczZgYtpHgt4BEl1nBUH7Yvb13Wr3Hc/YT8vlw7Nd95CQrBpqd6nbXVO7+VWLw8tNVdr5ZV2toP8H0j0NzBXFlbEB5lhu5HWr4pwNMkm/9EPCmkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU4aih+R; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU4aih+R"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7761bca481dso1736651b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758276179; x=1758880979; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l3pRS43zD00W4GdlnMNO3r4aqf6OUK+jP2tCs5Weyyw=;
        b=IU4aih+ROG62WERUwnm6K/pL0BJwaHnMi+E1z7+0GEjhbKXCG4K/CHBjwU4IJ9HVxC
         li1ku6QQfilXzm7jyP2OwsVXlTbWmKMNU3lMuLj16daNjw2xbU0ZIMn/zlGqTfV2s4MS
         Rd92JgQcAzQdDdXNRmIz2xNTYnKnDHlSWolpfATQIHXdIe0S0E61UK76fHF27joZPTwk
         hb67IcJqnwwbzslBdHPtcYPRvxxeZZ1IZqQ9a9VUNxo9NcibooP12MoT+jicloccNoii
         rBB+NLJ+jJ9pqhQZyuWsNSXV6PuNPwwsp4h1gr8Rx85rfYo4JBBGAAUFkwpH44Z2p0nR
         hUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758276179; x=1758880979;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3pRS43zD00W4GdlnMNO3r4aqf6OUK+jP2tCs5Weyyw=;
        b=UjO/FRhnFnkSl7uayOCgmNXX9DMSskcVgfKHyGkOOEdhLLLa72CR37xC8A6O4NNDcH
         Y3pL+eDsh6wlR1hSe6M/cbdJwy0ndWvxIsfeoH3eaZatMgYygrKs/3AcBpwy4Eulr0kQ
         LoWqm4RzXeKbPXFp4h4q0KXyCW4bfaDdZGih03Aw1OssM3GJhoLaT6ilmpYWlJ/EW4wC
         +OEDoUmyyb91UjXbdOGc054PYT8maF2cGsUHNauEqSsiA+Gdv0e9D8JQgoU35exPrvcJ
         CLr7YyU/ooSyvT8RnKg4Mq5m8lSEOdsG32QPkeI/aROPm9BdvUkzjNLk0m327PsDrCag
         SSnA==
X-Gm-Message-State: AOJu0YyjFqCh8X9fMSPDM/kn3ND/V9FBYc9IT9Z56UEBeC/c2flKwSVj
	r1CwDr4d4t/81I6IKbtktxVn9KoeAi2/Oqzz/tpWKwTALi3HQ5IdKXQp7L7G1Q==
X-Gm-Gg: ASbGnctI+gcEiwyZNLbU8T7Bri2DLSv6Jb8zMipsDwAQ8RNQk2KYPEG41KSm/YPzBxI
	0VZ2/OwH9H3b+qnLVSl6PuOuYzdjZqJr3icJthZR5w35b2pPT5YER0vK7f11O4NMe8u33gGzDlk
	MRcVo2QN9ll1TabNvKiBPzBqL9XodVl7aGMLE7EUzrLm2WXkypbN106+P9+1KHPotd7l9pmTXNL
	6pEr+ma0hlRK0i/BCJoV8lXXMGgcZqXNXdfbqgCTfgBZ4xiRmtvt7A4ba0ONdS4bNlbqhxR6lmg
	fWyGy7mFuYOumzbp8O1OmSpdLxWcUWIaQ9I+MZa3GQ3z6nxrOcpVsLs70hc7cPM4bsC8OQgplL0
	7lZVk3GecrMAAqng2AcBBp0deho3rtO3m7ISU8LA=
X-Google-Smtp-Source: AGHT+IF6AZwSVLl5koP/sjehcDunXnGMSgeEURNY7/J7DtgPQ0Esqh5XlIW8JeoaiJ9Qyrojf6NBCw==
X-Received: by 2002:a05:6a00:4b55:b0:776:1a2a:6baf with SMTP id d2e1a72fcca58-77e4f19fe23mr3514341b3a.32.1758276178642;
        Fri, 19 Sep 2025 03:02:58 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.40.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77da1584eafsm3723589b3a.20.2025.09.19.03.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:02:57 -0700 (PDT)
Message-ID: <68cd2a51.050a0220.1df6cd.f63c@mx.google.com>
Date: Fri, 19 Sep 2025 03:02:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2716426724661851979=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] doc: Fix typo in PreferredBearer property
In-Reply-To: <20250919084324.2799981-1-hadess@hadess.net>
References: <20250919084324.2799981-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2716426724661851979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1004140

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.49 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      2592.23 seconds
MakeCheck                     PASS      19.77 seconds
MakeDistcheck                 PASS      183.10 seconds
CheckValgrind                 PASS      234.72 seconds
CheckSmatch                   PASS      305.23 seconds
bluezmakeextell               PASS      127.85 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      915.16 seconds

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


--===============2716426724661851979==--

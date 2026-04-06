Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BAF21B192
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508915; cv=none; b=mRViRSrG1N9xm6JrF7NJQ8cqj9CJ2NEly8+ytN+5F3uUs1+Up3x3dQFwz5m8d5GhGWIbWVah860ATiECV+qSqizRLVmrNGLrBxa44Av20E3XMYLlIrh7yJj1LKfSKch7kMWShsteivKwA+cZt0wtZB2X4I+simjSNCxDrJvMHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508915; c=relaxed/simple;
	bh=RH2qN0O4FaY2zOV17GhqinoC8swuMcU9L0x1DIHXXKc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s6tfL0DZEV0AkIEtGQz7KrBnsdVO9ps5mWAxS21t8v2m5lIrL42bUDUVEO1HYJhbSgLEFJPalHqnA+yQ0SEihIdKbbO+L5MWUapWJI2qTZol3/f8seMYVeuJhANZP7BeDlho54lUyncBcGbppw4U/EtsLGOBHhqpNapgWkoWDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB6gYEHq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB6gYEHq"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50b69bf5638so54173051cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2026 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775508912; x=1776113712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xuo4oFU6iJowG99RovwgF0nQHlKzPXpBrR4n1hUoy8U=;
        b=GB6gYEHqSkTm4D1wzintELvDf/5iyukR/5vA4P3HH6cLKHiO2D6Y6+uMClkVdFwO7n
         UmqSeppURG/qVb8urokwDAnpyJJkFzcMRsLob0LEdRZOYZjB3q/O8htvUNeBy1JJZwbB
         we8lxqfdflNaYkfCK/u7gOMWNVbyqhslYHLrhAEYMKGK8hN3IHFdy3WYGZgDY8hR0ogp
         bIKhf5AoywcDMTmoGzar7HxUKWuMPtytjrb0lyEbT+65ymtsOj4tREmbTMuDIAmuIcIT
         1moNKB0y6c3a0M9timo3ct2PjenLIOxHGvcUIZ+LfJtSDwwxsc50LL0Ru5ckrknIrcoD
         rK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775508912; x=1776113712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xuo4oFU6iJowG99RovwgF0nQHlKzPXpBrR4n1hUoy8U=;
        b=i2yV4mTna/pNf5nBeU5yx4+ciDB+YRe0CHKeqvioy+DIs//5L7T7UsC0AgW9Z3Twx9
         QVuxAPXciPps4h7nBoprvDTqgy6AWn2lHEwnTjaQjaml6p8eHDSeD5EdVEXnzFqUwsqr
         y5UDh+hTYKLrgLnBuR1/S+oEZtig09jnhnzmZHIT6+kRF2887xr4XBpp9RBwGdjBWnaN
         KCBI2Ab/ZMYcAbtB+/R+Qeg4SSVpL34Iqx3z8Km9abQlr9aUiv/zVxeEpy7ngAVCJ3o3
         BkxnlzQceYjiZgCAo3J4VzqepCheS4DVgamt0lRP54j0XwzGRHK6AtqLLrRzgr3gfGkM
         VfoQ==
X-Gm-Message-State: AOJu0Yw7eDK5TkrAH2Jo9xbWBOs0YbVJCcTerfJi2n8OQ8VYi02KJY0j
	kPWOeJBfB47wQHnNX0azNVQBI4CpG0XEfLuSMgcUeeO5HCZ22iqEKAqLA+6AQw==
X-Gm-Gg: AeBDietmFpRW9905RxJo7LV4SoKH76J0px8iE9YaHAP6lP2mASffoIH3Q1PrGK0J2MK
	Z2ITD+ZBqsU3gW/pM65f7k9vTidWgDfIdRhJfVpMCm/+ol46jRpw89vlwg29FoOg4TLNUcd3ghp
	L7qSTdYR8nePJuMdYPNy0BRWHhsu9qc4aQFsw9Bp4bPAL5+qoWwElxXj+50KpXSS7RiOb5m4AH4
	8tP6rnTjUNdzC2C521iNSZheCALVtxnDvnuEwEqIA2zZuDJ2nUmoyvoDS+3AhP3u8WSN1yK6aaR
	onmNYAZUdvmf0miMdvDrTInE1C/tcEq9izOmIh9nTPk4plcwFEQulULzUEi/mufoul1zOgvoiqq
	tQcdV9awUpoimwxbGijyBTpRMG+uBcNO9Ju5FGclLmHYKvqZ1BQdJsQqF7Bm4Xz8Uq/dnEj3fMA
	6H3S+5TFvmt8CFoNaFvD2thzRQcRFWag==
X-Received: by 2002:a05:622a:aa0b:20b0:50b:409d:48b7 with SMTP id d75a77b69052e-50d62aa53f6mr167355761cf.44.1775508912330;
        Mon, 06 Apr 2026 13:55:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.88.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b746314sm135248221cf.16.2026.04.06.13.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:55:11 -0700 (PDT)
Message-ID: <69d41daf.050a0220.3b910.2352@mx.google.com>
Date: Mon, 06 Apr 2026 13:55:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2214453430994969303=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Fix not loading local GATT DB from cache
In-Reply-To: <20260406200043.3447321-1-luiz.dentz@gmail.com>
References: <20260406200043.3447321-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2214453430994969303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077784

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.56 seconds
BluezMake                     PASS      655.19 seconds
MakeCheck                     PASS      18.10 seconds
MakeDistcheck                 PASS      243.21 seconds
CheckValgrind                 PASS      297.43 seconds
CheckSmatch                   PASS      349.29 seconds
bluezmakeextell               PASS      181.12 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1028.57 seconds

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



https://github.com/bluez/bluez/pull/2022/checks

---
Regards,
Linux Bluetooth


--===============2214453430994969303==--

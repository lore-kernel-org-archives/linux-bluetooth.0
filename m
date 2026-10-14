Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7331E84F
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014837; cv=none; b=umNuNiusWdoogAZLnOKueI7YjKMqJGt04G1lyeK5PRlbmWLLdAMVH1UlB8CqnsR7ol/d+U88vh2OBbMTuVbdmh5ec7iJ+b79LP/yI6vqQ0BaNDh3OzkJRaIsxAI1kIV3PmZznR+moPp4t2h5yY/H2d9p1KcQ2i/XHBJ3dfEu2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014837; c=relaxed/simple;
	bh=oY20vUVv0r9BvnyCq8+nZlX7TxqLwhfTSvlDNUT0BTY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JQENRjuDwYZ6lMWerrilPglWrEu1b/V3JsnNnbb1uz64F1ytuUa03F+ik9T6aV8l9bhBs2BrarGJfjBirluKKec8rV1Aywv05FWEzGPNHqF/J9ouZFVdyEmaLfoRMkDfyrQFZh1uSlDKYDaP8nRC+3DNdvsS8XJtO1aHqfTVhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4ffVegP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4ffVegP"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53391022dc0so52032701cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792014835; x=1792619635; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VDAqsr1npxbs+Qgi3HI/Bk5ZkGcuj2/tCxhDTd3cH3c=;
        b=Z4ffVegPTc2PgNY+0Dsnv9sV0SBNzQd7+3hWf70jzSN4HToa8z26nrnvNifjN/C5JN
         vt54xMUx3qz3cMijtEe17/KhrYfsdrnBt5OzyC6kr1/bjsbsOFDng0/GMbNwJuZnZH/L
         cgN2kqdb43ySx+qyCq+Q4dv4KWnB1tV+ZchJjIa8S3oLfoyOcnCxpCBo19NVubG6pznp
         Bh2/oJPGB99eQU8YhcG57VhK7dsePsBkO8v/TfgUNvgL50VCaekHyoJYmsZ1eOPAbhnO
         se1edMmeonBfcR2GONW8equqkKcV7ZMrSl7/90ih3ZbXIrxdvXixthx+uuRta8YRo9sU
         JulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014835; x=1792619635;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VDAqsr1npxbs+Qgi3HI/Bk5ZkGcuj2/tCxhDTd3cH3c=;
        b=O62bQrtXcXWtJj1ZwTIu4bNkIYVVooY5B2niEnpaAHR6LZg/fzq/lqdcWZ0ULrPWXF
         HzIc/PSc7ktRDzk9umLDLeCwkO/w96nqKHbdan10rAMGybC5pzgvDYx8+thu9oJKhrPL
         lzuBuqulwYIkLRySEom3O/1NjkEtt7UQEtFBCkNvp2GBL0CRjU0M1YBTqU0qq46OaZCb
         lndaC00PvBIKpKYVDKCJMqr3cEMip7lOkVCvdkasbHmprUp8mMoyf79uUVcS48EWM+oQ
         tshUolfm4MGjzEnwhqeMecwruO09avcW+1JxchEyWDtTh+TR5iYrqMEV44Cr2tboPW7d
         sZzw==
X-Gm-Message-State: AFq9FYKlUn3wyjGNM/4AhznRe3WR4bbS/kMPkoBLX8l66+QJpwWBsdIh
	sX/6d78Gplnc/mLEMcyU8TGtuuaDTsNlMLX2A+6Oht8TSwgcQAlhlR6DeiwOtw==
X-Gm-Gg: AYBFou1VnBf2YI0s5D+9M7I/lx4ddtBY0AWkuOE2QLiKheZp6oLdmZKMbzPjXKkSlNI
	Xl15iTWoHNM/LBV5bQqlcCquB6EdJIbE/h5MsY5kI//zuv7DBxIif3A4FD6Kgv+wgVSkxLdE0aB
	E3WI8Lza923g94NPdsQB/w+yjvgwXg9I2t+1va+nfBmBwh0C7oDNL+fAHfzOeM1FtJSyxSfTqHI
	EA7OZ4TAQWpza3LlgE5satUAhYRIbD/DonX5YxT2qfKT0IQo/47/Oo+TwY/MtAHFEXEktw6weG3
	BsbIzvxBAJ1Ds639xdIyWEOBC3zOS6QatICAIlIesl46cyh4bMGc1FdbmW5l0T3tdimFKhXlLVW
	4WQI8606G9DzW6dIMweRg6J7+JEbYz6OzxdSlASBNdmOzOys3t7zAgzkFsv7ZZUM8uITWylfG41
	kPqYnAiG36NKQJrNF2/xAsz9jwMX/FlMNorw+z4SUbOVNb/PrRKs6oMpZQxdAByiMjIy9y7HlJn
	J7iA54=
X-Received: by 2002:a05:622a:8414:20b0:535:d4d8:eed6 with SMTP id d75a77b69052e-535d4d8f54dmr120348441cf.32.1792014835408;
        Wed, 14 Oct 2026 14:53:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.175.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127c62d3sm7779751cf.15.2026.10.14.14.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:53:54 -0700 (PDT)
Message-ID: <6acff9f2.699f42ab.1b862.6d45@mx.google.com>
Date: Wed, 14 Oct 2026 14:53:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6416259296738344006=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] mgmt-tester: Add LL Privacy host-resolved RPA scan checks
In-Reply-To: <20261014181153.1559666-1-luiz.dentz@gmail.com>
References: <20261014181153.1559666-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6416259296738344006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185788/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      19.72 seconds
BluezMake                     PASS      302.23 seconds
CheckSmatch                   PASS      296.18 seconds
bluezmakeextell               PASS      95.13 seconds
TestFunctional                PASS      1135.66 seconds
IncrementalBuild              PASS      302.77 seconds
ScanBuild                     PASS      1153.57 seconds



https://github.com/bluez/bluez/pull/2681

---
Regards,
Linux Bluetooth


--===============6416259296738344006==--

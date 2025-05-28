Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436022ACD6
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428416; cv=none; b=tDMX1/tWYlfKwcr/g5+g8sQWfTl1qRRs4wsDswRXWsAkRZJ7KN2bNDocaU/Ml4jeJRW6PNC6rJxgC5Kq1LExdWxURsWSaVmU+7Ri/bl3CBvKZBjzZQDVLiKeUtV0xWvFWnAsLp6sU0az8pBajYJbKZ5n4sOGoahEhONeoE5+cHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428416; c=relaxed/simple;
	bh=yd4Hx2ZbE/8g8BznEePcLPCadI8a7fJ1KKFgagxf/VY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j2fCqB7pKyypiV1QHp5ck6PG8WAdFseiSVlB/zEsx/Ic6VDnAHXBDlTFH90jobnBLKbZvLRKEOAEZ0KByV/rKXGeRUIjWIJSJwTBseSiD0o80ccJ0H+IVZsW2zSczzAuBNkpindI7FvGhaZWjRv2fy+nx5LpTVB27R9S3EriAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLwN8TNR; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLwN8TNR"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-867355d9c4eso94443239f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748428413; x=1749033213; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wExCDflCTUpF/JsB4Qjg9le6PwoSqvLEuGvf4Nfkq48=;
        b=fLwN8TNRjISJotLo98VOpxAmj3NOBHjhY3mAQ/cUEWrY2u2tXaCrqDYZUo3IiaOOJt
         iU7PinGoO4C2zUbq/W9OphNqlL25HhXW/Q/WWYBuTCXRYAPzierNi44Ef2Pn1NcTzheD
         35BW6Z2ZPcBImvB2Myof4c6AjEmg/2qEyJmKWluhKKhXoRz+9haTOjyHR85R+Y0lnf/8
         4Sxl6RtlhEAqIR1+GwHb7l+iEhlt9AphdJHT26U+lD4pTn/Uowk4XcgXHx4mFbkn5s6d
         fRR10P2MsdgSezjewXK+vw0kL64dP5CKYibdToXteHUJCC2bx94dhb3GhegwlQCCzsDX
         uJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428413; x=1749033213;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wExCDflCTUpF/JsB4Qjg9le6PwoSqvLEuGvf4Nfkq48=;
        b=MWbkpESc3tdtnqq48qk5453czc9eU1UjmFC3e7JON9W26dCS54WelY7Z4RLNiaiEG4
         buzeUp8viIvpTjj79CdmLZB1Q226xycLwhLyodfsG1kWKxjp2gFLp8ofW52/Vbzl0Zzz
         eo3gHgh979ZmtYzHqL37eknqH5cK8pkr9EuxrQAihJp/pb2ZgZNnfkigh9cX4rHBmzCm
         dPYlvQWuKeUbZbcIwzHWKUc1ENM/i4zqd1qcgz/I57wT5CiN9qN9E+VZKO7W/GnJ7Ms1
         tIErV5NeXtkY7rGfKmwZfYsNogKn5aeZmtvZbUc2rhJXbHoqycaMP6prsL2+fOWeeRD3
         orwQ==
X-Gm-Message-State: AOJu0YyG+/QA+JcBc3hQmZkbUApFSVq6ADUOuLzR/FXEE/1p17MGUsje
	Jivzp1iviuNLq6CePnpYCYgVBOep5QtXZuVxYtQiuLFC8qJPD79zMARZ7C44YwYK
X-Gm-Gg: ASbGncsueQ2awF+hCsxkQFjIsvn9OB+uy+YZqfp7S9Pa2yCAw2PT4pn3hKTFecj+1xl
	5TI6a8AX669SXg4tMPMTTnFMhF+mhGzs7ilwPB2E4btvauG8G7bUKpaLJBv1iCK8MHBXwsSLA+/
	hqyywPs25KmrQCqfMEobbTgQVLTxssrLx68BZIfCyynpbpUNnYRuuCOFCBNda7dN5CdXH7rdJom
	eYnxjxxVmOulWtUxT5/QRYGV9Y7eT8g9phiMw2d5iPJHUrAKvgM+vqSKu/MwEDqpgn7U4/BTJzk
	qsgkyhdxhChS+CUSuCHQGtJqekp0IU4RRdZ7u5cUSzqyxVcyI2YnMmD1uw==
X-Google-Smtp-Source: AGHT+IEoyOxFrqbD6pRRpEVnvaQwOHegXPBaz8fJ0g62Io/y4/j5yy7ZegtZPrTUEH9QKPYnZzNvOQ==
X-Received: by 2002:a05:6e02:1787:b0:3dc:746b:5455 with SMTP id e9e14a558f8ab-3dc9b689ce3mr125416875ab.13.1748428412076;
        Wed, 28 May 2025 03:33:32 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.144.68])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdbd495bfdsm170496173.7.2025.05.28.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:33:31 -0700 (PDT)
Message-ID: <6836e67b.050a0220.269783.028e@mx.google.com>
Date: Wed, 28 May 2025 03:33:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7835128106811512336=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: New Telephony interface for HSP, HFP and CCP
In-Reply-To: <20250528085930.227816-2-frederic.danis@collabora.com>
References: <20250528085930.227816-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7835128106811512336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966926

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      2624.40 seconds
MakeCheck                     PASS      20.41 seconds
MakeDistcheck                 FAIL      8.76 seconds
CheckValgrind                 PASS      275.83 seconds
CheckSmatch                   PASS      302.61 seconds
bluezmakeextell               PASS      128.49 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      897.49 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'doc/mgmt-api.txt', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:12236: distdir] Error 2
make: *** [Makefile:12312: dist] Error 2
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7835128106811512336==--

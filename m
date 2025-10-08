Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B271BD9C9
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925856; cv=none; b=igo9ex0CB8BYdFsGm9KUWJbS0cKc72B22D/Wz4tQUlMG0x2lN5KCgFIoSVPnp4rpAeYhroq86rGYiDGaZPv00wMn5RzOR6Zjydx9ocxvQOG+5cZZBU4+pg901NADkuNzscTnmCbqBEJPAuv2+tLIW0s/FoKLLFR8/2yKfrwvLEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925856; c=relaxed/simple;
	bh=eujKUvpTGnMNs4qCfzbCz8dfS9rAN3qnaqQwb9zy0jg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kKbJM4diaEVxphhhgkfG8clzFi57QyU3vZer5dni3uLR7LrWoM/Cqc/Xp7auXWvB/dkl6we/NvtrhopogyK8ErHSnh98OSzBE07YvhX+oTwtNtaXbYx0wypBtBkH5+yZ9KUM12ZwrOrdT8eRs6jHVVS3Op223MBx+R+tX8oxcDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjGjw3TB; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjGjw3TB"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-911afafcc20so293857239f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Oct 2025 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759925854; x=1760530654; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ThzoX+aL0r6Vk5+y+jATytiXY3f40KQqREQc0owoC8k=;
        b=KjGjw3TBQ+yvCMcET4lTBTVDS6x6DlOdS5NHzJKBYny+UjFF9R0oMwvmo4cABu7CK2
         W0t59hSkY/LPde4Ug3vbGQjwCW9E69DwsHHeYIT0+5R1eT3W68SbxH/ZPRjsOVjJHu7K
         vfkg0LNHiDq8AZkcD1sDjsKbVrPYH4xTirizlLx5ccCSHuS4lSr/DV4mSPYKN2Svk+cU
         yFlCgKRvuT0rUyj7Y7tVqaXYqhz4a4kpZxViJoKo0BVPO11nkXluyS/unmiRTumqCBEp
         woFAaFNlyb2tVukakLbl+9mNdx655mOF27XdZNybmUbzO7tVv7clJ8KyNZ5bESDFme7c
         rigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925854; x=1760530654;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThzoX+aL0r6Vk5+y+jATytiXY3f40KQqREQc0owoC8k=;
        b=B7ArbpiA2u9UTfgX20AiAicjp9rJWu9hcZ2lg35KFcXMFZYG54efjS9X//AJV8BwgJ
         enq4nYXOOjaQ7f/IGUduginoyvtVJwTj5FlT/ZczEeGBHROe2Y2y31GPnbP4uOhDgO9f
         V0+YpTsZ7SGB9WzgIwXzqmM3ttECARGnrvlYOTVgfeqyzL6CDIYsXcMIr6X8wpJMPNgc
         1TAiZoQhqlKWq3Dr3V2qQsrAq8WzP/Ufmh+5I8eWgFHpapfVH4/83GgKYbKxf+8DvOar
         iX9tDJO1ddYY8410Zd85b9zN2L/qanK4hCTGVK9Kp+oJwWNY30d5/JU/WTQUOvQ+Nbbs
         zsbQ==
X-Gm-Message-State: AOJu0YxZF5dEhnta95CAmALtpcvT2x9CiTMgOdVCGE9kQJSPAxHwjywK
	IqjDNU4cagBW7KwUtcMt4ViEbcEz0wImCGW11smAcA0mCB3kzT7Cj3ghVj7bcA==
X-Gm-Gg: ASbGncvGnuZzoVcDht+eOb2xakpGudYo/JI1REeEbgEc2/VX4Xx0S4m0vp79Qup6MrJ
	Q6uqkYAK6tHJKfHK0EptEAFyrB1n/UAKP5tzolEqgWx7LecBDGAMHs/K5HoQGsfNGINZI6iGsYi
	Vsd57J+e1vQz3AqHQJq/oLFKpxwzWRGowWvSvbQxkPr13hgiUgIxEWwIF4xaNh9qDk6nn9cv/Uj
	2ui302amdLFeNL8VJllJmW2gpuYxpWsHzU9jNLbi31vtIeyD5z/MbSEGNAFbP81HshmFfw7bRXm
	LPc9xBe6TUmXY7TYI4GRHcrWH1uPrXv4fM5umUKKf2bXLSItx4XvO02U51AoShaM7ou39Q+Q95H
	V5yl0l9uZiYM6U5kw8nKKdhRZD2KNc3KoLciixW4SB8uF1Yw4bs9oFx8=
X-Google-Smtp-Source: AGHT+IE6BxGCmkNJrMRIjA7VUu5XpzA3Xd9eJCtTWCeQPoWbp+0X/V91R43XTyJulo+TKasLz/77kQ==
X-Received: by 2002:a05:6e02:1707:b0:425:e850:b2e3 with SMTP id e9e14a558f8ab-42f874537cemr24930515ab.32.1759925852666;
        Wed, 08 Oct 2025 05:17:32 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc8181sm7317003173.47.2025.10.08.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:17:32 -0700 (PDT)
Message-ID: <68e6565c.050a0220.126044.cae2@mx.google.com>
Date: Wed, 08 Oct 2025 05:17:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6670761876051578195=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: build: Add meson build system
In-Reply-To: <20251008104132.2206963-2-hadess@hadess.net>
References: <20251008104132.2206963-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6670761876051578195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009338

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      19.92 seconds
BluezMake                     PASS      2675.00 seconds
MakeCheck                     PASS      19.91 seconds
MakeDistcheck                 PASS      182.81 seconds
CheckValgrind                 PASS      235.15 seconds
CheckSmatch                   PASS      306.36 seconds
bluezmakeextell               PASS      127.95 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      907.15 seconds

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


--===============6670761876051578195==--

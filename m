Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998323A562
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442190; cv=none; b=j7ySdS417IVNKAW8Fmg9iOJlFWH5X0ukbTINR1KCqsBsCPUnhTYTC3zp2iBenGW6ysztUl5/f1oM8LSflpmiL4TgqjKX1YwffHL8HTxbWIItt85RPxI+1vP+05IKki6bjcayKKs40ZEbrWgb40nlozrmuQkfdBALEd4OBL3qfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442190; c=relaxed/simple;
	bh=qrnvoyRsU6+V8NNN+WmoJAOP7w9Ld1rajafBLL7Nev8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N0fQfh397ogZC11Vjgfkfzp2634oMKGdcDFZgOOvAm2zRrZVWVNrb13FByzHr3veq69Q20EsYrMYJUZR7JPb+s1NDwhwH62/s+3D+crrCTc9B+0DbWxYX13hmToEjUDF9VZzEaEJnpmka/aIM+32NA5azOmRK4TUxVBnrfjV43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0wQOKjz; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0wQOKjz"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30807ba471bso7096214eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442189; x=1782046989; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QLQTHOBW+SkQvd18tBWAK+DhDBdcWlNi3RSPQnoovNg=;
        b=j0wQOKjzgv5yG8b3dIIPKrFmAKSXCw0xszPScINzfNWLTMs5PQBNNvy/Y1VrS6mDpR
         gAk/+ItzgMy4tdNE1LOD3kWnS/4ncCuR09CCYivOeT4jnqcHwuJYWE6Z/VWHKDlL41Q3
         tk1JwKCowuVavvetyX5gN/ocQXcV2I2NnTYBT/mmUDVLMPiTD5itLbKlk8MSsVclvkfC
         lDIFNAVeDWAgLSbW+MhVq2ZMkwNH89xnrsCGiuXBEpRcF6G8AFGngETY1uef9sv/8pOc
         nmemAdwbDLfaC2d96BPWXOfSNQDbotR4XCw08uh4VIEmJuZ9rbb5UCH7cKQptfOJLGkn
         6gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442189; x=1782046989;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLQTHOBW+SkQvd18tBWAK+DhDBdcWlNi3RSPQnoovNg=;
        b=RQuNnFZXt6WmB7VkHjbqD1j2UqHmeA8McmJmJqpaYZ2Zh7Sw2OWd/W6Tu2BhAK+Y23
         GxGpqMiUYk2O8GCroSKZ5kAVowMNgV8vGnjHQR4fiY4MIm90BjeRiMYxsfWQZ3geLKZ2
         NHw9sFtQKU/jvTWWw+IeyM2hLRVdSFsdN3RHqa7oLDY1OJqR2skrcrhp+YMzPi+D6fol
         aJyOMryZVKAC9G1brpN6uvfNQwn7eo5fRc3+jngpbRgZ0lS+JmZbEFyV6vdcxKJnZhfj
         f0el2Nq5Mlv82bognknXkR9nqNzn8gulYmQ0d+ct0x8SnBYXUS1bh/YEGcPuC/fa0LZ6
         OwBQ==
X-Gm-Message-State: AOJu0YznhzIvyi/vpRwWGM+2gwdR3oKMS23jW0bWl1PbQ/28sc6TrUee
	B0kKymFOxuKQqCDohuQjBpdYsLOaBRu+6Ud0ExTf0ra6ISoWYx7qYP26aQP01A==
X-Gm-Gg: Acq92OFXoprQEGdA8tc2hlxgyiINu76CvXJ0PJhnUKpGAmvmNhxhEC+gg/zmtIc0wGT
	uCmghKDqx/Dg7m1P7KCpQ99LHt6EhBn+mbH/iCSAa+wJpQ9k/MI+AEOV4dwF0ZemvN8pJ+lwuhi
	cknYBAq4cIwaT0UWSQf5S41eisWkiBsgaYTLw7lFkcY3dYtrMg8gAM6i/vNdUB4CESkeJEZ0WCr
	5WLaDrtFjJjQzy3ECE/E3GboZ07nYoQMO5zEPm0PrUyTkWXLt03yGM3TP/FqvWv8H/GYe0g/14A
	CFRyvZ0rVgpDBxXbBogITN5MERM5BhkzsyKp+AA8/rmRVogc2a26qSbczV6YNzO0iIHPBJpmnG2
	YNYccgYyqokDhmAQgwjFEW5Axw3QIRg1ymUbiSRt4NaZepIlHqDkQIEa03topfGszjMZAtREXGH
	40iGn9ueted4XC2vhHDBuenP0dvd6LTq8=
X-Received: by 2002:a05:7300:8196:b0:2ed:6f94:9d9f with SMTP id 5a478bee46e88-3081ff75663mr6438257eec.11.1781442188490;
        Sun, 14 Jun 2026 06:03:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.106.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm11339602eec.3.2026.06.14.06.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:03:07 -0700 (PDT)
Message-ID: <6a2ea68b.4a342cbc.316e90.0f43@mx.google.com>
Date: Sun, 14 Jun 2026 06:03:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3748067614830539573=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v3,1/2] shared/bap: Initialize ucast/bcast IDs as unset
In-Reply-To: <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
References: <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3748067614830539573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111255

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       FAIL      0.44 seconds
BuildEll                      PASS      17.83 seconds
BluezMake                     PASS      638.03 seconds
MakeCheck                     PASS      18.06 seconds
MakeDistcheck                 PASS      222.41 seconds
CheckValgrind                 PASS      278.79 seconds
CheckSmatch                   WARNING   316.71 seconds
bluezmakeextell               PASS      168.90 seconds
IncrementalBuild              PASS      639.69 seconds
ScanBuild                     PASS      926.11 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,2/2] shared/bap: Don't link server ucast streams before CIS IDs are assigned

1: T1 Title exceeds max length (86>80): "[BlueZ,v3,2/2] shared/bap: Don't link server ucast streams before CIS IDs are assigned"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2232

---
Regards,
Linux Bluetooth


--===============3748067614830539573==--

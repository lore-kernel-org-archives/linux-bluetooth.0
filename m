Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58FF19C54E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744760050; cv=none; b=eyi3r63vtFUM0nC2lYrlLG0TAo/4kX3v7D27pLn3tlMIUt2bMrph7DjXhfvOvLWLSKI7JKcVZrEDkkdvUPwLRF+qxyKIcH/hhizLRYwMg/sDJhFlk6fG8iG+5LUgGOzZkLPMIRZsuAq1bc81R6+37crEA46WX5pOLjnPJTEOr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744760050; c=relaxed/simple;
	bh=Ai3WzGHQTKzT+7eDapsswmWGEwhDe3Lvh9ZVvveSJiQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S/BnGaZOOM8w33j0YVGS9S+iMR4qZBajFBc8+7cLhVDlKkuQROXX5kPHsXdvllTCnOlpehhMpR+ffbhbftNW9e8HAfANFTyfha6yL4Yf90FrG/KczKhoPg5OUqTMEgIyMuGzHN37iHFToRnMCu1KMlc8ZBaXqy0/5Ph86gNrdXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfBDVkPy; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfBDVkPy"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so1701166d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 16:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744760047; x=1745364847; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mLY0KJLAfJd9oC4zyPVzmfkk550YkwWMcnqkzRif5CA=;
        b=LfBDVkPy37nKH+zMUFfb8lFqHndBEEh095pu3kiXAKB0Yccrc4dMAA2P8ae+kBTj8G
         G/BMP2JtZD3JU4vfNJ3iuY60jll/0aBI+mGPOXfY/uHFT6hWt0qICrXv5NonI1BiV2oM
         rjZPx1J3O+UXIqHX62C2Tdwlb9JgrtmyHZSOAk8NlibRKy5RoCF3V7eb7+bLTZQvD3ba
         Fp4TO7wN9yixwppj6eyQKwOVTLnbB5uj935nvl07PnOYvlh+X6cML4TnZ/reqUPrdOFc
         vfERqWqtdLSWKGCN3sGSEpgW3OdYy56HfsYhkj1LUTMbNm66CNfuuEAuQxpRHqEHx09r
         moSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744760047; x=1745364847;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLY0KJLAfJd9oC4zyPVzmfkk550YkwWMcnqkzRif5CA=;
        b=L0Nmgwh3HD7TXujOdtsrrEsVhv7U9ZgB1AHO/XhjI2ELeJImDncHk+PX5z2K4Lkxv0
         N4Bu9F0Qav7PSLXx9ulXjWGdaDY5al+t4B4cAS0YVTUXrszNgcLVv4HbnpOjUd0l1SeM
         +i40PzhReo156vgOHWg6IgcqYUw6k6mJ19IWueUYek4vBWw8MipAkhZIxHsnCWKuI8KX
         QHttQMWz8S3+4lQ+4TgcZJOqZKqWDCn2Cqb8XiT3Dcbj9eFEkU8FFAKchZVbioVIG+ck
         7SwnrSmtzMVE4G7sZ+zI/0CCgw22w68AvPLlMR8FImzAHAYRicyGX9Z3T8Rqdfq38pTF
         CXlQ==
X-Gm-Message-State: AOJu0Yzm6wV+g1CZZtFGN+8aKV1q2c0q1OeRcwAFX1d0+aY7MgIWLgcl
	hpdFwBF4A6j43Ur7JxaYGYMId+cm9THEclTwY9+9h/pbBWDMhovrOzSWDQ==
X-Gm-Gg: ASbGncumGMVsP66LKW+6jXKbC/C19eUenHqmBmmqcrDtz2me8vnJvrL8/8m/g/dagK/
	cnkp/q5RK5HOOUA2iLh8PVx5v+AQjQFLbqSGj4aWwFE6KVZUFZigHoY6eYQ7h2h/mYtikW31TcS
	hBZKoZNjZdZ//eIqcfEbbRjDG+KZhZHvYdd0JjltfM1PhG35c68IFJJ9YvekNr0ccSOKRcnORaD
	T4j8LrOcystjo3bcVeMPv1ZpicuXAtdYfjnEpNzFq6M4W8cS8zESF82fe9zrnvzNhY8NzCNuZla
	Gi9/OASniafFB/rz7lTYujXKkrZivjvhmj8CEzJBSs0FBeY=
X-Google-Smtp-Source: AGHT+IFmuRAse1yNPHkChUnIYR+/dISXC9nibqF1PLuJFndzaWXEdjDCBUtAEZwsGxnOKgVX708XIQ==
X-Received: by 2002:a05:6214:19eb:b0:6e2:485d:fddd with SMTP id 6a1803df08f44-6f2ad86bcb7mr27639626d6.1.1744760047485;
        Tue, 15 Apr 2025 16:34:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.217])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea0806esm107012496d6.69.2025.04.15.16.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 16:34:07 -0700 (PDT)
Message-ID: <67feecef.d40a0220.35d60d.b6c8@mx.google.com>
Date: Tue, 15 Apr 2025 16:34:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6908779192079553045=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] bap: Fix not setting SID for broadcast receiver
In-Reply-To: <20250415214811.1677842-8-luiz.dentz@gmail.com>
References: <20250415214811.1677842-8-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6908779192079553045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953730

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.60 seconds
BluezMake                     PASS      2662.10 seconds
MakeCheck                     PASS      25.83 seconds
MakeDistcheck                 PASS      200.51 seconds
CheckValgrind                 PASS      296.96 seconds
CheckSmatch                   PASS      304.88 seconds
bluezmakeextell               PASS      129.58 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      933.16 seconds

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


--===============6908779192079553045==--

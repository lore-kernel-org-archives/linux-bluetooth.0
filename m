Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481452C21C0
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168890; cv=none; b=eem2E42ftzx2jJlfDP2s1HaITXPt5QoEJnzoIQ6UcRZrDRYJP8pClaRZZrGR0yOXkvCb2zgly4ErmQWXJmjyHtXDTcMxfFE3228bLkJ9aATgDUQ/mEdcD8vvdamvEYXRl3qXeYt0vZc3hsT6qkuW0ZzjZUGDnhQt2+Sn6HVZPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168890; c=relaxed/simple;
	bh=D70IQdATTA5szpI4FOmoSKn+jxjLqSjQVG05xmhaQdc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PZuNiJV7P8opXfBsZzpRaA9vwi+szw3x9RhJBF+cW7GbP/QR+9c5HWhTijHMVFqyIvRheIaj79HsVUzP/dHbP8zCyna+jfa9FAg3/R4cLeXjNATyE7//ojglnYA02hlna6aMaiXdbH8yDqunq16LLrR3fGrODVr1legYyTzwPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT9C7Ksg; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT9C7Ksg"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-65f59501dacso1586323eaf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769168887; x=1769773687; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7G9DbQjZ6+UE/lNzKnTjNL/EzWl8/vp9iF2UzT8V7sU=;
        b=HT9C7Ksg/JZ2mZ7GqrIuqSoNWzg6F4sNikgM0jqqkKiS9+qmht/+xqY0RRsWUyWRvL
         jhEAPkHes1cTRQHjXK0vHgeLjRHbK0zHOPGapH6kenHjl54YC/71wfj4a7FezcoDdOOC
         T4/KOWVwUIhHbVDHzpIS6n5cs2uKpTxlK+AMpRRL0351qZm0eghVPU5Q3eRcepqREndO
         dUZqBklbRyhhw9p/5WmEu6s7JpSV74SomneRyIB90Huo3Vuc6lr+IvqMMUC6Ag+yUv1W
         TIevVTmbzQKIY2LlxfQCMUKCiljevGZL3t6uaXNYSXVE6SAQowPOQxQEYLbicNG29oya
         Wlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769168887; x=1769773687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G9DbQjZ6+UE/lNzKnTjNL/EzWl8/vp9iF2UzT8V7sU=;
        b=LXv8LIvqXy1GaHjfzSImY1PsGbjdBeTX22je1uTZv3tmgMaM7xNHt7tD61WWLJ9gRH
         uUy+ZNQy6SSpC+OZYJn8ITgPsSXfw/7DGdabWa14a4BzhuO8+feWOBqdzuOOlN3CThOD
         ZRTBndMKZMvAE5+Mp9YTTC1hwKgVPjNQFz5ZgqWogwPohW9cSBSpY/y7fXO340LymlB2
         yOOUWSk19D+bbwSoObndiDqV8QU5xyDcjw64pVid1joDcObkgFJtSnUDtBdA1XATpR5n
         pb4LLTOLxjmKnPQFn9DEW/2+zwcEp+XHNiOZhVv5gFx1c5GLM5RxAXGhBMpR4YRnMd7D
         bo4A==
X-Gm-Message-State: AOJu0YzRO8bn9u0QLFa32Yj2xQ5KfEHyMDW4GOHuDjDylje7n6ZSCuT8
	z5j59K0aVdgvPLJug7KKwagRXSHu0pBcH5I3NfWw5rxzkjt5GtWgcwoWz7uPtdtH
X-Gm-Gg: AZuq6aIAozRXb5ILZAQrSaA/O+5k2jHh5OA3PwMDuSurL8yh5rmmqFCWm+lAltnkBMm
	cQ1UsZjFWdojtpSZ16dHxaQGLMWNrXcv12wWutMzZ9TZQQxkkzVKnSmB5H55v3LPZMi7w3+iTUV
	2mojzz+MTUYJeOGiyU3aybYCVZyK/H8ND5JgdVqHbvIYMA3q2EmXavHpjCa+/DfJO7EwLawI8tS
	uuJeTPT+7zu3FG2JCKwcFldf8uMvOOHfYXV29NRBsESGDMIoS/2/kP8DsOpRFRCp00R4pB3h00d
	xlSrpJ6jy38IWD6CYLU0dDwGgYpR0FhyB8KNPxr8v6etHBl1tClTgI2xgTaS+hTyBuM+3AORK9Y
	V7DGJLzZXkz6xdlXUce8tnSFtIfWTXVqR4weGjqUnlWOzOF8B3wjxAhDUDqQ5Nmme/6HC6nOtIc
	ZMVxrMoyAsmgKdDcLK
X-Received: by 2002:a05:6820:8118:b0:659:9a49:8ec7 with SMTP id 006d021491bc7-662cabb348bmr1242862eaf.75.1769168886664;
        Fri, 23 Jan 2026 03:48:06 -0800 (PST)
Received: from [172.17.0.2] ([135.119.38.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662cb4e5f47sm1058328eaf.3.2026.01.23.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:48:06 -0800 (PST)
Message-ID: <69735ff6.050a0220.86a04.c3a7@mx.google.com>
Date: Fri, 23 Jan 2026 03:48:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3905429876575296134=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the GAP qualification
In-Reply-To: <20260123105249.677211-1-frederic.danis@collabora.com>
References: <20260123105249.677211-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3905429876575296134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1046202

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.14 seconds
BluezMake                     PASS      643.43 seconds
MakeCheck                     PASS      19.06 seconds
MakeDistcheck                 PASS      243.83 seconds
CheckValgrind                 PASS      295.50 seconds
CheckSmatch                   PASS      352.02 seconds
bluezmakeextell               PASS      182.38 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1033.83 seconds

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


--===============3905429876575296134==--

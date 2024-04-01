Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369E54FA5
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007740; cv=none; b=BIP9mYhnOHto7+pIKj3st6quArw7Rl2fRSq8Qpy+rZLmdMwb1b4WSz4nry23SCc8NTTFpI25ZzICkav4s4pHDFbcl2psKdUio9UOnXR55I/y1BMtdLDyedcQiRiTY98MtOdWcdp6kjZaU19g+8WRNOJ+ccrud4X8nQ008NR9ULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007740; c=relaxed/simple;
	bh=M2+cPVXgEUFqgtDfvXiW5gRFA7TZySFWUVoJsSfc/WQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tq8WR8oQd9RuV9nxg71JZl6TQUpT3S6NE6a0TTmGWAZot82yb5ck3F233j0R/JoK7oAprjMPJqZmTINqjoMWVq2iW7u3zLPCMLORncz15t0r2B4zrXTXuaPZMu7TSG2PICvF3jnLymjX1x7ZS61G1dQ11SZdPA7jaNzPAquXZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NduHMn7/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NduHMn7/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e709e0c123so3880871b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712007738; x=1712612538; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SzMmbGn0WZ0hKUx7YMHy3JiZnyPyDchr/KEuFg+PxpU=;
        b=NduHMn7/emln8EBmXm2vS5AotaQCA+z5qZCEVqubAZq33Ro528il6MXgG4DuNeNKON
         V7QgjizRKarpMo+ZnwnkZMYj0gyx/qop94u01AE3BsquTUMqMh1b+emawEsZgdjiDRyh
         g8EugjM+Soehh/YFjWbgJU6eHwsUuV8rvm1IT7HVDUc3r1bH7/kprwcSIzMabQpCRva1
         PDrk/i9tPvwTTVpmIcawB8ZmhJmI4pC6oD2RIc71AhGzCbGRuC1h/RLtEmkVdgHPdUE8
         W7eiN4O1OFfLTn7YJ9rjUbZ1KYcT5TU/MNRFduelR/iEKBKRqhFc6vPucFRFZ7N0ep/L
         6zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712007738; x=1712612538;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzMmbGn0WZ0hKUx7YMHy3JiZnyPyDchr/KEuFg+PxpU=;
        b=sfxWwM8sJ1hBARO5NAYFREN1TNE/TJ7+r5TC3HmJ0vwAK959fCacQ5L3RWpvHdWg5o
         y24AK8m0M58t9OAZNoWO8GXBmuVNKlh2QDkaLd13egVLmZrnaFzhqvuaM8JzS+1nxN9S
         mCGgD/whnzfh7zBiAYEoChoep09fL3gXzYv48EPpTa3EoRg8OKZa90JemiOxkQeVH9Q1
         GjYHSW8dKdkzt8nZwxS8ApnIr9dUyLFem6x+KYnicC2dd+8aD84a9JOLeg1fxL8+ZMvM
         k5FDYJ2zJOA9/yAFI4eCGq7gE6T3VBM9rrh8YPleUpQVuxQYgVlhAyiON3DAS2rtvjr7
         swtA==
X-Gm-Message-State: AOJu0YxVDgLqqxWq252eONCsKiSalDj8Q9fgzXcGPTtslE0PqpHitNi5
	hiX9UjSN+gEtNWmILQ/EYEIL3S+51qYZSn7XitV9hw/rW2A96dgnElWB1JEV
X-Google-Smtp-Source: AGHT+IGznHDRVTv2xW4cBOxGsycbfHl7lBuBhnaS2Eo4XJGLgRYlYvO8sKKB8RksE/xH1gKWgK6XNw==
X-Received: by 2002:a05:6a20:d90c:b0:1a3:be68:e82b with SMTP id jd12-20020a056a20d90c00b001a3be68e82bmr10960716pzb.45.1712007738523;
        Mon, 01 Apr 2024 14:42:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.1.140])
        by smtp.gmail.com with ESMTPSA id on4-20020a17090b1d0400b002a0777a2b1asm8181915pjb.10.2024.04.01.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:42:18 -0700 (PDT)
Message-ID: <660b2a3a.170a0220.a7b2c.4bb4@mx.google.com>
Date: Mon, 01 Apr 2024 14:42:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1904730032573393126=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/3] input/device: Fix not handling IdleTimeout when uhid is in use
In-Reply-To: <20240401185808.2520694-1-luiz.dentz@gmail.com>
References: <20240401185808.2520694-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1904730032573393126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840335

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      25.58 seconds
BluezMake                     PASS      1883.06 seconds
MakeCheck                     PASS      13.83 seconds
MakeDistcheck                 PASS      188.00 seconds
CheckValgrind                 PASS      260.24 seconds
CheckSmatch                   PASS      370.62 seconds
bluezmakeextell               PASS      126.41 seconds
IncrementalBuild              PASS      5072.22 seconds
ScanBuild                     PASS      1092.23 seconds



---
Regards,
Linux Bluetooth


--===============1904730032573393126==--

Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F363594A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754627435; cv=none; b=lRAuN1CjEX0/dR45Ecdw0xiabX8Cu/7XnVGbAf4vXcQanfx87OXFCgb9lF6bzUSWbyonz/a3xm2nNkVL1hlJwyP/TTqAeRU6mdLeFmD1oSYtzazpmW6cLyl269s1n++Nk4EukhYfbj/p/sRZnSDCBwXtptz5Rmu4m5xpCy3CqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754627435; c=relaxed/simple;
	bh=t6tPuq+Ij1u9VhC07t0kl6oNKdWvMdgk8KH9QDNnh4Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XTiELdHCFpbWGhTMAi877T3JSv+ApWYP1VApZQ5p/FXtPOV/Kty2GrF8e4zEKnNTlwJRU51urGN8b6TUaLLlXY34adNZi8pmMGtuibutS8jKp76tJSg7DGN+m4zy/QVLRdlgGiBg0towklqXe17IAXTxvSIlHnPojXMeI0V0OoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD+TAzZ5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD+TAzZ5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e806613af8so210218685a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Aug 2025 21:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754627433; x=1755232233; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kBDFcx+qUrDfaCfZt3+PvfpznstBwVOcuAaerqUnGGk=;
        b=dD+TAzZ5LA+o2SPpHEpFozY0JNm+9SNgZFwHbVTg9QIE/2ef/zZs5MK5cs0N6lCn2P
         Kquq+hW9tp0mtNZPSyye92ZkUrXMaNTpigmzopU2ShCpCGK3oztcHm+Y1QuFVhROMmGr
         JaFNDOEwBaNQH/OTVGIN1kP9zS3NQAdUip8VMu60/FVAnvLXaMB4uVu9d9dTswS8S7Tp
         3+P0xmqSXI22UKBmxCiWySZ9AtsMe0VpOpLZNZntWo+TAJEqS6KJDVQ+TFYzCstRxqRy
         34SdxpFDPg3rimibzGPzc968bXz0JZm3MiI/Y6RJ2Gy8u32k9HLVAD07kO/tHe0AiVA5
         FqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754627433; x=1755232233;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBDFcx+qUrDfaCfZt3+PvfpznstBwVOcuAaerqUnGGk=;
        b=DFcIUeoGKGA9sKMC+VIRF+YIaMkX58tPiVNjy+00pIy1Vy+WOPeRlpCAk/BNEAhqWH
         N2iLKAwP2Abb/Uk/kAvsVYYSlZDp5bbw9xMQc5L/GzappQjh8FmznW1Ssmd1DrhuW2n6
         rU1mL6JSFV5HALwJlHA0whk3nOgFpOcdYSZTS8V9EWuhjrciABYgaWubxUO22B71rlru
         KxvxIY5wOprRPP0aYD0//6VM6o2GzfzDjgxCUnNmjWV1YLxsREwDGvlyO5BscwKNnmLy
         ZBNmtMKYh9p8Mhg2TcD+iqM8n2h9TBoEKMzVq55NjneBztFt+H4NU8R3sTcZfOAvqTwO
         KKIA==
X-Gm-Message-State: AOJu0YyvjfwFaNAEgFqG99Af3BDLOAuVCbKvTIiO5n/QUKi/AZX0dzre
	6HTPUmH9KlY5R29b7bFWv1czElsoBPlKunh+SkgdMuZac0v82R/QJ9G2ExaePg==
X-Gm-Gg: ASbGncuRop3U8rSFSDfPWXZhWgVAw0xBCHyFX5yxDvqTVVN7k4RLZW6Vv7pFDtZXgS1
	LhMSKhbxZD4WEb+2YYuRDculuS/jFqSJw+pzGQr6N7Xm1zAwyfGS4/j8ZaQ6OihYMGh4oNAQYcB
	7oRnmRHHQ9yCPN6FZBDZUUXo8DbOsVGAfISZySPIy9y3Q0LKHVMwFYBBA8gtM0Bk7S7xOp7XO/I
	j8l/voyfHyH18DVb8Ypcqvl47QcQJgallgemN50sPo+72fLGMytCl10M46r2zSyJRjcvuD3y+6d
	1aTT6YARiMrSYdg8OkIX5csKK6xqjTCV14A7EP2Y5H4oHvz/ddgQ8iDnePI/cV0KQent3/uMBE0
	3lPE0rFx1DUn1IhJbOG2h7AKdOW9sqm0EkQy3tw==
X-Google-Smtp-Source: AGHT+IGwBSXhtJzqKRFxHRBtOvqSziisFGDhNiZ+QVIqC/lHq2AwMEbfBiFJWFSQ971VNpH7s/Sw4Q==
X-Received: by 2002:a05:620a:191c:b0:7e8:770:5a0d with SMTP id af79cd13be357-7e82c72591cmr211106685a.37.1754627432362;
        Thu, 07 Aug 2025 21:30:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80b869d4bsm491446785a.24.2025.08.07.21.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 21:30:31 -0700 (PDT)
Message-ID: <68957d67.050a0220.2b9fad.3ead@mx.google.com>
Date: Thu, 07 Aug 2025 21:30:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1464486977287847814=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ochang@google.com
Subject: RE: Fixed a buffer overflow found by OSS-Fuzz.
In-Reply-To: <20250808013402.548986-2-ochang@google.com>
References: <20250808013402.548986-2-ochang@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1464486977287847814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989263

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.16 seconds
BluezMake                     PASS      2672.13 seconds
MakeCheck                     PASS      20.50 seconds
MakeDistcheck                 PASS      189.00 seconds
CheckValgrind                 PASS      235.94 seconds
CheckSmatch                   PASS      307.17 seconds
bluezmakeextell               PASS      128.65 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      906.31 seconds

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


--===============1464486977287847814==--

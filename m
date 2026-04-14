Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939F30B529
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194097; cv=none; b=bKN00WM0Z9mFAfBC+RiZTrWbvGsGkzK84GFJ8hcY64jWFaDQIeX6iqnQFGBTZezuhtnDSuR8SZLULOWtBRpcuXOD6/0otUmypqDyeUkVTWb1PbhfzLV52x9fGujagDHj36zasB6XrDeVUn68Oer7vUaQPuTsS6QAtemvHLyVFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194097; c=relaxed/simple;
	bh=F/sSngmrvzNFF1n4XGMoWI9ufNSMFkyWtK01IeaSWfU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HTM9aSwdFNhQwmLvcBzfp+A1h0vjYJ7+JQejtpQI6q5lKkFUbJuS2BoeQFai/IF9oKn+aeeHmmbP8ntaFjOBujoG2UrLYw5qNr3q4HlO4jC0DD8Ouy4huaNEuyeFZ6W13ho+WHhnSsFJmNKUN2HLiS2XpbSzj0W6dIp14t9XZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FupzVHGK; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FupzVHGK"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-471618e202bso1523047b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194095; x=1776798895; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/sSngmrvzNFF1n4XGMoWI9ufNSMFkyWtK01IeaSWfU=;
        b=FupzVHGKNFJ8S2KT+O4GYvxiPGYnFMR+vusEJ9HrvayCsZUTYFLWRrXaTvvqLGiwHY
         lXmh/UQmuIdTSS2sbXoKWk0b6hbXllUljbrJbf4CwaAIdL5esXdBJH7OcHJ/dSp+ZT/R
         F34eZizVCcMVu+qrS9fEUCduAayS5wGJ5dp52xcQxiXp3+MvyXk7Xp6ZHkHHkwLJwLY3
         hivXoRep93B/B1NEkOs4RUJo58Y+8kIqLjSVPCTK9rgux66CNOUFv5bGjH4ODW7AiqJp
         hiPWleX3eX5t9fVEYrengd6lBlONiv8CBOfdstUdFM2dwKhbz/sS6/FB4SheZzxX8TGz
         MPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194095; x=1776798895;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/sSngmrvzNFF1n4XGMoWI9ufNSMFkyWtK01IeaSWfU=;
        b=R4kWVNo+P/UHMJTSEdRFiHHeGR26PRvgwz5anu10CDTRGfTtt2z0nmqddcDhRek/CW
         yGk6B2/uqqug6aDCkYZsf/OBLXy+xiuYRzSYI5ExkSvxaDJM34na0Mt/WD4HxgpRu0qf
         fJDx0Krhx15SdjaaFkm2fBgkDy1IvsPNiv2oKjEFK9CRZFZMMd+igAwq3viC0XKlJ1aE
         SMn2hZ8tGhzlxAI5j4jWx5xMRmRhzl2ZNno3t0KASTdjhBMeTe4QP6i116B+EIjOxlxN
         mSXHwP7bo2tp2fmV1lpkYIVCBF8DK05rz3DfY17Nd4RULkTkIq0Sujn/6EupOkdUyhJo
         WZrA==
X-Gm-Message-State: AOJu0YzQeTUOLEKAOE4tqNKG9tKIFKMKFmhaTT4ULdtAYds2rY+ORAdk
	geWZG7LCQhbMl/kwz+crtIgdr2VhuhEEsaxUNqZo6dxO7mtL/0EzIzOTIkidFA==
X-Gm-Gg: AeBDieuVRRktKrzqvNehD1Datfda38aZfu6F7EHpmfDaAeZ6ljPQb5m1RMB8OdlK+7k
	j7+egOXvr8sfYl+Hmf6VNDutMNFpNMqcostN8pbZ7MdMPv0dMIVydYS1p7+eFgaBFWAriKnD6Xh
	SuNY1nL0OkrtCWzPz0f/aBZKvuPUaBkM0ps0xaOskKgGxaKj/oA1Gr8sBQr08MH4m9OXGBOdyYV
	pL59qZgVk4BZmC3qTAJpYbn86XytfmQ6PAVv/g6zyDGB9+AlCV76hg/fFu2INqDfVTjy5jE30QI
	EWFSnpl7X/GlzRhauavSbpP4IyvuByW0rs+2lWaKnfEmE6NBnyCSDeyOVSVhsQzbDYoIY51zhdH
	+5WRpiGvvk2vL8lI12N0T/DWRt1frtisxek3A9jrtlzAhFiVWQMX9taQZhuU546x1Uo5kgEyopG
	QdOG2IOagFFZHT3+AM8r83Re3dXCcSSMkKz5nUTY908A==
X-Received: by 2002:a54:4e95:0:b0:46c:cdf4:1be4 with SMTP id 5614622812f47-4789c6459c7mr6757177b6e.10.1776194094770;
        Tue, 14 Apr 2026 12:14:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.100.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb80ccesm11385156fac.13.2026.04.14.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:14:54 -0700 (PDT)
Message-ID: <69de922e.050a0220.13e50a.95f4@mx.google.com>
Date: Tue, 14 Apr 2026 12:14:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0340634323972204081=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bass: Fix crashing on BT_BASS_MOD_SRC
In-Reply-To: <20260414161611.67225-1-luiz.dentz@gmail.com>
References: <20260414161611.67225-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0340634323972204081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/bass.c:1865
error: profiles/audio/bass.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0340634323972204081==--

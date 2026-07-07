Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD63E557C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456618; cv=none; b=QYtPwRzjWZjIJHzdKf1/Mlv1buFJ3xREAugmJHntKVlL2TgcDxCcKdJeqslRamdDfHbAy3ou0FzEC8e+fbm+qpMQYkgNdWQ/o1p9OG/thJULQqFHL/KZFtKF9gXlttez8y2eEaSK2bVSkR9PZ2Wlg4N+8zCChu54dqCbMMO4STk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456618; c=relaxed/simple;
	bh=39P9ZQaoihtqzL/z8uGjvyJwLIjBvJU9EgAmNyz8tb4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lwlvFKgL+81gevtZ/87IoudAmFpRkqNszBTZa0ZJRVX3qaSrROO6IitQEVG3X3b5gbdBRhdzpXe+3E3EIJrrFRfL9VLsdSf2wkYoTqQPM8KmVcLXCXOu1v+/VuJZmvgPl6Ejk4kCSJC2N0hVGy9XfKf09KZypMNlWmlg4vgCe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN768wgt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN768wgt"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9204711e831so394287085a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783456616; x=1784061416; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gwJxUfMx3dHjOBAYaD1JqzCu1qpniqaSsKb4kzfXz1o=;
        b=aN768wgtrPL4lnLw4QDNiai1Ml4Q5k4NOY48E5fIH/Do0hmZkjc8sYdWrmfQz/YMVg
         2XEllolm2OxqdUWwkQjLtKAysrbvGebg9ys43spQz778uoBmNBf9d7EgxEpXZfIV32/b
         APdlKtEmPqB7im2t8GiK4kW7sWIPU1g8HQY5+K3ns20k9XHXKl+sqOQyArkFgkxe2ym6
         mYqAQby7qm6WeTupoGfq8JQ38zFuAyKUaR3x212VvfR9iiYY0q1aAOOGp7tnKGeBq8yi
         R7wDOj0GkCwEtEIgD86sw4TzB3jlk2IJnAAIMgruAnHYbanqOUeqC1LkC/990q/QlzYx
         1BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456616; x=1784061416;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gwJxUfMx3dHjOBAYaD1JqzCu1qpniqaSsKb4kzfXz1o=;
        b=FbwVK93xHc7+pB/fOb69M+jcbcaaz6qqlHKmWfltorg6aAuOFIYVtATOz4WcZUP71y
         xkseKGLsvKCYEArmzqApJNUOXascTh17m/rOh6cANdWSSoKQJNRL19zFo1D4kKSKm0GX
         +9LGuAZU2UP6LfTL8rXEXoy8jeUBvZfQ4OBGiHQqGm2gqJnszDqrgTI4RM3r/RUY0w4f
         Ssgsx4zbcTChw5iWx1koDnbuvFsz2lCk2RH5RLAlIwvYPqzyA5Zp6NQ4iOp84KFy+DU9
         GAL52Yy9jpxVFBAVEhbikam4kFZwplPVXN7yHF9Z6u7of+LKDiRRVmb6kefDFSUEna2j
         V1uQ==
X-Gm-Message-State: AOJu0YwaiRcu2wrK+I97ilnFFVK04SjpbBYuh4BqDJTe9XWkzUjFm9Gi
	Z7WaLKFiCWzyIUQ8Mseb8WNmBhv7IFNg7aM1wKTTWh4yzF8+Rh4fnEdMS//a9A==
X-Gm-Gg: AfdE7ckMLAL/YKwmdAgX2qiHimjcyTpxSqM6DN5ScbOfPGXt1GxtQVimy2u0NnEbRfE
	Ypepq5FMHqgwhHTnG/YpKBg172PqPa2+qy4BmwJQdSBqNjKyMLl6Cf4m0+zYrboUZ+RM0NI1Pp4
	YgwRWz9KKAcnhQ6jXvaKGCpiaQaWKkuf8qzvC3aD6jTSs8dyAq4qWa2G2nm5ypl2blhdHznG4Mq
	2PyfGDDJAZJ2Ti7GR4n0Mb2yrDJKR1SO4YKm9qbexVtrcMSko3u44jnol3t/BRBAN560PBkRQpY
	n+Ah3Sh29qtcGk1O5I9Hem6ncOod8T1RUN+KjUkqLGgt5qZwcmrHwQ3MkKNRY8A1Bm3rD8Kq3mZ
	Fn0XIZcehM1OKt/W4r2usU8p3kpY91kymP2ahBgs79h9tse6xn8F0RJiMWIIBdzxnb5lH4g3y6m
	4Ee7/IAwuJK/iChwkVzc81yQ==
X-Received: by 2002:a05:620a:4086:b0:92e:7d1f:d3aa with SMTP id af79cd13be357-92ebb500799mr863165085a.31.1783456616034;
        Tue, 07 Jul 2026 13:36:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.157.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90c926ebsm1270780885a.31.2026.07.07.13.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:36:55 -0700 (PDT)
Message-ID: <6a4d6367.6f91ca5b.592b7.18d9@mx.google.com>
Date: Tue, 07 Jul 2026 13:36:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5968535063975240103=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Use util_ltv_foreach to process metadata
In-Reply-To: <20260707183944.1215551-1-luiz.dentz@gmail.com>
References: <20260707183944.1215551-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5968535063975240103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1123298

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.12 seconds
BluezMake                     PASS      503.93 seconds
MakeCheck                     PASS      12.82 seconds
MakeDistcheck                 PASS      152.61 seconds
CheckValgrind                 PASS      200.09 seconds
CheckSmatch                   WARNING   293.70 seconds
bluezmakeextell               PASS      94.10 seconds
IncrementalBuild              PASS      521.50 seconds
ScanBuild                     PASS      866.97 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2279

---
Regards,
Linux Bluetooth


--===============5968535063975240103==--

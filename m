Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC33876C1
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207309; cv=none; b=Fr1TkaDNKfSibybxO8lkW1xw5Mu6XQZRx6WRbU7HIdEjGrh539OSGFQOre5tobytkYNKKjFEJRqU2DTP+43DlTEjXhIesEgpY1nvOHCTsz+NYHKvzXjU5qV1MNDs7DtPEJWzd0EWSbOyTOGLYXhwAqdMEcSOkRUXaq85qmaIgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207309; c=relaxed/simple;
	bh=mIW7v9gDEhqJxRZLYltYPyztv8dvW/2Tqz1g3PnlmHc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BukByVA3+6k+DDCLSFPxyX5ghHg9cVH9CVqzSEEI0vDo7RUuXApeXX+R80Cz/gMFFMnG+sUUsWcHgoYu3VzTVdtddUfDHDIk3EH9vjPJxcuskW1B5z/tVRhxYQmScB817+0GxUnlKoFjQEYu1zJq4qJRglqQB9UaDj8B1oNJSsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfPA0YP1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfPA0YP1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cca0c5799eso15715425ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787207307; x=1787812107; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4aqqRtduBTaqMeFcuuaAkaXxtsmd+aEbWq5R5ebNq9s=;
        b=YfPA0YP1/UzGlIPgOn/oOsZ3orzY/lRbO+jNNpZxfRaWUY9t671EgT7jPrmA9JmeAK
         GX9Pw7hdv5MwFRqx7nF1e6NTFksgsG/ZlTEJJmUkeN8tAyYDcZZu3zTEPzQq+kyBahSx
         QzgoEAaZhD+6DVXAi66O6pdkwHc8AWcflvJsj4LvtOx3sbXnqRn/BYPEzJd448SN4lTv
         aXzCk7+gzrw4kTUW5YGe/mUi6DI16N2qsPFA1Iw4e18LXDDekyfxSfXEL+J5R5FiXjD1
         aOmPO/mRZ+iaBW0zTMsi2hpJ64QftwZzUgAmCbWt9caQiLDsguX3XUM5Xs5nyiqbLmIZ
         wmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787207307; x=1787812107;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4aqqRtduBTaqMeFcuuaAkaXxtsmd+aEbWq5R5ebNq9s=;
        b=QoQWG5p4/hkKpVv6qzO0xAuR+Vax56R3RBAlfh/Br98lQTeGHa3XRO5Xb/RkkjWCHo
         /1nNBV/qzDtoU7KC9ezSYVkhv5PMxn8x+5qOC/S0jAeF7RiH0uxeobZ6DtWH5AbQZPH8
         8RY56ttwAf2WdUww6Xrfdd/s3KCziZauiUIGNXcVztntDIeCTigJCrhzQcpEEFt8FsVQ
         Zqt8woIUH01k5RvtN6FfN1jKI4zpI3kgKngdVyvazM9a1Pzo3zhTjP5kCV8+AZM1FL25
         5W1sSxitRaKV9HLtPl4uy0dFovQi4Xb1zRZ+6qXYxsAqs72O2Ttn0lO6E6X2zygnSkdZ
         Y+sw==
X-Gm-Message-State: AFuF++lwOjg63eMJimK/zEX6SsPQMDbrlCEdrFXUUhesACHRgClyxc3v
	0mHxLcoHfglGoypI9WrVUcafaSSmdGaheM49PK01GBw1zWaUKzwtQ5vJGOtebw==
X-Gm-Gg: AR+sD12LAwCbv1kUaJCAeJToGipaHFBNwtnIccU+EtSSDZsv3U6NTwGoEa5/Axg7clM
	ybdVXI7VbfWxnebJuc6OBu/e/DVFWey3jHBbC8cWqIpFPG3zj4MXDYM7J7oGYvU27m5fhh03VkZ
	+nubvTXv/E+som6/PW/ZTxqPIdvqsm9c6D5CZfohfu5Q6sv0gMHtENI+WKL/edm1Bhip6nnQFtz
	dJ8r0h6wYwm+CbvhBUMRiBOpjeT8Xx+qSG5AbGECQfPej9Nwt84rhnrBOlBINpoVsxrFbGeQ74M
	6HSfWIhn8KNlUiH3cs1LFyPDvqxKexfVzwIQ4yAdwLWpHoGEtkks0PTADq9safFdjdDS4bSFI1G
	Es8DqCnY8YscLu3yRZZqWGw7PgY503cJWLrMFiDbNaqy3Ndu/+REuKA0wFMLASlA/PZ5SSLaS8q
	Xey9b7FGQFJt61crCK3q83L2iwUBRK5TYNRTh7NPwi/mKitBECsYY8pf6ejgtJbe5oWA==
X-Received: by 2002:a17:90b:55c6:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-395813f758amr20160261a91.11.1787207307247;
        Wed, 19 Aug 2026 23:28:27 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.193.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c3fc6675sm18616986eec.13.2026.08.19.23.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:28:26 -0700 (PDT)
Message-ID: <6a869e8a.3865fcc3.3a8777.0dc5@mx.google.com>
Date: Wed, 19 Aug 2026 23:28:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6798762950975646796=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lijun01@kylinos.cn
Subject: RE: [v5] Bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
In-Reply-To: <20260820055003.1204188-1-lijun01@kylinos.cn>
References: <20260820055003.1204188-1-lijun01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6798762950975646796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148824

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.74 seconds
BuildKernel                   PASS      20.38 seconds
CheckAllWarning               PASS      22.64 seconds
CheckSparse                   PASS      22.04 seconds
BuildKernel32                 PASS      19.68 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      365.46 seconds
IncrementalBuild              PASS      19.02 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/622

---
Regards,
Linux Bluetooth


--===============6798762950975646796==--

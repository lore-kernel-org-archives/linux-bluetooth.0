Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41171A01BE
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013251; cv=none; b=KM6+kXo+Y98DuVqY9Z2N0YWeXvLWWhDJYBPX23pzQJnngBUrUm6tNBg2Pw60iF2pMqX1cx+oiA4KFZjuZJGZJ1Dw2eBYrWk99yD9dJscMmUNMdUAUvY3Y50DksWCs0I5Vzd5PlJ12H/akrG7WnQOzr+WiBRbEZ0HOZ+Ryqk5DEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013251; c=relaxed/simple;
	bh=QA6Z7tIx9OjTcdbpr0MapswEAVgA9eQ4eylzgq7lESQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RVNzKFbdvQmWVT0HCY/f+8QRiU07KOsva3056shgYAfYWG/ql3I3oCpOivfHDAtGIAlbVc3OfkgiQwNKP8XUFDC2Nq5CKCubIRoTwVD9yoSjPazaN/MsJrLjIRcfQVB4D3Dn6UdKJm3twJCHmL4moaZjC4mFiWN1Cayp0M5rN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ossb9YwR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ossb9YwR"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6c4a867cso94053085a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785013249; x=1785618049; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kx4BTdkdcHx6bwj5Bl5i++tcRcRRZpnPYtnXgyorsb8=;
        b=Ossb9YwRPvehevPrebKN3LAu6Zgxq5KLONeBv8F/ZyCl8gaaVhai4qsnJHAHTWhwNR
         1C3rQSq6OqdA0FXOSqJOCPJGfHaBJ1h3n25g9Ls57/BTc7oDbEA3KxAqsaIrJLcOVb61
         3GfpOemV4dODDJiYJwWeHEcI/1H2Z2cMkLj36j36SKcwYMLHN6mvtEEiiMnyWUmCLmKo
         ty3yR3umtaUmKkxTpVoz1E5FAWmAbUtXWwryFUl+fEeN4cX2efAaR7YSjZZ0BA30Zj1Q
         YLnpvPj9Vzt3128ba0JXFW4X1SzfePh4JScsJ8RMlUtQBekKZFhEjSTcJ/YPRJNf/Yp4
         wDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785013249; x=1785618049;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kx4BTdkdcHx6bwj5Bl5i++tcRcRRZpnPYtnXgyorsb8=;
        b=n6lkK02cnDefFZ3tZkNYBob6NpJpw75dhdPT6U8hAlvyeFVHr4e8+nZ7EEuoCodrBC
         6sQODmimkEPb3QD/RMzDx+tBkidV7p81A2clHqyS08Jdk+7zno4aGmlLW/DcNpB6jaHg
         y1p27CBQ0ccxYd0VFQ16DE+y2LtP1nxS1s5VhPugLB8twcn2vcYtOat+a4z00SN/y4Uh
         g3lC/dmLIlvWZDp887UqM7Rxu81EjlPWpv63W8xAMHwKhprAXnoUWxGK25bwck6BO3YV
         ID3auXumAlp+2yWU9K1+vs1k359po8UMNAaYaQQFLEsWFtQYcYc1HzwkPOduttgIFj5L
         Rwew==
X-Gm-Message-State: AOJu0YxjH11P61+T9AbGDek340DrnumxxsvysyfI/00dt26F1IL8Si7L
	gRJAE8DDkH11KTS5GptAoqv7SugwWnlR5uc8ehnD7QgMCbCogMo1ILrovyj5VA==
X-Gm-Gg: AR+sD11Dq3KwMEWsUdJHzQvP25M497pLvyzE35dHzLAW0WbtJYJd72JAt3KO9mylTan
	7w8z5lXt+bP6yE+nrhsGn2tgvWcXY0TsWbn2aoWJHpIeHHDP19tquMMv5Bi6yHOJA8Upt71iXTw
	j8BgkEOTrsXbbl8oVG2jk+kCU6mas5q3G0qVLlIzrLCAyjozMTWruOlfpKfUXpB9QgsLsRvNu4c
	z1rZd1qJNxoOnhg2DdRj3+g64aEn/Q8jBgipRgNQsAVR5nYJSBRDTNllevFtXesYYHEf66NTWSa
	DoJcvd7xjbeESO0exaPCXXRonvXuxbVqjQkE3CUncJ9JdcOVHFC+pPHzRXnzCe2yF8Am/RTIJgA
	U7kI807GYk7/Cgwrc7bE7QLo8f7z4hJyMwB0ddcme6zv9HhvsPKrmHJXcYxbwo129sCigvvV3L9
	DjBPEnrUqr
X-Received: by 2002:a05:620a:318f:b0:92e:c116:bef2 with SMTP id af79cd13be357-932df739ba3mr322262285a.79.1785013248670;
        Sat, 25 Jul 2026 14:00:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de657111sm216882485a.38.2026.07.25.14.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 14:00:48 -0700 (PDT)
Message-ID: <6a652400.3d6d24e4.23e49a.7dac@mx.google.com>
Date: Sat, 25 Jul 2026 14:00:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3060612290350984647=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: [v3] Bluetooth: SCO: give the socket its own sco_conn reference
In-Reply-To: <20260725195230.967546-1-qwe.aldo@gmail.com>
References: <20260725195230.967546-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3060612290350984647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134465

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.14 seconds
CheckAllWarning               PASS      29.74 seconds
CheckSparse                   PASS      28.33 seconds
BuildKernel32                 PASS      26.03 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.84 seconds
TestRunner_sco-tester         PASS      31.82 seconds
IncrementalBuild              PASS      26.14 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/496

---
Regards,
Linux Bluetooth


--===============3060612290350984647==--

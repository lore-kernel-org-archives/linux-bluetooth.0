Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E20318ED6
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396492; cv=none; b=XfpZNjKtGgnmUcJjGxKCe7cZK3aJx/ZXOzpSWye/TLg/4rpJsGH83OdUuoVzUB3qUDQWXcIJX7KpjvJFivkfhoe8I74BTQl/WZGa2PFeUbpJSf0qSqeSlms0QiFcP65Bz9q9yDk9iF+CfC7H70qbM3cKmgaNLZGGHBS01E7Gu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396492; c=relaxed/simple;
	bh=qu2/bST2wStT538PuAp4Ry/SiwMpOm5QpxBdZ4cib+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SPkNRJ0yFXvSvlGDqEnhVYwJDD3w2Gf9nEnKv0FiouFOv60IihoMIwUiGwqcmSKAewQVEmovNTELHOTWsCyQ3N6pfiGQx3q3G78u0vD+FVpPnW0O58BLdz/+91G+P44To/+lqeqPbf8tZNqWdlKe2qq/O5N/zd449W9xnjFCWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgwiTOXR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgwiTOXR"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9125284a8ecso759984685a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779396490; x=1780001290; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HyO522CKjnX6xuUFIaLsHwG6vNtJ55WI05pg0CrkMho=;
        b=PgwiTOXRrTHh8q7a9dwlPfcStI9OGkf3y9ZSI5G7T46SWtO+xqGPoPhlx8hIacHOzU
         dsYy9njDbYN6bcxP90SBFNE30INITmOUfILit8tgbJPGf4gxb+zuHzaBFAbw+ErsF8DL
         8Tn9wJWTl08sw6X7+TSUbtdinhkM5EPx9HxqlUX6MgFWwbihKP32lVHUTlbspPwuv4XY
         +blNYwLUQxaHeGFPd9rgxH21L4qkL4A8Dld4AzkrjqLFlSl7nt50O3YT5As41thxCZN5
         UU8Wx4xEbW84ShAaEMJZbkzcvD+CyKuFigvfAv75Ylikqv9taEpZvJtCxOyam+NCGg0b
         r8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779396490; x=1780001290;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyO522CKjnX6xuUFIaLsHwG6vNtJ55WI05pg0CrkMho=;
        b=BQI7JyaoxWSRLoPAHg3fFPz4GficxwoslMVkUuq6aQcKVY0+qqzMkqXtthi+EUy26P
         Ub8fLCd0GsQJsLGArY3/mn8ctCCoy3Tb4MOKRzA/3bFI4DxD3uz53XoutavGI+iB+JCQ
         GbBxAaXTUov+K1RDMgac2+cRQLk1UMRKg6GJNsGnxv3HXW+GcP06fggWBAIHVLLkS6o2
         Uky/vq3oEChu2GwW9iHE+GGKZ52jV7gMpqI1hZ7HdVTNj+XQDQZPDIL0smFt+kWCUyBl
         QwEnWt/mrtOLyAXsmT/CRioDzinDsfwoDJ7xnImRgyslxewiUr+Ab1MrZdVmVi2LzjoA
         og6Q==
X-Gm-Message-State: AOJu0YwbbQ6CwaSkCdu1TdqranzBK2xfw9oCOc8Sd2XMfslAsfOt0W4g
	947izOAUV8TqZyuiMdqtok0jRIVtFLsGGHpvXVdJNNlI7WZhLWZq+B/0nW0xuD8I
X-Gm-Gg: Acq92OE7iTo26NSHFGAlCqITLxjbTuth3PvliJOqb1v/Nlms5T0JdD39ISuthy1hMDC
	9fOeHDz9OWrY5e7YpbEBS7pxacPz/XxvzkrANZMBguqXxuuCiOdZk514tm5J0YnfSFC71XXTMEq
	eYsCJO2cpTHfbGGxIzTd8BkprzplQ4zOpp6AIpX7UCxhwVBiKkcA/DFK7Bi2YHTM+HMa8pbpOgU
	Gh7JBgaj9rFSToOWciqZJVWkgCu6E8X0T0TCyKWSccOZ8EnaiYvzeA7llZMVnvh3nflsPNuBK6n
	3BRv60KYEUgXmr2PPtMvFgukLn7XhE6WVIkm3BqROnmeHBV7h3U+K/8BIGbX2zPBOSjtmYiDLD8
	iMe5e78EtTQCBrk5lz3AtA6yaNi82aAqsed/fZWXq0IVEFEA++ct/Kj40kewtQOY1jKLtsa+N/9
	j0sJXy3SnKtb1diiuwa4GxZ14Vo/Sc
X-Received: by 2002:a05:6214:3018:b0:8ac:b619:5ec3 with SMTP id 6a1803df08f44-8cc7b6a1d67mr16430166d6.50.1779396489979;
        Thu, 21 May 2026 13:48:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.125.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc7e3b6086sm20186d6.39.2026.05.21.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 13:48:09 -0700 (PDT)
Message-ID: <6a0f6f89.5e4003ec.2588f.073e@mx.google.com>
Date: Thu, 21 May 2026 13:48:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4322624022612108750=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
In-Reply-To: <20260521190332.3171234-1-luiz.dentz@gmail.com>
References: <20260521190332.3171234-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4322624022612108750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098993

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.91 seconds
CheckAllWarning               PASS      27.98 seconds
CheckSparse                   PASS      26.40 seconds
BuildKernel32                 PASS      24.55 seconds
TestRunnerSetup               PASS      529.10 seconds
TestRunner_l2cap-tester       PASS      59.90 seconds
IncrementalBuild              PASS      23.97 seconds



https://github.com/bluez/bluetooth-next/pull/232

---
Regards,
Linux Bluetooth


--===============4322624022612108750==--

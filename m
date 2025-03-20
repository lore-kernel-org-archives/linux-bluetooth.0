Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B823A0
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465677; cv=none; b=csmLsP22Uchh2UHAnP6rOrVoJ/7qQ415/J67TJA2EFEvwNTKfSu+u+RXIBQH+K+VAneqg3cXROp/IhSP16nPayADw+pjjl73VemR3V3pt9AL+JJ+TYnXXBpGGv4dI5QRtEpZssfJkINuS1oOcOtGyTWdKns9xpGFvgKzEZxyLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465677; c=relaxed/simple;
	bh=syUq04o6sBh3SNEWp0PvxJcbOqbLD3nQwjM0gLCBPpo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NfTiWpB7iSDsbpSi7M1ym6zX0MnuU9RDeIIAk9K2xJN8hPgyQRJfiQKyjgrlMedo6/S9DRoYu7TSZ+OU9j2Ea8CYsGxOLBc1eMEXjr20YMbzujGVaZZLcgKxA7vsyS66k9OQd3fCTt9WVfFKGRUHEAgwMQTMTTitNqXpGVCdGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qec23At0; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qec23At0"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd15d03eacso5736876d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742465675; x=1743070475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FhrRxal/RtOLd9wURhu77dx6/F5wq27w1ug9Zvi2StI=;
        b=Qec23At0qpHTufiuf9gBGSkEgkIb+GE8z0FJ8dHvrcD38/C/g/KTibPb1zF60S6V2H
         PsJXEqde5f9Ls5hyOHmw9NEJCjPRZn4AnmxWMMuWyLVfORVzZmKCrA3l/qWvjQpt6qch
         C7rryaKH72PwGTt4+d9C+1Fz8vWJuUg+p9FCdpciTZzOtR+GJlbPEjBE69zWZOPWCVHQ
         rWTliz1eKvyFiyvq5lJi3v+uQ0IJFN1fCxh8uqfeMUqFMgRrQSAzlPWua3C+TFJiXU4m
         cayUL9pbEIPFOmXcpudlr25cvOJMUY0piRKA9DFpmITtg9HFjTx2nKasOdQcaI6Yhi1I
         0/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742465675; x=1743070475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhrRxal/RtOLd9wURhu77dx6/F5wq27w1ug9Zvi2StI=;
        b=nr7lTDX3f5q6VJ0CrMKJJ0PT1KOm1aFwb1RXmJnP2CcjPh5jNqsoSLYdayvUTiTrgY
         zRwz9/et81VJamEG3iTXTOrIwaAQvx1kLZIhi4O4guJWLaGCHr2mss/Ky1F1MTB7Vuu/
         fLRlkME7F8jQi9dTMscuZfDxO/jyLaAhNu4QjFdBVnLIwUtkGsXVTHtn35kZs94R4TUL
         syArGoXPL8bccQNH3f3xK7C1+0ujCxLGxP+pWX+vuS1l77bm6kEG7VruH/0S2tD6hwY3
         oYUhLjKJzmQBu+IJb7Ls0vbkF8Wm2sxZZ1GTh/ROOz283kfLH0pIkdk2kbL1mReTPnvx
         gIKg==
X-Gm-Message-State: AOJu0YxgDCaszv9H0rBkYKbyn9B2Aai1abRg+zD+8tMv2sFBO5WKEGPB
	uOijyUgavO7AsX9bGdync+7WMloVpP+4ssl0bk20j0aa3q4u4X/95XSAgg==
X-Gm-Gg: ASbGncvalxNFejyCuzlkgW2pFcwVoNPJt2KaiNY4TnhDHLQBxv1wayHrE9C4r4NUenA
	w0UyfyxkJ7uYi44SKBri5KlZQHAnNDsF84drMQtU4fl1EhftboXuz8Iu2YP8JC3dxZyMuJxUkDX
	Qbu+EuynsBl0/c1MU02rbqEbb5Ju5J8uAh54QdCE0zPB6dVngF+xr0N/NAlQvy1N71TrSEql0sC
	OwRFdXczpaIjzvjB1c5k0rzx7/eYicH/TVi1L62uxSr8Qa9kUzQQuh6lQX3voGJIYSTRxi+33VC
	m0GYkegaiBNMaBUxNaytXt+qbTxQocW4a1bWJF7YAjVBesFdlKrCAPJgDw3hvp6L
X-Google-Smtp-Source: AGHT+IFfiKzkR/PavmmW74OmQhel9hEMTmvM8COASh4E+kZMsNaxxAK+f77ms22WiHKmpcMkYSEJ6g==
X-Received: by 2002:ad4:5c47:0:b0:6d9:ac3:e730 with SMTP id 6a1803df08f44-6eb348dfa33mr51992216d6.5.1742465674729;
        Thu, 20 Mar 2025 03:14:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209a06sm92835836d6.4.2025.03.20.03.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:14:34 -0700 (PDT)
Message-ID: <67dbea8a.050a0220.3a18b.34e4@mx.google.com>
Date: Thu, 20 Mar 2025 03:14:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0597235174577453701=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [RESEND,v1] obex: Add base implementation for get_mas_instance info and set notification filter
In-Reply-To: <20250320084356.4050233-1-quic_amisjain@quicinc.com>
References: <20250320084356.4050233-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0597235174577453701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945832

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.70 seconds
BluezMake                     PASS      1621.00 seconds
MakeCheck                     PASS      13.67 seconds
MakeDistcheck                 PASS      160.31 seconds
CheckValgrind                 PASS      218.23 seconds
CheckSmatch                   PASS      283.11 seconds
bluezmakeextell               PASS      98.17 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      877.80 seconds

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


--===============0597235174577453701==--

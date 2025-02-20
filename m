Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A781E9B35
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046314; cv=none; b=RnL7huyjRflk4RZ5TdoRM7oEEny/HQ4qoYDQiSiCxcbvF7QozdQazOjoIicHAxWDJH9VWp3jl34vN4757/kZmojNnIagZjmtNav4lHBny4gv+ym4phpWY5gztzcj/1wYmlapjvgYlpoM1L6hI260UrRF7FJd4PWJggX/J3NtQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046314; c=relaxed/simple;
	bh=lL5PbZrO/tn4suIj6CCXX2X5NgQYSFeMHHO6SjpnfAI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uaqfaJNzDEfmkQCxoSgk29FxQQKRAKc4hjFx/BbBSQi45lRx4TUOyo9sOH4qEIE5qJuTt/qYqngLrbGYQg4qE/iknVB+ALsT865BsDOAlebm+HX4WOHBxmVwFbp/1z/aBd9m/YifUXD3t5EBYvlnAeznB0a6LwnyHcBgLnbcsno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfXpoxPS; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfXpoxPS"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0a974d433so170472085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 02:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740046312; x=1740651112; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ1R85rYugPTlFjRr95q/vQFE2nPFIvzf/xgf9hreOw=;
        b=TfXpoxPSO6wBlJE8V8v28JXFN39WcM7l9nm24FNYkLAqpKP1faf4YCA4DKhfMiSGz7
         FMxxTV4KXX+U3qqx+Oub6gmlU0BHerV9DH5cdDKa+MUu2pNvKaZK/oGez4Iv2sCv6uvf
         0REA8w3zdzzFhhxulRQMHhC88p2I9jgtyV1J4yYQGBIIo+mtMge3q831LTYOHLyArmgm
         SO+h4AK32aGkECM7ts9xlKZcd2slXWpdEfZ3ajXj+wvovUWeNt/94lCRsJtPtEGwtiqT
         j2bNsOyEHON736gOB5GrKbtkUneKhVKkdYfka1YRxPl+PxF6HroT34i+4S8FeFcaoUav
         rfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046312; x=1740651112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZ1R85rYugPTlFjRr95q/vQFE2nPFIvzf/xgf9hreOw=;
        b=wodRh79lQTEMIYlnV5X+qu2neiyfO9Sh+Up8kjGTxL7DDMoT2uGpzCYvpEX+/XqS8K
         dVJw83anBv7rCVIRn6e4lHMruIbKz+9xHxJ4fX+YUDsdCpkeKhZWcGsrrAhjDhonyeuk
         nJTXo8CAOq9C+EI1Eedb47aUZI8HR3ifpYborg41ZIk+x58i3fLVU8PEZQIS0gb2WkyP
         JH3Uz73sLiD1yd9NYUkgQTr5QZaRy8nVPKKEjqndyfXCDidI/ll7XP46+M2l43Lk5u9a
         m9mMADfBsYXJeJZ7hbC/I969n/H2r/PXXwR2MuUYq0oNtE3y9QbPr0h8dPhoh96g0Uro
         jZ4A==
X-Gm-Message-State: AOJu0YylD2LVuRHP7lz7AaFHTLVcKCE7GJLceZmL41q8TGssVoMnm4bT
	8ICT4h0SYrNlXtMy7eSDAibAaDO93SuNOMjGiA6dRLqEosgvKLzysfqtbQ==
X-Gm-Gg: ASbGncur7mxfPM2ZejxtTbgzjKhPDWOHpHg9st9AsFDYy7w3T6Jc+Rof+Sy56PLxljq
	zTUbjVav36rk25FPiiRq2KAs/4OUodU5LAphk7AP1me7b+vTxzGFkXLChod3AgXBNQbP+VgSvAR
	Prvz/xC/xleMH4V07H8cjMrGZnI6J3YCeHwgrUKIDIJRjyKHOikoiudYXlKgtMEjgBn4tL8P7eT
	YvoHP4F6T/rxhnGEv2Sodjs+Li9ymrxO7Tm3Yjk2un/xjWE4A9xDr8MnZmHEblvKGBlKqPKvMXr
	uhGOYIOfuHPUYdJe0uWc
X-Google-Smtp-Source: AGHT+IGbisFvJlG7nsPfCIALKaAwqxz/yNBSrysAsxSLufiINtwTEhGNiG2BhriVmk3Aviz6nfltGA==
X-Received: by 2002:a05:620a:2985:b0:7b1:44ee:644d with SMTP id af79cd13be357-7c0c21902c7mr353280385a.10.1740046311898;
        Thu, 20 Feb 2025 02:11:51 -0800 (PST)
Received: from [172.17.0.2] ([20.57.47.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7864c3sm84177246d6.49.2025.02.20.02.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:11:51 -0800 (PST)
Message-ID: <67b6ffe7.d40a0220.58089.2170@mx.google.com>
Date: Thu, 20 Feb 2025 02:11:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9164573358043967484=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bap: Update bt_bap user data handling
In-Reply-To: <20250220085811.5033-2-iulia.tanasescu@nxp.com>
References: <20250220085811.5033-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9164573358043967484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935909

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.18 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      1530.47 seconds
MakeCheck                     PASS      13.76 seconds
MakeDistcheck                 PASS      159.59 seconds
CheckValgrind                 PASS      222.09 seconds
CheckSmatch                   PASS      286.40 seconds
bluezmakeextell               PASS      98.96 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      877.71 seconds

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


--===============9164573358043967484==--

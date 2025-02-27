Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F0270054
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685175; cv=none; b=BNLKCubdxkb2hPqM9q09avzGBL6tixSeNN8ZVePd91od+o5rhuSr7t6AeBe23gdNrM3V44jDMcE6eW00X1wzWkMRDxp9eU1KcSGcsZQhQDGGe2JSBJRn4jk1PI4YwwldTEfWs1Y4oLx85bHGRs2XpcceETZt0eEsYTD9h8A80gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685175; c=relaxed/simple;
	bh=hCNwYq7w7/yi664C51hVHArtPGbqCgY7J5AZJnYjnwA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tNDOOVd1kPYYIC1beAU5bq2Lpynq2zV0lejNMPh65yjQ0Hq+ACC1aFugFRJTBwYMUuowkLNqsUUWZOq7ExgS58f0p4om/zs4whwWg0lCxRe3rkeagioNas8l4k5Giq/2+EBB3GtBftEdlYHrLI7KecJa4MNH80gPee0utM+L4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6D/KvoD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6D/KvoD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234bec7192so36128355ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 11:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740685173; x=1741289973; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sXtEH0Eq/qdgQdERl112qVB8db4XbZHryZ5jpUpqU3Q=;
        b=U6D/KvoD1mFdcwAKOkL4XKXQNXcqv2Rhn9FzghAOoBsFlQoyPa6tPzgeeledJSMD5M
         KLWFTUQ/PwaN9oub0qrZxTrHm05+iInDGK1Q5ibQyw6u+2VD4yrjD0WTrZP7MlnKrvwX
         BLvmXVLKOGTlwUrq0006MoRIC1/95eB0as5L5XwcRoTxddXw0yAYCJG+7PvMOMigOxoa
         jQdOPdzjLXXGTHomYsRVEOYXxhoz95929/LG2OrVW0HrbjakEw7IHADyrqdBqIsZej+k
         B0473UEpLo+bgk/pkoCFUNMOInDW45DZC3OdzWuXwUaScT8UuweMBDTNsSK1sTHgfbKh
         HWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740685173; x=1741289973;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXtEH0Eq/qdgQdERl112qVB8db4XbZHryZ5jpUpqU3Q=;
        b=gDG6jZZPHCbkEHfRP+9vJjK9YAGeQMw7qVjn3HDgwfF4ayTPGBgAgFlIyKxytGZ0ir
         MwYC59vwABKadu29G8vDzj/wpYtSPZ7lXoBld3WNel0SD1bbva5scIY2tR4lMvYWAM6N
         1B/mjWyCT7MMG+TuGoFjAQWpNDTg4DfZuHf+Baem4Ig91TrIFJLP9W4c+pzeC8ilAFqc
         WcswCFDsVlH0HHOLNsZIMklEg5qUo5UseBRN/OTaii/Plj8Duyo6F3Vuh512iMDG3ISV
         tmCNWaFNFrbSdnSxv/F7nbM+wsbuovVpcivF5kUtabnYh3F0ph0sOME9f/TkofXZBY7t
         zH8A==
X-Gm-Message-State: AOJu0YwDP3AE9qc5iqg0f20zBEPbdbwvuW1BLrdjP33t2bzQqi+qF8Cq
	0+QJ73eHAbcyrrdmnrBJvklq+As85Ytdn3jeg4BOVJJH6HHctIwByQeATFgu
X-Gm-Gg: ASbGnctcpuIlTgoaKV6gK8EwC/OVgZmEAFew3hmIuyZ2Y1z9wFutSiQAC/yq3EyG3YM
	FWv0ddEfKO5XF5Ut9X0YyBFsqLpIqV9GA09ikmMM149PhUAWiIqUt1oaYVWaoU1sYOEhKpQWGmB
	/6oPI0B785msDRc+c1hGHxTvaRWr1MwMnILVVJUflyrIOxwfyXpZ4eCyBtkhE0p3oaWfjjS2CPR
	kYom5LLg2vshdtWkUidl0mdjfcvPS8zebTYn8b89K0LOmzEVd2PtC1cp8lvClCDAU52EXt/Cm5N
	Ks0HeXri2nt/AF3HU80Ehvedtrmk4Lc=
X-Google-Smtp-Source: AGHT+IE0oKnDF2nIbB4qXbubFuFX9lsqBMOj1rBTMSbAoV8RSzEqBT9LP9BBm97Fa0nMcH97dGVCKA==
X-Received: by 2002:a17:903:32cf:b0:223:377f:9795 with SMTP id d9443c01a7336-22368ac3345mr8796315ad.0.1740685173447;
        Thu, 27 Feb 2025 11:39:33 -0800 (PST)
Received: from [172.17.0.2] ([52.234.5.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a005e667sm2045198b3a.157.2025.02.27.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:39:33 -0800 (PST)
Message-ID: <67c0bf75.050a0220.1a7c84.3ae3@mx.google.com>
Date: Thu, 27 Feb 2025 11:39:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7431407989230163872=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] oeg.bluez.Adapter: Fix DuplicateData default value
In-Reply-To: <20250227182832.3228513-1-luiz.dentz@gmail.com>
References: <20250227182832.3228513-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7431407989230163872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938643

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.35 seconds
BluezMake                     PASS      1528.97 seconds
MakeCheck                     PASS      12.66 seconds
MakeDistcheck                 PASS      159.80 seconds
CheckValgrind                 PASS      215.40 seconds
CheckSmatch                   PASS      284.30 seconds
bluezmakeextell               PASS      98.10 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      865.71 seconds

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


--===============7431407989230163872==--

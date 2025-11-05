Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501851ACEAF
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372893; cv=none; b=bFKnNMl9Bt4QcV/d3BWecAjdD9LPq89W5S3kfS0VTJoweQRyz6RfHIlhWG4fsyssGA1qdpDXpfZtcOKUVCSuT+k+68flOiOi2OZyUOET07xvwHrR+yffqdAd1NNo18O+JL1WzKZD4mSsa9wI7GwX++ViY+eKtVjoY5huY8drC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372893; c=relaxed/simple;
	bh=HvGn9z940IkwWt7fy1tLVcStPkzfsdSrdbtoaarlFcM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QrvYwNt/4tJFvcGlzCZKJEePBy5/j1AQ1K4AdmmY+2oYIQV1HSst+WGz6WlyvjG8FBH+Er2nQMM+PVwJkK5nSSvStlIB0/5eGtnZsm/FU1Z7lJmgrC8MT1Y59aMY2Vh0YwW7DEB+IJCoIuJr0GEG4yGjIao07A6aDeMuUwPPn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwM8a0H6; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwM8a0H6"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54bc08ef45dso155677e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 12:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372891; x=1762977691; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hIflJCGK+b1KmB4G9YZ/u6AGANyzeELUmIkZM7m6PxE=;
        b=UwM8a0H6KYEnKpOGJvdOWyJkWBbDcRBelC2rD7JeonmuAcyV4mUV6h1Wxxdg/3lqP5
         q6Kmr8csirXy1fhjwHfrABqdev/ALSKpFcCmUDrTe74iBl0LVQVRxqrMgFOvtk1q5oLJ
         4X1ZMXmQCmHDvahqD5Jnw7ixAr3MsepwcCqAKc6F1W/fwpa0nvBRXq/eXB41+pkC11pY
         zs3BvEzewSo+VJY8WjFmCgY/wuAhIz1cYT3M8GByrcD6Ztpu9Ul9/ItzTGtJiKiYV0Gu
         r68I0W/90mgkqOarHyP1zy7zRzU9A1HugTM9fvnSoibnjSFPSm1pAySeeFXqplSfjQ6T
         7gqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372891; x=1762977691;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIflJCGK+b1KmB4G9YZ/u6AGANyzeELUmIkZM7m6PxE=;
        b=XmtxKKu5pSCHR/5nsMgt0jzxFXr56Xw4MYBnqL5KzwLktcq7JIuPPMS6ApzdWmzTOh
         Uq099/N9ghBuOvjqV3dbfspGp4VAdyOQn1o02fcfiwCMoEikssMpzHFT9ZwuMRObt9Fz
         i/l+LaA4XRojUquF04ggLfFfTLt/6Yir5ULgxa+5Wcq2OzJK6VB1KaSYCC8pwRzLa7iU
         IGgTBUPQxS1K5cEqpdcYCRO/2gRnW1OvA6O2EcoFLfEilMpK2kM+B0DlOLCyHA2evW8O
         P8N9gEjXs34CayBhCIiQ1UctRFnWmxPZ/ytjPrizneBKi5tN5nzxA/n7u+M/rYAMRHwk
         /yew==
X-Gm-Message-State: AOJu0YwvnXfKAmamC28moOYpwgXFCIOowCc/MhOOE+pmc1adKaE/bzqL
	zdgvCu/FV9LAamH19mi+0PZ1GmZZoEDZK81iXB0+SiK25+mHCDznlRqrTMSLog==
X-Gm-Gg: ASbGncs4L9Gl/j/MVvEGEwVDnaUrAZr0NX422YdwNzwAB5PBXdlM5C984OV9oX+RJ+o
	yaWpwjikDSANrwzxNgHDKcFv2xEG/NeFubzHHjxooFTa+a/zhIABfhndL1v0RkI8WPLc48ei5cQ
	D6ZREEWFNNLs8JS7hGDLwd9jHUduJUc8fwaYMBUIv8cOmb5toC/Uy/oyW62CVuypf7xiiQw3+m+
	HWtcQ0uM0CsT82Ao4ZsVb5ed5YS1vSuYcSA4ApTW9PWcx5gCvKshGgdbrWpBYYvPAIG3Mzm2mYG
	WvoHkVu0PFcMHmwxnNG+bKfmVBA9dTR6ROv8S3/N5z8nf9OvJ5LwVIWOSRj1dDmeAEAgPad2esn
	2rtYd3y0dzxHbrugKqE5LJJRXyZ12ExFqdDh9Xci+wYnyZDhZaWVlMhESCCKm5iqRAFopH0Niu0
	26Cnk=
X-Google-Smtp-Source: AGHT+IHO5d9wFPII+e0FR4wCZ5tYyHyinPKH+aifPQ4Dqh+W6rCSB1ChkijgM79gcqzOoNunMw9ZqQ==
X-Received: by 2002:a05:6122:1b0c:b0:559:60b8:fa81 with SMTP id 71dfb90a1353d-559862b3b51mr2002558e0c.4.1762372890837;
        Wed, 05 Nov 2025 12:01:30 -0800 (PST)
Received: from [172.17.0.2] ([4.246.135.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23580a00fsm32415785a.43.2025.11.05.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:01:30 -0800 (PST)
Message-ID: <690bad1a.e90a0220.122578.1303@mx.google.com>
Date: Wed, 05 Nov 2025 12:01:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0193543989248558837=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RESEND] transport: always show A2DP Delay property as sink if DelayReporting
In-Reply-To: <9c8c3680e82cbc31b8f9cc3a64997c3668220ddb.1762367086.git.pav@iki.fi>
References: <9c8c3680e82cbc31b8f9cc3a64997c3668220ddb.1762367086.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0193543989248558837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020034

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.12 seconds
BluezMake                     PASS      2598.27 seconds
MakeCheck                     PASS      20.38 seconds
MakeDistcheck                 PASS      187.08 seconds
CheckValgrind                 PASS      239.37 seconds
CheckSmatch                   PASS      312.39 seconds
bluezmakeextell               PASS      129.47 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      936.17 seconds

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


--===============0193543989248558837==--

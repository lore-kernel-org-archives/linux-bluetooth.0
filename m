Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC8157A6B
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730586547; cv=none; b=sxUFQ5/9u85SqfVDqxYEfUT8xeA0APWtGfvdOzhWx/sHoy0l5nyNhIrk6i4xVi+ZhFx9Ky2+kBPSOzeHXbpOE46YvRm48uLd0cndBVpB3F2NkmCE63Kxv8hrE3NHIMSfpdYSyLWeAb2aS3tObR0a2+lzNStDeryJzkC3U6jCaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730586547; c=relaxed/simple;
	bh=Kehap0Jrid1OekccOy32TRBel6PbQPFxCH9kuwCHwn8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lJNZHzBxvRwrhi3XqQcO4Ks1ZGU4WFuIMJtHQ7Kg3DSbKlau6E5kVJyxFGyLOx4uAKxoxfB4yW5pldnfNsHn0b/fgWLwRJvqPMoJ96up0r0JA9uB1Tx9U2zVOGGE2e9nn4WctW4rqYYxzdOKIElaOy9tbnzkt917laqNiO2D5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRu9MkkO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRu9MkkO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ce65c8e13so34207055ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Nov 2024 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730586545; x=1731191345; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8W/7EeBmhI37UmuodH2iXQOXqfMHdtfTO1JG6y0xp2U=;
        b=nRu9MkkOIHR27tAchk4tgmGEOFI4kWi6tV6+pfxZy/doDxZlO3laQ0fGoAZTwHC+ff
         N4IqKrRC8JzAuplpF70+ZvY+bQ3SJxaSimhj6lq+BkKixIKS6uA7IDbFSQxUAOSGZn7f
         c99ot2AHKuCK/K/oU1rMBVsGr6y2+Cl8IoGzmZtlPFrPGDquZqzrsBbjkHTM5f3WmFnE
         iyIZp6dG4qxokfDq1sPN1nFZPDdOFG8XfCF/AApShulCDFBKx30v09e67Kq1W3DxauWo
         DwDsrT9KMsXmUaHryEgM5LVXJj5IHk7twAZFy1/DICzLGLy/kC7aepeMXfHuuata+QLK
         aJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730586545; x=1731191345;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W/7EeBmhI37UmuodH2iXQOXqfMHdtfTO1JG6y0xp2U=;
        b=n/5kl2tnc5ZeQU1/qwXmLcgrIbmzacNSSwb7QrW3Ym9J45xtGrg2Lwtit9ZofaF7rM
         gPx8jQkTxSZXg9lH6GZijo43XqFhmFe5aVMWqZQzUwUP+g8UMKVmTaHZw8n29NYyjfoh
         K3+vwYCGMaSTS0Riw4vEZqq30EOJqLXcZRzFS1f189iae0uL03SfOHt3h3ySX3Zn1fpT
         bATaRpk7jCIP0EwVlaLfba55wGfs0Vn/ZpurDDeoSwFTsIFSy/iwtqwAwtRzRECe1Dhk
         NSSgUGBDSVgvYL/etfhRdYKdMSXBiWyYQ4dT3gQuBY2+uDUDeFLB2jWOkihS7QQK/WB7
         1I3Q==
X-Gm-Message-State: AOJu0Yz+TSxqgkVfaZ7D7S/Zfs4RsMnL+TeqvVSgeKPjUL4kbtYZrMxj
	2j/CQo7sLGlF+RbyOmncJc0uKWL58WNe93zyuLtwtcgGsj8APM3fgAFuRw==
X-Google-Smtp-Source: AGHT+IH5EYoG0nDiRQWbykhQxObag0OuImbUVYn+Nshjl5UwGsIH9+v2tG59TVSw+3qYlV2/T2gWGg==
X-Received: by 2002:a17:90b:4a47:b0:2e0:d1fa:fdd7 with SMTP id 98e67ed59e1d1-2e93c1d3996mr14551528a91.27.1730586545332;
        Sat, 02 Nov 2024 15:29:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa0f6edsm7104923a91.1.2024.11.02.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 15:29:04 -0700 (PDT)
Message-ID: <6726a7b0.170a0220.3367bc.2a63@mx.google.com>
Date: Sat, 02 Nov 2024 15:29:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1292635020782708255=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: transport: don't disconnect A2DP if canceling Acquire() with Release()
In-Reply-To: <e96a0f052fd93f65a24e82d44249b2aa0169cb21.1730579026.git.pav@iki.fi>
References: <e96a0f052fd93f65a24e82d44249b2aa0169cb21.1730579026.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1292635020782708255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=905703

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       FAIL      0.65 seconds
BuildEll                      PASS      24.56 seconds
BluezMake                     PASS      1700.09 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 PASS      180.81 seconds
CheckValgrind                 PASS      254.34 seconds
CheckSmatch                   PASS      357.50 seconds
bluezmakeextell               PASS      120.63 seconds
IncrementalBuild              PASS      2973.52 seconds
ScanBuild                     PASS      1015.67 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] transport: don't disconnect A2DP if canceling Acquire() with Release()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v2,1/2] transport: don't disconnect A2DP if canceling Acquire() with Release()"


---
Regards,
Linux Bluetooth


--===============1292635020782708255==--

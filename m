Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E15482EB
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720820525; cv=none; b=o+lM/ih926siKLi7wEhZekJEFKK9rQKnNGSf2ioK9i4E9Lq/tF8tNw4qqpHFrhp67yTOUe4Hhym3f3IKMEK+4zRdNK0ypzmXi0NE2zCeqjEeDrNTdEUn6KHM1oM3wIyFKkPTXVRjS/wIQoF4rIcHlxHvIyVwCyEXAa39o2CCuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720820525; c=relaxed/simple;
	bh=M7xH4xLwkZZQTWJRJEsk2FR1ULDNe87FzVQ1Uy2ZOOQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IM950UlX2070bxZoInxy7v5OJByhoedJu5PTAwrbR0ElKi1imGXIDU12iOtsb49RnBBvjad4YgnzBTdabWZEjIxC1RUCaO/MYoo7N5Lf9NC/DpCl08+RXiwuQrXR8hrz+YLWBCdHMRqXgf/3qeAux1insl81NXnDF61bzmyovgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG5rA+jw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG5rA+jw"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b0bc1ef81so1864402b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720820523; x=1721425323; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dozkt+mRkqYgPqc63mwZmlXkhX7tGr89G2uF+wzIH2k=;
        b=JG5rA+jwNjQb8YJQnDkxq9PrgINhlmY5L5jf24fKS+FKTRfuxQIC498uNVYKvu75t0
         Kajtxh5xF2gxRPiZsh6Rg1G8PZKoDuG4ULMbfWGVdyJsRxQQKL0Tjh734YyEYFaL1YzS
         iew9s/7i/kP+npzyt5UI1e19XscHXcFVIJ6yBS3pEs/c33vXdLFRl1mVDhJmMQgl16wv
         VApmfYTXQMfrTldPouR+hJcYeMpRyPoayTldR/HZXymXk1YzjPvXUSRhURKlUmZ6Nofh
         UXuD2lYuE6tipZ9hg7Dc57oQSuIopCjBFvHjv7pWc8yyQLGwFqyjL0I7xKRuacVCJ2PG
         qY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720820523; x=1721425323;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dozkt+mRkqYgPqc63mwZmlXkhX7tGr89G2uF+wzIH2k=;
        b=Jg9DhKgGVcGg/tjvnp0ifpH4w4teXHQDRMlaKBTV0b5CooMHaN+4D9cIuGZYdXbKaP
         vajaqJP6wHTvUA2/6tsyy3oxkS9LSs0ARlRH6o95CVwWfiwPe604xKlmeHm0mjNtsUg6
         KX3zDVajNHfJZZeZwW/IK7V3NbC7KyIGNz1NMB/+DmpSKd5DLB6gphVSlOlUEpcuKCcO
         rGRo2x8KyfULIbdql2RzabfsGfnroa499TVAlOTiZi2rLDLF5hcqicCAIe7+HyiozY7x
         Ey+lH6pw0ekS6iNN0+YoTy0VEhEkQIIhrlfmLCwb4gfPN5ll3hVK+6ATEFOmpGxtnnwt
         CCnw==
X-Gm-Message-State: AOJu0YwPfTe0iCnQT2eM7G+NP0WNMFtHE1jIEpu3wm3w1vAChdFOIxTL
	W1KBZop9b4QC/TsVJRI6Sn+O1JNXLZGzqkcIQm9YHDc5LKm4k1AJs2Pytg==
X-Google-Smtp-Source: AGHT+IFYScq2efsppNxqoSHfpddWyQzdbDZQqzNtDzOQkbqagR+HJZJHyagyNYgZVD7Ide5dWEdl0Q==
X-Received: by 2002:a05:6a00:21ce:b0:70b:2a:15cd with SMTP id d2e1a72fcca58-70b43370fbbmr15881546b3a.0.1720820522614;
        Fri, 12 Jul 2024 14:42:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.36.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438994d2sm8273494b3a.13.2024.07.12.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 14:42:02 -0700 (PDT)
Message-ID: <6691a32a.050a0220.cf270.6e3c@mx.google.com>
Date: Fri, 12 Jul 2024 14:42:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8685697782765660994=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Fix ASE notification order
In-Reply-To: <20240712193820.3945762-1-luiz.dentz@gmail.com>
References: <20240712193820.3945762-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8685697782765660994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870944

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.82 seconds
BluezMake                     PASS      1704.02 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      178.96 seconds
CheckValgrind                 PASS      253.20 seconds
CheckSmatch                   WARNING   360.35 seconds
bluezmakeextell               PASS      120.92 seconds
IncrementalBuild              PASS      1486.13 seconds
ScanBuild                     PASS      1015.28 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============8685697782765660994==--

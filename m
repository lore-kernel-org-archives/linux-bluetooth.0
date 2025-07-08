Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5717C21E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001589; cv=none; b=QOKEKTqina/F/1+LKjl1tYpAvpPnySFlCwKM2bW+fLtm91Kou8CikD/UM++RfA5MJkMKxoRKkB0w2lJjVfDXG4GNX0x3aS3gNrn39ZUWnLtBMr5pJJT5bpxpR+G+fABMJ5WMXz+mworRIj3Z8anj9v4ukzkf9A4h8+7gQ1urx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001589; c=relaxed/simple;
	bh=FlqfLNt9koAHBytu80rrBeNrAGPK/EalonLFF5Uj3zg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bOohGRDghnXsq30vz/5eqoMhfR+5mFU1QWZqzvrqUrIWYcIVyz4Gc6T+jT5gYc8wekgvOtrDouIHwjJ8bstc467gelFrkJN5R2HdbSd29HwS/F2S2Jcrp5zH4eHUSDhPIyEPnehTDUDyqGI18pN1UIHHyprfVndOY7FIlSc8BtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS1SWnlG; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS1SWnlG"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e0570a9b83so15997725ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752001587; x=1752606387; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dxM0HsTQbrT9gyTftSN9GqgH4ge+G6tmjCRKtQUUki0=;
        b=TS1SWnlGETeo+3Aa62MOiNxydLSKtw247k4OH058mSuj6KtNEi3ORnWG5s3B/ULKsa
         YSt+u3YIOUDbQoasNAMzfVlKChazqGHTjHZJI9V8wocknESxkx/RP7mO50pGaLVsqFO3
         tbSyzasazQfkB9sYs+sa/bQEQSBq6s5QafIAjPeMk/fwa75nxIgnKQsjyhb0XZb112Jd
         /nrTx/014tEbKw0+fb0AdY9Hpq7GmqmYmu0EHD75e73999HOn1TFkgLEEnrMH6bFcY2R
         KcTqpu6+vZGB/nLBSZS1khNKTc2Es6o08qtEawYeoIXUq7nw/+qwoQZQgao2HmwAGiAs
         d+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752001587; x=1752606387;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxM0HsTQbrT9gyTftSN9GqgH4ge+G6tmjCRKtQUUki0=;
        b=NlsLGdxdebyNM6fWy9WI4ZraDcZzYykdN5BvbIwhcXU0iUI6n83TB4+8nyv8wxuU+s
         tAHcprP9yjnKdIQEe+OYmzC7O5y2nmuoSOIpNI1mPo0uiKGoe022hITEBX3/9PbNnEsn
         Eu6D9l0AvWvwzY1UnTX6qH1O9haToNuMW6K/MEtZ97Y74hwxp6RRCsxPxDH+9Odo9Flu
         kHBc2YraZyjbPJT+YdZuyo4qa/rnJLPbWm9H4S/NL8zLh+ILNpv0KX50QKeKfHNg5K5c
         SJZY+68I18O9KexeU7gFZXJpS4P6qOfTijGBFZ6civVZ8ywnH6ORjPLHjaBBVC2DeHP+
         Eutg==
X-Gm-Message-State: AOJu0YwHQu0nqmY29fC0/KdWoNghLRN3SBgB42cMJsaZPv7D0du83APc
	cinMKF41l+E4IXw52r5ykl5WMrBOg5tabn+Koztks3AC3wIVX2Uol+4PDQcKhypV
X-Gm-Gg: ASbGncvldWrGDGYYCqVyFnGgSuW56H8SttzhNYED2vcu8Bwvjf6Q3jJj0Ipzog5RVZ0
	Gw86qS4DnswMesNaJDD5pEuBp5ef7pTxpln/wIK1iyvWrKm7jl0EFhkPPC+t/ka9Ju+cn/30Vez
	BwVLbK+hcBbvIesemOMIO9+XleTmnoS8lXW2kQoz4dII1+TbFRY9HR+u+ZsKeEpHr8P0KtjyhG2
	N1+wqCmw198596CEyAzrJn28unAvE470dd2Mptv7B9RNYicgHq1NiC+Hm3EDTMIvayelUO7GjVr
	WZKapuq/1B8v8WkAkk5U95tADADihcZlmN3bUHeuD2TBoG3+3nUgw9cpYSommX2l1byCS6cyOqX
	vXNk=
X-Google-Smtp-Source: AGHT+IGvY2qLwE76ggjTePEftvUi3rVLPRMkcKytrFVt4XVtdyvxNqqta6cHBpH4/+xNCLQiqa/duA==
X-Received: by 2002:a05:6e02:1d99:b0:3dd:f338:6361 with SMTP id e9e14a558f8ab-3e153917749mr49055455ab.6.1752001586612;
        Tue, 08 Jul 2025 12:06:26 -0700 (PDT)
Received: from [172.17.0.2] ([40.113.224.43])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b599b330sm2274282173.21.2025.07.08.12.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 12:06:26 -0700 (PDT)
Message-ID: <686d6c32.050a0220.10ac69.3c11@mx.google.com>
Date: Tue, 08 Jul 2025 12:06:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2335263704379302308=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/util: Introduce strnlenutf8
In-Reply-To: <20250708174628.2949030-1-luiz.dentz@gmail.com>
References: <20250708174628.2949030-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2335263704379302308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980144

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      2579.74 seconds
MakeCheck                     PASS      19.90 seconds
MakeDistcheck                 PASS      184.87 seconds
CheckValgrind                 PASS      236.56 seconds
CheckSmatch                   PASS      304.81 seconds
bluezmakeextell               PASS      128.16 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      912.39 seconds

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


--===============2335263704379302308==--

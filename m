Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605C19ABB6
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091806; cv=none; b=HlgdLhVOfRiXH2rmFuIYvIMmo7tXaV247RZE09tVLeTPypqf50rEBrB3TG28GxtEYrsa8kvpM8BVHgGDrfLhz4/6YZvfWac974AKOyHwXP0OENwpDaa9d6FzKo5dDIpUzdTGSJaCrX8+FRSGCMIuo//sJl47V1rymgw/ZX8PoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091806; c=relaxed/simple;
	bh=j6HvOVsc1ELQozhDpXa2o3+j19+PssosEXQjub6dDpU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IU4g5uP6vMc61pQpE+90f2vd/3qcHVcU1UFsbfI6ARDlB+8DZIXsE0iBYu3gQY1BSrB59BS1KK0IPLC3IilSpFP4svFkokYDVAZJehBLMyLstKp+pC5qrFglpWfqX/NAMrJBDEd3J/GMK+xRRWj7IASf62nRsMsjjJ8wIOCb8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYvabiF+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYvabiF+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6ef047e9bso576383085a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 11:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738091803; x=1738696603; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rpy+ebsoSi65yGPsgx45Nq3PXdVYF/f4xtrXYZ+6nzM=;
        b=mYvabiF+luzm6yce4B8MPRtDi1xdvGWohESiQ8znPhuBHI62UUq6eoueGGUC5XBCwf
         CSQqqwraJTAZ8hmamJfxNI4SKEv5Pj2vSmQ6BX4H0qZdwMmbtlsKKgU/RVgOYOI2OS05
         COzGD3XM0feXKAOoxuq5+zq6qmXz5uRNsIOa16QqNbRKuG1knJc+MSvFibVoa0Onn4HU
         yo67Xn3uiRoE5XD+LsRN94DHfyKaHztg7/pRzYzuh5ZwNWj4sdFQKgPtQdXyRlcPSE54
         pz4Ajo2B9YzVm6VQvqJfe3IXKYduj5cPe0ozCl3EClVerzofTcfePK8X0uy4EA8phEVE
         aD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738091803; x=1738696603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpy+ebsoSi65yGPsgx45Nq3PXdVYF/f4xtrXYZ+6nzM=;
        b=L9uae73o15hXjtv5Ws1IujgCaWbKTVyfqQnCj7D/RVCc/Y4If8vKABW2wbOat/a9Kr
         qTfrM8W4XAbLqvlXqbUzPf8+cfwWKQFVGa/2k6dCEJl9s4ajw7YDSPBy7Bp6vQVpbRFO
         uwr2X+rv0m6oBkYI1URrI6aqvAjz4XsRm6LWDIknrd3iVtd1wKeNo+HqJtNETsbqsqsy
         EgWS6cu210+rhIro/RRYQIB55ORwoCL05+CJmPcephteCidI1q3incWv2bk7l0ZwaEdc
         F42DLdaCiNmZaAznr9w2Ib4A85pf1stP/wK39vSkgbqiZRn0sluZGq33O7QHTdjGzrsG
         rL5Q==
X-Gm-Message-State: AOJu0YysJ/wyMEMIG0y7LLrOHdpqZqniCC0+AL0SWXfL3dOpGowNZQsV
	fFa4BM7Bo4f4PcuLv/4dnMOS/shh/0/0j3gVaAyeerPA6hnFutIBNotwNA==
X-Gm-Gg: ASbGnctWYctEllu6L7eHFXMJ8jwg5u2IcifORHe9rI8rofmgslSDN/TBam4zDOubrzV
	JYgWXR2tt17sT8awTotDkyDVgYQ5lj+ejeAkEmd2qsXJrzJAGywXXyjWI25UjaKGkqKGd61FeY+
	XhZQQX+n/pyHT/0jkooePtqthPQ2u46JmutrlV98+6ikDANyw5TvCIDwXg8fUoULaKX5nW28DXS
	p9N7+6AP9dFUhLzO9Lda+C4h+b0mPjD2zirycoZ3Aq8JGzPLipNJpGJqH4/UE77KD2ogn8A84o8
	qFJjgytOWZT3X9S6SPnKQw==
X-Google-Smtp-Source: AGHT+IHRXzKpKsgnvnVnEe3YVawk1HgbKixj3oU6bmMYiT25TXI+6P4Oten0mTOK+edyTZxuyxyyWw==
X-Received: by 2002:a05:620a:40cd:b0:7b1:5545:7104 with SMTP id af79cd13be357-7bff3f5c159mr744665285a.2.1738091803200;
        Tue, 28 Jan 2025 11:16:43 -0800 (PST)
Received: from [172.17.0.2] ([172.183.54.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae992c5sm541514185a.63.2025.01.28.11.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 11:16:42 -0800 (PST)
Message-ID: <67992d1a.050a0220.3ca55f.5d0b@mx.google.com>
Date: Tue, 28 Jan 2025 11:16:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7529062710410005489=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Update the MAP Client version to 1.4 in SDP record
In-Reply-To: <20250128174130.1476094-1-quic_amisjain@quicinc.com>
References: <20250128174130.1476094-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7529062710410005489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928898

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      1591.53 seconds
MakeCheck                     PASS      12.79 seconds
MakeDistcheck                 PASS      158.48 seconds
CheckValgrind                 PASS      213.86 seconds
CheckSmatch                   PASS      271.65 seconds
bluezmakeextell               PASS      100.09 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      891.19 seconds

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


--===============7529062710410005489==--

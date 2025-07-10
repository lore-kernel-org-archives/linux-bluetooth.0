Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035AD248F78
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148265; cv=none; b=rHsYwU2ryux9esEM/45DxyfrMW/Z0v1S3BRVidp49u5Nrzne8D43eBm5qT8ExYJnEvBHOj/nF786GZqlILdc3EFz5mlLO+lbDDJEDPbMGGH20jLnwqEX9iE12UcGezyWNckeYCdfJMFh2wFq6Yn26cJXK3rsweu+zXJz9CgMUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148265; c=relaxed/simple;
	bh=HrKRkGynR2Dg5hFbouhqwMV2Ou124/rovLeuWcvde+w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ADY2dcVBLd9O575tzRbOFqIE3C0EXGMvYDJ5bGKqnfaRXTthy7YDByw5QJXdUkSOp8nZTubnL9YSnOx9PqYU7i+WJepcW+xNSVhnvkhw/iO3BQJ0geuCkIarQAxBQ+PzquuBM8wGcEb/kQxg4YFqK3s82/Z9T932+NR6uL0B4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVuoy/mr; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVuoy/mr"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d3e7503333so125346785a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752148263; x=1752753063; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=69k0B3miVWqR/NDCXjIUZWDyzuE/lQcXS1dbwpGvmGg=;
        b=QVuoy/mrlHFo7qimcGE92eRnpFjjKEGytaagz3dTCsIca30QjuruKa7cndxsgTJM5o
         Ky/TyeZz149uVccRFvuLr5W3rL7dVInrXffIV0PDAIvfnh4PexS8CA0FF7VFfaNsfVVz
         T8IPhF51RKnQQu3YPwUEK3lYmj8oXn4IJt9cLfH/82R8YmN+nRAbgxjeaK527CngzTDJ
         LD7L1Uh2u6ZyplYCZ9yBiXX17pf061n5b0tiNXrgSHodz7mKBTsVV7LjwQPUo/DXq8i3
         jht+roERubnJsrkORe8A2CP8SZmrcFQhhm34HfLPMZDtx4dHhDi5j+E16ZWGALQ74bfh
         sawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148263; x=1752753063;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69k0B3miVWqR/NDCXjIUZWDyzuE/lQcXS1dbwpGvmGg=;
        b=t5LZCjxrCQ673wC8mOxeGLVBZaiA9OwvO7nPRmB7jANEbGgPj/dkEMYvh9tRcDSGmC
         iwzmQKkHw52z7NQMudYFnJZ+CdQSWR2AfZQmmeSFuIJqZGkfpvcm07yjtRM7hE7MkpAY
         HOqHVAyQUEdJT/gYT1iTIexHbkyYdIfTI5e8NhGfe1UBZUkbJD7ygR+qqkBghEJgJrd6
         zQI0ISVLNcHHUXY7ALxpWb1Okmy5dxR3Ausegm/imCv/TNvRoxnbqz6v4zIOntCSPbnu
         gef4jI8HsB6ymfE2p0Ue46+/+rMMiNl2DHz0b+53H8+uHzjfLcZdhnNKAWTwiyHmE3RZ
         BGRA==
X-Gm-Message-State: AOJu0Yyac2yX/rgvdkIAv6tunRHkZ3n+RbnxbKkcvLczDFrLy+y23k75
	iCVdL5HgNgtzOtGlno2yxnYhPhlviPz27XSF55Dqi2FKaj7PekU3TAQSLrmpJzlI
X-Gm-Gg: ASbGncs3V8u1C70/MALeZu1tELkdR+3HSSn1f1WH5ZKMU37EY96MwHL40vRLEx8h56J
	MPWv0ECV6gdnyA9M1EAUY1vEJbFHBElqss7+s8aPWM4gNOrWEZIbw8kL59tngHWNBlGPo4na8t3
	T4J5rp/LYfnt6Ymof+f5yhY3Vq2o23dpEhzXJaqRa46wyYnGnBtukpHhcAfky18FPCCiuMt9uyR
	X9057i03A0AqI1+O/V1aecKutUQu18ZOt1JLEgtoSOg6bnv3UggfU0eG2fQOGg26GGoCgSGRPZ+
	bJ7zI1J9Ny+qt/FUpQLTSpvwHev4Fl2jtNMUpA14J8+1kjhzNE/WlaHn0g5txs9vQK72yvE=
X-Google-Smtp-Source: AGHT+IHh6qFTeHdvdvOLFEoUKvbXUawYYKBYnX4r7y5e7lxspLT1aKqlBYz+laHYdXwbwB2w2nNc1g==
X-Received: by 2002:a05:620a:4412:b0:7c5:9a2a:aac1 with SMTP id af79cd13be357-7dccffe711fmr322669085a.46.1752148262422;
        Thu, 10 Jul 2025 04:51:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.142.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497db175dsm7478566d6.103.2025.07.10.04.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:51:01 -0700 (PDT)
Message-ID: <686fa925.050a0220.28313.1253@mx.google.com>
Date: Thu, 10 Jul 2025 04:51:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1966429940995825105=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] avdtp: fix not adding stream to global streams list
In-Reply-To: <987505e5b8dbc97180e5fe8e112c6435f5435754.1752141846.git.pav@iki.fi>
References: <987505e5b8dbc97180e5fe8e112c6435f5435754.1752141846.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1966429940995825105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980952

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      2606.23 seconds
MakeCheck                     PASS      19.77 seconds
MakeDistcheck                 PASS      185.48 seconds
CheckValgrind                 PASS      234.51 seconds
CheckSmatch                   PASS      304.25 seconds
bluezmakeextell               PASS      127.46 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      906.75 seconds

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


--===============1966429940995825105==--

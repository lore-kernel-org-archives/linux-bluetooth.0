Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627801BA86B
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932759; cv=none; b=j09tP8e4eEhXSxGBggtG2KWVMhQk4RI9AUzqUvjnCHU+RKfwqcWNep7KfxiIbRkAr8Wo6fuNYOTpsxpsTs6H0l6rVbyWQJ4ImSPHmaW1zpKFAstj0946frPzUhq/7Q8RNEj1gzPKJpGJkHeR4IOK6vbW91GGPOtLhLKG37VM/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932759; c=relaxed/simple;
	bh=lfNnmVobsZjoXOQwFOsWzySHqM2ov3IXQ26+Btj20J8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TUn18mDt9LQFb3O84X907i2ABe1GY6DHJ3SMs7iUbYemLXMz3keZiRbfPQOCcIOVx6cBLXs/r5iYY7YpVMcOPf1eGW+zhUeJ1cp2c+A+fTYMT7xEUqZONaPFtbupgpPAxJKnxZ7YF3ZuTeJbeKkkjWT9/WqyNJy0gJKYJNs0m6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1/e//kM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1/e//kM"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-445e1f933e0so23880431cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932757; x=1720537557; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eIURif/scavHqejsxkZHNYqxfs2gIs5kwMvJCeZw/Z0=;
        b=l1/e//kM9GgBEZ9tUMSMYSZYbvss5oxG+HLT8vOc5rk6n3xMMeUx180018YzQBsjof
         3mMqQId6XOm+lv2JBp5MyLnF7Wn5pJRjhM6SiCcq1/Ay9qNYAPs3qgRibjHfqcUElRYa
         AHQtCcGwjwUxMddm4G2Gr1giN0X6FrZPCcvk5DqYxVbed3y64A1ZlFqTJOhfQH7hLgN9
         vIWKATbz6QYH7E8RQxRmu6tAJ3lgSXEosWCMAMY+mghYmhzoR2/tomakytwv/pyLAbYv
         kMKq2HmV6sZ+sZg5KjKtr+JIxoxR23RRXcw2S+F74q2wJIYcHEo0ji0E8Y2stivlrLcD
         SREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932757; x=1720537557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIURif/scavHqejsxkZHNYqxfs2gIs5kwMvJCeZw/Z0=;
        b=MAV/DfqPhVw0SzCO9c51lnMDXh7tbEyHm4QbClL3BoVsQmEJTrV58E+G83XrpkfMmP
         hy+Gsp1srfBaPplEmgWjbjdC0boF5yblYK57vqTtm+Hu77u+AfTRddQZ+odpH53gkztJ
         frN0v5obpjNsaDf1PuaQgcLC6m/ZdLCRbE0lgE9EEwU/Iy1bzkgBQ32MIV4YpPsNYEPP
         uUo05f+8qvNuRDRnhfHG4+ZHqfTBe9tmX/jA2aHH1x1U09PsSQQojKI/20weFQpVWGbH
         xZRW2LYwrwEQB3DgRq/lAq1WoQHHX1VtQdi5f6Lwv/gYPkNfavHQOR6Zoy8R1FCaLyog
         eJkg==
X-Gm-Message-State: AOJu0YzX3NYKSOYdWjHUhT9LZFOgejFIcaTY6NQg3NBK5FffQ76mMCaj
	az/vwiYwVo4kchCkYzqaP9jQgjehM1D9K+fo2+YCbydTdnbwH2SJdTsrTg==
X-Google-Smtp-Source: AGHT+IHehZpWBG2QUUuvCnEZJC42OxJ9hzg3YMloq3WrSr642SP0Et1eKWGev9eRW607tl0Gnwh1EA==
X-Received: by 2002:a05:622a:199b:b0:446:602a:407c with SMTP id d75a77b69052e-44662e4c137mr103948611cf.24.1719932756788;
        Tue, 02 Jul 2024 08:05:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.114.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651498256sm41788181cf.64.2024.07.02.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:05:55 -0700 (PDT)
Message-ID: <66841753.c80a0220.c0d60.0cd1@mx.google.com>
Date: Tue, 02 Jul 2024 08:05:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2069340002727701535=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] gatt: add return value check of io_get_fd() to sock_io_read()
In-Reply-To: <20240702131506.91493-1-r.smirnov@omp.ru>
References: <20240702131506.91493-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2069340002727701535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867554

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      25.74 seconds
BluezMake                     PASS      1788.64 seconds
MakeCheck                     PASS      13.65 seconds
MakeDistcheck                 PASS      181.35 seconds
CheckValgrind                 PASS      261.30 seconds
CheckSmatch                   PASS      365.14 seconds
bluezmakeextell               PASS      123.96 seconds
IncrementalBuild              PASS      1533.21 seconds
ScanBuild                     PASS      1052.76 seconds



---
Regards,
Linux Bluetooth


--===============2069340002727701535==--

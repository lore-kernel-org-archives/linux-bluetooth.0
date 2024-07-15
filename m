Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E4188CA6
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040202; cv=none; b=hFLfYtCCBwBuOI8Skrz8K6X159Ah6jDEdNCLnCalrXHXhrO84BL44M/My6pgdJVRJgN87cISWf9De/J2gdTIrR6HZVE3nyfd5X+sANfK4JlXjkMDmauEO3Gez9a9imymZwaue4zZEHNYTmjIrck5dN/1LvHWmhjEWsfs1drqFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040202; c=relaxed/simple;
	bh=vrSMFVfjgRPMJGUNcqHJw0tQXKFZcT3Shxz0h6UOG7Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ELMy+Iwqid9Y3S9Axa+DrLNI59a57B1r/tbF+3DRsiYMPM20gW0TuzM5m7s1FvfD81wtbkiaC0mlpZ6d6krq/59INrwWmy1dK9Z8XoE3C/3XXGe7hx50jhkJc0NB2Sz+JXVkWyo8JUYlSRUl7iRZGVBsLrn0aBFwwd1vbpLsu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht1ZWxRI; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht1ZWxRI"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44953ab0e2bso26869171cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721040199; x=1721644999; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5NHpMPDXiYlPMRPGUvX3rtk36z0DNmxYrWzMmUUrbRA=;
        b=Ht1ZWxRI/K7pbRJXMgEotZykyFUYr0fXbuSA5SlmWhxTfry5lxyRqFKKnfx1SmQ7Yk
         /eAdY901H52iv8kp0Kn0KUj/jUyHT5hgdElRqD38ugBV0hD8WnMtTGWZMI3SZdYsGP19
         KV8Ca5vepfGP/cexwuSXWErpYJqOHExXQck5jZGz1DFZtjUI61niluHBwuGj+RRXO4uB
         h239I3UaqnQ3t6keIjtpW57ZOq9yLdOgJFGh5/bJaLR8MQhdScSayGM1SePXVN3dnoQR
         SD5kN5sTwkjJdxsMHrqdTx2jlKI1V/SJjO6E0vcUpaJUiO87YOHtxjFDTqF5MiDHFR6j
         DOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721040199; x=1721644999;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NHpMPDXiYlPMRPGUvX3rtk36z0DNmxYrWzMmUUrbRA=;
        b=Mn8g6V37VvD0jX4TYXaU3Exol9ywm1Zo0klSuh/fdlH5qhDN5uyC9038WzMFA7xe82
         G96Y5IKxcQwhztpiVZcn4CyCfG1N0acneAQUzA1jO+7T5py/hrxixAQFX3JL8+yQ3Izv
         t0VVHqIKaBpssPs4F4CUwponLx32y8r7czbpojM5pS3Ul4onYxL7yY55Yfjy5lxH39EM
         Y9Q7sn1jL5KcggDrd2BpF0VJ4YmzDyNFFzzTS7EHRq/b1w2XeA77uGeV5bo8qDYK7Nlz
         cikAHaXZr1Xl3q/f//S2c4e3unZeosrOHQhnHVfIZDAs0seYdaEVKA3/1lrhskniXIah
         YoJw==
X-Gm-Message-State: AOJu0YyKzuAlV9kYlsPFAbc/B0cidSg2q+OaZzCviDYsOeADg+o40p1F
	dj2CDKOhWzCp8Fq09fJJRvLwdHF95QmXfBEAzipJtDSwGIbUrQB5GuH/Ng==
X-Google-Smtp-Source: AGHT+IFiWiQ3Ica0ftLXa07PoOYzFhB1ZJdBlFE7k+mZkZ8eq3fj3df8yrE2f8sVVM1UVZ/58bSqbg==
X-Received: by 2002:ac8:5f4f:0:b0:447:f0b6:d240 with SMTP id d75a77b69052e-447fa8e8fcfmr247414801cf.39.1721040199178;
        Mon, 15 Jul 2024 03:43:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.89.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e00a7sm23449971cf.26.2024.07.15.03.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:43:18 -0700 (PDT)
Message-ID: <6694fd46.050a0220.106ef.5dac@mx.google.com>
Date: Mon, 15 Jul 2024 03:43:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0884158546700183074=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] tools/rctest: add NULL checks to main()
In-Reply-To: <20240715084701.42478-1-r.smirnov@omp.ru>
References: <20240715084701.42478-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0884158546700183074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=871273

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.76 seconds
BluezMake                     PASS      1633.82 seconds
MakeCheck                     PASS      12.95 seconds
MakeDistcheck                 PASS      177.47 seconds
CheckValgrind                 PASS      251.61 seconds
CheckSmatch                   WARNING   355.07 seconds
bluezmakeextell               PASS      119.84 seconds
IncrementalBuild              PASS      1551.92 seconds
ScanBuild                     PASS      1024.58 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/rctest.c:627:33: warning: non-ANSI function declaration of function 'automated_send_recv'


---
Regards,
Linux Bluetooth


--===============0884158546700183074==--

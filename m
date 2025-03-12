Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DD1E9B26
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763771; cv=none; b=fmF7IIBYnWE7fILzr7olBpdIYNOAkMisEx8pRPE8DRPf3G3AA4A3zJ2IQ7zQ7qFs7bR4wO6RnvGVq4t25LLwoegZ6IEbvz/fv8OJBcVJowtEks3QxCkRaG2//wdtgKTN8jRuGaqQzBd6BT/HwYzBrIU04Rn4EoE5iDbr2+RfBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763771; c=relaxed/simple;
	bh=10WnBbSDWiuweCTujCjSOiPFeQkHugczC3Z421aZmrs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MTybUP3zm0NP4k8MkKBQ2svGkvmd/kQNU6Jr2TajIiNrNHGkIbNqYw14JX342kiH3i7k9Fg0LTv+Lf0c+OJLmAvQTbJlSgKYfwPUYhCQu+bBszwMMzapBNEpWzf8e3HRED1a+C/UOWZDl3SmhDV4vTbxj0zPsbXtayaeN7qzIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw6iKRRn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw6iKRRn"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f254b875so50910926d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741763768; x=1742368568; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CHkcG+sUFY/WhPDlQUrIqPA2ra4UTAOGAWxe+4vXgQI=;
        b=Rw6iKRRnyL07JX4yExZQylu2i23Bl3CuNfLiNYi1DrbBCYgeOAVrVGJdfXhEyIWfkd
         GlD/7VgHtcbvrFw0Kw2Cg6wgAq7H4J7A09lqyLayuchNWSlKzKAcKFhvanJIeZh5ZYJf
         YsLf1Var9t6oTvx+K6c0dyz7zbqEYNITr4ZonmABO5NLYV/ZIRuFQcV1cBOcU4OjKA5/
         F0X1PVNAAs8cL2L9AxdBg+4VC2O/n/gKNws7wu5EtU7GGfvb+2bB1+ahJWzQmTnTSmw3
         NVaYYU+IYszfk4TSzcm/q4s7nPq9S9SZfdlQTpL3kRyjqetGi912J70xGn8QzoOWzUNp
         WZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741763768; x=1742368568;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHkcG+sUFY/WhPDlQUrIqPA2ra4UTAOGAWxe+4vXgQI=;
        b=ms0OzAAuCpK0y8ti/Btk2f1kAiDiS54flPeRQ1cym6PTZGbkIVVInVUgrdhdcdiTnU
         wEdkLMMr+pYml4fbB/Y3N3be5WZHqP9+Dc6Ty1Wq4UDCDHMxuZMI3U0Tv6ib1dqDIHxl
         3y5QdDzlkTkb/JpxO4vWt58x7Y7O+SIF8lD9fVKZ0QsBO3WckJ56u/bL7gg/GRY3u6rD
         JOPv3LZmQFwPydw4cJrknMtou7aE48g8+jU0GGlGatVecx4Xl5V7qwRsZ4c83CLKaTyV
         qVa4rpUr37AT81VriUCgTYALDSMDKwyhsWkeRfaqN8Pv5TN6qLQq2eS22Slv1uQwERmx
         rPCw==
X-Gm-Message-State: AOJu0Yxp8kWFS9TSCsAkNXH3gpg8/dgVU36YbccmgXU1xZMOl6IZWTcV
	w5klmfHdh9cGdIeVAm6S/T7zadt66IYe1dgkCXUC/VquKAoW6Ivr3414QA==
X-Gm-Gg: ASbGncvt9eRVrI0DT5YoNlMPHIzHwdkvttiBEci3PA/zmdHMctGAo/w3U4gJ+HJUtRl
	ola3yKC1+ihLyA7iTqGIC0YjMt71lAalFZ2O3NDUlPBBwzyekWzshK0iymNCvrFfuSamLT8fi7G
	cEeH3xEB+VYf6p7+xjpiS7pIc20VwrDQgDLqHRW53p10MAd7Gav0jTRdLjGkv8fGoAjhhb5zR3L
	oXdT68rBtNZwZfl/GyBIsgqp/mM6/kD64CpcdcwL4MW+dnD53VFeQzwE9z3ICSaGgSGi0Fe8VWG
	uqfIheJo4RQB5/ZN8qol4o6hJByZdCm98Tzuz/TtKWqrqZPPquw=
X-Google-Smtp-Source: AGHT+IHRJ/26uR98IDmP9UBpsnh8wdGyDpPOlI3UiQuDBCLNLleYXtgpxKjuoUkZorid+wYLtXxwlQ==
X-Received: by 2002:a05:6214:19c9:b0:6e8:f433:20a8 with SMTP id 6a1803df08f44-6ea2dcfd1e8mr70729746d6.9.1741763767107;
        Wed, 12 Mar 2025 00:16:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e9146790casm48953156d6.55.2025.03.12.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:16:06 -0700 (PDT)
Message-ID: <67d134b6.0c0a0220.d3556.f9fd@mx.google.com>
Date: Wed, 12 Mar 2025 00:16:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5101675207428374752=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kx960506@163.com
Subject: RE: share/hci: Fix data type in bt_hci_send_data
In-Reply-To: <20250312060605.305-1-kx960506@163.com>
References: <20250312060605.305-1-kx960506@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5101675207428374752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942951

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      1445.77 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      156.61 seconds
CheckValgrind                 PASS      212.16 seconds
CheckSmatch                   PASS      282.15 seconds
bluezmakeextell               PASS      97.43 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      854.52 seconds

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


--===============5101675207428374752==--

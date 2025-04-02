Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E62520FA98
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582659; cv=none; b=X2Oz8oFrJb4UTz2dNfIQExkQj8KPTM4kBgNEtrFjNQrRTqSQzz5k7ABphx2y3E5raLg7IhrkEm0+/Mziia1DA8HkbLGFZOCOr2SdzUgD/t5A2W6ESSi34RSTGxgokkfvzyNjjbBHJP+y/1DPFX9hfuK35Cmjv1XuLyzm5vIKkGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582659; c=relaxed/simple;
	bh=BcQ3bNslqp6lMXa85yoLaNyq4kYXBTjILZFgvpm44yw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NhC+7c/LyqxCmqAPpaVtQdkwOFbLvIqpBvCXmwaDXtssAlJpSWlRsNb5wsfO66mIUiSOKZN1SD8WdWAoBYhO7I2OVWc0rIzXXrfWfNNfBW2zBspJmVmVok43jFcIqeltPqDOnmMQRXYj2pR/0ahfCNLKvEfofXeLRI/dZ7UKoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMV8ZwJb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMV8ZwJb"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476ae781d21so62555691cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 01:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743582656; x=1744187456; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pnBDyb0VYNrRCf/wdfrg4kyjH5PMVE7FF6s8kUOViDU=;
        b=BMV8ZwJb8HLyEdjMzfH9b10ez6pQTu0l6Jw02GXjfS4lh1ARcaf/m3t8kc2VfZ+wAP
         jgqCu6EklVSoQNLezA9le4nJDzpHcJuPdik05t7Y+tbZbSPwziqjUNcg1pP3yz4OIQdG
         w0iaMU9iMZ4EW9ewaarDvRkTf7LSH86R4aJbYe196/0HQvEda68Z9eSIH471KQI5wq2n
         mYGH6kyYDf+kBtESOE55cDUYNwTILBt3s3YuhakAIXgtPpI5OBc+l1pclO8upXvHbO+O
         +lW4munYOnlO1Uk0SiSsjZ415y934ed4r6eoXGqqEVHjbXcclaRduiwBEmKp8gEaeZfQ
         v4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743582656; x=1744187456;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnBDyb0VYNrRCf/wdfrg4kyjH5PMVE7FF6s8kUOViDU=;
        b=AcWzoR/HdDU8obf7Yq4Cjd5xaPjtk3zbKTNwT1LoV2c4KrcFiTbqDPE8pIk2AViM0Z
         YbrEaocZsabLCj07I5lhN8HGeXBzIm1wIGoorhCSk/WS3wh39WzfFAiR9favVXhuD6bf
         Q+nJaeF4LphOMZSnotiqH0zhKBSfWFwL6MXJ5Q89I8f9NogBswxrjp11XrJZBnMOBePL
         F3ti+kMMD5+L1rANFwTJThpi0jMtpA3vtaNIunLH3KTMjtQ8P1GUwlQyPto+6uRnCK4l
         wzzrY28zOkW+xsN5WX7tgCrqohkNNITZ2ATwtMo8EjqRHlvLK+K1R4x+Qu7ccCDHxpjG
         zJaA==
X-Gm-Message-State: AOJu0YxHd5POLN2KZq9yZsr5sWX9PNIwxu/gOMK2FimmrYTpjZYTMuSh
	ZUF7tCuqKKrNwcf2hQlJxB47p9pZFxHCe6Im9vIgssuNOCWG3af+ZxxHPg==
X-Gm-Gg: ASbGncsmYlwsXKqZ9mrMXUEZJ/cwW8pi/X+Zx53ROquSJZRxgxbzOOcW+iRq6N0gqSE
	/oibWfk605lr9GkMHA5BB+lSrf+1DmKFJy41RlMGGbEx+mjePoRig/NrWv4gjRjga3AI4WK8U6u
	v1CGcUXKgW4UltarNtNutJCho9RoWa5lVwEeTd8m7RO61nqGWs2rhVcLJBmpdFTp5U3Z0W9w33B
	snt0JL1GdsNvsUM9UJiIOX9dW3s0/Qi+eXdAHNSnRt7Mx7etOVDLgtfVvVQqLdGN7uFZDyPynF1
	u6lzlZ7/vU4R7WX/lZmvTY+/BWISztEHUlJ6ddG9lbzQ4UWzl58=
X-Google-Smtp-Source: AGHT+IG0QLLhiSqQcFsmcYl3K0gpcsmXNEvOVhX2S2+4g/GJTbAGiMG9ZFdB8QQsMKVmlAh0Y99Leg==
X-Received: by 2002:ac8:7d13:0:b0:476:afd2:5b5c with SMTP id d75a77b69052e-477e4b71b38mr185827841cf.30.1743582656256;
        Wed, 02 Apr 2025 01:30:56 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.22.147])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47782a7aaccsm76727391cf.34.2025.04.02.01.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:30:55 -0700 (PDT)
Message-ID: <67ecf5bf.c80a0220.13a9a7.9207@mx.google.com>
Date: Wed, 02 Apr 2025 01:30:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3926868805785238662=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] bass: Clear the temporary flag of the BIS source device
In-Reply-To: <20250402-bass-v1-1-3e753841faa5@amlogic.com>
References: <20250402-bass-v1-1-3e753841faa5@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3926868805785238662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949188

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.61 seconds
BluezMake                     PASS      1437.28 seconds
MakeCheck                     PASS      13.58 seconds
MakeDistcheck                 PASS      158.20 seconds
CheckValgrind                 PASS      213.87 seconds
CheckSmatch                   PASS      286.08 seconds
bluezmakeextell               PASS      107.94 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      861.42 seconds

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


--===============3926868805785238662==--

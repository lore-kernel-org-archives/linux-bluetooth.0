Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBA2FEE1E
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265479; cv=none; b=JDFxeLilvse519zu29B8HKcg5n3eWgsSKWlx2mP+S8rewuJAlUUonHL7UKd3e5EWwT8O3Pe3RMlnRimQVJe8N+TQh244qV13Hx+1c+2Xd+I77JuvOQ0bdrd4iMMAMC9mr3phSLZ9kZxS/DZdbdM1YKE0s66nwAUAxDhnAPFDEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265479; c=relaxed/simple;
	bh=wcrk1FWOaXBetC11r2/d4NVLkeu3rAvQNCPp7MFwLbY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DUaIdIrTlpKsTZR7lQ3h1TNwyGndPRsII1K8xM7CNt4czH7rqH3gsL+ZznzFwUqI5F0Gn5VUWUiBPa0OXv9BWnMroVOnt6SeADlPGxx2eE0/W99UasyJkF6EAX+ocL+ZzCV9tovUnn4t9HFQB9TjFdgC3pty/0eUYqcnqaxHAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8aPozLh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8aPozLh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fac1c60e19so10307276d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265476; x=1750870276; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8yeV8l29bqOROT+LHnJCaY5rw26VeM/M+bPtVx3qQpw=;
        b=X8aPozLhSmEm3A42YVDx4+AS9EJLLsSqfNfZZa/xg1TPfXijbPXn/I6f1+pGYOiRk5
         2oHSbFPsc10wZxj3uW/WkW8fwAtzpG3tm+AE/ITvnnKyONrJcUC/QyNVur4OApOygLpS
         3oPygwS0KiQPgo7rFvq1Efg3z+cnxfJ4E7hGuRivqsWw+bnk3pvdxHLP/FTFQe6QVd5k
         bWM/iIV/03fQG+W26Dk5Ieijp/ACU8ATkbsg/4hueqLzSJl/t9HVoYxTrKdcYGFFoOfm
         rZtiYhQ++1CieAbSZETpewZP/deK7/AeFOTihLta+rGiwulo0phtMhfVAHddAF6FZx2j
         P4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265476; x=1750870276;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yeV8l29bqOROT+LHnJCaY5rw26VeM/M+bPtVx3qQpw=;
        b=BB59SQj+7hHXyVDYENZr1wZdwPAByKN3uHBCpUJcYiCyI4+L1YqvWebXoDURo5JAOG
         pT8yXE0/1Po0NNsG34cw3oRTjuvpfl8G2H/e2uc4dy2lqviOXlSZjDevPxF66oLQGilX
         lYmKy2tfJHpOsMLn0/2ir52cTvyxH96pnm45P041ZlJjHssiHneypezICMoU03eu6NY8
         SDCdcBaKgCCfvTycfejGpRZE5PK3hLo9SSpp8ruK88g0Sw2u7WMMYt2sibJeRz5i/14W
         AV3X3oNz5Rfjlq6Y86S1tKD4J3hzKFDieznOU/ApranDi6qXDGAnOTyUREwviv73t4ke
         Bq4Q==
X-Gm-Message-State: AOJu0Ywwi1po4RiDYmGbMGBu1ZT8DTqAEzl/rj1OgOWQ924mkxcxb4l+
	a9qeGb5r5JYvVQqoiJw8wql2U3HEMQ82hLD+gOWeWKOaxdeOPZTtFd+yKuoNnw==
X-Gm-Gg: ASbGnctTzO0a9eLh/JZiOQFevYwH5EPmqUP5ZDlW3uxvpgyvuQtlojNqAikPkPlnLV/
	UiWzKuNBfwC2GLdOOmVEKEUXqlIrfAYhcoFz4M8kFI4VNZav7ZQDwyIIAFN2nqE/keNm68gUgCO
	ZLi1xnBWWA2zZ0AvWdjs1RObjPrsqzRbCebZxvxR8JN8P7lg+0GNwiZaMorUE6M4hxXI/IwPrT5
	HRCPnFYZHgegroe3Dt4mEk9ACDuKgbv26tCtFxecmFoZHljfUoVriLGv3QU+hXBmBiu/VqEneSG
	exhuKTmc4NwMCBhgFr0C0R7VwGc5M/4kstZJ6axTylP3gWhZmPH2EKU+SBcqRb2IcsnR
X-Google-Smtp-Source: AGHT+IHE/n2YePmIybXA/GDDNdPCzHEnrXKsfOXlWZ8sRpZCcLTqacCyTC1wm69QyJo1S+gTJa9g8g==
X-Received: by 2002:a05:6214:62e:b0:6fa:a5f6:ffce with SMTP id 6a1803df08f44-6fcff7c1dedmr4422386d6.19.1750265475857;
        Wed, 18 Jun 2025 09:51:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.202.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb54d393a3sm35693026d6.42.2025.06.18.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:51:15 -0700 (PDT)
Message-ID: <6852ee83.d40a0220.3c6863.1c1f@mx.google.com>
Date: Wed, 18 Jun 2025 09:51:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5280497852870864050=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] device: Fix memory leak
In-Reply-To: <20250618152918.220245-1-frederic.danis@collabora.com>
References: <20250618152918.220245-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5280497852870864050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973494

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2661.90 seconds
MakeCheck                     PASS      20.30 seconds
MakeDistcheck                 PASS      200.75 seconds
CheckValgrind                 PASS      275.71 seconds
CheckSmatch                   PASS      304.32 seconds
bluezmakeextell               PASS      128.23 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      907.58 seconds

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


--===============5280497852870864050==--

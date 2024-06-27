Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5ADDA6
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499431; cv=none; b=Vb87NbHDofJrnBI0pKjHJHhjl1UO45lP0ly/U7UmLdw5sPWh9Yq8nUxUkZt5k699iEHWbksYnGMvU98/j0GcIsIPOsGuIAeaXyjbGlP2lwLoW6YbPxKJniUdW0GVAaedQOOp3EG5sm8BZbHqUGzcD6lmxros87LdnSm4OM0KcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499431; c=relaxed/simple;
	bh=AA9qy5e49EzdouyvdiUhn4jvxUtc3SMRNeJ8cHIG+60=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jyjYugTHu1V0nxJ3hQTfkGRTnvjmkhV7zhG3pA8WttYNouj3snF57873oErZNPQz/Jo4kz29hPRPjgGQrBztthx9n1vwooLdRtRJVx+NCIlC+csq9pE3dRNh1lgMhg5FMXzaBr3OC2eZBUpcF5d2v430TQCgkPVleQigKS5OHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+sJEeqE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+sJEeqE"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64a6b66c1adso870707b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719499428; x=1720104228; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DuDRFiV2Zw9pg96jBTbEPzCS1HcpW9XoWlYkVBLa3Lg=;
        b=X+sJEeqETpLB2aUut9fNqzNStqgQgD2FwCPB4aUe77BVqso2dxgani66GxTgNeu7WM
         64WHvPs+QN6jDVTZ0OhTkt+JmYWoDbFmzd8O2p9wJTlSqnmKQJ+v+oF0H9CTVX2fHY3Q
         Fxiweu0wZ8Ds6UpWgaSWRfwP8KEmjNVaJQfB5mcP/aI5B03yHBa/fv1qGdlXhlPRp0qK
         NY0M4CK6ruQz7dB7TrhDMU3UQW0NWX4xyAXSNMH8PpHuVNVPBegoG0fEX1WVIGKmSrv+
         DzTmXdTnKyfVtp7zMAOXeA+1vcQtTOnSPrJk32be19ozhdVPuvrTOtK2sdO3JtM4fyzm
         9ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499428; x=1720104228;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuDRFiV2Zw9pg96jBTbEPzCS1HcpW9XoWlYkVBLa3Lg=;
        b=UrpSqSOy4Nb2I4jdBm0DYvsLoKmlEty/RdJr4HVsi7GtdMACaZ14wB+vATRYRAaQoW
         bOPtUDSyX8kSk2oRrA7iVGtqHVGE9QN8+JlwGj7HjH1KFpo/uhQLkI+MU/jlbRWVc6IP
         W1wfd0ACVdF40yL+sl8rudyByW6CsqjAaaR7y9DIFyfsBHGZjkARzwybi98kGPo4tcoO
         9cywt+YImhtw4Ftd1a1uU3JDKi+nk6q5M3vcCZVcD/eGElaBgG6yuk4Ujinn8omyh1CS
         mxxChKc3vFKcdfkXh/Uj54sVnqQkwy+RFlKEPw5Joc5e4bmj/oviDjEQHa3o/Jp/jotU
         7ZfQ==
X-Gm-Message-State: AOJu0Yx/CKgar0nR0uhp4ol9jSDzIXPd+3DJ37yX9cgIRrlVqKyBgoe2
	JlrsGWLhgcZs7qICppt3JR1DpmusA7R5BT6BzL4+nekfWVk1+xmBoazPjQ==
X-Google-Smtp-Source: AGHT+IEHGrrFWkUWAsHxV5XAkzJrJhmfRunn6ZgCvW46wK57FAzdMyanhdlWfokAJ00OYom1EDSOUQ==
X-Received: by 2002:a81:7bc5:0:b0:632:ca12:8fc with SMTP id 00721157ae682-6429da24bf1mr119354087b3.52.1719499428605;
        Thu, 27 Jun 2024 07:43:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.106.215])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6497ac2ea17sm2675367b3.119.2024.06.27.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:43:48 -0700 (PDT)
Message-ID: <667d7aa4.050a0220.e6749.19dc@mx.google.com>
Date: Thu, 27 Jun 2024 07:43:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0475766598258547879=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] media: fix memory leak in endpoint_init_pac()
In-Reply-To: <20240627130552.80610-1-r.smirnov@omp.ru>
References: <20240627130552.80610-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0475766598258547879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866157

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      1730.99 seconds
MakeCheck                     PASS      13.51 seconds
MakeDistcheck                 PASS      177.37 seconds
CheckValgrind                 PASS      251.53 seconds
CheckSmatch                   PASS      353.45 seconds
bluezmakeextell               PASS      119.35 seconds
IncrementalBuild              PASS      1473.21 seconds
ScanBuild                     PASS      991.71 seconds



---
Regards,
Linux Bluetooth


--===============0475766598258547879==--

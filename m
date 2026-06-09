Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764240D594
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046055; cv=none; b=ILY4ddxaR3ZNWvNuiBB6XzxlPWP9nCk+sEKIAHTGFczUuJl1yGfCC1qri4wWICpaMH4IgK2WkP4XnTiabkcb9U2AngkXecX84klfCw09x1DhfAp5nrRRzrxX4mDPlsWrEIBN0p4jdFIpgmlAXEoEY+eKbehBJtgpjYFQ5EP6dRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046055; c=relaxed/simple;
	bh=pEDBdp7/14YqzuIIg74RMPhGcfrhIUj6JijUAfYQnjY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lTmgIrbmo5rp90v0/Ma7wlFNnhwTzKVc+K/IoQzo8qG684cCHQ9WXorhreO4g9DJ4SaNFksI2Rg0JNcq3V256pjGtRtqbEXKVVbRQFal9c546RWTCPLSOQh3IgvWatXL9GyNLg2OaI7WNuNjSxp9Ufb3g3QFKLpNArIgNG4KfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kByPlEvI; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kByPlEvI"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59ebf30a91dso2188596e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781046053; x=1781650853; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cq1WZuQRWYIEIMNR3tp5uHMa/xkgzLazrw8bmKFBTqk=;
        b=kByPlEvII78a1EuHtvnHdaNC1ZmuLb22rTTT3bx6M7WPar6jwTeOX7Pab0MB8m3OFC
         7pysZcTO0YdEtqU+Nnt1fjPu9WaT+oxB/hAFVu8ouM/YcuFYaDTYUYX94KyTfxY22Waj
         ZRfhQW6jYyHHkxdXnZ7Obx23mWyBVqWTz/PxR5y2YDTfX9C+IpRHEIZFtApuA7J5ezLK
         RA+ZX/jgMZOKPF0CSEnbMrAim7/Cq5RXXL6DiZZXCe6JGIT/3D/0leVmKmU/Om6hL9aT
         k04Qy5Qbf3UVyQD9XY9p+Iry7/WGQ2vqZmXhKcpAhlt64k6MTXqU3Q0J1sKhqXtmhu3x
         xwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046053; x=1781650853;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq1WZuQRWYIEIMNR3tp5uHMa/xkgzLazrw8bmKFBTqk=;
        b=Iwc/y/O16+jzS8Z9dfslL4xNyFDx61RU/LUBwdB3mzdcXXJpDhCW9HhlF73qGU027E
         v9oolIO3N5PSPI1uZJdnHUDYJ4sar7/bRzocZnILAekX6P/doMaCU4nUXEMqWmz60BOZ
         Nu4Gv88gLvDKLpI5te/Ba3ssjJc6AjNLqxAm95Xj2cjEXcm75GynFnd2kCliFRCLERSi
         K/TtUcbmnt431dbwGQlcoT+mRb+51C1rCCKJlY1XsmZufzE6zdqdLLAA1iTArMzD9Myd
         ACeF9Tcxb3szrf5MgN+sYz9eStDOfvOtAYp2LQZbCMg6K5r2fnaruYDtdA2ltXNCGnwB
         qAwA==
X-Gm-Message-State: AOJu0YwZz+5XCevjXv9EETpxSCJO7FH1SgDh8aXaS3XGFxm7LAE7bFm+
	3Et0UG2KDIa5kSGgW8DksMe5NyxigeN3MyUO9CpnRQKBKb1Hdd2Iylamaf1S/g==
X-Gm-Gg: Acq92OHKfn0jzfjQSSM+lcwo/8fsqxAJWI/NZzcZwuoyMmLL+hLKt93lm3ihuQLUDu5
	ZlP0Qj6cPtqbR38x6BrN2ULC0TDDFBxKQccGRdlVcZC5XAzsytupB7aqzmPqKV0bmoY0FR1EpMP
	mX3LGEJ908bSCLc50HaMzjf1qqbDr2N9YQ3VcCykpU406vWlpUPnIDgSwZC7+6qrnVTxMFp15wS
	iCro7IGGuW4/ScPe/UfmBVqi99XaQsCokt8mIkTXjSO4YbRTKrAP3s6c011OKkzOv+nLR64VRu0
	KGeosxsWJaylFOF6T0EQ5xpwwrCmNW/2roqBbSczVFrzwgh+B2dS8gkPy77M81+2L0iw/FGht2u
	ZOa3lKVyv/9WDL6UD0RdynL+dzbtK9N9yZ/CwvBHmMzu+G7C8wHml8rDs0ZpzdgAmxr69rzO/gV
	brubtNQWedU8P3aqcehIPP+qDXK5IQRbtjtfBiRJwn
X-Received: by 2002:a05:6123:10b:b0:5a4:180e:8e1d with SMTP id 71dfb90a1353d-5ac4ee93c9amr12225112e0c.6.1781046052980;
        Tue, 09 Jun 2026 16:00:52 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.191.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdc91cesm214909486d6.19.2026.06.09.16.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:00:51 -0700 (PDT)
Message-ID: <6a289b23.362730bf.1b5de1.bf02@mx.google.com>
Date: Tue, 09 Jun 2026 16:00:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6222732926490767409=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] shared/bap: Don't link ucast streams before CIS IDs are assigned
In-Reply-To: <20260609211111.3887657-1-simon.mikuda@streamunlimited.com>
References: <20260609211111.3887657-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6222732926490767409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108824

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      601.20 seconds
MakeCheck                     PASS      12.72 seconds
MakeDistcheck                 PASS      233.39 seconds
CheckValgrind                 PASS      253.37 seconds
CheckSmatch                   WARNING   322.84 seconds
bluezmakeextell               PASS      165.30 seconds
IncrementalBuild              PASS      608.51 seconds
ScanBuild                     PASS      916.87 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2208

---
Regards,
Linux Bluetooth


--===============6222732926490767409==--

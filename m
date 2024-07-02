Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4CBE7F
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931760; cv=none; b=h2z/vGnkTS3hhRVi5u2lsggQaxo5UEcAhOdPo5z5AHO3/OOcJvZo62cakqPX8/osnQ/284reZJccdMl+ZmwQ5bBrgPsEmWRFPKsmOB5nyXTYlL56XU/yQuejbzhyF65J/vG4Zj2/CO62rxR8YNRC+SXr5/NyuRn7cVA8ZLs48Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931760; c=relaxed/simple;
	bh=Of846SBHdLyeYnoj52thDxJmckpnaLU/4mieVYQqumo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hbSsO5erhfplxrJDg3FA7BPATs0XIkzl4smlPYJndEbyWuHRwPRstw9V1vSRPvc0a1dav0QjH/hD5Do/8GMd24rfurRhSy3NKZsj4yC8EcyRyaNx8hrIQd7/H7NsYJ9wriQmeepDHz5f+rphrZoebLde5JnuywelsU3cRwuZd3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ6MGbdS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ6MGbdS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70675977d0eso2724361b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719931758; x=1720536558; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SJLmJAPKoYwp/dil2t2G/2QcoiT0MbuctTI4GBgaqPo=;
        b=cZ6MGbdSks3d89O0nNrFIuG4dEOhKA57qtb3iY2ulrzwLFGZRQgnIazqr06pwPNtpV
         NTgf5TnNqo7Cz2D+g52i0erpAdsfGgSMa1I37/STQXID0P8x/dX4xRI3hDnfz6QppdSW
         GB3DVGqNYYuf/AmEJe19Olnq0BLEZfG+qWuJScZFphOKeCPOZLBcaKeW3qucNRhlugVs
         wvlfmgwNr5xjzpo2bGo6z+6vHedEGg2aAMz9WKt3NZ/4kmhQnayrP8RNpVYAnjo+YcJk
         seKCzODZVrhmKnUaI3/FRzXKolwI4vCk7HDLoMn4edM0oNRxSmUyquL0JFdEpNZwqMfv
         KmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719931758; x=1720536558;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJLmJAPKoYwp/dil2t2G/2QcoiT0MbuctTI4GBgaqPo=;
        b=qmEFL+vb8AWIE0gVmZQszQMOo2VpxOJ6pUxqNLGxeLNYmUnaVigpsrLh3cz29VS10o
         X8misQhk++yRLEq/4cuUT5dzKeqOcaStkHpJjGdAYGBJunYnboZhqWM6+SrHwxYaNAJc
         9r2w6KbJJgtLiJrny1OBVnfMuyqCqSMFWsSu4Z/Eu03ojJ7akVumRDOazCjjhD+4Plsi
         ltVMMHuBQdwo2iT75li/Znnnf1N7ErslYWT7Lxyx95fziilsbc7Hv74aR5T3aPosz71l
         JK9CTqx0ze3s2NqpCDBo9ub001DadQJi2VVZfr6CsiXFNmSZeVBp91TEByAL42D6Wox5
         Qvvw==
X-Gm-Message-State: AOJu0YwS009AXTwg/FNsQk4X9D2xUrGr+283nPyF3rtyvJUbMtoX0POZ
	MrEi+Shmc/eaTkTfKSj7U7vzdl57b4A/KqNeh63J/V+XoQY7jVdlmnTCuCpz
X-Google-Smtp-Source: AGHT+IF42GDBUt6HQsME7taICZyE5if1HwM/SXGXzGSZydFv29uqxTTA9mCd5GM1wcLodR+4wdSn4g==
X-Received: by 2002:a05:6a20:2450:b0:1be:e4cb:bc6b with SMTP id adf61e73a8af0-1bef6199942mr9785593637.36.1719931758110;
        Tue, 02 Jul 2024 07:49:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.140.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce16865sm9005160a91.4.2024.07.02.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:49:17 -0700 (PDT)
Message-ID: <6684136d.170a0220.b45e2.f363@mx.google.com>
Date: Tue, 02 Jul 2024 07:49:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5802434491719788165=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] core/gatt: add return value check of io_get_fd() to sock_read()
In-Reply-To: <20240702125157.87719-1-r.smirnov@omp.ru>
References: <20240702125157.87719-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5802434491719788165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867543

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.92 seconds
BluezMake                     PASS      1749.74 seconds
MakeCheck                     PASS      12.79 seconds
MakeDistcheck                 PASS      179.90 seconds
CheckValgrind                 PASS      273.48 seconds
CheckSmatch                   PASS      360.62 seconds
bluezmakeextell               PASS      122.77 seconds
IncrementalBuild              PASS      1701.61 seconds
ScanBuild                     PASS      1076.28 seconds



---
Regards,
Linux Bluetooth


--===============5802434491719788165==--

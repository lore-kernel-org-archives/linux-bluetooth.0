Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634174420
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447537; cv=none; b=q6neUsKlHQTmGin/vonlloVvbi3l0G7T+fzsGCEAzLDTNMhmdzP2Gew4H5D2Jk1pF3jXarTs4/5D4NLiWYSy0eNKR4SYRiKi2D4ZjoRndFU5MMp+NR7Fan5XGpR+7bsj6jueZHf9bOY6Dfw/4txIMv6WfEUx+K1o5HmRO0f8DHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447537; c=relaxed/simple;
	bh=5qAMCSaKwBwCrPF+fBomF2puCukMLyIl8raAykz3bt8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jpa1eLlkZXiyEIjXnqlKMs0jQdsgUAKt7OeyIoQu73FMQ3BXLcTsbuiWu1/ebusHKYOZZUqC/Fgw8NJCD3GtLBydiqlgjxaegJ0AtGlQ4+IMrpbzq1xw64Aq0N0FjQAXi1HOHgb6iIlUALYD5MhfHWapI8JAp8zJR+tkaSdIQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1SAHhTv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1SAHhTv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234b9dfb842so21635ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748447535; x=1749052335; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gw8zSeFszHNEHKz/A702wIXvjKEYmURWSC+hbpQLQrg=;
        b=L1SAHhTvyxCq3Pui11QRQ4hlGtMIWM0olZrR/w9h/fBQa5pdcNXKj06XZs6f624rse
         9JklhNPBavdNNm/VMUaPEpVcSo6gkHDhuZYRFogpQdUsTFN8hFSiQUBJg686L60uZEAU
         oOOSku3DcuWVYAKfBC+RWa2Dgel98vTc0r1MGi7jMDNbtYT04eJp+1juLV6LBXusFO/5
         eunXOyM4krgGEUUdRmXtXcNDOrhXaMKppVFuCtRRhdhq8DBNdCByYMk/DHP/7/xj3E+d
         7lt6KZ5oCXM8MRmXdUcjKkDnuM2Nq1pSYBaKIVbyDJ/WTBkTzd1YhIMc5XU9pFdk/2Wu
         UqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748447535; x=1749052335;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gw8zSeFszHNEHKz/A702wIXvjKEYmURWSC+hbpQLQrg=;
        b=wxCuMNxt/bFLipnJiDQK4gnLepSUTdfKdln73AncoTKFPw94SPa32lp/xDfS/U+zJi
         JZAe9t8BwlDXAjzioE6+4EildgHUicWa2kG/Gzy7avuU1EIYlyrmhbFpIB+vJWb7o5lk
         RJPXogCperh2DurFOLI4wPHrKNPNrbHQ7BbDOZiLLv0v3EKKbgkbMydmAOXRtdddPzuv
         GHwml/zjs8V8RK87MxyHfgaTPQNJ2p0mC9QYiUGVCjhdRmBRddQthcY/zB+jg8fM5E4h
         xppbB/3BX9hfBd4qY22aIGerchgYxUaHy19VgH5EgukgcEDvKpzeW8xR36XYLNkNTQbg
         NOQA==
X-Gm-Message-State: AOJu0YzlgtpjcBXM+RRIWU2jCApL8mdRuOwRhG0mxt98fEfMlx/KB7IB
	LArtSHT5fkjUv9Rl06mYNy60QY1Is4dt6t9b7oH9zAbhB7vAwJjFCZaux/kxIA==
X-Gm-Gg: ASbGncsgRTwsoC4yUElQBXDVeZPRc6IaUm4OlPoVXE5UTphcUC2FKsIsSCdIcJnHdJe
	WCoEavnwRlWz5vOI3mSJY/Lp4IFK5r2KQztA6q52Fq9ugmhijnME2cNlt94P1Q6xdomY2aFGTlx
	euKRmaEFn7SsM+tWKOIOaE+EUPPs6drg4gqqkN7RHx+YlFgUC7tddpp+J03pHrvjUb0e/54Pwp/
	DtjEeXy7DV/khpxGFhWA86LxpmVCFwhmZnHB5PwyPi9TLrGuca9aVmeSPFHvr16BTxZhzLgqnhG
	V/dWkoFBAsxr5o1bN4TVyyV/Onulkh1JCyqasJ0Rqx6PmuV6c6jxR8DsQyU=
X-Google-Smtp-Source: AGHT+IF9nE1/jrCJLOycQTEZSBNXBemGxb1YA/yA83LwbMhe1QeJzTTmmSwIY0pyAtX3QKoxN7Z1Dg==
X-Received: by 2002:a17:902:ce0e:b0:234:c549:d9f1 with SMTP id d9443c01a7336-234c549dd07mr60113955ad.47.1748447534507;
        Wed, 28 May 2025 08:52:14 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.252.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35acbb7sm13337265ad.192.2025.05.28.08.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 08:52:13 -0700 (PDT)
Message-ID: <6837312d.170a0220.217cb4.89cc@mx.google.com>
Date: Wed, 28 May 2025 08:52:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7527649425448501676=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] audio/player: Fix not being able to register players of different types
In-Reply-To: <20250528142112.434989-1-luiz.dentz@gmail.com>
References: <20250528142112.434989-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7527649425448501676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967039

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2812.85 seconds
MakeCheck                     PASS      20.19 seconds
MakeDistcheck                 FAIL      8.60 seconds
CheckValgrind                 PASS      278.49 seconds
CheckSmatch                   PASS      305.18 seconds
bluezmakeextell               PASS      128.78 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      916.34 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'doc/mgmt-api.txt', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:12179: distdir] Error 2
make: *** [Makefile:12255: dist] Error 2
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7527649425448501676==--

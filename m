Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2211C84A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427254; cv=none; b=uQuSazjVEcFRuw1NLfONp+VytFc614MBLrxnYet141Wb2KJ4JobuzzKmm7fixPA3kfwOlIcu6SZt/uTYs/C8jj8GPXyz5pF/GS+H/O3q3o5UEhK8nqrZDyq8lyS/kxHqn71ZVsq2jy69xN8qMz6bTCsGDUrplknTHzwhqNJSEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427254; c=relaxed/simple;
	bh=Lu2JbP9v1sBgygpjdqyrLMqbsDc6fQWKC75cVQIMt3M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=caq+t9lwaVAgo3lByMACvVc6vhXvGB8ANZkxT6a3k5EbN158H6vdFMgbGf+lMhMfo5AV7r+ptuYc1gxiygki/GKqx45tpErFOMCEQYBV8Ii3eCg/ylHR05pJ+Psq6XFP9LVRdkhc+XURAPR0vRdolMu2CuDa0gDijaflr+wo2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikFq9jYC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikFq9jYC"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4766631a6a4so27426991cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747427251; x=1748032051; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0hvb7Nj0tIyPG4XeYb15YBnhXeOnLOK89hUmLCBRDTs=;
        b=ikFq9jYCynma5DxzMIaDQ9SE3yKpQiCCT9VbBnNEI9Grn+uGWkjjz61DRdPnKYyebL
         duUG2ZcTwXDVkQxHodcLrZKbxrx+xxRVXgrbeD0U7xEnZ9+FyNwg7m8/5N0pog6u9Wdx
         xKLHuQE0rAZyIn53tHaPHH91mTRMEfKMZ+Ydw7s8Y3DQhBELOx9MsNd32LTnWuHMaAhw
         x9r6IIognR3m5GMcLrw8j1BeIgfPih3re/xYxRQCyUvSZWk2ET5vBpHmuU2VhjRlwgkt
         QeAHS3+IBgDmYYi6UDDvd4+HlyLEHMbURME2P00d5U42AZ4Ec2dW4EMqCHjLrVI7Z/mX
         /WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747427251; x=1748032051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hvb7Nj0tIyPG4XeYb15YBnhXeOnLOK89hUmLCBRDTs=;
        b=tX869E65/Xakhaw3G9VSqYcnQZZlueO7p8g9Gc2jGLou2JbGuyZE8m0Uk1pEzeMOIi
         B2Hw3hVpEHiQ2GgcWcuWGZZeSVd5ve+Yd2OBc3TAqF1wI7V//dbSCia3LuUTLpb05kx5
         3ySyZTESU6w5jr5I1qmUWwT4y+Nm1YfdL7IvQk5QKyPQK6bbNvDUQCxjdJJXczmiUSh7
         kK+qejRorAhFYvduk3aoU4Abn1PYC3tDMIWL/55NqIW3iGinO0Zgj4wP1RWubrQ5auqq
         VsC8AP11GjUSbGD1QgMQbcwuKByjUBaRcZNo+vmQ08gqemvLNOLiv4ZDfWcKilNDOiRW
         E1KQ==
X-Gm-Message-State: AOJu0Yz3gT+qQf0LrddJNbxkkWcz8Z6PyoR01IoLhc0bsjX5ISDGfU5I
	+u4Zz7Ykl80a84nUqrXqw+7kbonl8WFzzFL2QccVLRxEhiCvEbZZB2UFK251aA==
X-Gm-Gg: ASbGncufCFzZWkUSFC+y5jdHifSuvOjWObM2Pn256PqTwI58oPlIyxi9BvuHr2uz2gl
	lMAtLsBb0Ekdaaf3GF0DT/RcleBTtQJZlUd/0HwX+0h4LterAWWnomc1Fi6gzSm7pEhD1s4IgJ4
	wZ5TbFieGfyhJT1hfzMvyN/3bIMvNQda0hLYtdB06+gkWGFduyWurVWEhfzYqRbp5cxCNnBGasn
	bVzHmQYUIyP4rZFWg8EERVblj+E9io0C00d26eqDY1iwSgX4V6K5QWIyMB2rHt0z42Ik9dqql2L
	YFqwkHffPX7/nnjhJNG2wkGJMyBmme4TH0A1X/l2JSuuyBBoKiYq+6jQ8xp5p7MotAk=
X-Google-Smtp-Source: AGHT+IGQuyT/IPxq6jXPtuBU6nnJdi0mmLXj9QzMyKsJPGFE7HNpUqF/4MbzJvJc38k+qMtwC1C+YA==
X-Received: by 2002:a05:622a:40cc:b0:476:903a:b7f0 with SMTP id d75a77b69052e-494ae4347e0mr80883831cf.49.1747427251626;
        Fri, 16 May 2025 13:27:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.195.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae3cd55fsm15514181cf.14.2025.05.16.13.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:27:31 -0700 (PDT)
Message-ID: <68279fb3.050a0220.3b10aa.aad2@mx.google.com>
Date: Fri, 16 May 2025 13:27:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4007620544329756395=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/2] avdtp: Fix setting in_use flag for local seps
In-Reply-To: <20250516190653.1974406-1-luiz.dentz@gmail.com>
References: <20250516190653.1974406-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4007620544329756395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=963744

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      2766.80 seconds
MakeCheck                     PASS      20.86 seconds
MakeDistcheck                 PASS      200.09 seconds
CheckValgrind                 PASS      273.74 seconds
CheckSmatch                   PASS      300.57 seconds
bluezmakeextell               PASS      132.54 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      903.43 seconds

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


--===============4007620544329756395==--

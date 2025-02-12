Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD42557C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368373; cv=none; b=LxcEtPdLdUW/Nz+qW8R1Lcw9/wPaFdaeDE7R2YEcXtlT+6eOH7KbcVn35TNghdTxcGKm9u5ZUgD5BbRHHjuaNvQ9djyciWtTwolsjqolHhnOhxy8Qt4m4bEkcztZHAR6INteb0qvPDaWyc6Oki/IuCsO9bhav8ICGi5F8OUylOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368373; c=relaxed/simple;
	bh=4AqJz2GxdLNgwoy9AfUFMP0vf8NBsM0TpwDcC9Jj2nE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHrU8Md+bXGbYlpnMgP7whNRQbxT9Swet7SZD/q26RPzJ8rA3w6s98DKh4axK2WzZXQl1Qj4hnT+LXmapOqtIMHnTdNP7o2ndpcUYQsiYNTZFZ+7ssRAc4yy2hc4kFPywU7kemS8G5PG8KB4ZymEp+ifKyXFkYBHo31RZKXGiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDACJW/j; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDACJW/j"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7e1286126so355584566b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 05:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368370; x=1739973170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISwwgnX80JzQg3/9lm4K7vPp4s9UZIGv/HLJ82kUl2g=;
        b=hDACJW/jZTPSiXWPqPWCRJJL4Dzg2xlIrk1OHORJl98/Qc9JmvrGIf64USK2oLAeCo
         ZCDP2nYRr0/KHRWGpqiSxzzIjI01ZM7kDBk5ljbLN/dZN8uNjsRzFHiMYeooJNNKwBjy
         CidKOhTvLQMKsXMuBLzV83hoyGT9RE9WERSIuNa7GhFG9OAhj58lx/N+ZBmJP+hxXFyG
         tDIman+LeKEgO8UuWjgtqWlCW2bjWZ/YyERAgcklCkovQ8bDrpjk/POqsUw+NIiovGd6
         e6f0lBJQ1EbA6wSqsCI9uMsi1TEjCH2+vViQ2ajj1JPel/+SrF8/txltbP9XEmlEkVsY
         d9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368370; x=1739973170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISwwgnX80JzQg3/9lm4K7vPp4s9UZIGv/HLJ82kUl2g=;
        b=S6oSi52hRoiioMaUcYzA26/DwGqvoc+kj69Z+rJB9wZWNJxmAxMWAZdDztdeWbf4go
         /8lwpOFI7/OMeUowdE5R007hz2v/4IIRe9QjdPF3Q5vV0yYUiMMKjrRf6jkI3d+93lNE
         /GO3qA5Qd0BlY9UExpol29Xrcenp5qrIWxQs8NE12kmCS7BWJAdS8DQSPkORa1dTUtN4
         7R1lg0d8OG1Ju6SqU50McpjaB0JQ6CbdWmE0rmR11KErKHaViwrWoVoLogRCNgTd5FkI
         etlnr2SOcdoJyxsnWPjJ91rqYJrqzSvYw/hAN/0Ch4gK47jAtvb119IOVSgRs4RHriBS
         YK0Q==
X-Gm-Message-State: AOJu0YxshIpS5LUeMdgSOcdI9/pqtS7kTafdqafGfPIqRtjUM1fLXZKN
	dr34y9XKOXDLHdETyhNkO7ziC9VkA68/GN9BT0vvQBXoCZap1uvxfo5dIey7
X-Gm-Gg: ASbGncvVeU2Mhvv5xjFkzI68d+jplkwMDnrcCpgPzTMG9YET25aFUqNO/lLFgP76jZw
	OAwgF4DNP5UW5642s7PRuQ82Gu0vaW2M2Yd2GqVzLTbTMCtf5KmSkxD+vtZiACy7S/UeWyT7csF
	ptaSbLXXO8QRgMknQQq6NSAiVzeyREUVhhmnvtEuoO8fGtX+vB1rKDbUGVzppbW6LSuTWeBlTQz
	8xy20VtlkUI24O+eu6Xhmr53P/qG3FHMC6pboelJUaMItKGh/+8aPezRmRNSg0JZrRNlef5Wfb9
	1qcAMWanxJH5n2MPC6U6eAWSX1N0ZQjasO084j9swgL9WizhMDGgFhHw9JfOJ5UR/QzH5MeBWc6
	sSXMP0irorZA=
X-Google-Smtp-Source: AGHT+IGTGo6UTsHbKEO7BaqeI5tJC3TQ1nd/q6hYnjFDMzsZ1bb1Hz8+LKfNJTcIJvBkk8NgCRSfRQ==
X-Received: by 2002:a17:907:a08a:b0:ab7:ca44:feb8 with SMTP id a640c23a62f3a-ab7f34ab834mr306125766b.52.1739368369446;
        Wed, 12 Feb 2025 05:52:49 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab786aa2c60sm1169870166b.102.2025.02.12.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:52:49 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH 2/4] test-runner: Remove the "-nographic" option passed to QEMU
Date: Wed, 12 Feb 2025 14:52:07 +0100
Message-Id: <20250212135209.129361-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
References: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option causes QEMU to redirect monitor and serial to the terminal,
but also it modifies the terminal settings and clears it before printing
anything. Such behavior might be annoying because it might clear some
warning messages printed before clearing the screen. Since test-runner
disables QEMU monitor and redirects serial to stdio in an explicit way,
the "-nographic" option can be dropped.
---
 tools/test-runner.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 77c89f3f9..13a5de465 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -212,7 +212,6 @@ static char *const qemu_argv[] = {
 	"-display", "none",
 	"-machine", "type=q35,accel=kvm:tcg",
 	"-m", "256M",
-	"-nographic",
 	"-net", "none",
 	"-no-reboot",
 	"-fsdev", "local,id=fsdev-root,path=/,readonly,security_model=none,"
-- 
2.43.0


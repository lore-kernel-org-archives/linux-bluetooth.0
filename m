Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C3127E3A
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183178; cv=none; b=m+GRDgN+cIuM/i5FwVgRdhpJZH+LmJeWdC8faKvZNi9CQB/ycQ+atyjouQq0wKbOUaRjWULsAMIZ1oT7Ik+54h0/CUTujPkNN/UjCNM414gNoSu3D013OCitRBPILFCxnMtX/1RxVOMo1LYXKQPB7fOpn3PdrMOY+jxCPvn7nvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183178; c=relaxed/simple;
	bh=DdkB3V8ZGog6weE5ByFmwUWEnknZ/OFQfZ7iKFzZSew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJsK6zZDkhJWPQY/FEOKU9EHPnHIRgZxPsZGQGIQ1M7fiPVp5vlHkaU1/fXFeTW/lXjmQUj8ZU++i1nxzVUG0JZbn5H/11rUaFSuvKELAwhNecE7hH8knfW1NMWWBT8Phiv6CIqkmspKA6DXmi5y2ZWuH7I2ED3831MJbUC7kgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=kXiIle86; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="kXiIle86"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22ed075a629so2548168fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715183175; x=1715787975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=kXiIle86G/zlx7pvEu2XZY6nm6sc/X6AQ9hObyZ3gC0ywgw6nh/fatvBFAYec+NPa6
         9A4/oBR8dwo6sYwchAq9B7Ijq/eCFDZV6xb4HXAXfRii5RajOGvkqNSYy9Lhvaf5vxza
         SDGDIxhMTWfvDmh+8x9Fc+Gnqh1OzPjVCWY8XmwoAWnPb99+5+AYGyVyxwyY72BiMEQq
         ZXXaYab5JuZ9XHd5SWqFI+Z303p64RXWOEk0vwuWPUoIlvgV+5T/7Qd5kOb7PLRvBymF
         PesYcZOsrARcSIn72sQJPmiZ3pdSb2PVY7FoXYMUmbYvrv8E28tggbwuWk3Mug/Q41K5
         T2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183175; x=1715787975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=sLP5aJOXr+2oSUGtwBJ41c1DsmqLswDx1zBx1AoU5ALKSUjAof+xNEmlhuD3/SiHC5
         oJUMukrAVLi/pr7WmQua6aTzKSB3JBUyHCL/+NLxPJcVZFwLYu9Ijv557VuPHzwnqiov
         egx7ZWNnVsXdpjpR/ZmUd8jVK7AKfJ7OCgTrGK04ufTUphqzCpG14cBW1Ak99azPv/KY
         wnNAwRGqWE856Qcrm2gW89gbQmdyUev218jyUIHQEPxjb1io6XzDyrxIB7RJWZl+tSGh
         +BNRNK0qhLoWBrVlviDoJci4SNDjV1v4G4Z5iTT+BujQ2+16TQoCeis9fCX39CvoJfoD
         vHYQ==
X-Gm-Message-State: AOJu0YxJ8uINOU4eGeaAgr+8r+8EmrVxMSzhERX2+HrHlC4vGJXNyqOM
	4ZhOoyn0ZZ8ioDudIBQnGY4qaLXn7+s8kgi9pNmtqNafMofyucJKE2cwbz49O6lp1RjLjdSDonb
	P
X-Google-Smtp-Source: AGHT+IHf3CzWiSU0aj3XLDv3AURZfotbmyC7LnR8jKT8xQxG2sT+zIZdLaZemXK/7CDL+AwsJInwGg==
X-Received: by 2002:a05:6871:413:b0:23b:caff:be33 with SMTP id 586e51a60fabf-24098c7b56bmr3353682fac.49.1715183175559;
        Wed, 08 May 2024 08:46:15 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id cd14-20020a05622a418e00b0043791f7d831sm7756513qtb.63.2024.05.08.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:46:15 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ 4/5] gitignore: Add compile_commands.json
Date: Wed,  8 May 2024 11:46:03 -0400
Message-ID: <20240508154604.276763-5-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508154604.276763-1-arun@asymptotic.io>
References: <20240508154604.276763-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handy file that can be generated with bear, and allows clang-based LSP.
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 9c2ac236e..6a6422379 100644
--- a/.gitignore
+++ b/.gitignore
@@ -183,6 +183,7 @@ android/test-ipc
 android/test-*.log
 android/test-*.trs
 
+compile_commands.json
 cscope.in.out
 cscope.out
 cscope.po.out
-- 
2.45.0


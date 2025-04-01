Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D336C2C6
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743473090; cv=none; b=ET9Snv9LDxon2CLCej0t0bDOSg3NEpmUR3sds+vtKYrtVox2uwomujESmotmIT9mqyUuRkzAgvXiUWDP5/qnx3gCWDhC7PQO31dJ94HDJUnpejdsEwHn9Dhfb6xyY6zSPFqYDfC0tjRbhAHHwc+OsIGcseIymsdtgt8Hv9tbtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743473090; c=relaxed/simple;
	bh=0Gzp7t5HCNfMTSH06QZL96d7wpRc9nH251SzjtuYIYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fj464H6/8KyrC6OQtZLpen+ATYcZ3Yr1/WqGFw9LnqO6p2XZMviFjL5Pf9ric6P2DUMD2A7GDhyYvfRFQ32QA5U8S783tNvw6Jn0XdfiE1bmgXM8uRQ+UQWaO+xGoLvaeupNg+/XxhYBhV28zSFfxpjKTgNW/P0eDpYGv9pRFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eZXJ8dnP; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eZXJ8dnP"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 897933F476
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 02:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1743473079;
	bh=HUkOWh3Fr02pdnt0yhxh0Ji51KkjxM7JuQ8QMnPM0lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=eZXJ8dnPGeGb7gH7bA7QjUuW3AcWJbyzFdJ0quI5dEZMdVo4z2vTA7E4Wd37Z00me
	 y7dl0XPxHx/U8sXBUITLh5EmlL4AaplioN6SCtPDGmvpd5Bt3qmRxARyxoF6+Cuajl
	 8zYqx75OFr7n9SlsFRW1fi9xC5fBlMaqbKQcHnU9vk94hdiByqx/REYQ/0RJYc+MPs
	 Sri08ih6ZdTYT+XfVLN2FMQKt8MN/il+WhtyjAuiB76K5E6x4lOBNdCOku75m6Wu5k
	 fPXHYbHbZKAKNeixzOrEe2rOi8d1Jsgb3SfCWCrSExPFvwzFAE/lLNJL991D3ukVdN
	 yftQrDtNMEU2g==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227a8cdd272so83603355ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 19:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743473078; x=1744077878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUkOWh3Fr02pdnt0yhxh0Ji51KkjxM7JuQ8QMnPM0lM=;
        b=t0jtKBRT3PVQOjytIOy1fo+JUTWhfkYE6CdW8VmYKh1OJit7MzPDm77xHhKfSn778L
         t0ebPKtRuB62egB+tfs8ikerfJMrfvh8VGQI28YXA5TQuYRq9S7XfsHKDBPSNycI6jSz
         goLCWUbHB2ZqANPiTdMRTkLOYgG8+lwWGUkXg+/csrNa6vnEod2G0O8JzpY27K27X5yj
         Vdaid2ffPY02uA9++XtYclsybyue/72BgKC7l9c/nEj7VDe5nDsfg7G52DuGZUX2igIk
         dUmkOQSwp5JqdQBCdzY05vgjo+t7Id4t+6ERD9zWCjyx2fp4k6NyxcwFEvfXtMrEc1SI
         Rokw==
X-Gm-Message-State: AOJu0YzbnCROFOLiZvrBmp2pVosEL12ct2IMLDKENcm2deTvtkpPUfIE
	Z+pUc04fL6JMahc7VJv+b4cXYSXI20A5tvAzapnIdBqoxIK52h+56BXU0V89Bc1FKB1wlb/nabY
	5k01p6feNEf15c0Ane3DBbptwpqRwFujZLWdA2SIPDP9/Yvw2GFNrUB+ghSPSio8ZJWKoz6CYei
	8t1ptetOMtm0qOFg==
X-Gm-Gg: ASbGncvJjJJvnqT6VuPln8icrBuTOuNMNQtPpjUrlPuu63f73Ju1vQFfAJKa6BhFHs5
	xjhrEwbB4w64xO/olOIQJpMOfRuXfQIbegru4mkzqpXqLkW/438iYf0toR3wbbcLIGPJXnaEsGL
	xSFSuInXIJMWRkShsB40Nwe9qlH54Xtkew6tiIDK6rpNT5J5Xr/vx4jIx140MhlaQmUdRWENmMH
	YohMoWKyNm2mrjMRTo9F8qb58Q3czCNJz8zTaktAAff3a/A4FbHZqagEMAnWNPv4SMKyf5MJCJB
	V4AoNQYOH2JOsjaQ0K2mEdImEBbDFGbwGnyR168GU6jjT427lr6GJkOrAHpP+i1X6Ag=
X-Received: by 2002:a17:903:2bcc:b0:224:912:153 with SMTP id d9443c01a7336-2292f942acbmr191316295ad.5.1743473077777;
        Mon, 31 Mar 2025 19:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg44py620fs0Be0G2gejLkbJ059imDf+5tOp2MBr9Wi3oRUOXNkLHs58cogIfA8tagtCx6GA==
X-Received: by 2002:a17:903:2bcc:b0:224:912:153 with SMTP id d9443c01a7336-2292f942acbmr191316115ad.5.1743473077453;
        Mon, 31 Mar 2025 19:04:37 -0700 (PDT)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf51asm76903225ad.151.2025.03.31.19.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 19:04:37 -0700 (PDT)
From: =?UTF-8?q?Yao=20Wei=20=28=E9=AD=8F=E9=8A=98=E5=BB=B7=29?= <yao.wei@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Yao=20Wei=20=28=E9=AD=8F=E9=8A=98=E5=BB=B7=29?= <yao.wei@canonical.com>
Subject: [PATCH BlueZ 0/1] policy: fix HSP/HFP reconnection
Date: Tue,  1 Apr 2025 10:02:20 +0800
Message-ID: <20250401020221.119615-1-yao.wei@canonical.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch was regarding to https://github.com/bluez/bluez/issues/1069.

The previous patch did not fix the issue, as I was testing it with Apple
AirPods Pro 2 and it automatically reconnects HSP/HFP after A2DP is
connected for about 25 seconds, and I assume the patch worked for me.
Some other devices I tested did not exhibit such behavior (Jabra Speak2
55 UC).  This patch was tested against both these devices, and both
cases with NVIDIA GPU enabled and disabled.

By removing the code checking whether A2DP service is initiator for
directly starting HSP/HFP service, it will now only check whether
HSP/HFP is connected, and start the service if not.

The previous patch also has an oversight of not falling back to get HSP
service if HFP is not available.  This patch fixed the issue.

Yao Wei (魏銘廷) (1):
  policy: fix HSP/HFP reconnection

 plugins/policy.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.49.0


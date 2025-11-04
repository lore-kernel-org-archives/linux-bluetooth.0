Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F7325494
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266319; cv=none; b=m7JxJ35KFI+cHjvTLZH4WY/Gmm32bwgOOs6YsrNSwDb31Gghr3geJ89MiwRQ2ANgjKqXjIvTtpMtA98LyYT2MrUVfxMY1V4geqW6IfHUpGR5Pm/KT0gWSXlW1XKo9HBlKptbkFHxjmizuU35DZaBWcb7ILXsZYgjWlvIldaCnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266319; c=relaxed/simple;
	bh=Y2vOyKAUsw7BTqHk879G+m/WO8aKQcD7j/W426y8LJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DXemnFabF0fwPzyPCEKOmLtG4a/3JyCBHQnboNSZv7MbXQjN5g+PupiYeR6nN/2zAjlCDjIkEtM/QRiAeL9e/8s3+yIpY2vyyJ8QCqz1mL9ru6AZ64SEX4DFHVEJQvAB1YEwu1LbC+VDi89KRrSij4uEgvO/iLvlgqbwOqLLMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krRQoAla; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krRQoAla"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932bc48197bso2425433241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762266316; x=1762871116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6y3SY1q+d08iYnwXjZQe2l93dMMnmoMNLOCQfh7QkBA=;
        b=krRQoAlanmxQQAkeFQiEshG17O1+omNx3K/NDQqH5+4IovNO0G8HD9VotyejxVGQHm
         qzi7VCK5npcGatsT4qo7T6BTDyLZrv468lgBfU5c4NZbuAgVKvB29O82ImhG/NsdnZcZ
         +NcXgsYvYMZqi6zMzKLSxm8MG6x/YSLaVZwBcPwJCfEjO5uLYajhVziGH1Qbc/l5YNfH
         wHPEOW19FIlovzupPeKm7AkpOaL33cUIY10tvCNw6vUm6rUwsuYP/TjnR1wn6laiuwK4
         SsngNJrPstnjA99FPXgHpk8IcsI1Qps8GeXUGCu1V+MjmXe4HvMZXp4los4m1inSp5kj
         kGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266316; x=1762871116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y3SY1q+d08iYnwXjZQe2l93dMMnmoMNLOCQfh7QkBA=;
        b=Pw8HN69kHjrRdcnhhQdWvk7h084rafaLaMZpsKf45GGHRVd5HHhV3W6SgjIoYPxZc3
         VzAcrCopm75uqyw3e2T/IoKNEMYf4KQ1umdXsQtOW+PwmjBzvltfzz1I9IHiXWjpTqSp
         WuUHt/QTo55oZIPKMG95q8wR3iT8YhcUapV1JMRXzJ05fgYMfvlFR8JSiMCNvfwpLeZl
         WZvIa9c4iEzxkbJcdIrO4Jrn4OEHVtLU72sQL4vMuQIZRil0nD0/1QG33I2lKItZxCTD
         hxHpKLxukOaBdQkoqYrqTecle1EBCr3OrZCLUJMVIS6U72FeAn7SvJ9Ti686UIXmiHXZ
         +htA==
X-Gm-Message-State: AOJu0YxZvING8pcqtcDoz04Y2WZDPBMzaUvWsUPMfDrUm7RqTinIoPga
	sC/JLtsRWJH4u27rZSmvjTySAv6xNlxtEm58IRQcAVZYgt92EqfswHuwvP+wRhVh1P8=
X-Gm-Gg: ASbGncsZtxBhn/u9iqEZLZ2ddvjjACPF2+xsKT9Gzaw6OXwkFxJBrHDYs2tnDxWs4ms
	CisJxqPG3Xc8i0+Hh54jvedePPUFJZTej4PQ385ndPjS/Y2d7/BeYnHjPsAmLCZCNeiWd2nVO5k
	ToFEi2H1d0/1kaFL+IUdmuz4Cb/Ksb4b6gFv4zq18mxae2UVhuZAjheKk8QJiqF+SYQnbwR6XUZ
	z4gCVhwkeM8y4NYVSB2lDtOdCU0+aENXZ8g0twwowaP8BkN6g2m8a9yk4ArUd5zenaUjRw7JiSe
	gqCXmjyDDwzE7XM0w3hjB9RDsiItS7ksdTk8HFeK/jQB4JIBPHMJvdt/Dy1ynC6MSD3uWTfu5pb
	5HkqmsFvu5RuIMTGU06gXFU9NEA5hrxO+mLIhrKnw7tUFrqFnvoKYn6sWSkRg277ABDVdqDGi0e
	cPP6KLgwu1i1b9CQ==
X-Google-Smtp-Source: AGHT+IGc6NNkLvh6GTybkolrfE4zVzgT7oDqo9NoO85gjUd0vfTaXcx8WiqICTSZY1dPR4Irgb0SIA==
X-Received: by 2002:a05:6102:c4e:b0:5dc:51c5:e3c7 with SMTP id ada2fe7eead31-5dc51c5eab7mr526846137.26.1762266314529;
        Tue, 04 Nov 2025 06:25:14 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbf31267easm1074306137.8.2025.11.04.06.25.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:25:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] monitor: Decode Bluetooth 6.0 version
Date: Tue,  4 Nov 2025 09:25:04 -0500
Message-ID: <20251104142506.12356-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This decodes 0x0e as Bluetooth 6.0.
---
 monitor/packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index ceed85318b3b..06c0894d8a18 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2526,6 +2526,9 @@ void packet_print_version(const char *label, uint8_t version,
 	case 0x0d:
 		str = "Bluetooth 5.4";
 		break;
+	case 0x0e:
+		str = "Bluetooth 6.0";
+		break;
 	default:
 		str = "Reserved";
 		break;
-- 
2.51.0


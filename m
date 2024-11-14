Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406E18D65F
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612332; cv=none; b=mUHASWB1TYFZ91aptq5eoCvHJ0eMsMU8ghdXFkZsdti4I+PrwdC64SP5+GJIqw1Zm+DBMcjej6IqEQNosH2amxvzcY7dDkd/JW+KLGu1J2M+1r/+bQERddX5JC4+9TgUwOcZjkxfVjWgDl0/A6ft4h+EptN1xCdI0eo2VaU2qfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612332; c=relaxed/simple;
	bh=mDWDSEQYFNXk8B4+HefqLXLfJVLN4mHgFS2QBTTh/Xs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OKE3g2I5o52ILvEoTmRAMv+zPoKDzTjLHg/cvqPsyZUWYcW+2WNznl89d4mpCXziTn+Wr8XVPEMP914okDycXmHkh3Rym5TnD3gxbSLq5SojBqTJ5DO38weGlfcVoi4mfO2l6tOmBCVdr5pU4sUGubpVwDs/+YUoAAxC7vhH4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euvQS9oe; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euvQS9oe"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-856dd0bc407so48815241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 11:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731612328; x=1732217128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErWN4/9tMrbTdpjrtmmp5ydR9xMupaBtG8ikCNl5fXg=;
        b=euvQS9oeyLtOXz0rbaeERZEtLdSXdxoJdpKqwvkYng01y/RO5nOcyaim9otMbzt+sX
         tp/quSNjorOPOOjMJXYdNk8SXd9Tt7kJH4W8wtIEnaEllIwbNRBmKIIZJwVi7kZDhb24
         Jc0ZPQQZoXdxmj6ewZXAwe0G2Mmyvks/3RDRfwQL00bgQFAQ0hW2VE6TzzMgWSosq9yH
         JQOPFmuNQkbOkmbLaD3ZGP0yaTAe8qPEQfEDdvph1Lbin/Lxjpce8cbWOjqER47L1oJQ
         aIcQPSVxn5/WQ2AqNpauEkqME7bHeN1jcJ/ydEClVNvl/QGMSGaBKrw3zOu+P9kbMBSR
         3lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612328; x=1732217128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErWN4/9tMrbTdpjrtmmp5ydR9xMupaBtG8ikCNl5fXg=;
        b=m6heaXraSEbb7TLzqxAgFK+iGAu+aetTw4JRCxowcSqIv3HJdy8dADGL6zsygawXLz
         RwYznkz9moxEa4UQwRUEGACdn8eQqmIhgIVLGiYGROmanVMWctgePQAAxJaVktY298RL
         Y3QNGgyMLzAV1CYpeaXxyXbt4W2JnqCYp7nxs6s/7Uzhv2cnDSMvgUTwpVZ0jFjzyCRC
         D/U0Woaec7fIC5WoDlg+iRz0qn0Fsx8tQ0hK8qfoMo1atbbiFL3fBGQSww/KtcI90efr
         rdRuZWWDAez8/vjR9OgdGgVwz7/geFEvWLKJGej4dGaXlldkCQhmBaXPYUMzxt3KnR1T
         RI5g==
X-Gm-Message-State: AOJu0YyOurXGy3YFbDl26aqGKsqr5QZBdzsZKNvkG40v27/Icu72OODH
	3FtDsrGrSn5UXAxXQw49RhMmY95RHGvrKBN5BbpVDyeFkefs+nK6jybhrg==
X-Google-Smtp-Source: AGHT+IF0mXaz3gVWt0D+jtCSX+0o61Pj09vKMt+T1B/pu8/21vdB0z0FahQlVjCHZVtD5yHapw6H5w==
X-Received: by 2002:a05:6102:26c7:b0:4ad:5b7c:7646 with SMTP id ada2fe7eead31-4ad631caa88mr161483137.26.1731612328334;
        Thu, 14 Nov 2024 11:25:28 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856ce622853sm213911241.18.2024.11.14.11.25.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:25:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] mgmt-api: Add Send HCI command and wait for event Command
Date: Thu, 14 Nov 2024 14:25:20 -0500
Message-ID: <20241114192524.1856334-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Send HCI command and wait for event Command initial
documentation.
---
 doc/mgmt-api.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 01a23526a4ef..b4a5776574f7 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3992,6 +3992,36 @@ Cancel Transmit Mesh Packet Command
 	Possible errors:	Failed
 				Invalid Parameters
 
+Send HCI command and wait for event Command
+===========================================
+
+	Command Code:		0x005B
+	Controller Index:	<controller id>
+	Command Parameters:	Opcode (2 Octets)
+				Event (1 Octet)
+				Timeout (1 Octet)
+				Parameter Length (2 Octets)
+				Parameter (variable)
+	Return Parameters:	Response (1-variable Octets)
+
+	This command may be used to send a HCI command and wait for an
+	(optional) event.
+
+	The HCI command is specified by the Opcode, any arbitrary is supported
+	including vendor commands, but contrary to the like of
+	Raw/User channel it is run as an HCI command send by the kernel
+	since it uses its command synchronization thus it is possible to wait
+	for a specific event as a response.
+
+	Setting event to 0x00 will cause the command to wait for either
+	HCI Command Status or HCI Command Complete.
+
+	Timeout is specified in seconds, setting it to 0 will cause the
+	default timeout to be used.
+
+	Possible errors:	Failed
+				Invalid Parameters
+
 Command Complete Event
 ======================
 
-- 
2.47.0


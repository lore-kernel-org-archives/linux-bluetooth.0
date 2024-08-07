Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9812A14C
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066103; cv=none; b=cQIGl4zxmQVtnj09l3tJ1VuHbEktPK0Q/wbEw1FG7bO7R3ZGqjb1tiBXRi+P9V0Cq2Ics9racY80PVkbBaWz88Raza6DCqI6E2QyxLpfOU76kHS55vchAlUEpQ94/olm98QgZP/RNOmjls4l1Fz0K5vbn5DOZaoKtkmk+NV+AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066103; c=relaxed/simple;
	bh=oAN7EliLUrnDsEzRm1rnTQCI3EDsGWO/Q9QC3PUG0lw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=adglrrpHtGHkItby8eD9hZ7S6/6YY1zYY5rY/n+o3J+EY2hG3c0Kb6MIiVLwfsMlxZpHMjtV1Bn4jqtUf8adDMyGMYUW/pGRUw1QlFeyoQO7tauby77kb1928fP2GpfjA86cbQa5CKlpoDlbZw7N/ErKh4ycwHxKzRUWJaycg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdnFvqi6; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdnFvqi6"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-494556dfa3aso101504137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Aug 2024 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723066100; x=1723670900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qclHKzexKMuNxGUFLGx+XZQmpxGczDy46V4MJ3PWfrY=;
        b=UdnFvqi6xG4tgKBfUYNsxZV85hZxfcWbAZeTBbpTZPOdRKwARgM2MP8y1Y5B+hlgRY
         C+6us+NgUWmKX/wU/Hb3z+twBQQLKKKVEQuGZjO44Xp5NBFQot2p4pu+pXkeLeFzRskY
         /C7JBNL1k0/g1SSGC1ivxMkYhTyeUK9leJBbI6BgoHtZN0Z03imjIHkbXBAmoo272X07
         /mvUy+9Gp7cVtVdfsKtpFfAEHkIylsSmzWQDGc0A2dxDO49iUD2NkzAlG6U3ak5wzoQT
         ER/AtjIpHEQpSgsal/coEKIvWLl0tlmqVbx0xsxgfXGPrLMUzTv+UKO7OzSrMLF+7ahA
         Lumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066100; x=1723670900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qclHKzexKMuNxGUFLGx+XZQmpxGczDy46V4MJ3PWfrY=;
        b=BIBD2F24OLYyw1f8R5t2mTQZlU/hwgWSlOfQDJiEHRlViDSi1PAFrhJOaE3jWfnJd0
         lI6gNW0sqijJhlnswKPNk7QiDbhLQBO1oT4vhJRyMDnXum//3waPFlWUw3h4bzFZraZF
         cnHQfnc5ZbWqNMhTLdD1z6FJV/HeV0X/C5ZeYv3Iuh+9vJzZ7Rcpkcwy1vfm6kvYleB6
         ewB2vGMA+rlorV7p/EwzMi6E1JX8rJboHefrjdhqpKTPht1XoJQNDePXXZYLr9kJ0CAQ
         R0CcCawGWQUJv86hiu2ZVmc8g7fZA1u4H3qfc+TwC4I4jSkUYtz4AsgKHv0RGYwrr+Pe
         h3wA==
X-Gm-Message-State: AOJu0YxiVxOJW0h9j4m998/U5wS5yKyZaRdeBZvTXd+L7f/ZkcjGoPgZ
	34tmi7yTtxO9RbL17rAdQA1KkDxymGIy5crLHSsCN9nyq11Kwhf812ugj3GM
X-Google-Smtp-Source: AGHT+IEOif1D8popzTZiP/MsAAyIuGW+AH5qp7Rxp9TcT1PLKNzIqKsiPzQ5TtvusPFIOu8iqWmu+w==
X-Received: by 2002:a05:6102:942:b0:48f:96a8:fa33 with SMTP id ada2fe7eead31-495c5b1f1c3mr54549137.11.1723066100355;
        Wed, 07 Aug 2024 14:28:20 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-83c09450925sm1701772241.32.2024.08.07.14.28.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:28:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/shell: Add support for comments on scripts
Date: Wed,  7 Aug 2024 17:28:17 -0400
Message-ID: <20240807212818.193908-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for entering comments onscripts by starting the line
'#'.
---
 src/shared/shell.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 88ecaa076adc..932dd7dd4a52 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -262,6 +262,10 @@ static int bt_shell_queue_exec(char *line)
 {
 	int err;
 
+	/* Ignore comments */
+	if (line[0] == '#')
+		return 0;
+
 	/* Queue if already executing */
 	if (data.line) {
 		/* Check if prompt is being held then release using the line */
@@ -876,7 +880,8 @@ static void rl_handler(char *input)
 		return;
 	}
 
-	if (!strlen(input))
+	/* Ignore empty/comment lines */
+	if (!strlen(input) || input[0] == '#')
 		goto done;
 
 	if (!bt_shell_release_prompt(input))
-- 
2.45.2


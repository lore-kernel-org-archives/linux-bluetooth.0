Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB23B19A
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147348; cv=none; b=G/QaolDhAZDA8pfEkUy8f+o/lA8fo6Mlzd830Nyw9Td4INP+SKt5juy71VHjfHhjs7h676qf3sBSuZTZy7FMBHiN8VXpNuZILlNpbLbqmXO/nMR0X/KVRhh+8ZzmTfIxSi5FNKBE3dIWj6EXcRlZO6t+O05NNEhJDAZpQHlTaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147348; c=relaxed/simple;
	bh=1zyrLZLlBovAE0zfs5zgFr/vCRp3dszXgwSWERtapjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DuYuuXNIe9vv/InxwNLIVmEdoUS5w3H68djTUIfKBwcNwiKzqOTAUGCNJtqcPv902DWz6iN8qy7FEVED6I2O1exK23GkO8WaTjh8pWZpxh4rbqgs3gRJU3LdGmYx9UsMhJc9C7Li95mqNOkT+mZWvQmw5500P9u8mHoIPzJgCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReZWW44I; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReZWW44I"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e58d28ebb0so437041137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749147345; x=1749752145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXA3dWbMYjMPkgl5Sx056TR7FaPIbzEG883Ro/fZ5qA=;
        b=ReZWW44ISiXl4LaZqwba37jGtPjWvTIbrWR3K2mDvWY8s9j2AR8OlQIGW+sI8z0t7r
         lyjJ0L7DI/Y3pFvy9mur4dz1z1RkT8xNCJ2V75tSMsTPFyegd375qHNGGwlEGGTXHZeU
         5iE8uuylgzUok/sMgSnh0BSnKEfJBwwD9ygB5i23YtA8AtxWf7RNOdtbryHX244Qo+fA
         ndVTZSKOrSSCiA+WdHA4T/WV1N1MefPSvNzyeW/oe8qd2Ru5+3k4yJOh3+yqHCZZ4yTY
         NQY6oH+SXVVqdwfGMl8Oq2l0ZmxDAwQ9HE+ZEbE3IB4Sb0hSV5xg5cWuJkhCfoklYH9T
         YZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147345; x=1749752145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXA3dWbMYjMPkgl5Sx056TR7FaPIbzEG883Ro/fZ5qA=;
        b=HQXJKiQMSBuB5c0PI9sJJ/AS9w3GM+EYDtmJq4qBdfKGbiZNGem+oFK1ngkZM39I24
         utw+24CIj/fB72QA5pqpvmpPsIsCAgLIF12YVbd9WXrMQPA2Gj7d0Y1MqGbkrWeLGqgo
         eR99v2YpoivjtfWbbqCW2su6jtar8zEUqnxHhshwljAVuGWwLGSdhbU7bQ8xgl3FcbNM
         Io3xHfJCAWSXy+n5odsAP5M4XSkPmtGylJFnTTT22wWSwyk6UKGepTz/LUl7yvdHwm74
         LeWropRJbC08IVF4R4rQsWvhhunvweN0Zf4SLEhFP3jwVdTLnkxWPFl+fpVhO7eNzTuf
         pS0Q==
X-Gm-Message-State: AOJu0YwgnvHh2NPmAWC8/OrXYARurARNH0m7dFu0Hvsn2w2hCibQjhrP
	ilKMl8nGKcfv7t6f6xfPj+6tFoi6HcFWmhY0F+sHxzN46r72vVLTSMXlelXb5cHCIvs=
X-Gm-Gg: ASbGncsA5IVCuuoNim7yRh9EpHh2As7Pjb1LkjThWVNK1CC64AeIiLadjS3YSAIaOnk
	64zzk60Aq6DKO/PAO1d9UCycrq9oig2Qf6fg74thfH4a3lHOBBSXxDq7kC3CTeU6/cJsDCZAf1R
	wPUV37TsB1FT6GtNahSMb8oHns53pD35hXYz2RucUPq0V637PWcvEKxGVuHOi0l7uU/ruJ6JRHd
	69XZWrTnTvV0BUaZqbmifClxWDP27fI0KPYU4ix2o66pKVY/q3efffdd4SZHCLeMqd1Bqp768id
	x97fUhOodqECinIbeLcGw7iNirTAg8FDX9Iuh3DufZHe2pCRuWcSnCrcatDDk0CKkeX8SeT/L5m
	KLl2EHZaa64dbLzgbvUJV
X-Google-Smtp-Source: AGHT+IHwhHZ8vkhU4bFxzGcxrnTXsWcBaZb1WcqGQcmk4xkt0lPH5gxNLzVWh/aQwzg0sc9ipX5SJQ==
X-Received: by 2002:a05:6102:809e:b0:4e6:a33d:9925 with SMTP id ada2fe7eead31-4e7728cd541mr483644137.5.1749147345057;
        Thu, 05 Jun 2025 11:15:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e64e9f7ff2sm11932499137.27.2025.06.05.11.15.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:15:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/shell: Add support for -EINPROGRESS to bt_shell_noninteractive_quit
Date: Thu,  5 Jun 2025 14:15:41 -0400
Message-ID: <20250605181542.854629-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables commands to call bt_shell_noninteractive_quit with status
set to -EINPROGRESS to indicate their execution is in progress and shall
not exit in case of MODE_NONINTERACTIVE but it can proceed to the next
command for MODE_INTERACTIVE.
---
 src/shared/shell.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 3e5959fc1868..6b4f7a7ef503 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1560,6 +1560,12 @@ void bt_shell_noninteractive_quit(int status)
 		return;
 	}
 
+	/* Ignore EINPROGRESS as it is meant for commands that need to stay
+	 * running.
+	 */
+	if (status == -EINPROGRESS)
+		return;
+
 	bt_shell_quit(status);
 }
 
-- 
2.49.0


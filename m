Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687EFC0E
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Mar 2025 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740906230; cv=none; b=ZYWtb//1CHWx5I4X2YMG1qprTyvxHrQoYndVCjhFU1adD1bJRqutTH/msfRx2qERBz9cAKQdSTa04Yll+yDqV+6qGyd0gqB+x+FK6e9ppSeLtHMG/Dd03Kx+feY3JJndkknXejR1LCTGv8rZqu/mtAJOD8vrbptmzy0ERFFEKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740906230; c=relaxed/simple;
	bh=CBn4bzpdABzgM45qN4znZFUEz3aV4OBhDxP10i+2SEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiBEbKqLD1Nl8+4KuIlR5Y7Mz4ZtTzANiMKhOWhsyP4QrreuisqC16hecwlffTF5kGYhExlAGIvFb7oSt1n3HsRJblRssKkRppjVCJd8HIGWuiPoLDL1TjhMDvaytmD5tXkX84k0HZrJsCT0ZSTEgiW4J4v3C2QbTGkGH4/aEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToLZWJwr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToLZWJwr"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf6f3b836aso43970466b.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Mar 2025 01:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740906226; x=1741511026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMHwQRszlNSB2UY3aaDkmUser27ieYOmK5gfjRrxJrI=;
        b=ToLZWJwrOtWyTAUCWTB12suloISEg0JJy9I/Wn8T1BNmsAZ9D5o2l4z1/7/+eG3ZbC
         65bC4hZesI4JhlpUA5t0mAlEAl4dz+E1Mwwafhhbv8bABpOynsQQYjrHkg4tv1Cgr6GZ
         XZPdE0U+OfwhPc3GPhAq64ZRA9Ccnm9CbpGmRKkMH+5mmwk0i0K000ObXCYSYeiORuXi
         Gc7JUh6KGhQUg177hZKk0IRVJUI/wBHIXI4DfYK+2r6STdsGx8SDAWU9drhfEfs0D5an
         KGx1Q4Tq2n08zVd278uQtzDwdDJVx/Of7UkqPv/9xtoY/iHlMN2Rarq3Ud+3B+fX4P0k
         zyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740906226; x=1741511026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMHwQRszlNSB2UY3aaDkmUser27ieYOmK5gfjRrxJrI=;
        b=VxJU3JBuYiCBH+nOcglWbul0ir79yJgATDfDunzhokByagtWulzDbbavV9bzT0kMzn
         tM4JfN2vjXpXakWYjO61euZ8injL6nmZMhANvz8UthDRsVaZYjEpIXLGG28Y0nf8Oaxq
         ZdynqJFO5ZCeQWdcMoz/2VaiNjM/Z+iHab3oGmFhD2LqgzcZ+t98qMP/xrqy7IXmBp/7
         cCRSnYiDqHVKfpJ0FbPknWnn2TzyScHmE4KTdpGTT8CKIjDPRmwUypDM3bEZhqQPnhFP
         EN+rGb6l3pcRe1aRt9J5QRlskssv8+Ep1Ly1dvSXrtowf0/80XMmb5KBBXZXv+7HfCg3
         DeQA==
X-Gm-Message-State: AOJu0Yw9hWuVL6NQj1mJUg+24G4OhY4m4qX73ILQCLDW5KvXGSA2QwZN
	qqDrnKyJ/1nlVrjssTxDq2aMucatD9ZqiA8gd0G+aHtW5FkPX0VkrZUZ7jah
X-Gm-Gg: ASbGncvCSUicV0XhjCgu8eDuDdPa28UaCBjmQURDEcsHDJ8rDtfSP1Ced6s4eBFPK8c
	+3xFtqD4MmbCtiK6zxiLR3EQwU7BRw33uAST9mzvmFCtY+Js1YkimlI2TSKs5HvOaxQAEnuuHoF
	AqO6oHxREhKt12EYk/Ysph7OiOEp528UgiIYV/wV5J1z0V494PMrGSmNjnq/lbd2KdYhXmrVuBw
	zmlrTDDWmc/DB2GxiYHo3vFjvd+4cYr4NLvZ6mvXTo4++5zJ9a8Nkd9w34EiDJUOH7fBqA2rjiv
	vsQdlaNecHTafrEtdCqZVV8vEWcK1hmJIJrIxOht80SCsZrfPpYmnJjkz+dU3D/cjfX3Ba1wfiA
	+N7nZPKKz2+6jRYYeLq0OfIKt3HZtW5wzUao+7g==
X-Google-Smtp-Source: AGHT+IElPk+OoTVTzsxtzHGNJxXRdpf/8uHwtCoJhaerm+D3SIDsxgrxmVM/T2/esujXRFHPONHyPA==
X-Received: by 2002:a17:906:d542:b0:abe:c031:eea2 with SMTP id a640c23a62f3a-abf2655ecbdmr1265618566b.24.1740906226278;
        Sun, 02 Mar 2025 01:03:46 -0800 (PST)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ed7ccsm624452166b.96.2025.03.02.01.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 01:03:45 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ 2/2] core: Report error in case of bt_name2string failure
Date: Sun,  2 Mar 2025 10:03:31 +0100
Message-Id: <20250302090331.17756-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250302090331.17756-1-arkadiusz.bokowy@gmail.com>
References: <20250302090331.17756-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/device.c  | 4 ++++
 src/profile.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index ec97fc889..aca28af8c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2646,6 +2646,10 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	uuid = bt_name2string(pattern);
+	if (uuid == NULL)
+		return btd_error_invalid_args_str(msg,
+					ERR_BREDR_CONN_INVALID_ARGUMENTS);
+
 	reply = connect_profiles(dev, BDADDR_BREDR, msg, uuid);
 	free(uuid);
 
diff --git a/src/profile.c b/src/profile.c
index 9fdfb7dff..ad2043628 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2319,6 +2319,8 @@ static int parse_ext_opt(struct ext_profile *ext, const char *key,
 		dbus_message_iter_get_basic(value, &str);
 		free(ext->service);
 		ext->service = bt_name2string(str);
+		if (ext->service == NULL)
+			return -EINVAL;
 	}
 
 	return 0;
-- 
2.39.5


Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372339B971
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014053; cv=none; b=OvMugVczB6AltyxRgAmuj9g7OWW0MnYMWA1DqiooLi1OVjqPEYr1UAKA4ZGefiEH72ss2L1te67/eC3TkHnnRqdjekGU8mbDl2CjUTM1rl5klcJ63TxT7vyJAKUBU1HGwXHuEVge2fR9VzeUwW7yM/K5q+qVlQX+0cw0Zkl82uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014053; c=relaxed/simple;
	bh=/WWHGzVPYBjImLaZwkHIKFspIDVadywregLwxqZ32l8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGd6t4KEMnfJBt4abTnarv3P8CJN+BjJWFtftrhcbb3qe1oEXt+5BBsz0oRVWGWw45+LzWBmZXUAofsDFEynAvnx8kmKnyts0iYn9t1isvW06o4j1l7n1kStQqxa1tvhIuTsf+p/TuAf+jb2VW/2a9+4TT5TCaLlBrr680U7zfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7UT0oCl; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7UT0oCl"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-628086439b6so4163093137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778014050; x=1778618850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7x/xj6nxTCm4Lil4A/8P3s6N01SrjnE+T7Sv2DEDM4=;
        b=J7UT0oClUu1a2IEGJcWwiinxya9U2KnQCRHWNAw/9fdde3td8+KgmHd5sp4o+vSONX
         LN0KdaGQcJOcUlDCcaDCH/FAoZ8fyRygMiduJoDTaX+3Mv5Yx8H40x1UuB5TTG6lqKV+
         PcaD2GL5lEJiQssnIKKb7kcUPAWUCOFiWBBhiSr3b+xHWbq6QWgs1ijt5UMP5Rj4L5fo
         d/siPIhUTSJNZV356hDc2c7fVCsb5+ZuPbmPMFe9EKELZCWdBHd5++Kw/Xd4NTAHyUOM
         5f19RyJg3BxbdbPDceuaYd0FuZZD5zQyRwC4qTIGTw2f0o+kRDy9xcJJOIWMFILlayLQ
         9C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778014050; x=1778618850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D7x/xj6nxTCm4Lil4A/8P3s6N01SrjnE+T7Sv2DEDM4=;
        b=MEGYwcwFWkQujGj8+ExlvcZoZvzMpGc9zExe9ls61hCZW8Moewjgp9h5nxk7cwb2sj
         TlCSQS8WEvzriZw1CUpn+8G71NoeY1dtwd1cLnyz/kjeIvDhDxoUQGVNqJvRLVfCJOTE
         DoseJOqxandRjZK/C07cQ4s56ZNyycRRhehv9I+X3MEUYKYLk0u+AXuJwIQpcKnnKnA4
         g96xsWUcQZi+pa/I+OItF0vIIrr6esK4uZ6HMNynAtGKUhD1TNn/tZizwR0GYau3qZqJ
         dHwiPsEFEbg2Oznc9bGO6u1GZtPyQPpLKrG54RVhoawZa3XjkSrs3z6NdT8Ko59Khemd
         Td1g==
X-Gm-Message-State: AOJu0YyEd/iNiitStQ1IfbSUN7vB1cI0lMr0tX1oyVE948daIg8F9jbf
	hN3BlI8A3S9CWiMY8MV30PuXS2tCs5PNl2W/TK2UIHEn1156vf8RuzSJ+r47Oxad
X-Gm-Gg: AeBDietn8OCDqky/1OcXjS8JyaaUrLRFsXRNxvdSYGa8yV6VWbS+VX5Hqnm3fB6o4CA
	nNi0i2qOfKyWPI0pTiwL10exYOVaycxeQtCUmVZKBvNB5PmZqTxnvGNlaQezrJuDVfbOu34E+d4
	zkiRN94x1O05Q2q8mgRpbrwGZ1o44xDwxoL24oYOhETsoFRqtrPi4M9BGLrFM5BrJl3uf9xAUfT
	/FZgvMONHeowZT1L4mmLl2QKofqFzIWIkq2xpF4nf0gWwBByjq2I3QwwO6eT1X8xL2/5/5eY3p2
	Xwt4nWTQlnR/0VQE5pClgxpsJZ488VtUrz5JCqPJQ6ChTBkdzZ9OkwIfgHbycSwxV+p+kCE3+53
	emeoxy2hGuypP3vAzIw7+Y7PTExPJGEJDeN6l3+/27Kad1uAojszJUWyx3SpDPFmTgBvJ6MIQmY
	P4O+jXnb41lR7rUeqjShjrBVJ/Xgyr7FhnUOauOtGT7Sd9p3JqbwPQy1UGqkoMdP+Nw4xtNxgmp
	6Nou7yTLOX22L6d2IPsVI0xoqaKOFZjMQKdvhk=
X-Received: by 2002:a05:6102:2c87:b0:62f:2ecd:3c9a with SMTP id ada2fe7eead31-630f8e788d3mr204828137.2.1778014050514;
        Tue, 05 May 2026 13:47:30 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfb14f1aasm8006629137.2.2026.05.05.13.47.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:47:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] tools/gap-tester: Enable hciemu debug output
Date: Tue,  5 May 2026 16:47:18 -0400
Message-ID: <20260505204719.1348473-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505204719.1348473-1-luiz.dentz@gmail.com>
References: <20260505204719.1348473-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add print_debug callback and call hciemu_set_debug when debug output is
enabled so that hciemu error paths are visible during test runs.
---
 tools/gap-tester.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/gap-tester.c b/tools/gap-tester.c
index 942c37d270b8..8c69765aa9c2 100644
--- a/tools/gap-tester.c
+++ b/tools/gap-tester.c
@@ -23,11 +23,21 @@ static GDBusProxy *adapter_proxy = NULL;
 
 static struct hciemu *hciemu_stack = NULL;
 
+static void print_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	tester_print("%s%s", prefix, str);
+}
+
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
 	tester_print("Connected to daemon");
 
 	hciemu_stack = hciemu_new(HCIEMU_TYPE_BREDRLE);
+
+	if (tester_use_debug())
+		hciemu_set_debug(hciemu_stack, print_debug, "hciemu: ", NULL);
 }
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
-- 
2.53.0


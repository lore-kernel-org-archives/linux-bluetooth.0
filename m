Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F58145359
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325667; cv=none; b=JafvFC9EVUBH7Z67NOjKlUliL0pYGkeVGuBPzH3pIqWp6tt0XLP5fWA6vJ+RuEgWrkHnqAVuqTK/X0XtmiCRrNEuKlWk5VWsBfqHm+p3NGGnPFItdCwSWukT+ZhjueA/usq4Aijo4stGdmOiXCZyYdQjs1p5pPL8Ztoy1CDlez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325667; c=relaxed/simple;
	bh=KJ5aZEj9beMNriHvwCGqcKSsO+iclSdRtd1BeylTsuk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AH7ECal4/epxdzvVCNzC4e4rbqkoQqjh5BG3BPG1SADyRLKt4dfacYc5bOoyF7LodWDIBAAqNi12PAEsmQMLQQKZhS8xLETAPhFRSUOc5pm6GtuDooISSLsendaUF0l/vAq4F9eZC6cOqxIFnqL66vVnIUU5plKCR6f5oNyXqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDshfRf1; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDshfRf1"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f2fb0c0fbcso473195e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721325664; x=1721930464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/LBgS8+/8ZWYwE+UEtT9VnUbhZgaOu+QEh9JqmYJzk=;
        b=lDshfRf1NYKJ2SJUjvBZD/CKCGLX5OeVGaZR34HJDZRX/6buzrp3tVQsbchNxovz/V
         I6Xa0ykaUHdD1c8BU7a5IqzzmBlQ4TDglEySj/MbHQWgo10aIB59O0S2MnyG8Y2u1SH+
         p1/LoP4a//cm5xwM+s0jeBX6lG8pZiINsPO2XTFg3zUKu76wLNGod3GYoJKBqpGq0TnP
         dy5/dX1l3Df5v9rwnBDq5pr3pTCc/t3OGdNmVYYGvK6SxSmhT/9pB/gAr6C4tBA6zbTJ
         WOdVy60qwj9WCOf7BnS11yJ67NBA+Ana8vQK5AUFsVBrx/isO1cFTnaCiRfjTINB7LXc
         +8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721325664; x=1721930464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/LBgS8+/8ZWYwE+UEtT9VnUbhZgaOu+QEh9JqmYJzk=;
        b=q69dpNfljL8wAXeDoWI67kaUZ2hRT7Xm/oSwk4D9RNeLrOQDfCPW56gcCJD5pN4G+D
         rU5dXy7uRNyOzbh56SEflgwoiwIfH1GpBSfhFX56YiUSHvqwozTojrnh9LmnTxAwB/y+
         T4yvC9i85OjkngGob9SWNG3kM5PYkZfwzmEjm3U1dEIwgA7D+Y/nJvtgLrkn2w9wtyd8
         N6ERu/QrJ/xELetVoftqIW7xdfrd4VyW7M2I7TSX4prXygNw8AVDgDbfh/bDalUumE29
         fCMl47m1dg/8T11b1kRHDBp62dOvpPeZcXegngwIXu9R/GOJXN1nE+MecfTYYJH2KCTM
         cgTQ==
X-Gm-Message-State: AOJu0YwqJXoTjvt+vTOzLp2MopoVV84b6xHWDCenf2LV6DD5g9ynvINW
	x2xeYMjkaE8gYOcCmNFZehOZFTuKkDA3++8OBmgkdK/7A62lDvnLg2+csw==
X-Google-Smtp-Source: AGHT+IEzmnmkhW2y2aZzKdP5Z56s2nDANhMP7d9gzk1K4SH9wykXNr68HhEXZtWm7DVgPqUSb4O+ig==
X-Received: by 2002:a05:6122:1347:b0:4ef:58d4:70e8 with SMTP id 71dfb90a1353d-4f4df687b8fmr7037915e0c.4.1721325663766;
        Thu, 18 Jul 2024 11:01:03 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f4eea4d406sm249230e0c.47.2024.07.18.11.01.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:01:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Fix printing errors when transport->filename is not set
Date: Thu, 18 Jul 2024 14:00:59 -0400
Message-ID: <20240718180059.1159551-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718180059.1159551-1-luiz.dentz@gmail.com>
References: <20240718180059.1159551-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If transport->filename is not set don't attempt to write to the
transport->fd.
---
 client/player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index a368c9c710ca..fdb62bac5f4c 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4892,10 +4892,10 @@ static bool transport_recv(struct io *io, void *user_data)
 
 	transport->seq++;
 
-	if (transport->fd >= 0) {
+	if (transport->filename) {
 		len = write(transport->fd, buf, ret);
 		if (len < 0)
-			bt_shell_printf("Unable to write: %s (%d)",
+			bt_shell_printf("Unable to write: %s (%d)\n",
 						strerror(errno), -errno);
 	}
 
-- 
2.45.2


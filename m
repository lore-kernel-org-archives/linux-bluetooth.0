Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2D374190
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023870; cv=none; b=gBDJOCiGZMK7i69loRjXmcdp05+yF4rh8w49kEpIQC/FXfOf8KDrMuC3icBkIuIpDWJuTmNYmnzLnLBGpM/t7+S405+yWuEDTKBEF7aYptnYjagxMZIz/ueZS8VtvoHoQUosXFUqn9FiarNlwOqtoOicq+1BpvYp1b71VChLSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023870; c=relaxed/simple;
	bh=oDi6yZ5xfHRDp30F3vA5Np0F0MNTvvv8REGnxlB8xMU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k8MeY859/tF12VITDj6eBFAhCzSsf32fbvwX6/ittbIccpIWz7x95qv0nVXWhg9hW5tgtK7oKBeNjya0rjLZRj4N2bkE1tTa4pgVx48Uo+NkmHSlp34mzo6rv1iXLwFj4XE6Q0qkjw/OI1SRDD2KjIAnPoFZ5MObvXiKh1gEplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knlLFlwY; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knlLFlwY"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59eb57ed4cbso2003169e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023868; x=1781628668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MwMwfad4Kyr+xfG0kKVdW1pRH7GL1boC0r3rGjkZkIw=;
        b=knlLFlwYnzLg6Xy834roFb16he3dJ3rUBa1Ui/5l3Xt7aehSAq5itgQj/f/itvqPrE
         JMDjoE0Pm+Ju2/rvUipe7u2NMD6ujfBEijmhkFV9f6FFx+22BvPTKsUIEHePAFmGLe6H
         OSRrLOOa+hsc0nS6Omol6xNrFep7m8LS4OSkAzLEXN76A1zfJ9c0ydkQUaG3OUkYjVvJ
         S4QIDChsu3GdxrTiaCAM9A75p8KDU+qCZURYkPzH8rz4ErfLrjwL6dC6lyGf14A2v6Wi
         QLFp9WbcjyL2dMNzdmZYLKlmrJ3R+HWGtJZYXoPQq0hV6f0tQFUC6peNQE/NuLivWCPC
         Q12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023868; x=1781628668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwMwfad4Kyr+xfG0kKVdW1pRH7GL1boC0r3rGjkZkIw=;
        b=L+3BQ7irYhac4DwnwAVHk0RRJuui9K82ZdkLI1vf5d+Gb2tJJvN9j8T1y28ZI3Zrz4
         aONDX9hlT8iZ2lOWyJnw8LvaIae9He+VU8bS68fgfVqe/WFdP4z3Jf/tgkAvqSfXxwBI
         gdBVbJoKrzsuLfuWabRwe6vNkv1TwznDCeQEzGGGLPo8yzZYxA6u6/+jKX1uFQr2tRJO
         6YNMzCVuHbQ38V34AxTRtqkykH9EM5h2vmvSo6ZaBU7bFSChJJW+MuhS+wict5+xzC7h
         8S96P//tt7HeOlsgv7t8Q6HItFznPQiA3Mfhmt5ABOXmCoikvuFB/ISeMmKa/f4v7KHl
         c9RA==
X-Gm-Message-State: AOJu0YxH+5B801zgR5T7IRCMAPNt9mW3/lj4JO17gqXa+z853gNaFOYA
	cDKo3x3yOPMC5h3rFsVUwO6zVsJbySfes0hHKD7YA4rf4K7m6VuZ8bBjbIpi8g==
X-Gm-Gg: Acq92OGGr8KQmImbLvjqDGOaARACZ5eBvE7P5YVQAxp8bTljPbVfsgK70i5iotm9cnD
	Q7+2/Dtsa2PGOlplxi73YCXPd/f9IYb89oh/ktaZpLeWDh0Y+aeFKs3Q8p1+bDRomr/dE+rjtzs
	FOGvddrI/udECTjVQxq1eVLhkJS8TidvC5QRg4KrNYMqFLCQD1QEZqj5SN7O8LBlEc3sz9xHdQ2
	8H9zrj1KXJJrauRRt70YzQV910n3gfHlXtf0ViFLHnYMgfrPBVAp++0Gp37UEIugVRMZfb58igm
	4jCduwtKE4G6OqYUuAhkjSlcKxjxwwjyZn4QTeFPHvpGgdn9PCNCrVfyIsc7ISv9qj+dXupANQO
	aQ9SeFTHWnj48BNtE7XCw6VdlGuj/NUWkP8IfIbgopPclWhhZEzK8zx96eAPNEdUIHK/3lOd8uO
	gBU1kdwnuKQPhjHWZxchsiG9kqKIaiUSFVO6yANWSTf8VcyOTk2HDhiSDeCKYu+7dmZWE5d8SIJ
	8I709HnCCm4IdWA9PZxyTaY3D3J
X-Received: by 2002:a05:6122:d02:b0:5a4:b5ab:b5f8 with SMTP id 71dfb90a1353d-5b6347623a5mr2094347e0c.2.1781023867691;
        Tue, 09 Jun 2026 09:51:07 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm18333721e0c.5.2026.06.09.09.51.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:51:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] btio: Handle EOPNOTSUPP from accept() to prevent busy loop
Date: Tue,  9 Jun 2026 12:50:54 -0400
Message-ID: <20260609165057.90837-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When accept() returns EOPNOTSUPP on an L2CAP SEQPACKET server socket
(e.g. AVCTP browsing channel, PSM 0x1b), the error is permanent and
retrying will never succeed. Previously, only EBADFD was treated as
fatal, causing server_cb to return TRUE for EOPNOTSUPP. Since the fd
remains readable, this creates an infinite busy loop that hangs
bluetoothd.

Treat EOPNOTSUPP the same as EBADFD by returning FALSE to remove the
GLib IO watch and stop the loop.
---
 btio/btio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index cfaa9392de12..8d71a210d505 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -254,7 +254,7 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
 
 	cli_sock = accept(srv_sock, NULL, NULL);
 	if (cli_sock < 0) {
-		if (errno == EBADFD)
+		if (errno == EBADFD || errno == EOPNOTSUPP)
 			return FALSE;
 		return TRUE;
 	}
-- 
2.54.0


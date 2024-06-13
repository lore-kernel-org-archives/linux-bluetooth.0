Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDE1E519
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286539; cv=none; b=qVWOIKsRaJEFGQZlgWYjKo/hiE3kXkBGuqvkSFMIssuomfp6Nt8UhKYP3zyJqL2gTvo5workxjWa+vBAD6FZLyJeADaoZGU6BwiP6BKgEmMcwMM1CIfI/eCQ67MUQR96ZinVGYpGVmxZcNQjd1rSgnloSSrQkq58VPBmxm10ZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286539; c=relaxed/simple;
	bh=ww0iArykb1VWaSlxWKGk3TTSUQss9T5p9wfMd1xYTus=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nFDP/K0PQ8RmPkpuiIOJ+i/WhMpqlGybiH6qBJPrCkozNi7ckeM5u4+kjf0dNywTjuqK2cfl26YcWBdMEvgQj0XG80i2ihWCBsO4lXTiFPBdC9TthzRQAitjEGbN5ggzagGMd7Zwv0qYq0hXPU7eFahCy5xuqUj4uUWlLNSZSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBL4NV9T; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBL4NV9T"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48c4720844eso1203530137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718286536; x=1718891336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6rituwGAGbrveCb/Vo6CbWjyRuxGzXLDY6B72cvwvI=;
        b=TBL4NV9TR9IPWSA34Ke4PirH6AYXqP+GWDSN8/iH0wQN5l9E2VJxPg/NExXWGmIvPY
         Al0fq6El1iPRuZtrYHgyIUmOAd1I/l18O2a5vw1/dhKQNfXRP4gaUzBaNaSDGtmMYC90
         6Q3K5db7+cd7QCtU+EP9yuzoBy4UrLwF8n763IG4JymEslTI9uIUTAmwNMkWlz0hU5fI
         VowT5Z03R0HsoozGWFmV36lKAeYo0Z6P29vKZbYd16H8c7tPsOiKr40xhHVxpiCEnpdr
         B1OzW5T3gyHUZWRn6302j+m8fSL9jDX76HDLdKIWoJQ9bqI6FbpH65L6lC6cAylkhYpa
         0TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286536; x=1718891336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6rituwGAGbrveCb/Vo6CbWjyRuxGzXLDY6B72cvwvI=;
        b=inNUZpCeXSQjyE31aIlqueF547tAdxCNa2B8VP5mtlKcbIcC7eUnKIX2eKGk0xGZCC
         zpPl3w92+XX5trE2ZeDI9O7ZYI2IrPTFR/LZAn6KsE0CGv3Mz3zieGAxp2IwIEgmD2gS
         F89wd4Jv1aggalXBb15NEb43DrTEhoI1yjYqTCvRgCTd6KwszT7FLofm6Pc7mwB5qBkq
         dZO1x67fFuzFQdGcxGk4Y2qG0/gB9CGCt8276p0C/TWU2hNeruTKBbR2vUEZuavu1w/s
         A2l5xXW3ei3I84g4iJHw/xEXmNnvGYeibcBwCTb22RPE487fFRi8wGusfY5pvdhbm9BD
         sDHA==
X-Gm-Message-State: AOJu0Yzn4kyHsilk5wK+BtE7z+Ob84kP0YYtpx6o+bVDe5GFzdU1I346
	RnlJgPF/DQokQ3UV8UGNqvC9talGLzWAbasSjcY4PY0mk2YM8uTpAzZTQg==
X-Google-Smtp-Source: AGHT+IH/y55e54qfpg8UwM+/M+jYcWukDlRu9BGxv9ieNOdkPm6B5vduDfEKk00ruTnmmIArgYl6Yw==
X-Received: by 2002:a05:6102:3bf8:b0:48c:3122:b76a with SMTP id ada2fe7eead31-48da06b0418mr2493528137.5.1718286536382;
        Thu, 13 Jun 2024 06:48:56 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48da438d5eesm247452137.2.2024.06.13.06.48.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:48:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Fix transport.send
Date: Thu, 13 Jun 2024 09:48:54 -0400
Message-ID: <20240613134854.1545034-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the usage of getpeername, introduced by 04153538aaf4
("client/player: Fix using unicast QoS for broadcast"), without
initializing optlen which causes the following problem:

Unable to send: Operation not permitted (1)
---
 client/player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index df5cb892428a..7a7598c397af 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5140,7 +5140,7 @@ static void cmd_send_transport(int argc, char *argv[])
 			err = transport_send(transport, fd, NULL);
 		} else {
 			struct sockaddr_iso addr;
-			socklen_t optlen;
+			socklen_t optlen = sizeof(addr);
 
 			err = getpeername(transport->sk, &addr, &optlen);
 			if (!err) {
@@ -5154,7 +5154,7 @@ static void cmd_send_transport(int argc, char *argv[])
 		}
 
 		if (err < 0) {
-			bt_shell_printf("Unable to send: %s (%d)",
+			bt_shell_printf("Unable to send: %s (%d)\n",
 						strerror(-err), -err);
 			close(fd);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-- 
2.45.2


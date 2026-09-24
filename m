Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234341BA98
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269924; cv=none; b=RTuekZl1UPYUtAE6gJGAJzkF+jIwxjZmvIuDKNR80iHvux8Vu5Y+ngCXv++xKf3oJdwlkZaJypTC9i6aVohYmznWgciudMfJSpMuwY/szcDxkaE2y3WPd6VX/1YkfaoxsErS6IUJp2jBk7FHQNQyUtuMKizwSs2BeDdDBDN+k28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269924; c=relaxed/simple;
	bh=W/ck1coMr2dEG4zPRjFcRqADFjpuUZK2WkTo5e8H+XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmcbElJ7Amu1g3qlsAK2svj+iPqQBpx4W8aOw6lYO6Q4PQm9JxddAIH9TkLzAcATGTw3f4B2Zyg19J9+1S/wuvcvB5B5vUIYThwYLoELn1WzFsJ+tSLZmW1CS9ynUUR+ptb7rB/wHXtelMib4CHpBy04CZ5S5zIyRi0mUDhmPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjhMsgPg; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjhMsgPg"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48435ae9ca4so1129f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269921; x=1790874721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yU4s4Q+VFQa//jnt2YKJ8f9M02v6lcYicWE3AjbReBA=;
        b=OjhMsgPgL8vBBvhp1cNW94qw0Ek3fP1H3YQwjf38OfUihQiw5WZGIfHidspjGez+pG
         H9i8wwhDf85rO0UmrV5Z7I33DwfpwDzVn8bGbe4pUJp1uX+Fjmkr+KCgOBY4EfRujiRf
         Xe7BRSkmCR3nOz8CN8aJ70JtFLrq6LI2LG8/r3IexunyC2JFZOgzGxQazPxr6g1v4+M9
         /4Cg05YsYrdA9uRtlExr0Kvn4clPav8fgEh31/TF0+eXzzjgNGNyOdpoclp3qzoU0WGr
         m/WbSUd1mzZUmkOF0/pt6iiXBOOdJttX5PuQa0HFSGCkx6hMMYyepDMdq4/w3RvAZvtc
         0Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269921; x=1790874721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yU4s4Q+VFQa//jnt2YKJ8f9M02v6lcYicWE3AjbReBA=;
        b=1eDuZHtfSnE2/493UHNeqgq6nY+ltGDO1EBmBDjSQq9HWBdnyXKAIj+B3uOpi7uuEL
         a65Uie68a10lLBqj5CshLAtbyInAwg+HnHdtyNZG/sx+BJ9b9XNbSxz94gofgJvDYZo7
         TEEv6/xbRhlb1p5tD/H/j6Y9Lp5mutu6RkllI0wfUVyUOINpGqFeRDv8yDmv7MdZqvpN
         N/DjbWPz60cpUPR2iP7l5HHBAAW7HqCI0+3fuAd4oWRmxPEVYvVGem196Ys0UKO6YnEC
         OBktHW2RfRmTQHwzFkeTlIMscGq0FyFrdMK1T5Qcitn4fzVI+D0E4RaLil8X/iiW+j7Q
         ELDw==
X-Gm-Message-State: AFuF++liBKmhMJtwE0u4i/h5r7wWMHrnW5q6Jt04VbuFaeCFsnIfhfhr
	PNDcxud4f+Y0bp+vuxvfrJy+5YEGmWFICcJPpRyQnMsqXyHGPhVtr8bFXhSvPmpy7dM=
X-Gm-Gg: AYBFou2OeU+L2MuBntergQehPxtJjYFhGO86idj2OkAeZ4IyFTuSQ5E5B+pFI9e9NE+
	FtlSEoKkUHfhXoAe/AyVzPXKIZ9SjcP+OnAMbfxUEX5s5/kJB2TWjKrxiL9PG5k6G+Z4uqi3Irw
	f2IMkALvthJiIUvvkuRSQyxVX9YmB6kfbSFNqiHsDRu95PR5lBRjNBdSpFmJw1R+tYNU+Q3pRu4
	dbZLAmVfKTM36t4krAgniZmkP/rjF84LOPeu+g3Ctir6Dqo8Z1n8jTNropEQxrOSN7kbiYyvOYV
	XnAJLMJvU//fCNDoqr5bOifDWgqP7gN5q7Lraprovk2N6f8+ZnJmVHTEMTAbpwx/CGrEBzKlKk4
	4LKt4s8NRQW9KcfupkPw4loCyMRFfzfZnz1YITTc3IznX9tSMCFxFLDtfJVSElF9WNxZQKwfAZb
	JfOZRsnRYGHdU36wzLvl8N4ARp1oMPenk1045rFnrXUcU2V8DZmt2nW1tiXRpvqFWeu/hz3TcHL
	n6j8VOXz3BPbdRxKshWhqVeSkSlHQqnithKEqZBJhX+BV+FzYdpNmU=
X-Received: by 2002:a05:600c:1987:b0:49e:745d:5768 with SMTP id 5b1f17b1804b1-49fe66840f9mr53011835e9.0.1790269920458;
        Thu, 24 Sep 2026 10:12:00 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bba615sm95590585e9.7.2026.09.24.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:12:00 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: [PATCH] Bluetooth: MGMT: Fix status of pending commands flushed on power off
Date: Thu, 24 Sep 2026 19:11:58 +0200
Message-ID: <20260924171158.804136-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmd_complete_rsp() receives a struct cmd_lookup and, for a pending
command that has no cmd_complete callback, falls through to
cmd_status_rsp(cmd, data). cmd_status_rsp() reads data as a u8 *, so
the status sent comes from the first byte of match->sk's
representation, not from match->mgmt_status.

commit f53e1c9c726d ("Bluetooth: MGMT: Fix possible crash on
mgmt_index_removed") changed the callers' data from &status to &match
and updated the cmd_complete branch to match->mgmt_status, but left
the fall-through passing data unchanged.

In mgmt_index_removed() match->sk is NULL, so every such command is
answered with status 0x00 (Success) instead of
MGMT_STATUS_INVALID_INDEX. In __mgmt_power_off() it is NULL too,
unless a Set Powered command was pending: then settings_rsp() has
stored that command's socket in match->sk, and the byte sent comes
from the socket pointer. Either way the status the caller set,
MGMT_STATUS_NOT_POWERED (or MGMT_STATUS_INVALID_INDEX when the device
is being unregistered), is lost.

Pass the status the callers set.

This was seen on a QCA9377 laptop: bluetoothd's Start Discovery,
pending when the adapter was powered off, was answered with Command
Status 0x00 and no parameters, and bluetoothd 5.72 crashed on the
zero-length success. BlueZ master has since added the length check
on that path ("adapter: Fix crash on short start discovery reply",
BlueZ a734b06059cb), but userspace should still be told Not Powered,
not Success.

Tested on Ubuntu 7.0.0-31 with a virtual controller (hci_vhci):
power off is held in HCI Write Scan Enable while a Start Discovery is
submitted, and the flush answers it with status 0x00 before this
change and 0x0f (Not Powered) after.

Fixes: f53e1c9c726d ("Bluetooth: MGMT: Fix possible crash on mgmt_index_removed")
Cc: stable@vger.kernel.org
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 41956cdde982..251a896babd5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1495,7 +1495,7 @@ static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
 		return;
 	}
 
-	cmd_status_rsp(cmd, data);
+	cmd_status_rsp(cmd, &match->mgmt_status);
 }
 
 static int generic_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)

base-commit: c9c15d4d8956df8c564f7c210e4dc5b9b820d97a
-- 
2.43.0


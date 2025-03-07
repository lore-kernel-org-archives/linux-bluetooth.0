Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15623BD12
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365284; cv=none; b=PK17DP1Fj3/HbUdychfIb4FW8vNtzIBC1rn476yNG9JwcpDP7c8K8d8+05XEmo242koMMhayFNKsrH/1LRKUZGUjIDsuB1gXqV+LPGI0gt85mSs529S7WM3weCopi3NkT7lBN72BB7LCcGK2f5syGoyInVxngQ3km29soaVM9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365284; c=relaxed/simple;
	bh=oMS3vX8OgQKLGwETUQUCPA51UatGLMC8mPzBIDujIso=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Vi9S08kVRalXPv5zsGcWfsTCqsOSBgvPlq4jHlUizbrl6abBwXsKD/1A5889RtqhEswcgg3XRB7eAZAQVrCT86U8nyXYgcZA8T8i9qsLulTQFGoBNMjnQeAp0mqA6bBhKFA7fMiO0gW4lWwI74LRdzSN7mGkciDAFjtjT2c8nmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKIf4k0N; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKIf4k0N"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52379e9b7d2so974181e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Mar 2025 08:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365280; x=1741970080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GUS0FaB9U85TxZITEh1gdO66tP3rI9TLbW9zQl9ISls=;
        b=LKIf4k0NfFgC+6LFqIkjmMHw4QXoGH12Db+c2Cze5JAC2V34LvB4I2Fp++HfFyZvux
         mjJ3FiE9H0ZFAiUQUDgkZV+PzkWcHnE/v25L9oUZqVjQsSRVjOEuawyWWvLrr6AeR3mr
         I/s+G7Aq2EUoKikaeq0XYISX54HKEzUBtcfELJ4z9lCsZzh+yXFA09JssNuMJNtIlNoa
         H9T0+AYtlu0TcXBGB+HkyRIWyIn2ub1oHTvcIR0sPvTob7c39U5/qqgQYEZ4cYPEh3SO
         kJ3qkhfugYYxhsrtk1uMtfJBQ85rE58XcTRFbLHQddHM3AS+SEw/FECnU+tXsYL3o15+
         EpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365280; x=1741970080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUS0FaB9U85TxZITEh1gdO66tP3rI9TLbW9zQl9ISls=;
        b=NPjOBaNkfS7JJAQHBqro3smpy1RdMFVnyl+Wu6H99IkdlIttqbUhBK88oGWCqdvOoB
         gQdqZ3Lc3kAyhHvVzGlyxbZuWxk11rTWNLTfsbW3vAp3fvwlNpXiAusqlejlfiYTrYo4
         5TvKctkT+r76J1kpb+L8FKqXgyBm0bUwN7wLBo9Rtm2KgilPR7vOg0eA70D/NqvYmZcL
         jw/pjfrqkDWsAPzLIoebaFDR1k0fhCjm5GepoXEFGZgw7uXgvlNq00o5NeMt310SvsEq
         PPVTxEASSQYPbBow7F4JJHZ2Dzz2GmME5CEWSY+Td9BpuEDN4z732N+pGLxWN2FP7M/L
         j0hg==
X-Gm-Message-State: AOJu0YzXBi4tSxya3XBKNpuplWvR4X0J3Hqtl8twNBk1hIe15ZK8RuEF
	as73yh8+M0XRqSFikjy5QvJ2ZnXOVlEqFRg3SGwCHiEkJ+lLXNfV28Iet/UR
X-Gm-Gg: ASbGncvU3I3mtCf4Qo0NYf1KKpWyWozjfbEu1Z/z0lYTYDK0sDDee/PiiY56sdc8+GV
	NC7EOjrM6GytFBAjtZCw890jFKwdhOGY2eU2Um2CX+KMuslHnrHxnISp5g8wuseWFVyFlqbpgPC
	9f8OZK6Z9lst0vJc9DR/DebNxfN+r1FoivCuhdxHg45xwGuqH+H4hEeDEMsk6tFeJ8ooElbjp+y
	NNvCccnMVKH8tQ8aVMmMzyI2LeEcDviaByPfpfGHwJG9GC9G92pqSmfywtlaUDRBLU6OBwofBZv
	vAfgRE8uuPF6Kn0YADrr1uwIavrsljNhlDAUmhG9ku44sQKhZiidhN1akvS6hGnALZyewpxFhkJ
	0Ow9mlXsgpjsxCA==
X-Google-Smtp-Source: AGHT+IGG375iMiwPYmBUJVKWMbRUYpcLdRLouZidfs2VP4oh4KUhZPutcKsMmLmD9ir+CeEHSsmULw==
X-Received: by 2002:a05:6122:1d45:b0:523:c4df:4de3 with SMTP id 71dfb90a1353d-523e4088cc2mr3082202e0c.5.1741365280073;
        Fri, 07 Mar 2025 08:34:40 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8c834dbsm596190e0c.36.2025.03.07.08.34.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Fix changing preset SDU
Date: Fri,  7 Mar 2025 11:34:35 -0500
Message-ID: <20250307163435.49599-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes changing preset SDU when configuring multiple channels, the
SDU of the configuration is the one the needs to be adjusted not the
preset itself.
---
 client/player.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 17817c45a921..9d38347d6b91 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2296,8 +2296,12 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 		/* Adjust the SDU size based on the number of
 		 * locations/channels that is being requested.
 		 */
-		if (channels > 1)
-			qos->sdu *= channels;
+		if (channels > 1) {
+			if (ep->broadcast)
+				cfg->qos.bcast.io_qos.sdu *= channels;
+			else
+				cfg->qos.ucast.io_qos.sdu *= channels;
+		}
 	}
 
 	dbus_message_iter_init_append(reply, &iter);
-- 
2.48.1


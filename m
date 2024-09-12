Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92E13E41A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159499; cv=none; b=hnDPM8h2yOHFzdEmR8OGyVe45eY68tGm87QM4bd+yDr2YdmEwsIXkUjMeCCUQV0bUIW3jOQxbhOht/hWp+zzdSB9uqTukW29Qn4GDrTDGkHiNVE4isvLG9NNclvHUtr4mVQ4PXLdbd6+hyvysMHnDSfYn9PLDvGIdmdOKm5IUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159499; c=relaxed/simple;
	bh=qOhc4pMGBoTzG9Ge9ClFLwKUUXxlu/Q7ouQ64tFRkc8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eSJ9hWVgLVo6584hjKYta74Rmqhl9CBI6T0mLqAOYC+sF+0EwGl3AoC7bxbRmSMDLcgzbFcjX36fp32BzKq8MOKhQtcG+OwZp2f9UgwfmhJzLaROKRl30No29N3UVDSYFTxeFcYVFrbMjfRp+q0vhuNoZowTbHix0V4ohzRcfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWytBjVE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWytBjVE"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-710de2712eeso29698a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726159496; x=1726764296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5IAVNM5AfY8mofYehKEcfR+Qvea2MQOqdy6ZK129jgM=;
        b=iWytBjVEUGWCOC5dsM9hAnmZ6kz2yCiICajTWuDTLKjI6eRoelR7ZYakv3AWpb2FBt
         x/zO/6AUjQxDyz2Zp2+jiJlwkyIS9Vyott/q5xr0KJi/1wU+Dbj4Zo/ZWkV0RknJZZCv
         hhyDWqb+/ojxQfSbnJRzfKsWO+65pglKjNxM+8U5+LjBHmwD7ZXoQuFTEcZy9G84CoWs
         11SHjaWklaQWUmPlXjotQpDfYJ3FQj6JvHv/qvPQVJAFGFuSJmiMAbpsu3ZptN7MnZEg
         ltKSLfT5KQma+zLa0kpry8C+WbGg+1ap37F9pz4iN3wEX/GWvGeLflEoUtwcc1zqbYDG
         dJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726159496; x=1726764296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IAVNM5AfY8mofYehKEcfR+Qvea2MQOqdy6ZK129jgM=;
        b=qaejnS0tkzBp3aZoAwm96bup02yOCf49BCH5zabFgZnefC1TwTeTbJ61n1dg8VVHNL
         RuTlncQyllBMouCjFpEOUTsaITEu91nS8QwNGTulo39c7wjrPfZm3WmBjuUYf5Ieh/Wx
         Bd8b+7GLAC5eMkNu+EJzJTSceQo/JgqCzY5OMIigh2bcuLSNiRmRuCgKroeOu8ATQ9Ny
         67DMisYZmynR5rKdqKLU2f5nD9GCVQjqyLP1pupR59en7T51wQQbnqHjyQbQ33TldrIQ
         dck4vwU/eUV76Tp7kX4kOE/8okn9YixfuWM4BHfgePPspvMemE3LqZ6ir0kgvlAQ33Oz
         Diew==
X-Gm-Message-State: AOJu0YyOPYrXZJowdjO4ygnHJ59yfFx8290gnQLNHZ0hyD/L/NdlX3Wv
	WMewUvsPyw+gr+exLOhJFmbOgQtHFxwDHE3G1gmyLPCK1xafadX1NcAGKA==
X-Google-Smtp-Source: AGHT+IEmTvtDe2mg1fj+qRmyZ+Bzni1T+ehsW4xxkFQYp7ov+4JnQwm2jhKBJBYOEeDgs09QYory5Q==
X-Received: by 2002:a05:6359:a39f:b0:1b5:fbe0:cb06 with SMTP id e5c5f4694b2df-1bc394075e6mr3329055d.6.1726159496054;
        Thu, 12 Sep 2024 09:44:56 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-502f9a32199sm771848e0c.9.2024.09.12.09.44.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 09:44:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
Date: Thu, 12 Sep 2024 12:44:54 -0400
Message-ID: <20240912164454.2996352-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If mgmt_index_removed is called while there are commands queued on
cmd_sync it could lead to crashes like the bellow trace:

0x0000053D: __list_del_entry_valid_or_report+0x98/0xdc
0x0000053D: mgmt_pending_remove+0x18/0x58 [bluetooth]
0x0000053E: mgmt_remove_adv_monitor_complete+0x80/0x108 [bluetooth]
0x0000053E: hci_cmd_sync_work+0xbc/0x164 [bluetooth]

So while handling mgmt_index_removed this attempts to dequeue
commands passed as user_data to cmd_sync.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Reported-by: jiaymao <quic_jiaymao@quicinc.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e4f564d6f6fb..1fb5c8022610 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1453,6 +1453,11 @@ static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
+	/* dequeue cmd_sync entries using cmd as data as that is about to be
+	 * removed/freed.
+	 */
+	hci_cmd_sync_dequeue(cmd->hdev, NULL, cmd, NULL);
+
 	if (cmd->cmd_complete) {
 		u8 *status = data;
 
-- 
2.46.0


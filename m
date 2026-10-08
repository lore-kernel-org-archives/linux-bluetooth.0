Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446B39A7EF
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439443; cv=none; b=qoB4Si+T1Q6aFb3ZGswBVYWr1aMkuYiPH/V0Ix42scmFTy34+COFt1/MHc26O07z50iPT/02e8q0xfUOwpQvHb4jT7tn0TwT5lNpO52NhDPIRTFKSs2np2AgrqL0HQ+YdLE8rmJs9jlwtd+7bEXEhx8wM/tScRBHbbwZ2Xqle1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439443; c=relaxed/simple;
	bh=PcW31aLcf7QLC4AFyS3qRN9LhPHMzg2IsGPcFvZQ/B0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RTQsTTfC12TTvb8ejVbBssw4qI3GKimJZ0p/9J9CEFG4TGE3k4k+jNZ6rW6pBhkbHY6A8YU2nqHPg9yTvaoZmWcB4W9qjU6JdJ4yXcMNI4vqTBB2/OcwimrMU7QMgyn3cC1b2tE3Yw6W5NPnNVxELMX55+ai0U9rusfe6+YcGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boekfo6q; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boekfo6q"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1486160a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 23:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791439442; x=1792044242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVfVT+UFtA5oYCaZRmFTBLRBViF4NDwZkeVmLB9yJho=;
        b=boekfo6qv/pvKGqXukdDZOIGXAEYcAewXA0vPEIQ4xwSZUf2nIT38jQxZAgQkYrxj8
         D/aEApqm9/4JQL2w+QvpPq12bAOnK12IhdkK4J8+zbksdAX3irP4jO8M9aAaHbJF4t34
         wYC/xwfw2dk0r5/G2/FLF4feidpxWhbFJNC1urPi6rb8ssQNuXC76A59TU4fO2s6IQb0
         SCQa0iyqpkg0S7GTDwozs4LDmdrg0sdFAinFGvvzGjHOhfvirGQJ792vH82zvoDEwbZr
         uSDDLjVkSk7l7OYV++JKJcgtrdqQEuRab1y5hjLNLVwf5R60GilgLyvoLbCuAJr5YHmK
         BFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791439442; x=1792044242;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vVfVT+UFtA5oYCaZRmFTBLRBViF4NDwZkeVmLB9yJho=;
        b=dxGF3pScOrQxquTfxwGilJLxHKc2FEYLhLVwhKyo4mDoFcDOsD5XDrX8kisPpbWJhM
         rcxkbCGiBFXSOTllOZb+S62l957zrBJXD7U7L9Xu2yWH8uyQMz5uJ3kcWzC3X+jLj6o0
         3MWBsMzPOW7Bq4AgZo7eMUhkHwU30czPav0iK+jBAv+6jA0R859Dd8mdCpHgRoIaKFVs
         0EZBwZDcwg21jRzFnKJ4zml+1UU1E50VcdzCmAZEqCMah9mCcMUunpdTiUaGI/XmKDKj
         ThTZPfEy4yq4YNwQa0rxDs9VAgUtei2DY8kXdpdkOYLoJcp1Fsk7ArEcy5y27GywRGsz
         jFwA==
X-Gm-Message-State: AFq9FYLE0awyxN3aOapf5u/5jFTwnj8/MVfnXiM4o3CT65lrpvcRBP/l
	TdU6LdPAH9LO6c3O87Yj2jlagHt21Lb6A5M/N1qAQCxjrOg5a5lNp28h
X-Gm-Gg: AYBFou2xF+inUfL883brbATyaiNst5haDHm51OwQhmmbi/uuWPh6LQTvML5zAxBXFAk
	A3bMUsTp7uuDbU6CNFIvwHNLSz/Td6C96GWpCgkRWRTq3BLI/zn8ytv4FZ0JVSpsPXxXMhz6NUE
	xj7UeQUORnHuU8gXbtkkkvTLgGh5BJU/rHovQT3geAD3wUL7+P7regCetVP2nAbuqmJYug6G+Y+
	DojQpMb9Qox7UWhq1wT13BSvE6y11qLban/VprsuD7VXtP4DkhjkxLlXbAUlsRIprKvg7G3hvI5
	7R+R+58c2jh+JpbGRdEmVOFuCgefBBuQykbSfy2JqclBjQihFNTN33GYJY4oMZTHnmZ1gDxPs/U
	Sr11xqUEL8lOpopRpKY+J/WvR9OPOqO9HH5QY0mIxAbxiJJ+cSAUJjBuNv82a3RM8JtxLkhValT
	Nu7kcD0N7CLhMgGls6gkU2D3VSWTpMZ+pdiCHh+edTB09hCGMjSf4ndoP5Oldl55v6MAMuct1pK
	ejP
X-Received: by 2002:a17:90b:4a89:b0:3a4:f6b0:7de with SMTP id 98e67ed59e1d1-3a8a08515acmr4074044a91.22.1791439441844;
        Wed, 07 Oct 2026 23:04:01 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aa0cbccea3sm2622298a91.15.2026.10.07.23.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:04:01 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: MSFT: Serialize handle map cleanup with event processing
Date: Thu,  8 Oct 2026 14:03:55 +0800
Message-Id: <pm-bluetooth-objects-candidate-0242-v6-e48e08db5265b66aeda9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MSFT monitor handle mappings must remain valid while vendor events look
up and use them under hdev->lock. msft_do_close() removes and frees the
mappings without that lock.

hci_dev_close_sync() clears HCI_UP and drains the RX workqueue before
MSFT cleanup. However, a transport callback that already passed
hci_recv_frame()'s state check can queue a vendor event after the drain
returns, if no earlier shutdown callback has quiesced reception. The
driver close callback runs after MSFT cleanup, so event processing can
overlap the unlocked removal. msft_monitor_device_evt() can then
traverse freed list entries or read handle_data->mgmt_handle after it is
freed.

Take hdev->lock while resetting monitor states and removing handle
mappings in msft_do_close(), as normal monitor cancellation already
does. An active event reader then finishes before its mapping is freed,
and later lookups see an empty handle map.

An instrumented kernel produced the following report:

    BUG: KASAN: slab-use-after-free in msft_vendor_evt+0x1906/0x1990
        [Thu Oct  1 15:01:51 2026] Read of size 2 at addr ffff888104df3602
    by task kworker/u17:2/502
    [...]
    [Thu Oct  1 15:01:51 2026] Workqueue: hci0 hci_rx_work
    [Thu Oct  1 15:01:51 2026] Call Trace:
    [...]
    [Thu Oct  1 15:01:51 2026]  msft_vendor_evt+0x1906/0x1990
    [Thu Oct  1 15:01:51 2026]  hci_vendor_evt+0x6f/0x90
    [Thu Oct  1 15:01:51 2026]  hci_event_packet+0x894/0xc70
    [...]
    [Thu Oct  1 15:01:51 2026]  hci_rx_work+0x3f8/0xfa0
    [...]
    [Thu Oct  1 15:01:51 2026] Freed by task 499:
    [...]
    [Thu Oct  1 15:01:51 2026]  kfree+0x307/0x580
    [Thu Oct  1 15:01:51 2026]  msft_do_close+0x238/0x750
    [Thu Oct  1 15:01:51 2026]  hci_dev_close_sync+0x546/0x1380
    [...]
        [Thu Oct  1 15:01:51 2026] The buggy address belongs to the object
    at ffff888104df3600
                                                                which
                                belongs to the cache kmalloc-32 of size 32
        [Thu Oct  1 15:01:51 2026] The buggy address is located 2 bytes
    inside of
                                                                freed
                                32-byte region [ffff888104df3600,
                                ffff888104df3620)
    [...]

Fixes: 145373cb1b1f ("Bluetooth: Add framework for Microsoft vendor extension")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index d9dd722db3..667c9951c3 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -681,6 +681,8 @@ void msft_do_close(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "Cleanup of MSFT extension");
 
+	hci_dev_lock(hdev);
+
 	/* The controller will silently remove all monitors on power off.
 	 * Therefore, remove handle_data mapping and reset monitor state.
 	 */
@@ -695,6 +697,8 @@ void msft_do_close(struct hci_dev *hdev)
 		kfree(handle_data);
 	}
 
+	hci_dev_unlock(hdev);
+
 	mutex_lock(&msft->filter_lock);
 	list_for_each_entry_safe(address_filter, n, &msft->address_filters,
 				 list) {

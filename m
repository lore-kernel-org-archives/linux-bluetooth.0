Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B0357CF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738631; cv=none; b=OGC4RFsWyWL++FXPWaZWj9SMJoYOsuCz8jPYHAolyTYsgclSsjonwXq4U2Rkr07mxABTwCxrfbDSN3NjT+81RYX/tnkDK1mHqIdVEzPbNRBupvZeiWW8Y0hCjqQtjvMfu4n5h+nfyJcjmZY2hlpU2T3H1L61gq5RoBin9Ru8H9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738631; c=relaxed/simple;
	bh=SGPXMJFs74VUxvhHjrZJrTOkAsRTRWbxiMW5TgSw5K0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=i6SPp0+7dXwZv5njPrck1bE+tz0jUwG4lZ6s2xo+9Lx75vMp0Rn53CC++K1x3dV1c8oQOiJLN+0OyJYBQqgft7wvmwZWHlXPz+8ZRQMUT+aTxdhNWb8H34dg9TYbgsGzWd2Oo+MmKFyawjtEleJMVYXGTBkLcIaSa0ck6xRIjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BjO+/QFg; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BjO+/QFg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778738617;
	bh=9frWUvJx74a+RCl0Ue12zO/yVLpFFLAQGv678sl5aBE=;
	h=From:To:Cc:Subject:Date;
	b=BjO+/QFgfmx5GZo92H854vzg1uyjoVltbJhlAQ0Fn1k60oU1+XX24PTypPkhe1wlJ
	 +PWQBhX+Wlp0XUAxVHunCxfNjfXGzsuQTA5La+F4Q8f4legCqh/vi7l6FvMfRFLcJ8
	 9x5J9FiKpAdoyg3f0gB43xDaXio/YlAACbMuHmE8=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E319E98; Thu, 14 May 2026 14:03:35 +0800
X-QQ-mid: xmsmtpt1778738615teqrwjhmu
Message-ID: <tencent_05373BA21CEEB5195F2ECCED0C77D0C57108@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2/7JwRM7+25tZPfpTr0mIEwJuw0RQOYICwFUA/GUVh8AjYTYDcc
	 0eWz3/hGDkDEBMwACPbmsTjz6F3R8jCINs9zE6TOrhzvRlBTqGDLph0lKbtfXMfGR/5iCp6on1zV
	 foBwDg3PbF5zTTrS2L6WVotfDii5WGy+GvQ+qr8lasw5sARqA92fUbrDh5UTbuUqOacVW9ZEtOIY
	 LZ6axj7WEMJ0hPzgSbNdCkn8kJmnAXNibbRG9qjXU2loFCypHX+QWEMgRMSeGVHsNN0MBoXUHXJu
	 kGuRvstK+QT/P9gCAaMigtnEQyFJpoFPIdkD14wC3TNHxRW3EJXN4h+EJCNhRY+vIfgdvwwb/JNj
	 uPRH4og4k/rI3O3jzJ4m7K+L4faHJ68OJrAnSyktvYSTklFGDHsSsRCjRt71Fql193ZeHQdNSv2X
	 tZPRsbnjKrO7lYyNXT6ErLXi9lE2jSYxmqwsq57+FXcDcAGbeutTmeSPfkgFXDnkNTkGpq46SOlN
	 tusQRvwWXM6taP+SgabT57wY47JXjR6jpypDzBpOfY6YdbMfO7BC4U7K5rk4M1ShJXaPBYYWGZUw
	 SWujYAbsvHl2qeX8qHGivrTjkgeQHY5G18XNHhsINgp2FQbtA9ShZQ3jEF/hw7nvNA45+huNJYDV
	 EXj4PhddAQGsoycUmEMBwBYAxriBAzNIZjjVQFMMwEh2VKz6DVhqu7ieJHHzMq3uQR4FMB+yupFY
	 jktcBb4AMky5vJSEDdFsAfW5SZrXhU8KEEFGfjozNFxe95WuXB1h8nynrXHzEm5J4tITfngsom37
	 0PhG3TpnIB0GKMRS+ywHvhOe63aGWQJZcjGtw6M9RlnI40xxvBOkit2cU23eUq8PchRlaRqiJNqm
	 1UUjEyXM2Ql2eObUQc5PDG1FR0vN22Lz9MpD1ar3YLk4L0h2fr9efPmKjOb6yfhh/r/h/5aTbBqB
	 /wKPFCUYqu77y/hse68jCzpurZDMQ+/xxgwMwQHZ3cwyf2mtTqxX8nTKZvxz8DX1Ve0ScrVB7pmx
	 8JGVYNUc1oLs1zkDTP
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Zhao Dongdong <winter91@foxmail.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] bluetooth: btnxpuart: Fix use-after-free in probe error path
Date: Thu, 14 May 2026 14:03:31 +0800
X-OQ-MSGID: <20260514060331.221418-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

In nxp_serdev_probe(), if hci_register_dev() succeeds but ps_setup()
fails, the error path jumps to 'probe_fail' which only calls
hci_free_dev() and asserts the reset GPIO, but does NOT call
hci_unregister_dev() first.

This leaves the HCI device registered in the system with its backing
memory freed, leading to a use-after-free when userspace subsequently
accesses the device (e.g. via hciconfig or bluetoothd).

Fix by adding a 'probe_fail_unregister' label that calls
hci_unregister_dev() before falling through to the existing
'probe_fail' label. The original 'probe_fail' label is preserved
for the case where hci_register_dev() itself fails (device was
never registered, so no unregister is needed).

Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 drivers/bluetooth/btnxpuart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e7036a48ce48..a4d7747e5be0 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1907,13 +1907,15 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	}
 
 	if (ps_setup(hdev))
-		goto probe_fail;
+		goto probe_fail_unregister;
 
 	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
 			   nxp_coredump_notify);
 
 	return 0;
 
+probe_fail_unregister:
+	hci_unregister_dev(hdev);
 probe_fail:
 	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
-- 
2.25.1


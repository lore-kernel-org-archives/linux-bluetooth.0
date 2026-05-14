Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2339A058
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758914; cv=none; b=PulbQoBt1eydsS2fYiIdRgoCHAPk1A8Ybvpp1DfOqELoA/k7ZIS+Rxq79RCWWAlMAbt1/YxvjzYlYmk2DNGyths04pSH7pWsb5XhQyTLqd8vyf0FZQbngtCpJRHNy6yeQqtld0uNRyres+viImX2zxO0Yx6kGqTTqdFduVZId68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758914; c=relaxed/simple;
	bh=JUYUW51PUVkT/qNbpDvTak4F3bMG/W//sLg2vjalukQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=b5iIF5sCsDOs9prL3f36+Us8sBTZKn4BQPZycbow5gaIpROalnJUx85y2+RqSXU2EdujMf360wLJxs7rGVKqLmwYP1WFycbU8fySXIvszfGTZuT4JgXulihCKAghxxWxp0wFP8sJZ1TM3c1NhlTTKpm2HGOv9lrYqAOXorw0c/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=FwABktri; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="FwABktri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778758900;
	bh=7KO5Kbw1mH+/kJcRlir1fXZVq1p3vdzqU3B1WUFATEM=;
	h=From:To:Cc:Subject:Date;
	b=FwABktrijH3pcbLPYfTZR/Q9Cri7/IbFxeLeBzg51/EQqH/2ALOeT9pXy6EzcMSiI
	 bU43wj533dhivEFoGn5zXaOFaHJc5RU7xlhv6fV2oicM1aR2DRBVzfTwtmcOSfsas9
	 qjm2/f2ss6KBRy3EIq1LT8jMOkdnLDZ+ufAWXOns=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A1EA9E3A; Thu, 14 May 2026 19:40:30 +0800
X-QQ-mid: xmsmtpt1778758830tcqsuj41l
Message-ID: <tencent_4A1D33225C74DB33EFAE8A0B6E884567DD09@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GrKOcRhtn/hwDJNkBNBayob2i+Y2MdXysWpcdgvCUTDy4Sqax2E
	 86hC9q5OubMPsVEHdqVw+aBkG5f4kk+/lGATwqgvDbg+sjChVAGAQhiA4952qFV59JkpiodiHOyK
	 bGgoy5qr46z5OrdBlT5iyMAU/tOsSGU9RdqxSoQJHFM05//ArW6vCunibQs9kvuOPX9gm+WpH/p4
	 g20e7CPhqnX4fx4lmvPvRFXAsQueoFZgtuw3QDZdipdjHiY/9o1ZCWwxVRmGnquJkxY1zunWCLYi
	 /j0aehr/QerHvNJald5DdFCJn5GwoeLsJkInR7f5YR7cw4bzuscZ/T0oQN8hH3gu295GKQ6gyj/m
	 JVPvOqhOWXwdSKDcYH3Of34xKeA+PyMoqQYd886nVw0yuY9WU7DudmrhgBCgUAcNsKEE8A095Zik
	 m+ywDt/eZJj5UILTXQesbfnB1GvIe8EKoq77bckYI9kKLxOqmQck7/w1SAznMKF80UfoBSPRmx1v
	 6l1BfK2iWW1vCt7OW+pnpnMDusushUR5m+UaWxwoiFz0C9oiT6QRBcwMZvMmdxAmp9cROr04uCzF
	 Gjr4ZPG5kS/X0LPLVBGajGnlP1wF709vLWe0kAoVMMQlhfH+67A+2dlnhU3xtjXHok0f0s2iO9pO
	 +qa4b760wFKXKrS3+YLjeCncxN8JshA1jlgqIDCZMoRMhUFlWtHbU4MjDcZPafz77Hf7fSv442sk
	 NtutMjyMgaEzX2Mlfqpit5XeJ2HsvOIFWugCbAyDUEfE5UMc/snIP/vbe/iEm2mhJsxhbJVMYADS
	 uWZEXwCQQnub+w0g9htcj6rwdGYMManph2aSRLVdAl5x7//67AOSIYTztsH2gtSclssOHl0oUt2l
	 YSQ+zKsbotHyGF+8cDKCHZO27iqQ+JxF4WeX/yVYZIhgG9/+1UiFJOEGJTR7YehUXCJgX99pARoz
	 4j6f4epdusFncDkPyL/ukj4/zgle+p0Tfhi83NM/WXe8OrTXXe9snqp1tHHEg9WA8LIp631mzua2
	 LgMUW6oO60AEteD0i3NGJCOP71bZ86yuI8Te+a+YYCJqsnmycKDIUzyVCB0NnXhTfHx5UoZEWPUE
	 4QHPBI
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Zhao Dongdong <winter91@foxmail.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH v2] Bluetooth: btnxpuart: Fix use-after-free in probe error path
Date: Thu, 14 May 2026 19:40:28 +0800
X-OQ-MSGID: <20260514114028.487979-1-winter91@foxmail.com>
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
v2: Fix SubjectPrefix
v1: https://lore.kernel.org/linux-bluetooth/tencent_05373BA21CEEB5195F2ECCED0C77D0C57108@qq.com/
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


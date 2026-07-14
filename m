Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885AA3FC5A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017249; cv=none; b=aE+Xm0F+FovLhzC1F1rfTh1efSw+8xdqbIyBigUfOTrC090TSeLHSiqU5/UmBSCNtRqqhQZw3WMZMUREN2mHzVn/lV/vnMDKYqKVus58UynXbG+FFgICn8j1LVf89Q+4iB+QqoO9YllxFXxR/Rkw8S8Tx97szClK7OXBUGbO0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017249; c=relaxed/simple;
	bh=Z/Q0FoU322Mjg7go4QmiFbuMLhwjYOPs62n8Fz+2HpU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dZQ/55x6LcLE38B/nL/JMO1SfqdTQ+kzVVLv6s5g+M8JzU228RV3qya4u4XxvNPLySZyjESAFQRS5GEZqP9+R4FWq8+3akQQ2lVU4kW5nop5Q23ShDcVzEB/66yeNL+H3riBJD1qhFwbf9NWS5D0xmy73bbLhqDQv5ynaydsjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O7FYDVZE; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O7FYDVZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784017232; bh=xCNFfND3mb1FHCD7t7i7l8rNmMUJPqhMUnDgDGvgTek=;
	h=From:To:Cc:Subject:Date;
	b=O7FYDVZEeRv3j5AvtKnttUbVEDmZhrRvUbuufofKeqL6lAP5v7lunVNce4qeJu6yQ
	 KTtx5znrWUW9m1wCDUFtUxHARJpTFH9PSCBLVOvSNGrEY2Zp0PpDfTlG2mfb7n3ztQ
	 oWiqF2wOXZC989/ZFadLTLq5NPuLRuS6c4wQ5MAc=
Received: from v25u1-PC ([61.183.83.60])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 51E38435; Tue, 14 Jul 2026 16:20:30 +0800
X-QQ-mid: xmsmtpt1784017230t9j6j7ps2
Message-ID: <tencent_C252270EE8A4AC5702E228978CF8ABF4E109@qq.com>
X-QQ-XMAILINFO: Nwte6vbuj0EqXx6xIBX4Us3FPw9Wz+XviiHJC/Kk0vDHVXY+SJVqHxwxFq/rFH
	 D+C++tuCJa8Rh52t0yiIVJQJC42Go81u8BJP/iWmRLRRWlKt2kwfL4ZXSL8TUktw8iwYUB9JiZkZ
	 5IN3EMKKioOs3VIqgcEeKTJdx2ytbC6AGWOGEgLWM7PmcB/BuU1PRuJPqxLplsXzHagXu8wOZKLJ
	 uW7B/mYR7k5GQuC8ikEe74Om0O7OdwrX6XeskK0sRs+Crxps7VeDsSPl6gYQJ2jtwmudHktfSEfH
	 u0NOOCOmgZtfquJjKRbyaoX6uaeeWk2uMXKGiZmCPcIGvkmNfbVA/aUjPUdWijB78EaZp3gnVKUv
	 LHgqztiPQHV2H/YA/HGs1OLcViVSpz6kCywfrOZzkGlj67I0o2jqgPtKIIbVWpkpD/hjujRAK0eT
	 sQjsN5VnVpwLoSClLcwOabLJbFCjF1VQGjN0NI6Oj6znAffcacz33oNeNTvjqVXzhBNIQ57yvgLx
	 InrMZGzKpFZlXYQ7y8xmMvBHLIZHUu/Qi8jrNVOmn6Lc/nUio8KXPNZ7qEnJ8FRwfz1cY9a83QAb
	 cXX6Gf/AEABONsh0XnYdGWxT6waCW/QxXAwv5+Pj0ENp3E3s+P/O/X5f8gbM/K87zkOxoCBlZ2Kg
	 si7oc/rMWls0KWM8isJH1sctfLvhe7/RQ1nlwRXEdL4G9o90sbnZXj105z50RGmKTO8auLxHeSav
	 3bOTCgDo0j1HNx6WtuqnaiX10oNpNlK2XH6N2NfIIzieQN9trBtPiCBUdi65ojav+sgwKVegg9Sq
	 eyolbYhfZSnTyS6Vv56vRYdHX9F5Fl/Qaaw6eUelBqOSdu/AT24IusSln7t5MR2EbrE6Cwed3nXi
	 85bv4sCj8JRBdRo4lltu0uG7DSODL/onrXUdwC8W2bfcXR1PDpWQcASHd9yKeTfd8tHF2nEeNGXy
	 nHlWw6XcYxUSMWhUJEiPOmeAyPbfdUGCgZMWwaQ89/B97A2UHkWu/UF5lh1ctuxL9piCoT1btJaI
	 yCgIfUwlpFPLXS0gx40JhbOtpS5ug=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Chengyi Zhao <chengyi.zhao@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Chengyi Zhao <chengyi.zhao@qq.com>
Subject: [PATCH BlueZ] adapter: Trigger profile connection on inbound device connection
Date: Tue, 14 Jul 2026 16:20:30 +0800
X-OQ-MSGID: <20260714082030.48437-1-chengyi.zhao@qq.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a bonded device initiates an inbound ACL connection before the
host sends an outbound one (e.g., after resume the remote wins the
race), BlueZ accepts the ACL link via connected_callback() but does
not establish AVDTP/AVCTP profiles. The remote's subsequent L2CAP
connect for PSM 25 fails with "security block" because the link is
not yet encrypted, and the kernel does not retry. The ACL link stays
up with no audio.

Fix: in connected_callback(), call btd_device_connect_services() for
bonded inbound devices. This initiates outbound profile connections
from the host side. Unlike inbound L2CAP, outbound L2CAP is queued
by the kernel until encryption completes, so it survives the race.
Safe when the host already won: the function returns -EBUSY if
dev->connect or dev->pending is set.
---
 src/adapter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4ffa32a52..4f1bda4ab 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9606,6 +9606,9 @@ static void connected_callback(uint16_t index, uint16_t length,
 		adapter_msd_notify(adapter, device, eir_data.msd_list);
 
 	eir_data_free(&eir_data);
+
+	if (device_is_bonded(device, BDADDR_BREDR))
+		btd_device_connect_services(device, NULL);
 }
 
 static void controller_resume_notify(struct btd_adapter *adapter)
-- 
2.50.1


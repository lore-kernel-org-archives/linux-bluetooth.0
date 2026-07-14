Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588618DB2A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022923; cv=none; b=DYyDygbC839suCwMh0t7ODZ2McEOg1+/mFWB0JXdJMBNLteHWQzJyl+G9JgibVwAojbEcIZbiwMsbKKk/9uVFr/0RisnlDxGgqpVApifTCs6dhuKv9zt0GPcwr7zeCrSnzrz7qcLhfzFvP1fsOBi/cdFsf6dF+x9yEhJVGSxMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022923; c=relaxed/simple;
	bh=6Li3BW1n3zQHXX84s+cXDo7oJLPMOsBVUoLSK9vQaxA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bxkUlHv532IYFZKgPE/fQP9U/myz9xDCTGN5+EjA3gZGkWGW/EpeUAYRjH8T7xw5rcdujIW2IHxol9sHBeN8ZciEyoxnqRfbpoiUC/ZXIjpfcVYonJXJjBSR0VJJpZ+XCmQk7L15lQl27B6RoDNOrBv9Gjkf+6qfZFj808QdMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VyP9ye+S; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VyP9ye+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784022913; bh=dpHcNQICX66kAhFa3lvhe3M79MC7nxE/PaxQoi2hl78=;
	h=From:To:Cc:Subject:Date;
	b=VyP9ye+Sx24ZTVHMjo7VN1Q727ytaqDivHw9yWIIer1ip0dj3qEmY/p+TNQSzbOll
	 ypOUGejk2l7OPm3cdVs/u4RkLzVEBM2fS/MCnJ4PpVUPSOPycuTNvj3C77V4LMvdBF
	 WQHwvvxmvpweDmamBJ8Daz5oIyvpzGrA6LcJXN4Y=
Received: from v25u1-PC ([61.183.83.60])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id DC1268A8; Tue, 14 Jul 2026 17:55:01 +0800
X-QQ-mid: xmsmtpt1784022901th2cef4se
Message-ID: <tencent_F226F8E90CACF302A428A98C3CABB4E0FE09@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLDND6hmjfo38qLXnm7yVOqMywXpb8hwW4Jn4d+9FdnjHV/gP+TK
	 DlVZxGgJGrIkdCSTbEnZiuuEXKIMS+b4tD/dabTXnamiHXLsNhdiJTrlT7KrmFo0N79gp31B0jFr
	 L9zmz+nM4WlO6a8QSHFqPrbudg0jwAkw50q0sYkcOW1mnHDANfraeYW8MmPASMHULePIVvldRylF
	 pKJMEvYzr7VOE+mYF+GsyTLhUuPOQ8kysz9xqCamskU8/zbKGuLKp3cCz0/ckfMjJsyMdLLSXlrc
	 K+z61zuxrJhaAQngsy6YU+CZ5r93GJI9ynq4FxYbFF5pylWuICo7nj86rYna13YUxY/TdHAbXyfG
	 v5aF/UaL/sTE2bEKn9w4RhnlvrALniYrTfVnTANgYtIYeZVusw2uDZkxegOdCLbxkCvzRfi3wfya
	 TUwpdyF64pB7UHUe8GJ3ik/bulLx0qUgLk4ALVxLfBD3M2l3DSfmZHtxY4k04y0feYn8p1xY8V0S
	 CDUx1p7DtadFbnwQsY07ZRauu3D9vLrWQYLQhG+1DT8tZk39s5CNG8SnFC1vbMWB0ZReDaw8vEVp
	 eVgp929zW1aw5W3uFUAyaCxAo+Ut01prNkpP63QArdjkV59PsKz+WsSwHFWwd2V8dfJejPoD6ooD
	 KNxwP2sQEJSwrzzx6Y8kUVt9MNER2RutaiiV26h7aywo8dnm0g0crfSxNj2dYDrN6ebU6YC3q9PT
	 3WzeS6a166IyQDxH3WVs2PQWYOXCx81aWSRPbuY5EA4YD3TGD9o2+EkQ/SJ1mXxmVNBLT0JLf0E3
	 X4CdoUkDhyRYDRrSi4wkkcudxJFqtmj8AAtTsliIuDpmV6V0GZDGuILy0dMIH3eVNdXxBmdIV8Th
	 HwCPvDVc2sjAomOJCz+l+uJY1kC4MQt6TrO37WYEXX1TKJVKicYHqDplnHRRi1nbJ6fSt6wg6H6P
	 h8NEadDGpnIvLofCpdO7jxGHDM+KbYVxYc923C2erjYiz/4jc4mRbrJ9iaeqR4jn1R69zLw0dqje
	 Uuk8Qw/i1sIkqKzIgk8Mv7E1A6/QukTFndoL2nA2ZZ2aGCp9zKVmFldkOOk0gF5TQiOhgSaw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Chengyi Zhao <chengyi.zhao@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Chengyi Zhao <chengyi.zhao@qq.com>
Subject: [PATCH BlueZ] adapter: Trigger profile connection on inbound device connection
Date: Tue, 14 Jul 2026 17:54:59 +0800
X-OQ-MSGID: <20260714095459.51634-1-chengyi.zhao@qq.com>
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
 src/adapter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4ffa32a52..e6b5f297a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9606,6 +9606,10 @@ static void connected_callback(uint16_t index, uint16_t length,
 		adapter_msd_notify(adapter, device, eir_data.msd_list);
 
 	eir_data_free(&eir_data);
+
+	/* Trigger profile connection for bonded inbound devices */
+	if (device_is_bonded(device, BDADDR_BREDR))
+		btd_device_connect_services(device, NULL);
 }
 
 static void controller_resume_notify(struct btd_adapter *adapter)
-- 
2.50.1


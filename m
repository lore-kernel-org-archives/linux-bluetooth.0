Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BA346773
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806059; cv=none; b=POuOtHS8JQoR5NJTM6OZC378jwOG911j+YAGdpcxVv1yGEfSNVutSMQdMbOUjvKp4vl+i/sJ8TlmVToTG1HZjST+vGG/wx9iGwxzvZoiM7mDgN2FGUIB3cvtUgHF26zNxRA7MlklWA4N3qEBm49alkb3yTAgwwmU4RLDHkIsvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806059; c=relaxed/simple;
	bh=kEl3z4LG1kGksJPNQYVP6pElhPg1cOG3i0x3D6MURqg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=MPdHL5De+dUyYO0D0u2MDZdxBJ52gs6Ae1wH26EEGoC5BZkPv3BbDz9aH0zb2mgny941AbS2vDapO7DINmhGAjwhN12SeSTHTKHCxx7A+9s8ZwNpR7U7TWhWosbtQpU1ecqBcdWs1r5NsqA2V3sb3msYXUAuELefxvkAvHbdV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=SX3coiep; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SX3coiep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778806041;
	bh=da8IQhoETOJ7uyI2HlnD291IzLbJ3/7ByDDtY40okbI=;
	h=From:To:Cc:Subject:Date;
	b=SX3coiepV+wY2P3AIr56WYl4muW9g2qKLG6VLlu4Oq0RIr7hlY4csKMoSWodJJcFN
	 RcaKktajpPtpgGTPyoG7wOBuchutmPl/oPopyH9e+FLX2FhPCjMAE8ceWrJ35IQd8Q
	 d91W47jR+QCmVCUXlrGO1BWrvsKzzVozaspPDYiw=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id B8BA7A09; Fri, 15 May 2026 08:46:11 +0800
X-QQ-mid: xmsmtpt1778805971tjq2ydq9a
Message-ID: <tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2/7JwRM7+25tZPfpTr0mIE7oltmFT3MPdyBKo9h+oA6/lVqroBK
	 c7d8ZkVhDX5DOFvpDMk8Er6d6SRiajeOKEoVYQzTEck4l2KfO/vFgYjrHBEUI/Vr6DOWtQExu7gl
	 biiyjTNLLlZhTURagNvOEF4F3IFEWmhwWMhOpxGGrppg1G+kBZU8fs7+4ZTSTJ/OclXhkbd465iE
	 h5j4Le7U9/HvwV88yDeed0mRwlCv2Jy8Wlv+T3tAtV3EF8jkyrxpciLqKmQLJP6sbEhE+8ONxEYq
	 WydLMtrgFki+RGW1XYSWKXZ4eBpuM/vs5KlCwlVD8ow3XZxV8bI8M4Pf0cPurR44lnVoYg8WKon3
	 QJMJzXIMe6OY21szPL+ELXhzhdHQAnPeaFSa5goWpjQ50LSP+8fDtUmyhmZSPysPz4XexaHL1TTA
	 7bAuzekafK+j6fmd1m2DZNSnqmqyvwc9BRYKU9aDB/oYbqT/0m369JaWp4NxCqPNYDKKtYbgEPap
	 TQrxNqsUOhGcaNcVXxJY/O1g/Jnolf3sdeNaj0EHZSw+05yr6ffrK82ebk1aXf8z5hEnuJhdesOt
	 IXrHbmkjoaJt6N1045YlJfDnfgufKPNcyMh7sMY7HItQoYM8aHpuaHoMrzhdAzb+1ompsqpSZOa0
	 GDXCdStV6HO2JpT3AqOK2ZGT94WFWFWRGYM3khbgGURqhJ4YfLe9S5qKrvYCiipB8I+qmXlPIOsK
	 zi5UXRlL1fkQ+VoBpdODeIZzTD1D165tPR44wQFJBjPi1jEk9gM56b0ctvetLZoyEet4Mmy1TNER
	 6sKs3kn1P6EBHW3oP2NIw68ZtINUCuZDbEGca+vZ3Y9rPZ0KT7yy+pT6nf9/hbvU5ZZ0g3yNlVeO
	 wxaPSFN3d1YSzt6V7PPQh0M3aZ8AI69cAMq+GvtZKTMVVIl2r1dxQKgEKu0Wmk+DEYkc317JlUnn
	 Gyoq0uGNDaJO0MYd75/MmFW6ZrmmyORIZ2e34xSm3vR6xrzNiGHlq/fKLWn3sR0MuVcys4tjPBn4
	 h7l85nn2/ynnpC2+qAKkm4xF9gllk=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Zhao Dongdong <winter91@foxmail.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH v3] Bluetooth: btnxpuart: Fix use-after-free in probe error path
Date: Fri, 15 May 2026 08:46:07 +0800
X-OQ-MSGID: <20260515004607.41116-1-winter91@foxmail.com>
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
v3: fix gitlint WARNING
v2: fix SubjectPrefix
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


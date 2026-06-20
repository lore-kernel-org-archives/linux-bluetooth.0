Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BC3AC00
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781953040; cv=none; b=HJKwnbWc7ig0/30WlwH4z4vV5fiVyy8TQbEDSA0yfLXt8gPepOCOpEj+IB0aVvC3yshFFUuR6jhvTwoe/EwDpNAVBB4t1xZM8x6VJLYQzA7wMFEL3HlhO2EBjwJ7GWeifl+sbJwm9IpJTQODkIXswtFVC5CzrHlvSYen5KfFFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781953040; c=relaxed/simple;
	bh=mUusZpG4NGYCtcRNUxY46FNZnSW9JhLFHjP9ujtieWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0uahu23+CVPiHti/EojnN2tDibFg9FXZTs1VJ6uuYoNoCbiYMNRmtp0cO4rEYof0/f83McSqRGPICPffncJavq62IwHhiUtH5k+ie08JY7l39m3y+Bc6GLC7E7/9DVrYKOMa13t3xrXz+HD2fMliD7P8S19n53x4fDfCchT+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAB3TjX+cTZq1fEyAA--.3751S2;
	Sat, 20 Jun 2026 18:57:02 +0800 (CST)
Received: from uu22.. (unknown [38.79.119.137])
	by gateway (Coremail) with SMTP id _____wDXD+r3cTZqgc4+AA--.61S2;
	Sat, 20 Jun 2026 18:57:01 +0800 (CST)
From: Yinhao Hu <dddddd@hust.edu.cn>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH] Bluetooth: btrtl: set error code when RTL_SEC_PROJ read fails
Date: Sat, 20 Jun 2026 03:56:40 -0700
Message-ID: <20260620105640.1369098-1-dddddd@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAB3TjX+cTZq1fEyAA--.3751S2
Authentication-Results: app2; spf=neutral smtp.mail=dddddd@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoW7trWfurWkKryfGw1DWry8Xwb_yoW8ArWrpr
	ZxGa4qyr45Jr4rJr47AF18AF909FWvqayYkrZ0ka4rArnYyrn5ZFyjkFy0qw1DurWkJF1Y
	yFs3G3W8C3WUGaUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmFb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r4UJVWxJr1lYx0E74AGY7Cv6c
	x26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw2
	8IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0imRUUUUUU==
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/

btrtl_initialize() returns ERR_PTR(ret) at the err_free label, so every
path that jumps there must leave a negative error code in ret.

The RTL_SEC_PROJ register read stored its result in a separate variable
rc and jumped to err_free on failure without updating ret. At that point
ret is still 0 from the previous successful read, so btrtl_initialize()
returns ERR_PTR(0), i.e. NULL. btrtl_setup_realtek() only checks
IS_ERR(), then passes the NULL pointer to btrtl_download_firmware(),
which dereferences it:

Oops: general protection fault
RIP: btrtl_download_firmware+0x39
btrtl_setup_realtek
btusb_setup_realtek
hci_dev_open_sync

Read the register into ret directly and drop the now-redundant rc so the
failure propagates as a negative error pointer.

Fixes: cd8dbd9ef600 ("Bluetooth: btrtl: Avoid loading the config file on security chips")
Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
---
 drivers/bluetooth/btrtl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 62f9d4df3a4f..eb6fdf8592c2 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1073,7 +1073,6 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
-	int rc;
 	u8 key_id;
 	u8 reg_val[2];
 
@@ -1185,8 +1184,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_free;
 	}
 
-	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
-	if (rc < 0)
+	ret = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
+	if (ret < 0)
 		goto err_free;
 
 	key_id = reg_val[0];
-- 
2.43.0


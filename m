Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="IpGQlHWl"
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 08:42:42 PST
Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9986198
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 08:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=34RTL
	E4latA1ndwKWr6wBHgOPTLPG/f2WMiFpqc09jo=; b=IpGQlHWlQocdLvpmSltcg
	SzQ/oJm4D6Qa/GqhAHHSorEW+sdWTmW8df9tx6cW+TxIesKCWeZvrBgj5bnw+hir
	wwrFteb5NgOReU0jUWlPWpI+BznuVZfRqKrH+VjJ2u6wR3RvMyYpv2m14ZeDr2Av
	SWrlBffFw4D+x6yUyiCEt0=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnT5NyOHdllbAiDw--.21285S3;
	Tue, 12 Dec 2023 00:27:32 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH 2/2] device: Add notifications when the bdaddr_type changes
Date: Tue, 12 Dec 2023 00:27:29 +0800
Message-Id: <20231211162729.1183207-2-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT5NyOHdllbAiDw--.21285S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RN18BDUUUU
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6BhD1WVLY0IN1AAAsw

From: Xiao Yao <xiaoyao@rock-chips.com>

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index a734fff0d..17bcfbc49 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4472,6 +4472,9 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 	device->le = true;
 	device->bdaddr_type = bdaddr_type;
 
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "AddressType");
+
 	store_device_info(device);
 }
 
-- 
2.34.1


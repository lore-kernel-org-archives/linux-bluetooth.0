Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259923A3815
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046677; cv=none; b=tfqxLy+Pvr7mghpw3D8xnI6x/WiQDeWnUj6xEXBGHhUa+piqkgRcZWp+pqfabNV++/EAzeRp4usdRkrTVdvaZQj1YA1MiCv7nt80O8acqbbNzrXUa26XpN/q/wMYOePDeezDMUe4jrXqC5kQUYTULzr6ebEvzqpmJ1PLAUHBJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046677; c=relaxed/simple;
	bh=yDSB/QvpZhB36aji7mu4J47AV4InJCzK38MPms4UfIA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=HWt3AvHVKL12tsaQApbuIB//T4tG/dY3OohIN7TXLaiiSW6hXvH7OlXodUv5xlcX5U3kD9b5SuHYiq28o23GiLVpiSd2nS2V952f/cX+7Qj5nW0ZeTRBX1/8rvaMR8gnmXSeXNkMcBwi04eJwErcrirlSqDkmXjwEwyLv5eAs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nh5+6mLL; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nh5+6mLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1790046669; bh=VB+P4zcykqaFhKuchSO6MsElU2jECMVD+OiH2ZIcOCc=;
	h=From:To:Cc:Subject:Date;
	b=nh5+6mLL9Hxd07TAzzC6oi81YfsqQ0F5kTgA0jF83k+yVG5Z1Tl8wJ7RxGe5BYFUI
	 PqZR3/LBZOmtLPv36Cb3ZOM4DXGqogwM4eC96mRR2ATEXYGi/0oQaN/x/GhW9JjSZl
	 uT6mm1XcIv8tulWI7XaB0wJPN90onGlyEZ3S3weA=
Received: from caitao123456-pc.. ([116.128.244.169])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2C710849; Tue, 22 Sep 2026 11:11:07 +0800
X-QQ-mid: xmsmtpt1790046667tzgqlimca
Message-ID: <tencent_27EA4A683B87E3DCF400C26D990DD9364507@qq.com>
X-QQ-XMAILINFO: NsBBv6AnqV8OI4Lj3/ZAkQAWgazZ5vgJ4swDtHSHvRoABmzadpBTQF1vp53fqi
	 AEv8dbz9CUyf62/R9jVAeIRnkZPYEfpdpata8ihswYp7a5PlZ9gzjah1D5C5Dq/mMvmSXJp3z8El
	 fTkiD5LtYuf+I7K8WOSEHL1HqyT3cObOGw4cpAhJNIciBY5R/nbvCNBJzLuY0URWvpKmYrYotkqU
	 QCijWYw4esbZLN9Zq7v31kS74HA5TYTMMypjnM0MUvMvLdGDq7YfTx96aH+uuTDTOG16wZs+vs12
	 N90YizK4CHT6r/24jw/juBkQAfAOvIQGL3r1/CnClsqBn69Z/332veQ9KS8rhojkJawY7JEarGYv
	 a/M4FDvfdaoQtrosleh8+BycTC2iD8s/6xUW/A9cfQm3nD96Sf38VrV7UBMWZYwR2PAvYWnomS0h
	 jvfFxxmyheqfxJ2kz6T9e/Ax4YTJ2zKwG36jH+o9QpOmw+rhU/BHZ6qCUmC/gbIzDWeq/2qRIcLf
	 ns8IMchl8runkpZT86aem+gTPygIF91uMFW3ro+Yq+WmVFHphXrcKiSAFwPIqoESscSPZ6EJpZTn
	 wx0YRexKmhPN4DI41mCvsKxgOMFdwf0hHymWXV0TadutCKHhrzPOceoDhk1sUMKxkH3V7OOPkMOt
	 uv/CxlOEZ9wyitko2vosoYxRLUIe+au30v7wdgl6ZU3TlLsQVEJvuIxfnAM9RYs3Gjb1rpsN1ryY
	 IhthOUFqUW5AGZOshPim3l+7k/ZH9qUx5ai1137w9mzBoJZ0cKaRNuLiN8AqcgER6l5b/b0M607S
	 FqNPgDNELEoUA1sYuJ2dbUV2oqTn87Y3YQSrlAn8jtr3pZBrTY4f73pGtdNCApaXqUiMSDbpBL+w
	 GzNIl1tEhN1Dy6cCjkjcfwweDhiX3PTfV7DzHYBbfXzT/ehF+IjMiSTjbUYM7NhR2sU/JKX/O5Gv
	 ElUE8oN5PIIGr6GYXPYA87xve+73CUTg9QBPASapVqYyQjvKP7zCMN7uoxWOR8nawJ884EN1nPFK
	 mNlcq+Z2MxdnyGR8IUW08IXmU9TD+9VYVkDgmSwcXNOg4p4qpw
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Tao Cai <294305068@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Tao Cai <294305068@qq.com>
Subject: [PATCH BlueZ] device: Fix NULL pointer dereference in dev_property_get_uuids
Date: Tue, 22 Sep 2026 11:10:17 +0800
X-OQ-MSGID: <20260922031017.104438-1-294305068@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bluetoothd process crashes during D-Bus property serialization when
the device UUID list contains a NULL entry. Add a NULL check before
calling dbus_message_iter_append_basic().

---
Crash Stack Trace (BlueZ 5.71 AArch64):
#0  0x0000ffff8ecfbe98 in ??? () at /lib/aarch64-linux-gnu/libc.so.6
#1  0x0000ffff8ecfe548 in ??? () at /lib/aarch64-linux-gnu/libc.so.6
#2  0x0000ffff8ecff120 in ??? () at /lib/aarch64-linux-gnu/libc.so.6
#3  0x0000ffff8ed005c8 in realloc () at /lib/aarch64-linux-gnu/libc.so.6
#4  0x0000ffff8f250204 in ??? () at /lib/aarch64-linux-gnu/libdbus-1.so.3
#5  0x0000ffff8f251c34 in _dbus_string_copy_len () at /lib/aarch64-linux-gnu/libdbus-1.so.3
#6  0x0000ffff8f254294 in ??? () at /lib/aarch64-linux-gnu/libdbus-1.so.3
#7  0x0000ffff8f23f968 in _dbus_type_writer_write_basic () at /lib/aarch64-linux-gnu/libdbus-1.so.3
#8  0x0000ffff8f243208 in dbus_message_iter_append_basic () at /lib/aarch64-linux-gnu/libdbus-1.so.3
#9  0x0000aaaabe2f64d0 in dev_property_get_uuids (property=<optimized out>, iter=0xffffd510cf28, data=0xaaaac18514e0) at src/device.c:1339
...
#21 main (argc=<optimized out>, argv=<optimized out>) at src/main.c:1456
---
 src/device.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6d82ea3e2..c5d8e4c6e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1455,9 +1455,13 @@ static gboolean dev_property_get_uuids(const GDBusPropertyTable *property,
 	else
 		l = dev->uuids;
 
-	for (; l != NULL; l = l->next)
-		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-							&l->data);
+	for (; l != NULL; l = l->next) {
+		const char *uuid = l->data;
+		if (uuid != NULL) {
+			dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&uuid);
+		}
+	}
 
 	dbus_message_iter_close_container(iter, &entry);
 
-- 
2.43.0


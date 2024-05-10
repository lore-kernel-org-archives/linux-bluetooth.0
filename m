Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786A79945
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332705; cv=none; b=tOujzsNdn9VUAE6WC21AXq+GqfKOnNzDTW3izOEPVG6zwRckVHVk3rkbx2tTOVrOZYUU4kDfKsWKX4fBrbW4VI0UksJ5EJD65vH1JXMqjeamXljn6dyQU+rmfylvjlEy0AyFHuW4WBxNSoZGKy0ZK70YJkBFWBo8zWxnMAujDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332705; c=relaxed/simple;
	bh=5TXl3HVkG/uQBuuY1wI8Z0QrwLoCEPRLF38cOOWUhP4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/MgTY12pyOj9ytKvfRpfjBE4z8Avo62SM6AFmVFnEBVtdrgCucKXYSVmO/ZErBxaSESf2MWgaYH8VjSKy+98/dhKlgHAXfSD6NM8f5o/4cjb66qyij9/7PKN1Sv8V6RXuOkA7DCtqtuLb0ugOzi2ZHiut0ApDsLnruPcKOpAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AB3A1BF20C
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 04/14] client/gatt: Check write_value() retval
Date: Fri, 10 May 2024 11:11:02 +0200
Message-ID: <20240510091814.3172988-5-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: CHECKED_RETURN (CWE-252): [#def35]
bluez-5.75/client/gatt.c:3191:3: check_return: Calling "write_value" without checking return value (as is done elsewhere 5 out of 6 times).
bluez-5.75/client/gatt.c:2371:2: example_checked: Example 1: "write_value(&chrc->value_len, &chrc->value, value, value_len, aad->offset, chrc->max_val_len)" has its value checked in "write_value(&chrc->value_len, &chrc->value, value, value_len, aad->offset, chrc->max_val_len)".
bluez-5.75/client/gatt.c:2502:2: example_checked: Example 2: "write_value(&chrc->value_len, &chrc->value, value, value_len, offset, chrc->max_val_len)" has its value checked in "write_value(&chrc->value_len, &chrc->value, value, value_len, offset, chrc->max_val_len)".
bluez-5.75/client/gatt.c:2919:2: example_checked: Example 3: "write_value(&desc->value_len, &desc->value, value, value_len, offset, desc->max_val_len)" has its value checked in "write_value(&desc->value_len, &desc->value, value, value_len, offset, desc->max_val_len)".
bluez-5.75/client/gatt.c:759:3: example_checked: Example 4: "write_value(&c->value_len, &c->value, value, value_len, offset, c->max_val_len)" has its value checked in "write_value(&c->value_len, &c->value, value, value_len, offset, c->max_val_len)".
bluez-5.75/client/gatt.c:775:3: example_checked: Example 5: "write_value(&d->value_len, &d->value, value, value_len, offset, d->max_val_len)" has its value checked in "write_value(&d->value_len, &d->value, value, value_len, offset, d->max_val_len)".
3189|			}
3190|
3191|->			write_value(&chrc->value_len, &chrc->value, value, len,
3192|					0, chrc->max_val_len);
---
 client/gatt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 6c7603985172..51fa8ba8553c 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -3197,9 +3197,13 @@ static void proxy_property_changed(GDBusProxy *proxy, const char *name,
 			dbus_message_iter_get_fixed_array(&array, &value, &len);
 		}
 
-		write_value(&chrc->value_len, &chrc->value, value, len,
-				0, chrc->max_val_len);
-		bt_shell_hexdump(value, len);
+		if (write_value(&chrc->value_len, &chrc->value, value, len,
+				0, chrc->max_val_len)) {
+			bt_shell_printf("Unable to update property value for %s\n",
+					name)
+		} else {
+			bt_shell_hexdump(value, len);
+		}
 	}
 
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE, name);
-- 
2.44.0


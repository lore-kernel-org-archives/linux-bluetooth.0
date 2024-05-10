Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FF16FF36
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343253; cv=none; b=FbWKAR/7trYZg0q3LVqQgQWDB4XDUrLbCf2yzyy2pgoutMezGJO8dlXDsEEpp2eVr/NvDAlREMBJw6kY3BB1vGmk8hW+4ovVgZOyNnw5mw4DFTSopYSCFIRS5aFi2zOuivc+QWzC0pr4uVSLjNmTKbFCdAgHTcaDh+uEwy8+K4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343253; c=relaxed/simple;
	bh=e+sq0Jf3tfFbQj8Hi0APs5Ay6QGQNzh6bDMCsDQ2Jms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA+dOq/EJWFpejEfj2WXtsE8sl2Gk0AJ4fSFUtHb7nTvphEqx32QvGJRk3Zm3MWkyg9N5PUOy42sEOkuVb0Kpd8mdJ3L7RUkgrZPJ8PYZb2cMXhG9BE8ERHSRSB8WeqLu5SfwSPcLf1RVRs76nfzABCgMKOj92OtYJFc84/Jma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D32856000B;
	Fri, 10 May 2024 12:13:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 04/20] client/gatt: Check write_value() retval
Date: Fri, 10 May 2024 14:10:14 +0200
Message-ID: <20240510121355.3241456-5-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
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
index 6c7603985172..e85031277bd5 100644
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
+					name);
+		} else {
+			bt_shell_hexdump(value, len);
+		}
 	}
 
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE, name);
-- 
2.44.0


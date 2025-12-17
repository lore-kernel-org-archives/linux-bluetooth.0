Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E8296BDB
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004108; cv=none; b=UNJc1oam5k9M/WSUoS+i95elI7LQ7wprPODUL5/oKXbq3vwtVAPMkeUJeVb/KIrYsfUewX3M/u846BCocipDiZ6hP5BThpFpBOhzMHJFQ33dVe18PKJt8wSK6THPwtiWbZMH2r29e2XqH7I6aNByG3Me+zGAa/5Nw3uU5InY5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004108; c=relaxed/simple;
	bh=sx2WwUV87bdywsdlL2OwcdRyd475sh+CZs5IWAGrqJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5rO049jw8Pgzzyq99dVJ+A2NnT0AR9ZBYxIXE2FfdBeKqOicxTENb9IQYJ2YE7SSTlUVDWEiDaB3+uMxYdsRC5DtHO2MOPZzV20i+nUueuPyJz8V+2/7Bl2yTWE1nP1VsawN5mUTcVJHNFs8p3OGA39+6buJba4WtPV01VWeK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUAqwPZE; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUAqwPZE"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5e186858102so2293298137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766004105; x=1766608905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBgFURcCCtDGjS1N33MYNWrLz62EUKrQtcbndE0cnyA=;
        b=EUAqwPZEBtJD5ArUYcexxuBZ+rQAvjo1xm4JxGm4R80Y0xwsq/bKeekBJ5vvcaeh6y
         Zx+vRXozQLxAV1k8xqOcVy5JHqiuCVAIsWGuZgFQOytkGzhJcsbw3hub/jfZvpYlQJj2
         hnOfZ2AURmhV7gpsMD83+OBhzorRWsxV1Y9cbl5zDmqssK3sS43NqoWOklrE9F1hB4T8
         sYx25BMN9D6wbnnzCfWWjzDZI2rYXAOyKT1JYVfsOv87NExHuOqOcLeQzEjC/TIw6Kmo
         18s2sf+yPX8yq73zX1vpVOLb071J7T4CWPYpW+TYIDuBlIrnVgBMriNNOtbM17j4BiUQ
         GPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766004105; x=1766608905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zBgFURcCCtDGjS1N33MYNWrLz62EUKrQtcbndE0cnyA=;
        b=dx3Vq1MhebIU3smhkdiJsh940b8iQa55NUrsSgknrpEXaXsqXIT4uRK7dr6hvWV5Kq
         SBQL3BaTTMK4IDc0wRdI9o+/Rc32tUxxNaWWvEvTJ8q/fJ6VvY+cZk2EQ6pjjvowsQTb
         c1QjmDUHq5avA1XzOBMQ8e3qAfeusFDyGUzkl093qP0uBFs75a85V+x5iKleP8DYuHFs
         s6oWDCyVastIFXUOt7GzQ1nCKtM3+Q5co8teoffSyFtXXrYuImQwHANfknx7oTqlIb9R
         MxR6jmGUqnn2ItHY/jiAeUFdxDWGOj6eSNhiZd3U8JJdVnbd+bWaCpnDAvLaT85P53kD
         EhnQ==
X-Gm-Message-State: AOJu0YyQ9KsdvHM5ivGHdE6pJ2QUE9y3+WNkNLbQZEj4z8jMUfyJLdzO
	mekQS6xjDAxDIn9OhzdxXNT+L6YmQ+ja14wrq/uB0SwnHP5VQbmue/I7IsoJNpIV
X-Gm-Gg: AY/fxX6IG9CYWcESsJccfmFtXI/XULKy7yAPkzPOb/mvw9zJhhmmPdLqtfq9iRb8UgX
	saSJniKA/cXyiGQTxRuwVItrzICP6hqwUehp7/2l4ZaFTzKC8vYZPJdW91tIin2SCkbUljfbMu9
	UUIW0BHXRTcA8gZEu387m/eP68B5ZMwK38eDTmneMG4BecDuKRGbqTvhGuMYSMPfN1reKsnMZ0m
	CxYFSnFV4Efz1ZE9sKggcHIQ6cCWGctFZ9aDCvcdxraYqoyOBTVriRSalXZ31lFCypQ69DnT8Dp
	Db7nBYMz/+9voRrZyqFPFYlqYmda32xG7MTRbYwNOi133W40MaaVSLSyh+uVUHTYsLXbZUfpn/r
	Q8ZpThQXQMXAHByx/IYpvBH0OcS5GJiE8IeSEbLg1mEHD7ymNE6aGipMBihSjBSu93pLP6x+8al
	rK20ZKdlQGQz490A==
X-Google-Smtp-Source: AGHT+IFnJ1LWw7gLapdtpWgyV7HqYJIaO1+m8KtvtlUt38gSNgUfDMO2KzWoNM2e6zIDEJgargLrew==
X-Received: by 2002:a05:6102:334b:b0:5db:eeb6:812c with SMTP id ada2fe7eead31-5e827835816mr6170810137.43.1766004104879;
        Wed, 17 Dec 2025 12:41:44 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb057e3f0bsm119217137.4.2025.12.17.12.41.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 12:41:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] emulator: Add support for BT_HCI_CMD_LE_SET_PHY
Date: Wed, 17 Dec 2025 15:41:32 -0500
Message-ID: <20251217204133.282359-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217204133.282359-1-luiz.dentz@gmail.com>
References: <20251217204133.282359-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for BT_HCI_CMD_LE_SET_PHY as well as
emit BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE when it completes.
---
 emulator/btdev.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 41e9c68f5f45..be43623e8bfb 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5082,6 +5082,79 @@ static int cmd_set_default_phy(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static int cmd_le_set_phy(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_phy *cmd = data;
+	struct btdev_conn *conn;
+	uint8_t status;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn) {
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
+			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!(cmd->all_phys & 0x02) &&
+			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+	else
+		status = BT_HCI_ERR_SUCCESS;
+
+done:
+	cmd_status(dev, status, BT_HCI_CMD_LE_SET_PHY);
+
+	return 0;
+}
+
+static int cmd_le_set_phy_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_phy *cmd = data;
+	struct bt_hci_evt_le_phy_update_complete ev;
+	struct btdev_conn *conn;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn)
+		return 0;
+
+	if (cmd->all_phys > 0x03 || (!(cmd->all_phys & 0x01) &&
+			(!cmd->tx_phys || cmd->tx_phys > 0x07)) ||
+			(!(cmd->all_phys & 0x02) &&
+			(!cmd->rx_phys || cmd->rx_phys > 0x07)))
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.handle = cmd->handle;
+
+	/* Use the highest PHY possible */
+	if (cmd->tx_phys & BIT(0))
+		ev.tx_phy = 0x01; /* LE 1M PHY */
+
+	if (cmd->rx_phys & BIT(0))
+		ev.rx_phy = 0x01; /* LE 1M PHY */
+
+	if (cmd->tx_phys & BIT(1))
+		ev.tx_phy |= 0x02; /* LE 2M PHY */
+
+	if (cmd->rx_phys & BIT(1))
+		ev.rx_phy |= 0x02; /* LE 2M PHY */
+
+	if (cmd->tx_phys & BIT(2))
+		ev.tx_phy |= 0x03; /* LE CODED PHY */
+
+	if (cmd->rx_phys & BIT(2))
+		ev.rx_phy |= 0x03; /* LE CODED PHY */
+
+	le_meta_event(dev, BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE, &ev, sizeof(ev));
+
+	return 0;
+}
+
 static const uint8_t *ext_adv_gen_rpa(const struct btdev *dev,
 						struct le_ext_adv *adv)
 {
@@ -6335,6 +6408,7 @@ done:
 
 #define CMD_LE_50 \
 	CMD(BT_HCI_CMD_LE_SET_DEFAULT_PHY, cmd_set_default_phy,	NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PHY, cmd_le_set_phy, cmd_le_set_phy_complete), \
 	CMD(BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR, cmd_set_adv_rand_addr, NULL), \
 	CMD(BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS, cmd_set_ext_adv_params, NULL), \
 	CMD(BT_HCI_CMD_LE_SET_EXT_ADV_DATA, cmd_set_ext_adv_data, NULL), \
-- 
2.52.0


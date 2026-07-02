Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C6381E95
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007450; cv=none; b=PMyI4wgNmyqY8JCtasZeBl7ZXhyi54NhLIJ3JkTVQ6Nxxf21ikroAHgS/T7Hu4DvNhZVfhVPpXPnYnR4vbfkh3WssKXasex8KYy72zT9aE8+dh3jYZa0o0lJZUsuTxxIbqZyPkNlD/WhmelLoHzopwZFNs6UjGrKUXdEMY75W8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007450; c=relaxed/simple;
	bh=YJWNoSM4VKe/YsAiDu4hlIDPN+xxPmakoRfsr3loAOU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ua1SYhDKpzFnEoTyPfSaDrv8ABMs6wBjvegv9hWFMOS2taoY1lV0a8XFcL5Zq1/NIj97eO4PI6+6TiK7rxaNNoQd2O+Q6Ex9fYUdgxpK51VyVuPW82YjP6xds934Jv5v/wKmKIELsEJbQTKDyE+MnQsj9QqCX5kLk12dsjTHv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD/1okBL; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD/1okBL"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-73770fd1b65so593416137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783007448; x=1783612248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYIU7steXdcB2kfI6mtfixOD37gtCXrYyhM3js4jHf0=;
        b=iD/1okBLVNpPgSwJAhGKbA5Ubuq2xyqejjmD67ezsYJmeF8grTO52YBUWWEeHFu9n1
         Kz4/pXWoTBSnY8XTTkiiaCqaCVCCKg7ajZ8Mi9ZddxiBULfD/PaEDhuFETeVaJr0YZn6
         AuArhRgcazOQ9IgCHs5+ex3C1il9q/PKqQADlHtqX5p+IeBMA/nWGpPRxx0lZsEM5Q5j
         jbL7p46hFkDSRgXe+0tgzdSfJPv/Ev+l/Y+67jjuoxC2CDafOdSe6XE4J/ZtCHrgITvC
         xgfdgr4ok6QC4dyTKDUC6xTUn81HCqFmjdVcSUargLoWqFZZWNyp5sXcziUVZWihdiTF
         S2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783007448; x=1783612248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYIU7steXdcB2kfI6mtfixOD37gtCXrYyhM3js4jHf0=;
        b=KD7+TeZz5qqt5Cefi4/w+wT8YPlJoy/bNG7vukbebDyTu79hkWo3S9hqcYlxTxStK9
         joPXHHhGx4eC2TxMyiGODndviJ6YDjzgAmmCKEKfEF++4K0q1e9CLA1HeE2LeZduaRzj
         CQ4tuo1W1JUhY6no4O4veN9x4vfRcngQwn4YiK8hWW9nxVtt9UbvkN4+pxWE05VZjWHW
         MHB0UpT2O4gNjyxK1M+SXSE9pYiXREUk8/iI/ZDUO3zostZeBVk0YlBrq0WBQJCtwahA
         KM09Nz0/yAelC2oGZxcsDaeOcOt5hOSKxRx5b/aOs5nlcehTuccpXYuhu+4L728n6oOZ
         Dcyw==
X-Gm-Message-State: AOJu0YyEKsxCv5UAUyuF4q2bxX3IieWkB1LVHc9vvTg4JgOZhveP3auS
	zpoA2JhTdOSnXQ1UjHEi+19Ngzv2h7BGCAQ5zNSKuRxyezuS0FNcIZYXUCc4w87olyQ=
X-Gm-Gg: AfdE7cl011LuF6MksvkOcXhH9QTZMuLjnC9b9u7EEqEFzB7E0poF2vz3I6LNvZXVk7m
	t71kZVhb69e0mrAZbwdl620f7pytle+jJxDvdlOuK0Dg/Tr7TbAfDgfLSuWHS1MySMIMwudMbUy
	YwGKhdgB0AwwBK0uuruJJCphIsRgCsP+i2RvcATEKWYArfeVwTqKi6AC+zHwqbDPaspfjJRZdfh
	Cvj0CdWeqTtIJa1edNlt8/BFEw2XtO4hBLaRHKIpO8/t3Qft/YjTG4IwZ8CCczcD0/o7swPMbDz
	DxcOxCkKNeySrWTax/mSW3wUVb5LU9OoGVri09ZDAEL7bkn8bN+3dLK366lLyIXodpIMJT2QzOy
	+8Eq08t3/xl4iMfFUR0F6duZM+D+lO+zegrBTGG4M3ZBIUwnJdNfORgozixppgOfyY5GtCZyBAz
	NOZJ9knLMniRr6DRRWUel2hJKu9mOHpUkdYF/FfvwxV/Vj0P0NsDRQVVuyVjDV7rUDYAFu6hxlh
	vgLZD4=
X-Received: by 2002:a05:6102:5805:b0:726:cf2d:6076 with SMTP id ada2fe7eead31-73dc07b88ecmr2189548137.29.1783007447915;
        Thu, 02 Jul 2026 08:50:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9698375705dsm1259782241.0.2026.07.02.08.50.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 08:50:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] adapter: Fix crash on dev_disconnected
Date: Thu,  2 Jul 2026 11:50:37 -0400
Message-ID: <20260702155037.9931-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit 5d836f1c697c ("adapter: Fix failed bonding attempt after LE
link disconnection") introduces a regression since it attempts to
call device_is_connected after adapter_remove_connection which may
free the device causing the following backtrace:

    #0 0x5cd6e384262f in btd_device_bearer_is_connected src/device.c:3754
    #1 0x5cd6e384266f in btd_device_is_connected src/device.c:3745
    #2 0x5cd6e37f8614 in dev_disconnected src/adapter.c:8626

Fixes: https://github.com/bluez/bluez/issues/2221
---
 src/adapter.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 538f63e0a153..210225243f00 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7612,12 +7612,16 @@ struct agent *adapter_get_agent(struct btd_adapter *adapter)
 static void adapter_remove_connection(struct btd_adapter *adapter,
 						struct btd_device *device,
 						uint8_t bdaddr_type,
-						uint8_t reason)
+						uint8_t reason,
+						bool *removed)
 {
 	bool remove_device = false;
 
 	DBG("");
 
+	if (removed)
+		*removed = false;
+
 	if (!g_slist_find(adapter->connections, device)) {
 		btd_error(adapter->dev_id, "No matching connection for device");
 		return;
@@ -7638,6 +7642,9 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 
 		DBG("Removing temporary device %s", path);
 		btd_adapter_remove_device(adapter, device);
+
+		if (removed)
+			*removed = true;
 	}
 }
 
@@ -7665,10 +7672,10 @@ static void adapter_stop(struct btd_adapter *adapter)
 		uint8_t addr_type = btd_device_get_bdaddr_type(device);
 
 		adapter_remove_connection(adapter, device, BDADDR_BREDR,
-						MGMT_DEV_DISCONN_UNKNOWN);
+						MGMT_DEV_DISCONN_UNKNOWN, NULL);
 		if (addr_type != BDADDR_BREDR)
 			adapter_remove_connection(adapter, device, addr_type,
-						MGMT_DEV_DISCONN_UNKNOWN);
+						MGMT_DEV_DISCONN_UNKNOWN, NULL);
 	}
 
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
@@ -8618,7 +8625,17 @@ static void dev_disconnected(struct btd_adapter *adapter,
 
 	device = btd_adapter_find_device(adapter, &addr->bdaddr, addr->type);
 	if (device) {
-		adapter_remove_connection(adapter, device, addr->type, reason);
+		bool removed;
+
+		adapter_remove_connection(adapter, device, addr->type, reason,
+						&removed);
+		/* No need to continue if device was removed from the adapter,
+		 * as it will be freed and the disconnect notify will be called
+		 * in the device free callback.
+		 */
+		if (removed)
+			return;
+
 		disconnect_notify(device, reason);
 	}
 
-- 
2.54.0


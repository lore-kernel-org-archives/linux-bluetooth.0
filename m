Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039332836A0
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785010755; cv=none; b=p03I0/FTSCoQ/8WAPftxZ2lB4/yJFO5IpIxJzjMR+1+9ZQptnUnCjhx0iNsvyFqox7g6HE0tlPeHnPwd8QPgd5jEjOVyp//vYSY5HkJ2agISvs/xs9e4CnTqUMaYyv72Xg+Hj8ZGfW/OnUX7w3a8/ReIdzZXvBirgTfXHuNwpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785010755; c=relaxed/simple;
	bh=LClexaVVJVJUX84HmLlIpw1ulYqnrgq5/04elQROZ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcSUYF8IX05NmsCxJLFbMMex5EVDCgwCUWKH1LONiB68+gcUbOmlpOuuq5Xx6c1bRVrZOrL3aFE6awRXvAi3JEMGyrZmrxWWBIbd8XHJjZSgRIcBBQt4TBQLpQultXuOAYX5gtidQjoYUglRUjOwMKgChBkiIUz+dB5UtlcWShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cC0Ruxt6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cC0Ruxt6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785010750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4c4iCd4O7gDRYI5Zd7gZVBZQBxLg/Mfvh96DrUcuD9o=;
	b=cC0Ruxt6caBkJr5Fl1sOO/kx0P0msHPajX5GguhLvBs8KZWIMSQn1tEps6+KqN3BOR3g2i
	SX9+XL5KkpLMnPAJZBtD9KmJv3g38iOxQph4uzlkKlML/FBbQKrbKVdyc0JSk1bOSUR/3R
	XulxidUiGvThVwr8YJsYMzSzLULQVXY=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH BlueZ 1/3] adapter: Add btd_adapter_may_wake()
Date: Sat, 25 Jul 2026 13:18:54 -0700
Message-ID: <20260725201856.2142333-2-matthew.schwartz@linux.dev>
In-Reply-To: <20260725201856.2142333-1-matthew.schwartz@linux.dev>
References: <20260725201856.2142333-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kernel provides no interface for querying whether a controller is
currently configured to wake the host from suspend. hci_register_dev()
marks HCI_CONN_FLAG_REMOTE_WAKEUP as supported whenever a driver
provides a wakeup callback, and btusb always does, so the supported
flags reported through mgmt say nothing about the runtime setting. The
value that matters, device_may_wakeup() on the underlying USB device,
is only evaluated during the suspend flow, and the wakeup callback is
not a pure query (btmtksdio's variant sends vendor HCI commands), so
mgmt could not simply re-evaluate it on Get Device Flags without new
kernel infrastructure.

Add btd_adapter_may_wake(), which reconstructs what btusb reports by
walking the adapter's sysfs ancestry to the closest USB device and
reading its power/wakeup attribute. A missing attribute means the
device cannot generate wake events at all, which is what btusb
arranges for the fake CSR clones by clearing the USB device's wakeup
capability. The attribute is read per call so that each query
reflects the current setting.

Only USB is handled. Controllers on other buses keep the current
behavior. btmtksdio exposes the same attribute on its SDIO function
device, but its wakeup callback can also depend on a vendor command.

Assisted-by: Claude:claude-fable-5
---
 src/adapter.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  1 +
 2 files changed, 71 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index a56eafabe..65b394f82 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -563,6 +563,76 @@ uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter)
 	return adapter->bdaddr_type;
 }
 
+static bool sysfs_wakeup_enabled(const char *dir)
+{
+	char path[PATH_MAX];
+	char *contents;
+	bool enabled;
+
+	snprintf(path, sizeof(path), "%s/power/wakeup", dir);
+
+	/* A missing attribute means the device cannot wake the host */
+	if (!g_file_get_contents(path, &contents, NULL, NULL))
+		return false;
+
+	enabled = g_str_has_prefix(contents, "enabled");
+
+	g_free(contents);
+
+	return enabled;
+}
+
+static bool sysfs_is_usb_device(const char *dir)
+{
+	char path[PATH_MAX];
+
+	/* USB devices expose idVendor, USB interfaces do not */
+	snprintf(path, sizeof(path), "%s/idVendor", dir);
+
+	return g_file_test(path, G_FILE_TEST_EXISTS);
+}
+
+/*
+ * Whether the controller is currently configured to wake the host from
+ * system suspend. btusb reports this to the kernel with
+ * device_may_wakeup() on the underlying USB device, which userspace
+ * controls through its power/wakeup attribute. Only USB is handled
+ * here. Controllers on other buses are assumed to be able to wake the
+ * host. The attribute is read on every call so that runtime changes
+ * are picked up.
+ */
+bool btd_adapter_may_wake(struct btd_adapter *adapter)
+{
+	char path[PATH_MAX];
+	char *dir;
+	char *sep;
+	bool may_wake = true;
+
+	snprintf(path, sizeof(path), "/sys/class/bluetooth/hci%u/device",
+							adapter->dev_id);
+
+	dir = realpath(path, NULL);
+	if (!dir)
+		return true;
+
+	while (g_str_has_prefix(dir, "/sys/devices/")) {
+		if (sysfs_is_usb_device(dir)) {
+			may_wake = sysfs_wakeup_enabled(dir);
+			break;
+		}
+
+		sep = strrchr(dir, '/');
+		if (!sep)
+			break;
+
+		*sep = '\0';
+	}
+
+	free(dir);
+
+	return may_wake;
+}
+
 static void store_adapter_info(struct btd_adapter *adapter)
 {
 	GKeyFile *key_file;
diff --git a/src/adapter.h b/src/adapter.h
index a9e1bbf66..ae0011ff7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -107,6 +107,7 @@ const char *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
 uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter);
 const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter);
+bool btd_adapter_may_wake(struct btd_adapter *adapter);
 
 int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec);
 void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle);
-- 
2.55.0


Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26508285066
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216526; cv=none; b=Qh+gZYuXlwaDQwZVNOabXXwjorENOFf6Fyf0n1Ue4FkT4EyYX6iUFMszY9+WbGPbsmrbYDwKtrqTqGyRYI1jiiSxV2R/A57pOHUIBvtH9tBX8PtsfX3QhQYnFVSG+ioxvh0j8GMUv299AprWjqIwS7jG+npUe2aWiSgoYhsCgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216526; c=relaxed/simple;
	bh=RYIkGaEYY0LgJNIuYOuomRPtLP/BzX+s0/r0ArSrzFA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8EpDMxjN5UkgfsbNGw2ws1I3DQHAgG7OSS3kme3POZO+LqYt5JubKFA3uQA2SNJadYTcd9OwzUFiU40q7cXiNNOv507DFb1VVAW9n6B8cD3Gx5dHrgCi/mAGRc/LLqB64DSa8pY9XoLzE5nSla76PUdYcM4dODoN0lQPS7t9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyqFEgH9; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyqFEgH9"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5314d78e74fso1448798e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753216523; x=1753821323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43cRUkGRhJIQqTj3xzjGiwJgHxzFg8BjBOZjqu0GXf0=;
        b=WyqFEgH9gskMbvwX1xhJaob8apfhf1QJv8C0HfRsDP4abJAE46hyWg9g8Z/QWBVRij
         1mWQfnlZyiZWB0NDTbE/U39oJ3p1IhIyG+DCxjJBocZPYZt/R+WWlnamn5mSjgFUTE2E
         Iz4dxHP9mFjhIflwVVGU5JL37yK9UDWxf18Mtf91UK2Eq0f+XYWfPoU2u87/6m+8wLFW
         7RpD9fXnv+l2O/mxGYYh8jUI/iSTe8zQbWytgyFko4FVTpLIilRv7CLOLE1qepgQL9ET
         KOzV8IIjseQ5PiGAAKuw57YJaGoWwaGv48NDcTvJcffozJTHOv2xOx0AqjCS/052d0W2
         LvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753216523; x=1753821323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43cRUkGRhJIQqTj3xzjGiwJgHxzFg8BjBOZjqu0GXf0=;
        b=nLoNBCEBA3CQEC+t1wHUHFVSCTJhFKP5gHuuz7P8PqkdgKay5uJ6y3/Xb1hkjkB+Jc
         oDNtpnbQPJpiA/xXDi1leC9M3aUBp0PMxzK7uU0GweXeMp1NpOFgAdCzwdDlpGEIhHo8
         gDIrfuQMexl3JHgpeY/+uobGOsTPh8W7CL//ZI/BSyaPgxZnNS7ck+gMy9MPzHz9+l30
         XJgzxo2hRDWOkxsdFHKVU+aLGTYG1+9y9+4Hy4tEb+jGtfgEGh1Y4f4B7MKjosRDdhsw
         KiDXYj12u9/2JAdyXP1pdtsW7lukqviDIckA2bT3oTlmFrBAvxuLMbESZ9/ule8d1E7o
         Fq9Q==
X-Gm-Message-State: AOJu0YzQB+ZhBCf3t2V35VFSO+2bsLzAa39uFKYAq4K7Jj/0a8EAfHVD
	rdu39HJl4xO++bOG4tsaK2dZGA5KWh0vX5vY0tAUQz8+xHb9erT92D41Jy6oEGoZ
X-Gm-Gg: ASbGncuJ2MRxKjDbsXFg3i2iitpWXP5L6gd6eDygcumz6HVMDD1rcpFw2PYm7WIHxXQ
	RWvuJ03EU0JhITnBTRZVCkXTe8dr03cPEclnVWESWG25FrZy29HRX3e5cwNWjiHHSoSpc0CU605
	Bzw+h5iCDWaCdcpnk1c9DFCmoFKQAkfTBzYxcRXEvuX4ZAZE6syM9l8NaVWm0Ly1vOTzoKc4Lqm
	39LUex2a9QCRSrBezOP6k8Z4RyT2e07U9h/hAmVnKhn+SIimeYnXhrf5dAUoiCvrErDMCvLZnv8
	/Az2a1n84vKlLsw18Jen4jhjML+/Hk+8eqyOCQGV6sqxfFrPPUZB+/7hddX2nQinkGFlSIiDhAh
	qBEhHCCBpkmS4XzC/4BQ+qMw1+Qib93luKVd99pLdbsMp+wb6IuTVomjDG8m9r+rbsOdc5a+/3a
	U=
X-Google-Smtp-Source: AGHT+IGm/AxGaAA3pCnkb6lj+M1s1C5rtx4RcKYlqJS3aOh3jOh2uZE1qFvw+UO6PIgA/FWXCXyvsw==
X-Received: by 2002:a05:6102:c4f:b0:4e7:bf31:2f68 with SMTP id ada2fe7eead31-4fa152574ccmr159940137.25.1753216523219;
        Tue, 22 Jul 2025 13:35:23 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0abfe699sm3444451241.5.2025.07.22.13.35.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:35:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] client: Add transport.metadata command
Date: Tue, 22 Jul 2025 16:35:08 -0400
Message-ID: <20250722203508.1311750-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722203508.1311750-1-luiz.dentz@gmail.com>
References: <20250722203508.1311750-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds transport.metadata command which can be used to update the
MediaTransport.Metadata property:

> transport.metadata <transport> "0x03 0x02 0x02 0x00"
[CHG] Transport <transport> Metadata:
  03 02 02 00
> transport.show <transport>
...
	Metadata.#0: len 0x03 type 0x02
	Metadata.Context: 0x0002
	Metadata.Context	Conversational (0x0002)
---
 client/player.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/client/player.c b/client/player.c
index e4c2d451acca..b8d7b68753b6 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5855,6 +5855,51 @@ static void cmd_volume_transport(int argc, char *argv[])
 	}
 }
 
+static void set_metadata_cb(const DBusError *error, void *user_data)
+{
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to set Metadata: %s\n", error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Changing Metadata succeeded\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_metadata_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	struct iovec iov;
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+
+	if (argc == 2) {
+		print_property(proxy, "Metadata");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	iov.iov_base = str2bytearray((char *) argv[2], &iov.iov_len);
+	if (!iov.iov_base) {
+		bt_shell_printf("Invalid argument: %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!g_dbus_proxy_set_property_array(proxy, "Metadata", DBUS_TYPE_BYTE,
+						iov.iov_base, iov.iov_len,
+						set_metadata_cb,
+						NULL, NULL)) {
+		bt_shell_printf("Failed release transport\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static const struct bt_shell_menu transport_menu = {
 	.name = "transport",
 	.desc = "Media Transport Submenu",
@@ -5887,6 +5932,9 @@ static const struct bt_shell_menu transport_menu = {
 	{ "unselect",    "<transport> [transport1...]", cmd_unselect_transport,
 						"Unselect Transport",
 						transport_generator },
+	{ "metadata",    "<transport> [value...]", cmd_metadata_transport,
+						"Get/Set Transport Metadata",
+						transport_generator },
 	{} },
 };
 
-- 
2.50.1


Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941F202F6C
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904667; cv=none; b=YgJYuCqm752M6Q3obvkFu2V3H5Kt1S98g42S7LLu6WHvc77N6PxRo7adjjf6BdyFBwOSbWGOUxZLHpni/XVrgb76yKKijbXKnI/kyySSvEg5tOYEkGLb3YYV3HMqwO5YxUzVD8CtQ93bE77QoLqfyPCiwiFeRSC4qCthrg127Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904667; c=relaxed/simple;
	bh=KYEBIpv6VgtOcQPm+QWMBc1JkAPQr1m9F9RFtH7SubY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GCEQUZjFaa0vYZJi4KGuU4xnifD1RAQrqnvcIdyAGkyUe805j9tFJCYNXYj8kCfJm20d5cOUmvzVyc12Mi/ABXN/RP4rBYMP/boIKkgJ3KWPJANxf7lb73WQJWRBXkhYCwfwlnJH/LH5JC7iCHAQyjvDLBRW04Z4ghmmVGzjVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX/afkd/; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX/afkd/"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50fc0345155so816056e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2024 06:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730904664; x=1731509464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZrCm9XK4sCY8ccc88nmkD8XGx2aVf9n5k2P64pFCIg=;
        b=MX/afkd/xdLtSJMmkEmBfY/RYgtiY4LWCVC6uf7JySbgR9Zi4+j+KUvdSHtz4mfDd1
         y+tk1eQpUNX5NZX1VNjqbz3jRynLsun61lsqVTEoQu+gVQJe4KSHT999KvcJkzS2RraE
         +iQ6o45n7DJszX9gb7P9Fr3zhAQFZZh7BJPl43bAbo7cl6hPoi77E9vmDajXr3jI6j4n
         XvP+pxEtqCeZw/47N6ESxVN60k1UWeHTi2RMXOR/N07ZNvWX5CUUQgS4AOz9RjcyPkY2
         OG6FyArQ2r0r5Qe1MceIhovI8DFnD3Xuq6ie67zrwFw7mlMe9NFmfOBB/2cyBlyREgWF
         bD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904664; x=1731509464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZrCm9XK4sCY8ccc88nmkD8XGx2aVf9n5k2P64pFCIg=;
        b=SdyWOjNg/JQCfOfleFOOJizM69vUL3McafCGpQfPcWdWznAW2rmJFi+ZJqyGMV2tHL
         6G3Dja7G07qWk56R/UDENIxz7w/+XfF8tgX1UzgVniyjpYhahhUqYziK5klMiaSdjICD
         ei8qGmo5ggZBYDy6i3D1xiyHxC2smwP+lshXec4lFCXBJP4FKShgiBKLR4dGF0xi9eoU
         ypO84P8mqd8UIMMFmh+yFYwFxkN/MCbaJyJZg2DkBVOOFVSx+xmXLb9OUPPptKFRwfwf
         3NBNlkUasSUB9KT6QE4ZerJ8/Ve4M62Yw3rK+mtKxytjNCGbnha+1mXavAs25hUXTJc5
         McPg==
X-Gm-Message-State: AOJu0YzrYhkBK4dGMbOf/7eXNTuHVFz8HnjmL7EaEdPG3R6kRWTgRruL
	aFKZWMpddgxj9la9cDoFnDPuqb5JfZTxmp8L+BqqOWJFcT9dgEqFxWCDnA==
X-Google-Smtp-Source: AGHT+IH+xjTJBx7aMx2evAdsxOpmzu4vuyMyg+r8udckJomakJHwvzJdyzWY4T3Es/FnaOllItB+fQ==
X-Received: by 2002:a05:6122:da4:b0:50d:45e1:f32c with SMTP id 71dfb90a1353d-513e30eaabfmr1716755e0c.2.1730904664403;
        Wed, 06 Nov 2024 06:51:04 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5106f2f55f9sm2642666e0c.22.2024.11.06.06.51.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:51:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] lib: Add IPC bus type
Date: Wed,  6 Nov 2024 09:51:00 -0500
Message-ID: <20241106145100.42889-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Zephyr(1) has been using the same bus defines as Linux so tools likes of
btmon, etc, are able to decode the bus under HCI, so this attempts to
synchronize the definitions by adding the missing bus type IPC(11) and its
decoding string.

[1] https://github.com/zephyrproject-rtos/zephyr/pull/80808
---
 doc/mgmt-api.txt     | 1 +
 lib/hci.c            | 2 ++
 lib/hci.h            | 1 +
 src/shared/btsnoop.h | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 59e61d361dc2..01a23526a4ef 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2500,6 +2500,7 @@ Read Extended Controller Index List Command
 		0x08	I2C
 		0x09	SMD
 		0x0A	VIRTIO
+		0x0B	IPC
 
 	Controllers marked as RAW only operation are currently not listed
 	by this command.
diff --git a/lib/hci.c b/lib/hci.c
index 937e65d48aa5..acf63f182953 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -152,6 +152,8 @@ const char *hci_bustostr(int bus)
 		return "SMD";
 	case HCI_VIRTIO:
 		return "VIRTIO";
+	case HCI_IPC:
+		return "IPC";
 	default:
 		return "Unknown";
 	}
diff --git a/lib/hci.h b/lib/hci.h
index 50f385c1ebf7..c39a72cefa9b 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -47,6 +47,7 @@ extern "C" {
 #define HCI_I2C		8
 #define HCI_SMD		9
 #define HCI_VIRTIO	10
+#define HCI_IPC		11
 
 /* HCI controller types */
 #define HCI_PRIMARY	0x00
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 80f0d5d8209c..c24755d56729 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -58,6 +58,8 @@
 #define BTSNOOP_BUS_SPI		7
 #define BTSNOOP_BUS_I2C		8
 #define BTSNOOP_BUS_SMD		9
+#define BTSNOOP_BUS_VIRTIO	10
+#define BTSNOOP_BUS_IPC		11
 
 struct btsnoop_opcode_new_index {
 	uint8_t  type;
-- 
2.47.0


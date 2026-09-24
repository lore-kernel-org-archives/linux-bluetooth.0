Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990BE4A3F32
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264811; cv=none; b=V1fvrt6vH5WD6GZwbqd+2wTSGK56G8090ti/PKyhZcXdyD9b8oCzXs0jEtjdAdJoLIUTPdZrNQgQAwQDi3fT5KtqoYzAMWCCtZaS/G0xCr+xQRPDQYyVoz+608ghqX+Tqug5uZw6gp2NVgA7GP4wql0tD4s0GzcQpWPaOj5dUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264811; c=relaxed/simple;
	bh=krH4sRu3P1H4OQgWWOZlu/EpxOhLOwP+XvzCZ4BTvcQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozxY8NZUb0pORqwM54tpkgjT9rQyYYQP/XiZP8otY/y0az2SGSbFNM4uI+cd/vvOF1l+GYP87E6Zd7LEemi+W/jUPotPVaFnxAjLuVuGeXsvO78ygVFF0qPDJxPgGC8EwagVJQ7/kHv7p452oP6V/csCu5Q2Jv7xDcaA7YSbv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDQd/RFA; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDQd/RFA"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-78564313adaso790347137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264808; x=1790869608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FHXO0KwwclyEFwfTkFf1oqSasFhEUn/4IjIXRG/71xU=;
        b=iDQd/RFA/FZYgphn32QSbNrLuEXCgVGJNv3KHbPufUxWMWQqI27N5XGeZwGtE/90n1
         yQd/TJHT2NZiDwyi9mtn3uC1ije3Nw9VIkbapIQnI0fFtucthLw6UpSeTw06FmkdnS/o
         4uKihF9okesFr74LJ6pG7VnVyVeBKJFJ15Qxe2qrmlrTztosesQKQROuXs3gSQyfxvsH
         35StS0VL7rDiSctwFbGojzolqBCWo9ps0Ff7+7o3NmWA80cYn9qv/PQEku4amFXe+xmN
         aVqmkA6Y3jI1qXIj6ZOUb6E4AOKpJyeIbivsLmBVev8nFcbrpx2Djym4HuS5HjAFkfbV
         142A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264808; x=1790869608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FHXO0KwwclyEFwfTkFf1oqSasFhEUn/4IjIXRG/71xU=;
        b=J32AmkV96W29/ipFS30ZzcaZfyds3RurPni92kJ2P89dNYqAGqHR7pKT5/mnf7dgdl
         XTmv97k6ncNJ+2HUhOQOoccuKoDQzrJ91EFVgrYWKYN6UVadJ8l4T4HTYXRTTDIhK+ZN
         W/ezNqp6Rzdn4NVxFZm67NMSdvzMOoUk8jtvGeRZkpUm9H0VIFdtbXMCblbjFsj7JgNd
         eIRGIxcTIlyvXW6WOZBV3HP5/ZsnRJGBGxoi+cx5goAlMPWOyXpSS49m2rAFa6n5P354
         0xSCf+nxVhKED805E9ZkJPYYzgG3sHkn5HWY3eEjLhF4V4P0wzIXmeJ/nHVWDOjBMyAL
         oDuQ==
X-Gm-Message-State: AFuF++m4feAmtWI/vLTeQjZJkPbTZtM4idQ8td514OOZQk/XOobnR2ZZ
	AYnpa12vRjDwrTaIvoYXfruMtjtAeagvKp/vDbrY3eu0ahxMyYlx2aGZc2sicnmu9f1qrw==
X-Gm-Gg: AYBFou39yFMkw41GuoWMzHo/CouYCzfwJ5i9Yu++a6KGhXJieiRZ88OCLZwXIzXGH1d
	2T/c3ZMQ8oqaxxLJINbBpAQi4DMDYl3zzaCm6zX7qnaD26GpwaV0u1uTmnT8DtglPI55wEvg/Li
	4Cs83tJU+6FP3v5C1CdT8M7DmWTp172IUZbAYFir0pZPMs2CDp0VZXkZLdMskKhNUoU9i4jtUy4
	RaKIDf4ho0kbewylLx3T3+3YzWI1XqwoB8j6ixbnuX9eu/mCW3PMv7IOwAT0FjNb/OhiMG/k6Ka
	0dYrLRIsznuUBCRIsJEe23oOIMXtv8GuMZS6uPwJrnT6XL6j5CBxpAhSXRPpODbkZ5O/jIRNnx3
	8q3SAhq0v61diMfBG54Lfkj3xhJWAYIqT1WaLDWT1alYpC/1opOKe0bxt30BRPVeEf8XFT0ZyAH
	vVpfhfJm6ZcDdzoXyZdNl8R8B5qvd51J2mJz0A2t6uWSm8L7UWwnR2gmXX8GCyLtAG5EXBThjCn
	uPo/oi4E1IKiM2KxEXe60EoqjQzl2ELoVsCexk9R1UPCf6Oq9qZp260DJ7PvbBH
X-Received: by 2002:a05:6102:4b1a:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7af1e4f8b12mr1181451137.24.1790264807995;
        Thu, 24 Sep 2026 08:46:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm7412428137.3.2026.09.24.08.46.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:46:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/9] client/scripts: Add HoG device scripts
Date: Thu, 24 Sep 2026 11:46:28 -0400
Message-ID: <20260924154631.369299-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924154631.369299-1-luiz.dentz@gmail.com>
References: <20260924154631.369299-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add scripts registering a HID Service (HIDS) acting as a HID over GATT
keyboard, with and without Shorter Connection Interval (SCI) support.

HID SCI Mode can be notified so the device can confirm a mode change.
---
 client/scripts/hog-device-sci.bt | 49 ++++++++++++++++++++++++++++++++
 client/scripts/hog-device.bt     | 38 +++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 client/scripts/hog-device-sci.bt
 create mode 100644 client/scripts/hog-device.bt

diff --git a/client/scripts/hog-device-sci.bt b/client/scripts/hog-device-sci.bt
new file mode 100644
index 000000000000..1bf3a0a90db7
--- /dev/null
+++ b/client/scripts/hog-device-sci.bt
@@ -0,0 +1,49 @@
+#
+# Register a HID Service (HIDS) acting as a HID over GATT (HoG) keyboard
+# with Shorter Connection Interval (SCI) support.
+#
+gatt.register-service 0x1812
+# Primary
+yes
+#
+# HID Information: bcdHID 1.11, bCountryCode 0x00,
+# Flags: NormallyConnectable and SCI Supported
+gatt.register-characteristic 0x2a4a read
+0x11 0x01 0x00 0x06
+#
+# Report Map: keyboard with Report ID 1
+gatt.register-characteristic 0x2a4b read
+0x05 0x01 0x09 0x06 0xa1 0x01 0x85 0x01 0x05 0x07 0x19 0xe0 0x29 0xe7 0x15 0x00 0x25 0x01 0x75 0x01 0x95 0x08 0x81 0x02 0x95 0x01 0x75 0x08 0x81 0x01 0x95 0x06 0x75 0x08 0x15 0x00 0x25 0x65 0x05 0x07 0x19 0x00 0x29 0x65 0x81 0x00 0xc0
+#
+# Report: Input Report ID 1
+gatt.register-characteristic 0x2a4d read,notify
+0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+# Report Reference: Report ID 1, Input
+gatt.register-descriptor 0x2908 read
+0x01 0x01
+#
+# Protocol Mode: Report Protocol Mode
+gatt.register-characteristic 0x2a4e read,write-without-response
+0x01
+#
+# HID Control Point
+gatt.register-characteristic 0x2a4c write-without-response
+0x00
+#
+# HID SCI Mode: None (0x00), notified when changed
+gatt.register-characteristic 0x2c39 read,write,notify
+0x00
+#
+# HID SCI Information (intervals in units of 0.125 ms):
+# Minimum Supported Connection Interval: 0x08 (1 ms)
+# Number of Supported Subgroups: 1
+# Subgroup[0]: Min 0x0008 (1 ms) Max 0x0050 (10 ms) Stride 0x0008 (1 ms)
+gatt.register-characteristic 0x2c3a read
+0x08 0x01 0x08 0x00 0x50 0x00 0x08 0x00
+#
+gatt.register-application
+#
+# Advertise as a keyboard with HIDS
+advertise.uuids 0x1812
+advertise.appearance 0x03c1
+power on
diff --git a/client/scripts/hog-device.bt b/client/scripts/hog-device.bt
new file mode 100644
index 000000000000..42b324eda020
--- /dev/null
+++ b/client/scripts/hog-device.bt
@@ -0,0 +1,38 @@
+#
+# Register a HID Service (HIDS) acting as a HID over GATT (HoG) keyboard
+# without Shorter Connection Interval (SCI) support.
+#
+gatt.register-service 0x1812
+# Primary
+yes
+#
+# HID Information: bcdHID 1.11, bCountryCode 0x00,
+# Flags: NormallyConnectable
+gatt.register-characteristic 0x2a4a read
+0x11 0x01 0x00 0x02
+#
+# Report Map: keyboard with Report ID 1
+gatt.register-characteristic 0x2a4b read
+0x05 0x01 0x09 0x06 0xa1 0x01 0x85 0x01 0x05 0x07 0x19 0xe0 0x29 0xe7 0x15 0x00 0x25 0x01 0x75 0x01 0x95 0x08 0x81 0x02 0x95 0x01 0x75 0x08 0x81 0x01 0x95 0x06 0x75 0x08 0x15 0x00 0x25 0x65 0x05 0x07 0x19 0x00 0x29 0x65 0x81 0x00 0xc0
+#
+# Report: Input Report ID 1
+gatt.register-characteristic 0x2a4d read,notify
+0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+# Report Reference: Report ID 1, Input
+gatt.register-descriptor 0x2908 read
+0x01 0x01
+#
+# Protocol Mode: Report Protocol Mode
+gatt.register-characteristic 0x2a4e read,write-without-response
+0x01
+#
+# HID Control Point
+gatt.register-characteristic 0x2a4c write-without-response
+0x00
+#
+gatt.register-application
+#
+# Advertise as a keyboard with HIDS
+advertise.uuids 0x1812
+advertise.appearance 0x03c1
+power on
-- 
2.55.0


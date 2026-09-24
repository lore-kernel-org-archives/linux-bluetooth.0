Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839B41A919
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289064; cv=none; b=aHLDPIzisXEs3V1li9rgW+Cq+8mq1dvK+Ye4TbAwFVQa7IoLMwgeznOmS71AYeE/7z7Cso8zpagEjlnjyEN3jWfQnUcvO32kNzr31zCO6eMjqgGVJmRdFt22wqJAdyPlVs6G6/Z8QpTCYVtjixH0Ut3ZlR/8Kj8UGopsd8QJt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289064; c=relaxed/simple;
	bh=YM0r7xxtXMoLEnGYeG7e+mrH60r3vZCekGYC7YHNpNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kn65lZTlTRudnKEr1QaihgJzNhU4OVfP5tnKEkCUrX3j9SFkhuruGeD7G98yCS5R3ij0kBRUS/ZnVgUuoyZFsxxq7q+BPNFsuBu88jpAODxu4o7MudQtEx9gsJtJhw8csMBFibH5035ayryg52I2G0JRYPQBylpGGTRIID6l1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr7CjZKP; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr7CjZKP"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c9031e714dso90351e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289061; x=1790893861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wz0+U4lflQ3l+q5328i73UaBVx4IiRSY7OVxG9dYUxA=;
        b=Gr7CjZKP86d5BiEHgqH9o9FYrDNwgc9hE5dzorGKsPe68t64bnWqjYlR92M1bi9pnU
         TjNTITe7pcIOpZqXZt63sDIu1rhHnqyfrk76p2lFAkFnlzXTHVakrfdH5hzF3eEsMU+C
         IM8Gtg2zIHzK71PwrM6bbPpyOBpuF8gUJP5R/Hc64CRTpNrliT1nVwyLE8nTkY4ucLu0
         Mh9N38t9QYeEBZvjhPqsko2d0BUcUNZ3Kk2/b/NIduYboDDnQXJfHkj1aJxDY2E+R6kN
         QtImxQ5G2C8Nw8GTQo0Tz2pZlkVeO5M1/BJyrZj73hwhihSn5bcXTpoGMwDCP7ocL6ms
         vM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289061; x=1790893861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wz0+U4lflQ3l+q5328i73UaBVx4IiRSY7OVxG9dYUxA=;
        b=u4LZNhDOkGcFJm7pQTsOaPy6S189ZAnYrAY3BCGFT6CcG7Kpn/jIBDAGwBs6Ey3bKo
         k7ahewnhLdXeJGW+07TYzbx74YmI1sGj0JEFbAaq6tCJUuattw5nK0eKrts9ONKCU9OB
         hC3SAravvCBhPxFN9pREuDYYGoKa1dLhEpTM8a+Ga2dBY8jaNi9HlyH2O0TIlfZzucdZ
         qQ58lgXXxjCe6ywX939wRg+DlefY5czff5iMCZ122DTVROQDdHmLWkZD56VypgJ0u7MU
         tUxWs/AAntfIHtfsJKBP0VFZ2FXDeYBXlGHEMv46yw+eNRL6Ni4FBIFH2aTAkeG+QbMe
         gN1A==
X-Gm-Message-State: AFuF++lc0wkJ5aucyp09OddknPXq4YNM/hxrGJknJvE0WTFU+fSFEjPN
	7a+MhzCDpxDdcvCq2JKqagZfxYBbFuubhyxAOmX94w0Q59W1Kl+mMQlh2KQP85pT4w3RHw==
X-Gm-Gg: AYBFou2Azg+hfze+s9dHziPfAs7pq2m5nnbGqCpjQCmWj7BnYLGGZqVCfV2FlcZmgvN
	TghjfyvqPVkNnN+p3Zx137XikBkh1Wv04iBZt7aG1RXUyR7SIRqWWinmcj+eqnC/UUwHqYekV7G
	9Jx6coT3ebQKXUVHvcvgleGFMHHllPuwRR7JzfqsO/wqlT/qvXZH0ycgCYetakcr0bAQgze2yS1
	byBnBipRBjsb85YDa1/PXD0QXTKVvJ+TEmM38RnZbX00w3jeIf7bnRP+eASY2y5girBoGVUM2+8
	KjC4U3kd/wXvyHun8nkhiXcWJf89ucS5NhFCm3PdEzEClHFld7NsHpf8TSVGYF9k1ffATxQe9DI
	1zlLRcBt/pZhed/qf0s3+D+r+btpoTuuwgI2WJMJ4uEhnY8YOomNOWjnopXwvxbNsvY+9flR8Jb
	PKc9XymNUdVZolRlrV9r5S4OKXxlj2RM0fq3biN858rndH4R8Mi+st7SpO5GLADf0ymRwAtOi+k
	C0WPVOuh3oX2i/vPsj16E3GYpNjHxnPY+tt3Yjtho5pmohxDPWTtnWeN1SBR30I
X-Received: by 2002:a05:6122:6081:b0:5c9:c60a:e9b2 with SMTP id 71dfb90a1353d-5cc9774d89emr144055e0c.18.1790289061210;
        Thu, 24 Sep 2026 15:31:01 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 05/20] client/scripts: Add HoG device scripts
Date: Thu, 24 Sep 2026 18:30:30 -0400
Message-ID: <20260924223046.605543-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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

Assisted-by: OpenCode:claude-opus-5.5
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


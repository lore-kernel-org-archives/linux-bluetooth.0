Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E54EE840
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625657; cv=none; b=X/sWKzNkwSwkNVC39sE+xcWCvK4Z7PqpTMmGFpkH1czN+wfsO2O1YkIUssCruGrAYgT1/whzY/yjh38nTH1daJ/LWyVJt2APxtsPNzH+SegPheixevNquBF7Izf8CH8totWPd4jZkoJ0OZ05qO4/qV2Ef27U+cIF7Kk0NlpNPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625657; c=relaxed/simple;
	bh=YM0r7xxtXMoLEnGYeG7e+mrH60r3vZCekGYC7YHNpNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIao5YktovJC+GvW+QRcS9CEW66EJpYcEiy5YELiF2YXKZEVaB1cOdsCknN+qmhd8polv6yuGiCeJwukP7/B9g4+l2rWssIplUw+H9Cwm+JnU8tDWTbb4yz7P29l8V4WlIFqg+cH7avxuMmSUuKf+5HNLMU7CqNRaQ0L93iU9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct1H4Ls9; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct1H4Ls9"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5caec6d2983so2928501e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625655; x=1791230455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wz0+U4lflQ3l+q5328i73UaBVx4IiRSY7OVxG9dYUxA=;
        b=Ct1H4Ls9ugUlCBwR5/z/L+VOzVvjxtG7Xz1oTKd9ih2bhw8K/SZSit0kz/lsfuzCZO
         9zZilRla2o4bEXrHlMVvAGy3BLEbeUHr6KeNQx0rSJN7OFbs95gucKnzXdxs7+smLPhD
         7fBxk97694ppr7ySzoE8estVvpPF372se+1OaiQjvicaI1hIW6cHoYEYGwfa8WUlTMRI
         LGPiKX6Qgtr59bA7Lt6B1E/9uIupdJT0LZikRRc1tnXY3CruAFv/sbbYYUcnYKDt9BVJ
         S22RIAVuXhUDZab0/ZV2eEwy0uAKtVKqIPfphNlavlUvcajY4ZdagBNZf2kWwHazcevj
         0W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625655; x=1791230455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wz0+U4lflQ3l+q5328i73UaBVx4IiRSY7OVxG9dYUxA=;
        b=xSEkANsx/oZX0KrwfXDrbbrAEPdzVfYQW+3cWjzHBK97ScGKgwENo/KVRrzm2Y7CKI
         YV1uPPjGuPbzEGeqbKtrVWuYKjHgj+VjUp+Nf5VMQ9zX21lAnam+fWtUBRtx4L3iRP4p
         7gSZkpdD7QVqACXY+Zk9fdFl6SuNqj5lBdKnjzZgAm36pSylrPs3JC60XtmbfgTBHPDu
         +9AtWtaIt9YE2rPrWZ/wnKS4EurmUsXJ2V54y0VmBoeMg76vSfNrzkjPScofDXYjzGf6
         vIU3dYQzvuSrSRFezOjA6rS1v0/j9fFhwo3BnBs/9C8Lpu7aZFAMCGYaz+434ZIK+lpK
         MctA==
X-Gm-Message-State: AFq9FYJYmsialtL+IZEX4yLNB0VuqiqqQMxqSJOidEz5al8hPuNaBmNr
	Wnqan3ImDIRRcOLLUbRsPji1qovsWOooxnSLY8GkxY/UG9tAfoKtAG4wE4C7Iwb6Keo=
X-Gm-Gg: AYBFou3wLv6cCDR1Kh88sRfP9GPf6z/ioypVwWS6qRU8noQ9jQysUQjJowuFTdCzkED
	fAO1QHDvyEBQlCoZgvOMkL3YdjR8/WAjvBvUiw1VOni3cbjuz6P3uwNbtVKarGBX6fgWCjfu2Z3
	jgOCKQDfrhTMF+hCjY+dta9sDJgEgcGW2RzzFh59Sfs/SgZwPhUUZFwJ0+31I8IUshAgQRZohYo
	/vzgov239k2txCdn6IEGLDbxSKImnv/EPNvIAt7388NN7X+Tocrok45OwBJF9EdoPbX4bOhoddP
	1zUn3SYLoYFTeA+vdfUv4VGxA5jJrUr+3NKswoUHVKgBE0g+Q9xspMj4zkz1F5f2JrZ6v6QAK0H
	mZJ22YPos7Yv6H0XRjiyIzFcpVSt03JsKUKYuIrtXmuE+HrTlYQvgQGMqcDdTTbtmJqqF6UhYNA
	EMW4Uh9igFFkfMGDpGoPkMmNB0s+oeytSCPlrZPm68yEWRcqrhQq/J+Xpk9HCyyPo3A8L4rvYqv
	VvhDfi8khgghccWnKskBG1QnWBXfwBuFHkxEYLDeYQPpLFp782E0cvuDsbZLO0ljoSuI5sFaDA=
X-Received: by 2002:a05:6122:338c:b0:5c8:46f3:8d26 with SMTP id 71dfb90a1353d-5cb09affa37mr6626625e0c.8.1790625654515;
        Mon, 28 Sep 2026 13:00:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.00.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:00:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 05/23] client/scripts: Add HoG device scripts
Date: Mon, 28 Sep 2026 16:00:11 -0400
Message-ID: <20260928200031.1209311-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
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


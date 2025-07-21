Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1D2DA743
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111830; cv=none; b=t93MRG7vLyZObMHjRB+er5jLycnlr6Z4ZQfMfYM74apVh0GLGu4CkS2ekZqM/PSyrLgrTo2SYe3ZOYBA/NW7FXTEHEEv1ZwGIpkMLsYDDxs3DWGGUkJ3RhG46USeKR0dvCHIWNQe5WLW3YyigmR3kAejLuKigWQK2tKvJFUld9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111830; c=relaxed/simple;
	bh=smyymOu3NPSCK3HxZ/GV5gdWGIxZJTwZ4aHqw3r7Ge8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QcFhbcZL4RVNEiO+ichRjSFI/cwd1szP6OxBG8B6pVwouJzgz9VGLAdZffhc1qpbDCnbuHut8aKZXE8HQYPhBiQ1vWktEZK12T1qCQMnrele6wvGvZjhgE5YyYtGwdIgaBZya4k3aj/TwXS5YYQObcew68crxOA0vdQOI7mUGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=I2Azn4NC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="I2Azn4NC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234c5b57557so40766905ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1753111828; x=1753716628; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3aue8C3XX6eJryL66fW8gz8PtNPMdxeDVuXm7OJoSaM=;
        b=I2Azn4NCn+FHeJGgm/qNezLrtyHh0jkRKtmwkCdQHyhhAfUBY8wfDWEm6ttWU7SSQC
         5fA9fO02NZuaodQyuVcM8wZj4hFT96YDatrLA8IZm3S/lVArGfCtqIBE6umK80JYF0ea
         kMaz3m8Rcqm7FxJzJljwCB8ujjUAlTb/SSNqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111828; x=1753716628;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aue8C3XX6eJryL66fW8gz8PtNPMdxeDVuXm7OJoSaM=;
        b=VLLNgwclsNpclq3oE/Bw37xThcZ0iML93NLMHqGlXt3zrtTrxsENgt9XPrlQjjFr/j
         NNXP7z7XFwzTasun8JNI0gKcOE1X8AVs625iSDgsyEY4BpbKHe6qq9vUdMpo870XqgG2
         thaVK7qUTLkWFYupddFULBAWIPHgNLxS/dPZygjeYuqaz4uiDPY8N1P61rMLxAVu5kO7
         uh4wmsySCSxZgiw/h/jDgGjqCv730gnI2qI+MnGslNvO4dTwHtO4hiDBirUmTYyPizN0
         5OEmaHNWXqDbbZBtsLSOqLPqA/7UKkbq9JkfslBRcMxuLsuW/y/rsO0L24IlWVU2fIA4
         xAqA==
X-Gm-Message-State: AOJu0YzDmnknYnwNCWYB9R1M1DilZUrdziLBsqZiSU+yaogtVQCBKkkQ
	2pWHooCQrEFTWZv2Y5TElXmMjlqIsdLo+Rydtz0pAorumTfh3WUuXoA5vUx0h3l8nnUNv8+HjP7
	h1+1i
X-Gm-Gg: ASbGncum6FfgYOuOzV2Cm4D44c7NiMhYeuIOkaspk7KLzkKs5BOwfZYz5n0E3d4n3dJ
	/z8V8yXCffR3fFBmbY39llE+1jlfcRCLX5UmHOYvEgqmMPTPAWW/2r86qQ03U1Mqb1xDM4gY3sw
	bRfncEhwTSc6Xzaa2b9ahbpy/h/4iHLeal4xXVaLy+DFmsHY7FLiHZwIhdOxL8HOBpjX3y7DJh8
	nB5MPcW+NCqnUnf8+WgZdgBcNu9t3jGm4pTK/UESwIwCjbvMIcaYy7g/HGTi6QMrcSiD1mEyfpV
	hAxf6bOzQU2bI0ytholLcN4vAPgX+peAjyfOP5gzhS6kYOqnR5gKoUpq0XCcvIbTDJNam9CXqne
	7GCVIQS9H0uiQYRKZ7fMQxRhZ4sC/mXY=
X-Google-Smtp-Source: AGHT+IEQS8xIFf1oVxKSq5TOQxIVnNqSEuQ4f9cplE6fC8A/ISTl8ROuS504mxt838QhO3BzExl0Yw==
X-Received: by 2002:a17:903:3508:b0:235:91a:2c with SMTP id d9443c01a7336-23e25771862mr275923825ad.42.1753111828180;
        Mon, 21 Jul 2025 08:30:28 -0700 (PDT)
Received: from localhost ([148.252.132.38])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6ef8e6sm59689925ad.212.2025.07.21.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:30:27 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:30:23 +0100
From: Chris Down <chris@chrisdown.name>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@fb.com,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_event: Mask data status from LE ext adv
 reports
Message-ID: <aH5dD1V0K7qZIOSJ@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

The Event_Type field in an LE Extended Advertising Report uses bits 5
and 6 for data status (e.g. truncation or fragmentation), not the PDU
type itself.

The ext_evt_type_to_legacy() function fails to mask these status bits
before evaluation. This causes valid advertisements with status bits set
(e.g. a truncated non-connectable advertisement, which ends up showing
as PDU type 0x40) to be misclassified as unknown and subsequently
dropped. This is okay for most checks which use bitwise AND on the
relevant event type bits, but it doesn't work for non-connectable types,
which are checked with '== LE_EXT_ADV_NON_CONN_IND' (that is, zero).

In terms of behaviour, first the device sends a truncated report:

> HCI Event: LE Meta Event (0x3e) plen 26
      LE Extended Advertising Report (0x0d)
        Entry 0
          Event type: 0x0040
            Data status: Incomplete, data truncated, no more to come
          Address type: Random (0x01)
          Address: 1D:12:46:FA:F8:6E (Non-Resolvable)
          SID: 0x03
          RSSI: -98 dBm (0x9e)
          Data length: 0x00

Then, a few seconds later, it sends the subsequent complete report:

> HCI Event: LE Meta Event (0x3e) plen 122
      LE Extended Advertising Report (0x0d)
        Entry 0
          Event type: 0x0000
            Data status: Complete
          Address type: Random (0x01)
          Address: 1D:12:46:FA:F8:6E (Non-Resolvable)
          SID: 0x03
          RSSI: -97 dBm (0x9f)
          Data length: 0x60
          Service Data: Google (0xfef3)
            Data[92]: ...

These devices often send multiple truncated reports per second.

This patch introduces a PDU type mask to ensure only the relevant bits
are evaluated, allowing for the correct translation of all valid
extended advertising packets.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_event.c   | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 797992019f9e..c210d699f4da 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2630,6 +2630,7 @@ struct hci_ev_le_conn_complete {
 #define LE_EXT_ADV_DIRECT_IND		0x0004
 #define LE_EXT_ADV_SCAN_RSP		0x0008
 #define LE_EXT_ADV_LEGACY_PDU		0x0010
+#define LE_EXT_ADV_DATA_STATUS_MASK	0x0060
 #define LE_EXT_ADV_EVT_TYPE_MASK	0x007f
 
 #define ADDR_LE_DEV_PUBLIC		0x00
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6d6061111ac5..065ad3a39a1a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6264,6 +6264,10 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 
 static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 {
+	u16 pdu_type = evt_type & ~LE_EXT_ADV_DATA_STATUS_MASK;
+	if (!pdu_type)
+		return LE_ADV_NONCONN_IND;
+
 	if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
 		switch (evt_type) {
 		case LE_LEGACY_ADV_IND:
@@ -6295,8 +6299,7 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 	if (evt_type & LE_EXT_ADV_SCAN_IND)
 		return LE_ADV_SCAN_IND;
 
-	if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
-	    evt_type & LE_EXT_ADV_DIRECT_IND)
+	if (evt_type & LE_EXT_ADV_DIRECT_IND)
 		return LE_ADV_NONCONN_IND;
 
 invalid:
-- 
2.50.0


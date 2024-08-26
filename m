Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49616199259
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703726; cv=none; b=ULP5hf3QJWlfUOKYkRMLhlyfLabarGVbMI5ff3aejr69PKCVr+fnKvuYsVLvbXd7349hlP1tNqT9kESIspL3hUos1mW3tqWvWZdXiM0dQ3IYf9gWpDts1KxFE9JR2Rq14guv67lz+rjdC3U3BglBc/MlPNwzNffLyf4uL9tnt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703726; c=relaxed/simple;
	bh=pxF72QhZbZ06J8zPYH9RSOjVHOm9t7pfIxy4158Q45w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ra90eEuYUW1uXw30EbkGg1VXzAF5Bkc79AYWPdzvUhjaoWbHfj049IneyrSFtZVaGKfqpiHrHBC87Hb+TsuWtP6kasEkwagrHRpCteWItyj0rpToWVP/B669Yb63XrNCkukSZapBlHhlEnGTtUo29Z1ktj02Bxv8qhpUqUKa4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POI/WGjI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POI/WGjI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428163f7635so40407035e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724703723; x=1725308523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcupoeiRpPRqVFDpcytO0RksaFDEg+wrYT7Qbj9iH1w=;
        b=POI/WGjILmp+Lv9PF8VLNTh7+9GLNskxKS7l89lHdneH+jef8m5zU3zZZiPAQ0cUty
         UhJbsow81FE5AX3A0mZ7IDSMBz2UfvQ6rmy9NlQfh+/TE0hkW9zd1W0JKqInC9KFX/Ko
         raC8Z87PaWwMqstc+5qiVqq6V1jKSoX9RSwVkMSH7HJ78i3SETzevoqeGhNIv06+7OQD
         a1tOKFeU5zU5pPsCM5yYRYw8t9qnpv038LmJQz0sWtc5/OnOY2quxCHGohEaoqst8tov
         phSHm4d3O5VNrJTq0tuMlowOJHY+0Typ8J4S+5pw2J4X3N0zapKXZ3OvZPueQ8o3VJnb
         ZPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703723; x=1725308523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcupoeiRpPRqVFDpcytO0RksaFDEg+wrYT7Qbj9iH1w=;
        b=L18ieGhTSn6Vn05C+kg2MZquVEK0u/E8nqF8jShm78BF53EPg/NeNlZHvSUAeUX+Q3
         3Up93v/7EnOlLoraNGDL+RCEvPb4T0xH2LsWkff6Ilv+k9F67VSb2k+l9CKPXJIRnrSw
         ucBz5qpdlpmmr72/4xC238fthX99jPQgy3YboSU4jEUFlNaEaU3LpZYyU32lgLlaFlB1
         EYzkdBv7itZ2mJvg9ILWYtAJhAYdQmF7yAHzs/0P+jNnSetdXtlYmjEIXnhinWI3cV6B
         f6rn8ZgABHjz+AaotQ50cPQMiQRFMn1l8mY/t90IuXlZm6pnMBqkncazsjmk/199iE5X
         z00g==
X-Forwarded-Encrypted: i=1; AJvYcCV08VmJllawsWLaLPvf5r5WtHjxuyd+ENXFab22p5TnkQcogQdhTc7d2xW0nWdWwGWZljks5HgQmWmm2d3DIkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5HHXrqBvcomyB8DLNobYLmATANgDkkSOUenqmakc0/SlA70T
	ClpfHcMVk5xmK0xXAuuhOcNepiUHFG8n+pVUwKLhnPpQ9kU1dS+XELIy0sKe
X-Google-Smtp-Source: AGHT+IEi8sNFHtefX/Ns+Rm2mt6XWdwuDL1qVau8050dNMzzJ1d3MiTufwSxpqESevQgkLm3q18HdQ==
X-Received: by 2002:a05:600c:5122:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-42acc8a60a7mr84998565e9.0.1724703722299;
        Mon, 26 Aug 2024 13:22:02 -0700 (PDT)
Received: from x1cx.uhrm.ch ([2a02:168:4f3f:7:4b00:1bb0:11f:418d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3730817a5acsm11437632f8f.64.2024.08.26.13.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:22:01 -0700 (PDT)
From: Markus Uhr <uhrmar@gmail.com>
To: luiz.dentz@gmail.com
Cc: Markus Uhr <uhrmar@gmail.com>,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	raul.cheleguini@gmail.com
Subject: Re: [PATCH v2] Bluetooth: Add new quirk for broken extended create connection for ATS2851
Date: Mon, 26 Aug 2024 22:21:13 +0200
Message-ID: <20240826202129.446112-1-uhrmar@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CABBYNZJgf0HobQqRR8orizGM-adToJaU20_NXfC-+jrc1efyxA@mail.gmail.com>
References: <CABBYNZJgf0HobQqRR8orizGM-adToJaU20_NXfC-+jrc1efyxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 12 Aug 2024 11:17:20 -0400
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> On Sun, Aug 11, 2024 at 5:05 PM Markus Uhr <uhrmar@gmail.com> wrote:
> >
> > I'm interested in getting this patch merged. Was this just
> > forgotten, or is there still work to be done before it can be
> > merged?  
> 
> It might need to be resend since it is no longer listed in patchwork.

This is a resubmission of the patch, rebased on current bluetooth-next
master.

In addition to the original change, this revision also disables
'enhanced connection complete' when the quirk is active. This
eliminates an ugly kernel error log

   Bluetooth: hci0: Opcode 0x200e failed: -16

when the controller connects successfully.


Best,
Markus

-- >8 --
Subject: [PATCH v3] Bluetooth: Add new quirk for broken extended create connection for ATS2851

The controller based on ATS2851 advertises support for the "LE Extended
Create Connection" command, but it does not actually implement it. This
issue is blocking the pairing process from beginning.

To resolve this, add the quirk HCI_QUIRK_BROKEN_EXT_CREATE_CONN.
This will avoid the unsupported command and instead send a regular "LE
Create Connection" command.

< HCI Command: LE Extended Create Conn.. (0x08|0x0043) plen 26
        Filter policy: Accept list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Random (0x01)
        Peer address: DD:5E:B9:FE:49:3D (Static)
        Initiating PHYs: 0x01
        Entry 0: LE 1M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 30.00 msec (0x0018)
          Max connection interval: 50.00 msec (0x0028)
          Connection latency: 0 (0x0000)
          Supervision timeout: 420 msec (0x002a)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4
      LE Extended Create Connection (0x08|0x0043) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Markus Uhr <uhrmar@gmail.com>
---
 drivers/bluetooth/btusb.c        | 1 +
 include/net/bluetooth/hci.h      | 7 +++++++
 include/net/bluetooth/hci_core.h | 9 ++++++---
 net/bluetooth/hci_sync.c         | 4 ++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 36a869a57..31f39e68a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3883,6 +3883,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
 	}
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bab1e3d74..4c942db4a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -328,6 +328,13 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
 
+	/*
+	 * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command is
+	 * disabled. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, which erroneously claims to support it.
+	 */
+	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
+
 	/*
 	 * When this quirk is set, the reserved bits of Primary/Secondary_PHY
 	 * inside the LE Extended Advertising Report events are discarded.
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e449dba69..a7a03ab13 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1876,7 +1876,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 			   !test_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &(dev)->quirks))
 
 /* Use ext create connection if command is supported */
-#define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
+#define use_ext_conn(dev) (((dev)->commands[37] & 0x80) && \
+			   !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &(dev)->quirks))
 
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
@@ -1890,8 +1891,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
  * C24: Mandatory if the LE Controller supports Connection State and either
  * LE Feature (LL Privacy) or LE Feature (Extended Advertising) is supported
  */
-#define use_enhanced_conn_complete(dev) (ll_privacy_capable(dev) || \
-					 ext_adv_capable(dev))
+#define use_enhanced_conn_complete(dev) ((ll_privacy_capable(dev) || \
+					 ext_adv_capable(dev)) && \
+					 !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, \
+						 &(dev)->quirks))
 
 /* Periodic advertising support */
 #define per_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_PERIODIC_ADV))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e79cd40bd..160f260a7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4800,6 +4800,9 @@ static const struct {
 	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
 			 "HCI LE Set Random Private Address Timeout command is "
 			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
+			 "HCI LE Extended Create Connection command is "
+			 "advertised, but not supported."),
 	HCI_QUIRK_BROKEN(LE_CODED,
 			 "HCI LE Coded PHY feature bit is set, "
 			 "but its usage is not supported.")
@@ -6427,6 +6430,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	if (err)
 		goto done;
 
+	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
 		goto done;
-- 
2.46.0


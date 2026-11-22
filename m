Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795324334;
	b=RMN6rTDDIg3pah5MxVMgsmSNzCqS02WiuKFGCge8d5og6/ET6QJwRHVENMosG6ogvpR2
	 l4GC04xqf52eA5GTU6HqCAgGvRePMlMAVAMKbg2mTVWL+Jc/j/pkcvwaah47NG/tlGGot
	 /dUJUb+z87hB1KPFwkHGBwugH9xohm9/b4Z+tLsN3sCGijSJPJyzEO/7GCIy+4JkhpTk7
	 TlBnGEk3aqGvOjqmiuNxJQNvIuDDW98R2zzKcQdxLrZZQcOpu0bfsbAAKw36jl2XAMM+d
	 6Rbc8W+1MkX6gwr4ecfrfchL6rfwYsGLMB+OjqdIgx7qOIMKJ28/F21I+o2fy/AE6Pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324334;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qm0wfk24ya2agwvJUggvv63GyJmzYEfnNvFV0dNw0f4=;
	b=CUdPBDzfC7uTB1wfWCGsQEqgOLf3Xn5C+Gm2m0y67/MjMnE9Rfd8g0UUJrfuBxWbz4X8
	 KHbAcNyp1UGVXOpLIINZweaAsRCezOb56ey8gcEfO3faIwVZxyynICdl55LLwG06MwQ91
	 OBwP0BWwXVKkGKSCMfCKANh4sofSV41NPDztVp0DUYEwyCBaU4ELQ9jTqp0ZoVuaKwNsF
	 /nAjc3CNZAUMa79vGT5puOVewEXw8M67Vlmk0p3WAe2bBEzYvrE8XHfOLSXzDM3+92msw
	 BhnlcEUjIDb4lWxO8Y5j8iZ146UzLagWs23yEtkLfoSSI0XUb++ZBrBo7/k9UBug7eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IITDDZKq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EE606A320;
	Sun, 22 Nov 2026 05:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IITDDZKq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795324334;
	b=1Qvcx2hxDxNDHxq2jJbmli5rCVY/0VrZCx8Tq7mN6rI3WyMYrMJEOILTV2K5fTI4aYNZ
	 sucdp5acNzoUQF2c063VP3jNmvLauXi7UYj7MCYwauTmY4oeKLyjYLe8tplRLs4vQNbPu
	 gXnzTriFTn1c4pwHYR2nWxANJf6U8AwCkTM3kpIVar6ponw9eIOsyGeiUoSA70wG7r38z
	 1i7ITSaxScIj1u7qZsHg2TMu3grfqVcQefZ5xiXTiK6RyhKqMezUrDWoxrkVfj65xbykl
	 LG8KhdHn482XyGUFZ10XipNAIiCL7p9hXtjoEDIHECBBSDNwKx8LhpGtcoWiuvROEqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795324334;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qm0wfk24ya2agwvJUggvv63GyJmzYEfnNvFV0dNw0f4=;
	b=VGjnugoHNWVK9askPzDuyqQgZlmy9UKR23BUA7TjS18texnINf2Vpfngw0HnAzmFMW5r
	 9KqmrKb6NTAsRZ9ARZE8oZOOt2YMtPjw2xx/20/AH7TLvqc7JYM5kJqlvIOxO0FY60Z/Z
	 KeHHAUu0CywpigeQM5BlS0XopUk+BMDOhH+gkBTujL7hArX3+3d+5XHgknw2b3U/vrwaH
	 2WY/YYqGE8ytQeKDCGDY/ArJYdT6hT7MWlEnoCt1o7x2Vj05hwyMnueJ0mI8qLHuczgBJ
	 3lHf1Cir1XGfxWUT7EG87OhbfmymZ96XNlVea+2kZDcMxgAoGRgpg4kEYdri/WqSK8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C6C3B1F000CA;
	Sun, 22 Nov 2026 05:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324334;
	bh=qm0wfk24ya2agwvJUggvv63GyJmzYEfnNvFV0dNw0f4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=IITDDZKqO0e3VwgtBu+xTaSow9ZE5GEvSYWySaT4BsM/2vlZ832cQaLGV1gOCZlwg
	 cs0YP0Uj9mhCCGus329XpKalAD22aKIK+55Tqm9keBoCtVs6F9j3/+qD8kakDekW+I
	 iKyeZOjwfBrFy8nidDguxrCabxpd1CRsmfRpUiFq63cChsZC9GBZ+cAhDfG5ETWyDM
	 rltn0tj2Yn96/wSW/zLrt9IljdX6C5V8oP12EqnGhcNgCwtwKM8g3bwhwkxktrPMyv
	 mQkPzA2pJDRlytEdzsJ1rw7k+r2lzXLuTs97IYbm/l5mZthqS/lYsYt44TA2LSs4iG
	 VjDvTLZwjaseQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 57C574BF13;
	Sun, 22 Nov 2026 05:12:13 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:12:05 +0000
Subject: [PATCH] Bluetooth: hci_ll: download the init script at the
 operating speed
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-hci-ll-oper-speed-v1-1-952a9c1edfde@enser.io>
X-B4-Tracking: v=1; b=H4sIAKR5AmsC/yXMwQrCMBAE0F8pe3a1iSEFf0U8JOnGREpadmsRS
 v/dRI9vmJkdhDiTwK3bgWnLkudSoU4dhOTKkzCP1aB7bZXSGr3BFDJOE84LMcpCNCL1V2P9YE2
 MEep0YYr587u9P/6Wt39RWNtXa3gnhJ5dCalFjZdtOBvkoOE4vgwf0B+YAAAA
X-Change-ID: 20261122-b4-hci-ll-oper-speed-e0346b764fff
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324331; l=5332;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=+1av/CAD+P2ReCY2LEXf8jR55fRsbXtZBigW9sg6n4Y=;
 b=omFo5tWcaF+GbD0ZUzRFYok1x5xHKCr3sFEc+Pu7YSGI4LCguUFJlwUI+Q+/H2Kb3Ck1dOWPt
 XLo+nq3Mnn6A5jIepaAq/DYEIPQZGfL9GkcXQTiH3TOBs1iJnwg8TTR
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Reply-To: emcp@enser.io
Content-Transfer-Encoding: 7bit

From: EMCP333 <emcp@enser.io>

ll_setup() downloads the TI init script at the 115200 init speed and only
then moves both ends to max-speed. TI's own user-mode init manager does
it the other way round: HCI_VS_Update_UART_HCI_Baudrate first, then the
script at speed. For a WL18xx script (TIInit_12.8.32.bts, 293 commands)
that is the difference between ~6 s and under 1 s.

The length of that window is not only a boot-time cost. On a Tegra Note 7
(WL18xx on a Tegra 114 hsuart, max-speed 3000000) the 6 s download
overlaps the WLAN core's bring-up on the same chip, and one script
command -- 0xfd82, the first after the PHY post patch -- then gets no
answer. Every cold boot logs

    command 0xfd82 tx timeout
    download firmware failed, retrying...

and the retry, with WLAN up and idle, passes. Bluetooth is ready ~35 s
after boot. With the WLAN driver blacklisted the same command answers
first time in ~140 ms. With this change the script completes 0.86 s
after hci_uart loads, with no retry, on two cold boots; the controller
then runs at 3 Mbaud and scans, and WLAN is unaffected.

Send the speed change after every BT_EN toggle, because that resets the
controller to its ROM default. If the speed change or a download at
speed fails, the remaining attempts fall back to the previous order:
script at the init speed, then the speed change. Setups whose max-speed
equals the init speed are unchanged.

Tested on the Tegra Note 7 on a next-20260422-based kernel. Not tested:
the fallback path, and controllers other than WL18xx.

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Signed-off-by: EMCP333 <emcp@enser.io>
---
 drivers/bluetooth/hci_ll.c | 71 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 3c9d98eebc..8dffe5f219 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -608,11 +608,27 @@ static int ll_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return PTR_ERR_OR_ZERO(skb);
 }
 
+/* Ask the controller to move to @speed, then follow it on the host side. */
+static int ll_set_oper_speed(struct hci_uart *hu, u32 speed)
+{
+	__le32 speed_le = cpu_to_le32(speed);
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
+			     sizeof(speed_le), &speed_le, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+	kfree_skb(skb);
+	serdev_device_set_baudrate(hu->serdev, speed);
+	return 0;
+}
+
 static int ll_setup(struct hci_uart *hu)
 {
 	int err, retry = 3;
 	struct ll_device *lldev;
 	struct serdev_device *serdev = hu->serdev;
+	bool at_speed;
 	u32 speed;
 
 	if (!serdev)
@@ -624,6 +640,23 @@ static int ll_setup(struct hci_uart *hu)
 
 	serdev_device_set_flow_control(serdev, true);
 
+	/* Operational speed if any */
+	if (hu->oper_speed)
+		speed = hu->oper_speed;
+	else if (hu->proto->oper_speed)
+		speed = hu->proto->oper_speed;
+	else
+		speed = 0;
+
+	/*
+	 * Download the init script at the operating speed, as TI's own
+	 * user-mode init manager does. At the init speed a WL18xx script
+	 * takes ~6 s, long enough to overlap the WLAN core's bring-up on the
+	 * same chip. If anything fails at speed, the remaining attempts use
+	 * the init speed.
+	 */
+	at_speed = speed && speed != hu->init_speed;
+
 	do {
 		/* Reset the Bluetooth device */
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
@@ -636,12 +669,26 @@ static int ll_setup(struct hci_uart *hu)
 			return err;
 		}
 
+		/* BT_EN just reset the controller to its ROM default speed */
+		serdev_device_set_baudrate(serdev, hu->init_speed);
+		if (at_speed) {
+			err = ll_set_oper_speed(hu, speed);
+			if (err) {
+				bt_dev_warn(hu->hdev, "speed change before download failed (%d)",
+					    err);
+				at_speed = false;
+				serdev_device_set_baudrate(serdev, hu->init_speed);
+			}
+		}
+
 		err = download_firmware(lldev);
 		if (!err)
 			break;
 
 		/* Toggle BT_EN and retry */
-		bt_dev_err(hu->hdev, "download firmware failed, retrying...");
+		bt_dev_err(hu->hdev, "download firmware failed%s, retrying...",
+			   at_speed ? " at operating speed" : "");
+		at_speed = false;
 	} while (retry--);
 
 	if (err)
@@ -663,26 +710,8 @@ static int ll_setup(struct hci_uart *hu)
 		hci_set_quirk(hu->hdev,
 			      HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
 
-	/* Operational speed if any */
-	if (hu->oper_speed)
-		speed = hu->oper_speed;
-	else if (hu->proto->oper_speed)
-		speed = hu->proto->oper_speed;
-	else
-		speed = 0;
-
-	if (speed) {
-		__le32 speed_le = cpu_to_le32(speed);
-		struct sk_buff *skb;
-
-		skb = __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
-				     sizeof(speed_le), &speed_le,
-				     HCI_INIT_TIMEOUT);
-		if (!IS_ERR(skb)) {
-			kfree_skb(skb);
-			serdev_device_set_baudrate(serdev, speed);
-		}
-	}
+	if (speed && !at_speed)
+		ll_set_oper_speed(hu, speed);
 
 	return 0;
 }

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261122-b4-hci-ll-oper-speed-e0346b764fff

Best regards,
--  
EMCP333 <emcp@enser.io>



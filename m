Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795137222;
	b=cTTG6Wxp759yTUfp4cUh8P3GpMYIfrvHbtudIBKpvD08FeS9QJr62k7ex+g3LU7/EGiw
	 Ir62Q9Pd8LRGl2gVDqYcbMlEzpFnZouMyZ/BszYXdiihgVXMKrd0dIc1g2jOKQKqdLII3
	 uVubKwXXIbOrS0MaE4JkNw9gEBAgiREyR9HYGlQXjy3Z/9kIS0ykcP69okugmGWGWUPat
	 B1rafHeI93fMEZ12zKbaP3WDjWQN6g/Gk4sGx9C6rn9wZEs0xdyxr1OlU1amFyXVo1eTJ
	 sI9v2ZvO9M6Ee0f0GHMYhT3b5jYo07oEjFiAPNnxv3XWRRA4Ih8QDLDfbJ5UO4SMMMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137222;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YyRPsaCoIIkfAHt7cqPyRJ1v7a1sa/l93ygc6VT/V7I=;
	b=TA/7M14JPh2sW7NShj5SsJwJ6vNMDumMlgb6PkQyb8L8iWS5GZE8joxtNij+D8nOSyQm
	 VxLYsyB3fc5e9uja220OmpaUSTuH6dK0B6QKRrgDaMMSqKAVSyreQnQTUcmSZXaEqdbGq
	 HIUYfwZp3COwDzOC/UL4rtNvIDD2znpRcOQy1fqzg3vUXsDDQurxXMfbiWrWBrWkxkY9t
	 usTuD4Oebr+2n7bikwlqDDe6pZqZ6gi0pE6CmSE1CKdB7rVqwSLbX+PDE//Zi7bzdhn8y
	 moI/pY1gPjSCJe5FAx1m6/150oHI0OX3J7yHCzi5oJBuBP4xSaF+SYiOHrZQwE6Y68g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUOYyR+A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3D606A320;
	Fri, 20 Nov 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUOYyR+A
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795137222;
	b=Z7pTdDvisMfeoPmoV+SABZTS5xI+7Q3rpXoO1/Fvym/Hwr0hxbNURL/kxVLsmI9Uts9S
	 922rGDhe0n3R1PhW1NLP6Qws1Y8RcGIWxznRcB6aEuZI3GDJOh9DDUqB1wfGUymDSLvN1
	 xEWs97saCTOVcKE3YsRKxR5tpPcEL/lcguUBkTB5ioT0RkEUltaPm8X04lJUJ80efvy5e
	 ZBjtsPn4XMDoAA7xIXeDli1/aiW+NYiq7iP5b+iD2Bxyb94EQ0dNoSbs4hG3+pJmsOxDM
	 BXoQ8w5W9Ty5DfmofRURXjDub42fKFDlZ28CPlJlGcVijslbAA8is3Jbvv181JO8ZPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795137222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YyRPsaCoIIkfAHt7cqPyRJ1v7a1sa/l93ygc6VT/V7I=;
	b=qjIYws1kI2QPWCBbdeDchvkNcJCTtoqngvJODDToPaQpHy7iiYN1HZydb8yTRhuX5vPd
	 kJ51noGDvxuE/0CWGsTX27kVILzdW4tdRrGHzVJ3mMyHTgCWTpt9TlMmX9nvCvQnZaY8N
	 IFQbJNRtaZ5t9ZHaBU8t9YW440mDbpV5Gx/GqjJ1PgRFwcZk0hGNhbmFYO2jSz+KdtbKQ
	 bIGPnmH5CMhutA/1LZBMkH30y30HHiDMZHTgq/twmE9yVLzii8XxJaE70q6mLtmsZo2To
	 dm8i52+QElHWkkLIOrcADRo7l4IjGUgLMJBPpAvGu+CJWEdc//TapupAj6w3/c9jIiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AF00A1F000C6;
	Fri, 20 Nov 2026 01:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795137222;
	bh=YyRPsaCoIIkfAHt7cqPyRJ1v7a1sa/l93ygc6VT/V7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XUOYyR+AxFFlFu6ECKRtVyM09Ug1mEIKXY5QOpAqO5zcNFXrTKo74VdzmvXoGViHk
	 3Dd+hE05Rq109/CHuetMN352cYLq9WA0+5TxUpZ1MGYN26VMju2mh11yCwa0yPhuPh
	 UkHqbZt8yhqwe+K96ZK2fB/EWeCfmuW5YhqMTcEMuU4IHHYpOC1uEgm4l8r8JA7kZd
	 LOpdTz7cKlkG+ccFkcKgXkUnbGmdnIxlYfcO9CZueDrhgCp7GdOQXcexd6k+oh5R9d
	 LSDsJlbfct9lyUkZqA5+5nsBk8O21HEL3Sq3+z2/W2lsrC23WvuQvyXv/UAnK8UyeP
	 YTjV7SvjRGcBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3D58542610;
	Fri, 20 Nov 2026 01:13:41 +0000 (UTC)
From: Thomas de Gruijter via B4 Relay <devnull+thomasdegruijter.pm.me@kernel.org>
Date: Fri, 20 Nov 2026 02:13:35 +0100
Subject: [PATCH 1/2] Bluetooth: MSFT: Record the filter state on Command
 Disallowed
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
Message-Id: <20261120-msft-filter-monitors-v1-1-8192f0c0791a@pm.me>
References: <20261120-msft-filter-monitors-v1-0-8192f0c0791a@pm.me>
In-Reply-To: <20261120-msft-filter-monitors-v1-0-8192f0c0791a@pm.me>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Brian Gix <brian.gix@intel.com>, Yun-Hao Chung <howardchung@google.com>, 
 Miao-chen Chou <mcchou@chromium.org>, Archie Pusaka <apusaka@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas de Gruijter <thomasdegruijter@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795137220; l=2913;
 i=thomasdegruijter@pm.me; s=20261120; h=from:subject:message-id;
 bh=9ByWVPjebUuGU8CBazRss6+Y7uMCgB12uO2GOB5lyKY=;
 b=SaGwUzLcYPLhMnCYJhcGZI5lJrJA+bj3w+9SatYoAnFos3dMPTQBh08wm55rcNE22qoTIRxYk
 bPFEkCggtuNBmTG/W248irq5PjIE2M5+k1SH5vF1b2vG2rPfExldA1i
X-Developer-Key: i=thomasdegruijter@pm.me; a=ed25519;
 pk=YtEZHHXdsASGVJkddpdFLAnfVg0G/gza+FXgPGUJZlg=
X-Endpoint-Received: by B4 Relay for thomasdegruijter@pm.me/20261120 with
 auth_id=1578
X-Original-From: Thomas de Gruijter <thomasdegruijter@pm.me>
Reply-To: thomasdegruijter@pm.me
Content-Transfer-Encoding: 7bit

From: Thomas de Gruijter <thomasdegruijter@pm.me>

msft_le_set_advertisement_filter_enable_cb() treats status 0x0C (Command
Disallowed) as success: a controller returns it when the advertisement
filter is already in the requested state, and some controllers start
with the filter enabled.

Since commit 493ea69970e2 ("Bluetooth: Convert MSFT filter HCI cmd to
hci_sync") the callback is passed the return value of
__hci_cmd_sync_status() instead of the HCI status. That function reports
Command Disallowed as -EBUSY, so the 0x0C branch is never taken and
msft->filter_enabled keeps its old value whenever the filter was already
in the requested state. msft_set_filter_enable() also always returns 0,
hiding real errors from its callers.

Pass the error code to the callback, treat -EBUSY as the filter already
being in the requested state, and return real errors from
msft_set_filter_enable(). Nothing reads msft->filter_enabled yet, but
the next patch relies on it to decide when to change the filter state.

The problem was found, with the help of an AI coding assistant
(Claude Code with Claude Opus 5.5).

Fixes: 493ea69970e2 ("Bluetooth: Convert MSFT filter HCI cmd to hci_sync")
Signed-off-by: Thomas de Gruijter <thomasdegruijter@pm.me>
---
 net/bluetooth/msft.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 7a06c2b8974b..f372df9a9831 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -1142,26 +1142,27 @@ __u64 msft_get_features(struct hci_dev *hdev)
 
 static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
 						       void *user_data,
-						       u8 status)
+						       int err)
 {
 	struct msft_cp_le_set_advertisement_filter_enable *cp = user_data;
 	struct msft_data *msft = hdev->msft_data;
 
-	/* Error 0x0C would be returned if the filter enabled status is
+	/* Error 0x0C (Command Disallowed), which __hci_cmd_sync_status()
+	 * reports as -EBUSY, would be returned if the filter enabled status is
 	 * already set to whatever we were trying to set.
 	 * Although the default state should be disabled, some controller set
 	 * the initial value to enabled. Because there is no way to know the
 	 * actual initial value before sending this command, here we also treat
 	 * error 0x0C as success.
 	 */
-	if (status != 0x00 && status != 0x0C)
+	if (err && err != -EBUSY)
 		return;
 
 	hci_dev_lock(hdev);
 
 	msft->filter_enabled = cp->enable;
 
-	if (status == 0x0C)
+	if (err == -EBUSY)
 		bt_dev_warn(hdev, "MSFT filter_enable is already %s",
 			    cp->enable ? "on" : "off");
 
@@ -1212,7 +1213,7 @@ int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 
 	msft_le_set_advertisement_filter_enable_cb(hdev, &cp, err);
 
-	return 0;
+	return err == -EBUSY ? 0 : err;
 }
 
 bool msft_curve_validity(struct hci_dev *hdev)

-- 
2.56.0



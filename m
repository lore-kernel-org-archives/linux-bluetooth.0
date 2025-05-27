Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1581188715
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333581; cv=none; b=AHQDnVTzKE6z0ZN0cRVP9XtImeQAlM7VQN16yeWCBXS8itrqZXWfwEHHc03OcsoIvo0ZWS/qg55xDDGO8KxlybwYUtTpYvUibOynzzz/qGDJD2UrQxDc6ys+Lpb3/hy83XEfebCRuyXfbh4/GJdSTlMj7j9ft4fn3VrOJpbkSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333581; c=relaxed/simple;
	bh=vRXCTahCbPNi7Gpo/oSb3d1o5RfZc0lRWZgPXj+ow1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iFbjKHpEFwBzOiV0PzMETGYZ1niRzqOKIrG4um3fRowYs0hbpH/eHr2u/aKgyB3mL+e60RNVLOB9PY6jHYUQQy0a2ewoXxG5gOzkUIj8M0ttzchz1+Kx+pQMi2tyjQNSxQxMcalpuQ3LqJxYmL/VbVnt8HVGC98w+iA0HjO8FLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9cEJjlw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9cEJjlw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DB5DC4CEE9;
	Tue, 27 May 2025 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748333581;
	bh=vRXCTahCbPNi7Gpo/oSb3d1o5RfZc0lRWZgPXj+ow1A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=j9cEJjlwguZAG8LR0kO0tdjpyeK/stFM6nMMUE87YygQvvPskAjB66xKTfHWkuq8H
	 zuaOONB5PYmA7VVYPpUMlVjCVlGpuw4vYMjCttfBPiqvpZtcZLl6vsmcprDzlAnFhI
	 Pr7LDS+XBFiWW58YBvGjXXPDMqUWH1rhMbw92yd8xlC1AHZXDh9TmgpAf363KHfk1U
	 /kriRmGQX85LY7O2sY+CcrDttlg/cZ9fWs2rWun1XLjjj5sXYOoPX/7fX+QumbkGPE
	 36guYwbdsnp6QKoXzxqHxsNZFxqhtczjJkj5X2WkEqe0hCRcJTUmADBLKRqBeuW0lw
	 7t3xf5r8PkNfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A045C54ED1;
	Tue, 27 May 2025 08:13:01 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Tue, 27 May 2025 16:12:59 +0800
Subject: [PATCH bluez v2] shared/gatt-db: Add read offset to record the
 progress of att read blob request
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-att-read-blob-rsp-err-v2-1-23c7f749e8d8@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAAp0NWgC/4WNTQ6CMBCFr0Jm7Zi2WEFX3sOw6M8ATYCSKRKVc
 HcbLuDyey/vexsk4kAJ7sUGTGtIIU4Z1KkA15upIww+MyihtNCqQrMsyGQ82iFa5DQjMaMrhbd
 SU+tLAXk7M7XhfXifYIcXfaHJcR/SEvlzvK3yKP+IV4kSK+1L6y63ur6qhxmH2AV3dnGEZt/3H
 /1clUTDAAAA
X-Change-ID: 20250527-att-read-blob-rsp-err-c30db15efd30
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748333579; l=1844;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=QBewF9n7q8M+QSBW+utFpCumWyJUTCjQVXc/v2VXmeQ=;
 b=RzCIs/F0DNe+eH8D3yuztRCawPXqNwmLYW9r1DoZPGvkD5qJvdNd04gyIQ5zRXIOgS8DqbvfX
 8H47Pyf9uMOAY6lwcDTAI/P2PLL5PRw6I7D+2jujmEe/FcWXmQEmDIl
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: Ye He <ye.he@amlogic.com>

When processing the att read blob request packet sent
by the mobile phone, Bluez ignores the offset and the
payload of each att read blob response is the same.

This patch add read offset to record the progress of
att read blob request.

Fixes: https://github.com/bluez/bluez/issues/1294

Signed-off-by: Ye He <ye.he@amlogic.com>
---
Changes in v2:
- Fix build error.
- Link to v1: https://patch.msgid.link/20250527-att-read-blob-rsp-err-v1-1-75d3bc498862@amlogic.com
---
 src/shared/gatt-db.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8951079beef1a8af7e46e87043f320640d4109f7..06af4f65bacaac39cdf9641e40fac902653c4b9c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -109,6 +109,7 @@ struct gatt_db_attribute {
 	uint32_t permissions;
 	uint16_t value_len;
 	uint8_t *value;
+	uint16_t read_offset;
 
 	gatt_db_read_t read_func;
 	gatt_db_write_t write_func;
@@ -151,7 +152,8 @@ static void pending_read_result(struct pending_read *p, int err,
 	if (p->timeout_id > 0)
 		timeout_remove(p->timeout_id);
 
-	p->func(p->attrib, err, data, length, p->user_data);
+	p->func(p->attrib, err, data + p->attrib->read_offset,
+			length - p->attrib->read_offset, p->user_data);
 
 	free(p);
 }
@@ -2126,6 +2128,8 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 	if (!attrib || !func)
 		return false;
 
+	attrib->read_offset = offset;
+
 	/* Check boundaries if value_len is set */
 	if (attrib->value_len && offset > attrib->value_len) {
 		func(attrib, BT_ATT_ERROR_INVALID_OFFSET, NULL, 0, user_data);

---
base-commit: c888c682fbd4e02dce6bf4c1f9a47328ceb02716
change-id: 20250527-att-read-blob-rsp-err-c30db15efd30

Best regards,
-- 
Ye He <ye.he@amlogic.com>



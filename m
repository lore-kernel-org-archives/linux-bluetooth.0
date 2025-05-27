Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209228E17
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329955; cv=none; b=mrK+8pd5DGVUXCwd0mlPRKrPR0+08VUdtYR89hfhTEBxhFcaiXcDF+GEJzhwS6TCt7TMQ66hmeSv2xlxR7ZyGdoLemolGLIjB+n8UAT7eYED203qMiwQAdr8qtGZu3Azdb7TF+PbD7t0e6ASlZMGuIbkQFpI1qJNBEL8mX1j53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329955; c=relaxed/simple;
	bh=0EPRLyzmpcl0iZs2rVSB+wg10sXC65RyB5a+2lgHCYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QozYz3RzNf8WGc4bQhFydENPj124I0T6XkB/QBvXPEGeNwk01OSel/0QaJlGCOBsVCcu+N8Ag6J/DOQloMxv3EtWesfGY5/0RDPLLEHLwXCTBXS9nEkRYVaARdeGQrTI3wmL4MBbsUI8qelQ/pFr6sixPSmlKCRoFw/XP/uxaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGQ7RXsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGQ7RXsB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D877AC4CEEA;
	Tue, 27 May 2025 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748329954;
	bh=0EPRLyzmpcl0iZs2rVSB+wg10sXC65RyB5a+2lgHCYo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jGQ7RXsBJf091rLxhGNJTJIpXNHgmcBGyb3qlYPAq/kK49kI7xFmaaAVTfvSrBcmw
	 kuYqiILCd5yoNDmkYrCDcICDR9zXcw2L7A0vTYNy2Nadjs8RDf7bDgzX9EmxSlrgOJ
	 i24i1WrrkrL9Qhyd1j3tmoMB+TMzUsjX7VD50q5lAFIl6N/LG3esf9iklKmXrjNRwa
	 5JqpXmg8D/6AO4L4XRKkrNZS/tXMxX4QdmbkZlLnhA+03quAo0shWb4w/v6VnI1CDK
	 LUhM8vx8K809soZrj3+XbljfB0V5j9z7ylBoXGH7n1QOGeZzhKuEeILXl/BNmJ5EYL
	 +jFerqeF15NMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A7AC54ED1;
	Tue, 27 May 2025 07:12:34 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Tue, 27 May 2025 15:12:28 +0800
Subject: [PATCH bluez] shared/gatt-db: Add read offset to record the
 progress of att read blob request
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-att-read-blob-rsp-err-v1-1-75d3bc498862@amlogic.com>
X-B4-Tracking: v=1; b=H4sIANtlNWgC/x3MywqDMBBG4VeRWXcgRkKhr1Jc5PJrB4LKRIs0+
 O4NLr/FOZUKVFDo1VVSfKXIujT0j47ixy8zWFIzWWOdcfbJft9Z4ROHvAbWsjFUOQ4mhd5hSoO
 h1m6KSc77+6aQD/xovK4/x+dYR24AAAA=
X-Change-ID: 20250527-att-read-blob-rsp-err-c30db15efd30
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748329953; l=1701;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=vxMhjFj0Gsr/BlBCous8I8eiykh+hZC7t0mFPgCbZIE=;
 b=ITiq8l3XnZwN7dHDrXlPOkN4cHONQgxviW3vK9zOjlinMlHJFcS+/2IyEJ5/+VOeqq99YjtzO
 ICoZ5uXtZl3DgobwX234aoJqz2fIhnBlzWTdbrKJj92fJ1AyvJTEsgX
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
 src/shared/gatt-db.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8951079beef1a8af7e46e87043f320640d4109f7..7c4127dbaebfa659d010a0595ea13ffbb88edade 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -109,6 +109,7 @@ struct gatt_db_attribute {
 	uint32_t permissions;
 	uint16_t value_len;
 	uint8_t *value;
+	uint16_t read_offet;
 
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



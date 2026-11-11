Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359394;
	b=cJs99VVgrBiqrkJ+cjz8KPKufZSUkiq/pjUOpdCXrMmUTzhGxAT487i9hOhpeeoK3Z7X
	 TgnfaY8UOQLPIh2KhMciahr0tHmhmEsUkq9jSTSsxfeL05EpVEe4UKbJc8lIBEjV+C10g
	 3/XA8zh91PH7nauMEu4x7sVcxrTtZqScogZhMG4BP/0khP89G/nELQC66Yp+aRPx18gfi
	 OgmqPzhvdVvvzwHdNArOJ6qGTdCNWmgWzZQvchj72z97IH0l5WY36hA9xAblY8ogN6rME
	 tYhLjaj04hTfGKzlbuHDe4yFc/URIkDiwmvA3CxafTuZTI4adjJKqxHGPaACApMOyEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qbfUdL58dfT5P1l7WHlOccnYOyG2ThCfIcB1g7EjOCc=;
	b=gzSEsZlLbfIsv9juqsNQMMqHumDxjon5MtKKecNV4wETlbT4/ok1OZEnxUcwnF4OwR4q
	 uFEPq1FPHgsmFcH/VRUnOKU5CJqJj1WYJgXfAglE+HcZWuaxyPR/1OGe6EIPsn2Aqow+J
	 kjYPDYHlRbSKOo8ADWV753wovsgmu/5iPTTb+v4bzrDk/ldmhUYgyIwCLFFfhU7M3McMo
	 UDz2p9BclV+SNA6GHZXkZcE8RqbyYzFfkuIbtfKLEwpH6RNcybeOyIZDWUT+7s/LoFEVT
	 LRTc0cOoGzqlCRk0zrZELr7PhuKfVON2JghlGO9u19khw5t3PPQVSOtNxSE2aXWh7Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DMNFvhKm;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06100606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 01:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06100606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DMNFvhKm
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso40711eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 17:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359393; x=1794964193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qbfUdL58dfT5P1l7WHlOccnYOyG2ThCfIcB1g7EjOCc=;
        b=DMNFvhKmikJJBayxCck1RMV5Up1cQxkRu+yIj9c8NCQAzwIFFytJ2djcud7CyKXlDc
         4AFUVP8wxTl9Eu19NWeVqE2pidqhXAnKzhC8sGCfCaEi+LU1w+636W7F348JwwUzAawn
         KOQnARNsf2ChAWd4XVZhj2RHPTomgowsmL6HZoWH3t/De1Bla5nCutkJvQCufXPx/+DI
         d9JCrVRWrMrIqCig6hzetfRehlkxSShHrc0b47Rb9oSx1CzIwKsTJvKsbBkrHnWGzFiF
         c/3t0Rhf/EzCSRVPebxTGPLnj0F7Or8q7wEwNhVCY+yexFTUz04Ak1+i6ZFZ3S8HIV5j
         t4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359393; x=1794964193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qbfUdL58dfT5P1l7WHlOccnYOyG2ThCfIcB1g7EjOCc=;
        b=lUdG/ahnJMD3wWSO0qn+YoYbeuEHpzw5vqw1Ikl+FkKqnyIyhl1x/MWnoMUP0UUCys
         12i8cdmKBQLt5eA+qJI79X0OTkVQeo4pw4eEVeJrJAoNbZ67IczjkL5Md/0mgRSuDMsT
         qh3snXUVwX50CnUxsQiWQ88wHDrsN9tDgs3Oat4DGgnTLd22ZuBA8qCKxdqX49x+O7SS
         qdqA5ZRCyo9LsWR+wztUVNCaqiJA6nrlmVN6OhkLLfKicvMgL5lrTkIFYLfyZ5zWjlCi
         X3raSBfk2ztnZUydzVWrz0pz/Z8rieS5QsbxnBvdCzNE5PDEBrIQIFJLOLyJ+fi2k1iC
         i7ig==
X-Gm-Message-State: APuU4Z+YwwsZclpv0GqtJx0BFXH5xjykMbMJ7CvsJOI6uUfGXcpAIuIm
	QcrZTCApgxON/1znmZKESrmjJvJfvs23SbyvPBYHw58z2QKC7wa8U54lWijHC6VkcCo=
X-Gm-Gg: AYBFou3/o5DNWNfbsiruVkaXfql9ZdOuB9pUwHuXMf2gpgbazQ3fmCU/NwlS8X9ireD
	uIG4P+tfrzBTM1ENRQVWBlkdOKlyPJa9PwJCzUMvBX7DT7nwZj4R6gw7cB2H3gCSnAsgk+EyG00
	gY5lS14WIBqVK1AUuQbK+CYVRlwrRkxKBBCKXfqOjUHvfuEHa0OTWxMwpeG5XmGMRiAHzJiPfs8
	TzQGC2DiBSv2kKGvLZRqIKWboBEgS926UuDuG6j1p1CgStSjEah0AKf028L7lS4PVkkmgURjJjq
	a2OoaUY2Xi6FW1VyrJoc3z95Szw6taIhmmarkIst/7bajS7v8XMwON3u2Q8nR4v6wVUiUDquFbI
	QAzjVNxsNUhcYiIDsCpjdbBKlup8oyNcmCMDHSQEJDhJB3OBki9CCxYhGDOnaKcDm0AcSPtGrtK
	Nilq03l3MgCko3GZqabubSduNBJhPrs0iteCKEsZfHbSmokQ+gM30boyw3LVVHyrqTwlEkf1zp5
	LFU502XTeA0EBo8E5+EqUpw4lD2tJ6CCxKaKc8wLixw16jaECq067mAyn75MS51gYf+0GMLa2fM
	yYwnmbov6IxP1dhMHlqNVrKU0E2OZtV7+z8M3kBeORqbDQIqceuPTfMNIjJo/KtJLzeam00Uebr
	QjxXClPYOmvnzxvoX2CAv
X-Received: by 2002:a05:693c:2a17:b0:36d:a465:b38e with SMTP id 5a478bee46e88-3768395f032mr1455791eec.5.1794359393141;
        Tue, 10 Nov 2026 17:09:53 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm10085492eec.28.2026.11.10.17.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:09:52 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH v2 1/3] Bluetooth: hci_sync: Set an advertising set's random address on its handle
Date: Wed, 11 Nov 2026 01:09:38 +0000
Message-ID: <20261111010940.728149-2-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111010940.728149-1-weihong.guan@gmail.com>
References: <20261111010940.728149-1-weihong.guan@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the controller supports a single advertising set,
hci_add_adv_instance() gives instance 1 handle 0x00, and the parameters,
data and enable commands for an instance use adv->handle. LE Set
Advertising Set Random Address, from hci_set_adv_set_random_addr_sync(),
still sends the instance number, 0x01, a set the controller doesn't
have, so an instance using a random address, such as a non-connectable
one, never starts:

  $ btmgmt add-adv -d 0A09434841445654455354 1
  Add Advertising failed with status 0x0d (Invalid Parameters)

  < HCI Command: LE Set Extended Advertising Parameters  Handle: 0x00
  < HCI Command: LE Set Extended Advertising Data        Handle: 0x00
  < HCI Command: LE Set Advertising Set Random Address
        Advertising handle: 0x01

Send the instance's handle, looked up with hdev->lock held.

hci_cc_le_set_adv_set_random_addr() records the address in the instance
numbered as the handle and leaves handle 0x00 alone, as that handle's
address is hdev->random_addr for instance 0. Instance 1's address on
handle 0x00 would then go unrecorded, and its RPA timer never start, so
record it in hci_set_adv_set_random_addr_sync() once the command
succeeds, as the completion does for the other handles.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
 net/bluetooth/hci_sync.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9213e3ef9..320c5ba0d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1258,6 +1258,8 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 					    bdaddr_t *random_addr)
 {
 	struct hci_cp_le_set_adv_set_rand_addr cp;
+	struct adv_info *adv;
+	u8 handle = instance;
 	int err;
 
 	if (!instance) {
@@ -1269,15 +1271,46 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 		err = hci_set_random_addr_sync(hdev, random_addr);
 		if (err)
 			return err;
+	} else {
+		hci_dev_lock(hdev);
+		adv = hci_find_adv_instance(hdev, instance);
+		if (adv)
+			handle = adv->handle;
+		hci_dev_unlock(hdev);
 	}
 
 	memset(&cp, 0, sizeof(cp));
 
-	cp.handle = instance;
+	cp.handle = handle;
 	bacpy(&cp.bdaddr, random_addr);
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err || handle == instance)
+		return err;
+
+	/* hci_cc_le_set_adv_set_random_addr() records the address of the
+	 * instance numbered as the handle, and leaves handle 0x00 to
+	 * hdev->random_addr, so record it here for an instance using another
+	 * handle: instance 1 on handle 0x00, on a controller supporting a
+	 * single advertising set.
+	 */
+	hci_dev_lock(hdev);
+
+	adv = hci_find_adv_instance(hdev, instance);
+	if (adv) {
+		bacpy(&adv->random_addr, random_addr);
+		if (!bacmp(&hdev->rpa, random_addr)) {
+			adv->rpa_expired = false;
+			queue_delayed_work(hdev->workqueue,
+					   &adv->rpa_expired_cb,
+					   secs_to_jiffies(hdev->rpa_timeout));
+		}
+	}
+
+	hci_dev_unlock(hdev);
+
+	return 0;
 }
 
 static int
-- 
2.47.3


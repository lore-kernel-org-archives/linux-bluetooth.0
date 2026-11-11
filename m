Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359399;
	b=N71O1DSp3NyxjijZG8NytBg+P5sY8dxatLhjerxr421afWS/OjXqhsHLqQ+XUkK/sbqy
	 CSslh/NaB7KomcOnshh3rH1psrLAlJiBJM8o4YB3ZMP2ocEEdMpC04+9r/fCS+9xzF2Oo
	 yRvCV5syrDaNWT4dsPPCdKVuyXHmBqR8WjRdm9m9jwvD4WWmWS1mq9XfeRQpTkS/fG/fr
	 e6H/Qm5wx1wMOH7fkcjOahAKTGZ09lovB95DaKLRMN7bjTyW7KA1SDhB7RZCIN1YVwvdl
	 5sbxJm9QOTeHCj2bILwCUtIkbfCIReyXxyYPqLb95E+CH6rOHVXgiFI1bHs4Q3kWIow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VaZDd5RoEanKXvTkyFyS8/VUhq+OJ4Z2rCoCiKehOU4=;
	b=VAysesEupKApZGY+TUBxsHWjC1CgGWZ1c+r1eBFojEcHg0MoKnulahDhkVUBk11oroSD
	 xHMVoqEwMUzCh2dH0YuBcEv075KjTHVF7mM8PI8XBJLq48dClyu6YRwFbNCIiPJLnpFU7
	 SZZ3PbLoFcH3PqMa1yW9DqjzbpDy+KRquyXb8X5vYga0f7s3c8e2Xlpj9jUTWqcHVQrp/
	 9McVMRtRMygYdkuwoCQNwJ5QB7xwdts9SLUJbCBdz10trs6TnjtzfGwVdP5EtlmnOh1Jm
	 j2re2t4pfxAA3d/68Mpjl0xrz/EpzprxOTDYu0r4rDOcf7+oFkL/oZYxd9h/5+BOZgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EEQhydsD;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA090606A332
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 01:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA090606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EEQhydsD
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37000e7234bso38906eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 17:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359398; x=1794964198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VaZDd5RoEanKXvTkyFyS8/VUhq+OJ4Z2rCoCiKehOU4=;
        b=EEQhydsDiKh2uTDlq4MYrWq6SP4IXeWJd9XYlMmnSpFiLkbwMnxeoJ7k8oT0bMQGjA
         ZOUxI0XOZdO5ywOH1SxlrzkLsdFNzWfsJvmIUCUFVyYXQDsQgCrBWqSJHtM9hYsgz6Tw
         zIqGV3COi1g6+5hTPCBRmwjwNb+6+awoOrI+oBoyZ44aOzt2CsbtOw0QS9Sggrp5L1dS
         EtN4iU0R0CYz/BMcx3HgbTRGbZq7Y77qSWrTF5kqRdKVXILfiUN0rp/jbPP/mwPbWXkB
         D1lpPT+2ncDY8uSHjFWVX6wznywNrLPJqeoIMJllQLIbxea1q0n+ogTYXXieJGVUUaM5
         Yikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359398; x=1794964198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VaZDd5RoEanKXvTkyFyS8/VUhq+OJ4Z2rCoCiKehOU4=;
        b=MVgYETyQiyoV7COhvyoMuGCtOqqHhlX+IH9gxFdjKv2EGXJWPQ0ZikXJ4XDjkYB46E
         yY9BslgYZYtStHmA5hq9/HR0rUAcb0pmaZBou93W+AN8eyr+0tgoHQ8KGmCa0ZcHMrDD
         Rry1fuIDbvgsRANNlDsu1USiO/8ibAcV/EzcN+RAWkGhcrpN3UMDtnQV4Kd1nwLDhxMj
         agWLQs4MkmTye7ZAELdMLDOwJNg1DKPf2Zn+GxTs1sjegjByM3EGjsUJWzkxg07e0Ri4
         EXEFpQrE1faoEr9UrpTQlHaxLIPhl5fjLDZYt/mJckMFH/1LOli+26SRj8TRFdG2mw/R
         GeZw==
X-Gm-Message-State: APuU4Z+BAonhd1lYyjkDuls98NY2izh/xwb77bwDLgx/jCoKQKCjNqzt
	8RMx9g1cw4kwi+EDJCV9/dDA9c4M2Ucb0fgWr+gb/9Lh4hrUpdqFjZeSKz3C9IUn8UU=
X-Gm-Gg: AYBFou0K5GTv+NSkQnWxEjCA6hpzlNUFpIziiSIUnf792VJWippWTuAhJ1E0cagutIV
	8DrHV4Jzx8fXncSwyF7E+AJFKLNHWVXTjK+K4e4986FLjXvXkFG9DlxtdTZ8QkGCLP579WsajL6
	9zgIWGM5D9d/hARZlaQN9xxkNSXHF58HHL0I1POS9ve+NXMk3FrXFbai8WYwxHFOwh5lIiK2cU9
	HPs7plPPQ/JQaOHiSKBVyW73JNJvBcmwX0y8WxoTVYHQt2miuDr18pRJzdR0UjxonNeDGocwEF2
	VS6Ekt6g/nfIhkM0AK76DV0lTGSeIJA2fxsmkUrPOIT9JvsH3xZ3OqFfsYYEj4tXSJkr7yYTjhi
	rjNn0+eCH2ZjcsaRRSlag9M/guvgD0RYv4/yUl31h1VcAlksgtVj9bmfwPecwlTkM+EBk7uA6Gb
	0HVeKLht9U0vTXC8nLobVVQlfv6jAAAnYy/wfnhVtAXSIrANpP1/JIsMBiKPs2dUBnHKvbguGNR
	Hmza72EFY3fAsxMouqgpWIX0yFNG2hwaiQbamEHe21wfkzBqFurWW4d+paSLD5j7FwgeNAQFK1j
	DfuixHbFCy3aWC/TI1xQKJRzohSoMgenBbwgPGpW+JX8+oU2SBELRgOWazO3s252iTZmKmH0ORn
	3
X-Received: by 2002:a05:693c:409b:b0:36c:bf78:967e with SMTP id 5a478bee46e88-37685d72ba3mr1576340eec.10.1794359398009;
        Tue, 10 Nov 2026 17:09:58 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm10085492eec.28.2026.11.10.17.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:09:57 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH v2 3/3] Bluetooth: hci_event: Find the instance owning a terminated advertising set
Date: Wed, 11 Nov 2026 01:09:40 +0000
Message-ID: <20261111010940.728149-4-weihong.guan@gmail.com>
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

hci_le_ext_adv_term_evt() looks the instance up by the event's handle,
but when the controller supports a single advertising set,
hci_add_adv_instance() gives instance 1 handle 0x00, which is also the
handle of Global Advertising. For instance 1 the event then finds no
instance, and:

 - a connection from it gets hdev->random_addr as its responder
   address, rather than the instance's random address, which SMP then
   checks against;
 - the connection stores handle 0x00 in conn->adv_instance, which is
   later restored as hdev->cur_adv_instance, so after the disconnection
   instance 0 is re-enabled rather than instance 1;
 - when the set terminates with an error, instance 0 is removed rather
   than instance 1, so instance 1 stays with no
   MGMT_EV_ADVERTISING_REMOVED.

Find the instance owning the set: for handle 0x00 the instance enabled
on it, as hci_le_ext_adv_set_enabled() tracks, and use its instance
number and random address. Global Advertising, and any other handle,
are handled as before.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
 net/bluetooth/hci_event.c | 42 +++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f0ce124bb..33ff6cd80 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6179,6 +6179,26 @@ static void hci_le_pa_sync_lost_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+/* The instance advertising on the set identified by handle. Handle 0x00 may
+ * be shared by Global Advertising and an instance, e.g. instance 1 when the
+ * controller supports a single advertising set, in which case the instance
+ * enabled on it, if any, owns the set (see hci_le_ext_adv_set_enabled()).
+ */
+static struct adv_info *hci_le_ext_adv_owner(struct hci_dev *hdev, u8 handle)
+{
+	struct adv_info *adv;
+
+	if (handle)
+		return hci_find_adv_instance(hdev, handle);
+
+	list_for_each_entry(adv, &hdev->adv_instances, list) {
+		if (!adv->handle && adv->enabled)
+			return adv;
+	}
+
+	return NULL;
+}
+
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 				    struct sk_buff *skb)
 {
@@ -6202,15 +6222,18 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	adv = hci_find_adv_instance(hdev, ev->handle);
+	adv = hci_le_ext_adv_owner(hdev, ev->handle);
 
 	if (ev->status) {
+		u8 instance;
+
 		if (!adv)
 			goto unlock;
 
 		/* Remove advertising as it has been terminated */
-		hci_remove_adv_instance(hdev, ev->handle);
-		mgmt_advertising_removed(NULL, hdev, ev->handle);
+		instance = adv->instance;
+		hci_remove_adv_instance(hdev, instance);
+		mgmt_advertising_removed(NULL, hdev, instance);
 
 		list_for_each_entry_safe(adv, n, &hdev->adv_instances, list) {
 			if (adv->enabled)
@@ -6227,22 +6250,19 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->conn_handle));
 	if (conn) {
-		/* Store handle in the connection so the correct advertising
-		 * instance can be re-enabled when disconnected.
+		/* Store the instance in the connection so the correct
+		 * advertising instance can be re-enabled when disconnected.
 		 */
-		conn->adv_instance = ev->handle;
+		conn->adv_instance = adv ? adv->instance : ev->handle;
 
 		if (hdev->adv_addr_type != ADDR_LE_DEV_RANDOM ||
 		    bacmp(&conn->resp_addr, BDADDR_ANY))
 			goto unlock;
 
-		if (!ev->handle) {
-			bacpy(&conn->resp_addr, &hdev->random_addr);
-			goto unlock;
-		}
-
 		if (adv)
 			bacpy(&conn->resp_addr, &adv->random_addr);
+		else if (!ev->handle)
+			bacpy(&conn->resp_addr, &hdev->random_addr);
 	}
 
 unlock:
-- 
2.47.3


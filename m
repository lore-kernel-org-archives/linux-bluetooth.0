Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DE3FADF3
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966450; cv=none; b=SFXVerSM4EhJGG9GajrM6G+++DdC1izx7XCnv4W6Qv3LpCBo7A7ElS4b6beUzR1gK2vF0UBDtn31XODSWhqjxxum7BQ0hCRiZN5m7oaXJWOQBIrdT841ywOgKaObNX027qHC5AsyZxS9AfHDEKWISfHvbPiFXYV4hANw3GasMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966450; c=relaxed/simple;
	bh=szt0w8DbKoVg8ulmw8/DZSgLzId9BVRNgZALH0Fp2+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz8/HyoA5zKX8372w3na1f1uyBNC1Y8+9Qq1zGRCIu7PMTjviBOj88LLHbAOZ1iAn6hLtpLccQKDgHMBL5tPEdm4+cQ82cFcHOAF0eNBp1UZ+3+Xp5AJvxuCIcxoWQTPRWDjarOMY96yjL+6dUNTs0Y+B7UNSZaK8PeY9HpvaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdWqdmNp; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdWqdmNp"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1274204434bso5037323c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774966447; x=1775571247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEznFt8iy4PfjJKzwmf2yqiGR9CX0VFuj03I+QP2lL4=;
        b=rdWqdmNp7hATISPen2+LCGDpYEYZI8wsDj3r0IqBdJqDLSeSSXboc+rbZ0dc6ZkjuD
         zAnasqWSLGb/Astl0TWfET0wrRaeeu0gDKTabdUgz+vS7pEEwD4lg4XSdORzrMN7HkD4
         gjLcnXUbAi9Nq4eB7zxL4Acst1eHFoMdJ0L6ypHgm5E+DOS+d2NkRRGwt+blTm0w+uvQ
         IBxAEm7YqthSQ5P0va8CsZvBZBM9T4iOK70hFj1uP2Y78byP7RQX7R1y+lUr+9noIFyc
         svPSc1Yq4Goc+XJt7aJbZ3cqmctAGom9RB+pWsXpyj+5blzFhQ+0JOObd76dYIC0BMDP
         CHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774966447; x=1775571247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEznFt8iy4PfjJKzwmf2yqiGR9CX0VFuj03I+QP2lL4=;
        b=Y2hL6WwTrq+8NVH0B5XSvhxegYSpFPY5gDIleZbvtUGWvZzksgClBGT5sITbmxiJDO
         +I1IccW3bV9bBMx1QGzFhLazS6uRgGN8qzf+zR199y9YIhKzHGYEF4SgWdYpz5GJpfIt
         DuruCMF3S0yttj5xePNQBDwUoo182vvQ9+SR0Hlt+rLcwmzTBWJH1JTf39nbt9wdZhMD
         iReahi1SaEH0OkqM1YTo4NRWKVkybNUkuIsbUzclJrv5wTMkh20f9LUTfYqg6+O6F57T
         FhFdE9fvY0AFKltX1X6HUYNa3r4IOKYFqCz4oEV+LkLWzjcoZ9OMQrDwYiM+ygMZUjwP
         MMdg==
X-Forwarded-Encrypted: i=1; AJvYcCXCfngtytowiQF9fFqNTYsEAGkjSK1Zuu5zAN3eriGKV4MMoGkgKIYRQFm+vIo+xBntxNAuKgzztyveL34C3Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyufTZIWOSqGxKcNP3EoT89nhNdq4WxTBrBTMIMD6CEyRPoxXnK
	eFjI83if82QKb9Rd52FKq3BzVXKQLrQMgZgrHbcoyR3W1DV4Uy5ZIYpT
X-Gm-Gg: ATEYQzxc6234pFPhX4TVWBkf6NLPRzggz9Cy+seMXyu/h7RbLj+rIbmTarN3mgK6a8W
	z7Vl3zstlhPmOKNZAWgIgRjbXd1lDNgxc8tZYtm1U1Dkr9BR5wfFIormi3m+wslNcFaWWVrGQiV
	bIb88o5eOQDdH8WfD2P0qFeADU3h8yEuUkU+fTEJaq+wBua6fiOvfTDCXeGN/Y2waCc89JUF//V
	EgYOa9Rvkrg/IejBwaQj3Pn30+9jQNAVFt1NKYqxokJnIcnUwFezyRe5mREAikMZBsp9n1Fe2B/
	onDXBRIl8SG1X183tmfEDTnGDJUK8mhxd121AYOVRnca3ktqf9mRJDW8IQZirdI7POWc6uyww2G
	3pUR/gvbwEDWSepFMP2NPjK2STUh7UVMdkTBKw3ubgLa6n3wqKomJNS899XAQRQKZKDZUEBF2kC
	h5TIAk5jFBBiNhwgcX1Qhdb1lhZoRAoAe6Z1p3WJuBJ+ZX/nDhXqS0SOr8w0cIwCM4tg==
X-Received: by 2002:a05:7022:e29:b0:128:cdb7:76e1 with SMTP id a92af1059eb24-12bddea1884mr1707333c88.13.1774966446399;
        Tue, 31 Mar 2026 07:14:06 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm15471461c88.7.2026.03.31.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:14:06 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_event: fix OOB read in hci_le_create_big_complete_evt
Date: Tue, 31 Mar 2026 14:13:58 +0000
Message-ID: <20260331141358.3244105-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
References: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_create_big_complete_evt() iterates over BT_BOUND connections for
a BIG handle using a while loop, accessing ev->bis_handle[i++] on each
iteration.  However, there is no check that i stays within ev->num_bis
before the array access.

When a controller sends a LE_Create_BIG_Complete event with fewer
bis_handle entries than there are BT_BOUND connections for that BIG,
or with num_bis=0, the loop reads beyond the valid bis_handle[] flex
array into adjacent heap memory.  Since the out-of-bounds values
typically exceed HCI_CONN_HANDLE_MAX (0x0EFF), hci_conn_set_handle()
rejects them and the connection remains in BT_BOUND state.  The same
connection is then found again by hci_conn_hash_lookup_big_state(),
creating an infinite loop with hci_dev_lock held.

Fix this by:

  - Breaking out of the loop when i reaches ev->num_bis and cleaning
    up all remaining BT_BOUND connections, then terminating the BIG
    since a mismatch between the host and controller state indicates
    failure.

  - Properly cleaning up the connection when hci_conn_set_handle()
    fails, instead of calling continue which leaves it in BT_BOUND
    state where it would be found again by the same lookup on the
    next iteration.

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
---
 net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 286529d2e554..64b5b497c491 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7085,9 +7085,15 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (i >= ev->num_bis)
+			break;
+
 		if (hci_conn_set_handle(conn,
-					__le16_to_cpu(ev->bis_handle[i++])))
+					__le16_to_cpu(ev->bis_handle[i++]))) {
+			hci_connect_cfm(conn, HCI_ERROR_UNSPECIFIED);
+			hci_conn_del(conn);
 			continue;
+		}
 
 		conn->state = BT_CONNECTED;
 		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
@@ -7096,7 +7102,22 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		hci_iso_setup_path(conn);
 	}
 
-	if (!ev->status && !i)
+	if (conn) {
+		/* More bound connections than BIS handles reported by the
+		 * controller -- treat this as a failure for the entire BIG
+		 * and clean up any remaining BT_BOUND connections.
+		 */
+		do {
+			hci_connect_cfm(conn, HCI_ERROR_UNSPECIFIED);
+			hci_conn_del(conn);
+		} while ((conn = hci_conn_hash_lookup_big_state(hdev,
+							ev->handle,
+							BT_BOUND,
+							HCI_ROLE_MASTER)));
+
+		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
+				   UINT_PTR(ev->handle), NULL);
+	} else if (!ev->status && !i) {
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
@@ -7104,6 +7125,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		 */
 		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
 				   UINT_PTR(ev->handle), NULL);
+	}
 
 	hci_dev_unlock(hdev);
 }
-- 
2.51.0


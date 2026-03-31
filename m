Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879853B388E
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966434; cv=none; b=Fb4vdGJth4/iHDCsf/YhKyxNlvwzvNRdMq27xKWTKK7/AOQW6/WJKqnv2RlXs39eJ75ois0UHkt9zJ1cLRgorJQjck0JiYIVT4Dz6xSkT6d5PbOQXSWU7eG+hl+Jit6fLJ7sr8uxJjnuVslxHRLh8gycKlhQnzhIpVrfiitT1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966434; c=relaxed/simple;
	bh=szt0w8DbKoVg8ulmw8/DZSgLzId9BVRNgZALH0Fp2+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgMzpKjpCgp2f5SruwpXUDeWn14wA3pZunFfzxBL/n7eJTd2VgPh2BMKWxgiQDXJu7jAnTeCfGNxiaPZD1XrBzJjUWOaAiu4YmoREbdl3nY8qHTvrtr+iXG6/v/L3c5NPBdoGq/QSc80VMrRi9uid2Mw10LgsXxhw9Erpkn+SD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2Vk1FjD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2Vk1FjD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so504416b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774966433; x=1775571233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEznFt8iy4PfjJKzwmf2yqiGR9CX0VFuj03I+QP2lL4=;
        b=F2Vk1FjDTzGMeJEBLL5KZvhExnhpcxoYDh7jRxljDbOoJQDCtRLux08bljbzY2LbWk
         D64np2pqqgfEu6GSGXBjFWBXGgqeaUWAlsL1yOP8zsVTdgZ/Nf5rwR5BgBEyFqyorrff
         Q4Q0KUrJntSqpjZhqVtBGoI+g/Y1uHyfTQ3rmpL7QLkewfQL8gvD2LZX8KaQ5VbQ8gh1
         xnJRNhkLpx9M0Vdo/LIcUIjjO+ZoGvENH7uv6RGGTEcsljDFXBxeiPj6TXC/3ZRzv9oG
         3pCLeSfqANiQCrzq6Yd5jxSpI/a5NeHaLpraCfI1qndQRvgN1sS0p5I4D/aj3XQs2rBC
         pyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774966433; x=1775571233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEznFt8iy4PfjJKzwmf2yqiGR9CX0VFuj03I+QP2lL4=;
        b=o26R8mQr803Wo8N3NLSnN6U1/eFUWPQ/3LxUbrYkhXWZqGnMcmuS9FKnns92leHBQF
         cYYtNZZefnemziKImMCG6Uc24wUKjFy69QFIfQ1tGIGSAZ9HrIanDGAH4kP2Nz/mPmQn
         Xdk2WkzxeF4UVHAuhC6GloGliN4uTAKlIYZayw+OByeICPPp/vLQ0dTOm2n5zN0nRM/0
         d8wiKhQ78dh6Cgb/p3n/97TJ4DzpXhXDOn8oYJeRD/tNYxC2XzAkPgfqS1SpYs6K0LdR
         cjlhu7ia76holP7bbwL74gaKklSUPhD+zpyu4XZoUO013kLbchsOhom/lZWWZp/pjpw6
         7OXw==
X-Forwarded-Encrypted: i=1; AJvYcCUzkCi3Tq3QmBVEx7+dv8SKea3fy3ljzQt8MmnoEvMm2ABeiy0++ojCKym/mZ6FpuC2cspzwCdw1rmktCanzvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyarFSycWUvNBcyWBkd2KdhMKrMfHHIaxRojC8wnNFDFG8YkQ/t
	dDyqROn4AoKu41tNZ8CJhVOJiP/vxIVBlzmgN7xPnaG/45fWwZp4seGE
X-Gm-Gg: ATEYQzwmP0TPD7QeI8Ik9cUS2fb/yuYr7qRMA7XV6SaK5hOk6YS+BJgE9jJwNr5CDL4
	O8MVed+O7izA85eySu+CQuXbjUI6PIF8Xf6xLUKiUCvK5K7XKbMhhnYql2mV0yPcPocvNbWUtpc
	Sd+pxIttSiQdwC15QzXHrwTEycnyTXL1qBAN3ZpyrZuJHeBkwkCzWHAs5mE8y6/pFpSba3ayjOH
	r2PvGdzMev4Ss3pY3FfFn5XP8m6edo2ETqBqYwSXjekakMJbNcCrCz/Ydo3KnGmp/ApUhq04eMU
	uIMFGYEGNIhrxk3SJZnEh2/i8XZZfkdh984ADoh+f6rxbxtuh1adJIBZtAkyurgNjYJFrzIyc77
	cBlcxBT/QAlA2f2ADuR9HA7FHHzU+gDiukQO8SienrpfN/WCd0hH+Tpm1lGGjsiFc9WpiObuPMw
	tG8T4Q
X-Received: by 2002:a05:6a00:6ca2:b0:829:6f7d:3093 with SMTP id d2e1a72fcca58-82c960942d4mr15021120b3a.48.1774966432737;
        Tue, 31 Mar 2026 07:13:52 -0700 (PDT)
Received: from hkbin-u25 ([2406:280:1003:25b6::6da])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca847ff4dsm10630221b3a.23.2026.03.31.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:13:52 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_event: fix OOB read in hci_le_create_big_complete_evt
Date: Tue, 31 Mar 2026 14:13:32 +0000
Message-ID: <20260331141332.3243059-1-hkbinbinbin@gmail.com>
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


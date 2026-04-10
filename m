Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D73203B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837988; cv=none; b=gT4/DEhZlP/QEkPqOaqqQYIdx9pqhjWpITOIsYDonkBZC2JHwVYFhCrHMQgCmEHRZnGfBzMKLdmQFZI/t2I1DjF3FC2htI0bhXJbCcz83bFdXv18JypM9MEW0E5QYLbO6hyve2ADtQx6Yx2ddYYhPEmw25Gyyyv8KqlrLDZ/+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837988; c=relaxed/simple;
	bh=2sqkraGKOjrNPsVZIuk32nKx2edaLTfYst6vQGlwrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V81rM8UCG74rkwee3rFS4hLb72SZ/KgDL1BCQ7q3eBc+Ymbf2jSQoinYcHxnunhqKxgE+tb3bH4puu/jDtRi/WYDgOIEQm5xCE+rYBYsycoFmjdzvZlcjLS3Iiyfw1u6/1c/r3TsyW54znIPLFqZOqOgp45TD9cS7NiGMkH58zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVrdJUHj; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVrdJUHj"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so1598136eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837987; x=1776442787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gOqRIDekvHj7WoWPfMJtNauE9B+cpTSvzavFMCjRXk=;
        b=qVrdJUHjQ56jzFk0WWSrBYiTb2wXflV6s1msRcrEt1ViP2zWrpX3FmGCXvUu/PMNEK
         RFtUVQwmRD+bbRaEKsinjnGooz8QDryAkGF80dfehY20LKwD+aI4Ve3WhhDy+NKMqRfC
         2ct6nBn0nkUSnlU+k9cT9/v7KNxMDnexqjy0daHEsvqOYl5hDIqJx19fGlPQt8ofvtT4
         T8duYP5kENVHC7Y1kZdgOmSEjUpuZFM+8nYNUTDYF/+OVPADxh6Ium/GYOZcGeaznhSF
         3v0l2h2qwGPIWWnWo3ICdnYcnjsOkqNq/q+pqsR07Rz+8qVCU8Q1fY6yf+XVJKgv/5LR
         PxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837987; x=1776442787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gOqRIDekvHj7WoWPfMJtNauE9B+cpTSvzavFMCjRXk=;
        b=gT1N7ZrIwgyvicYfddiXXSq8fgijF0qiJ6bOlB20uHwFIrW99qFAdJoy6oSHUbwA1Q
         pzDHJkhkxqqhTlgEvVRIGnE3SsOAdeJT/mtkrCdT4Dqbx1WaxeW/3ZsWl4oJNhew01h2
         RvvB4OZ+nTIqYAmEj1qvKJcnLGgw/c2OudyMhsBqa25T2qVc8pUL1vdLl3hVAOI90XKi
         QWRTephei4byuJKPCDDXE9Gss+LeQq7JXAd0Gn/fvl9M/FeKRLwTEiiJk693CFJBxhUz
         o+vjRGlH140hMOyRGWAzoV0U0diFpzPXcNwR9QnmOXIB0PFzzAYrPW7elDPMyuyCY+ny
         XoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz4/Dq+68Im3MT0mBEJ2pC6pJtsK19IN/5MOuHGIw7Iq6oGnOTp/lNQfCZIPoj8Vev26HSkcOhq4PfVnmzSRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2oK4+Sum+JH5RLOJ9pyGTHJG3tZVdWcA90d+ACr3O4kLYxENQ
	L340alqoMXduoNU1ps0xzaeVx/7+Fj7MJvKluH8bTBrgoJG8Et187GLU
X-Gm-Gg: AeBDievczu0tyT9PH4cBxP9M0Mtrfs6o3jq0++Y/IWM4ogURfFxIMGWc264UfNXEXeB
	6e1JTBzYm6XfB5uSwqM1zHe+x44+egJdVnXesDcXIenpWluDV4D+M3bV9qQPV0Udn0oNTDnJlr9
	rM7ClwJXV3QdZhaLaU3K+aKxguDQq+CK8GITTR3sRpuG5b6VVpFYDkrDA3rGRd6K/8N/gn3VSoN
	m9+HiwvIpcKc1/KnyRPXJB119MCMCE7ZM0obwPvVS209JOpr08Zb0bMbbscHnIv1vK82up1H5Lv
	4Y9FKZXOz45o9rWwejM6Ppeipq/N6IwlWBZg8AmuPaezucjwHOLCWhEUBm6cxyXVmppFk8G+/zS
	YskOWIXm84Ue/9YQqUFb9PfuqCYq0I+W+6f3XdvbsLLvUNAPf+TEsqgbarfjzj6S9/0CClgn/3x
	C1dlFNGowrtldfxpxxF3Nni8vtKoOtMNIZ88wWYZMIeNUyBWfOcwfEg1ao1VF1EwcrLw==
X-Received: by 2002:a05:7301:19af:b0:2c0:bfe3:b95c with SMTP id 5a478bee46e88-2d5870ad63emr2521678eec.4.1775837986601;
        Fri, 10 Apr 2026 09:19:46 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faab010sm4958395eec.12.2026.04.10.09.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:19:46 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ZhiTao Ou <hkbinbinbin@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_event: fix OOB read and infinite loop in hci_le_create_big_complete_evt
Date: Fri, 10 Apr 2026 16:19:36 +0000
Message-ID: <20260410161936.2589459-1-hkbinbinbin@gmail.com>
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

From: ZhiTao Ou <hkbinbinbin@gmail.com>

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
Signed-off-by: ZhiTao Ou <hkbinbinbin@gmail.com>
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


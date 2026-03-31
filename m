Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DCD3009ED
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936242; cv=none; b=ZsT+bto2KMcuCq+mPG6Z8obFGji+fPvMrUrqfDRVsldmhyvJxFxCtnNy2LMHKIrwLPk/jAyI45nz5Vni8U4y1kvmPD3cLA374/c1KzC67M02qApEbxU51nQXFPMcb9575buCuT6HNahNbRjJ2ea2xis/BdXAKmrwOgn2KrkudRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936242; c=relaxed/simple;
	bh=cVM85kBUixxEDF8geGvobDd+lyOPWvPL/3rV8qXg6Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTQg4vAYVw6FvIwtEq72jl6pYNP8SP53IeI1Ce+mQz/v8sm9dfVUfdj16wloxYve4acH0tHIMX8WBJh+ivFIzhKP4qCrCenbatLOZEgFcysCrayD2Z3ugZDNn3O0oJjGxL484kuoqMYVYzrvTFCoJigHmvMobjMvF3hD+PUL/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPOqQ5LC; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPOqQ5LC"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1271257ae53so5252008c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774936240; x=1775541040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eJ1yAEb3cUbVO4oLsTAGit5fCasX3X7SEleR3AgWXs=;
        b=lPOqQ5LCW1IGHvI1IQ+tQoASoZ+NcKBlDz64tchBQUkyEB6YwUgpEAWXDfn+mKgFsL
         RAQidk4UGaaGJ7nFwxupipE7uFH0Sk793TrvWq2OzsSdNWYSOe0FMVifAgwRhrTMc1x8
         VvSvF5hd/mZJ4YTqldZASKdf18clnmOWm5SNypjGPPhFZcYBKRai7qYY8u2MqCzoQNzH
         GCI8Yt5947TyubXYtDTwNmoIRIDT1Ki4hJNbbOX9ra7YP0k1tq8+Jy6sf4WMboDOOsdc
         WxTbrcMiLSY2Nla9Hf4577QWliOyWsLFsSzVgGJskBE+Og+et+/pdOphIRQqde8pvF4/
         CHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774936240; x=1775541040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eJ1yAEb3cUbVO4oLsTAGit5fCasX3X7SEleR3AgWXs=;
        b=pGh+IA8QwAEd7+Hvl//G7iUrfZjj+wk15wy09JBeSVsM3rMzpLT2eOD439WhDdKkda
         Qw4xjo7c5iNiGbTFHCsb5FGOrSn2ExJKukuY+l3+clDlqUH7AmEzoRuqj2ZBqfMNPe4v
         xxCOHxo9JdO/OxR7amW6LPFcuw2JesWhuQL/EZhnj67xp2HiGMhaEMvdtysmFOvSPOeu
         nCqkTXWt/hqK1o1gACcrAE9Zasf5CE2Rk4O1krsg6bnHo6+JbGytN3B3zDVzwqsQc/mL
         D/mNTDpyNQSfk8l+NMgSp+0Kayrn8DUGbUYKgc7zevFysWmysv9c3jlpeUgT2F2VebX8
         QwGw==
X-Gm-Message-State: AOJu0YyRS2WTNr8LcbimISL3VhR2YO+yMhzp2cYaONuke6AXckEUaBJm
	R8BPnmbNxxXcRWg0DmwfuTrLe4r1wd9GwR9t7JgAZn7yFF2nRuyHi28B
X-Gm-Gg: ATEYQzzOnAis2utTjvpDtDmQ9tvQ8bRQoTxCqvjxvx77kwYwHAHs5PQxmlgH7LiilrU
	DMBui20jMcIG5jT+QdNmbcoq1AcRuZjoiGmIV4Srvv0oE0ZzM7Fb8P+hkfXtj5g2hJ45NjXe4Y0
	Nn8xZTwTIFxPd3q8ddzvvjBLLfMcKZO40J1Evo4MbWyQvp4py1o0g+xAeSAIEu34tfbdtRR0VIG
	7zSKZaDVBnKqtZIXPClG0ruVLJb3hGzTTN/1vfvjKqRAxjJteSEr9l8lhEegJ1bYT3nyi6cQ/G3
	SU+swX1AYDKrYonALMBOV9rMAg4mZaJb28wzwtPhuDtKljwTwu/8C3khW+ToLEOh1zOkS3eX+Ii
	CMeA5hKj+7zGOkovrQQEnDUdfk+eRjHBFgKHjV0SL2iPMikF6E2fl6/W/rSyI0UUOKtn7D11SAJ
	AuVJxrKsMaksDYBswUmwJQ5iW5IIggXsF8EK3FGEJXyjcspB6gV/fFifZyUKueAtEFSQ==
X-Received: by 2002:a05:7022:62b:b0:127:380e:ff5a with SMTP id a92af1059eb24-12ab287e6c4mr6942873c88.17.1774936240096;
        Mon, 30 Mar 2026 22:50:40 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm14497560c88.4.2026.03.30.22.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:50:39 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: fix OOB read and infinite loop in hci_le_create_big_complete_evt
Date: Tue, 31 Mar 2026 05:50:32 +0000
Message-ID: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_create_big_complete_evt() iterates over BT_BOUND connections
for a BIG handle using a while loop, accessing ev->bis_handle[i++]
on each iteration.  However, there is no check that i < ev->num_bis
before the array access.

When a controller sends a LE_Create_BIG_Complete event with num_bis=0
while BT_BOUND connections exist for that BIG handle, the loop reads
beyond the valid bis_handle[] entries into adjacent heap memory.
Since the out-of-bounds values typically exceed HCI_CONN_HANDLE_MAX
(0x0EFF), hci_conn_set_handle() rejects them and the connection
remains in BT_BOUND state.  The same connection is then found again
by hci_conn_hash_lookup_big_state(), creating an infinite loop with
hci_dev_lock held that blocks all Bluetooth operations:

  Bluetooth: hci0: Invalid handle: 0x6b6b > 0x0eff
  Bluetooth: hci0: Invalid handle: 0x6b6b > 0x0eff
  ... (repeats ~177 times)
  Bluetooth: hci0: Opcode 0x2040 failed: -110
  Bluetooth: hci0: command 0x2040 tx timeout

The value 0x6b6b is the KASAN slab free poison byte (0x6b),
confirming reads of freed/uninitialized heap memory.

Fix this by adding a bounds check on i against ev->num_bis before
accessing the array.  Connections beyond the reported count are
cleaned up with HCI_ERROR_UNSPECIFIED to prevent the infinite loop.

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 286529d2e554..ebd7ae75b133 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7085,6 +7085,12 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (i >= ev->num_bis) {
+			hci_connect_cfm(conn, HCI_ERROR_UNSPECIFIED);
+			hci_conn_del(conn);
+			continue;
+		}
+
 		if (hci_conn_set_handle(conn,
 					__le16_to_cpu(ev->bis_handle[i++])))
 			continue;
-- 
2.51.0


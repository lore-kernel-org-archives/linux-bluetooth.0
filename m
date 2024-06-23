Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBB1C14;
	Sun, 23 Jun 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133920; cv=none; b=LvQxAE+50SHXcBmfLQj0cTsSL1kPujYk9I0YoPEa/InCtlymmK3jAntiZ67murg1fQoS+5WG3k1B6Xta8bJEE4dlVFYwaJcPT3Daw3mQb3lwBNc5eMcMjz8k+a8S+3v7c1Y21jLqeeAew8ap+J4F3kNoNWGDr94bGgHePdxy9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133920; c=relaxed/simple;
	bh=9PpbKR6w3Iu2ALPSmk5bOIP7zdMirW30x7ODlfnmSI8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tE4traCK2z8c2FCsJc8DSS7gJ1Xdb6ywbtC5ZCDZBJmYb30FPvWe6glI80gZYfLVHY4b6q6E0r6on4QR5yLX34bAblGENyqEFKk6tG14Bg3ss0TTwJuAUwrvug/jTxMpqRxUsodqU61FQX3tj8dftS1fvuyOSo9yHltPtEXsteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XMoYSk8i; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XMoYSk8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719133605; bh=F2Y5FsltYYu6RBm0fojOKhVSeGmbWVg+5v1x+DrOyMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XMoYSk8iu3/RNxcMdfNBfFRB1kwcXEPY4lAmYbF4VVJ3sAUZYayfJchXF6Dzx/DTH
	 0qK8W1b0Av2QMRIH9jJMz0NS3MFclj5yqN1GiGp4YcXA4LLfEQILFv8PWBWk9I4w1P
	 rMxA/OgG5PB59Aa9UT6/z6JFwZQblBxjhc4rM4fI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 1AA9C83B; Sun, 23 Jun 2024 17:06:42 +0800
X-QQ-mid: xmsmtpt1719133602t9vru0epp
Message-ID: <tencent_70F452CB86430990EEC56EEB4CBB27D40606@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aplMQ3N6eZX3MWPmIvMrZA1q+KMlXuKsOZwU/nFV7zxH6hgAzxw
	 3vPyeYKRQYf0CEzPOfkpQAtDS2+1WQQN8tw5+OUZb5sQBDBOuA3oLWoIfgnciNXm5zlxAeFJKmu+
	 0gP+bpEYfbE81+9BY4Z7kP65yj1ehRiK9o0a13/V4MVCa9oKWcdMSE45uJ+5bGZYJ0elnskSAkZW
	 d3I3wVN3VMUWTKQDCnqZZTfrHV+yADfYgQhd3NBDY1wpwRzGBonZFHlMN7Qokw04Ie2xdJUDnLxg
	 GB90md7/x7tplrRnnqs2ycuECMjL5N9HBNrE3lWhGd59mvKNIc9FXojbQFgm1IY2b/5AQLpIJjHe
	 l0DdXD+TaYUXXsBAjbG1y9Ob1JaGNNiwu8Vzm0uwfP0P8EwUurxesKfXr1kNy8LkCD5Po8QXkNyO
	 L/9Aor7uo5BibW6sCIF2Dw7xLyrGwdvcV0GQjst+b3x5+ExhQtsYFzS6NzNFg5pHU18in4h7z+4v
	 xq8CPmR2hIVv/DBTOMCTyLax6zGDVIHfcCnaMLq5wPjty9RrW/83m1xrYG8hU3AEYPt5NGmzqedg
	 JPpNEqbhGiaO0UOBNYg0PV9XlccMaqnOyaOpdBiX4eGBsvAZV0bQohL2vI6TeX7gfsGUSnSQ40kX
	 CjCc3YRWkIFJmhdqQbI6zdPyLJb7ENhM9tvTLCQC0xGnOMy00dTh9busVBIJLC72uJiAA+9W0K9J
	 wKwJ/kNuX0HAjHJDnNERxKnAnz4U69YiXuCya+Mc90Ay9zB6fM+HcWS1w58b6PQ2hK2tWMq3kt4j
	 mijuL5zq7V5h11YNrsm+mzt6Z89z7SXfsVm39keKNVvmYnhKrlLiFmd7nGmIL/jzp6seLAfTdF7p
	 FquJYffUZpKrxImja3wy7CD21gIpJ1lgpeRDaDFRUjjGGU/DqXwXedvVkYvdiXCpeGflZcsjWK
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: fix double free in hci_req_sync_complete
Date: Sun, 23 Jun 2024 17:06:43 +0800
X-OQ-MSGID: <20240623090642.3753697-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000033a6e8061b3c6d4a@google.com>
References: <00000000000033a6e8061b3c6d4a@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Look at the following situation:

cpu1                       cpu2
====                       ====
                           sock_ioctl
                           sock_do_ioctl
                           hci_sock_ioctl
hci_rx_work                hci_dev_cmd
hci_event_packet           hci_req_sync
req_complete_skb           __hci_req_sync
hci_req_sync_complete

If hci_rx_work executes before __hci_req_sync releases req_skb, everything
is normal, otherwise it will result in double free of req_skb.

Adding NULL check of req_skb before releasing it can avoid double free.

Fixes: 45d355a926ab ("Bluetooth: Fix memory leak in hci_req_sync_complete()")
Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_request.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index efea25eb56ce..3862fa6bb288 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -106,7 +106,8 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
 		if (skb) {
-			kfree_skb(hdev->req_skb);
+			if (hdev->req_skb)
+				kfree_skb(hdev->req_skb);
 			hdev->req_skb = skb_get(skb);
 		}
 		wake_up_interruptible(&hdev->req_wait_q);
-- 
2.43.0


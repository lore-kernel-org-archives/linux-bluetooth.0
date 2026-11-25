Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599445;
	b=agmIPFb9857C/nB2GLuwk++kYVQzeYxCRkrn4iuThMDWPQllgkYsWGwR3z+iBLgTOjZz
	 U1Ur1WNwu53Lbhe0K/x9XWFc8iup3FJRumEW1hHNzxjQlyvDLftI8+4TyJ6fNgmTU0yzm
	 mJh+QLSlkx6NLsJ7wugCzupP2fBrIL+86wujE0q4KVMSAr9tgir1PsCXQMMlJ6ewyZvDT
	 vxRJ3T+7vWY4wnlhbM14cE/INMJYWpXRiveujE+2SpxzEDsXO7wLccYmtd5MScF3RvADl
	 R8Dce/K+F9CbfeQmPF6Aqfq1e1Dxz4ntG0E3l93aLp37mwWomJ5ZOJFV0ozFj5jOMfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uru4uc89gdbKTgL7oPQD/8sChQuJekgJ1PKHJDsBnDk=;
	b=zase3l5+QkAY51dsjmrJC8mNXDyoPomjFiWpMaq8b/3kcm0E7BVf4Ngy84nDCuH0yPEf
	 ULCg+/fMsLk6v0BFH8BuLRBvhqy+s1bubsgjoax3gT778uPIXa10A3Mp22yGSDvryxoj5
	 EajtEOm8Jtl08CiLQlQgrZ0qRskzoAtiZ+t7DTkURJ8tT5omG5LC6Sv+fhqQrB7cvGY6T
	 L7xv2yVB5uR8cXDieF0AqxXBLh74JDIkLui4ApWCXl6K70quSjB4v991kH7Shq9MeCnUP
	 TyeddqhxLvHyRkQNnVxN/1u2XitnJRmKUI8XbpwdUkG2no7lMAbvmAc2k0j4hCjSyig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z0dLjg41;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F7606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF2F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z0dLjg41
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so46937305e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 01:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599443; x=1796204243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uru4uc89gdbKTgL7oPQD/8sChQuJekgJ1PKHJDsBnDk=;
        b=z0dLjg41R3uLk2yeb8k5wxIB6q0Ke/05wkhEoBVYgl+hRx6El5jMIq6grFlpzdFuon
         qF5yUr6pJs5UwqLBK1T8XZ5EoxNpDB9jO28H70rVYGQKIA2VZwvuONhWDs2ceMcoDWgt
         j75aSwOvJWVHlSNd/0UZPtBRyOyubmhYJmAI7CHV+tuSN1HMki1uhpJwRo6IPN8GCR3J
         OZq5nSUUWtaQ0wGfWsPBhFgGHYwz5YQdCkOSLYWDe2SES1Yi53sMnk24AOKsJeEL6IYR
         NWDNhh8/c6LAHuZaTmPQBf4g13zU5LCGWjVQmbsozJyC/XkJ1UuP5SKQr3ZGLZ8N5NAE
         dUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599443; x=1796204243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uru4uc89gdbKTgL7oPQD/8sChQuJekgJ1PKHJDsBnDk=;
        b=UPStA+23QqSCnN0fbFqESp7yFUZ6dvOCtZh+aeTMB7Fng1kTeULla94B1I4LRSZllN
         14WjqQWGmvv2od1uixvgDC5YLkBTZfbcIQwD2scTTY3+imjX9l+5ICZGKwKYpV+Gm6Jk
         MSf75wCp/S6NfwAbQHNGG0hHZJg40f3kieGfkQDAKhoZX87mWt8CLVwuacRkg5r+mHBH
         lQjQFu6Y+GdScxv5zw3sw5YNXaGY4/DI0u7rqZKWP+fA0JlaU6zCSh7JPBK3TycSl6Jn
         XFYEGmJf2XDT+aM9gV4aRNo6IdOFO88aI343zLyNz3P3f+CHJFVTXcCclpNa2hkomoDY
         ax3A==
X-Forwarded-Encrypted: i=1; AL+hErF/eE76KElbqjtKEgwVJvUgW5Kur0Pnq05mS7fqEYJuU9HK4P56gcp6wG+nZrcCOA7RZFA2luR9BTWyl1qmh/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RwfSVupE/4Hhy663bcYzemOrd9koKOZLyHvTTH79vUspiiQJn
	mOlQB96BUkNE/zEGEmz9+tRUzP9cAxtq/n/WYVaEwwapDEwRxb9vc++W
X-Gm-Gg: AZFdTZfL51xHAmvYxbZeAVuhGIK4/mJ1qALcXVPs1rmlAr462J2811QCm3N8670Vebg
	lWq7rspSwJACLglHxQ+8giaKXyLMxPuJSudUWXicN3uisEQMfQHROStjI33+VRWEN7Mhksrf9YK
	3O2LUs9AGnOM6YqOV54A7kY32TyhEFP5lQL6TohvdpfS0pYI2TLXdVLEEiwFdmKFcJfv5kpmvI0
	JwwkXSyvlYITXwSaZMFzDQlyTq6KNAMRazP22G6b/o1woN+/wEGuSM2mt/3gL6ZYDpIeiRnqY/M
	h0p5x3e8OtgtsqI+HkZH43tm85e07CBX9ONYKcWY7KwrMfos/Ft8e+NYIM6ucyz6qkkELbLgcNz
	ixKjFUNIZu1gtf9mT+4x6Qp+CCoxSCINmpUEAJ/xT6DBMMcVe+XL6YDdJSiVUKgQAIWRyj7Ir4R
	VLbdp/ZrKcbR0voJ2Pn//HKRK/B4HI+DIG8Wj9NXzM0H60VEd8BJnGTCCLoOLz8reTYGWarQS/0
	azk0kxsl/e4hpoOeBcmZMnThuFD4TiOpOtuaZVKX2Y9tVEgPBmLYs0s6Uq7c1BEeFXbm95h+Llc
	Jql9lyE1dOhZaeHFF/4AUlyQweE/mHQ97AB0sgUAsg==
X-Received: by 2002:a05:600c:6092:b0:4bb:6ac0:6dc0 with SMTP id 5b1f17b1804b1-4bb8892097fmr322215805e9.29.1795599442922;
        Wed, 25 Nov 2026 01:37:22 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm492567075e9.10.2026.11.25.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:37:22 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed, 25 Nov 2026 16:37:07 +0700
Message-ID: <20261125093708.227125-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 59437cbb5781227567dec226aaa88c66a09ccc5a upstream.

This fixes not checking if skb really contains an SCO header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Petr: add Fixes tag ]
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 84d9a445e08d..67a13dca41bb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3838,18 +3838,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_sco_hdr *hdr = (void *) skb->data;
+	struct hci_sco_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_SCO_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "SCO packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.sco_rx++;
 
@@ -3867,6 +3871,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 				       handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.55.0


Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1D481A5;
	Sun, 16 Jun 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718533270; cv=none; b=AkSBDh05iinVo0EyVKE27ydT9TvSWzl10PLGxjVEFeIk6tvwyJ0T8S3r8E+ELIAv/a4OE9zmaMoZik2vA4UM//RuD2XCPsPLZlTyt19n7dV3Ji2egC+A5usOQKkeUQo34ZXDWhCvRIIqiZfs/L/octfDrQ1qDBkCNki0ZK5FYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718533270; c=relaxed/simple;
	bh=/gF+TPeSqpiiOPBUTi1DdfZLffw2Xi7zZSekGwAhyuI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rng6iQIZ7bp2JLAvW8jtMpmh9/Ol71OoXmj+gjr3VSk3/KTLeY2VlNaXG9m4GNZktEJz76xlIddgmGccxosVpKIi/sU2XzrLoEHMx1Q5dejlqlHOfhIux6svuJ02dI5uxVdQhaKg9LWsiH6CAd6f7h7UAeFq8Zn5ylvQAXJH5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NzMtdvmT; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NzMtdvmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718533265; bh=9H+M+GoTLUJBtiF3+IABcXAnLDBNfpaHHLcYInAzR2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NzMtdvmTVRBFZMYIR0j/N2UIhoOeeEis+fzbY/xprFb9u56GDznfUeGHuxtTu1JKP
	 rs4ZyaGygW/rzs1VNP7EwacVe+MOVxdUSFbbXVrVHx+Zjhlh4QffI8YsUfR/hhD+0A
	 kUdGX3vIDJ8CGVQhWNpoi45wfyl1FUtZCAhtMfes=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 53A90AC0; Sun, 16 Jun 2024 18:20:58 +0800
X-QQ-mid: xmsmtpt1718533258ts70uv51b
Message-ID: <tencent_880C74B1776566183DC9363096E037A64A09@qq.com>
X-QQ-XMAILINFO: ND42uzdxTIzrMsG1rW4qAKnSoj6jgTZADUhkRaamPWeIm5a+peVtxdY87+KA8H
	 1+vFUixkjQtVcO0AmX/MUAVmRvd+WL2XmukyQOmWtBhPiIO3MV1U53Aj8YULjsEwmAUs48x0XkNQ
	 a/viW5+6EmONtoczByZJWT33XADv7DXa8ZfGXl9jIRgQy4FVl+rBzxa4az5Njf36b2lPMHIw9OQx
	 cQyUe7K7TAFhPDbxsa35s8PJ2ixmJ//WMhBnauRKngp/X7LXZgNvPXNCs2AJwrKYILbK+W0ZJ8II
	 veIum0/0kVGVkuP+LqEvqYhQgzOCsxcBTjvNnKnZ/Ln1IA/CifvktuL/5HWwc3o4ZyO2cNC1gxkH
	 Qh8apiSbsIcfcM/cry6HioBnHEW9OeUGdmXJNjuLOTCMCGq6JpsHY16090pKJt8vODW5+EvU6Pmg
	 CpcQ9ywQjOPFJeXUg/e6L6M5j+PnhkCDsmn9P9FTPHxPBBAH1sLTEA9CxWL2I5Wu6jgH+B7Utd/k
	 +gv26hIf1fTERUBE4Hl4o85xoowVsPUJz1O71szX6O/cvsMJK4HjxVV5vwGnjTPhBWcY9kt5Lkse
	 k3+4673cKlL98xQgYBakbFeQqGXTM6ElJCLpItBkUuVCRwMZSlY19HCqslErHOo8ZN8mJ3EINZJc
	 kLFmLz7/Hlel9yhl/kdP15NBmnLn+cv2F/GO09wtgNGA0mP8UcRUKKFArlGm27JXlqVJWPlLA4XI
	 z8VzV23cGdjcVuGEO6pC8AEmhOb/j/ZIjHpYA66Bjg9zRtvNO1eMU4BtAuLHi8x5s2h9D9nc9UdU
	 5d20VFf61FBhyC2EkTDEFon2QL7c5BUhv5p0tK8VdgchP872VMKT/XfxQ8R8eGbW4tOl+jnzkUXf
	 b+jv6EjdVSQW36tbZOL3dfsAVI7z49htJD3UVQ3A3bGJeD7NTtzsKPjgDLvBHv2UdLJg8Le+Gh
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	johan.hedberg@gmail.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	william.xuanziyang@huawei.com
Subject: [PATCH] bluetooth: handle value within the ida range should not be handled in BIG
Date: Sun, 16 Jun 2024 18:20:59 +0800
X-OQ-MSGID: <20240616102058.417715-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000bf4687061269eb1b@google.com>
References: <000000000000bf4687061269eb1b@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_big_sync_established_evt is necessary to filter out cases where the handle
value is belone to ida id range, otherwise ida will be erroneously released in 
hci_conn_cleanup. 

Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a487f9df8145..4130d64d9a80 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6893,6 +6893,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 		bis = hci_conn_hash_lookup_handle(hdev, handle);
 		if (!bis) {
+                        if (handle > HCI_CONN_HANDLE_MAX)
+                               continue;
+
 			bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
 					   HCI_ROLE_SLAVE, handle);
 			if (IS_ERR(bis))
-- 
2.43.0


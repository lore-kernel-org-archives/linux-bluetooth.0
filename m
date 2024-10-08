Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72D1C9B77;
	Tue,  8 Oct 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384943; cv=none; b=J394nP3in6dEJQMf2ScNTIeGIftod6BJFl14MtirfA1FFZDsdd2gTbIXU6gcw7oZz8E4Xilm1WuMIPAQESEDO3fzwrcHkAtXx0ylOJFHCHqTpdkMK0oFpX759EpAehSNwA/CErNcwfO7rfDqbmCn7sEL4oSkd6z7AA/wxDBmeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384943; c=relaxed/simple;
	bh=T10TmYleAujok5QXhQKKVY5Z48V+5yiR6QxVR3ZM78I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Dx+ElTiXguUf/VCT45VXnmcm3AG+RXNRt4Mc2RcbkxNhWbW2O5oqemjfgBhnlG9p1h/2f6CGcxQhCeDtb0fXktOy7lSJtrocosktBtyTV96OH5A56kpv58PzD35TcMzoxwcg5D6YKmdoQ9ClMmBdPLySD+IkMJ7GWL6T9R1Ue7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Tvbh+Bq+; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Tvbh+Bq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728384930; bh=T+n9Hu+oS2+GRG6bC2oJxuPUDQjdMM2KC0KURr7mPa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tvbh+Bq+ONPDfAblC8vg18Bka+GLryEDlVCKzEBF42X5qELksAMORyTguyFWgWbpj
	 vnxRQGWYQ6NQ4sIoRdp+vvURvg+BR7qeFD3qiilWsdEdURBqk71MVyO2lniQktIi8c
	 C9ILqryGHQ/8e6wUMr5+D+wYCmbHk0ktfSPlYqvg=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszgpua4-0.qq.com (NewEsmtp) with SMTP
	id BD1B92E1; Tue, 08 Oct 2024 18:47:17 +0800
X-QQ-mid: xmsmtpt1728384437tpvbsyid3
Message-ID: <tencent_29BA32BBF933AC9EDA1B074B621BEF259308@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJd8qWBZcD7JScyrkFLVp3zoeQc/H//lOFnxbgWIPc7/MjkZZZZe
	 uTQt1OiK46X/33AUGbd4hvC4p0hC7u2Nc0OvWQryIQbeoIukoA2GVIdckSdT1LTV0ByalBw5qaMi
	 TBw8qe11CrrWP5z7Smc83L/9Bf4sXCOp4a1yuKmZNBk2yMr37bnDq5JwRzlDUWqS6RhSCGopAfU/
	 YUXBCflNJJ0+GHgsg+fsX3UCbz4H3knyrEXCxdSsi6CRrcGvUQ6E1B/qo9k6Vt7p/q01J+9fWqge
	 4PMHNY5ns8BJnKF7T1eIqp3c1XoiYEd3tdnimo+UivtbKMk1xJZLSRKyd2REz4jMdPvwViGKft+o
	 Wb/Vj4f26HHZehOtwDuCUc2jO9Zbjnsv9XxRD6jYz6Uvn02P8gZTwOfoLgT4lQY65yklx9Q3lR0x
	 Fbt5rnFfTTzRYZ9ILsBvyqtWiGxLw1UtHorDf/dnbtnHPRJDd363QF0obm+gG3a67mMly/Scozsa
	 FPk5XUNGCGccbV3ku+3z8fpG/GIZ/hF6Dd4JOySYnbhpjx9NjN6ifTMyHQmOi1Qx8jJAC3FkALAN
	 1xvBUyHpGkOshcXOEaSaMqKINV0sJuiMtB4sVDPn42aLOM/G98w3XzcEdbUVz6eo0rR0lZASj0he
	 fin1Z4JDaBHebb7B8cDk0HyIADKK3Y0xoOOwjGeSYiAks2m3WPxvN7IrP7xX+MyAP699Gd//cKoi
	 HnyIu+anC+6KAlygSUtaqiwwJ1hbmgEB1nbTXyrRekKyAWHPkTIOoVhciG4Vlh/O9xd3k6yVG15A
	 w4avBU6BMQ41B58LVRzOAlDsiGBKJvWjlooj8142V9XzrNc26Rpim0zdKKXUB8ZJnVyLZOfE7VNw
	 cyroQOE6MuPwUPLVJ5594ElunfAEeta4xhs2ZLQtGFdMbVhBYKClI5CkCTF2tcfHtWs+B4iiL7Lg
	 /U76kZO5o=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: hci_core: remove acl hdr handle error message
Date: Tue,  8 Oct 2024 18:47:18 +0800
X-OQ-MSGID: <20241008104717.508655-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6703b264.050a0220.49194.0502.GAE@google.com>
References: <6703b264.050a0220.49194.0502.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a uninit-value in hci_rx_work.This is because l2cap didn't
execute the corresponding connection request to call l2cap_send_cmd() or
l2cap_do_send(), and ultimately called hci_add_acl_hdr() to set hdr->handle.

Therefore, when calling the thread callback function hci_rx_work() to call
hci_acldata_packet, hdr->handle should not be used directly.

Reported-and-tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6976db02c06..20605a7f3f4e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3791,8 +3791,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		l2cap_recv_acldata(conn, skb, flags);
 		return;
 	} else {
-		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
-			   handle);
+		bt_dev_err(hdev, "ACL packet for unknown connection handle");
 	}
 
 	kfree_skb(skb);
-- 
2.43.0


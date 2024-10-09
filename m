Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDB9476;
	Wed,  9 Oct 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436073; cv=none; b=hSjrqME2VKq1u0mzLEcyQA/aPz5IVFrUb1OtLKRRPKG7U3LY6C14I+HFTTUZ95hhVlccP66c2ZR5sERo2RE7/S8+FU4YEHpO7zavrpizv6d+6QOSjYe7ncReAFkbG8LMH9gwplnFvW4dgsESiJmAGlWlJcYXQzJ8lTiSTGq/8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436073; c=relaxed/simple;
	bh=lmSiH5GO4/xrxhmIoORrQIcuLgAwwiSvkvHN/NIFYUU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDmvPSp907JsduVfsHBPXvzbH0pf5W1gzIh34OEwC7wkXZYXL0a7IATN9X4txcnOd0k1m7I79sxjckXO/yUuGSVXbO2is+Kuj91ADvAoAWuI8WRdEFMoKCFHye6qx11YiXXfGAIssenQZYerA1O1baRwQscZcd+QAUSahcpZ5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FnCxK0nX; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FnCxK0nX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728436064; bh=lx/LOvs5VZqqX/WqTY32oczWkgglNbzujdXqEPWPowc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FnCxK0nXICbVHh7KThUz6drM1l6TC58shrZnjG1a4uLDmvosYjGeRqcJVkBlVA3f8
	 dqV4UtHrR4a7qxxRpTEf+vaeB/X6cNXZSPwLkC/JGibaN+VhuVXgmRUYzUpi55rYwh
	 aiJY61K4SMbfVlX/fz6jNU8OOzEDT0NRhxKJxIiA=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 1E9A1E78; Wed, 09 Oct 2024 09:07:41 +0800
X-QQ-mid: xmsmtpt1728436061t7n1c3cin
Message-ID: <tencent_68B1AEF2EEC20C9C27C246DAD2F2C6568906@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0Ch1K6qSHmuL7OfSg4k3PSsyxtBR5+Qb35X0Y183fmg7wqJq610G
	 VYqNR3HpecQicRK8Fx7gw9CkZncMl9+feABJAvnrL1AE7xyVGWT3iU2OHuZ4jGOZttHA30lW2AFJ
	 lOtEXaXOE8Fsm0N+6+6uRXSV9ZR/kNPGPYFxMtgMRglhrUdMM+Pjcjac1T2e9Txa3WIh34XHEuO5
	 m4WFPOVPX+KxB+uRKhnc+1tQNTpJnIzfgGU0FIV7D5NZ1uFNPbRwzkJt9dBxlEtiZsZY28GHoJ1t
	 WXJ4OU48kQO0aNionOTWhQ9WrbCBxVC/8P5N0fJbQaeedbsthrzNriGOdJx5a9DIslPf94J7O0LH
	 nOslpDp9wYLiNjfpesv+YCVHpL1VMPj2YUmQvSBfD8waZy2drrrQ3iwoXBJeiI95rKdRQ3vs2nkn
	 26VhKokzHhClr6wR1/FzjbgsQMY9ec3dEyMnQ1wMqINnfZbV9isl0d0ja0oLs0twzYDAlKMXT5GY
	 namBy99cbRYP7SkMsDyjkVRvMIlZw4XbkzttocssG2JKmQ7K4mlx5A48JSO40C/2OI8RMbNEuLU3
	 L5hq5jLVOfCsGr8GLcZMJiuwXWghEI7s900lt3xZU/ob3pWbe7LWXIsKyLxVW0KSH5wNzh1B9wd/
	 s/ufiVIi/t8SuM8y57k6L4RdFrqw4PM5bSNIugxgEKkK+lTGfh/0DvtMNzKjslvM80IQYpS3TfYS
	 Vfao/onRy6yB0Z09FZOmgOgFeJsUtJ6rw879PUsarggrkMwWdIsh2o6dBlp6Z2veF833cPOXGh1U
	 1XHMabGI8iqpp7/4dvo4EkHjUh1J301BrfNfdWZSeZWTGYbtld5yfjDaClm3kP5VBhzIe5fmbj3/
	 V4IgH3PLZeZKrTZ2g0opyd3j+Q2eSlggZ9ZlrPSz14ouw6AjRb2ksqUumFbRf5l+nfgnt/J8wf9F
	 EF823a9UW0czENFToUUUfC4vjM4Q3YhDit7jsPkK0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: luiz.dentz@gmail.com
Cc: eadavis@qq.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: hci_core: remove acl hdr handle error message
Date: Wed,  9 Oct 2024 09:07:40 +0800
X-OQ-MSGID: <20241009010741.780475-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CABBYNZKiNBxqZbS7hcBrpiwHRRwAe9gXvHWNvi63qBfykR=SVg@mail.gmail.com>
References: <CABBYNZKiNBxqZbS7hcBrpiwHRRwAe9gXvHWNvi63qBfykR=SVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 8 Oct 2024 10:12:34 -0400, Luiz Augusto von Dentz wrote:
> On Tue, Oct 8, 2024 at 6:47 AM Edward Adam Davis <eadavis@qq.com> wrote:
> >
> > Syzbot reported a uninit-value in hci_rx_work.This is because l2cap didn't
> > execute the corresponding connection request to call l2cap_send_cmd() or
> > l2cap_do_send(), and ultimately called hci_add_acl_hdr() to set hdr->handle.
> 
> What are you talking about here, what these functions have to do with
> a local handle variable?
> 
> > Therefore, when calling the thread callback function hci_rx_work() to call
> > hci_acldata_packet, hdr->handle should not be used directly.
> 
> It is not being used directly, the handle is a local variable which
> get assigned:
> 
>     handle = __le16_to_cpu(hdr->handle);
> 
> If what you are saying is that there is no guarantee that skb->len >=
> HCI_ACL_HDR_SIZE then we probably want to replace skb_pull with
> skb_pull_data.
You are right, skb->len is too small.
But, skb_pull is ok, maybe just need to add a check.

#syz test

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6976db02c06..cfb828452a13 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3769,7 +3769,11 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_ACL_HDR_SIZE);
+	if (!skb_pull(skb, HCI_ACL_HDR_SIZE)) {
+		BT_ERR("ACL data packet %d, smaller than ACL HEADER Size %d\n",
+			skb->len, HCI_ACL_HDR_SIZE);
+		goto out;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
@@ -3795,6 +3799,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle);
 	}
 
+out:
 	kfree_skb(skb);
 }
 


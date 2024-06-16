Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897004431;
	Sun, 16 Jun 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718545142; cv=none; b=RsfjgLcCgW35hDcPYZQOgWAFSKp7jo2lNVVwCSChjsBQeIOaYEqrVahTI5+wkkVukO+jcPe7HuE/heCEItrv97za5zWNfL+BaXfP9XUwO36D9kAofzTAGVmECVdpaW1904UHtJzQpfITG1fawB/5l1XkqatQpZXzHNPID38OlGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718545142; c=relaxed/simple;
	bh=3DVpCOO3sUTvTy/SKfszK1530ggxWSe9b8tGGARb2eE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rhtdE2LLli9HwDBOlzcHbfF/9JN6j48UBQ4NpO82xkE3Jpl/LjnqMlImeKe/NU+Tf6aYtHryxie6Y8tiWHIbwIcChF0NFFtI+PFT/qIepR7fDHPw4ua8YCKeIZOISE7dwzGKl9tKrcrNM02Lhk36CaDE8BBiGNTQztBJflPtXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FL4ZobYk; arc=none smtp.client-ip=203.205.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FL4ZobYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718545138; bh=QnGIQhnllw4Z9tBRtiByPGpIGjr4/z5r1mOluJiNIKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FL4ZobYkRn3IDg5qCVYaazkTtnxn2ikAxqfSxFBlRxz8gRDtriypVUV+BdOa0eJuh
	 f7+7UY73w/FxIz9sVoSza12qFld/TJoeTTPUKypuxRWSSV029sNnaewKaEg4ROwZm3
	 eRNp1Y5H6P9ElamPT8PldrVafR1Y64IIW9/HP1U4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 5568C83C; Sun, 16 Jun 2024 21:21:22 +0800
X-QQ-mid: xmsmtpt1718544082t6wi7qken
Message-ID: <tencent_410DFAA59E0DBA9213DDE8DD9399584FDB07@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQAFbobgONXpWjsNwRu9fF9gsTCahQjkKvAw5vuvYvtAbDdCpc1n
	 752KL98Ykt31N2oK+bYgiHsSO9pdGU6RYuzku6z9bKr0HfaGheffSyElOeErDMrX6qxdboOgAke5
	 hZBcwFg414xkgBSmup5gPne2s7YqpBzC2+N21G+9hIw+3MaVYbzSST6g0EfPCAsyEZARAGavKWqy
	 Wqf22pUVhzVusWxc0iJmwbudAnL4SpyJ7EmOM7qqH2ldPxcEssfVtnEPPNndWbIvHUtsFD0TeMKe
	 aw67mxS+hxdRUp/v5BYRxTW9TuGAdrCEKmoz+gfW5Amv9WS9tMjrOSnCuXS/V+K0b4SDsxpjLMoS
	 o0nRgUxPglKMQNrlLlfkSn+1Zs8KNLQzZR5hFriZTWB1sY85VdbkSaDAWo0QFY9NP1ewRxOaQDRU
	 M0HWRCUnLVTk48tU9h9nVbL/g09VLgm3sgTGeZtYqmUak2lysfYDe3yZ10g9+v45igdau5KCmFb1
	 ovs32GFQ6rf/Aie5xj1GB6eW9VkxNjUycCmYMRnKvfb/32easmNDlH6j9JqQVI74JFCSB4PNR57u
	 BwGQ/Pnz7CcFevfw5e1JjdyqkY0dynLAeVX28Q1ZCW+DDoiHxlsX/f4g1V5P4qYPPW3NP1Oc00yN
	 oakO3HWD7M8zBn8r3OEY7wDuS1UNZ1SHbmhpiv6bWfWjF9QL1fgcXIC+up2AHteQJdoCsYnEmdwN
	 rJyHzOSbAZS1fhAvIeYRCmnAffORv9qnF5Vdt6Vk3D/v52Rz3sFehGTJMhvHhkjN5jnV/pz+aQfv
	 UM4BHKnSJK9Z1JVhISrIOcbCrZboZShf2A9bbFZEOB4SoHbsU7qjZPa8zdGYnt1D8lCoMzNQbust
	 XjwyvVVxXW+VXPPCd8jdO1nKzfyWuvHLxQtJSik6u3oua0fdzF9oIqRNmwIytJ9hh10eUNMJVh
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: bluez.test.bot@gmail.com
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
Subject: [PATCH] Bluetooth: handle value is too large should not be used in BIG
Date: Sun, 16 Jun 2024 21:21:23 +0800
X-OQ-MSGID: <20240616132122.584063-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <666ec579.050a0220.39ff8.d4a2@mx.google.com>
References: <666ec579.050a0220.39ff8.d4a2@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_big_sync_established_evt is necessary to filter out cases where the
handle value is belone to ida id range, otherwise ida will be erroneously
released in hci_conn_cleanup.

Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a487f9df8145..eb1d5a2c48ee 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6893,6 +6893,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 		bis = hci_conn_hash_lookup_handle(hdev, handle);
 		if (!bis) {
+			if (handle > HCI_CONN_HANDLE_MAX)
+				continue;
+
 			bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
 					   HCI_ROLE_SLAVE, handle);
 			if (IS_ERR(bis))
-- 
2.43.0


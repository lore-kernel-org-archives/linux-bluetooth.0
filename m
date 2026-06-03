Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215C39A4DF
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499350; cv=none; b=XCZeHAb59mW4CAV394cZItkazKRTs7lqWhTOO4QSX36952m84cne2wOr4IlJFgBVOByIm5krt8lY0aAGeG0HQC3pyeVVH/rOXK5SOdX4mO3X248mB3DF0vRJzXysNg8uRUOxVLdCxpv80hR0m8zUUf3u4dENM+a4WbnXcRghJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499350; c=relaxed/simple;
	bh=IONiSyegGLaAoUAXmboVeD3IENdbPVC3d2A+/S15Ffc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2wzFL8Kgv5cC8QOVmfuYYvnkfIJxC18wWZ58CEyOPvjh58gWtP7cZIP8NpZZPNmxudwmlhuntT49wmGWJ+h2glo0vYcwaHdxq94z87eyVQIvRssIOMt5Lx0A6UbyJjNzE68uBiINTFqsTZN0jxD4ndPS+aGV40X289KqW3asp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=YBpq+O4H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYyT4Gcn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="YBpq+O4H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYyT4Gcn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 131DF7A0122;
	Wed,  3 Jun 2026 11:09:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 11:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1780499347; x=1780585747; bh=24AATU2km6TqyPYA3sFQ1
	UfLa0JrBIsdmuDHgT0ezP8=; b=YBpq+O4HgRpTJ/Kku0RJYGkAYUC8wyvgnC+hY
	OScROH+BB0vCzY8BmVSlStrDdebgEMVIHBMQ9JjtzXu4lXY9wjF59e0XUlAHg0eg
	orOzEA09okpG4SUbYvYjXvodmY475sjIc2nc0YuzEj5wrpczzk5uVBnMRbAM89x4
	rAR6cKVGXD2/gmfsgOP/rrhUiUFWxKL44WZatHGvjWq7tojIg24qLTw8ueEX+IOG
	bsUH0LNygWGIvNbI5SLnUnGx2lkrYjYSjuPIm2WxI/+SVmRcf1RAwbK2bUgCPYoh
	hvL6PoAopzLg0P2yXOOik9CKHKbWQEY4YA8Ne7eKjuM7LYC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780499347; x=1780585747; bh=24AATU2km6TqyPYA3sFQ1UfLa0JrBIsdmuD
	HgT0ezP8=; b=WYyT4GcnuM8yMMlXcGhxLUrDttfDM6GzpwY6gFIvR0PMITS3yo/
	9FrOuX/Li9hvL2rwWv+YspOj3jWxkmw7H7jvUmY4WZ2SMitzPrkio+QnawlYUsIW
	i+Tldk4OsKz6Dw1WGIQ0apfuH9aT/7+zEW20VFjzf461LiclUTJTyTK6M5jpqTe+
	RAr32cNi9dwkDZ3ID7aO85JfrhB5pzmQFzWQ6cHK9oZYH+UGXdUnMqd0vdmBwORn
	M2IvcFRr56VBzh/78U3r6YuZtTPSmlAhLF63wuL3yGEYu70J4vo7K1ld5nJq9Nvh
	z+5/mc8WqYAl7ktVmczJ+pH63LswXi+5W0w==
X-ME-Sender: <xms:k0MgauHS9KG6tHyT6QO1QtWRtrWPzfR_Ha8kUxi293zjPgOJR6LjsQ>
    <xme:k0MgamWwTtM8_VdW82MHoq6P44Rb4Lfzk4AD5HqLo8Yu1Gx3mlHdQNniaH5mDyuO_
    6woNJVhMFRit3IWwM6ok0qeQJ9MuGyJE4HJas4w9QWnYGbPbF_yZnI>
X-ME-Received: <xmr:k0MgatLmAUxwA-CZRh_vYstZGmlMsgmWP0QltKNLYvB6dMJyzwRHXspsOBNFUYRw98xjb9M>
X-ME-Proxy-Cause: dmFkZTEgISV+qlNOz37VyU89r4WCRQx40RKKu1HUUPIOZs5kJ4fECKSxGjSkSl0fGij9Zk
    bn1wpT+EtIhL4M673UUVFYgLWjhZQZf1FEo9yqEVEHH8fVRPGv87uM/AOgAfMZpZBPovF+
    KNYEZHT/qgkPWYxlx1nW+drUsZ2nZV+BGx/cSC4qwkCmhaPoKzW07s8JyPIledIHc52CjV
    Vdp1mW5+pyrjUF8ukzpid3GSg5h7IQKKzHXRsKLxM/uEH/Ol13+85vMk2pZ+GP9LSSMhzl
    ze5RIUpKsNbxhhQSsId0MtvF/Zs/qEPTO+pqzHwjjPY8hl2Z34dZMo4ypBLR6/rGOveZPo
    qvt3yew+5lGnjwC/8fegYDdzWGC/FL58YNFnmVjkSFFysdIgqIgUpYjmba5zrceKKyZDHO
    IyQ4mcSpBffz5zye5BEPYjNoIN26s5x6HZZLBh/mlEnZP6XF69pP8TRqaV28nzN5pFZfIl
    fdz1hyA8SXRkTkrql1AFeYBeuMsgQ3FMEcoMsULAn8Yg9aXjn8QdxvabwAf4AN2vnL18vS
    0Qy6AaxMYMt4Tjv366LYS4WtmOXggMaXGsh/m5bc9Fl9ckz20zlYY2Y47HdCw9Lv4QgmLE
    hugknhQimezUOcO7ZFEnG4tZ9b/rENSvWSH4g4P9lhpFRlheW9RwVV7bQ9nA
X-ME-Proxy: <xmx:k0Mgam8B6NATUdSbZKt1rsitbqSbBvUz2h7YQP98BIwc1uSlPoS9dA>
    <xmx:k0MgagKMp6WMSz4RB37OTlk5TJgb8JyIXO65-tW7VQVzSAc1Fh_XmA>
    <xmx:k0Mgarm2jiyW02XYjBuXXhVQ_IS_qvBkjSufbzRYh-oHo3kHil5-Dg>
    <xmx:k0MgakMWZZlYA-2KGy6Jm2li1rU3OvkXq17d0zFwiL9E1dfgz1F5Yw>
    <xmx:k0Mgav7GC2akiSx2BlhDkN6w4_oaHqwLt-u5DntYJ34zwhPEOj_wXdem>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 11:09:07 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v9 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Wed,  3 Jun 2026 11:06:27 -0400
Message-ID: <20260603150835.3539963-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to v2, addresses comments on https://sashiko.dev/#/patchset/20260415204842.2363950-1-oss%40fourdim.xyz .

Compared to v3, rebase against bluetooth-next.

Compared to v4, allocate the channel outside the function and pass it in as an argument to avoid the use-after-free.

Compared to v5, extract the channel init to a separate function.

Compared to v6, balance puts and holds on chans.

Compared to v7, rebase against bluetooth-next and refactor the chan refcounting.

Compared to v8, adopt the philosophy of one assignment one reference. Make refcounting easier to follow.

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 include/net/bluetooth/l2cap.h | 10 +++--
 net/bluetooth/6lowpan.c       | 31 +++++++------
 net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
 net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++--------------
 net/bluetooth/smp.c           | 17 ++++---
 5 files changed, 113 insertions(+), 69 deletions(-)

-- 
2.54.0


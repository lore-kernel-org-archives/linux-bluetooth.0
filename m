Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8C3E3143
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351965; cv=none; b=dGvlEGDtxyF6WRJKc9PRKTrsWOpR9sbpRgpcXCuiIwxyo9zlYdSFUtozhOFQc7gQ0S7P3ZtWy+FWm+A/rv0hUJ9febblPFrIMPD9CX3Zjvf60cbn2azjb0ljUoU5ogDKBGyP31yZP89m/5EWEoAcI+Hdyis/Cuc0Q0AnlaYub2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351965; c=relaxed/simple;
	bh=Al1F9LxdwQPYH1d+6OVlctXzpz8oQZ3GDQFoDUgKM5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2TAQjhjOSehlzBF+njxOxAYGMk60NkFaMWMplkY5aMRskhm+jmfKkRwisL0YiVBLMxUJVhPiCwd1x8yvISA1tK3Ls6R6ufU/upBta+7o9b8J37qQ2Zacig3C3TETuSoetpDgGFyAm5MKBJVojmksqI6AWXP4WB0dXvhIgVZpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20251104.gappssmtp.com header.i=@u-northwestern-edu.20251104.gappssmtp.com header.b=Qijt9nub; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20251104.gappssmtp.com header.i=@u-northwestern-edu.20251104.gappssmtp.com header.b="Qijt9nub"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50b3488fb31so9245971cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20251104.gappssmtp.com; s=20251104; t=1776351963; x=1776956763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+r7pKm0Oa2J37AR0FDSLuD1gUcrwE8bT/2He5bq2wC4=;
        b=Qijt9nubWsMQ3ACDh6KarbEc7Sx4XQ5AbOu2TroLG5TY0pUlZHIkQ28lJOuiXbYjCz
         5AObOlKcyTbgudKOiYyUfPjfirvejJl49GXUCrjblmpIkroC0/pxvEmkuyb5LNmdiQPI
         HZOqhvxuiu/R25Q1lMywWLbPpw1lLQ4PTpSnLFGzVmJe/m6JJja7ilo1xhwpHgfw33Zf
         E0X9Yq8nWj4cx736TczXc+VmrZf+bTc2wgptDMyqHZ6vRhj+FK6lKz/dzLErD992NiqH
         4933YI7QvGJtlcVvIGOzVrtzyn3DQVC9QSN8k57i5xGnkiVsS9dApVLdiTLJ+ppjDhmD
         d7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776351963; x=1776956763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r7pKm0Oa2J37AR0FDSLuD1gUcrwE8bT/2He5bq2wC4=;
        b=R4V2BdmLkCPgbd1bHRWoZo8QgFTExG7uwn8MsbuCGwoDv1o95fCwuAygiXhLI1vsmN
         MZM/my6aY+frgYbR0Xd3om02l8W1pQwbP9HGbKyEOYtfRQ4Yy5AzZLk7QuxpfmIobyTV
         0S2p7SfT6mh7KTtjTmJnlrpc3eJNuqgeOQdG63QcgrAOT5P6qcfbHksH07rIyuUpjGU9
         yzWI1O7SACEanwM7d4RblUIs6G7dJ6cN0QFwL2KRFIguvbGcZpZDnh/o/k/GbSf4BDXx
         OKvk2WyzwZXKlkRdpe0ovN374e7sKwRZpi9NwqwPBBi1SzQ4e8bbDc3jPvDHkyhO8Y13
         srDw==
X-Forwarded-Encrypted: i=1; AFNElJ+Jz/op8bHVyDj1Ey5V3CSo7p0qATAJ5jht8Fe48kOMvlPjnqFkTH33BiH2MYuViNiL9HcFyO8cgrLG4WxXmAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3SRsE+55HYSgb3nQWSA61+vtBQNPFTrP+MG2D4d0lHRgAMKI
	Q71jcFSVohl9Ve3Fi7HoGuSSD8m09JpDQkt3ce1nM1qMiiYUSJ9wgvorgJA6ZU+g0dI=
X-Gm-Gg: AeBDieuLJ4jMQxxVDa00G7KF/EThX8P7vLQNZvhZfoCq8iknQOzQ7wGwlwwNAHuGR4f
	dqOMZ4KreGrgqeBCl8+0hBVyE0+0dLgJSs28D25QGj0CzbhCmscotQfSY8YkYWOKANhP76nQtWH
	Zws84TzfhkvLRPzExsfania9AKaBcorphJxLHLQmaeXJkggkSEPLuZuyJi543hA7s4LRi1wNmcb
	5F0ygg/NGK6iW+rsIBrEBeFuHQNXeHTkRT/1Do3NQnFHnbLfDyVt72oZJgCj5/hL7Vo/zQRPKK7
	eB/jy5oeUyz7QaUCG0aPEelsuiGTxv/9K8yMxjXANM8qmhyT8G7NWqGLVUzxmsZVtMvxbYc3OOv
	fBj5BWoVpgYadh3bSj6W3wULDuQVJHVg+4MTyICQCxLt9K2QDC/wlOoirmOiI/cLC6+URqTKPi8
	YFWKwW8lZ1NxhulGtAMnz/RXivt6/tLrUZP4iHM8mxaBEJE8fg23QHDUIM01csPF1Kf0KPYyKwp
	3vJPygv+mZ5YNkIdbw7C18=
X-Received: by 2002:ac8:5ac5:0:b0:50e:32cd:52fa with SMTP id d75a77b69052e-50e32cd53c0mr2194101cf.3.1776351962785;
        Thu, 16 Apr 2026 08:06:02 -0700 (PDT)
Received: from conor-Inspiron-3020-S.mynetworksettings.com ([2600:4040:44b8:3600:d171:db71:e260:ff8d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afc1629sm51124321cf.23.2026.04.16.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 08:06:02 -0700 (PDT)
From: Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu>,
	syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com,
	syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com
Subject: [PATCH] sysfs: return -ENOENT from move/rename when kobj->sd is NULL
Date: Thu, 16 Apr 2026 11:06:00 -0400
Message-ID: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_move_dir_ns() and sysfs_rename_dir_ns() pass kobj->sd to
kernfs_rename_ns() unconditionally. If sysfs_remove_dir() has already
cleared kobj->sd, the NULL flows through and kernfs_rename_ns()
dereferences it via rcu_access_pointer(kn->__parent), which KASAN
surfaces as a stack-segment fault on the shadow lookup:

  Oops: stack segment: 0000 [#1] SMP KASAN PTI
  RIP: 0010:kernfs_rename_ns+0x3a/0x7a0 fs/kernfs/dir.c:1752
  Call Trace:
   kobject_move+0x525/0x6e0 lib/kobject.c:569
   device_move+0xe0/0x730 drivers/base/core.c:4606
   hci_conn_del_sysfs+0xb8/0x1a0 net/bluetooth/hci_sysfs.c:75
   hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
   hci_conn_del+0xc36/0x1240 net/bluetooth/hci_conn.c:1234
   hci_conn_hash_flush+0x191/0x260 net/bluetooth/hci_conn.c:2638
   hci_dev_close_sync+0x821/0x1100 net/bluetooth/hci_sync.c:5327
   hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
   hci_unregister_dev+0x21a/0x5b0 net/bluetooth/hci_core.c:2715

syzbot has reported 35 hits with this signature across net, net-next
and linux-next between July 2025 and January 2026, via both vhci
release and HCIDEVRESET ioctl.

Return -ENOENT in that case, consistent with sysfs_create_dir_ns().
The underlying ordering problem in bluetooth -- device_move() called
after the target's sysfs has been torn down -- is a separate issue.

Reported-by: syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/687c6966.a70a0220.693ce.00a5.GAE@google.com/
Reported-by: syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com

Signed-off-by: Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu>
---
 fs/sysfs/dir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index ffdcd4153c58..6664fae288c9 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -108,6 +108,9 @@ int sysfs_rename_dir_ns(struct kobject *kobj, const char *new_name,
 	struct kernfs_node *parent;
 	int ret;
 
+	if (!kobj->sd)
+		return -ENOENT;
+
 	parent = kernfs_get_parent(kobj->sd);
 	ret = kernfs_rename_ns(kobj->sd, parent, new_name, new_ns);
 	kernfs_put(parent);
@@ -120,6 +123,9 @@ int sysfs_move_dir_ns(struct kobject *kobj, struct kobject *new_parent_kobj,
 	struct kernfs_node *kn = kobj->sd;
 	struct kernfs_node *new_parent;
 
+	if (!kn)
+		return -ENOENT;
+
 	new_parent = new_parent_kobj && new_parent_kobj->sd ?
 		new_parent_kobj->sd : sysfs_root_kn;
 
-- 
2.53.0


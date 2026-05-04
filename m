Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293421257E
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 05:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871276; cv=none; b=j+YruGqIJpHDvuHVKSDFMlodvXKApRWq7UZMiH7DodurS2hZ0UKDPa5vAPOBieWTVekpTkXJ2lSB80bEbafG9Ofh2miuPF4lpi9Q0//OBeyya/R5l6bmlcQTwAmuMca3ap5YR7L2g5z5Gf6H0buCEIH702/vazPHFfHXUNQLoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871276; c=relaxed/simple;
	bh=E32bK2qLJyOT8y0iWLUoQdzRqE32ppr0Bx3idjtawYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tn+Ar1A5ZWmaUdKa63HPkWhGomblMjw/qHNyBaAgvy8cw2n75l3k7ubYi7oL5RYsXRX4mcgR5sI5sizDKcOP84LS/zqREJtd0TgV8uW3STzGms8yk6iz0SBc2ltclgxdLHcqcwIA/G9kDw4OoBaxBy4EFz860BNi2Mf1RSlo1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20251104.gappssmtp.com header.i=@u-northwestern-edu.20251104.gappssmtp.com header.b=H/TMM8yp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20251104.gappssmtp.com header.i=@u-northwestern-edu.20251104.gappssmtp.com header.b="H/TMM8yp"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d880e6fbbso43758151cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 May 2026 22:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20251104.gappssmtp.com; s=20251104; t=1777871273; x=1778476073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTroaTH8vyZ3o3Up6auB4LFBfOAeXvYkb5rPynl4ydw=;
        b=H/TMM8ypS4l7Za6/drzkcSJenjsWoHbgq/oxFfowhX63JUPrC08V0D8IgffOq83QT2
         Fyp7XY34evwbz9uzpzV92oya+ympTrA4qGBOBN/4gpGc4E/B0c0iig8diIvoMCBKHY+v
         k8GDsp4Oe4Ct707lAt++ysqOmmcJ1q4Ll/Ukw9+4oJYsiK8YeBoPfrqN/YZWt2Phaooq
         KdRLz7SHAtF4qHmBhCQl6UItJD4FLnrk/0lAavrYmsGmV8bo37hDccpcvcTcNXNjNVls
         chAXn/VmpguNFYZbdie/MCoC8EcnuQlHG1wqRK4jdBQzPUVJ+XBPyG/ADIHQZuETYoYm
         aiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777871273; x=1778476073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTroaTH8vyZ3o3Up6auB4LFBfOAeXvYkb5rPynl4ydw=;
        b=J0744bcqrp1FEtVki91m8qWPCA2o8gyb7X4OTmQyY5zzeXK/UO+nGhw1FodytTbwfE
         Iq9EmS7UYKaGdsZNywOzYWKk4+LESIC9tShatZ/YIVPfbAp/g3d9Xkwqr39zraHivagF
         GUeiR4L2/ziU0ePFZMDAK4c70DOzC4G52ooCVxR7T/YV8q0iQUM9sGdUKFSgQzjTwq3X
         4wNOQHpuSNAHM30pXKut2igs7dsxq84YEkpgemLEETbvPKhn6KkOOHvx640uswT1ojWp
         nKcfBRjTtozzgFGtMw1TyNCGAYSjxKfPp5ZK5R/A4NtH2JdHs3r4eV69NCbWfWOkCQCb
         491A==
X-Forwarded-Encrypted: i=1; AFNElJ+jMhEcINYVomtVSSu4GGAEuv181+D3noXjAPF4n53zycWQ/huR5HOtYhP1XTnYCuPs7zYWlJilrzNF1GmoW48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69QDpuL0FWFjciHncnm2+sv15cZBrBhyD7x6Ci+ifAYX/gnG0
	uMYYpu2Ooz+2FV+0ez2WQZk9dNf8Cc2EgPCvlRI50Z7/AQ3RP/g9FDClXq+xKAjcGOw=
X-Gm-Gg: AeBDieu1uIcgG4Lep+DUhqxRo0159wHbW0fmIyY/STHQGMDlLXKvYUDnmhbX+0XEyJm
	qtmo5sKq9Ndz7Ox7J787Y2KSkyRGIWZ7PE33IaN/f1Fb2Vmzvdys9b36i2WZ4pJZ1GARZSywh1e
	aACoj84FXaBYOWnbHig/5CiSPRRbclbBjH0tE1EefriymWwOD8YUYh2krd/Yw419psux6o4bXvW
	Mm2vLHhUIxfjbYpJrtv08rmZETLExbzTmoyLBKxSRe9k8pl5/LA4t6RDigczWSTIEJH9mTtjvbK
	Yi/i9Vz0PPqe7tYTx17lHPCTfKKfrxwQimovj2ujEmRKvQs6WeF2UiHUDJKW2Kpj1EaLdVTrY5k
	HzP7v6zew8n86AWPRvzYrsScYwCvw5RDXaf7T66qkLWwD5Ohe5KAHGxhk6qc8a907KIIrVn/AyT
	Zebk7iRugOSPTpzZYJkjujC/5HApHNUHxtgNRpvSRi0KrkQwOsQk7Usb7DOpklNLSbe29/xs7Tu
	nE3rrXiWxGt6KKcr2VzraUr8NnTe935TBxPznlDmN058Ggeno6xKcW21txJHgFTjvqHot0=
X-Received: by 2002:a05:622a:550c:b0:50b:2542:e16f with SMTP id d75a77b69052e-5104b5275a2mr113445211cf.15.1777871273379;
        Sun, 03 May 2026 22:07:53 -0700 (PDT)
Received: from 10-19-124-38.dynapool.wireless.nyu.edu (216-165-95-157.natpool.nyu.edu. [216.165.95.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b35527sm84983031cf.17.2026.05.03.22.07.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 03 May 2026 22:07:52 -0700 (PDT)
From: Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com,
	syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com,
	Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu>
Subject: [PATCH v2] sysfs: return -ENOENT from move/rename when kobj->sd is NULL
Date: Mon,  4 May 2026 01:07:36 -0400
Message-ID: <20260504050736.17672-1-conorkotwasinski2024@u.northwestern.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu>
References: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu>
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
Closes: https://syzkaller.appspot.com/bug?extid=faeac5b54ba997a96278
Fixes: 324a56e16e44 ("kernfs: s/sysfs_dirent/kernfs_node/ and rename its friends accordingly")
Cc: stable@vger.kernel.org
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
 

base-commit: 36f35b8df6972167102a1c3d4361e0afb6a84534
-- 
2.50.1 (Apple Git-155)


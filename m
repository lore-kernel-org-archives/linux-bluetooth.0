Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95303B7A8;
	Thu,  6 Aug 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021215; cv=none; b=lV9evcKzVQhBY/Ghgtl2jT8rjnIlhnbJPHOGFsYsF4nMNVZmYbK0R+x5HMhbVnaVdksplJfRloI+mDt5aFeIeLLAlidKTK0yU48fFwVw+t8Quc1FilBvMUzS7PBkpb1WboEca2EtMxddM/SFuCLyfBBLvccb7m42N2il7S1eIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021215; c=relaxed/simple;
	bh=Jv3cvOdAvFGZeCaI0CYku+2FEk6NsrV6coaGdEuDgGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mh+tsoz1mBb+wCEubfZ50jD/VfjnY44Uc1emImY2yXo1QtRFHOjCLa78znt/VavEJ6E8bPE7Pt7mZ69uTjMbtwYip3frWIjkHerNQ1gTfbzZRrY0Xz9Hn68XShOLpe3SYfcXanB4sqgkwg2LIEZBEZnVzKI6HfwPemubEE07uOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bd9d5f20919611f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d9e09ae4-9259-4264-82e7-828df67b17c7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c5a2ad345f476c7523592138ed4fb39e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bd9d5f20919611f1aa26b74ffac11d73-20260806
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 952638268; Thu, 06 Aug 2026 21:00:03 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH bluetooth 0/4] Bluetooth: fix cmd_sync payload lifetimes on the cancel path
Date: Thu,  6 Aug 2026 20:59:53 +0800
Message-Id: <20260806125957.698760-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cmd_sync worker calls entry->destroy() after running a command, and
_hci_cmd_sync_cancel_entry() does the same when an entry is cancelled --
but only if a destroy callback was supplied. Without one it frees the
work entry and leaves entry->data unreleased.

These four call sites pass a heap payload with a NULL destroy callback
and free it inside the sync function instead, so each of them leaks when
the entry is cancelled rather than run. hci_cmd_sync_clear() cancels
every pending entry when the controller is unregistered.

Patch 1 additionally holds the connection, as the payload stores a bare
hci_conn pointer. Patch 2 additionally frees the payload when queueing
fails, which it currently does not check for. Patches 3 and 4 also leak
the socket reference taken by mgmt_pending_new().

Each patch moves the release into a destroy callback; apart from holding
the connection in patch 1, no behaviour changes.

Found by inspection while reading the recent cmd_sync lifetime fixes.
Not tested on hardware: these paths need an adapter removal racing a
queued command, or allocation failure, to reach.

Linmao Li (4):
  Bluetooth: hci_conn: fix the SCO setup context lifetime
  Bluetooth: hci_sync: free the advertising instance on the failure and
    cancel paths
  Bluetooth: MGMT: free the mesh send cancel command when it is
    cancelled
  Bluetooth: MGMT: free the HCI command when it is cancelled

 net/bluetooth/hci_conn.c | 20 +++++++++++++++-----
 net/bluetooth/hci_sync.c | 12 +++++++++---
 net/bluetooth/mgmt.c     | 22 +++++++++++++++-------
 3 files changed, 39 insertions(+), 15 deletions(-)


base-commit: abd93c85c8667add738ee82aeab95dd9fc8265a2
-- 
2.25.1


Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66279471425
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097739; cv=none; b=PT5EsVR15rkXzOwCssoOgBrBYNmroZMrtblerEzgJLrM98Xx7+KN8w2tEm8CRtZrNPzRMVB6Hnnn9XIRqwU9g2JEI0HH7Uhypav3K1cOGUwpBzZgwUxxLOqiJDv12cEowobPAZREhRZCBGW1/OnknKoOkhF9IZJgwu1zxM5Qvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097739; c=relaxed/simple;
	bh=XU7SBVwoZ2gmzDIRGG1/wevQLi+4spBoLxZ+LV157CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQK3nDe8aWcHwRnLuGPXlzWu10g3caMfVNpQz4SfklDgV95htnk4RWXOUbIEtyrlU33cdiBWAk/JIwyMb5PEWdys5jZfjLIV5V8zYhPTeAHj0qQcJTFDQExapzgY+nPH+P+JMGSwYcbP7j1HD0N1139sORD3anTtLhzvH8Wm+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=AKLIrrns; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="AKLIrrns"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39266382df6so307608a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786097736; x=1786702536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dU0nW0nnnYVIBF5ljLRaJDGaH50na6JSFZ8vlLoM0Gw=;
        b=AKLIrrnsgqvF8+GR/aupTJptHWVR81SJpeyoMs+2CPYyqi5WcdI7sOjJsUC/kV39A5
         RL6oUISVXqfxsErlwfE+EQdAhgFAPq9YhhI7n0SIJitKgnffrMZ3/Jj4l2i6RmJqFqSU
         jgV0dhKNcpe0ZHkAVrAWantrKDhW2p32KRKs4UwXIh0Jc+JaJBBE/bSTRKPqQGS8+2q7
         azGkkCz9LPUDfvNSzdocUh4sS/wunQEMvYxJja+/BO4nSKS1aWC0RGYrTSt5wsasV9bc
         2YKpBzANESy2nuPYcizY6uWGUg8QSm60jBoqQFVgqn040/2+W5KAdEvTpAZQq/Xw5Uf1
         yRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097736; x=1786702536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dU0nW0nnnYVIBF5ljLRaJDGaH50na6JSFZ8vlLoM0Gw=;
        b=ZCA82w6Wld8zEPu7xEE2yOSyUzFhEecaNvGtBpX+XNUyQDKp3Igv2dAPwsGuJAlEGa
         DzZpPaPD0CMOEiTUNmosHTyajUxXRdP6h7h36eMU1h+UlvpMG9L6nioliQMPbVdOg/Xw
         bcHkddNNW+JNhV476vyzqSmIFhVi+b7xAmkvCo80TqnSEuY49UWyczJW9OmTPt+onR6U
         BxeDQHWoN1Vge5pO84qgUD/zFUhU0SU56cWLr/C0ho08Q8RBGUt3JWtDzY8oJknh3TEP
         Fcr0JRqw75bPh1srtNjXbCcZOCeigRv21WedVMAnH7WjWEGCp+pJB/ZygDmc6he+HkCB
         icVw==
X-Forwarded-Encrypted: i=1; AHgh+Rpga9MCLPkCECzBIr7xwUGJB/0YeWmrffDHj4wycMsTQnXCNYZMIw/7n3hkN7VLyO6md0Cd49H4dUTOmdKDpdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoIxV2WScKY3Bu4l+LM4KYCAEsNKp86/dbMcfNNLza8dh9g4J/
	AKrax12mNhBVRHLDQJfUP7fZ9wHgBeD+xokQa9ULd0dZ2AqAoNIBvKJaEL6ArE5Au0M=
X-Gm-Gg: AR+sD12zaR7IoRErCPJ0Opu41o+J7s8Bs1bLNpL4J19NPt8n498ySDdzrUqLwFTx89P
	TY/GhIDA+V3psJZiW08tWxBhegvG9E7tv6d1osGAoFPEC7ejmlGtw9igGK5vpRvUyPZDUUvFrLR
	fBtwdKfFAiSt/FuwhPphN3C9SfnOcXwJAE1unjWR80NgHDQ3uAVv8A1B4ULWIMl7aUjm93QnW3X
	98lJY1AycNs2CzTyeBCCtcxKavzgmvlUA0Ee0WV+RCjsV6b7kdBKPU7tg+0Wi3xcjyBkVPo+74h
	Y1PBEDm1nCI/ZPEeKm/1DAOYrZ205QWr8AYTIb48DaUOiMhC1f5rmL1alnWOad7NANytxixxs/9
	mSgdIAoyTW0/rNEKV6kLUTJCAmNClf9GcGOn8txjWWIJlTz7O0bncK2TNWj5ykLQC2jqX5GXeSN
	2i52o+zL2ppc8FBKVhJaAbAZlu2sRRGAABINXimj5y93Z6OQMdMM4VYHxUQohUqzgImp08/sHYU
	fnHY4IaB63+cJdvN7cdse9vhnG515q4uhBySPQs3ufmQeESudo/AiE=
X-Received: by 2002:a17:90b:264c:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3903c59936cmr23131603a91.8.1786097736542;
        Fri, 07 Aug 2026 03:15:36 -0700 (PDT)
Received: from localhost.localdomain ([1.220.41.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dea04bsm4399162a91.8.2026.08.07.03.15.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:15:36 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Brian Gix <brian.gix@intel.com>
Cc: Baul Lee <baul.lee@xbow.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: [PATCH v2 0/3] Bluetooth: MGMT: fix use-after-free of struct mgmt_mesh_tx
Date: Fri,  7 Aug 2026 19:15:26 +0900
Message-ID: <20260807101529.17348-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hdev->mesh_pending is extended and walked from syscall context under
hdev->lock, and unlinked and freed from the hci_cmd_sync worker under
hci_req_sync_lock, so the list has no protection; the objects on it are
also handed to hci_cmd_sync_queue() as raw pointers, and those work
entries outlive the list.  Three use-after-frees follow, all reproduced
under KASAN.

Patch 1 removes mgmt_cleanup(), the one walker of the list that cannot
take hdev->lock.  Patch 2 puts the list under hdev->lock on the worker
side and asserts it in the helpers.  Patch 3 gives the object a
reference count for the work entry.  The order matters: the assertions
in patch 2 have no violating caller left once patch 1 is in, and the
reference in patch 3 is only well defined once every unlink happens
under one lock.

Reaching any of this needs CAP_NET_ADMIN in the init user namespace.
hci_sock.c sets HCI_SOCK_TRUSTED at bind under capable() rather than
ns_capable() and gates every later mgmt command on it, and the mesh
commands additionally need HCI_MESH_EXPERIMENTAL.  Nothing in
hci_event.c touches hdev->mesh_pending.

Each reproducer was run at identical parameters on the unpatched and the
patched kernel, built with KASAN, PROVE_LOCKING, DEBUG_LIST and
DEBUG_ATOMIC_SLEEP: every splat the unpatched kernel produces is gone.

v2: rebased onto bluetooth-next, where send_cancel() no longer ends in
    mgmt_pending_free(), so v1 did not apply for the CI.  Context only,
    no other change; v1 applies as posted to the bluetooth tree, which
    still has that line.

Baul Lee (3):
  Bluetooth: MGMT: remove the mesh walk from the socket destructor
  Bluetooth: MGMT: protect hdev->mesh_pending with hdev->lock
  Bluetooth: MGMT: reference-count struct mgmt_mesh_tx

 include/net/bluetooth/bluetooth.h |  1 -
 net/bluetooth/hci_sock.c          |  1 -
 net/bluetooth/mgmt.c              | 72 ++++++++++++++++++++++++---------------
 net/bluetooth/mgmt_util.c         | 31 +++++++++++++++--
 net/bluetooth/mgmt_util.h         |  3 ++
 5 files changed, 76 insertions(+), 32 deletions(-)

-- 
2.50.1 (Apple Git-155)

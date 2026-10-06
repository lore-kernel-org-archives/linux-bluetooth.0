Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089A3B2D14
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791271479; cv=none; b=QYC6e3CFRSP59tttihp3YjDfu0xOQRgCEEMUm12nUuPGnIOudNAEuokOoEz47wfiAE+ETHfikDDfne0hsHkTYGdUK8xa+/80Le/R/3DnYcxJHBPxtR0YAMt4rrLqQP6aqAlQdsXLN5iI+RfxEhAhvIWrXRXKSaKNGIMdFASkeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791271479; c=relaxed/simple;
	bh=/Y86KKoGqNSJegfp0FJGbm7eqG7+Ktab/4HBqeYdkfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cYBW10E/it1szGvF2o7kYt7j3dFshQwi9J2pj2yG/MPmw/rP2/pi3mzu5FM1bdcg2loMPUJPkNT1/GSJT7FIjiG/nIW/ONIOntyS8Rs2VhMXfHeW1DgEikYSwpKPyrKWcsDAHI1CAEbQCcgjh7O94vMhXmu3bSsK1PJRjkUiuMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc022twr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc022twr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1131582a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791271477; x=1791876277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQ/gKoozURTZC5r7U8J0vCYUipMnuI1HqdA3TudRHRA=;
        b=Xc022twrnakJd6rDcuxva4Urh6p1/7ORzO2nBvk1vDHpE1UWDCHOVyEltrV9rKjsFc
         nc+f0Gt8yC0jXOzVt6GvpbEwWlWUYmxscLvhQ1T1wbn+vRgbU9tYa5GMSfa+CE+6XNGo
         PJbZmnIV9PRpJgytc0pGSEpGJcOzZ15gZe/DOgdXQQA+49c+locz8mBMrELNiXKIfKpK
         bKrOWZ1Pq7tnfbtwniUPX+LXBm5K7sGKVi7hSjCbckWS2aBe1CzVWUdvZU6KjIaqrJjx
         zCgKsX5eDL1ddLhwYtqpB3dZU5MRBg3sndMKNrz/BkULz1Z4zfHPaknL+Dxdc5aDJPdW
         wODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791271477; x=1791876277;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BQ/gKoozURTZC5r7U8J0vCYUipMnuI1HqdA3TudRHRA=;
        b=S9KhEfACz3pybcIVVoM+BsWNeUUSUwHp4pPn2/Jj1cWC5AJ7z7lmyxCrXKPJhWNZbw
         EjXVQ2SHpsyLpYdza/0iFxBz7UvRpG1jWNZY2RORD+8u0I4+cZP5j+oEZztOf9ow/Lgw
         PF7Tq9woILieyrk0M2rvyFkfddjccCycmE0602jXGtL1qw3rpiC5snmZLs63GSjj2ABQ
         tPaVsUmHDqXPSq71WfpaEA1gx+NBXOPUBi6grtfsBC2+OBDCkANcTYvct2Hv0sOkAkli
         WOAoFE0f1rrlvhGT/m0WBiZV1LJ75mE5WIi5k0k7F0Vu2pCHEVSSB4EhQ5E8nApbVPMx
         uJDg==
X-Gm-Message-State: AFq9FYJsClVnFB/9SIyuM4lhDZSX16fcHEfDNBOg0xriDG7rZ+4W7ccm
	KssLYI4QRdkmDwDKtXzsCOhn2bVAkFrnOadP4SeXH7kz4REEtrl1CzbD
X-Gm-Gg: AYBFou1aPpYh5ZoCrMT6jZDBAC05FNfejHKnfhuiXABPCQA2WSCKXjMTf2y3Q0sXnjh
	+/3GBlugXqV6umSW7WePwKNKuvwLlSzxW0xa1PEn2xNATL0vA/JeWfK5GIBrQlnvN+Tb8ecw//1
	Gb7Q8PFLKVE/AIecHoXHrJFmlpSXzQkDtI77aYo8+34Q8+bJvP76S+09RMLzaaxnBG9DMI1T2K3
	eMS7HMb/5yWAxkUYExOgq20aNP3kdC1Xla3dGQy76Wkc945ypDQhX1Ijq37utDSVFC92n3labwg
	LJpN2PwEBvhdpPY7n9X+Ek6zSDhSwRnDpwKBs8zWCtrmUSPwEK+VLUY72dGyEgZqMjd+N9FOCI0
	VZymj5XVLIluefWGPX8SurHBLrNHxdC8XLk08PwFwNTVAHkJi/XnGBs8QQ5jfZpzgd00+TI1i+l
	gMY5ip/CQyYfj4zEgXkY66Vn7mnfbG3Mh2hNAopivUR0sDdjMcQeVdEwX1qg1jlDqCNRrZjZNjN
	+fA
X-Received: by 2002:a17:90b:388b:b0:3a0:903b:f253 with SMTP id 98e67ed59e1d1-3a78717daaemr8254458a91.18.1791271477340;
        Tue, 06 Oct 2026 00:24:37 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cde769sm3401775a91.13.2026.10.06.00.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:24:36 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: MGMT: Reject quality report requests during unregister
Date: Tue,  6 Oct 2026 15:24:31 +0800
Message-Id: <pm-bluetooth-objects-candidate-0186-v1-e03b4f1d5ba49b962cec@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A quality report request must not call a driver callback after its
module text has been released. hci_mgmt_cmd() holds an hci_dev reference
through set_exp_feature(), but that reference only preserves the device
allocation. set_quality_report_func() takes req_lock and invokes
hdev->set_quality_report without checking HCI_UNREGISTER.

This is unsafe when a SET_EXP_FEATURE request for an Intel controller
would change HCI_QUALITY_REPORT and is delayed before taking req_lock
while the controller is removed. With btintel_pcie and btintel built as
modules and no other btintel dependents, the following order is
possible:

  Management request                Removal and module unload
  ------------------                -------------------------
  hci_mgmt_cmd(): retain hdev
                                    hci_unregister_dev():
                                      set HCI_UNREGISTER
                                      remove hdev from lookup
                                      close under req_lock
                                      release req_lock
                                    btintel_pcie_remove(): return
                                    unload btintel_pcie, then btintel
  set_quality_report_func():
    take req_lock
    call hdev->set_quality_report

When the request resumes after btintel unload, the indirect call targets
released module text and can cause an instruction-fetch page fault. The
close operation serializes with a running callback but does not prevent
a delayed management handler from invoking it afterwards.

Check HCI_UNREGISTER immediately after acquiring the existing req_lock
and return MGMT_STATUS_INVALID_INDEX via the common unlock path. If
unregister passed its close section first, the request now rejects the
removed controller before accessing the callback. If the request passes
the check first, hci_dev_do_close() must wait for req_lock until the
callback has returned, so unregister cannot finish before the use.

Oops report as below:

    BUG: unable to handle page fault for address: ffffffffc0408e10
    #PF: supervisor instruction fetch in kernel mode
    #PF: error_code(0x0010) - not-present page
    PGD 80a9067 P4D 80a9067 PUD 80ab067 PMD 0 
    Oops: Oops: 0010 [#1] SMP KASAN NOPTI
    CPU: 1 UID: 0 PID: 439 Comm: btmgmt Tainted: G           O        7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) 
    Tainted: [O]=OOT_MODULE
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    RIP: 0010:0xffffffffc0408e10
    Code: Unable to access opcode bytes at 0xffffffffc0408de6.
    RSP: 0018:ffff888110927838 EFLAGS: 00010293
    RAX: 0000000000000000 RBX: 1ffff11022124f0c RCX: ffffffff85b1a1b6
    RDX: ffff888117511d00 RSI: 0000000000000001 RDI: ffff888117598000
    RBP: ffff888110927950 R08: 0000000000000001 R09: 0000000000000001
    R10: ffffffff893d3057 R11: ffff888117511d00 R12: ffff888117598000
    R13: 0000000000000001 R14: ffffffffc0408e10 R15: ffff888117599970
    FS:  00007f15453f2040(0000) GS:ffff8881fd852000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffffffffc0408de6 CR3: 000000010b832005 CR4: 0000000000770ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? set_quality_report_func+0x232/0x660
     ? __pfx_set_quality_report_func+0x10/0x10
     ? pmbd_gate_maybe+0x47/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_probe_hit_cookie+0xe7/0x1c0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_probe_hit_cookie+0xee/0x1c0
     set_exp_feature+0xf7/0x260
     ? set_exp_feature+0xf7/0x260
     ? hci_sock_sendmsg+0x12b2/0x2400
     ? __pfx_hci_sock_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? selinux_socket_sendmsg+0x160/0x280
     ? sock_write_iter+0x4c0/0x550
     ? __pfx_hci_sock_sendmsg+0x10/0x10
     ? __pfx_sock_write_iter+0x10/0x10
     ? __file_has_perm+0x25e/0x420
     ? __pfx___file_has_perm+0x10/0x10
     ? do_iter_readv_writev+0x59c/0x860
     ? __pfx_do_iter_readv_writev+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? security_file_permission+0x26/0x80
     ? vfs_writev+0x30e/0xc10
     ? __pfx_vfs_writev+0x10/0x10
     ? __pfx_do_epoll_wait+0x10/0x10
     ? __pfx_do_epoll_ctl+0x10/0x10
     ? do_writev+0x241/0x2f0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_writev+0x241/0x2f0
     ? __pfx_do_writev+0x10/0x10
     ? irqentry_exit+0xbe/0x820
     ? do_syscall_64+0x115/0x6a0
     ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
     </TASK>
    Modules linked in: [last unloaded: btintel(O)]
    CR2: ffffffffc0408e10
    ---[ end trace 0000000000000000 ]---
    RIP: 0010:0xffffffffc0408e10
    Code: Unable to access opcode bytes at 0xffffffffc0408de6.
    RSP: 0018:ffff888110927838 EFLAGS: 00010293
    RAX: 0000000000000000 RBX: 1ffff11022124f0c RCX: ffffffff85b1a1b6
    RDX: ffff888117511d00 RSI: 0000000000000001 RDI: ffff888117598000
    RBP: ffff888110927950 R08: 0000000000000001 R09: 0000000000000001
    R10: ffffffff893d3057 R11: ffff888117511d00 R12: ffff888117598000
    R13: 0000000000000001 R14: ffffffffc0408e10 R15: ffff888117599970
    FS:  00007f15453f2040(0000) GS:ffff8881fd852000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffffffffc0408de6 CR3: 000000010b832005 CR4: 0000000000770ef0
    PKRU: 55555554
    Kernel panic - not syncing: Fatal exception
    Kernel Offset: disabled
    Rebooting in 1 seconds..

Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aea3482e38935282bb9f95e2f85d00f14cfcf564..b1c2eaa021c49a7b8a7a85fed2edd2ebb5e8525b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4909,6 +4909,13 @@ static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_sync_lock(hdev);
 
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_EXP_FEATURE,
+				      MGMT_STATUS_INVALID_INDEX);
+		goto unlock_quality_report;
+	}
+
 	val = !!cp->param[0];
 	changed = (val != hci_dev_test_flag(hdev, HCI_QUALITY_REPORT));
 

Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8C366573
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774213760; cv=none; b=aXGjkwtgHD41hwgMZZrULIcQVr8ITke3vR3qJe67fd9ip3U0eb7kOIMQ0RZsrA+nJOJdsr9XW3DQbGRiWXEYf6xzBh+5PTQXm4nD/XUhvSrPw3sYuCdF7SXNucWznK2rJk0spb8oLXIgHGQYlu86Rg2IF6KXuXu54H3aRBuFbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774213760; c=relaxed/simple;
	bh=K1AYDC8IU4VefpqdSf1/9FvLSZ4aap8F7Wg9vhexyF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkAadC81XgINyxAu43gkYU39192ev9ReRutKelz93qmABfB48evONm++qvEA+3QzYjjoJ4h49mZ2uWf12WqtL8211RDeeLJG9Sm2UDm5bsVFutkVmesTID6gxp179JFHve6M/s88jWjD26gpIbBvdZ6lX8rDIo7GNUjmphgYfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB05lgnR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB05lgnR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a9296b3926so26904485ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774213757; x=1774818557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ok8B17E9F5Gbs6VMeORb12tZdKJq1eiGicFxW3x7Y/I=;
        b=HB05lgnRM3olLjftsfm3yFA5U3k5KQW9o7niLJJ4h/1JWzZvoVXAoq9WBztqufm0SX
         UmX2zX6lLhjuC+9DdBa6IA2ch61XQHf0qxjQTFwyFiL5gtRc5TUW5Tdu6WRzELKZRAip
         Up58fVC7Y0fBwZGHY1hwmtmHNrr6B4OW/0OXbNg/Ceplx6Xwoiz+QFRLmUncTI4/QOka
         lKMzZ9QqZDB3mmHp0AJ1O2R/Zmyytx5scdONK2xyHchcnpJacmUYpqiFtdcHhNu3wwOY
         LdAieSPc7SRsnIQJ4RkfYBoVWBjGHN32F1YrpPUF51yJVLWTg5dDROEiV1od9yrJ1Go9
         EPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774213757; x=1774818557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok8B17E9F5Gbs6VMeORb12tZdKJq1eiGicFxW3x7Y/I=;
        b=TRQaGAd/6JFOSlFWv2ffEltjEV9e31KgdTuuCvCSD2RaDLGnjI7EpZK3qLvznlbMuf
         EtV3xAAiLEihnWppbsyIMqoxaBIShdT/FFtgAZ7H/49mpY+vA9DH3Xjnppw5mU4XKadt
         N8+D5XJvY7Sl92jRVDSvt3uvbCifKHJ11dVNXmhP7GjWT0qAHYB06xkBC2R4twvSp9Ev
         8fIs9iAidg2T7hS6XfLcQ62S2xsktHES4M4/EGnvjUEG9uLT9u0L2I2iVCOWo5c0sahs
         GDIZFTU1c1jP5fk5qic1xU10kh9D+GxT3mCxiilDKAaVqfM18nDcp22fLbdaRRnZeVcs
         KpyA==
X-Gm-Message-State: AOJu0YyUmIGtTQ0YFqnhUp8Jo2w3QgxsSiIYAcsM/a3TbxRT1PNszo8M
	zdf/k5Sd3LVxAIOilxDqGlZ46vWfNnevPK27Z2e4mCwAZUNptg2jmPPn
X-Gm-Gg: ATEYQzxPAzl/h+wTQ3HYwJv6JM62kbvF8PdfASdWrAXopZmZokrKZalwrBeGUInP8Td
	V/Oad00o0plEjOBizv3NBcnKB7opFpi6zJelIWtE/ni3QK5ZsE5y/pba6ARsY4oHiLXxFj4UVmE
	c1jtXUJgUtWrDWOK9xwgyqMfXuqaywQjyapvws/Hmz26UPxDXso9SeGdTVAJwUfe3Rs75kc81s9
	yaxNGfq3tXFDS6DL8CQnF55HnhjiCjEPCzdW4FAEaW3R2LFAMKMboFRtJ+pmb3Lo6XhBz/IQd55
	q6HyetdBtQq+V1jwnDopxMIK6TaeRhdIcQtMXVL4C7zPWrAHqVwD21SgcmtUttIZiHEHRqB8/wX
	CrRwkIdBoLlGCW48RPCLlOEwOfNz1xTF02utcee8bixrLArTynVEv8uZZ+yxdE1EvRYtWZ0hnyQ
	e+m7o0acxScdMFwRr5tg==
X-Received: by 2002:a17:902:c40f:b0:2b0:4158:c9d1 with SMTP id d9443c01a7336-2b082796b00mr93712315ad.36.1774213757435;
        Sun, 22 Mar 2026 14:09:17 -0700 (PDT)
Received: from fedora ([103.149.158.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm84552345ad.26.2026.03.22.14.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 14:09:17 -0700 (PDT)
From: Aby Sam Ross <abysamross@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Aby Sam Ross <abysamross@gmail.com>,
	syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
Subject: [PATCH v1] Bluetooth: hci_release_dev: disable delayed devcoredump work
Date: Mon, 23 Mar 2026 02:38:49 +0530
Message-ID: <20260322210849.68743-1-abysamross@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not necessary that the pending delayed hci devcoredump timeout
work, hdev->dump.dump_timeout, submitted to the hdev->workqueue by the
bluetooth devcoredump state machine,
	hci_devcd_rx()
		hci_devcd_handle_pkt_init()
will be reset by it or by the timeout func hci_devcd_timeout(), using
hci_devcd_reset(), before destroying the workqueue or before the hci
device is freed up in hci_release_dev().

In this bug the active delayed devcoredump timeout work's timer object
is active when the memory associated with the hci device is freed up in
hci_release_dev() causing the ODEBUG WARNING.

Make sure that the delayed devcoredump timeout work is disabled before
the hdev->workqueue is destroyed and before the hdev memory is freed in
hci_release_dev().

Tested the change with the syzbot reproducer that uses vhci device
locally on x86_64 and on syzbot portal as well. Ran kselftest with net
target.

Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
Reported-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
Tested-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
Signed-off-by: Aby Sam Ross <abysamross@gmail.com>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 01f8ceeb1c0c..1c7ee2a33337 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2747,6 +2747,9 @@ void hci_release_dev(struct hci_dev *hdev)
 	kfree_const(hdev->hw_info);
 	kfree_const(hdev->fw_info);
 
+	if (hdev->dump.supported)
+		disable_delayed_work_sync(&hdev->dump.dump_timeout);
+
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
 
-- 
2.53.0


Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6C2DCF77
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Sep 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811895; cv=none; b=I6L/qbMUkGb5pH6C+y2wRW7jozljOlfSYn0Idq7uFzPU0CqTgR0YX6mSMVlHiSO1zKSemj0yILigxNqwG1kRv5SMGMMcrhnE7VR8BpOnwtBKfHG5P5t+x/4U48ncYuYS6FuJxS72PkeDTzHdeS3Ie8ORL6poBIKykii+E1Djrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811895; c=relaxed/simple;
	bh=L6SoP4wBSH0ij3fkHsK/XGeobwPmQwNQKMsaS359wKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMLfkllZO/7nl6T1Os2IERij8lC/HzoXlDciqM0v769i+MDTjuCVfy1vNXbnlqxpiVnDayDq5ZztbeFOsXm4mjDIUWpWz+bMeRgUak76tAMDt6GRiQd8ox1dE/WSFjQaF3ZvAX9jj40hQcQRxiyjg/sR3qY0qGMBhzUQvoSon/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrvdK3h6; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrvdK3h6"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8e3eaa30c71so1000244241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Sep 2025 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758811893; x=1759416693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77xQ9AagyxgspcAnYMbL71tYk6pS3T6xKIIrKpqNykw=;
        b=CrvdK3h69jRSFuqJbRMdWhrh2KfupcYHnfNrNStgPsiBydcJjbtZa1GwWG64vPWR/a
         VKWuvLz144nzmS5kduvQ+W/dF8Agm2te0tfGiU0H0Ux5cbVJXMwdWYh7rBPkfN69emt9
         LITDM49fwjUCo184+hgSeJne5XseWcRWgzyz3xizf843/03EXSnQyuj/Dqg8Mcq7KfhS
         Ml2G3hxIsaQdPUveCr8hwmrXNDVCF+MGZfJJpt++LQ+V0oFH1EBEwuuE2ZUC0r4+tyW6
         UPZn8HHPVfD1tatuPmaxEPG3pIANqKjJAKgcsBbXQ5RFApMaMlMAxZWiEARighPfFNCF
         fVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758811893; x=1759416693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77xQ9AagyxgspcAnYMbL71tYk6pS3T6xKIIrKpqNykw=;
        b=Mv6Pn1h7Xnnm0qWUYLlhdvnwaXGF1P+hSHNzNwj5H15wsvcpyQna7XNb4xhOduWUXb
         sQIP6ZZ+P8WqX/1Iq6z35qt68/sjfof2IHETjMtUWRo+RiKEF0CGvGjUVE2XUhSoryII
         dnW7EFBGf2HZymZGNwIWyMoL078Ug33auhDRNWQFfcss7s1C56mkkIirlJ9+TQ7MPK8j
         kDSFgex+zNQ/hqqBrpgDp5bAlWdycrKrXtWMiCOX0xSOzhsFGKp8snxnCEWmbqYl1/RF
         8z88GDJVXnIyANfgiS0fZd2ea3CGXyXTOhQP58lhj943Yki2OEkJF+YJXy2BnmhNW4lK
         /SJg==
X-Gm-Message-State: AOJu0YxcrrAZTuPvYFxWWpiXuF6vPPpC/hfcUpubCvp0akQRQ9cRTC/7
	KXF0tmCxe2HNELIVp91UvOnqvoVP2Ok4Adp/FwAJT/91k6pBzOMpK4T2
X-Gm-Gg: ASbGncte70+yyhGeOY2TCmYklKn/tj2HK8I9j3W1h/hr8iBQpTA/eHdorg60tS3CAi6
	eZ/fzBhu1vfUWeGsb2H24wkgKBjorJr6GCdWZ453WdWZgQrORzpENR3rTLS0j+lsskCrgqb9kuV
	Sbz5SOEW1RdknUZfmGfHprMw6GigFgpEp2QgJLwKXhnau5vFQ6JX0pIYWbWs/M2AI2OjxG5Lv/R
	T0ENqUrAw6VkjsLf9herJzda8zXwLQped759SsJBv1iccwLgv6m/5pjDJZZn2WYkOF9Z/fJxb8o
	u9kGTcvY7gY/+A7nfpoUDqpkNb+briLhQRKZ+XQ1mggYDUMJDrkCmVXIfp8320ZlB/s2EB6mPMD
	Jo9ZsOXl9RzIq6INyy94MuXavqAJVU7E4yyOWwBiNf30CTyQuDtiqa5JmvWQaWCEMIA==
X-Google-Smtp-Source: AGHT+IGy7QOLPhjvgEYnjRf/nkzcywrd7/bdhmB77Qy7xQJ6U5Qldt7e18Cqi6fey2pThQDiRaJnYg==
X-Received: by 2002:a05:6102:4190:b0:534:cfe0:f861 with SMTP id ada2fe7eead31-5accd215f2amr1571674137.18.1758811892531;
        Thu, 25 Sep 2025 07:51:32 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae302edafasm573619137.4.2025.09.25.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:51:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth-next 2025-09-25
Date: Thu, 25 Sep 2025 10:51:24 -0400
Message-ID: <20250925145124.500357-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 12de5f0f6c2d7aad7e60aada650fcfb374c28a5e:

  Merge branch 'net-gso-restore-outer-ip-ids-correctly' (2025-09-25 12:42:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-09-25

for you to fetch changes up to 8d0a1577fe0db496fa3cc674e5ebff28ebbdebd4:

  Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings (2025-09-25 10:08:04 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

core:

 - MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
 - Avoid a couple dozen -Wflex-array-member-not-at-end warnings
 - bcsp: receive data only if registered
 - HCI: Fix using LE/ACL buffers for ISO packets
 - hci_core: Detect if an ISO link has stalled
 - ISO: Don't initiate CIS connections if there are no buffers
 - ISO: Use sk_sndtimeo as conn_timeout

drivers:

 - btusb: Check for unexpected bytes when defragmenting HCI frames
 - btusb: Add new VID/PID 13d3/3627 for MT7925
 - btusb: Add new VID/PID 13d3/3633 for MT7922
 - btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1
 - btintel: Add support for BlazarIW core
 - btintel_pcie: Add support for _suspend() / _resume()
 - btintel_pcie: Define hdev->wakeup() callback
 - btintel_pcie: Add Bluetooth core/platform as comments
 - btintel_pcie: Add id of Scorpious, Panther Lake-H484
 - btintel_pcie: Refactor Device Coredump

----------------------------------------------------------------
Arkadiusz Bokowy (1):
      Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames

Bartosz Golaszewski (1):
      MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver

Calvin Owens (2):
      Bluetooth: remove duplicate h4_recv_buf() in header
      Bluetooth: Fix build after header cleanup

Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
      Bluetooth: btintel_pcie: Define hdev->wakeup() callback

Chris Lu (2):
      Bluetooth: btusb: Add new VID/PID 13d3/3627 for MT7925
      Bluetooth: btusb: Add new VID/PID 13d3/3633 for MT7922

Gustavo A. R. Silva (1):
      Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Kiran K (4):
      Bluetooth: btintel: Add support for BlazarIW core
      Bluetooth: btintel_pcie: Add Bluetooth core/platform as comments
      Bluetooth: btintel_pcie: Add id of Scorpious, Panther Lake-H484
      Bluetooth: btintel_pcie: Refactor Device Coredump

Luiz Augusto von Dentz (16):
      Bluetooth: btintel_pcie: Move model comment before its definition
      Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
      Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
      Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
      Bluetooth: hci_core: Detect if an ISO link has stalled
      Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
      Bluetooth: Add function and line information to bt_dbg
      Bluetooth: hci_core: Print number of packets in conn->data_q
      Bluetooth: hci_core: Print information of hcon on hci_low_sent
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: MGMT: Fix possible UAFs
      Bluetooth: SCO: Fix UAF on sco_conn_free
      Bluetooth: ISO: Fix possible UAF on iso_conn_free
      Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements

Pauli Virtanen (2):
      Bluetooth: ISO: free rx_skb if not consumed
      Bluetooth: ISO: don't leak skb in ISO_CONT RX

Thorsten Blum (2):
      Bluetooth: Annotate struct hci_drv_rp_read_info with __counted_by_le()
      Bluetooth: btintel_pcie: Use strscpy() instead of strscpy_pad()

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1

 MAINTAINERS                       |   7 +
 drivers/bluetooth/Kconfig         |   6 +
 drivers/bluetooth/bpa10x.c        |   2 +-
 drivers/bluetooth/btintel.c       |   3 +
 drivers/bluetooth/btintel_pcie.c  | 328 +++++++++++++++++++++-----------------
 drivers/bluetooth/btintel_pcie.h  |   2 +
 drivers/bluetooth/btmtksdio.c     |   2 +-
 drivers/bluetooth/btmtkuart.c     |   2 +-
 drivers/bluetooth/btnxpuart.c     |   2 +-
 drivers/bluetooth/btusb.c         |  23 +++
 drivers/bluetooth/h4_recv.h       | 153 ------------------
 drivers/bluetooth/hci_bcsp.c      |   3 +
 drivers/bluetooth/hci_uart.h      |   8 +-
 include/net/bluetooth/bluetooth.h |   3 +-
 include/net/bluetooth/hci.h       |   1 +
 include/net/bluetooth/hci_core.h  |  32 +++-
 include/net/bluetooth/hci_drv.h   |   2 +-
 include/net/bluetooth/mgmt.h      |   9 +-
 net/bluetooth/hci_conn.c          |  27 ++--
 net/bluetooth/hci_core.c          |  52 ++++--
 net/bluetooth/hci_event.c         |  46 ++++--
 net/bluetooth/hci_sync.c          |  17 +-
 net/bluetooth/iso.c               |  34 +++-
 net/bluetooth/mgmt.c              | 254 +++++++++++++++++++----------
 net/bluetooth/mgmt_config.c       |   4 +-
 net/bluetooth/mgmt_util.c         |  24 +++
 net/bluetooth/mgmt_util.h         |   2 +
 net/bluetooth/sco.c               |   7 +
 28 files changed, 604 insertions(+), 451 deletions(-)
 delete mode 100644 drivers/bluetooth/h4_recv.h

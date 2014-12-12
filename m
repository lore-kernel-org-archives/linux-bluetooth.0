Return-Path: <cyrus@holtmann.org>
From: Tristan Lelong <tristan@lelong.xyz>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Tristan Lelong <tristan@lelong.xyz>
Subject: [PATCH 0/2] BCSP Link Establishment in kernel
Date: Thu, 11 Dec 2014 23:14:36 -0800
Message-Id: <1418368478-13956-1-git-send-email-tristan@lelong.xyz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This serie of patch will add the link establishment protocol for BCSP into
the kernel rather than having to handle in userland before switching discipline
and make the TX window size configurable.

These patches might not be ready for direct submission to the kernel mainline, but this is a first request for comment/review.

Thanks,

Regards

Tristan Lelong (2):
  hci_bcsp: Add LE protocol on kernel side
  bcsp: Change tx window size in configuration

 drivers/bluetooth/Kconfig        |   7 ++
 drivers/bluetooth/hci_bcsp.c     | 203 +++++++++++++++++++++++++++++++--------
 drivers/bluetooth/hci_ldisc.c    |   5 +
 include/net/bluetooth/hci_core.h |   2 +
 net/bluetooth/hci_core.c         |   6 +-
 5 files changed, 182 insertions(+), 41 deletions(-)

-- 
2.1.1


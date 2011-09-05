Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 0/2] Move SMP encryption to a workqueue
Date: Mon,  5 Sep 2011 14:31:29 -0300
Message-Id: <1315243891-21875-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes from last version:

- use the hci_dev workqueue for SMP crypto work;
- move declaration of smp_chan to smp.h

Cheers,
--

Vinicius Costa Gomes (2):
  Bluetooth: Move SMP fields to a separate structure
  Bluetooth: Move SMP crypto functions to a workqueue

 include/net/bluetooth/hci_core.h |    2 -
 include/net/bluetooth/l2cap.h    |    8 +-
 include/net/bluetooth/smp.h      |   17 ++
 net/bluetooth/hci_core.c         |    8 -
 net/bluetooth/l2cap_core.c       |    2 +-
 net/bluetooth/smp.c              |  339 +++++++++++++++++++++++---------------
 6 files changed, 226 insertions(+), 150 deletions(-)

--
1.7.6.1


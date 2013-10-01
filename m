Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: Fix hci_dev_open race condition
Date: Tue,  1 Oct 2013 22:44:48 +0300
Message-Id: <1380656690-22246-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's an updated set including fixes based on feedback. The patches
should go to bluetooth.git, but I'm not sure how important it is to try
to get them to the stable tree since we haven't had this issue reported
with the Intel setup procedure which (afaik) should be the only one that
could be affected in older kernels.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Refactor hci_dev_open to a separate hci_dev_do_open function
      Bluetooth: Fix workqueue synchronization in hci_dev_open

 net/bluetooth/hci_core.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)


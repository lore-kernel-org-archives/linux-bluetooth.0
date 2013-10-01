Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Fix hci_dev_open race condition
Date: Tue,  1 Oct 2013 14:10:26 +0300
Message-Id: <1380625828-19538-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

There was recently a bug reported regarding the setup stage getting
called twice (Subject: [PATCH v5 1/2] Bluetooth: btmrvl: add setup
handler). There was an initial patch proposal to get an understanding of
what exactly is happening, but the initial fix itself was not the one we
want upstream.

After considering the various options we decided to simply ensure that
the HCIDEVUP ioctl calling path needs to ensure that the req_workqueue
is flushed before calling hci_dev_open. However, this requires some
refactoring and hence two patches instead of one.

I was able to test this with BlueZ 4.101 and Intel HW to see that the
Intel setup handler doesn't get called twice, but it would still be good
to test this with the setup that was used for the initial report.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Refactor hci_dev_open to a separate hci_dev_do_open function
      Bluetooth: Fix workqueue synchronization in hci_dev_open

 net/bluetooth/hci_core.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)


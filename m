Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Fix workqueue related issues
Date: Mon, 14 Jan 2013 22:33:49 +0200
Message-Id: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I was initially only going to fix the thing in the last patch of this
set but after starting to look at the code I found several other issues
and hence the rest of the patches.

The first three patches fix work queue handling. We should, whenever
possible, avoid the system-global workqueue (the schedule_*work
functions) and use hdev-specific ones instead. However, we can't use
hci_request() with the usual workqueue since that would block e.g.
hci_send_cmd from completing so a second work queue is needed.

The last patch fixes a race with setting the scan mode that I was
seeing every once in a while through a connectable or discoverable test
case of mgmt-tester failing. There are several other HCI commands with
the same potential issue (like the class of device and the local name)
but I haven't gotten around to fixing those yet.

Johan


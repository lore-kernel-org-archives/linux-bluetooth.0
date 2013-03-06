Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Error handling in HCI request framework
Date: Wed,  6 Mar 2013 20:45:13 -0300
Message-Id: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This small patch set aims to add a better support for error handling in HCI
request framework.

When we are building a HCI request with more the one HCI command and one of
the hci_req_add calls fail, we should have some cleanup routine. This way the
HCI commands already queued on HCI request can be deleted. Otherwise we will
face some memory leaks issues. Discussing about this issue on IRC, we came up
with the approach implemented in this patch set.

The approach is the following: If a hci_req_add fails, we set a flag in struct
hci_request to indicate the failure. Subsequent hci_req_add calls will simply
add no HCI commands to the HCI request queue. Once hci_req_run is called, we
verify the error flag. If it is set, we delete all HCI commands already queued
and return a error code.

Regards,

Andre


Andre Guedes (4):
  Bluetooth: Check hci_req_run error code in __hci_req_sync
  Bluetooth: HCI request error handling
  Bluetooth: Make hci_req_add return void
  Bluetooth: Check req->error flag in hci_req_add

 include/net/bluetooth/hci_core.h |  5 ++++-
 net/bluetooth/hci_core.c         | 33 +++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

-- 
1.8.1.2


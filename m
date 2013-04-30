Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/13] Update Discovery to use HCI request framework
Date: Tue, 30 Apr 2013 02:44:51 -0300
Message-Id: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v2 basically implements Johan's comments from the previous patch set. The
main changes are:
* A new patch was added to fix start_discovery for LE-only controllers.
* The hci_ prefix was added to inquiry_cache_flush.
* Interleaved discovery implementation was changed. Instead of building a
  request with HCI_OP_LE_SET_SCAN_ENABLE and HCI_OP_INQUIRY commands, we send
  the inquiry command in disable LE scanning complete callback.

Below follows the summary of the patches (from the previous cover letter with
some adaptations):

* Patch 1 fixes start_discovery for LE-only controllers. This patch can be
  applied even if the rest of this patch set is not. Otherwise, start_discovery
  always fails for LE-only controllers.

* Patch 2 makes inquiry_cache_flush function non-static since it will be used
  in mgmt.c by the upcoming patch.

* Patch 3 updates start_discovery function to use HCI request to send HCI
  inquiry/LE scanning commands to the controller. It also defines the start_
  discovery_complete function where all command complete events are handled.

* Patch 4 simply removes Start Discovery command complete handling from hci_
  event.c since it is now handled by start_discovery_complete function in
  mgmt.c.

* Patch 5 moves discovery macros from mgmt.c to a common place (hci_core.h)
  because some of these macros will be used in hci_core.c in the upcoming
  patch.

* Patch 6 updates the interleaved discovery to use HCI requests. First we send
  a request to disable the LE scanning. Then, if it completes successfully,
  we send another request to trigger the inquiry procedure.

* Patch 7 updates stop_discovery function to use HCI request. This patch does
  a similar job as Patch 3, but for Stop Discovery command instead.

* Patch 8 simply removes Stop Discovery command complete handling from hci_
  event.c. This patch does a similar job as Patch 4, but for Stop Discovery
  command instead.

* Patch 9 does a very trivial refactoring in hci_cc_le_set_scan_enable
  function.

* Patches 10 and 11 removes LE scanning helpers and inquiry helpers since they
  are no longer used.

* Patch 12 removes the hci_cc_le_set_scan_param function since it became an
  empty event handler.

* Patch 13 is not really related to this patch set, but it is related to the
  whole Device Discovery functionality. As discussed on IRC with Marcel, we
  don't want the kernel sending Mgmt Device Found events to user-space when we
  are not running the Device Discovery. Therefore, Inquiry or LE scanning
  triggered by HCI raw interface (e.g. hcitool) won't generate Mgmt Device
  Found events anymore.

BR,

Andre

Andre Guedes (13):
  Bluetooth: Fix start_discovery for LE-only controllers
  Bluetooth: Make inquiry_cache_flush non-static
  Bluetooth: Update start_discovery to use HCI request
  Bluetooth: Remove start discovery handling from hci_event.c
  Bluetooth: Move discovery macros to hci_core.h
  Bluetooth: Use HCI request in interleaved discovery
  Bluetooth: Update stop_discovery to use HCI request
  Bluetooth: Remove stop discovery handling from hci_event.c
  Bluetooth: Refactor hci_cc_le_set_scan_enable
  Bluetooth: Remove LE scan helpers
  Bluetooth: Remove inquiry helpers
  Bluetooth: Remove empty event handler
  Bluetooth: Mgmt Device Found Event

 include/net/bluetooth/hci_core.h |  27 +++---
 net/bluetooth/hci_core.c         | 186 +++++++++++----------------------------
 net/bluetooth/hci_event.c        |  67 +-------------
 net/bluetooth/mgmt.c             | 157 +++++++++++++++++++++++++--------
 4 files changed, 188 insertions(+), 249 deletions(-)

-- 
1.8.2.1


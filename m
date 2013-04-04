Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/17] Update Discovery to use HCI request framework
Date: Thu,  4 Apr 2013 20:20:58 -0300
Message-Id: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch set updates discovery code in order to make use of the HCI request
framework. This way, we can move all Start/Stop Discovery command complete
handling, spread in hci_event.c, to a single place in mgmt.c, reducing the
spaghetti factor from discovery code.

Since this patch set follows a different approach from the previous one, I
reset the version counter on the subject. However, some comments from Marcel
about the previous patch set are still applicable and all of them were covered
in this patch set. The main comments were:
* Move cleanup and trivial refactoring patches to the beginning of the patch
set.
* When build a HCI request, put hci_req_init, hci_req_add and hci_req_run in
the same function;

Since this is a long patch set, below follows a summary of the patches in
order to make the review process a bit easier:

* Patches 1 to 4 are a very trivial patches which add or rename some macros in
order to improve code's readability and remove some magic numbers. These macros
are related to LE scanning parameters such as scanning type, filter duplicates
and scanning timeout.

* Patch 5 makes inquiry_cache_flush function non-static since it will be used
in mgmt.c by the upcoming patch (patch 6).

* Patch 6 updates start_discovery function to use HCI request to send HCI
inquiry/LE scanning commands to the controller. It also defines the start_
discovery_complete function where all command complete events are handled.

* Patch 7 simply removes Start Discovery command complete handling from hci_
event.c since it is now handled by start_discovery_complete function in mgmt.c.

* Patch 8 moves discovery macros from mgmt.c to a common place (hci_core.h)
because some of these macros will be used in hci_core.c in the upcoming patch
(patch 9).

* Patch 9 updates le_scan_disable_work function to use HCI request.

* Patch 10 updates stop_discovery function to use HCI request. This patch does
a similar job as Patch 6, but for Stop Discovery command instead.

* Patch 11 simply removes Stop Discovery command complete handling from hci_
event.c. This patch does a similar job as Patch 7, but for Stop Discovery
command instead.

* Patch 12 does a very trivial refactoring in hci_cc_le_set_scan_enable
function.

* Patches 13 and 14 removes LE scanning helpers and inquiry helpers since they
are no longer used.

* Patch 15 removes the hci_cc_le_set_scan_param function since it became an
empty event handler.

* Patch 16 renames le_scan_disable work to a more suitable name.

* Patch 17 is not really related to this patch set, but it is related to the
whole Device Discovery functionality. As discussed on IRC with Marcel, we
don't want the kernel sending Mgmt Device Found events to user-space when we
are not running the Device Discovery. Therefore, Inquiry or LE scanning
triggered by HCI raw interface (e.g. hcitool) won't generate Mgmt Device Found
events anymore.

Regards,

Andre


Andre Guedes (17):
  Bluetooth: Change LE scanning timeout macros
  Bluetooth: Add LE scan type macros
  Bluetooth: Add macros for filter duplicates values
  Bluetooth: Rename LE_SCANNING_* macros
  Bluetooth: Make inquiry_cache_flush non-static
  Bluetooth: Update start_discovery to use HCI request
  Bluetooth: Remove start discovery handling from hci_event.c
  Bluetooth: Move discovery macros to hci_core.h
  Bluetooth: Update le_scan_disable_work to use HCI request
  Bluetooth: Update stop_discovery to use HCI request
  Bluetooth: Remove stop discovery handling from hci_event.c
  Bluetooth: Refactor hci_cc_le_set_scan_enable
  Bluetooth: Remove LE scan helpers
  Bluetooth: Remove inquiry helpers
  Bluetooth: Remove empty event handler
  Bluetooth: Rename le_scan_disable delayed work
  Bluetooth: Mgmt Device Found Event

 include/net/bluetooth/hci.h      |   9 +-
 include/net/bluetooth/hci_core.h |  29 +++---
 net/bluetooth/hci_core.c         | 192 ++++++++++++---------------------------
 net/bluetooth/hci_event.c        |  71 ++-------------
 net/bluetooth/mgmt.c             | 156 +++++++++++++++++++++++--------
 5 files changed, 201 insertions(+), 256 deletions(-)

-- 
1.8.1.2


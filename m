Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 00/17] BlueZ/Bluetooth: Multi-advertising infrastructure
Date: Thu, 30 Apr 2015 17:33:03 +0200
Message-Id: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
References: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a patch set introducing the infrastructure for multi-advertising
capability to the HCI core and mgmt API.

v1 -> v2:
- add missing braces in read_adv_features()

v2 -> v3:
- split change-set into several patches
- replace err == 0 by !err
- fix coding style problems

v3 -> v4:
publicly visible change:
- when calling remove_advertising with an instance value of zero (i.e.
  remove all instances), the command response also returns an instance
  value of zero now as it doesn't make sense to return a single instance
  id when removing several instances

refactoring and fixes (due to Arman's review):
- splitting the change set into a much larger number of patches to
  facilitate review
- use HCI_MAX_ADV_INSTANCES in the same patch that introduces it
- use adv_info->hdev in the same patch that introduces it
- make the logic of hci_find_adv_instance() more readable
- make sure that hci_find_adv_instance() is called while hci_dev is
  locked
- replace hci_num_adv_instances() by an instance counter in hci_dev
- add inline comment in get_adv_instance_flags() explaining its return
  value in the error case
- generate zero-length adv data if the current instance identifier is
  invalid
- revert erroneous changes to the logic in clear_adv_instance()
- use hci_adv_instances_clear() in clear_adv_instance() when removing
  all advertising instances also removing a reduntant error check
- inserting TODO messages to make sure that advertising will not be
  switched off prematurely once we allow more than one advertising
  instance
- inserting TODO messages to make sure that multiple advertising
  instances will be advertised in a round-robin fashion once we allow
  for more than one advertising instance
- identify peding advertising instances (just added but not yet
  confirmed in add_advertising_complete) by a boolean flag in the
  adv_info struct so that we can identify and remove them even when
  the pending add_advertising command cannot be retrieved for some
  reason - makes sure that we do not lead advertising instances in this
  case
- only send HCI commands to update advertising data when a new instance
  has actually been added



Userland:

Florian Grandel (1):
  tools/mgmt_tester: expect 0 rp when removing all adv inst

 tools/mgmt-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)



Kernel:

Florian Grandel (16):
  Bluetooth: hci_core: Introduce multi-adv inst list
  Bluetooth: mgmt: dry update_scan_rsp_data()
  Bluetooth: mgmt: multi adv for read_adv_features()
  Bluetooth: mgmt: multi adv for get_current_adv_instance()
  Bluetooth: mgmt: multi adv for get_adv_instance_flags()
  Bluetooth: mgmt: improve get_adv_instance_flags() readability
  Bluetooth: mgmt: multi adv for enable_advertising()
  Bluetooth: mgmt: use current adv instance in set_advertising()
  Bluetooth: mgmt: multi adv for create_instance_scan_rsp_data()
  Bluetooth: mgmt: multi adv for create_instance_adv_data()
  Bluetooth: mgmt: refactor update_*_data()
  Bluetooth: mgmt: multi adv for set_advertising_complete()
  Bluetooth: mgmt: multi adv for add_advertising()
  Bluetooth: mgmt: multi adv for clear_adv_instances()
  Bluetooth: multi adv for remove_advertising()
  Bluetooth: hci_core: Remove obsolete adv_instance

 include/net/bluetooth/hci_core.h |  22 ++-
 net/bluetooth/hci_core.c         | 113 ++++++++++++-
 net/bluetooth/mgmt.c             | 352 ++++++++++++++++++++++-----------------
 3 files changed, 328 insertions(+), 159 deletions(-)

-- 
1.9.1


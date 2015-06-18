Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 00/20] Multi-advertising
Date: Thu, 18 Jun 2015 03:16:33 +0200
Message-Id: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

patch set introducing the infrastructure for multi-advertising
capability to the HCI core and mgmt API.

v1 -> v2:
- add missing braces in read_adv_features()

v2 -> v3 (changes due to Johan's review):
- split change-set into several patches
- replace err == 0 by !err
- fix coding style problems

v3 -> v4 (changes due to Arman's review):
- bug fix: when calling remove_advertising with an instance value of
  zero (i.e.  remove all instances), the command response also returns
  an instance value of zero now as it doesn't make sense to return a
  single instance id when removing several instances
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
  all advertising instances also removing a redundant error check
- inserting TODO messages to make sure that advertising will not be
  switched off prematurely once we allow more than one advertising
  instance
- inserting TODO messages to make sure that multiple advertising
  instances will be advertised in a round-robin fashion once we allow
  for more than one advertising instance
- identify pending advertising instances (just added but not yet
  confirmed in add_advertising_complete) by a boolean flag in the
  adv_info struct so that we can identify and remove them even when the
  pending add_advertising command cannot be retrieved for some reason -
  makes sure that we do not leak advertising instances in this case
- only send HCI commands to update advertising data when a new instance
  has actually been added

v4 -> v5 (changes due to Marcel's review):
- split into separate change sets for kernel and userspace
- do not trust the adv instance list length when compiling the adv
  features struct
- introduce adv_info->pending in the same patch it's used for the first
  time

v5 -> v6 (changes due to Marcel's review):
- fix the add adv override bug
- fix "Using plain integer as NULL pointer" warning in
  set_advertising_complete()
- reword the "remove adv instance" commit comment to make it clear that
  an existing bug is being fixed

v6 -> v7:
- so far the patch set only contained a functionally neutral refactoring
  to provide the basic infrastructure for multi-advertising. It has been
  decided, though, that the patch set should provide the whole package
  at once, including actual multi-advertising functionality. This has
  been implemented and tested in the latest version of the patch set.

v7 -> v8 (changes due to Marcel's review):
- switch to next instance when updating the currently advertised
  instance
- keep instances without timeout during power cycles

Florian Grandel (20):
  Bluetooth: hci_core/mgmt: Introduce multi-adv list
  Bluetooth: hci_core/mgmt: move adv timeout to hdev
  Bluetooth: mgmt: dry update_scan_rsp_data()
  Bluetooth: mgmt: rename update_*_data_for_instance()
  Bluetooth: mgmt: multi adv for read_adv_features()
  Bluetooth: mgmt: multi adv for get_current_adv_instance()
  Bluetooth: mgmt: multi adv for get_adv_instance_flags()
  Bluetooth: mgmt: improve get_adv_instance_flags() readability
  Bluetooth: mgmt: multi adv for enable_advertising()
  Bluetooth: mgmt: multi adv for create_instance_scan_rsp_data()
  Bluetooth: mgmt: multi adv for create_instance_adv_data()
  Bluetooth: mgmt: multi adv for set_advertising*()
  Bluetooth: mgmt: multi adv for clear_adv_instances()
  Bluetooth: mgmt/hci_core: multi-adv for add_advertising*()
  Bluetooth: mgmt: multi adv for remove_advertising*()
  Bluetooth: mgmt: program multi-adv on power on
  Bluetooth: mgmt: multi-adv for trigger_le_scan()
  Bluetooth: mgmt: multi-adv for mgmt_reenable_advertising()
  Bluetooth: hci_core: remove obsolete adv_instance
  Bluetooth: hci_core: increase max adv inst

 include/net/bluetooth/hci_core.h |  29 +-
 net/bluetooth/hci_core.c         | 148 +++++++++-
 net/bluetooth/mgmt.c             | 563 +++++++++++++++++++++++++++------------
 3 files changed, 565 insertions(+), 175 deletions(-)

-- 
1.9.1


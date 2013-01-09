Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Bluetooth: Various mgmt fixes
Date: Wed,  9 Jan 2013 15:29:32 +0200
Message-Id: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This this set of patches fixes various issues with the management
interface that have been found in the past few weeks. It also improves
the pass-rate of the user space mgmt-tester to all but one test case
(which I'm not 100% sure is correct anyway):

Total: 35, Passed: 34 (97.1%), Failed: 1, Not Run: 0

Johan Hedberg (8):
      Bluetooth: Fix missing command complete event for mgmt_confirm_name
      Bluetooth: Fix missing command complete for mgmt_load_long_term_keys
      Bluetooth: Fix checking for valid device class values
      Bluetooth: Fix accepting set_dev_class for non-BR/EDR controllers
      Bluetooth: Fix returning proper command status for start_discovery
      Bluetooth: Move non-critical sections outside of the dev lock
      Bluetooth: Fix checking for exact values of boolean mgmt parameters
      Bluetooth: Fix sending incorrect new_settings for mgmt_set_powered

 net/bluetooth/mgmt.c |  124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 91 insertions(+), 33 deletions(-)

Johan

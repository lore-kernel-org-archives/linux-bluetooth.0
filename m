Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/2] Bluetooth: Multi-Advertising Infrastructure
Date: Fri, 10 Apr 2015 04:30:39 +0200
Message-Id: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <20150409094913.GB10676@t440s.lan>
References: <20150409094913.GB10676@t440s.lan>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A patch set introducing the infrastructure for multi-advertising
capability to the HCI core and mgmt API.

v1 -> v2:
- add missing braces in read_adv_features()

v2 -> v3:
- split change-set into several patches
- replace err == 0 by !err
- fix coding style problems

Florian Grandel (2):
  Bluetooth: hci_core: Introduce multi-adv inst list
  Bluetooth: mgmt: Start using multi-adv inst list

 include/net/bluetooth/hci_core.h |  21 ++-
 net/bluetooth/hci_core.c         | 118 ++++++++++++-
 net/bluetooth/mgmt.c             | 349 +++++++++++++++++++++------------------
 3 files changed, 321 insertions(+), 167 deletions(-)

-- 
1.9.1


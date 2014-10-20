Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] core: Add btd_adapter_recreate_bonding()
Date: Mon, 20 Oct 2014 15:01:24 +0000
Message-Id: <1413817285-23388-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2:

* Fix warning

Alfonso Acosta (1):
  core: Add btd_adapter_recreate_bonding()

 src/adapter.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/adapter.h |  7 ++++++-
 src/device.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/device.h  |  4 ++++
 4 files changed, 119 insertions(+), 7 deletions(-)

-- 
1.9.1


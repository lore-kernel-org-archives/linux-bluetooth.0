Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/7] Move adapter config file to ini-file format
Date: Wed, 10 Oct 2012 10:58:33 +0200
Message-Id: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter saved configuration will be saved to /var/lib/bluetooth/<adapter address>/settings
in ini-file format for BlueZ 5.
If this file does not exist, we try to convert legacy config file to it.

Access to variables during run-time is performed in adapter structure which is populated by loading saved configuration during initialization.

First 6 patches remove access to config file from run-time.
Last patch move to ini-file format style (load, save and convert).

Frédéric Danis (7):
  adapter: Read name in storage at init
  adapter: Read device class in storage at init
  adapter: Move pairable read to load_config()
  adapter: Read pairable timeout in storage at init
  adapter: Read discoverable timeout in storage at init
  adapter: Read mode in storage at init
  adapter: Move saved config to ini-file format

 TODO                  |    6 +
 plugins/adaptername.c |    9 +-
 src/adapter.c         |  330 ++++++++++++++++++++++++++++++++++++++-----------
 src/adapter.h         |    1 +
 4 files changed, 268 insertions(+), 78 deletions(-)

-- 
1.7.9.5


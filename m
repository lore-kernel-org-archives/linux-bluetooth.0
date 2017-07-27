Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH Bluez 0/6] core: Add checking for Policy/GATT in main.conf
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
Date: Thu, 27 Jul 2017 20:18:41 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patches add checking for Policy/GATT in main.conf as below:
  bluetoothd[XXXX]: Unknown key Cache for group Policy in main.conf
  bluetoothd[XXXX]: Unknown key Timeout for group GATT in main.conf

ERAMOTO Masaya (6):
  core: Add group information to warning message for main.conf
  core: Split check_config() function
  core: Fix General options in main.conf
  core: Add checking for unknown Policy options
  core: Add checking for unknown GATT options
  core: Make easier to manage checked groups

 src/main.c | 81 ++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 23 deletions(-)

-- 
2.7.4



Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ v2 0/6] Improve around advertise of bluetoothctl
Message-ID: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Date: Mon, 25 Sep 2017 13:21:38 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set fixes bugs of advertising.c and refactors
advertise-related code.

Changes since v1:
 - Merge 5th and 6th patches into a new patch

ERAMOTO Masaya (5):
  client: Fix memory leak of advertise command
  client: Fix core dump when using set-advertise-name
  client: Prevent to pass invalid ad type to D-Bus
  client: Use existing function for parsing argument
  client: Use new parse_argument() instead of parse_argument_XX()

 client/advertising.c |  14 +++++--
 client/main.c        | 107 ++++++++++++---------------------------------------
 2 files changed, 35 insertions(+), 86 deletions(-)

-- 
2.7.4


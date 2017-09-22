Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 0/6] Improve around advertise of bluetoothctl
Message-ID: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Date: Fri, 22 Sep 2017 21:15:38 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set fixes bugs of advertising.c and refactors
advertise-related code.

ERAMOTO Masaya (6):
  client: Fix memory leak of advertise command
  client: Fix core dump when using set-advertise-name
  client: Prevent to pass invalid type to D-Bus
  client: Use existing function for parsing argument
  client: Introduce parse_argument()
  client: Use new parse_argument() function

 client/advertising.c |  14 +++++--
 client/main.c        | 107 ++++++++++++---------------------------------------
 2 files changed, 35 insertions(+), 86 deletions(-)

-- 
2.7.4


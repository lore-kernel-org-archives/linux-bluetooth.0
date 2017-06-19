Return-Path: <linux-bluetooth-owner@vger.kernel.org>
CC: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ v2 0/3] client: Improve help command
Message-ID: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
Date: Mon, 19 Jun 2017 20:22:02 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds alias-related help messages and makes more readable in whole.

Changes since v1:
 -rebase patches


ERAMOTO Masaya (3):
  client: Compare a input string and each command only once
  client: Add a description to all commands
  client: Output a long message by two lines

 client/main.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

-- 
2.7.4

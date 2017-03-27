Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: hyuk0512@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Lee Hyuk <hyuk0512.lee@samsung.com>
Subject: [PATCH BlueZ] src/adapter: Add the NULL check for response
Date: Mon, 27 Mar 2017 10:18:26 +0900
Message-id: <1490577507-28351-1-git-send-email-hyuk0512@gmail.com>
References: <CGME20170327011830epcas5p448d6a1d19f613c5962d386546fe9ecf5@epcas5p4.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lee Hyuk <hyuk0512.lee@samsung.com>

It is just bug fix.
Please review this.

Lee Hyuk (1):
  src/adapter: Add the NULL check for response

 src/adapter.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.9.1


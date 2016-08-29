Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Per Thomas Jahr <perja@extern.uio.no>
To: linux-bluetooth@vger.kernel.org
Cc: Per Thomas Jahr <perja@extern.uio.no>
Subject: [PATCH BlueZ] Include UUID in output
Date: Mon, 29 Aug 2016 11:14:48 +0200
Message-Id: <1472462089-22900-1-git-send-email-perja@extern.uio.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added UUID in the output when listing attributes. This makes it more convenient to work with as it gives a mapping between UUID and attribute id.

Per Thomas Jahr (1):
  client: Include UUID when listing attributes

 client/gatt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.5.5


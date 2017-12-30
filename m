Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ahmed Alsharif <ahmeds2000x@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ahmed Alsharif <ahmeds2000x@gmail.com>
Subject: [PATCH BlueZ 0/1] Remove useless error from StartNotify()
Date: Sat, 30 Dec 2017 11:07:01 +0100
Message-Id: <20171230100702.14124-1-ahmeds2000x@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

StartNotify() should work regardless whether the device is connected or not,
but it only returns an InProgress error when the device isn't, which is a bit
inconsistent.

Ahmed Alsharif (1):
  remove InProgress error from StartNotify() The error is only returned
    when the device is not connected, even though StartNotify is
    supposed to work in that case as well.

 doc/gatt-api.txt  | 1 -
 src/gatt-client.c | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.11.0


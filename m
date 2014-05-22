Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/4] android/gatt: Read/Write improvements
Date: Thu, 22 May 2014 13:17:41 +0200
Message-Id: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set improves read/write operations from characteristics managed
by Android server application.


Lukasz Rymanowski (3):
  android/gatt: Improve handling pending read/write requests
  android/gatt: Fix minor style code issue
  android/gatt: Use pending request for write req and prep write

Marcin Kraglak (1):
  android/gatt: Use common framework for processing read_by_group_type
    request

 android/gatt.c | 139 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 79 insertions(+), 60 deletions(-)

-- 
1.8.4


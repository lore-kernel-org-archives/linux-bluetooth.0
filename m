Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/5]android/gatt: GATT Client write types support
Date: Thu, 17 Apr 2014 13:57:43 +0200
Message-Id: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds support for different write types.
For this I had to expose some additional API from attrib.

Only signed write left to implement.

v2:
* Rebase
* Remove double empty line from gatt.h as Szymon pointed out

Lukasz Rymanowski (5):
  attrib: Add API for reliable write
  attrib: Expose write execute
  android/gatt: Add support for reliable write
  android/gatt: Add support for write execute
  android/gatt: Add support for write without response

 android/gatt.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 attrib/gatt.c  |  24 ++++++++++++
 attrib/gatt.h  |   8 ++++
 3 files changed, 128 insertions(+), 17 deletions(-)

-- 
1.8.4


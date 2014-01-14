Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 0/5] Remote device cache support
Date: Tue, 14 Jan 2014 12:11:40 +0100
Message-Id: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

This adds support for permanent cache of remote devices info. Cache size is
limited to DEVICES_CACHE_MAX (currently 100) and oldest devices (based on
timestamp) is removed if cache gets full.

notes:
 - there is still place for improvements in number of reads/writes done.
   Will work on that when current cache approach is accepted.
 - there is no need to cache SDP (we cache UUIDs)

Comments are welcome.

-- 
BR
Szymon Janc

Szymon Janc (5):
  android/bluetooth: Split devices list to devices and bonded_devices
  android/bluetooth: Use defines for settings and devices files paths
  android/bluetooth: Always store device info
  android/bluetooth: Add support for caching remote device info
  android/bluetooth: Add support for loading caches devices from storage

 android/bluetooth.c | 199 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 148 insertions(+), 51 deletions(-)

-- 
1.8.3.2


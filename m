Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/2] Add support for filtering service search by uuid
Date: Thu, 17 Apr 2014 11:58:15 +0200
Message-Id: <1397728697-22563-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3: Rebased
v2: Add replenish support for caching services. It helps to avoid double
primary service entries on list.
v1: Allow search service cmd to support filtering by uuid

Grzegorz Kolodziejczyk (2):
  android/gatt: Extend android2uuid uuid type support
  android/gatt: Add support for uuid filter in search services

 android/gatt.c | 330 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 245 insertions(+), 85 deletions(-)

-- 
1.9.1


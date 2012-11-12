Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Update dbusoob API
Date: Mon, 12 Nov 2012 16:53:14 +0100
Message-ID: <1352735596-731-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This updates AddRemoteData method to create and return device object path.

With recent change on how new device objects are created it is no
longer possible to create device object from string with
org.bluez.Adapter interface. When adding OOB data for specified
address device object is created if it was not yet existing.

Path to object is returned in AddRemoteData to avoid need for extra
FindDevice() call on org.bluez.Adapter to get object maching specified
address.

Question:
Should RemoveRemoteData be updated to accept device path instead of address?
(and therefore require existing object, this method doesn't remove object or
any storage data but only deletes hash/rand kept in kernel).

Szymon Janc (1):
  dbusoob: Create device object and return it when adding OOB data

 doc/oob-api.txt   |    6 +++++-
 plugins/dbusoob.c |   28 ++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

-- 
1.7.9.5


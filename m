Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 0/2] Store address type on storage
Date: Fri, 18 May 2012 17:57:45 -0300
Message-Id: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BLE devices have two different address types: public or
random. So we need to provide this address type on keys in
the "primary" file to avoid duplicate BLE address types
around the BlueZ.

This series changes the storage to store the address type
together with the device address.

Hemant Gupta has been working on this on "Store LE device
address type with primary list" but his patch hasn't been
accepted and he didn't send a new reviewed version of that
patch.

I have patches for the other storage files as well, I'll send
them when this series is integrated upstream.

Claudio Takahasi (1):
  core: Fix creating device from "primary" file

Paulo Alcantara (1):
  storage: Store BLE address type in "primary" file

 src/adapter.c |   10 +++++++---
 src/device.c  |    2 +-
 src/storage.c |   30 ++++++++++++++++++++++++++----
 src/storage.h |    5 +++--
 4 files changed, 37 insertions(+), 10 deletions(-)

-- 
1.7.7.6


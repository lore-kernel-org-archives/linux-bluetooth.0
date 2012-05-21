Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 0/2] Address type in keys on storage filesystem
Date: Mon, 21 May 2012 17:48:34 -0300
Message-Id: <1337633316-4992-1-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BLE devices have two different address types: public or
random. So we need to provide this address type on keys
in the "primary" file to avoid duplicate BLE address types
around the BlueZ.

This series changes the storage to store the address type
together with the device address.

Hemant Gupta has been working on this on "Store LE device address
type with primary list" but his patch hasn't been accepted and
he didn't send a new reviewed version of that patch.

I have patches for the other storage files as well, I'll
send them soon. There is a potential problem in
device_address_cmp() function which checks the address only.
I am investigating how to fix it to compare address and type
without breaking the current code.

v2's changes:
     - Use sprintf() instead of setting values by indexing
       strings.
     - Keep backward compatibility with entries created by
       older bluetoothd versions.

Claudio Takahasi (1):
  core: Fix creating device from "primary" file

Paulo Alcantara (1):
  storage: Store BLE address type in "primary" file

 src/adapter.c |   10 +++++++---
 src/device.c  |    2 +-
 src/storage.c |   32 ++++++++++++++++++++++++--------
 src/storage.h |    5 +++--
 4 files changed, 35 insertions(+), 14 deletions(-)

-- 
1.7.7.6


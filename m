Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 0/4] android: Permanent storage support
Date: Wed, 18 Dec 2013 12:20:56 +0100
Message-Id: <1387365660-25281-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

This is first RFC for storage format for Android daemon.

Some highlights:
- storage is much simple in format than Linux daemon (no addresses in paths
  or filenames, only 1 adapter support etc)
- only info that requires persistency  over daemon lifetime from Framework
  perspective is stored
- settings file for adapter config
- devices file for remote device info (groups are remote devices addresses)
- Android storage path is /data/misc/bluez (I've decided to not use
  /data/misc/bluetooth to avoid any clashes as there still seems to be
  leftovers available in Android tree eg. there are still references to that
  directory in CTS testcases and init files of Android 4.4)

I'm not sure how to handle storage on Linux host so for now it is set to
STORAGEDIR/android/ directory (if directory is missing it is not created
by daemon).

Storage format is as following sample:

settings file:
[General]
Address=20:68:9D:3A:52:5E
Name=BlueZ Android
DiscoverableTimeout=0

devices file:
[00:0D:3C:B1:C4:AC]
Type=0
Name=Nokia BH-503
Class=2360324
LinkKey=0x306A400930B0AE36D7AC45D8DC50F1A0
LinkKeyType=0
LinkKeyPINLength=4
Services=0x0000110B00001000800000805F9B34FB;0x0000110C00001000800000805F9B34FB;0x0000110E00001000800000805F9B34FB;0x0000111E00001000800000805F9B34FB;0x0000110800001000800000805F9B34FB;

[00:1F:20:17:87:D7]
Type=0
Name=Bluetooth Laser Travel Mouse
Class=9600
LinkKey=0x3725CC552EAB8AB82D843BFEB14D2E47
LinkKeyType=0
LinkKeyPINLength=4
Services=0x0000112400001000800000805F9B34FB;0x0000120000001000800000805F9B34FB;

[40:B0:FA:39:FF:B8]
Type=0
Name=Nexus 4
Class=5898764
LinkKey=0x1E201EE8E82E1E50682622077D372F20
LinkKeyType=5
LinkKeyPINLength=0
Services=0x0000180100001000800000805F9B34FB;0x0000180000001000800000805F9B34FB;0x0000111200001000800000805F9B34FB;0x0000111F00001000800000805F9B34FB;0x0000110C00001000800000805F9B34FB;0x0000110A00001000800000805F9B34FB;0x0000110E00001000800000805F9B34FB;0x0000111600001000800000805F9B34FB;0x0000111500001000800000805F9B34FB;0x0000113200001000800000805F9B34FB;0x0000112F00001000800000805F9B34FB;0x0000110500001000800000805F9B34FB;


Comments are welcome.

Szymon Janc (4):
  android/bluetooth: Add initial support for permanent storage
  android/bluetooth: Add initial support for storing device info
  android/bluetooth: Add support for storing link keys
  android/bluetooth: Add support for restoring devices from storage

 android/Android.mk  |   3 +-
 android/bluetooth.c | 317 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 configure.ac        |   3 +
 3 files changed, 311 insertions(+), 12 deletions(-)

-- 
1.8.3.2


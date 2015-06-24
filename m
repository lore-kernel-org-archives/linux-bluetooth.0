Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  0/3] Add Support for GetTotalNumOfItems
Date: Wed, 24 Jun 2015 14:41:29 +0530
Message-id: <1435137092-19300-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support added for AVRCP GetTotalNumOfItems browsing command.

It is used to retrieve the number of items in a folder prior to
calling GetFolderItems to retrieve a listing of the contents of a
folder. The purpose of the command is to provide both scaling
information, and total item count for devices that may not be
able to store or display an entire folder content listing.

Bharat Panda (3):
  audio/avrcp: Add AVRCP GetTotalNumOfItems support
  audio/player: Add TotalNumberOfItems DBUS method
  tools: Add total-items command for GetTotalNumOfItems

 profiles/audio/avrcp.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.c  | 53 +++++++++++++++++++++++++++++++++
 profiles/audio/player.h  |  4 +++
 tools/bluetooth-player.c | 40 +++++++++++++++++++++++++
 4 files changed, 174 insertions(+)

-- 
1.9.1


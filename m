Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 0/2] PICS for GAP and HID
Date: Tue, 19 Nov 2013 15:36:13 +0100
Message-Id: <1384871775-8348-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Please note that some PICS marked as mandatory for LE were not
selected because of Android 4.4 not supporting some LE Roles.

v3: layout changed, added: mandatory/optional/conditional
	markings and descriptions, # - not implemented mark
v2: layout changed, each parameter description added
v1: initial documents with PICS targeting Android 4.4

Jakub Tyszkowski (2):
  android: Add PTS PICS for GAP
  android: Add PTS PICS for HID

 android/pics-gap.txt | 708 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pics-hid.txt | 285 +++++++++++++++++++++
 2 files changed, 993 insertions(+)
 create mode 100644 android/pics-gap.txt
 create mode 100644 android/pics-hid.txt

-- 
1.8.4.1


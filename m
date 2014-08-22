Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 0/2] Fix accepting not encrypted connections from keyboards
Date: Fri, 22 Aug 2014 11:02:58 +0200
Message-Id: <1408698180-23301-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2 changes:
	* checking subclass for the keyboard is done only once, when the SDP is
		done. Then the default, minimum security level is stored inside
		the device struct.
	* fixed typo

Jakub Tyszkowski (2):
  android/hid: Reject connections from unknown devices
  android/hid: Force encryption for keyboards

 android/hidhost.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

--
1.9.1


Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 0/2] Fix accepting not encrypted connections from keyboards
Date: Mon, 25 Aug 2014 14:54:17 +0200
Message-Id: <1408971259-21929-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3 changes:
	* extracted writing virtual unplug message to helper function
	* send virtual unplug only for controll channel

v2 changes:
	* checking subclass for the keyboard is done only once, when the SDP is
		done. Then the default, minimum security level is stored inside
		the device struct.
	* fixed typo

Jakub Tyszkowski (2):
  android/hid: Reject connections from unknown devices
  android/hid: Force encryption for keyboards

 android/hidhost.c | 59 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 12 deletions(-)

--
1.9.1


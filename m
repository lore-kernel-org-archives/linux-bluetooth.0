Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 0/6] android/tester: Cases for HIDHost security checks
Date: Thu,  4 Sep 2014 14:54:55 +0200
Message-Id: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds cases checking if Hidhost rejects connection from unknown HID Devices
and if proper security level is used for devices which requires encryption.

V2 changes:
	* removed btdev hacks for which proper fix was already pushed
	* smal function flow improvement for emu_remote_connect_hci_action()
	* slightly reordered patch order

Jakub Tyszkowski (6):
  android/tester: Allow HIDHost to use custom sdp response
  android/tester: Add action to verify encryption change
  android/tester: Add case verifying encryption on HIDHost
  android/tester: Fix HIDHost cases sending fixed tid sdp responses
  android/tester: Add support for rejected connections
  android/tester: Add Hidhost rejecting connection case

 android/tester-hidhost.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.c    |  64 +++++++++++++-
 android/tester-main.h    |   6 ++
 3 files changed, 287 insertions(+), 5 deletions(-)

--
1.9.1


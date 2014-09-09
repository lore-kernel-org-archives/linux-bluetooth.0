Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 0/7] android/tester: Cases for HIDHost security checks
Date: Tue,  9 Sep 2014 09:46:56 +0200
Message-Id: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds cases checking if Hidhost rejects connection from unknown HID Devices
and if proper security level is used for devices which requires encryption.

v3 changes:
	* improved remote side event verification by defining emulator callbacks
	* removed sdp call counter and use transaction id from the request frame

V2 changes:
	* removed btdev hacks for which proper fix was already pushed
	* smal function flow improvement for emu_remote_connect_hci_action()
	* slightly reordered patch order


Jakub Tyszkowski (7):
  android/tester: Allow HIDHost to use custom sdp response
  android/tester: Rename and expose callback verification function
  android/tester: Improve HIDHost data sending verification
  android/tester: Add encryption change verification mechanism
  android/tester: Add case verifying encryption on HIDHost
  android/tester: Fix HIDHost cases sending fixed tid sdp responses
  android/tester: Add Hidhost rejecting connection case

 android/tester-hidhost.c | 256 ++++++++++++++++++++++++++++++++++++++++++-----
 android/tester-main.c    |  83 +++++++++------
 android/tester-main.h    |   7 ++
 3 files changed, 294 insertions(+), 52 deletions(-)

--
1.9.1


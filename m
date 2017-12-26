Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ahmed Alsharif <ahmeds2000x@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ahmed Alsharif <ahmeds2000x@gmail.com>
Subject: [PATCH BlueZ 0/1] Fix bug in StartNotify()
Date: Tue, 26 Dec 2017 04:55:07 +0100
Message-Id: <20171226035508.30625-1-ahmeds2000x@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

if you call StartNotify() right after a device disappears, bluez returns an
org.bluez.Error.InProgress, even though the device isn't there at all.
A simple fix is checking the case of !gatt at the very beginning of function
characteristic_start_notify, since we can return the correct error immediately.
The patch returns an Error.NotConnected, which I think is the correct error in
this case, but it can be problematic since this function never returned that
before. Another possible error is Error.Failed with the message "Not connected"
since that's already expected from the function. This patch also cancels out
the cleaning of client at the bottom of the function, since we never create it
in the first place when a device is not available.

cheers.

Ahmed (1):
  Fix bug in characteristic_start_notify.

 src/gatt-client.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

-- 
2.11.0


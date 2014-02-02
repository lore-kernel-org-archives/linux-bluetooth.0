Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 00/11] Add bonding test cases
Date: Sun, 2 Feb 2014 12:16:30 +0100
Message-ID: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

A bit more explanation for last patch in this series:

We've encountered random timeouts for test cases which we found to be
because of missing "credit" in bthost which queued HCI command
indefinitely. The problem here was that previous HCI command in bthost
was sent from notification_handler thread in android-tester while reply
was handled in main thread. This caused race condition in bthost code
which is not thread-safe.

A quick fix for this would be to simply change order of operations in
send_command as follows:

if (bthost->ncmd) {
	bthost->ncmd--;
	send_packet(bthost, pkt_data, pkt_len);
} else {


So, first decrease number of "credits" and then send packet, so command
complete received in another thread cannot overwrite this value before
it's updated. But since this does not make code thread-safe and just
hides problem temporarily, we've decided to wrap all callbacks from
notification_thread to serialize their execution in main loop.


Andrzej Kaczmarek (1):
  android/tester: Make bt_callbacks thread-safe

Grzegorz Kolodziejczyk (10):
  android/tester: Coding style and syntax fix
  android/tester: Add create bond with PIN success test case
  android/tester: Add create bond with PIN fail test case
  android/tester: Add create bond with SSP sucess test case
  android/tester: Add create bond with SSP fail test case
  android/tester: Add create bond with no discovery test case
  android/tester: Add create bond with bad addr fail test case
  android/tester: Add cancel bond success test case
  android/tester: Add remove bond success test case
  android/tester: Add remove bond bad addr dev test case

 android/android-tester.c | 809 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 763 insertions(+), 46 deletions(-)

-- 
1.8.5.2


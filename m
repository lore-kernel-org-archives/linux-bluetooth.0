Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 0/3] auth & enrypt cleanup attempt
Date: Wed,  4 Jan 2012 16:06:21 +0100
Message-Id: <1325689584-15121-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

Luiz and I had a discussion on IRC and he suggested
that it might make sense to remove duplicated code around
auth & enrypt in hci_event.c. I found it hard to 
really simply the code there. There are a lot of side
conditions.

Maybe using hci_conn_auth() makes sense since it will
also ask to encrypt the connection. 

cheers,
daniel

Daniel Wagner (3):
  Bluetooth: Make hci_conn_auth/encrypt public functions
  Bluetooth: Use hci_conn_auth() instead of open coded version
  Bluetooth: Use hci_conn_encrypt() instead of open coded version

 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_conn.c         |    4 ++--
 net/bluetooth/hci_event.c        |   24 ++++--------------------
 3 files changed, 8 insertions(+), 22 deletions(-)

-- 
1.7.8.2.302.g17b4


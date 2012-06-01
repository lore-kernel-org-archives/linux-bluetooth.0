Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 0/5] Bluetooth: Refactoring hci_connect()
Date: Thu, 31 May 2012 22:57:51 -0300
Message-Id: <1338515876-7547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes from last version:
 - the functions are now named hci_connect_{acl,le,sco}. I didn't use
 hci_add_* because there is already a function hci_add_sco.

Cheers,

Vinicius Costa Gomes (5):
  Bluetooth: Refactor LE connection into its own function
  Bluetooth: Refactor ACL connection into its own function
  Bluetooth: Refactor SCO connection into its own function
  Bluetooth: Simplify a the connection type handling
  Bluetooth: Add type information to the hci_connect() debug statement

 net/bluetooth/hci_conn.c |   81 ++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 28 deletions(-)

--
1.7.10.3


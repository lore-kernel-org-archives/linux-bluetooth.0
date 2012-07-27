Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 0/7] Bluetooth: Refactoring hci_connect()
Date: Fri, 27 Jul 2012 19:32:53 -0300
Message-Id: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes from last version:
 * Changed the names of the functions that send HCI Commands to avoid confusion;
 * There was no need for exporting some functions related to connections;

Cheers,

Vinicius Costa Gomes (7):
  Bluetooth: Remove some functions from being exported
  Bluetooth: Rename LE and ACL connection functions
  Bluetooth: Refactor LE connection into its own function
  Bluetooth: Refactor ACL connection into its own function
  Bluetooth: Refactor SCO connection into its own function
  Bluetooth: Simplify a the connection type handling
  Bluetooth: Add type information to the hci_connect() debug statement

 include/net/bluetooth/hci_core.h |    2 -
 net/bluetooth/hci_conn.c         |   99 ++++++++++++++++++++++++--------------
 2 files changed, 62 insertions(+), 39 deletions(-)

--
1.7.10.4

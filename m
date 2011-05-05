Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>, <linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v1] Bluetooth: Double check sec req for pre 2.1 device
Date: Thu, 5 May 2011 16:16:16 +0200
Message-ID: <1304604978-17895-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've changed the function name since hci_conn_check_secure seems more
adequare then hci_conn_accept_secure.

/Waldek

Waldemar Rymarkiewicz (1):
  Bluetooth: Double check sec req for pre 2.1 device

 include/net/bluetooth/hci_core.h |    4 +++-
 net/bluetooth/hci_conn.c         |   17 +++++++++++++++++
 net/bluetooth/rfcomm/core.c      |    2 +-
 3 files changed, 21 insertions(+), 2 deletions(-)


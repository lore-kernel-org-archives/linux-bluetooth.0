Return-Path: <cyrus@holtmann.org>
From: Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Anurag Gupta <anurag.gupta@stericsson.com>,
	Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
Subject: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket 
Date: Tue, 24 Jul 2012 15:24:58 +0530
Message-ID: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches allows L2CAP socket user to reserve bandwidth in
percentage. Underlying socket reserves calculated number of
HCI credits for this L2CAP channel.

Manoj Kumar Sharma (2):
  Bluetooth: Usage of HCI channels in L2CAP
  Bluetooth: L2CAP socket option to reserve bandwidth

 include/net/bluetooth/bluetooth.h |    2 ++
 include/net/bluetooth/hci_core.h  |    2 ++
 include/net/bluetooth/l2cap.h     |    2 ++
 net/bluetooth/hci_conn.c          |   30 ++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c          |   27 ++++++++++++++++++++++++++-
 net/bluetooth/l2cap_core.c        |   12 +++++++++++-
 net/bluetooth/l2cap_sock.c        |   11 +++++++++++
 7 files changed, 84 insertions(+), 2 deletions(-)


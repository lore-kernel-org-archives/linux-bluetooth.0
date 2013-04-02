Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] Bluetooth: Add HCI init setup stage
Date: Tue,  2 Apr 2013 20:21:24 +0300
Message-Id: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is a resend of Marcel's patches that were sent in November, rebased
and fixed-up for bluetooth-next. They are a pre-requsite of some
follow-up work I'm doing to have a simple way of doing synchronous
single-command requests that will be needed by some HCI driver setup
routines.

Johan

----------------------------------------------------------------
Marcel Holtmann (3):
      Bluetooth: Add driver setup stage for early init
      Bluetooth: Convert BCM92035 support to driver setup callback
      Bluetooth: Remove driver init queue from core

 drivers/bluetooth/btusb.c        |   28 +++++++++++--------
 include/net/bluetooth/hci_core.h |    3 +-
 net/bluetooth/hci_core.c         |   56 ++++++++++++++------------------------
 3 files changed, 38 insertions(+), 49 deletions(-)


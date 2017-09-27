Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <59cb68f2.8403630a.d2376.bab9@mx.google.com>
Date: Wed, 27 Sep 2017 14:33:33 +0530
From: Shermin Joy <shermin.joy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/2] Use address resolution in the controller to enable device
 filtering when peers use RPA
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, host cannot not use whitelist if any of the peer devices
in the pending reports or connections uses RPA. If address
resolution is enabled in the controller, then the peer using RPA can
be added to the resolving list if its IRK is known. If all the peers 
using RPA can be added to the resolving list, then whitelist can be
enabled.

Shermin Joy (2):
  Add HCI commands to enable address resolution in controller
  Use whitelist along with resolving list to enable device filtering

 include/net/bluetooth/hci.h      |  25 +++++
 include/net/bluetooth/hci_core.h |   7 ++
 net/bluetooth/hci_core.c         |  26 +++++
 net/bluetooth/hci_event.c        | 107 ++++++++++++++++++++
 net/bluetooth/hci_request.c      | 213 +++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_request.h      |   4 +
 6 files changed, 371 insertions(+), 11 deletions(-)

-- 
1.9.1


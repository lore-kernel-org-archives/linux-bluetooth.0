Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 0/4] Extend gobex high level transfer API
Date: Wed, 21 Dec 2011 02:40:59 +0100
Message-Id: <1324431663-3800-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The purpose of this patch series is to propose an extension
to the current high level request transfer API.
The motivation for this is that currently profiles that require
parsing of non-body response headers in PUT operations
(such as BIP) can not use the high level transfer API.
The proposed solution is to make the function the API
uses to handle each response packet replaceable at the time
of transfer creation.
A custom handler can process incoming packets and (if desired)
pass them to the default packet handler in order
for it to proceed with the transfer.

Jakub Adamek (4):
  gobex: make transfer structure public and opaque
  gobex: make default response function public
  gobex: add response function parameter to API
  gobex: add functions to public transfer API

 client/transfer.c          |    6 +-
 gobex/gobex-transfer.c     |  122 ++++++++++++++++++++++++++-----------------
 gobex/gobex.h              |   16 +++++-
 unit/test-gobex-transfer.c |   20 ++++----
 4 files changed, 101 insertions(+), 63 deletions(-)

-- 
1.7.4.1


Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 0/8] Transfer cancelation
Date: Tue, 21 Feb 2012 14:57:04 +0100
Message-Id: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patch series proposes several fixes regarding the cancelation of transfers.

The goal is that the Cancel method defined in the transfer's D-Bus API should work for any registered transfer, be it in progress or queued. Currently none of them seem to work properly.

This second version is mostly a refacting of the previous proposal, according to the review from Luiz. The exceptions are patch 4/9 which has now been dropped, and patch 7/9, which now prevents from setting the callback twice.

Mikel Astiz (8):
  gobex: fix callback remove when canceling transfer
  client: fix obc_session_get_buffer
  client: fix cancel when no agent present
  client: process transfer queue only if none active
  client: terminate queued transfers properly
  client: expose obc_transfer_set_callback
  client: fix canceling queued transfers
  client: make sure callback does not match size

 client/session.c  |   45 ++++++++++++++++++++++++++++++++++++++-------
 client/transfer.c |   37 ++++++++++++++++++-------------------
 client/transfer.h |   10 ++++++----
 gobex/gobex.c     |    3 +++
 4 files changed, 65 insertions(+), 30 deletions(-)

-- 
1.7.6.5


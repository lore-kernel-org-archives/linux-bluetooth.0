Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 0/9] Transfer cancelation
Date: Tue, 21 Feb 2012 09:46:14 +0100
Message-Id: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patch series proposes several fixes regarding the cancelation of transfers.

The goal is that the Cancel method defined in the transfer's D-Bus API should work for any registered transfer, be it in progress or queued. Currently none of them seem to work properly.

Mikel Astiz (9):
  gobex: fix callback remove when canceling transfer
  client: fix obc_session_get_buffer
  client: deny cancel when no agent present
  client: remove unnecessary code
  client: process transfer queue only if none active
  client: terminate queued transfers properly
  client: expose obc_transfer_set_callback
  client: allow cancelling queued transfers
  client: make sure callback does not match size

 client/session.c  |   58 +++++++++++++++++++++++++++++++++++-----------------
 client/transfer.c |   32 ++++++++++++----------------
 client/transfer.h |   10 +++++---
 gobex/gobex.c     |    3 ++
 4 files changed, 62 insertions(+), 41 deletions(-)

-- 
1.7.6.5


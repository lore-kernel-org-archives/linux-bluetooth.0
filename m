Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 0/2] Transfer cancelation
Date: Mon, 27 Feb 2012 10:54:34 +0100
Message-Id: <1330336476-13454-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patch series proposes several fixes regarding the cancelation of transfers.

This third version includes some minor refactoring of patches v2 5/8 and 7/8, following the reviews from Johan.

Mikel Astiz (2):
  client: terminate queued transfers properly
  client: fix canceling queued transfers

 client/session.c  |   30 ++++++++++++++++++++++++++----
 client/transfer.c |   12 ++++++++----
 2 files changed, 34 insertions(+), 8 deletions(-)

-- 
1.7.6.5


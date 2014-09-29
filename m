Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/6] shared/hfp: Refactor of hfp code
Date: Mon, 29 Sep 2014 15:47:11 +0200
Message-Id: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set of patches prepares us to implement hfp hf role.
Common part has been identified and some common helpers
are created.

Lukasz Rymanowski (6):
  shared/hfp: Extract struct hfp out of struct hfp_gw
  shared/hfp: Extract creation hfp to separate function
  shared/hfp: Add set_debug helper which takes struct hfp as parameter
  shared/hfp: Extract hfp_cleanup function
  shared/hfp: Add helper to set disconnect handler
  shared/hfp: Wakeup writer and similar can use struct hfp now

 src/shared/hfp.c | 221 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 128 insertions(+), 93 deletions(-)

-- 
1.8.4


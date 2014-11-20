Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/8] shared/hfp: Improvements and fixes to HFP AG parser
Date: Thu, 20 Nov 2014 16:55:07 +0100
Message-Id: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set brings couple of fixes on parsing AT commands.
This improves robustness.

Also some minor fixes has beed done here

Lukasz Rymanowski (8):
  shared/hfp: Trivial, fix comments style
  shared/hfp: Fix setting result pending flag
  shared/hfp: Improve handling AT command
  unit/test-hfp: Add test for reading \rAT+X\r
  shared/hfp: Refactor call_prefix_handler
  shared/hfp: Remove not used assignment
  shared/hfp: Improve handling AT commands
  unit/test-hfp: Fix parsing empty string test

 src/shared/hfp.c | 123 +++++++++++++++++++++++++++++++++++--------------------
 unit/test-hfp.c  |  41 ++++++++++++++++++-
 2 files changed, 117 insertions(+), 47 deletions(-)

-- 
1.8.4


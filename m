Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/9] HFP AT parser skeleton
Date: Tue, 25 Feb 2014 10:23:38 +0100
Message-Id: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set contains skeleton of hfp_at parser and some basic unit tests.
Unit tests check proper commands handling for now. If API will be acceptable
more test cases for fetching values will be added.

Comments are welcome 

Marcin Kraglak (9):
  shared: Add skeleton of hfp_at parser
  unit: Add hfp_at tester
  shared/hfp_at: Add skeleton of hfp_at_process_data
  unit/test_hfp_at: Add test cases for processing basic commands
  shared/hfp_at: Add function for getting number
  shared/hfp_at: Add function to open container
  shared/hfp_at: Add function to close container
  shared/hfp_at: Add function to get string
  shared/hfp_at: Add function to get unquoted string

 .gitignore          |   1 +
 Makefile.am         |   8 +-
 src/shared/hfp_at.c | 350 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp_at.h |  54 ++++++++
 unit/test-hfp-at.c  | 347 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 759 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/hfp_at.c
 create mode 100644 src/shared/hfp_at.h
 create mode 100644 unit/test-hfp-at.c

-- 
1.8.5.3


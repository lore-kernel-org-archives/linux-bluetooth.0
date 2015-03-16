Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 0/6] unit/test-hog: Introduce test-hog and add few TC
Date: Mon, 16 Mar 2015 16:38:51 +0100
Message-Id: <1426520337-21545-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch contains previously sent tests for unit/test-hog rebased
and cleaned up.

Mariusz Skamra (6):
  unit/test-hog: Add TC/HGRF/RH/BV-01-I test
  unit/test-hog: Add TC/HGRF/RH/BV-08-I test
  unit/test-hog: Add TC/HGRF/RH/BV-09-I test
  unit/test-hog: Add TC/HGRF/RH/BV-06-I test
  unit/test-hog: Add TC/HGRF/RH/BV-02-I test
  unit/test-hog: Add TC/HGCF/RH/BV-01-I test

 Makefile.am     |  15 ++
 unit/test-hog.c | 441 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 456 insertions(+)
 create mode 100644 unit/test-hog.c

-- 
1.9.1


Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/8] HFP_GW parser
Date: Thu, 27 Feb 2014 10:39:58 +0100
Message-Id: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2:
 - parser moved to src/shared/hfp
 - dynamic register/unregister prefix handlers
 - minor fixes pointed by Marcel

Marcin Kraglak (8):
  shared/hfp: Fix parsing line with few commands
  shared/hfp: Add prefix handlers functionality
  shared/hfp: Add initial implementiation of processing commands
  shared/hfp: Add implementation of precessing commands
  shared/hfp: Add get_number implementation
  shared/hfp: Add open/close container function
  shared/hfp: Add function to get string
  shared/hfp: Add function to get unquoted string

 Makefile.tools   |   1 +
 src/shared/hfp.c | 363 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/hfp.h |  25 ++++
 3 files changed, 380 insertions(+), 9 deletions(-)

-- 
1.8.3.1


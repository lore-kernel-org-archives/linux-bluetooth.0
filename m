Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH obexd 0/4] Fix memory leak, remove unused struct etc
Date: Thu, 12 Apr 2012 20:33:11 +0530
Message-id: <1334243001-17016-21-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series of patches fixes the following issues in obexd.

Syam Sidhardhan (4):
  client: Fix memory leak during session connect
  src: Use goto for avoiding code duplication
  src: Remove headers declared but not defined
  client: Remove unused struct session_callback

 client/session.c |   10 ++++------
 src/manager.c    |    4 ++--
 src/obex.h       |    4 ----
 3 files changed, 6 insertions(+), 12 deletions(-)

-- 
1.7.4.1


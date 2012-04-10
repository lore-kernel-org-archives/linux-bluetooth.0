Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 00/11] client: transfer implementation improvements
Date: Tue, 10 Apr 2012 15:38:21 +0200
Message-Id: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This second version of the series integrates the review from Luiz, affecting patches from v0 01/11 to 05/11. These changes mainly consist of minor corrections including early return statements and function renaming.

>From previous cover letter:

This patch series includes internal rewrites particularly regarding transfer.c. It includes some api changes, minor fixes and internal refactoring, none of which should affect the D-Bus api.

These changes are convenient by themselves, but they are also motivated by the D-Bus changes to be discussed soon. For example, patch 07/11 separates memory-based transfers from the filesystem-based ones, which will make it easier to decide if memory-based transfers should be removed (as it has been proposed).

Another example is patch 08/11, which will be get simplified once the D-Bus agent is removed.

Mikel Astiz (11):
  client: minor buffer access api changes
  client: remove unused field
  client: refactor transfer callback use
  client: fix progress report before field update
  client: transfer api merges put and get
  client: transfers take gobex when starting
  client: separate memory transfers in transfer api
  client: open transfer file during creation
  client: delete file in case of error
  client: unify transfer implementation
  client: double transfer buf size in each realloc

 client/pbap.c     |    2 +-
 client/session.c  |  146 +++++-------
 client/session.h  |    4 +-
 client/transfer.c |  683 ++++++++++++++++++++++++++++++++---------------------
 client/transfer.h |   48 +++--
 5 files changed, 508 insertions(+), 375 deletions(-)

-- 
1.7.7.6


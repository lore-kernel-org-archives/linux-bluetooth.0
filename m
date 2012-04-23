Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [RFC BlueZ 0/1] core: Fix adapter mode inconsistency
Date: Mon, 23 Apr 2012 10:34:34 +0200
Message-Id: <1335170075-12363-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

There seems to be a bug with the management interface plugin that enters an inconsistent state if the adapter is discoverable during startup.

I'm not really sure if this is a proper solution but it does fix the problem.

Cheers,
Mikel

Mikel Astiz (1):
  core: Fix adapter mode inconsistency

 src/adapter.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

-- 
1.7.7.6


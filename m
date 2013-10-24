Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/2] Add basic scripting to haltest
Date: Thu, 24 Oct 2013 14:46:45 +0200
Message-ID: <1382618807-14605-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patcheset adds command 'source' to interpret scripts
and processing of .haltestrc to execute some commands automatically.

Jerzy Kasenberg (2):
  android/client: Add source command to haltest
  android/client: Add processing of .haltestrc

 android/client/haltest.c |   55 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

-- 
1.7.9.5


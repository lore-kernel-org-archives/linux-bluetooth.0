Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/5] Fixes and refactor avrcp
Date: Thu, 15 Sep 2011 01:21:32 -0300
Message-Id: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here are some fixes for avrcp. 0001 fixes a bug due to the recent code move,
0002 fixes the response of one command and the other 3 were already sent
previously.


David Stockwell (3):
  avrcp: use LAST element on media_info_id enum
  avrcp: fix handling of metadata item 0x7
  avrcp: get/set three-byte company-id

Lucas De Marchi (2):
  avrcp: fix missing error code
  avrcp: fix overwrite of number of attributes

 audio/avrcp.c |   72 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 42 insertions(+), 30 deletions(-)

-- 
1.7.6.1

